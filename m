Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Add active_low irq polarity quirk for
 Asus T100CHI
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170629122132.4537-1-hdegoede@redhat.com>
Date: Thu, 29 Jun 2017 14:36:09 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <88ED8683-E111-4490-A7B2-A924BD9FB9FE@holtmann.org>
References: <20170629122132.4537-1-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> Just like the T100TA the host-wake irq on the Asus T100CHI is
> active low. Having a quirk for this is actually extra important on the
> T100CHI as it ships with a bluetooth keyboard dock, which does not
> work properly without this quirk.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/hci_bcm.c | 9 +++++++++
> 1 file changed, 9 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

