Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Apr 2012 08:02:44 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Gustavo Padovan <gustavo@padovan.org>
cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
    pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Subject: Re: [RFCv2 5/8] Bluetooth: Restore locking semantics when looking
 up L2CAP channels
In-Reply-To: <20120429202546.GD2917@joana>
Message-ID: <alpine.DEB.2.02.1204300800280.2723@mathewm-linux>
References: <1335570655-30878-1-git-send-email-mathewm@codeaurora.org> <1335570655-30878-6-git-send-email-mathewm@codeaurora.org> <20120429202546.GD2917@joana>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


Gustavo -

On Sun, 29 Apr 2012, Gustavo Padovan wrote:

> Hi Mat,
>
> * Mat Martineau <mathewm@codeaurora.org> [2012-04-27 16:50:52 -0700]:
>
>> As the comment for l2cap_get_chan_by_scid indicated, the function used
>> to return a locked socket.  The lock for the socket was acquired while
>> the channel list was also locked.
>>
>> When locking was moved over to the l2cap_chan structure, the channel
>> lock was no longer acquired with the channel list still locked.  This
>> made it possible for the l2cap_chan to be deleted after
>> conn->chan_lock was released but before l2cap_chan_lock was called.
>> Making the call to l2cap_chan_lock before releasing conn->chan_lock
>> makes it impossible for the l2cap_chan to be deleted at the wrong
>> time.
>>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  net/bluetooth/l2cap_core.c |   10 +++-------
>>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> Applied to bluetooth-next. Thanks.

Please revert this for now.  This patch causes a locking imbalance if 
patch 4/8 is not merged first, and is the main reason I requested that 
*none* of these patches be merged yet in my cover letter message.

Thanks,

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
