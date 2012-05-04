Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1335976922-19456-3-git-send-email-mathewm@codeaurora.org>
References: <1335976922-19456-1-git-send-email-mathewm@codeaurora.org>
	<1335976922-19456-3-git-send-email-mathewm@codeaurora.org>
Date: Fri, 4 May 2012 15:58:31 -0300
Message-ID: <CAA37ikY3LZnwPdZ7TmfA-K_HAR5xR5Mj41kQ_O5ioiwSfu1nEA@mail.gmail.com>
Subject: Re: [PATCH 2/4] Bluetooth: Restore locking semantics when looking up
 L2CAP channels
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	marcel@holtmann.org, pkrystad@codeaurora.org,
	andrei.emeltchenko.news@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Wed, May 2, 2012 at 1:42 PM, Mat Martineau <mathewm@codeaurora.org> wrote:
> As the comment for l2cap_get_chan_by_scid indicated, the function used
> to return a locked socket.  The lock for the socket was acquired while
> the channel list was also locked.
>
> When locking was moved over to the l2cap_chan structure, the channel
> lock was no longer acquired with the channel list still locked.  This
> made it possible for the l2cap_chan to be deleted after
> conn->chan_lock was released but before l2cap_chan_lock was called.
> Making the call to l2cap_chan_lock before releasing conn->chan_lock
> makes it impossible for the l2cap_chan to be deleted at the wrong
> time.
>
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c |   10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Looks good. I couldn't see this problem when Andrei was adding
l2cap_chan_lock and doing other changes, thanks for fixing it.

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
