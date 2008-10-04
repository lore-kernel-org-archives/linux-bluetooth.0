Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez-4.9 + 2.6.27-rc8 + SCO headset -> bluetoothd: connect:
	Operation not permitted
From: Marcel Holtmann <marcel@holtmann.org>
To: Stuart Pook <kernel6org@pook.es>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <48E752A7.70600@pook.es>
References: <48E29416.3030402@pook.es> <48E2B59A.7020600@dtsp.co.nz>
	 <48E3B3BF.6070205@pook.es>
	 <2d5a2c100810032047s47bec394w828852079d64e591@mail.gmail.com>
	 <48E752A7.70600@pook.es>
Content-Type: text/plain
Date: Sat, 04 Oct 2008 13:51:08 +0200
Message-Id: <1223121068.11272.46.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stuart,

> > There is a regression on bluetoothd daemon, we introduce a SCO socket
> > listen recently which is causing the problem, although it seem that
> > the driver is also cooperating with the problem.
> 
> ok. Thanks for the information. Would installing bluez-4.10 help?

I will release 4.11 over the weekend and that should fix it.

Regards

Marcel


