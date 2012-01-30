Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327953929.2400.80.camel@novo.hadess.net>
References: <1327448862-21964-1-git-send-email-scott@netsplit.com>
	<1327952977.1955.160.camel@aeonflux>
	<1327953929.2400.80.camel@novo.hadess.net>
Date: Mon, 30 Jan 2012 13:42:21 -0800
Message-ID: <CA+bD78jkORzLP-M+bGqFMkp9vHmBXW+LgLnFGhLczn92Rk2XXA@mail.gmail.com>
Subject: Re: [RFC PATCHv2] autopair: add autopair plugin
From: Scott James Remnant <scott@netsplit.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	keybuk@chromium.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 30, 2012 at 12:05 PM, Bastien Nocera <hadess@hadess.net> wrote:

> As for the patch itself, we will still need from the wizard to check for
> those NULL hints (CreateDevice vs. CreatePairedDevice), or presentation
> hints (ICADE and keyboard for example), so the file itself needs to be
> made available to the front-ends (and its location exported).
>
Actually after a few minutes thought, I wondered whether we could
handle this by exporting a D-Bus interface from the autopair plugin
(like dbus-oob) so you could simply query whether or not a device has
presentation hints/needs encryption hints.

> For the NULL hints, I would like to see something like
> CreatePairedDevice() but that would get whether to pair or not from the
> database.
>
This is another good solution, a plugin callback from here could
verify whether or not to pair, etc.

> The PIN length hint is also ignored in the current code:
> + =A0 =A0 =A0 <device type=3D"audio" oui=3D"00:1A:80:" name=3D"CMT-DH5BT"=
 pin=3D"max:4"/>
>
Because that's a UI restriction, no?

I didn't put any PIN-generation code here, because I'm not entirely
sure what the UI for "generate random PIN' should look like or which
spec you're following.

Scott
--=20
Have you ever, ever felt like this?
Had strange things happen? =A0Are you going round the twist?
