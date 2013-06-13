Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Jun 2013 10:59:06 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH] Bluetooth: Fix conditions for HCI_Delete_Stored_Link_Key
Message-ID: <20130613095906.GA16835@joana>
References: <1371110473-15072-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371110473-15072-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2013-06-13 11:01:13 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> Even though the HCI_Delete_Stored_Link_Key command is mandatory for 1.1
> and later controllers some controllers do not seem to support it
> properly as was witnessed by one Broadcom based controller:
> 
> < HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7
>     bdaddr 00:00:00:00:00:00 all 1
> > HCI Event: Command Complete (0x0e) plen 4
>     Delete Stored Link Key (0x03|0x0012) ncmd 1
>     status 0x11 deleted 0
>     Error: Unsupported Feature or Parameter Value
> 
> Luckily this same controller also doesn't list the command in its
> supported commands bit mask (counting from 0 bit 7 of octet 6):
> 
> < HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0
> > HCI Event: Command Complete (0x0e) plen 68
>     Read Local Supported Commands (0x04|0x0002) ncmd 1
>     status 0x00
>     Commands: ffffffffffff1ffffffffffff30fffff3f
> 
> Therefore, it makes sense to move sending of HCI_Delete_Stored_Link_Key
> to after receiving the supported commands response and to only send it
> if its respective bit in the mask is set. The downside of this is that
> we no longer send the HCI_Delete_Stored_Link_Key command for Bluetooth
> 1.1 controllers since HCI_Read_Local_Supported_Command was introduced in
> version 1.2, but this is an acceptable penalty as the command in
> question shouldn't affect critical behavior.
> 
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_core.c |   14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Patch has been applied to bluetooth.git. Thanks.

	Gustavo
