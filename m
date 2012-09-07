Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Sep 2012 10:00:40 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Subject: Re: [PATCH 1/6] Bluetooth: Fix deadlock when closing socket
In-Reply-To: <20120907140813.GC22944@aemeltch-MOBL1>
Message-ID: <alpine.DEB.2.02.1209070949580.3761@mathewm-linux>
References: <1346933147-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <alpine.DEB.2.02.1209060946190.22884@mathewm-linux> <1346962251.21200.119.camel@aeonflux> <20120907140813.GC22944@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Andrei -

On Fri, 7 Sep 2012, Andrei Emeltchenko wrote:

> Hi Marcel,
>
> On Thu, Sep 06, 2012 at 01:10:51PM -0700, Marcel Holtmann wrote:
>> Hi Mat,
>>
>>>> If we have unacked frames when closing bluetooth socket we deadlock
>>>> since conn->chan_lock, chan->lock and socket lock are taken. Remove
>>>> __l2cap_wait_ack completely.
>>>>
>>>> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>>>
>>> I don't think you want to remove this code completely, at least not
>>> without giving some thought to the problem it is solving.
>>>
>>> The problem is that programs may have an open socket which they send
>>> some data on, then immediately close.  There is no feedback when data
>>> is actually sent over the air, so the socket may end up getting torn
>>> down while there is still data in the HCI tx buffer or some data was
>>> lost and needs to be retransmitted.  Waiting for an acknowledgement
>>> confirms that the application's sent data made it to the remote
>>> device.
>>>
>>> Without this code, it's difficult to use l2test on a number of
>>> qualification tests.  Profiles or applications using ERTM may depend
>>> on the "wait for ack before closing" behavior in order to have a clean
>>> disconnect.
>>
>> isn't that what we have SO_LINGER for?
>
> Looking at the code I suspect that SO_LINGER is not working. Maybe we need
> to merge linger code and wait_ack stuff.

It does look like a bug that the "wait_ack" behavior happens even 
without SO_LINGER.

In order to do SO_LINGER right, it would be better to check chan->tx_q 
instead of chan->unacked_frames to makes sure all data is sent and 
acked.  chan->unacked_frames only tells you how many sent frames are 
unacked and does not take in to account queued data that hasn't been 
sent yet.

--
Mat Martineau

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

