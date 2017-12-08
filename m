Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] Bluetooth: hci_ll: Add endianness conversion when setting
 baudrate
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1512699739-22162-1-git-send-email-david@lechnology.com>
Date: Fri, 8 Dec 2017 09:00:56 +0100
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Message-Id: <87878C4D-90C2-4469-A827-C54516B052B1@holtmann.org>
References: <1512699739-22162-1-git-send-email-david@lechnology.com>
To: David Lechner <david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> This adds an endianness conversion when setting the baudrate using a
> vendor-specific command. Otherwise, bad things might happen on a big-
> endian system.
> 
> Suggested-by: Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> drivers/bluetooth/hci_ll.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
