Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 1/2] Bluetooth: Use BROKEN_STORED_LINK_KEY quirk for HCI_Read_Stored_Link_Key
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1440960441-31324-1-git-send-email-johan.hedberg@gmail.com>
Date: Sun, 30 Aug 2015 13:51:20 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <51149276-A120-4E5A-BF5A-10F8995D390C@holtmann.org>
References: <1440960441-31324-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Some counterfeit CSR controllers also have broken behavior with the
> HCI_Read_Stored_Link_Key command:
> 
> < HCI Command: Read Stored Link Key (0x03|0x000d) plen 7
>        Address: 00:00:00:00:00:00 (OUI 00-00-00)
>        Read all: 0x01
>> HCI Event: Command Complete (0x0e) plen 8
>      Read Stored Link Key (0x03|0x000d) ncmd 1
>        Status: Unsupported Feature or Parameter Value (0x11)
>        Max num keys: 0
>        Num keys: 0
> 
> Extend the existing HCI_QUIRK_BROKEN_STORED_LINK_KEY to be also used
> for this HCI command.
> 
> Reported-and-tested-by: Rhobison Alves Pereira <rhobison@hotmail.com>
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

