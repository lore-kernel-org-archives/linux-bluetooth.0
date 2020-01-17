Return-Path: <SRS0=B7Pc=3G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02836C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 17:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D436920728
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 17:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgAQRLi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jan 2020 12:11:38 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:36244 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgAQRLi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jan 2020 12:11:38 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id BB273CED0D;
        Fri, 17 Jan 2020 18:20:54 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] bluetooth: Refactoring mgmt cmd op_code structure
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200117034318.51409-1-alainm@chromium.org>
Date:   Fri, 17 Jan 2020 18:11:36 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <4AC68A7A-5F6F-48D1-8A5D-76718FAA200D@holtmann.org>
References: <20200117034318.51409-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This change refactors the way op-codes are managed in the kernel to
> facilitate easier cherry-picking  of features on downlevel kernels
> without incuring significant merge conflicts and op_code collisions.
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> ---
> 
> include/net/bluetooth/hci_core.h |   1 +
> net/bluetooth/hci_sock.c         |  14 +-
> net/bluetooth/mgmt.c             | 470 +++++++++++++++++++------------
> 3 files changed, 297 insertions(+), 188 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 89ecf0a80aa1..0cc2f7c11c3a 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1494,6 +1494,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
> #define HCI_MGMT_UNCONFIGURED	BIT(3)
> 
> struct hci_mgmt_handler {
> +	unsigned short op_code;
> 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
> 		     u16 data_len);
> 	size_t data_len;
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 3ae508674ef7..4e121607d644 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -1490,9 +1490,9 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
> 	void *buf;
> 	u8 *cp;
> 	struct mgmt_hdr *hdr;
> -	u16 opcode, index, len;
> +	u16 opcode, index, len, i;
> 	struct hci_dev *hdev = NULL;
> -	const struct hci_mgmt_handler *handler;
> +	const struct hci_mgmt_handler *handler = NULL;
> 	bool var_len, no_hdev;
> 	int err;
> 
> @@ -1533,16 +1533,18 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
> 		}
> 	}
> 
> -	if (opcode >= chan->handler_count ||
> -	    chan->handlers[opcode].func == NULL) {
> +	for (i = 0; i < chan->handler_count; ++i) {
> +		if (opcode == chan->handlers[i].op_code)
> +			handler = &chan->handlers[i];
> +	}
> +
> +	if (!handler || !handler->func) {
> 		BT_DBG("Unknown op %u", opcode);
> 		err = mgmt_cmd_status(sk, index, opcode,
> 				      MGMT_STATUS_UNKNOWN_COMMAND);
> 		goto done;
> 	}
> 
> -	handler = &chan->handlers[opcode];
> -
> 	if (!hci_sock_test_flag(sk, HCI_SOCK_TRUSTED) &&
> 	    !(handler->flags & HCI_MGMT_UNTRUSTED)) {
> 		err = mgmt_cmd_status(sk, index, opcode,
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 0dc610faab70..7baf9a2809a8 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -40,73 +40,271 @@
> #define MGMT_VERSION	1
> #define MGMT_REVISION	15
> 
> -static const u16 mgmt_commands[] = {
> -	MGMT_OP_READ_INDEX_LIST,
> -	MGMT_OP_READ_INFO,
> -	MGMT_OP_SET_POWERED,
> -	MGMT_OP_SET_DISCOVERABLE,
> -	MGMT_OP_SET_CONNECTABLE,
> -	MGMT_OP_SET_FAST_CONNECTABLE,
> -	MGMT_OP_SET_BONDABLE,
> -	MGMT_OP_SET_LINK_SECURITY,
> -	MGMT_OP_SET_SSP,
> -	MGMT_OP_SET_HS,
> -	MGMT_OP_SET_LE,
> -	MGMT_OP_SET_DEV_CLASS,
> -	MGMT_OP_SET_LOCAL_NAME,
> -	MGMT_OP_ADD_UUID,
> -	MGMT_OP_REMOVE_UUID,
> -	MGMT_OP_LOAD_LINK_KEYS,
> -	MGMT_OP_LOAD_LONG_TERM_KEYS,
> -	MGMT_OP_DISCONNECT,
> -	MGMT_OP_GET_CONNECTIONS,
> -	MGMT_OP_PIN_CODE_REPLY,
> -	MGMT_OP_PIN_CODE_NEG_REPLY,
> -	MGMT_OP_SET_IO_CAPABILITY,
> -	MGMT_OP_PAIR_DEVICE,
> -	MGMT_OP_CANCEL_PAIR_DEVICE,
> -	MGMT_OP_UNPAIR_DEVICE,
> -	MGMT_OP_USER_CONFIRM_REPLY,
> -	MGMT_OP_USER_CONFIRM_NEG_REPLY,
> -	MGMT_OP_USER_PASSKEY_REPLY,
> -	MGMT_OP_USER_PASSKEY_NEG_REPLY,
> -	MGMT_OP_READ_LOCAL_OOB_DATA,
> -	MGMT_OP_ADD_REMOTE_OOB_DATA,
> -	MGMT_OP_REMOVE_REMOTE_OOB_DATA,
> -	MGMT_OP_START_DISCOVERY,
> -	MGMT_OP_STOP_DISCOVERY,
> -	MGMT_OP_CONFIRM_NAME,
> -	MGMT_OP_BLOCK_DEVICE,
> -	MGMT_OP_UNBLOCK_DEVICE,
> -	MGMT_OP_SET_DEVICE_ID,
> -	MGMT_OP_SET_ADVERTISING,
> -	MGMT_OP_SET_BREDR,
> -	MGMT_OP_SET_STATIC_ADDRESS,
> -	MGMT_OP_SET_SCAN_PARAMS,
> -	MGMT_OP_SET_SECURE_CONN,
> -	MGMT_OP_SET_DEBUG_KEYS,
> -	MGMT_OP_SET_PRIVACY,
> -	MGMT_OP_LOAD_IRKS,
> -	MGMT_OP_GET_CONN_INFO,
> -	MGMT_OP_GET_CLOCK_INFO,
> -	MGMT_OP_ADD_DEVICE,
> -	MGMT_OP_REMOVE_DEVICE,
> -	MGMT_OP_LOAD_CONN_PARAM,
> -	MGMT_OP_READ_UNCONF_INDEX_LIST,
> -	MGMT_OP_READ_CONFIG_INFO,
> -	MGMT_OP_SET_EXTERNAL_CONFIG,
> -	MGMT_OP_SET_PUBLIC_ADDRESS,
> -	MGMT_OP_START_SERVICE_DISCOVERY,
> -	MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
> -	MGMT_OP_READ_EXT_INDEX_LIST,
> -	MGMT_OP_READ_ADV_FEATURES,
> -	MGMT_OP_ADD_ADVERTISING,
> -	MGMT_OP_REMOVE_ADVERTISING,
> -	MGMT_OP_GET_ADV_SIZE_INFO,
> -	MGMT_OP_START_LIMITED_DISCOVERY,
> -	MGMT_OP_READ_EXT_INFO,
> -	MGMT_OP_SET_APPEARANCE,
> -	MGMT_OP_SET_BLOCKED_KEYS,
> +static int read_version(struct sock *sk, struct hci_dev *hdev, void *data,
> +			u16 data_len);
> +static int read_commands(struct sock *sk, struct hci_dev *hdev, void *data,
> +			 u16 data_len);

<snip>

I do not see this as a good thing. This massive list of forward declarations is not acceptable. That makes the code unmaintainable for upstream.

Regards

Marcel

