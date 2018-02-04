Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluetooth: btusb: Add support for Intel Bluetooth device
 22560 [8087:0026]
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1517623922-32654-1-git-send-email-tedd.an@linux.intel.com>
Date: Sun, 4 Feb 2018 15:07:30 +0100
Cc: linux-bluetooth@vger.kernel.org,
        Tedd Ho-Jeong An <tedd.an@intel.com>, amit.k.bag@intel.com
Message-Id: <57F07B6B-1CE5-4D82-BB19-FFA3452D454B@holtmann.org>
References: <1517623922-32654-1-git-send-email-tedd.an@linux.intel.com>
To: Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> The Bluetooth device 22560 (also known as HarrisonPeak) device from Intel
> use the same firmware loading mechanism as previous generation, so include
> new USB product ID and whitelist the hardware variant.

lets include QnJ and IcP also in the description. Or maybe send a separate patch to add QnJ and IcP support.

Regards

Marcel

