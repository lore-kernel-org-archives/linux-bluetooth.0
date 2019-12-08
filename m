Return-Path: <SRS0=rPQ+=Z6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FE0C43603
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Dec 2019 09:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646F3206D5
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Dec 2019 09:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfLHJ4X convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 Dec 2019 04:56:23 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:38423 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfLHJ4X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 Dec 2019 04:56:23 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 15B97CED0A;
        Sun,  8 Dec 2019 11:05:32 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [RFC BlueZ v2] Adding support for blocking keys and mgmt tests.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191205175132.123632-1-alainm@chromium.org>
Date:   Sun, 8 Dec 2019 10:56:21 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E8D34C1B-653C-4D73-9353-2C44431D2A8D@holtmann.org>
References: <20191205175132.123632-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> Here's a newer version with most of your feedback addressed.  Others
> responses sent inline in the v1.

commit message here please.

> 
> ---
> lib/mgmt.h       | 17 +++++++++++++
> src/adapter.c    | 65 +++++++++++++++++++++++++++++++++++++++++++++++-
> unit/test-mgmt.c | 33 ++++++++++++++++++++++++
> 3 files changed, 114 insertions(+), 1 deletion(-)

Comments for the reviewer here.

> 
> diff --git a/lib/mgmt.h b/lib/mgmt.h
> index 570dec997..3e2e26e68 100644
> --- a/lib/mgmt.h
> +++ b/lib/mgmt.h
> @@ -583,6 +583,23 @@ struct mgmt_cp_set_phy_confguration {
> 	uint32_t	selected_phys;
> } __packed;
> 
> +#define MGMT_OP_SET_BLOCKED_KEYS	0x0046
> +
> +#define HCI_BLOCKED_KEY_TYPE_LINKKEY	0x00
> +#define HCI_BLOCKED_KEY_TYPE_LTK		0x01
> +#define HCI_BLOCKED_KEY_TYPE_IRK		0x02
> +
> +struct mgmt_blocked_key_info {
> +	uint8_t type;
> +	uint8_t val[16];
> +} __packed;
> +
> +struct mgmt_cp_set_blocked_keys {
> +	uint16_t key_count;
> +	struct mgmt_blocked_key_info keys[0];
> +} __packed;
> +#define MGMT_OP_SET_BLOCKED_KEYS_SIZE 0
> +
> 
> #define MGMT_EV_CMD_COMPLETE		0x0001
> struct mgmt_ev_cmd_complete {
> diff --git a/src/adapter.c b/src/adapter.c
> index cef25616f..f571961bb 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -99,10 +99,25 @@
> #define DISTANCE_VAL_INVALID	0x7FFF
> #define PATHLOSS_MAX		137
> 
> +/**
> + * These are known security keys that have been compromised.
> + * If this grows or there are needs to be platform specific, it is
> + * conceivable that these could be read from a config file.
> +*/ 
> +static const struct mgmt_blocked_key_info blocked_keys [] = {
> +	// Google Titan Security Keys

Lets use /* */ comment style here.

> +	{ HCI_BLOCKED_KEY_TYPE_LTK, {0xbf, 0x01, 0xfb, 0x9d, 0x4e, 0xf3, 0xbc, 0x36,
> +		 					0xd8, 0x74, 0xf5, 0x39, 0x41, 0x38, 0x68, 0x4c}},
> +	{ HCI_BLOCKED_KEY_TYPE_IRK, {0xa5, 0x99, 0xba, 0xe4, 0xe1, 0x7c, 0xa6, 0x18,
> +					0x22, 0x8e, 0x07, 0x56, 0xb4, 0xe8, 0x5f, 0x01}},

Lets indent both the same.

> +};
> +
> static DBusConnection *dbus_conn = NULL;
> 
> static bool kernel_conn_control = false;
> 
> +static bool kernel_blocked_keys_supported = false;
> +
> static GList *adapter_list = NULL;
> static unsigned int adapter_remaining = 0;
> static bool powering_down = false;
> @@ -8568,6 +8583,40 @@ static bool set_static_addr(struct btd_adapter *adapter)
> 	return false;
> }
> 
> +static void set_blocked_keys_complete(uint8_t status, uint16_t length,
> +					const void *param, void *user_data)
> +{
> +	struct btd_adapter *adapter = user_data;
> +
> +	if (status != MGMT_STATUS_SUCCESS) {
> +		btd_error(adapter->dev_id,
> +				"Failed to set blocked keys: %s (0x%02x)",
> +				mgmt_errstr(status), status);
> +		return;
> +	}
> +
> +	DBG("Successfully set blocked keys for index %u", adapter->dev_id);
> +}
> +
> +static bool set_blocked_keys(struct btd_adapter *adapter)
> +{
> +	uint8_t buffer[sizeof(struct mgmt_cp_set_blocked_keys) +
> +					sizeof(blocked_keys)] = { 0 };
> +	struct mgmt_cp_set_blocked_keys *cp =
> +					(struct mgmt_cp_set_blocked_keys *)buffer;
> +	int i;
> +
> +	cp->key_count = G_N_ELEMENTS(blocked_keys);
> +	for (i = 0; i < cp->key_count; ++i) {
> +		cp->keys[i].type = blocked_keys[i].type;
> +		memcpy(cp->keys[i].val, blocked_keys[i].val, sizeof(cp->keys[i].val));
> +	}
> +
> +	return mgmt_send(mgmt_master, MGMT_OP_SET_BLOCKED_KEYS, adapter->dev_id,
> +					sizeof(buffer),	buffer,	set_blocked_keys_complete,
> +					adapter, NULL);
> +}
> +
> static void read_info_complete(uint8_t status, uint16_t length,
> 					const void *param, void *user_data)
> {
> @@ -8795,6 +8844,12 @@ static void read_info_complete(uint8_t status, uint16_t length,
> 
> 	set_name(adapter, btd_adapter_get_name(adapter));
> 

I would do this separate.

	if (kernel_blocked_keys_supported) {
		btd_warn(“Kernel doesn’t support blocking of vulnerable keys”);
		goto failed;
	}


> +	if (kernel_blocked_keys_supported && !set_blocked_keys(adapter)) {
> +		btd_error(adapter->dev_id,
> +			"Failed to set blocked keys for index %u", adapter->dev_id);
> +		goto failed;
> +	}
> +
> 	if (main_opts.pairable &&
> 			!(adapter->current_settings & MGMT_SETTING_BONDABLE))
> 		set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x01);
> @@ -8972,9 +9027,17 @@ static void read_commands_complete(uint8_t status, uint16_t length,
> 	for (i = 0; i < num_commands; i++) {
> 		uint16_t op = get_le16(rp->opcodes + i);
> 
> -		if (op == MGMT_OP_ADD_DEVICE) {
> +		switch (op){
> +		case MGMT_OP_ADD_DEVICE:
> 			DBG("enabling kernel-side connection control");
> 			kernel_conn_control = true;
> +			break;
> +		case MGMT_OP_SET_BLOCKED_KEYS:
> +			DBG("kernel supports the set_blocked_keys op");
> +			kernel_blocked_keys_supported = true;
> +			break;
> +		default:
> +			break;
> 		}
> 	}
> }
> diff --git a/unit/test-mgmt.c b/unit/test-mgmt.c
> index c67678b9a..d73c03f61 100644
> --- a/unit/test-mgmt.c
> +++ b/unit/test-mgmt.c
> @@ -256,6 +256,33 @@ static const struct command_test_data command_test_3 = {
> 	.rsp_status = MGMT_STATUS_INVALID_INDEX,
> };
> 
> +static const unsigned char invalid_key_buffer[] =
> + { 0x01, 0x02 };
> +
> +static const struct command_test_data command_test_set_blocked_keys1 = {
> + .opcode = MGMT_OP_SET_BLOCKED_KEYS,
> + .index = MGMT_INDEX_NONE,
> + .cmd_data = invalid_key_buffer,
> + .cmd_size = sizeof(invalid_key_buffer),
> + .rsp_data = NULL,
> + .rsp_size = 0,
> + .rsp_status = MGMT_STATUS_INVALID_PARAMS,
> +};
> +

Indentation is still off here.

> +static const unsigned char valid_keys_buffer1[] =
> + { 0x01, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
> + 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f };
> +
> +static const struct command_test_data command_test_set_blocked_keys2 = {
> + .opcode = MGMT_OP_SET_BLOCKED_KEYS,
> + .index = MGMT_INDEX_NONE,
> + .cmd_data = valid_keys_buffer1,
> + .cmd_size = sizeof(valid_keys_buffer1),
> + .rsp_data = NULL,
> + .rsp_size = 0,
> + .rsp_status = MGMT_STATUS_SUCCESS,
> +};
> +
> static const unsigned char event_index_added[] =
> 				{ 0x04, 0x00, 0x01, 0x00, 0x00, 0x00 };
> 
> @@ -441,6 +468,12 @@ int main(int argc, char *argv[])
> 	g_test_add_data_func("/mgmt/response/2", &command_test_3,
> 								test_response);
> 
> +	g_test_add_data_func("/mgmt/command/set_blocked_keys1",
> +						&command_test_set_blocked_keys1, test_command);
> +
> +	g_test_add_data_func("/mgmt/command/set_blocked_keys2",
> +						&command_test_set_blocked_keys2, test_command);
> +
> 	g_test_add_data_func("/mgmt/event/1", &event_test_1, test_event);
> 	g_test_add_data_func("/mgmt/event/2", &event_test_1, test_event2);

Regards

Marcel

