Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1335976922-19456-4-git-send-email-mathewm@codeaurora.org>
References: <1335976922-19456-1-git-send-email-mathewm@codeaurora.org>
	<1335976922-19456-4-git-send-email-mathewm@codeaurora.org>
Date: Fri, 4 May 2012 16:06:27 -0300
Message-ID: <CAA37ikaut-vNWLS1d9vGUWV=rLMH6Ud72j8Mwn3+u18-a_Bf-w@mail.gmail.com>
Subject: Re: [PATCH 3/4] Bluetooth: Lock the L2CAP channel when sending
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org, marcel@holtmann.org,
	pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Wed, May 2, 2012 at 1:42 PM, Mat Martineau <mathewm@codeaurora.org> wrot=
e:
> The ERTM and streaming mode transmit queue must only be accessed while
> the L2CAP channel lock is held. =A0Locking the channel before calling
> l2cap_chan_send ensures that multiple threads cannot simultaneously
> manipulate the queue when sending and receiving concurrently.
>
> L2CAP channel locking had previously moved to the l2cap_chan struct
> instead of the associated socket, so some of the old socket locking
> can also be removed in this patch.
>
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
> =A0include/net/bluetooth/bluetooth.h | =A0 =A02 --
> =A0net/bluetooth/l2cap_sock.c =A0 =A0 =A0 =A0| =A0 15 ++++++++-------
> =A02 files changed, 8 insertions(+), 9 deletions(-)

Looks good. I'm just wondering if we still have issues with chan lock
versus sock lock elsewhere. Maybe you've done some auditing of this?

Regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
