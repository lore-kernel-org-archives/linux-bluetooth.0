Return-Path: <SRS0=Q1DV=EF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D357C00A89
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Oct 2020 23:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1B8221EB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Oct 2020 23:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RcvBDUuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgJ3XKG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Oct 2020 19:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgJ3XKG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Oct 2020 19:10:06 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCD9C0613D5
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 16:10:06 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mp12so30841pjb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 16:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A7yfMyMLahsjiks9ekmRwm/hsXUIAXDcBQ5d9craIoU=;
        b=RcvBDUuY7bH7Gh30MWhfQol/B6VI9nkqRTAdQKLOhVINgAcWmZ0vzIEvMGOD/HW8Ia
         ThISYjxbAfhRZFG9k4P7GcTg7sdrvF7w40YBnnhMfnisoWKoUFBaeCNUURK8T0ZqOPMl
         YrWa2hZAzISBuvsatd9ePRh5dBvZztMOYH0Kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A7yfMyMLahsjiks9ekmRwm/hsXUIAXDcBQ5d9craIoU=;
        b=LH1feepavgTWPXirQXUSmXeViKoz42RIl31fNbe8XKpB76D9bkiJMOIPoJbF2NGaLC
         U6O2msWgLPzOgcHF+vVyf2rZb7GcFjX5TSUxsHPhH5h2R1usRuNFwF4DCh0tx3fCyzna
         CPHZdqmJNx1H2m6mfIqBnrbA6r3OEyP2+MILfocHHT98umnglnqzMdQorVgQefY9OHOg
         9UaJeL4qoclZovOm3WwNVSpnIZQFTjlYDP4zhsSEa+KaHhDMYfaH1i8vchFn5NcMXYFt
         6LgUSdzZu/Ytw9mg2COrDwKWAbk31rMGwJxZW+uJ9z/whK595zNlEdS0xI+9mam15/6f
         qgBg==
X-Gm-Message-State: AOAM533OpFI6lXKIqHmNZquMGtSB9aefxiZcZkmC1PKmQJYsJ+IcDE7Q
        zTdJek2iGa0HiKkMFCm/rM3Ea0g08JO5Jw==
X-Google-Smtp-Source: ABdhPJwo1/3bOddPUsx/UfxOUE3qHw617wrseS9Hy0sAEbWlpMf7SQBnT8GwmT2mpK3NJZDpfRBEtA==
X-Received: by 2002:a17:90b:3d6:: with SMTP id go22mr5512300pjb.214.1604099405143;
        Fri, 30 Oct 2020 16:10:05 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id w187sm6744371pfb.93.2020.10.30.16.10.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2020 16:10:04 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v1] adapter: Fix a crash caused by lingering discovery client pointer
Date:   Fri, 30 Oct 2020 16:09:54 -0700
Message-Id: <20201030160833.BlueZ.v1.1.Ia45f3edc48142d9db0dc4b315c84ab60a149697f@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This cleans up the lingering pointer, adapter->client, during powering
off the adapter. The crash occurs when a D-Bus client set Powered
property to false and immediately calls StopDiscovery() when there is
ongoing discovery. As a part of powering off the adapter,
adapter->discovery_list gets cleared, and given that adapter->client
refers to one of the clients in adapter->discovery_list, adapter->client
should be cleared along with it.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

 src/adapter.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index c0053000a..74bfb0448 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1507,8 +1507,10 @@ static void discovery_free(void *user_data)
 		client->discovery_filter = NULL;
 	}
 
-	if (client->msg)
+	if (client->msg) {
 		dbus_message_unref(client->msg);
+		client->msg = NULL;
+	}
 
 	g_free(client->owner);
 	g_free(client);
@@ -5301,6 +5303,19 @@ static void free_service_auth(gpointer data, gpointer user_data)
 
 static void remove_discovery_list(struct btd_adapter *adapter)
 {
+	DBusMessage *msg;
+
+	if (adapter->client) {
+		msg = adapter->client->msg;
+		if (msg) {
+			g_dbus_send_message(dbus_conn, btd_error_busy(msg));
+			dbus_message_unref(msg);
+			adapter->client->msg = NULL;
+		}
+
+		adapter->client = NULL;
+	}
+
 	g_slist_free_full(adapter->set_filter_list, discovery_free);
 	adapter->set_filter_list = NULL;
 
-- 
2.26.2

