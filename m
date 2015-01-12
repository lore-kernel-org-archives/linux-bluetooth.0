Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 Jan 2015 11:06:39 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/5] Bluetooth: Read stored link key information when
 powering on controller
Message-ID: <20150112090639.GA20805@t440s.lan>
References: <1421012665-4842-3-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421012665-4842-3-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jan 11, 2015, Marcel Holtmann wrote:
> The information about max stored link keys and current stored link keys
> should be read at controller initialization. So issue HCI Read Stored
> Link Key command with BDADDR_ANY and read_all flag set to 0x01 to
> retrieve this information.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index ba0d1fdccbd9..96572a48948e 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -731,6 +731,14 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
>  
>  	hci_setup_event_mask(req);
>  
> +	if (hdev->commands[6] & 0x20) {
> +		struct hci_cp_read_stored_link_key cp;
> +
> +		bacpy(&cp.bdaddr, BDADDR_ANY);
> +		cp.read_all = 0x01;
> +		hci_req_add(req, HCI_OP_READ_STORED_LINK_KEY, sizeof(cp), &cp);
> +	}

Since we're now reading the stored key count before deleting anything,
wouldn't it also make sense to move the deleting into init4_req and only
do it if hdev->stored_num_keys > 0?

Johan
