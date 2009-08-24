Return-Path: <cyrus@holtmann.org>
Subject: Re: btusb autosuspend and circular lock dep
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Arjan Van De Ven <arjan@linux.intel.com>,
	saharabeara@gmail.com
In-Reply-To: <200908242326.01149.oliver@neukum.org>
References: <20090615175435.GA4772@gamba.jf.intel.com>
	 <200908242149.51588.oliver@neukum.org>
	 <1251143962.2950.63.camel@localhost.localdomain>
	 <200908242326.01149.oliver@neukum.org>
Content-Type: text/plain
Date: Mon, 24 Aug 2009 14:36:57 -0700
Message-Id: <1251149817.2950.72.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> > okay, then we have to violate coding style here since throughout the
> > whole Bluetooth subsystem we don't do { } around single statements. And
> > this applies to single else statements.
> 
> Next trial.
> 
> Signed-off-by: Oliver Neukum <oliver@neukum.org>

except that I have no commit message now :(

Regards

Marcel


