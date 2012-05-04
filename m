Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1335976922-19456-2-git-send-email-mathewm@codeaurora.org>
References: <1335976922-19456-1-git-send-email-mathewm@codeaurora.org>
	<1335976922-19456-2-git-send-email-mathewm@codeaurora.org>
Date: Fri, 4 May 2012 15:55:16 -0300
Message-ID: <CAA37ika9JvSW1WCDtcnuQnFu3DppGsDx6BqbowiJ1kyz8LBJBQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] Bluetooth: Fix a redundant and problematic incoming
 MTU check
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org, marcel@holtmann.org,
	pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Wed, May 2, 2012 at 1:41 PM, Mat Martineau <mathewm@codeaurora.org> wrot=
e:
> The L2CAP MTU for incoming data is verified differently depending on
> the L2CAP mode, so the check is best performed in a mode-specific
> context. =A0Checking the incoming MTU before HCI fragment reassembly is
> a layer violation and assumes all bytes after the standard L2CAP
> header are L2CAP data.
>
> This approach causes issues with unsegmented ERTM or streaming mode
> frames, where there are additional enhanced or extended headers before
> the data payload and possible FCS bytes after the data payload. =A0A
> valid frame could be as many as 10 bytes larger than the MTU.
>
> Removing this code is the best fix, because the MTU is checked later
> on for all L2CAP data frames (connectionless, basic, ERTM, and
> streaming). =A0This also gets rid of outdated locking (socket instead of
> l2cap_chan) and an extra lookup of the channel ID.
>
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
> =A0net/bluetooth/l2cap_core.c | =A0 20 --------------------
> =A01 file changed, 20 deletions(-)

This looks good and correct to me.

Regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
