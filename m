Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21423C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jan 2022 13:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245125AbiA1Nhw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jan 2022 08:37:52 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:40268 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244552AbiA1Nhw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jan 2022 08:37:52 -0500
Received: from smtpclient.apple (p4ff9fc34.dip0.t-ipconnect.de [79.249.252.52])
        by mail.holtmann.org (Postfix) with ESMTPSA id DE00CCED37;
        Fri, 28 Jan 2022 14:37:50 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v2 2/2] adapter: Remove custom MGMT send/reply timeout
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220128020735.3779202-2-luiz.dentz@gmail.com>
Date:   Fri, 28 Jan 2022 14:37:50 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <8C6BE164-39E5-4215-BF6D-4DFC9D6123D0@holtmann.org>
References: <20220128020735.3779202-1-luiz.dentz@gmail.com>
 <20220128020735.3779202-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This removes the custom MGMT send/reply timeout since bt_mgmt itself
> can handle them itself and it actually start the timer only when the
> command is actually sent to the kernel rather then when it is queued.
> 
> Fixes: https://github.com/bluez/bluez/issues/275
> ---
> src/adapter.c | 162 ++++----------------------------------------------
> 1 file changed, 10 insertions(+), 152 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 9772e843a..72e98ba0a 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -311,15 +311,6 @@ struct btd_adapter {
> 
> 	struct oob_handler *oob_handler;
> 
> -	unsigned int load_ltks_id;
> -	unsigned int load_ltks_timeout;
> -
> -	unsigned int confirm_name_id;
> -	unsigned int confirm_name_timeout;
> -
> -	unsigned int pair_device_id;
> -	unsigned int pair_device_timeout;
> -
> 	unsigned int db_id;		/* Service event handler for GATT db */
> 
> 	bool is_default;		/* true if adapter is default one */
> @@ -4134,21 +4125,6 @@ static void load_link_keys(struct btd_adapter *adapter, GSList *keys,
> 							adapter->dev_id);
> }
> 
> -static bool load_ltks_timeout(gpointer user_data)
> -{
> -	struct btd_adapter *adapter = user_data;
> -
> -	btd_error(adapter->dev_id, "Loading LTKs timed out for hci%u",
> -							adapter->dev_id);
> -
> -	adapter->load_ltks_timeout = 0;
> -
> -	mgmt_cancel(adapter->mgmt, adapter->load_ltks_id);
> -	adapter->load_ltks_id = 0;
> -
> -	return FALSE;
> -}
> -
> static void load_ltks_complete(uint8_t status, uint16_t length,
> 					const void *param, void *user_data)
> {
> @@ -4160,11 +4136,6 @@ static void load_ltks_complete(uint8_t status, uint16_t length,
> 				adapter->dev_id, mgmt_errstr(status), status);
> 	}
> 
> -	adapter->load_ltks_id = 0;
> -
> -	timeout_remove(adapter->load_ltks_timeout);
> -	adapter->load_ltks_timeout = 0;
> -
> 	DBG("LTKs loaded for hci%u", adapter->dev_id);
> }
> 
> @@ -4237,27 +4208,13 @@ static void load_ltks(struct btd_adapter *adapter, GSList *keys)
> 		}
> 	}
> 
> -	adapter->load_ltks_id = mgmt_send(adapter->mgmt,
> -					MGMT_OP_LOAD_LONG_TERM_KEYS,
> -					adapter->dev_id, cp_size, cp,
> -					load_ltks_complete, adapter, NULL);
> -
> -	g_free(cp);
> -
> -	if (adapter->load_ltks_id == 0) {
> +	if (!mgmt_send_timeout(adapter->mgmt, MGMT_OP_LOAD_LONG_TERM_KEYS,
> +			adapter->dev_id, cp_size, cp, load_ltks_complete,
> +			adapter, NULL, 2))
> 		btd_error(adapter->dev_id, "Failed to load LTKs for hci%u",
> 							adapter->dev_id);
> -		return;
> -	}
> 
> -	/*
> -	 * This timeout handling is needed since the kernel is stupid
> -	 * and forgets to send a command complete response. However in
> -	 * case of failures it does send a command status.
> -	 */

please don’t loose these comments. They are important because of the kernel bugs we had.

Regards

Marcel

