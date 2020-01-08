Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74DEC33C9E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 11:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3FC2077B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 11:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="cH9nmtcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgAHLsB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:48:01 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:44225 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgAHLsB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 06:48:01 -0500
Received: by mail-lj1-f180.google.com with SMTP id u71so2954892lje.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 03:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VTlDCnPfKcd55lI+sDtv699lS0147jpqjrgEWgI7T/k=;
        b=cH9nmtcQUTnVGNZzgqUhfe4qVQsUcctrAi7eEZPasa1u71Z1kxmw7De8vDPwt49kOj
         J+Zv9I/pXGdJT16I1MI5PK5mYZTyi0EVB1av/TWALHUuTOHRoS1gnbRIjDjNPZR2iMvf
         7WX6g+4nOIiDvSobTBNLpNyNnpvZiVzzlD2gsWLIZI9ENqIzvQK/xsyKzj65CTSp1lqz
         XLHL+mnSHEUbL1xfd4159HXTz9q7GrXnC6fOhd0cm7pzyKwWwnCoBEoWu3IvRllHCOas
         Kwu/DlYPTFDk875v4hRSpcp1+uZbmNEJvGLYGn4+RHMsMo/K7v4cexvBDZyku6jOJBhN
         lvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VTlDCnPfKcd55lI+sDtv699lS0147jpqjrgEWgI7T/k=;
        b=rANEWnPcVy0TIcKAazewmt39s9oMtDj1VPvis4uwj0BJ0Stb+nmS4kW1WB3prTu1Kt
         DOGjRmREau0/I2ufpXFp5FoNa+WX2/kIbbQIjDn1kwalodqgmhXJmDRCRa3x0MUS/r7l
         onJJbYLxn2B4RODf/WHyEwit1pGzeukkpMP6DYrX1NwBTkrnJCI5l42LpBBK7Yyd7jcv
         4SQhvuZSCDCQWqv90gxvb1R1Y4+Jd3VpU9Jl+qxTifQMmeeL0EP+L2H7b6I0E0r0uU0Z
         +j9NsdMLbfQ9b6j+j4AJ30zhtgn9V3nw9jn94awIp1q3HAejBWeHEzdFYGkQ8WcixMXP
         soHg==
X-Gm-Message-State: APjAAAXnBOTOKVCC/xBZQAzouAZaQBoUmVPzGKh04IAnBFuwbKjceSoB
        Gt0MpIpUf7Y8VBybz03LueMvO0tFwKY=
X-Google-Smtp-Source: APXvYqzMD/e9xconngQmhSMyPbursyRWJTxYUcv3n102ew1PaYZOckxZzDxYC77QhEh6YEiUMdc/tQ==
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr2477510lji.256.1578484077524;
        Wed, 08 Jan 2020 03:47:57 -0800 (PST)
Received: from tp480.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id e17sm1130645ljg.101.2020.01.08.03.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 03:47:57 -0800 (PST)
From:   Szymon Czapracki <szymon.czapracki@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Czapracki <szymon.czapracki@codecoup.pl>
Subject: [PATCH v2 2/8] monitor: Decode LE Periodic Advertising Sync Transfer Received Event
Date:   Wed,  8 Jan 2020 12:47:46 +0100
Message-Id: <20200108114752.133076-2-szymon.czapracki@codecoup.pl>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108114752.133076-1-szymon.czapracki@codecoup.pl>
References: <20200108114752.133076-1-szymon.czapracki@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 monitor/bt.h     | 14 ++++++++++++++
 monitor/packet.c | 21 +++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index ecf3782c9..e14c1771f 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3140,6 +3140,20 @@ struct bt_hci_evt_le_chan_select_alg {
 	uint8_t  algorithm;
 } __attribute__ ((packed));
 
+#define BT_HCI_EVT_LE_PER_ADV_SYNC_TRANS_REC		0x18
+struct bt_hci_evt_le_per_adv_sync_trans_rec {
+	uint8_t  status;
+	uint16_t handle;
+	uint16_t service_data;
+	uint16_t sync_handle;
+	uint8_t  sid;
+	uint8_t  addr_type;
+	uint8_t  addr[6];
+	uint8_t  phy;
+	uint16_t interval;
+	uint8_t  clock_accuracy;
+} __attribute__ ((packed));
+
 #define BT_HCI_ERR_SUCCESS			0x00
 #define BT_HCI_ERR_UNKNOWN_COMMAND		0x01
 #define BT_HCI_ERR_UNKNOWN_CONN_ID		0x02
diff --git a/monitor/packet.c b/monitor/packet.c
index 64f75cf8e..8e5219bef 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -9788,6 +9788,24 @@ static void le_chan_select_alg_evt(const void *data, uint8_t size)
 	print_field("Algorithm: %s (0x%2.2x)", str, evt->algorithm);
 }
 
+static void le_per_adv_sync_trans_rec_evt(const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_per_adv_sync_trans_rec *evt = data;
+
+	print_status(evt->status);
+	print_field("Handle: %d", evt->handle);
+	print_field("Connection handle: %d", evt->handle);
+	print_field("Service data: 0x%4.4x", evt->service_data);
+	print_field("Sync handle: %d", evt->sync_handle);
+	print_field("SID: 0x%2.2x", evt->sid);
+	print_peer_addr_type("Address type:", evt->addr_type);
+	print_addr("Addres:", evt->addr, evt->addr_type);
+	print_le_phy("PHY:", evt->phy);
+	print_field("Periodic advertising Interval: %.3f",
+							1.25 * evt->interval);
+	print_clock_accuracy(evt->clock_accuracy);
+}
+
 struct subevent_data {
 	uint8_t subevent;
 	const char *str;
@@ -9871,6 +9889,9 @@ static const struct subevent_data le_meta_event_table[] = {
 				le_scan_req_received_evt, 8, true},
 	{ 0x14, "LE Channel Selection Algorithm",
 				le_chan_select_alg_evt, 3, true},
+	{ 0x18, "LE Periodic Advertising Sync Transfer Received",
+					le_per_adv_sync_trans_rec_evt, 19,
+					true},
 	{ }
 };
 
-- 
2.24.1

