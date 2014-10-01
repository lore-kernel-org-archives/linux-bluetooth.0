Return-Path: <cyrus@holtmann.org>
Message-ID: <542C09D5.9050405@hurleysoftware.com>
Date: Wed, 01 Oct 2014 10:04:05 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Fix locking issue when creating l2cap connection
References: <1412158707-26604-1-git-send-email-jukka.rissanen@linux.intel.com> <20141001120944.GA25046@t440s.lan>
In-Reply-To: <20141001120944.GA25046@t440s.lan>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 10/01/2014 08:09 AM, Johan Hedberg wrote:
> Hi Jukka,
> 
> On Wed, Oct 01, 2014, Jukka Rissanen wrote:
>> l2cap_chan_connect() was taking locks in different order than
>> other connection functions like l2cap_connect(). This makes
>> it possible to have a deadlock when conn->chan_lock (used to
>> protect the channel list) and chan->lock (used to protect
>> individual channel) are used in different order in different
>> kernel threads.
>>
>> The issue was easily seen when creating a 6LoWPAN connection.
>>
>> Excerpt from the lockdep report:
>>
>> -> #1 (&conn->chan_lock){+.+...}:
>>        [<c109324d>] lock_acquire+0x9d/0x140
>>        [<c188459c>] mutex_lock_nested+0x6c/0x420
>>        [<d0aab48e>] l2cap_chan_add+0x1e/0x40 [bluetooth]
>>        [<d0aac618>] l2cap_chan_connect+0x348/0x8f0 [bluetooth]
>>        [<d0cc9a91>] lowpan_control_write+0x221/0x2d0 [bluetooth_6lowpan]
>> -> #0 (&chan->lock){+.+.+.}:
>>        [<c10928d8>] __lock_acquire+0x1a18/0x1d20
>>        [<c109324d>] lock_acquire+0x9d/0x140
>>        [<c188459c>] mutex_lock_nested+0x6c/0x420
>>        [<d0ab05fd>] l2cap_connect_cfm+0x1dd/0x3f0 [bluetooth]
>>        [<d0a909c4>] hci_le_meta_evt+0x11a4/0x1260 [bluetooth]
>>        [<d0a910eb>] hci_event_packet+0x3ab/0x3120 [bluetooth]
>>        [<d0a7cb08>] hci_rx_work+0x208/0x4a0 [bluetooth]
>>
>>        CPU0                    CPU1
>>        ----                    ----
>>   lock(&conn->chan_lock);
>>                                lock(&chan->lock);
>>                                lock(&conn->chan_lock);
>>   lock(&chan->lock);
>>
>> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
>> ---
>> Hi,
>>
>> this is version 2 of the fix for the locking issue I was seeing
>> when 6lowpan connection was created.
>> The patch is now much simpler thanks to Johan's help.
> <snip>
>> +	l2cap_chan_unlock(chan);
>> +	mutex_lock(&conn->chan_lock);
>> +	l2cap_chan_lock(chan);
> 
> As Szymon pointed out on IRC this version is also problematic in that
> the check for chan->state is not inside the same atomic section as where
> we change to a new state.
> 
> After some further analysis it seems like this lockdep warning is a
> false-positive because of the way that all other places besides
> l2cap_chan_connect() treat the locks. Most of these depend on the chan
> being available in conn->chan_l:
> 
> 	lock(conn->chan_lock);
> 	for_each(chan, conn->chan_l) {
> 		lock(chan->lock);
> 		...
> 		unlock(chan->lock);
> 	}
> 	unlock(conn->chan_lock);
> 
> Because the l2cap_chan_connect() code (or l2cap_chan_add actually) takes
> conn->chan_lock before attempting to add to conn->chan_l it makes the
> loop described above unable to reach the chan and therefore the deadlock
> is not possible.
> 
> There are at three exceptions I could find that don't follow exactly the
> above pattern (by depending on conn->chan_l content), and should
> therefore be considered separately:
> 
> 	l2cap_connect()
> 	l2cap_le_connect_req()
> 	l2cap_chan_timeout()
> 
> All three of these require the channel to be in a state that will make
> l2cap_chan_connect() return early failure before getting anywhere close
> to the risky l2cap_chan_add() call, so I would conclude that these are
> also safe from the deadlock.

Ok, but a lockdep report disables lockdep, which means that

1. There could be other lockdep errors after this one
2. Lockdep gets disabled for all subsystems so this can be masking
problems in other places.

So still worth fixing this lock inversion.

Why does chan->lock need to be held when adding the channel to the
conn->chan_l if the chan is not retrievable until it's found on the
list?

Regards,
Peter Hurley

