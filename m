Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [RFC v2 08/15] Bluetooth: Move is_scan_and_conn_supported() to hci_core
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383053160-10175-9-git-send-email-andre.guedes@openbossa.org>
Date: Wed, 30 Oct 2013 00:09:36 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <7A2002B4-B5FC-4248-87C3-2594A82A102E@holtmann.org>
References: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org> <1383053160-10175-9-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds the "hci_" prefix and moves the is_scan_and_conn_
> supported() helper to hci_core so it can be reused in hci_core by
> the next patch.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> include/net/bluetooth/hci_core.h |  2 ++
> net/bluetooth/hci_conn.c         | 13 +------------
> net/bluetooth/hci_core.c         | 11 +++++++++++
> 3 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index e85b37e..0049036 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -782,6 +782,8 @@ int __hci_add_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
> void __hci_remove_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
> 				    u8 addr_type);
> 
> +bool hci_is_scan_and_conn_supported(struct hci_dev *hdev);
> +

as I said before, leave this all out until we figured out on how we handle the LE supported states. This patch now makes it clear that it is not fully thought through. And I am not moving this function around any time we need to change something.

Regards

Marcel

