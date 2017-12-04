Return-Path: <netdev-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH 2/3] bluetooth: hci_ll: add constant for vendor-specific
 command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1512357682-8911-3-git-send-email-david@lechnology.com>
Date: Mon, 4 Dec 2017 07:23:13 +0100
Cc: devicetree <devicetree@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <5C65FB74-D7FD-4653-993A-5A68AD844A41@holtmann.org>
References: <1512357682-8911-1-git-send-email-david@lechnology.com>
 <1512357682-8911-3-git-send-email-david@lechnology.com>
To: David Lechner <david@lechnology.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> This adds a #define for the vendor-specific HCI command to set the
> baudrate instead of using the bare 0xff36 multiple times.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> drivers/bluetooth/hci_ll.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
