Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E5BC3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 11:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B1F20801
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 11:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgCELEV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:04:21 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:36122 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgCELEV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 06:04:21 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id C02BCCECE9;
        Thu,  5 Mar 2020 12:13:46 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v3] bluetooth: Enable erroneous data reporting if wbs is
 supported
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200304172207.58963-1-alainm@chromium.org>
Date:   Thu, 5 Mar 2020 12:04:18 +0100
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <952F72CF-2414-4940-B5CE-D33981E56B90@holtmann.org>
References: <20200304172207.58963-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This change intruduces a wide band speech setting which allows higher
> level clients to query the local controller support for wide band speech
> as well as set the setting state when the radio is powered off.
> Internally, this setting controls if erroneous data reporting is enabled
> on the controller.
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> ---
> 
> include/net/bluetooth/hci.h      | 14 ++++++++
> include/net/bluetooth/hci_core.h |  1 +
> include/net/bluetooth/mgmt.h     |  2 ++
> net/bluetooth/hci_core.c         | 21 +++++++++++
> net/bluetooth/hci_event.c        | 39 ++++++++++++++++++++
> net/bluetooth/mgmt.c             | 62 ++++++++++++++++++++++++++++++++
> 6 files changed, 139 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 0b3ebd35681d..d66648e9ff13 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -286,6 +286,7 @@ enum {
> 	HCI_FAST_CONNECTABLE,
> 	HCI_BREDR_ENABLED,
> 	HCI_LE_SCAN_INTERRUPTED,
> +	HCI_WIDE_BAND_SPEECH_ENABLED,

lets use HCI_WIDEBAND_SPEECH_ENABLED. It might be just me, but when I look at WIDE_BAND compared to WIDEBAND, I prefer the latter.

> 
> 	HCI_DUT_MODE,
> 	HCI_VENDOR_DIAG,
> @@ -1095,6 +1096,19 @@ struct hci_rp_read_inq_rsp_tx_power {
> 	__s8     tx_power;
> } __packed;
> 
> +#define HCI_OP_READ_DEF_ERR_DATA_REPORTING	0x0c5a
> +	#define ERR_DATA_REPORTING_DISABLED	0x00
> +	#define ERR_DATA_REPORTING_ENABLED	0x01
> +struct hci_rp_read_def_err_data_reporting {
> +	__u8     status;
> +	__u8     err_data_reporting;
> +} __packed;
> +
> +#define HCI_OP_WRITE_DEF_ERR_DATA_REPORTING	0x0c5b
> +struct hci_cp_write_def_err_data_reporting {
> +	__u8     err_data_reporting;
> +} __packed;
> +
> #define HCI_OP_SET_EVENT_MASK_PAGE_2	0x0c63
> 
> #define HCI_OP_READ_LOCATION_DATA	0x0c64
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index dcc0dc6e2624..c498ac113930 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -260,6 +260,7 @@ struct hci_dev {
> 	__u8		stored_num_keys;
> 	__u8		io_capability;
> 	__s8		inq_tx_power;
> +	__u8		err_data_reporting;
> 	__u16		page_scan_interval;
> 	__u16		page_scan_window;
> 	__u8		page_scan_type;
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index f69f88e8e109..b203df07e7fc 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -672,6 +672,8 @@ struct mgmt_cp_set_blocked_keys {
> } __packed;
> #define MGMT_OP_SET_BLOCKED_KEYS_SIZE 2
> 
> +#define MGMT_OP_SET_WIDE_BAND_SPEECH	0x0047
> +
> #define MGMT_EV_CMD_COMPLETE		0x0001
> struct mgmt_ev_cmd_complete {
> 	__le16	opcode;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 4e6d61a95b20..d526d7568396 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -603,6 +603,9 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
> 	if (hdev->commands[8] & 0x01)
> 		hci_req_add(req, HCI_OP_READ_PAGE_SCAN_ACTIVITY, 0, NULL);
> 
> +	if (hdev->commands[18] & 0x02)
> +		hci_req_add(req, HCI_OP_READ_DEF_ERR_DATA_REPORTING, 0, NULL);
> +
> 	/* Some older Broadcom based Bluetooth 1.2 controllers do not
> 	 * support the Read Page Scan Type command. Check support for
> 	 * this command in the bit mask of supported commands.
> @@ -838,6 +841,24 @@ static int hci_init4_req(struct hci_request *req, unsigned long opt)
> 			    sizeof(support), &support);
> 	}
> 
> +	/* Set erroneous data reporting if supported to the wideband speech
> +	 * setting value
> +	 */
> +	if (test_bit(HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED, &hdev->quirks) &&
> +	    (hdev->commands[18] & 0x04) &&
> +	    hci_dev_test_flag(hdev, HCI_WIDE_BAND_SPEECH_ENABLED) !=
> +	     (hdev->err_data_reporting != ERR_DATA_REPORTING_ENABLED)) {

So this statement is creating a knot in my brain ;)


	if (hdev->commands[18] & 0x04) {
		bool enabled = hci_dev_test_flag(hdev, HCI_WIDEBAND_SPEECH_ENABLED);

		..

		cp.err_data_reporting = enabled ? ERR_DATA_REPORTING_ENABLED :
						  ERR_DATA_REPORTING_DISABLED;

		..
	}

I would not bother checking the quirk here. I would just configure that setting based on the HCI_WIDEBAND_SPEECH_ENABLED flag. Unless we have controllers that report this command and don’t allow setting the value, then we have to deal with it, but right now I assume that they get the basics of HCI right.

Btw. I am debating a coding style here.

		cp.err_data_reporting = enabled ? ERR_DATA_REPORTING_ENABLED
						: ERR_DATA_REPORTING_DISABLED;

But I am not even sure that is clearer or cleaner.

> +		struct hci_cp_write_def_err_data_reporting cp = {};
> +
> +		cp.err_data_reporting =
> +			hci_dev_test_flag(hdev, HCI_WIDE_BAND_SPEECH_ENABLED) ?
> +			ERR_DATA_REPORTING_ENABLED :
> +			ERR_DATA_REPORTING_DISABLED;
> +
> +		hci_req_add(req, HCI_OP_WRITE_DEF_ERR_DATA_REPORTING,
> +			    sizeof(cp), &cp);
> +	}
> +
> 	/* Set Suggested Default Data Length to maximum if supported */
> 	if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) {
> 		struct hci_cp_le_write_def_data_len cp;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 591e7477e925..3772acddda93 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -901,6 +901,37 @@ static void hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev,
> 	hdev->inq_tx_power = rp->tx_power;
> }
> 
> +static void hci_cc_read_def_err_data_reporting(struct hci_dev *hdev,
> +					       struct sk_buff *skb)
> +{
> +	struct hci_rp_read_def_err_data_reporting *rp = (void *)skb->data;
> +
> +	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
> +
> +	if (rp->status)
> +		return;
> +
> +	hdev->err_data_reporting = rp->err_data_reporting;
> +}
> +
> +static void hci_cc_write_def_err_data_reporting(struct hci_dev *hdev,
> +						struct sk_buff *skb)
> +{
> +	__u8 status = *((__u8 *)skb->data);
> +	struct hci_cp_write_def_err_data_reporting *cp;
> +
> +	BT_DBG("%s status 0x%2.2x", hdev->name, status);
> +
> +	if (status)
> +		return;
> +
> +	cp = hci_sent_cmd_data(hdev, HCI_OP_WRITE_DEF_ERR_DATA_REPORTING);
> +	if (!cp)
> +		return;
> +
> +	hdev->err_data_reporting = cp->err_data_reporting;
> +}
> +
> static void hci_cc_pin_code_reply(struct hci_dev *hdev, struct sk_buff *skb)
> {
> 	struct hci_rp_pin_code_reply *rp = (void *) skb->data;
> @@ -3302,6 +3333,14 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
> 		hci_cc_read_inq_rsp_tx_power(hdev, skb);
> 		break;
> 
> +	case HCI_OP_READ_DEF_ERR_DATA_REPORTING:
> +		hci_cc_read_def_err_data_reporting(hdev, skb);
> +		break;
> +
> +	case HCI_OP_WRITE_DEF_ERR_DATA_REPORTING:
> +		hci_cc_write_def_err_data_reporting(hdev, skb);
> +		break;
> +
> 	case HCI_OP_PIN_CODE_REPLY:
> 		hci_cc_pin_code_reply(hdev, skb);
> 		break;
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 1002c657768a..a648241c8973 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -107,6 +107,7 @@ static const u16 mgmt_commands[] = {
> 	MGMT_OP_READ_EXT_INFO,
> 	MGMT_OP_SET_APPEARANCE,
> 	MGMT_OP_SET_BLOCKED_KEYS,
> +	MGMT_OP_SET_WIDE_BAND_SPEECH,

Lets use MGMT_OP_SET_WIDEBAND_SPEECH like we have in the documentation.

> };
> 
> static const u16 mgmt_events[] = {
> @@ -850,6 +851,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
> 			settings |= MGMT_SETTING_STATIC_ADDRESS;
> 	}
> 
> +	if (hci_dev_test_flag(hdev, HCI_WIDE_BAND_SPEECH_ENABLED))
> +		settings |= MGMT_SETTING_WIDE_BAND_SPEECH;
> +
> 	return settings;
> }
> 
> @@ -3593,6 +3597,63 @@ static int set_blocked_keys(struct sock *sk, struct hci_dev *hdev, void *data,
> 				err, NULL, 0);
> }
> 
> +static int set_wide_band_speech(struct sock *sk, struct hci_dev *hdev,
> +				 void *data, u16 len)
> +{
> +	struct mgmt_mode *cp = data;
> +	int err;
> +	bool changed = false;
> +
> +	BT_DBG("request for %s", hdev->name);
> +
> +	if (!test_bit(HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED, &hdev->quirks))
> +		return mgmt_cmd_status(sk, hdev->id,
> +				       MGMT_OP_SET_WIDE_BAND_SPEECH,
> +				       MGMT_STATUS_NOT_SUPPORTED);
> +
> +	if (cp->val != 0x00 && cp->val != 0x01)
> +		return mgmt_cmd_status(sk, hdev->id,
> +				       MGMT_OP_SET_WIDE_BAND_SPEECH,
> +				       MGMT_STATUS_INVALID_PARAMS);
> +
> +	hci_dev_lock(hdev);
> +
> +	if (pending_find(MGMT_OP_SET_WIDE_BAND_SPEECH, hdev)) {
> +		err = mgmt_cmd_status(sk, hdev->id,
> +				      MGMT_OP_SET_WIDE_BAND_SPEECH,
> +				      MGMT_STATUS_BUSY);
> +		goto unlock;
> +	}
> +
> +	if (hdev_is_powered(hdev) &&
> +	    !!cp->val != hci_dev_test_flag(hdev,
> +					   HCI_WIDE_BAND_SPEECH_ENABLED)) {
> +		err = mgmt_cmd_status(sk, hdev->id,
> +				      MGMT_OP_SET_WIDE_BAND_SPEECH,
> +				      MGMT_STATUS_REJECTED);
> +		goto unlock;
> +	}
> +
> +	if (cp->val)
> +		changed = !hci_dev_test_and_set_flag(hdev,
> +						  HCI_WIDE_BAND_SPEECH_ENABLED);
> +	else
> +		changed = hci_dev_test_and_clear_flag(hdev,
> +						  HCI_WIDE_BAND_SPEECH_ENABLED);
> +
> +	err = send_settings_rsp(sk, MGMT_OP_SET_WIDE_BAND_SPEECH, hdev);
> +	if (err < 0)
> +		goto unlock;
> +
> +	if (changed)
> +		err = new_settings(hdev, sk);
> +
> +unlock:
> +
> +	hci_dev_unlock(hdev);
> +	return err;
> +}
> +
> static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
> 				         u16 opcode, struct sk_buff *skb)
> {
> @@ -6994,6 +7055,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
> 	{ set_phy_configuration,   MGMT_SET_PHY_CONFIGURATION_SIZE },
> 	{ set_blocked_keys,	   MGMT_OP_SET_BLOCKED_KEYS_SIZE,
> 						HCI_MGMT_VAR_LEN },
> +	{ set_wide_band_speech,	   MGMT_SETTING_SIZE },
> };
> 
> void mgmt_index_added(struct hci_dev *hdev)

Rest looks good. Thanks.

Regards

Marcel

