Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA96C33C99
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 09:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C232087F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 09:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="RjqY1w4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgAGJS5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:18:57 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:40552 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgAGJS5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 04:18:57 -0500
Received: by mail-lj1-f180.google.com with SMTP id u1so53912044ljk.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 01:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SSvUPMj9oDG8ge9IMvQUvFjkR/T0aekFdLjEpPzlIdY=;
        b=RjqY1w4RKtqKJ9t2SohNvFguXVyS1vEcvkWl23D/TnlMa35jQ9QI4g74GEZGvHFF0x
         9pgku1YHxozEjfDvlBHR2r4RQ84xJsLWqNZmJigNaCLG3aAaby9WSbschOQYHN20zm3n
         BYO+VlmbVhD5Epe/qtApI/MXb8eJOqCfKCmT7toBkzmhiEzJfI1G1NeCblDrAwk9k60F
         mp7ftlr5yTWdD+YfFBqX0q9mlPPw8hCTqKiNpf+0f+gxtsmJHkJ/oJA2Rwy4dh6dNqh3
         4g8pI8vpVB/OZPKZfFUItQhqzJafOlyPZ0jQBchblB2nJcIuGjzNu6cPJqNetsOFS9gB
         dEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SSvUPMj9oDG8ge9IMvQUvFjkR/T0aekFdLjEpPzlIdY=;
        b=Vw+tRCFDMdUzvqe0qSEQx0ZRujDxrwgR3S3S8UnlJV2MO0r/msd9yIF4rcM2SoVrZq
         Ook4FFAk+QmlEXVs/k0+ymV9P287p1jQQtRa6rOjfhlRvF/+nJtgPTTNxiI+z4XvWGlh
         pdcpVx/PBXLPOyMG/Efwaw+dFfZ6XdDG5M2jXOAlSZzQYdX3R18G5iWgcQpmQ6ll+Hts
         0+FpXZGXIqYrfaxGjmypzYZo0rgKd7f6yqr3e6o6627OaRaN2LGtf6gdtPk7+vm+n+fZ
         sJdSaRUYuTprl3R9Ct1T3MwPkq8OxxkRsx1kQ53ej/J/750sEOZ+lBO1Is/BYDqKc4HN
         x5BQ==
X-Gm-Message-State: APjAAAVHk5Uj/YdNzBljt8ZaqWEzNH8xhnRxvdtISTpkrK1Q9T+JDvbY
        SYlZw4wAKBZxOP9LpFeMv/NDK7vv0jU=
X-Google-Smtp-Source: APXvYqz0wTNf06EGNDqoU3K1Cg0bGOm7HgFzTAOW3ZNt/cMhLhf9vHdAA1fTjsCJUhAU4zV6/MrfHg==
X-Received: by 2002:a2e:9ec3:: with SMTP id h3mr14397518ljk.159.1578388735255;
        Tue, 07 Jan 2020 01:18:55 -0800 (PST)
Received: from tp480.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id d24sm30345292lfb.94.2020.01.07.01.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 01:18:54 -0800 (PST)
From:   Szymon Czapracki <szymon.czapracki@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Czapracki <szymon.czapracki@codecoup.pl>
Subject: [PATCH 2/8] monitor: Decode LE Periodic Advertising Sync Transfer Received Event
Date:   Tue,  7 Jan 2020 10:18:27 +0100
Message-Id: <20200107091833.14921-2-szymon.czapracki@codecoup.pl>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107091833.14921-1-szymon.czapracki@codecoup.pl>
References: <20200107091833.14921-1-szymon.czapracki@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Change-Id: I5a7c2d36ca5aee61441c2aab6adeb16058ab062f
---
 monitor/bt.h     | 14 ++++++++++++++
 monitor/packet.c | 27 +++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

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
index 64f75cf8e..76bb9f239 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -600,6 +600,12 @@ static void print_addr_type(const char *label, uint8_t addr_type)
 	case 0x01:
 		str = "Random";
 		break;
+	case 0x02:
+		str = "Public Identity Address";
+		break;
+	case 0x03:
+		str = "Random Identity Address";
+		break;
 	default:
 		str = "Reserved";
 		break;
@@ -9788,6 +9794,24 @@ static void le_chan_select_alg_evt(const void *data, uint8_t size)
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
+	print_addr_type("Address type:", evt->addr_type);
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
@@ -9871,6 +9895,9 @@ static const struct subevent_data le_meta_event_table[] = {
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

