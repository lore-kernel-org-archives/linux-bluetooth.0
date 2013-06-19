Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH 1/5] Bluetooth: Support for loading broadcom patchram firmware
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1371655718-1753-1-git-send-email-jesse.sung@canonical.com>
Date: Wed, 19 Jun 2013 22:02:57 +0200
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Anthony Wong <anthony.wong@canonical.com>
Message-Id: <688D0E41-320E-43A3-9722-462851431685@holtmann.org>
References: <1371655718-1753-1-git-send-email-jesse.sung@canonical.com>
To: Jesse Sung <jesse.sung@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jesse,

> There is an user space firmware loading tool which can be found at
> http://marc.info/?l=linux-bluetooth&m=132039175324993&w=2
> 
> The supported firmware is in hcd format, which is a collection of
> hci commands. The download process would be:
> 1. reset command
> 2. download command
> 3. firmware image in hcd file
> 4. reset command

following what we did for the Intel devices is obviously the right way here.

However that said, we used the Intel setup part to test the handling of the changes we build for doing the actual setup. Long term plan is still to create a mini-driver framework.

So drivers like the Intel one and Broadcom patchram will become their own module providing just the setup routing and sharing everything else via exportable functions from btusb.ko.

Would you like to help our guys to get this mini-driver framework into a mergable shape?

Regards

Marcel

