Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH v4] Bluetooth: hci_ll: Add optional nvmem BD address
 source
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1513122852-5135-2-git-send-email-david@lechnology.com>
Date: Wed, 13 Dec 2017 09:22:11 +0100
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Message-Id: <A32D2F8C-AE13-4774-AE0E-60547167669F@holtmann.org>
References: <1513122852-5135-1-git-send-email-david@lechnology.com>
 <1513122852-5135-2-git-send-email-david@lechnology.com>
To: David Lechner <david@lechnology.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> This adds an optional nvmem consumer to get a BD address from an external
> source. The BD address is then set in the Bluetooth chip after the
> firmware has been loaded.
> 
> This has been tested working with a TI CC2560A chip (in a LEGO MINDSTORMS
> EV3).
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> drivers/bluetooth/hci_ll.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 61 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

