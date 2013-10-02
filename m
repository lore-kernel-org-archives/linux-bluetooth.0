Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 1/8] Bluetooth: Add Set Reserved LT_ADDR Command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380705078-22154-2-git-send-email-dh79.pyun@samsung.com>
Date: Wed, 2 Oct 2013 11:31:39 +0200
Cc: linux-bluetooth@vger.kernel.org, steve.jun@samsung.com,
	DoHyun Pyun <dh79.pyun@samsung.com>,
	C S Bhargava <cs.bhargava@samsung.com>
Message-Id: <8F4369C6-95E9-4878-A87D-26F69B085A6D@holtmann.org>
References: <1380705078-22154-1-git-send-email-dh79.pyun@samsung.com> <1380705078-22154-2-git-send-email-dh79.pyun@samsung.com>
To: Dohyun Pyun <re20sfree@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dohyun,

your adding the structures and definitions for this command. Not that actual command. That should be clear in the subject.

> The Set_Reserved_LT_ADDR command allows the host to request that the
> BR/EDR Controller reserve a specific LT_ADDR for Connectionless Slave
> Broadcast.
> 
> The Core Spec Addendum 4 adds this command in part B Connectionless
> Slave Broadcast.
> 
> Bluetooth Core Specification Addendum 4 - Page 90
> 
> "7.3.86 Set Reserved LT_ADDR Command [New Section]
> ...
> If the LT_ADDR indicated in the LT_ADDR parameter is already in use by the
> BR/EDR Controller, it shall return the ACL Connection Already Exists (0x0B)
> error code. If the LT_ADDR indicated in the LT_ADDR parameter is out of
> range, the controller shall return the Invalid HCI Command Parameters (0x12)
> error code. If the command succeeds, then the reserved LT_ADDR shall be
> used when issuing subsequent Set Connectionless Slave Broadcast Data and
> Set Connectionless Slave Broadcast commands.
> To ensure that the reserved LT_ADDR is not already allocated, it is
> recommended that this command be issued at some point after HCI_Reset is
> issued but before page scanning is enabled or paging is initiated."
> 
> Signed-off-by: Dohyun Pyun <dh79.pyun@samsung.com>
> Signed-off-by: C S Bhargava <cs.bhargava@samsung.com>
> ---
> include/net/bluetooth/hci.h | 9 +++++++++
> 1 file changed, 9 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 7ede266..dead0b0 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -838,6 +838,15 @@ struct hci_cp_write_le_host_supported {
> 	__u8	simul;
> } __packed;
> 
> +#define HCI_OP_SET_RESERVED_LT_ADDR	0x0c74
> +struct hci_cp_set_reserved_lt_addr {
> +	__u8 lt_addr;
> +} __packed;
> +struct hci_rp_set_reserved_lt_addr {
> +	__u8 status;
> +	__u8 lt_addr;
> +} __packed;
> +

Please follow the coding style of all the other structs in this area. They clearly have a tab between the type and the variable name.

Regards

Marcel

