Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Aug 2009 16:44:21 +0200
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez-4.49 does not build for me.
Message-ID: <20090824164421.407bcdf2@stoetzler>
In-Reply-To: <2d5a2c100908240652l179a6ad3mc6195db710ae069a@mail.gmail.com>
References: <20090824151514.6eb4f1f6@stoetzler>
	<2d5a2c100908240652l179a6ad3mc6195db710ae069a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 24 Aug 2009 10:52:18 -0300
Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:

> Hi,
> 
> On Mon, Aug 24, 2009 at 10:15 AM, Stefan
> Seyfried<stefan.seyfried@googlemail.com> wrote:
> > In file included from lib/sdp.c:50:
> > lib/sdp_lib.h:31:33: error: bluetooth/bluetooth.h: No such file or
> > directory lib/sdp_lib.h:32:27: error: bluetooth/hci.h: No such file
> > or directory make[1]: *** [lib/sdp.lo] Error 1
> > make: *** [all] Error 2
> >
> 
> Strange I just compiled it using ./boostrap-configure 

You are cheating! ;) bootstrap-configure is not in the tarball. With a
git checkout, you are also missing the missing files ;)

Have fun,

	seife
-- 
Stefan Seyfried
R&D Preload Department             |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
