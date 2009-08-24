Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez-4.49 does not build for me.
From: Marcel Holtmann <marcel@holtmann.org>
To: Valmantas =?UTF-8?Q?Palik=C5=A1a?= <walmis@gmail.com>
Cc: BlueZ devel list <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1251124029.19970.1.camel@walmis-desktop>
References: <20090824151514.6eb4f1f6@stoetzler>
	 <2d5a2c100908240652l179a6ad3mc6195db710ae069a@mail.gmail.com>
	 <1251124029.19970.1.camel@walmis-desktop>
Content-Type: text/plain
Date: Mon, 24 Aug 2009 13:06:29 -0700
Message-Id: <1251144389.2950.65.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Valmantas,

> Here's my errors:
> 
> make[1]: *** No rule to make target `tools/bccmd.8', needed by `all-am'.
> Stop.
> make: *** [all] Error 2
> 
> same with hid2hci.

there were some more. All of them should be fixed now. The automake
dist_man_MANS target doesn't work with conditionals.

Regards

Marcel


