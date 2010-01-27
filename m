Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1264619569-12448-1-git-send-email-padovan@profusion.mobi>
References: <fbf08281001201158q23d13d9bj930a66271c527b43@mail.gmail.com>
	 <1264619569-12448-1-git-send-email-padovan@profusion.mobi>
Date: Wed, 27 Jan 2010 17:17:04 -0200
Message-ID: <fbf08281001271117u2e3b645bjc3321881ae63051f@mail.gmail.com>
Subject: Re: HFP support into BlueZ and oFono
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: ofono@ofono.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jan 27, 2010 at 5:12 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi All,
>
> New patches for the HFP support. The BlueZ part was updated with the Johan's comments and the oFono patch supports load/remove of bluetooth devices dynamically.
> We still have bug: the link RFCOMM on the AG side is closed only when bluetoothd shuts down. Any idea on that?
>
> Comments are welcome.

I forgot to mention, but the first two patches is for BlueZ the other
one is for oFono.

>
> --
> Gustavo F. Padovan
> ProFUSION embedded systems - http://profusion.mobi
>
>



-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
