Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA19C433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 23:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39DC461077
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 23:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhDSXgt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Apr 2021 19:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhDSXgs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Apr 2021 19:36:48 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FDBC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 16:36:16 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id h15so6584166pfv.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 16:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wLLNnqiqcs/lATj65OpNjSTqcU7M8vh3ILTJJ7yqOQ0=;
        b=PYiHX7SMVxnQjsxJCv125H9lnAq8Q7JKSM0S6xy4AAp0b4tTEr++oEWy0D2k2j5m4Z
         HwuOxb18z4FqyxrxSclX8xhYJkhlsRNs/quVJjSlHyDr9S9/HcqjjqziFZ7pukFUhB50
         7I6OG45AvdfAhzbUzDBiqADQixHbyJLvZoj0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wLLNnqiqcs/lATj65OpNjSTqcU7M8vh3ILTJJ7yqOQ0=;
        b=OAxCfoEGu0Ihur0aGNyysBeaWMF/Z/SqXN1Zda/BQN+biDEjcqbKnpMPbz5t0OIl/6
         sNwQ+a7UFUIw6T+jjPh+/20SM7pe27uHaevzKgBm8klAADliuHID5sjWnjZR+hkWy2Ee
         vMbb+ySI4O4zWTw9KITJcRS+H8Zhmr//C5hFaGBD77JX9/U39OSG7DtETFzIZZJZ90mC
         lF7RbD/8FkW/N7cbKMF2enxxHQeusvEj0lCJQUqcIBW8uPF+aDj6fxmGMpu9vWF3ZXzi
         n2KTxCmcDKlk2y0UP4X+iU9aWBNrWksVRFfqR5OSUW1Mdx39DQTzjk12AabnqvJZklqZ
         7aGw==
X-Gm-Message-State: AOAM532z5TgcS5XBAvh7MosJ4ZsV/hJAJ1d/Y123D7kdMdvIEtPK3AvH
        6N0hvlRn25JNKFY+Zdr2qrSTIHPouVGJCw==
X-Google-Smtp-Source: ABdhPJzLvUyMQkg9oTvywLhs/aSVDpZHuRjB4KIjq7D96tIyQjp5cSwq+8NZo3KBN79swqFZVOebJA==
X-Received: by 2002:a65:620d:: with SMTP id d13mr14059811pgv.85.1618875375497;
        Mon, 19 Apr 2021 16:36:15 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7527:8700:7408:d424])
        by smtp.gmail.com with UTF8SMTPSA id oa9sm440043pjb.44.2021.04.19.16.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 16:36:15 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v1] device: Reply to connect request if SDP search failed
Date:   Mon, 19 Apr 2021 16:36:02 -0700
Message-Id: <20210419163518.BlueZ.v1.1.Id327043128b54d359c7ad4bf44ec21179c7d3213@changeid>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SDP request can be initiated during BR/EDR connection. This fixes a
missing reply to the method call to prevent generic error message for
no reply.

The following test steps were performed:
(1) Put Bose QC35 into pairing mode, start scanning on bluetoothctl
(2) Turn off the headphones and connect to the headphones
(3) Verify that error should returns immediately to bluetoothctl
---

 src/device.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/device.c b/src/device.c
index df440ce09..516ffe2e7 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4966,6 +4966,7 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 {
 	struct browse_req *req = user_data;
 	struct btd_device *device = req->device;
+	DBusMessage *reply;
 	GSList *primaries;
 	char addr[18];
 
@@ -5009,6 +5010,18 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 						DEVICE_INTERFACE, "UUIDs");
 
 send_reply:
+	/* If SDP search failed during an ongoing connection request, we should
+	 * reply to D-Bus method call.
+	 */
+	if (err < 0 && device->connect) {
+		DBG("SDP failed during connection");
+		reply = btd_error_failed(device->connect,
+						strerror(-err));
+		g_dbus_send_message(dbus_conn, reply);
+		dbus_message_unref(device->connect);
+		device->connect = NULL;
+	}
+
 	device_svc_resolved(device, BROWSE_SDP, BDADDR_BREDR, err);
 }
 
-- 
2.31.1.368.gbe11c130af-goog

