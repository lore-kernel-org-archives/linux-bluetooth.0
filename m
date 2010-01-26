Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4B5EA94B.1000204@gmx.de>
References: <4B5C554D.4030702@gmx.de> <1264343316.11653.0.camel@violet>
	 <4B5C6062.4030705@gmx.de> <1264346020.11653.1.camel@violet>
	 <2d5a2c101001241309u6e292a12hfc5c67011d6b77ba@mail.gmail.com>
	 <4B5EA94B.1000204@gmx.de>
Date: Tue, 26 Jan 2010 12:36:12 +0200
Message-ID: <2d5a2c101001260236v506b53dcl9d948722f7926329@mail.gmail.com>
Subject: Re: [PATCH 1/1] add configurable support for bridge forward delay
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Thomas Egerer <hakke_007@gmx.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomas,

On Tue, Jan 26, 2010 at 10:35 AM, Thomas Egerer <hakke_007@gmx.de> wrote:
> Luiz,
> let me tell you why I'd like to have an extra config variable. Let's
> imagine an admin who want to add the upcoming bnep interfaces to an
> _already_ existing bridge (for that matter a test whether the given
> interface name already exists would be nice, too) plus he knows about
> the infrastructure behind the bridge and decides to set a different
> forward delay. He could, of course reset the delay, once the bridge is
> up. But ideally he would specify the setting in the network.conf. Hence
> the extra config variable (which btw. were actually two variables by the
> time I started writing the patch).

In lets say a pure network sense you are probably right, but what Im
arging about is that the PAN spec doesn't mentioned anything about
this, so in the spec sense once you accept the connection the
interface _is_ already fully functional. So either we always set the
delay to 0 or we have to wait until the interface is ready to accept
the connection, although the second alternative is doable it happens
to be after the connection is accepted that the network interface is
created and there is no way to inform the other part that there is an
arbitrary delay before the interface become functional again.


--=20
Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o
