Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH 2/2] Bluetooth: Add local SSP OOB data to OOB ext data mgmt command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1428406590-30002-2-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 7 Apr 2015 08:59:17 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8D9A0505-B88D-47C0-A27D-F274EDF4DDC4@holtmann.org>
References: <1428406590-30002-1-git-send-email-johan.hedberg@gmail.com> <1428406590-30002-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The Read Local Out Of Band Extended Data mgmt command is specified to
> return the SSP values when given a BR/EDR address type as input
> parameter. The returned values may include either the 192-bit variants
> of C and R, or their 256-bit variants, or both, depending on the status
> of Secure Connections and Secure Connections Only modes. If SSP is not
> enabled the command will only return the Class of Device value (like it
> has done so far).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 152 ++++++++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 149 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 845dfcc43a20..df721370605b 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -6466,6 +6466,140 @@ static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
> 	return eir_len;
> }
> 
> +static void read_local_oob_ext_data_complete(struct hci_dev *hdev, u8 status,
> +					     u16 opcode, struct sk_buff *skb)
> +{
> +	const struct mgmt_cp_read_local_oob_ext_data *mgmt_cp;
> +	struct mgmt_rp_read_local_oob_ext_data *mgmt_rp;
> +	u8 *h192, *r192, *h256, *r256;
> +	struct mgmt_pending_cmd *cmd;
> +	u16 eir_len;
> +	int err;
> +
> +	BT_DBG("%s status %u", hdev->name, status);
> +
> +	cmd = pending_find(MGMT_OP_READ_LOCAL_OOB_EXT_DATA, hdev);
> +	if (!cmd)
> +		return;
> +
> +	mgmt_cp = cmd->param;
> +
> +	if (status) {
> +		status = mgmt_status(status);
> +		eir_len = 0;
> +	} else if (opcode == HCI_OP_READ_LOCAL_OOB_DATA) {
> +		struct hci_rp_read_local_oob_data *rp;
> +
> +		if (skb->len != sizeof(*rp)) {
> +			status = MGMT_STATUS_FAILED;
> +			eir_len = 0;
> +		} else {
> +			status = MGMT_STATUS_SUCCESS;
> +			rp = (void *) skb->data;

I think the coding style proposes (void *)skb->data.

> +
> +			eir_len = 5 + 18 + 18;
> +			h192 = rp->hash;
> +			r192 = rp->rand;
> +			h256 = NULL;
> +			r256 = NULL;
> +		}
> +	} else {
> +		struct hci_rp_read_local_oob_ext_data *rp;
> +
> +		if (skb->len != sizeof(*rp)) {
> +			status = MGMT_STATUS_FAILED;
> +			eir_len = 0;
> +		} else {
> +			status = MGMT_STATUS_SUCCESS;
> +			rp = (void *) skb->data;

Same as above.

> +
> +			if (hci_dev_test_flag(hdev, HCI_SC_ONLY)) {
> +				eir_len = 5 + 18 + 18;
> +				h192 = NULL;
> +				r192 = NULL;
> +			} else {
> +				eir_len = 5 + 18 + 18 + 18 + 18;
> +				h192 = rp->hash192;
> +				r192 = rp->rand192;
> +			}
> +
> +			h256 = rp->hash256;
> +			r256 = rp->rand256;
> +		}
> +	}
> +
> +	mgmt_rp = kmalloc(sizeof(*mgmt_rp) + eir_len, GFP_KERNEL);
> +	if (!mgmt_rp)
> +		goto done;
> +
> +	if (status)
> +		goto send_rsp;
> +
> +	eir_len = eir_append_data(mgmt_rp->eir, 0, EIR_CLASS_OF_DEV,
> +				  hdev->dev_class, 3);
> +
> +	if (h192 && r192) {
> +		eir_len = eir_append_data(mgmt_rp->eir, eir_len,
> +					  EIR_SSP_HASH_C192, h192, 16);
> +		eir_len = eir_append_data(mgmt_rp->eir, eir_len,
> +					  EIR_SSP_RAND_R192, r192, 16);
> +	}
> +
> +	if (h256 && r256) {
> +		eir_len = eir_append_data(mgmt_rp->eir, eir_len,
> +					  EIR_SSP_HASH_C256, h256, 16);
> +		eir_len = eir_append_data(mgmt_rp->eir, eir_len,
> +					  EIR_SSP_RAND_R256, r256, 16);
> +	}
> +
> +send_rsp:
> +	mgmt_rp->type = mgmt_cp->type;
> +	mgmt_rp->eir_len = cpu_to_le16(eir_len);
> +
> +	err = mgmt_cmd_complete(cmd->sk, hdev->id,
> +				MGMT_OP_READ_LOCAL_OOB_EXT_DATA, status,
> +				mgmt_rp, sizeof(*mgmt_rp) + eir_len);
> +	if (err < 0 || status)
> +		goto done;
> +
> +	hci_sock_set_flag(cmd->sk, HCI_MGMT_OOB_DATA_EVENTS);
> +
> +	err = mgmt_limited_event(MGMT_EV_LOCAL_OOB_DATA_UPDATED, hdev,
> +				 mgmt_rp, sizeof(*mgmt_rp) + eir_len,
> +				 HCI_MGMT_OOB_DATA_EVENTS, cmd->sk);
> +done:
> +	kfree(mgmt_rp);
> +	mgmt_pending_remove(cmd);
> +}
> +
> +static int read_local_ssp_oob_req(struct hci_dev *hdev, struct sock *sk,
> +				  struct mgmt_cp_read_local_oob_ext_data *cp)
> +{
> +	struct mgmt_pending_cmd *cmd;
> +	struct hci_request req;
> +	int err;
> +
> +	cmd = mgmt_pending_add(sk, MGMT_OP_READ_LOCAL_OOB_EXT_DATA, hdev,
> +			       cp, sizeof(*cp));
> +	if (!cmd)
> +		return -ENOMEM;
> +
> +	hci_req_init(&req, hdev);
> +
> +	if (bredr_sc_enabled(hdev))
> +		hci_req_add(&req, HCI_OP_READ_LOCAL_OOB_EXT_DATA, 0, NULL);
> +	else
> +		hci_req_add(&req, HCI_OP_READ_LOCAL_OOB_DATA, 0, NULL);
> +
> +	err = hci_req_run_skb(&req, read_local_oob_ext_data_complete);
> +	if (err < 0) {
> +		mgmt_pending_remove(cmd);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> static int read_local_oob_ext_data(struct sock *sk, struct hci_dev *hdev,
> 				   void *data, u16 data_len)
> {
> @@ -6517,9 +6651,21 @@ static int read_local_oob_ext_data(struct sock *sk, struct hci_dev *hdev,
> 	eir_len = 0;
> 	switch (cp->type) {
> 	case BIT(BDADDR_BREDR):
> -		eir_len = eir_append_data(rp->eir, eir_len, EIR_CLASS_OF_DEV,
> -					  hdev->dev_class, 3);
> -		break;
> +		if (!hci_dev_test_flag(hdev, HCI_SSP_ENABLED)) {
> +			eir_len = eir_append_data(rp->eir, eir_len,
> +						  EIR_CLASS_OF_DEV,
> +						  hdev->dev_class, 3);
> +			break;
> +		}
> +
> +		err = read_local_ssp_oob_req(hdev, sk, cp);
> +		hci_dev_unlock(hdev);
> +		if (err) {
> +			status = MGMT_STATUS_FAILED;
> +			goto complete;
> +		}
> +
> +		goto done;


So I think in this specific case, doing it with if clauses is cleaner than the break and goto and easier to read:

	if (hci_dev_test_flag(hdev, HCI_SSP_ENABLED)) {
		err = read_local_..
		hci_dev_unlock(hdev);
		if (!err)
			goto done;

		status = MGMT_STATUS_..
		goto completed;
	} else {
		eir_len = eir_append_data(..
	}
	break;


> 	case (BIT(BDADDR_LE_PUBLIC) | BIT(BDADDR_LE_RANDOM)):
> 		if (hci_dev_test_flag(hdev, HCI_SC_ENABLED) &&
> 		    smp_generate_oob(hdev, hash, rand) < 0) {

Regards

Marcel

