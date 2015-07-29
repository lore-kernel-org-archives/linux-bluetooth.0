Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v5 1/6] Bluetooth: add HCI_LE_CONNECTING hci_dev flags
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1438161714-4521-1-git-send-email-jpawlowski@google.com>
Date: Wed, 29 Jul 2015 15:56:37 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D7CD702E-D9BC-4797-BB6D-C6D861056AA8@holtmann.org>
References: <1438161714-4521-1-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> This patch adds HCI_LE_CONNECTING flag to hci_dev flags, that will be set
> when connect attempt is pending. It also uses this flag instead of conn
> hash lookup where appropriate to check wether connect is in progress.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> include/net/bluetooth/hci.h | 1 +
> net/bluetooth/hci_conn.c    | 3 +--
> net/bluetooth/hci_event.c   | 4 ++++
> net/bluetooth/hci_request.c | 6 ++----
> net/bluetooth/mgmt.c        | 2 +-
> 5 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 7ca6690..4772ff8 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -240,6 +240,7 @@ enum {
> 	HCI_DUT_MODE,
> 	HCI_FORCE_BREDR_SMP,
> 	HCI_FORCE_STATIC_ADDR,
> +	HCI_LE_CONNECTING,
> 
> 	__HCI_NUM_FLAGS,
> };

this needs to be added to hci_dev_clear_volatile_flags as well then. HCI_Reset would need to reset this value. And I would actually sort it after HCI_LE_SCAN flag or at least after HCI_LE_SCAN_INTERRUPTED.

The last three are clearly put in an individual block since they are special and should be kept special. They are for debugging and testing purposes.

Regards

Marcel

