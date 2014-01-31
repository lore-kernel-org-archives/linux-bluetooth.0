Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] Bluetooth: Remove Simultaneous LE & BR/EDR flags from AD
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1391109410-8595-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 30 Jan 2014 19:12:52 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <57F1BF45-B9B4-4C6D-AE7E-A5BAE2262175@holtmann.org>
References: <1391109410-8595-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Starting with the 4.1 Core Specification these flags are no longer used
> and should always be cleared. From volume 3, part C, section 13.1.1:
> 
> "The 'Simultaneous LE and BR/EDR to Same Device Capable (Controller)'
> and ‘Simultaneous LE and BR/EDR to Same Device Capable (Host)’ bits in
> the Flags AD type shall be set to ‘0’."
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 8 +-------
> 1 file changed, 1 insertion(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

