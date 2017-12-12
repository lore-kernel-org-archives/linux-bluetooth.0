Return-Path: <netdev-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH v3 0/3] Bluetooth: hci_ll: Get BD address from NVMEM 
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1513115958-23761-1-git-send-email-david@lechnology.com>
Date: Tue, 12 Dec 2017 23:52:53 +0100
Cc: devicetree <devicetree@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Message-Id: <4646D298-A5A9-486D-8F7B-27D05BE2572A@holtmann.org>
References: <1513115958-23761-1-git-send-email-david@lechnology.com>
To: David Lechner <david@lechnology.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> This series adds supporting getting the BD address from a NVMEM provider
> for "LL" HCI controllers (Texas Instruments).
> 
> v3 changes:
> * Additional comments on why swapping bytes is needed.
> * Fixed comment style and trailing whitespace.
> * Rework error handling for nvmem cell code.
> 
> v2 changes:
> * Fixed typos in dt-bindings
> * Use "bd-address" instead of "mac-address"
> * Updated dt-bindings to specify the byte order of "bd-address"
> * New patch "Bluetooth: hci_ll: add support for setting public address"
> * Dropped patch "Bluetooth: hci_ll: add constant for vendor-specific command"
>  that is already in bluetooth-next
> * Rework error handling
> * Use bdaddr_t, bacmp and other bluetooth utils
> 
> David Lechner (3):
>  Bluetooth: hci_ll: add support for setting public address
>  dt-bindings: Add optional nvmem BD address bindings to ti,wlink-st
>  Bluetooth: hci_ll: Add optional nvmem BD address source
> 
> .../devicetree/bindings/net/ti,wilink-st.txt       |  5 ++
> drivers/bluetooth/hci_ll.c                         | 77 ++++++++++++++++++++++
> 2 files changed, 82 insertions(+)

I applied to first 2 patches to bluetooth-next tree, but the 3rd is throwing a warning.

  CC      drivers/bluetooth/hci_ll.o
drivers/bluetooth/hci_ll.c: In function ‘hci_ti_probe’:
drivers/bluetooth/hci_ll.c:814:41: error: passing argument 2 of ‘nvmem_cell_read’ from incompatible pointer type [-Werror=incompatible-pointer-types]
   bdaddr = nvmem_cell_read(bdaddr_cell, &len);
                                         ^
In file included from drivers/bluetooth/hci_ll.c:56:0:
./include/linux/nvmem-consumer.h:81:21: note: expected ‘size_t * {aka long unsigned int *}’ but argument is of type ‘int *’
 static inline void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
                     ^~~~~~~~~~~~~~~

Regards

Marcel
