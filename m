Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2] Bluetooth: Fix __hci_request synchronization for
 hci_open_dev
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1292434408-20793-1-git-send-email-johan.hedberg@gmail.com>
References: <1292434408-20793-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Dec 2010 12:36:35 +0100
Message-ID: <1292585795.2658.3.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The initialization function used by hci_open_dev (hci_init_req) sends
> many different HCI commands. The __hci_request function should only
> return when all of these commands have completed (or a timeout occurs).
> Several of these commands cause hci_req_complete to be called which
> causes __hci_request to return prematurely.
> 
> This patch fixes the issue by adding a new hdev->last_init_cmd variable
> and making use of the HCI_INIT flag which is set during the
> initialization procedure. The hci_req_complete function will no longer
> do anything when this flag is set and the completed command wasn't the
> last_init_cmd one.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> ---
> v2: (based on feedback from Gustavo Padovan) hci_event.c and hci_core.c
> are now less dependent on each other regarding this issue. Now the
> hci_init_complete call doesn't need to be moved to a new location in
> hci_event.c if the sequence of initialization HCI commands changes in
> hci_core.c.
> 
>  include/net/bluetooth/hci_core.h |    4 +++-
>  net/bluetooth/hci_core.c         |    8 ++++++--
>  net/bluetooth/hci_event.c        |   33 +++++++++++++++++++++++----------
>  3 files changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 3786ee8..23ca4b1 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -134,6 +134,8 @@ struct hci_dev {
>  	struct hci_conn_hash	conn_hash;
>  	struct list_head	blacklist;
>  
> +	int			last_init_cmd;
> +

please use __u16 type here since you are storing an opcode. Also make
sure you always store the proper opcode in host order.

Regards

Marcel


