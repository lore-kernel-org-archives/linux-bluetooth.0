Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D4EC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 18:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1C4220738
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 18:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VTfsXh9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgHUSBQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgHUSBO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 14:01:14 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05501C061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 11:01:10 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a79so1440141pfa.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 11:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Khob2YLsczWPVhqP71ZFU0FcOyus14dQulSnyUMpZU=;
        b=VTfsXh9HapOpKLuD0Fxxt0Smw0lYAGLy/xMmbg8TfhtCJzz8z88UpIe4vH5cW2+vQD
         pGwsKqx524N13PhnmOcsWm0lc45E5EuLfk5QfL5uiBB3MltjB2rmf2j8Um+6IIyIESDg
         ZD9y4ed7YytQUDap+nyHGPTCdQOS/mY2EJWvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Khob2YLsczWPVhqP71ZFU0FcOyus14dQulSnyUMpZU=;
        b=UdSixIk9EwZZGakvdqZLRy1kTTQrEGTNodUjVSVvvgmscYC/o/tHvw3Suy/sXHKFDV
         +SmksC87U+XlqpB/Zg+tOq9wzo5Ui2tdCFTPLQ2cPR2z85J2+cf4469t0RWyWsaWMZPQ
         VG2Ys+Xv1q1zcPuLYxLitRTB8nWMzhiZzeQYVU3zLY0FfyizTVHf69H/pstQVPbnvlHQ
         5MfhAweoighPWkv3hRp4SKdTIt7gIpxdqgL12V9EpnoammKqjONlvBP70VbZUNafe2pv
         NiaZKDYZMuxTKCDPA4ld5zqy1PGWQSkQcU2IqEtn/5uUPLeDcbhnKHriGnOJ+YwqZtib
         RVIw==
X-Gm-Message-State: AOAM5322/6deaJfTr7IPKk2jOjvABuMqfm5lNf7pcISAXASxjGtKd54m
        fEn/BuxaA+ntoyQwxPgnPGrvPFyD7K8meg==
X-Google-Smtp-Source: ABdhPJw/NWcZGUtStCjgBqmTjX8KpgNNBg0ZOXuk71ln/JsvjY6m4AW7NstPVQYmdlObSWmDRn3Kfw==
X-Received: by 2002:aa7:9467:: with SMTP id t7mr3322402pfq.64.1598032869268;
        Fri, 21 Aug 2020 11:01:09 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id s22sm3075558pfh.16.2020.08.21.11.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 11:01:08 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH BlueZ v2] device: Fix race condition between device connection and disconnection
Date:   Fri, 21 Aug 2020 11:01:06 -0700
Message-Id: <20200821180106.21048-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When Connect() is called and waiting for return, dev_disconnected may be
called due to MGMT_EV_DEVICE_DISCONNECTED event from kernel. In that
case reply to client that the connection failed otherwise the dbus
method will timeout because bluetoothd never replies.

Tested with simulation of a lot of Connect() to bluetooth devices and
check that error is returned from bluetoothd rather than dbus timeout
when this race condition happens.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---
 src/device.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/device.c b/src/device.c
index 7b7808405..f59b6c1d0 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3006,6 +3006,7 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)
 void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 {
 	struct bearer_state *state = get_state(device, bdaddr_type);
+	DBusMessage *reply;
 
 	if (!state->connected)
 		return;
@@ -3020,6 +3021,18 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 		device->disconn_timer = 0;
 	}
 
+	/* This could be executed while the client is waiting for Connect() but
+	 * att_connect_cb has not been invoked.
+	 * In that case reply the client that the connection failed.
+	 */
+	if (device->connect) {
+		DBG("connection removed while Connect() is waiting reply");
+		reply = btd_error_failed(device->connect, "Disconnected early");
+		g_dbus_send_message(dbus_conn, reply);
+		dbus_message_unref(device->connect);
+		device->connect = NULL;
+	}
+
 	while (device->disconnects) {
 		DBusMessage *msg = device->disconnects->data;
 
-- 
2.26.2

