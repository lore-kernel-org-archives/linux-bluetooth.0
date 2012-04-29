Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Apr 2012 17:25:46 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Subject: Re: [RFCv2 5/8] Bluetooth: Restore locking semantics when looking up
 L2CAP channels
Message-ID: <20120429202546.GD2917@joana>
References: <1335570655-30878-1-git-send-email-mathewm@codeaurora.org>
 <1335570655-30878-6-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335570655-30878-6-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2012-04-27 16:50:52 -0700]:

> As the comment for l2cap_get_chan_by_scid indicated, the function used
> to return a locked socket.  The lock for the socket was acquired while
> the channel list was also locked.
> 
> When locking was moved over to the l2cap_chan structure, the channel
> lock was no longer acquired with the channel list still locked.  This
> made it possible for the l2cap_chan to be deleted after
> conn->chan_lock was released but before l2cap_chan_lock was called.
> Making the call to l2cap_chan_lock before releasing conn->chan_lock
> makes it impossible for the l2cap_chan to be deleted at the wrong
> time.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c |   10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Applied to bluetooth-next. Thanks.

	Gustavo
