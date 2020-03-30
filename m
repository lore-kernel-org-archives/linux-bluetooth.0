Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C14EC43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 07:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8B520774
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 07:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UW2TSgn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgC3HFW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:05:22 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:57694 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgC3HFV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 03:05:21 -0400
Received: by mail-pj1-f74.google.com with SMTP id np3so14385000pjb.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 00:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=17WV3wHSshNZTqrKDBURt6jSVo9e/2Bnk+sFCCeMYic=;
        b=UW2TSgn33OQN+gAk46lO9oANxlnaofv7ViMHVOGmONBqjq4kqesSWI+4Eu4x4vApJv
         0EJ1IWupicaByS1brKvPcKhjX6iuzNpBP+DpJklQP5vUaV4mkE5ttObdeClgRpL39cv/
         GhRAW6PXdw80CR0SX9Ah8ST+kux+bu4TGFODqyk5DV+rSKHUCkqvY2yGkc/t9O5bp8zj
         rntAIazQPd6048zvl2WMuxjVGAFYXev6J7UbGp4AsXoeRyr2T/hCb+nBklDe3y6qovhy
         GVqhbvjavA9/W1cMVRRurPuTnYsnoOVtAOcsELZ7INenc/w4jYr7G17laEr6L4//EERa
         3loQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=17WV3wHSshNZTqrKDBURt6jSVo9e/2Bnk+sFCCeMYic=;
        b=WtI3RVyovErV7MEOsfuIOIS7dGAPblvwhW/3Nc4RLRTUYl/YCN2I8z67gQK7fJ+p7q
         K4EMQHI7semp0FRpvbD8G83aTGO6npitrqbHzPx3DBh/vWVhwIgi9O8odDFpW9TDTFZt
         9yEpQwgUrQk96wGQLsMx6S2vo8R/t2SH/j8+Rrnimh9s0D5dGN4rmvOvWYbZRFlzD9Tp
         gCp8jEFH6OAL4QpD2JtdVbWo75KszUuP6FETfmvRL2tAXDlhSrEWAU0lqZrP2jMTkrwp
         eGTdy1ujwuWO46oh8mrFuPKM4loJzEwCOwaaMa+81zvHrRMZCKwQsdVcRNRJdqHboyl0
         T5bQ==
X-Gm-Message-State: ANhLgQ2TqJTHqPSiTakzyNfITuOtA5rTrP6AoIsGIJfPWT+pdi4jVDMJ
        j9674OmgG5kFIvK6NzJPG4nF8sxwIi37QIm4oTYcwuJTm0mmV3kSwzGk9gY24Eej0wMoOU+LFfS
        a6uT8KjVDtOGepO4HHISgMmVsz85wrEgJTqgv5cLVyHCG6q5otudAC2hlERsotDBfdxbYQr9ShT
        o1feXqziT9tSQ=
X-Google-Smtp-Source: ADFU+vvSsEVpqdhf2NKBudC1DJ/mV+VxEtz7vH7UZPCdMVaYKYNxHWM0mqZJV8x3ggCKvER08RxfmViT95fvBkSlsQ==
X-Received: by 2002:a17:90a:fa86:: with SMTP id cu6mr14187158pjb.93.1585551920298;
 Mon, 30 Mar 2020 00:05:20 -0700 (PDT)
Date:   Mon, 30 Mar 2020 15:04:34 +0800
In-Reply-To: <20200330070438.37316-1-howardchung@google.com>
Message-Id: <20200330150424.Bluez.v1.2.I4fe5ed67f70011e5374e65929b845e13fe6ed59e@changeid>
Mime-Version: 1.0
References: <20200330070438.37316-1-howardchung@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [Bluez PATCH v1 2/6] core/advertising: Add support for LE set
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

