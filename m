Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679D6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Mar 2022 01:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344011AbiCUBis (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Mar 2022 21:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344022AbiCUBin (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Mar 2022 21:38:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ECADD97A
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 18:37:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so11069572ybg.8
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 18:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YXq71nLjntbIYjgifO6/WWT8gp5pZBjfe99X73obMew=;
        b=VAA1ZDAvMSYm2jMxo+arQfNPGcQMlrSCd/DN6HGS5AtgWAo5tr+et0iw7iLf5LOGEp
         9lyj1o1oyDDihvMaeNtyuHxv1ZL5nYXgxP2B4bNbFUzlxKEhk+TE8Ff4snVbg28zk2aj
         IbjJ3taYFoDHwTKc4ZD9PjGKOPBuE6f0vjGFZPMFXx4BsbVaBFta1V6MkWmd0mpk+iJu
         tmSU+AZ5DBMI3Z96NuFs/XV6EdrMf4Wk4DPAmIpwiXCPDqa28260Ho3cAHMarNEuj79s
         GWuIYXJzqUiIbZ2O/kaKUwwgWb2OmNAVayVf8775QQna83eW023yTqIt980p/7TaxsrY
         DGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YXq71nLjntbIYjgifO6/WWT8gp5pZBjfe99X73obMew=;
        b=WXQvafaXoJjG+2JJpHURR+T1cAAl8D+0slvA+NkmkDtWE10Zd9Ly3Qsdezj1AVTAEP
         vU/Ic3LNWGoWQynzrwco5pn+aEgWSKa4+mC5H0D0x8VRp2q2Tx52yZi39CKhpA901AE3
         RNguh4ONn+GnrNm5md8U8fVch147ZcpK1ZK0DqD1YVMlTximX12zE2IwvQjPGDoUCpPX
         Vn2mGRV6ysrkE1YZ5EqBPR1kxiQjG5Q67kZcgGzt7ws4UQcrJ8IVK+ZxuM5oPebZSXT+
         8/dScM5f9bKqlKFGGTmIktLy2ZoA1vExLwrFXsdMAV9HuzahEsd4Wm3zA445kFSXbeZj
         gUkQ==
X-Gm-Message-State: AOAM532Nlc1rTFi2HVOtIkZtCThp3Z9LWUBKxRhwlJ30t0wSa5/EfbHS
        ncRFNafbKFDavZcLQIAPltuR38fLtGO9JA==
X-Google-Smtp-Source: ABdhPJwKYKmJ+O3Mbb2iOijDa4A8txzq0voseRw2rnD+dh7nO1Uzrp4Objnjjv1A05NdeeLU7UnXZrZDJ6L3PQ==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:e0cb:81c1:7b8f:ab9f])
 (user=mmandlik job=sendgmr) by 2002:a81:493:0:b0:2e5:a1de:9f1a with SMTP id
 141-20020a810493000000b002e5a1de9f1amr22477282ywe.88.1647826637817; Sun, 20
 Mar 2022 18:37:17 -0700 (PDT)
Date:   Sun, 20 Mar 2022 18:36:59 -0700
In-Reply-To: <20220320183445.BlueZ.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
Message-Id: <20220320183445.BlueZ.5.I53ad1b66c8f8a65e5950354cd20417d812ad9c72@changeid>
Mime-Version: 1.0
References: <20220320183445.BlueZ.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [BlueZ PATCH 5/9] monitor: Display AdvMonitor DeviceFound/Lost events
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Display information about MGMT_EV_ADV_MONITOR_DEVICE_FOUND and
MGMT_EV_ADV_MONITOR_DEVICE_LOST events in the btmon output.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 monitor/packet.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index b7431b57d..6f615f7ba 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -14103,6 +14103,31 @@ static void mgmt_device_found_evt(const void *data, uint16_t size)
 	print_eir(data + 14, size - 14, false);
 }
 
+static void mgmt_adv_monitor_device_found_evt(const void *data, uint16_t size)
+{
+	uint16_t handle = get_le16(data);
+	uint8_t address_type = get_u8(data + 8);
+	int8_t rssi = get_s8(data + 9);
+	uint32_t flags = get_le32(data + 10);
+	uint16_t data_len = get_le16(data + 14);
+
+	print_field("Handle: %u", handle);
+	mgmt_print_address(data + 2, address_type);
+	print_rssi(rssi);
+	mgmt_print_device_flags(flags);
+	print_field("Data length: %u", data_len);
+	print_eir(data + 16, size - 16, false);
+}
+
+static void mgmt_adv_monitor_device_lost_evt(const void *data, uint16_t size)
+{
+	uint16_t handle = get_le16(data);
+	uint8_t address_type = get_u8(data + 8);
+
+	print_field("Handle: %u", handle);
+	mgmt_print_address(data + 2, address_type);
+}
+
 static void mgmt_discovering_evt(const void *data, uint16_t size)
 {
 	uint8_t type = get_u8(data);
@@ -14414,6 +14439,10 @@ static const struct mgmt_data mgmt_event_table[] = {
 			mgmt_controller_suspend_evt, 1, true },
 	{ 0x002e, "Controller Resumed",
 			mgmt_controller_resume_evt, 8, true },
+	{ 0x002f, "Adv Monitor Device Found",
+			mgmt_adv_monitor_device_found_evt, 16, false },
+	{ 0x0030, "Adv Monitor Device Lost",
+			mgmt_adv_monitor_device_lost_evt, 9, true },
 	{ }
 };
 
-- 
2.35.1.894.gb6a874cedc-goog

