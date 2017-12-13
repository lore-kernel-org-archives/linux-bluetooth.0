Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH 0/2] Bluetooth: Add device tree compatible for TI CC2560
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1513124971-23717-1-git-send-email-david@lechnology.com>
Date: Wed, 13 Dec 2017 09:39:10 +0100
Cc: devicetree <devicetree@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <12AF86F1-0F4F-40E5-9139-8B175A8F3269@holtmann.org>
References: <1513124971-23717-1-git-send-email-david@lechnology.com>
To: David Lechner <david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> This series updates the bindings TI WiLink 7/8 Bluetooth to add TI CC256x
> chips as well. A compatible string is also added to the hci_ll driver for
> TI CC2560.
> 
> David Lechner (2):
>  dt-bindings: net: add TI CC2560 Bluetooth chip
>  Bluetooth: hci_ll: add "ti,cc2560" compatible string
> 
> .../bindings/net/{ti,wilink-st.txt => ti-bluetooth.txt}     | 13 +++++++++++--
> drivers/bluetooth/hci_ll.c                                  |  1 +
> 2 files changed, 12 insertions(+), 2 deletions(-)
> rename Documentation/devicetree/bindings/net/{ti,wilink-st.txt => ti-bluetooth.txt} (78%)

both patches have been applied to bluetooth-next tree.

Regards

Marcel
