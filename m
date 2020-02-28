Return-Path: <SRS0=e/tT=4Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127EBC3F2D0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 08:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E466624695
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 08:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgB1IGS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:06:18 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:46785 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgB1IGS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Feb 2020 03:06:18 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5D6C5CECF5;
        Fri, 28 Feb 2020 09:15:43 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v1 3/3] bluetooth: Enable erroneous data reporting if wbs
 is supported
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200227182938.110670-4-alainm@chromium.org>
Date:   Fri, 28 Feb 2020 09:06:16 +0100
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <E57D43F4-D927-44C0-A8CF-C27652505B7D@holtmann.org>
References: <20200227182938.110670-1-alainm@chromium.org>
 <20200227182938.110670-4-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This change will enable erroneous data reporting if wide band speech is
> supported by the controller as indicated by the
> HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED quirk.
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> ---
> 
> include/net/bluetooth/hci.h |  7 +++++++
> net/bluetooth/hci_core.c    | 33 +++++++++++++++++++++++++++++++++
> 2 files changed, 40 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index b214c4358d1c..807fd40bb358 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1095,6 +1095,13 @@ struct hci_rp_read_inq_rsp_tx_power {
> 	__s8     tx_power;
> } __packed;
> 
> +#define HCI_OP_WRITE_DEFAULT_ERRONEOUS_DATA_REPORTING	0x0c5b
> +	#define ERRONEOUS_DATA_REPORTING_DISABLED	0x00
> +	#define ERRONEOUS_DATA_REPORTING_ENABLED	0x01
> +struct hci_cp_write_default_erroneous_data_reporting {
> +	__u8     erroneous_data_reporting;
> +} __packed;
> +

So I realized that in monitor/bt.h I also used the full name, but inside the kernel code it feels way too long and creates harder to read code.

My proposal is HCI_OP_READ_DEF_ERR_DATA_REPORTING and HCI_OP_WRITE_DEF_ERR_DATA_REPORTING.

You might realize that I included the read command here as well. So first, we need to read the current value of the controller if supported and then also start tracking changes to it. You will find examples in hci_event.c and how that is done. Store the current value in hci_dev.

I also realized that we should only advertise Wideband speech support if this command is actually supported. So that you might need to fix as well.

> #define HCI_OP_SET_EVENT_MASK_PAGE_2	0x0c63
> 
> #define HCI_OP_READ_LOCATION_DATA	0x0c64
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 1ca7508b6ca7..19afb85ad399 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1382,6 +1382,29 @@ static void hci_dev_get_bd_addr_from_property(struct hci_dev *hdev)
> 	bacpy(&hdev->public_addr, &ba);
> }
> 
> +static int hci_write_default_erroneous_data_req(struct hci_request *req,
> +						unsigned long opt)
> +{
> +	struct hci_cp_write_default_erroneous_data_reporting cp = {};
> +
> +	cp.erroneous_data_reporting = (__u8)opt;
> +	hci_req_add(req, HCI_OP_WRITE_DEFAULT_ERRONEOUS_DATA_REPORTING,
> +		    sizeof(cp), &cp);
> +	return 0;
> +}
> +
> +static void hci_write_default_erroneous_data(struct hci_dev *hdev,
> +					     __u8 erroneous_data_reporting)
> +{
> +	int err = __hci_req_sync(hdev,
> +				 hci_write_default_erroneous_data_req,
> +				 erroneous_data_reporting, HCI_CMD_TIMEOUT,
> +				 NULL);
> +	if (err) {
> +		BT_ERR("HCI_OP_WRITE_DEFAULT_ERRONEOUS_DATA_REPORTING failed");
> +	}
> +}
> +
> static int hci_dev_do_open(struct hci_dev *hdev)
> {
> 	int ret = 0;
> @@ -1547,6 +1570,16 @@ static int hci_dev_do_open(struct hci_dev *hdev)
> 		set_bit(HCI_UP, &hdev->flags);
> 		hci_sock_dev_event(hdev, HCI_DEV_UP);
> 		hci_leds_update_powered(hdev, true);
> +
> +		/* If the controller supports wide_band_speech, enable erroneous
> +		 * data reporting.
> +		 */
> +		if (test_bit(HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED,
> +			     &hdev->quirks)) {
> +			hci_write_default_erroneous_data(hdev,
> +					      ERRONEOUS_DATA_REPORTING_ENABLED);
> +		}
> +
> 		if (!hci_dev_test_flag(hdev, HCI_SETUP) &&
> 		    !hci_dev_test_flag(hdev, HCI_CONFIG) &&
> 		    !hci_dev_test_flag(hdev, HCI_UNCONFIGURED) &&

Don’t do this in hci_dev_do_open. You want to read the current value in the init procedure and change it if needed. This is similar to Secure Connections and other values that we only allow to change while the controller is down.

Regards

Marcel

