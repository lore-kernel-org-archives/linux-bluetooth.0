Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 16/17] Bluetooth: Create hci_req_add_le_passive_scan helper
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393362104-12175-17-git-send-email-andre.guedes@openbossa.org>
Date: Tue, 25 Feb 2014 22:44:13 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A552BAE1-F573-4940-9E30-CA7AF189D3DD@holtmann.org>
References: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org> <1393362104-12175-17-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patches creates the hci_req_add_le_passive_scan helper so it can
> be re-used in the next patch.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> net/bluetooth/hci_core.c | 54 +++++++++++++++++++++++++++---------------------
> 1 file changed, 30 insertions(+), 24 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index fb4c961..e776624 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -5095,6 +5095,35 @@ void hci_req_add_le_scan_disable(struct hci_request *req)
> 	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
> }
> 
> +static void hci_req_add_le_passive_scan(struct hci_request *req,
> +					struct hci_dev *hdev)
> +{

	struct hci_dev *hdev = req->hdev;

Regards

Marcel

