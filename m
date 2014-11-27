Return-Path: <cyrus@holtmann.org>
Date: Thu, 27 Nov 2014 14:22:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v11 1/3] Bluetooth: add hci_restart_le_scan
Message-ID: <20141127122222.GA28057@t440s>
References: <1417051767-19597-1-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417051767-19597-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Nov 26, 2014, Jakub Pawlowski wrote:
> +/*
> + * BR/EDR and/or LE discovery state flags: the flags defined here should
> + * represent state of discovery
> + */
> +enum {
> +	HCI_LE_SCAN_RESTARTING,
> +};

I think this enum should be as close as possible to the struct
discovery_state definition, i.e. right before it in hci_core.h. The
hci.h file should be strictly for HCI definitions only, but for
historical reasons it also contains some implementation specific stuff.

Also note that the net/ coding style doesn't use an empty first line for
multi-line comments.

> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -75,6 +75,7 @@ struct discovery_state {
>  	u32			last_adv_flags;
>  	u8			last_adv_data[HCI_MAX_AD_LENGTH];
>  	u8			last_adv_data_len;
> +	unsigned long		flags;
>  };
>  
>  struct hci_conn_hash {
> @@ -337,6 +338,7 @@ struct hci_dev {
>  	unsigned long		dev_flags;
>  
>  	struct delayed_work	le_scan_disable;
> +	struct delayed_work	le_scan_restart;
>  
>  	__s8			adv_tx_power;
>  	__u8			adv_data[HCI_MAX_AD_LENGTH];
> @@ -1326,6 +1328,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
>  #define DISCOV_INTERLEAVED_TIMEOUT	5120	/* msec */
>  #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
>  #define DISCOV_BREDR_INQUIRY_LEN	0x08
> +#define DISCOV_LE_RESTART_DELAY		300	/* msec */
>  
>  int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
>  int mgmt_new_settings(struct hci_dev *hdev);
> @@ -1403,6 +1406,7 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
>  			      u8 *own_addr_type);
>  void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
>  			       u8 *bdaddr_type);
> +void hci_restart_le_scan(struct hci_dev *hdev);

When looking at your later patches (mainly 3/3) this
hci_restart_le_scan() functionality is only accessed from within mgmt.c.
I'd therefore suggest to simply have it all as part of mgmt.c (as static
functions) and only later export it through hci_core.h if there really
is a need.

Johan
