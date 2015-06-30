Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Jun 2015 14:55:55 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v1 1/2] Bluetooth: Move address type check for
 hci_conn_params
Message-ID: <20150630115555.GA29126@t440s.lan>
References: <1435188850-14969-1-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435188850-14969-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Jun 24, 2015, Jakub Pawlowski wrote:
> @@ -2822,10 +2822,6 @@ struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
>  {
>  	struct hci_conn_params *params;
>  
> -	/* The conn params list only contains identity addresses */
> -	if (!hci_is_identity_address(addr, addr_type))
> -		return NULL;
> -
>  	list_for_each_entry(params, &hdev->le_conn_params, list) {
>  		if (bacmp(&params->addr, addr) == 0 &&
>  		    params->addr_type == addr_type) {
> @@ -2842,10 +2838,6 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
>  {
>  	struct hci_conn_params *param;
>  
> -	/* The list only contains identity addresses */
> -	if (!hci_is_identity_address(addr, addr_type))
> -		return NULL;
> -
>  	list_for_each_entry(param, list, action) {
>  		if (bacmp(&param->addr, addr) == 0 &&
>  		    param->addr_type == addr_type)

Both of the above could be called for HCI events related to non-paired
devices that use private addresses. In such a case these identity
address checks would prevent unnecessary iteration of the (potentially
long) list. Do we really want to remove them?

Johan
