Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: btusb: set HCI_QUIRK_BROKEN_LOCAL_COMMANDS for
 0x0a5c:0x21f3
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAFk90B-PXM4QWynAZg33dV7KGUcYyELVEfe=pGSAFzm27+_NWg@mail.gmail.com>
Date: Fri, 9 Jun 2017 18:50:35 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7FA34550-B4CB-44B9-BA71-1CACCB411749@holtmann.org>
References: <20170508110848.8639-1-graham.gower@gmail.com>
 <7A6EA8E7-D67A-4EC0-8309-113D15F5DC1C@holtmann.org>
 <CAFk90B-PXM4QWynAZg33dV7KGUcYyELVEfe=pGSAFzm27+_NWg@mail.gmail.com>
To: Graham Gower <graham.gower@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Graham,

> I reverted my patch, then captured the btmon output while running
> 'hciconfig hci0 up'. I'm running kernel version 4.4.38. Please see
> attached.

I just posted a patch that will skip the Set Event Mask Page 2 command in case nothing has to be modified. Maybe that will help you as well. Can you give a try.

Regards

Marcel

