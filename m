Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1335976922-19456-5-git-send-email-mathewm@codeaurora.org>
References: <1335976922-19456-1-git-send-email-mathewm@codeaurora.org>
	<1335976922-19456-5-git-send-email-mathewm@codeaurora.org>
Date: Fri, 4 May 2012 16:12:25 -0300
Message-ID: <CAA37ikaAHTN_M7kPgqwkyy3+2jUa2WPY8kUFBqfcxvNCNwx1Dg@mail.gmail.com>
Subject: Re: [PATCH 4/4] Bluetooth: Refactor L2CAP ERTM and streaming transmit segmentation
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org, marcel@holtmann.org,
	pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Wed, May 2, 2012 at 1:42 PM, Mat Martineau <mathewm@codeaurora.org> wrot=
e:
> Use more common code for ERTM and streaming mode segmentation and
> transmission, and begin using skb control block data for delaying
> extended or enhanced header generation until just before the packet is
> transmitted. =A0This code is also better suited for resegmentation,
> which is needed when L2CAP links are reconfigured after an AMP channel
> move.
>
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
> =A0include/net/bluetooth/l2cap.h | =A0 =A01 +
> =A0net/bluetooth/l2cap_core.c =A0 =A0| =A0154 ++++++++++++++++++++++++---=
--------------
> =A02 files changed, 92 insertions(+), 63 deletions(-)

This patch also looks good to me, but it'd be good if Andrei or
someone else could check as well.

Regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
