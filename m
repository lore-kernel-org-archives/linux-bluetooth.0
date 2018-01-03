Return-Path: <foo00@h08.hostsharing.net>
Date: Wed, 3 Jan 2018 14:34:10 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
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
Message-ID: <20180103133410.GB17027@wunner.de>
References: <cover.1514916630.git.lukas@wunner.de>
 <36e7c22493235863c2ab9dd9d7aa382a3fc15675.1514916630.git.lukas@wunner.de>
 <ffd03fb7-6caa-8128-03ba-fc4cb63328ea@redhat.com>
 <20180102233648.GA15299@wunner.de>
 <89642ecf-63b0-1aa7-8df0-ff4ecb5efe2d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <89642ecf-63b0-1aa7-8df0-ff4ecb5efe2d@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jan 03, 2018 at 09:07:20AM +0100, Hans de Goede wrote:
> On 03-01-18 00:36, Lukas Wunner wrote:
> > I don't have one of these MacBooks, I'm submitting patches on
> > behalf of others,
> 
> I didn't realize that, great work on this! It must not be easy
> to develop a comprehensive patch set like this without direct hw
> access.

A single person wouldn't be able to do it.  It's a collaborative effort,
the testing and debugging on multiple different machines, by Ronald
in particular but also Daniel, Peter, Leif, Max and others, is
indispensable.  (I've acknowledged that in patch [10/10].)

Gathering and curating all the relevant information, as done by Daniel
and Ronald on GitHub, is likewise important, as is the pioneering work
done by Leif.

Thanks,

Lukas
