Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C419C43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 08:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549A82073B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 08:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ibzYmoFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgC3IEQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:04:16 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:51487 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbgC3IEQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 04:04:16 -0400
Received: by mail-pg1-f201.google.com with SMTP id p13so14236466pgk.18
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 01:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=axUhYrK/4mE+ijb5p6RZuq2PLRRjrVtRjO2FiDK+tvg=;
        b=ibzYmoFl9N24F7rKcDhChsIlb474+3mXUiovL8oAoSDpw9typ2Nw72GjIB0jVv0QtW
         rmD+sHMJ+lMwGPGxhog9tLvf+XNZTf3Uhl2KcFeO+mgbgFSa8WELK+0LlL7aqb5FRari
         Bb3g3I+IrKdH51Z189AJPe7OnJb4oP5vSnB8vAYUZw49MqrSJ5tIKGGiCPE5xsy6E/HI
         GpU4l7BRqGGrKq5XbklibeL5dBVLumGLavux+M6Xq+b6f9isl5nIsKv2/gymts+Y9E//
         mhEY6lXTvmNBYA5qI09NUGQ4hI/BkxwvlJqPXrXBvftULSfjILjeiCEUO4EbOiN7KpzN
         RykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=axUhYrK/4mE+ijb5p6RZuq2PLRRjrVtRjO2FiDK+tvg=;
        b=DsYblU5J9lLxmrjOCYr4lBWTFJgI/pKsGVP9+nCXRMdKUAP4rqvzuVXQJS+KeooU6c
         pmFMJEr/lUbtwEiKtKTSP8D7PvRaBZfAgHkpimyJMW7b69ga64a6wYqqsHrmQdzUq7wD
         8m2evf48sLLbf9WV/xAKdCkLBHluj8DARcEG0daoeb4WuaEK1jxWfQZboPZ/vCBGQfv4
         AHpff60cEaOFc2Gcy4NLZnHd46Z2nnVa6yfxFcR11hNMmF0FoSMuy7dwkrKAIxdb/GKq
         KwDS3eAfqxEadVS+D8LM9k8RkP7/uSrAeo0Vpe2u5h+iUQrj3PLOsOtDKg0dRoMAmww8
         eRHQ==
X-Gm-Message-State: ANhLgQ1kKlfxpEnaZnZZ2ccTYr1FA0IsPYmVyfEMr5hOUUTxYCJscT6B
        3IpQDw3HW5P+WJkHW2OJfh/3ULHL7I2C9fkmiFJbfqzsEvf03ia5mDbCRguS3uOfuhut4peSfwx
        c5gVqiUKLcPp8S4Aex33h9HI78q7+v0bJBalX0JyrqBQGi7p52ISoj7Cgpq1D56ohHDWc8c/h6t
        kEw37kzrv65gU=
X-Google-Smtp-Source: ADFU+vt7EWP7WVaZVOyojGAQAezT65jZ7njFtq5pCByynRBvK7MkTcMpSDiNsn3rnyNy/gm4usNI6QumxaRthcAMlA==
X-Received: by 2002:a17:90a:21ce:: with SMTP id q72mr14135128pjc.160.1585555455117;
 Mon, 30 Mar 2020 01:04:15 -0700 (PDT)
Date:   Mon, 30 Mar 2020 16:03:53 +0800
In-Reply-To: <20200330080357.96989-1-howardchung@google.com>
Message-Id: <20200330160343.Bluez.v2.2.I4fe5ed67f70011e5374e65929b845e13fe6ed59e@changeid>
Mime-Version: 1.0
References: <20200330080357.96989-1-howardchung@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [Bluez PATCH v2 2/6] core/advertising: Add support for LE set
 adverting interval
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Implement a new dbus method to set advertising intervals.
The advertising inervals are sent through a new mgmt method with
the opcode MGMT_OP_SET_ADVERTISING_INTERVALS to bluetooth kernel
subsystem.

Signed-off-by: Howard Chung <howardchung@google.com>
---

Changes in v2: None

 src/advertising.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index 45ff19fa0..444969f04 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1342,6 +1342,92 @@ static const GDBusPropertyTable properties[] = {
 	{ }
 };
 
+static void set_advertising_intervals_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	DBusMessage *msg = user_data;
+	DBusMessage *reply;
+
+	switch (status) {
+	case MGMT_STATUS_SUCCESS:
+		reply = dbus_message_new_method_return(msg);
+		break;
+	case MGMT_STATUS_REJECTED:
+		reply = btd_error_failed(
+				msg, "A non-BLE device should not advertise!");
+		break;
+	case MGMT_STATUS_INVALID_PARAMS:
+		reply = btd_error_invalid_args(msg);
+		break;
+	case MGMT_STATUS_BUSY:
+		reply = btd_error_busy(msg);
+		break;
+	default:
+		reply = btd_error_failed(
+				msg, "failed to set advertising intervals");
+	}
+
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+	dbus_message_unref(msg);
+}
+
+static int adapter_set_advertising_intervals(struct btd_adv_manager *manager,
+						DBusMessage *msg,
+						uint16_t min_interval_ms,
+						uint16_t max_interval_ms)
+{
+	struct mgmt_cp_set_advertising_intervals cp;
+
+	memset(&cp, 0, sizeof(cp));
+
+	/* Convert milli-seconds to multiples of 0.625 ms which are used
+	 * in kernel.
+	 */
+	cp.min_interval = min_interval_ms / ADVERTISING_INTERVAL_UNIT_TIME;
+	cp.max_interval = max_interval_ms / ADVERTISING_INTERVAL_UNIT_TIME;
+
+	btd_info(manager->mgmt_index,
+			"Set Advertising Intervals: 0x%04x, 0x%04x",
+			cp.min_interval, cp.max_interval);
+
+	if (mgmt_send(manager->mgmt,
+			MGMT_OP_SET_ADVERTISING_INTERVALS, manager->mgmt_index,
+			sizeof(cp), &cp, set_advertising_intervals_callback,
+			dbus_message_ref(msg), NULL) > 0) {
+		return true;
+	}
+
+	return false;
+}
+
+static DBusMessage *set_advertising_intervals(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct btd_adv_manager *manager = user_data;
+	const char *sender = dbus_message_get_sender(msg);
+	dbus_uint16_t min_interval_ms, max_interval_ms;
+
+	DBG("set_advertising_intervals: sender %s", sender);
+
+	if (!dbus_message_get_args(msg, NULL,
+					DBUS_TYPE_UINT16, &min_interval_ms,
+					DBUS_TYPE_UINT16, &max_interval_ms,
+					DBUS_TYPE_INVALID)) {
+		return btd_error_invalid_args(msg);
+	}
+
+	/* The adapter is not required to be powered to set advertising
+	 * intervals. Hence, just go ahead to set the intervals.
+	 */
+	if (!adapter_set_advertising_intervals(manager, msg, min_interval_ms,
+						max_interval_ms)) {
+		return btd_error_failed(msg,
+					"failed to set advertising intervals");
+	}
+
+	return NULL;
+}
+
 static const GDBusMethodTable methods[] = {
 	{ GDBUS_ASYNC_METHOD("RegisterAdvertisement",
 					GDBUS_ARGS({ "advertisement", "o" },
@@ -1351,6 +1437,10 @@ static const GDBusMethodTable methods[] = {
 						GDBUS_ARGS({ "service", "o" }),
 						NULL,
 						unregister_advertisement) },
+	{ GDBUS_ASYNC_METHOD("SetAdvertisingIntervals",
+				GDBUS_ARGS({"min_interval_ms", "q"},
+						{"max_interval_ms", "q"}),
+				NULL, set_advertising_intervals)},
 	{ }
 };
 
-- 
2.26.0.rc2.310.g2932bb562d-goog

