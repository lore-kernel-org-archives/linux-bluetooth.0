Return-Path: <SRS0+568a86f7f2f31b2d34f2+355+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Subject: Re: [Bluez-devel] Re: CSR firmware question...
From: David Woodhouse <dwmw2@infradead.org>
To: jt@hpl.hp.com
Cc: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Steven Singer <steven.singer@csr.com>
In-Reply-To: <20040813163736.GC22763@bougret.hpl.hp.com>
References: <20040813002514.GA21388@bougret.hpl.hp.com>
	 <1092385877.28711.185.camel@pegasus>
	 <20040813163736.GC22763@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1092416546.14552.41.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Fri, 13 Aug 2004 18:02:26 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, 2004-08-13 at 09:37 -0700, Jean Tourrilhes wrote:
> 	What do you mean default boot set to HID ? I look similar to
> what I'm seeing.

It appears as a HID device instead of a Bluetooth device. Presumably so
that the PeeCee BIOS can use a Bluetooth keyboard as if it were a USB
keyboard, and do its emulation thing to make _that_ appear as a PS/2
keyboard....

Try running 'hid2hci' from recent bluez-utils. It should 'convert' it
back to being an HCI device again. 

-- 
dwmw2
