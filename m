Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH 2/6] Bluetooth: Introduce HCI_ADVERTISING_INSTANCE setting and add AD flags
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426809877-22469-3-git-send-email-armansito@chromium.org>
Date: Thu, 19 Mar 2015 17:47:54 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F71DAEBE-ECE2-44EE-9F77-CAA3BED77946@holtmann.org>
References: <1426809877-22469-1-git-send-email-armansito@chromium.org> <1426809877-22469-3-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch introduces the HCI_ADVERTISING_INSTANCE setting, which is set
> when an at least one advertising instance has been added using the
> "Add Advertising" mgmt command. This patch also adds macro definitions
> various advertising data fields which can be assigned using the
> "Add Advertising" command.
> 
> Signed-off-by: Arman Uguray <armansito@chromium.org>
> ---
> include/net/bluetooth/hci.h | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 06e7eee..e400175 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -227,6 +227,7 @@ enum {
> 	HCI_LE_ENABLED,
> 	HCI_ADVERTISING,
> 	HCI_ADVERTISING_CONNECTABLE,
> +	HCI_ADVERTISING_INSTANCE,
> 	HCI_CONNECTABLE,
> 	HCI_DISCOVERABLE,
> 	HCI_LIMITED_DISCOVERABLE,
> @@ -477,6 +478,19 @@ enum {
> #define LE_AD_SIM_LE_BREDR_CTRL	0x08 /* Simultaneous LE & BR/EDR Controller */
> #define LE_AD_SIM_LE_BREDR_HOST	0x10 /* Simultaneous LE & BR/EDR Host */
> 
> +/* Other Low Energy Advertising Data fielt types  */
> +#define LE_AD_FIELD_SOLICIT16		0x14 /* 16-bit service solic. UUIDs */
> +#define LE_AD_FIELD_SOLICIT32		0x1F /* 32-bit service solic. UUIDs */
> +#define LE_AD_FIELD_SOLICIT128		0x15 /* 128-bit service solic. UUIDs */
> +#define LE_AD_FIELD_SVC_DATA16		0x16 /* Service Data - 16-bit UUID */
> +#define LE_AD_FIELD_SVC_DATA32		0x20 /* Service Data - 32-bit UUID */
> +#define LE_AD_FIELD_SVC_DATA128		0x21 /* Service Data - 128-bit UUID */
> +#define LE_AD_FIELD_PUB_TRGT_ADDR	0x17 /* Public Target Address */
> +#define LE_AD_FIELD_RND_TRGT_ADDR	0x18 /* Random Target Address */
> +#define LE_AD_FIELD_APPEARANCE		0x19 /* Appearance */
> +#define LE_AD_FIELD_MANUF_DATA		0xFF /* Manufacturer Specific Data */

please use the EIR_ section for this and extend it. I know this will look odd initially, but since AD and EIR share the same types we actually opted for calling most things EIR and kept it like that.

Also I think the only one you need to add is the APPEARANCE one. All others will not be used inside the kernel and have to be provided by userspace in raw format. So leave them out.

Regards

Marcel

