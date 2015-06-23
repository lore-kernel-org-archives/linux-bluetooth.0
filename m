Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Jun 2015 14:14:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Markus Pfau <markus.pfau@peakwork.de>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2015-06-18
Message-ID: <20150623111410.GA8703@t440s.lan>
References: <20150618184311.GA30772@t440s.P-661HNU-F1>
 <20150623.032255.394457596589182499.davem@davemloft.net>
 <558939EE.10206@peakwork.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <558939EE.10206@peakwork.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Markus,

On Tue, Jun 23, 2015, Markus Pfau wrote:
> Am 23.06.2015 um 12:22 schrieb David Miller:
> >From: Johan Hedberg <johan.hedberg@gmail.com>
> >Date: Thu, 18 Jun 2015 21:43:11 +0300
> >
> >>Here's the final bluetooth-next pull request for 4.2.
> >>
> >>  - Cleanups & fixes to 802.15.4 code and related drivers
> >>  - Fix btusb driver memory leak
> >>  - New USB IDs for Atheros controllers
> >>  - Support for BCM4324B3 UART based Broadcom controller
> >>  - Fix for Bluetooth encryption key size handling
> >>  - Broadcom controller initialization fixes
> >>  - Support for Intel controller DDC parameters
> >>  - Support for multiple Bluetooth LE advertising instances
> >>  - Fix for HCI user channel cleanup path
> >>
> >>Please let me know if there are any issues pulling. Thanks.
> >Pulled, thanks Johan,
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Hi David,
> 
> I didn't get any response to my issue "High CPU load when turning off BT
> keyboard" from 2015-06-15.
> Is it already fixed in "Fix for HCI user channel cleanup path" ?

Your issue (and fix) is user space related whereas this pull request was
for the kernel, so they are completely unrelated (we shouldn't bother
the netdev folks any further with this so please drop Dave and netdev if
you reply to this).

As for your fix, please resend it to linux-bluetooth using git
send-email so that we can continue the discussion around it there.

Johan
