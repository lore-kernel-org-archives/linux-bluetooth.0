Return-Path: <foo00@h08.hostsharing.net>
Date: Wed, 3 Jan 2018 14:34:51 +0100
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
Message-ID: <20180103133451.GC17027@wunner.de>
References: <cover.1514916630.git.lukas@wunner.de>
 <36e7c22493235863c2ab9dd9d7aa382a3fc15675.1514916630.git.lukas@wunner.de>
 <ffd03fb7-6caa-8128-03ba-fc4cb63328ea@redhat.com>
 <20180102233648.GA15299@wunner.de>
 <FDB414A4-5E3E-40B9-B725-CEB0ADC01A5E@holtmann.org>
 <20180103132221.GA17027@wunner.de>
 <8C0A242E-C6A5-40BA-96EE-D0C615104A13@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8C0A242E-C6A5-40BA-96EE-D0C615104A13@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jan 03, 2018 at 02:29:04PM +0100, Marcel Holtmann wrote:
> do you have a link to the data sheet?

http://docplayer.net/62075870-Bluetooth-functionality-laird-sd40-series-version-1-6.html
