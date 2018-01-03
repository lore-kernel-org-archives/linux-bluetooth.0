Return-Path: <foo00@h08.hostsharing.net>
Date: Wed, 3 Jan 2018 14:22:21 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Frederic Danis <frederic.danis.oss@gmail.com>,
	Loic Poulain <loic.poulain@linaro.org>, Max Shavrick <mxms@me.com>,
	Leif Liddy <leif.liddy@gmail.com>,
	Daniel Roschka <danielroschka@phoenitydawn.de>,
	Ronald Tschalaer <ronald@innovation.ch>,
	"Peter Y. Chuang" <peteryuchuang@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 03/10] Bluetooth: hci_bcm: Enable runtime PM despite
 absence of IRQ
Message-ID: <20180103132221.GA17027@wunner.de>
References: <cover.1514916630.git.lukas@wunner.de>
 <36e7c22493235863c2ab9dd9d7aa382a3fc15675.1514916630.git.lukas@wunner.de>
 <ffd03fb7-6caa-8128-03ba-fc4cb63328ea@redhat.com>
 <20180102233648.GA15299@wunner.de>
 <FDB414A4-5E3E-40B9-B725-CEB0ADC01A5E@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FDB414A4-5E3E-40B9-B725-CEB0ADC01A5E@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jan 03, 2018 at 01:34:00PM +0100, Marcel Holtmann wrote:
> > I notice that command 0xfc27 is used to write the sleep_params.
> > Does anyone know the command to read them so that we can check the
> > defaults Apple is using and find out if they can be optimized?
> 
> the Read Sleepmode Param is 0xfc28 and requires no parameters. You can
> check monitor/broadcom.c for a bunch of these commands since btmon will
> decode them for you if possible. Might want to actually post the btmon
> log of the init sequence here for reference (just blacklist the module
> and load it manually after starting btmon).
> 
> I thought that I created a Broadcom specific init that reads most of
> the standard values so we have them for reference in the btmon logs.
> However it seems I have not done that for Sleepmode Param at the moment.

Thanks!

I've now been able to dig up v1.6 of the Laird SD40 firmware datasheet.

There's an incongruence between the datasheet and struct bcm_set_sleep_mode
(as declared in drivers/bluetooth/btbcm.h and hci_bcm.c) wherein the order
of pulsed_host_wake and break_to_host is reversed.

The datasheet is dated Oct 2015, so fairly recent, making it appear more
likely that the datasheet is correct and our code is wrong?

Kind regards,

Lukas
