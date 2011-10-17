Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1110141410410.9993@mathewm-linux>
References: <1318543247-27130-1-git-send-email-mathewm@codeaurora.org>
	<1318543247-27130-2-git-send-email-mathewm@codeaurora.org>
	<1318549090.15441.49.camel@aeonflux>
	<alpine.DEB.2.02.1110141410410.9993@mathewm-linux>
Date: Mon, 17 Oct 2011 13:25:13 +0300
Message-ID: <CABBYNZKtyro_ep=X1Baq51oUXueqMDVEr_0aZw54+c48SvtWcw@mail.gmail.com>
Subject: Re: [PATCH 1/9] Bluetooth: Add BT_AMP_POLICY socket option
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	padovan@profusion.mobi, pkrystad@codeaurora.org, andrei.emeltchenko@intel.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Sat, Oct 15, 2011 at 1:38 AM, Mat Martineau <mathewm@codeaurora.org> wro=
te:
>>
>> Not sure if applications actually do care, but for OBEX it might be
>> interesting to know if you are on an AMP controller right now or not.
>
> Yes, that would be a nice feature. =A0OBEX seems to work well even withou=
t it,
> though. =A0The OBEX connection is made over BREDR, and the socket option =
is
> changed after the OBEX connection is made but before any gets or puts. =
=A0What
> you see in hcidump is that the move starts before the first get or put go=
es
> out over BREDR - those OBEX packets sit in the ERTM tx queue while the
> channel move happens. =A0When the move completes, the transfer immediatly
> proceeds on the AMP controller.

I guess the is implementation dependent, for obexd we might want to
check if the transfer will take a considerable amount of time to
decide whether or not to use AMP, in some case it might not worth to
switch because it will take more time than transferring over BDEDR.

--=20
Luiz Augusto von Dentz
