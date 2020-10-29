Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AD5C55178
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 10:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E65A2076E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 10:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k9eXKy6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgJ2KKE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 06:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgJ2KKC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 06:10:02 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40D3C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 03:10:01 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id w16so1657585ply.15
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 03:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=YO/jkQ1Xvo2Pu21jszB9gfiRu/kN1DHdIpxIq7BUWuc=;
        b=k9eXKy6+qxU1yQDJFKC3LWpgI+hJlBrVKphtQqCMF4frZlJFKDhWwMqqoSJ1+jkTBM
         7BVNZ9JXLCjDK/1+18dLTpGcicgaSDnD+njg5Z7fqmjJuwgkGPXzUo9MUg1hTaMBfG+i
         02EByLnTrhEvUNUKILh+K/yOjpbLvLicuUNB9iq7eLm5rptyOM2Sj2DdWdw5po+o2E5k
         UpYf3Gvz1V13QEn7/9ZVjltrREb+6c0lYS/bF4/OJngAxbQVh07gnVhs+Z947/jkk8OM
         bNDUbNxqrhfXtdFDynujgzXvn9VKrh5EYaJsO73zbZmF3HMxeNorVwahiYAnRNmEbGhM
         ANPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YO/jkQ1Xvo2Pu21jszB9gfiRu/kN1DHdIpxIq7BUWuc=;
        b=JjHXADAK1MRLxjrN0s1+Ryb5TjQRKpzzXFBa7ljxDtfsUIrgaExFheBkcznqMtWLaF
         9j0PUUl3zNWqce01nAhq8q/wvNJVKW2WEWRFlrtZB/AcM0EMPh9iKXlF7yQ8up9Tpb8s
         v746mee8Ou7dj/WaNtj5MKrsG6X5Occ3oxBWdDYDaLEgsRYwMmlRS2OwAc7+/C72l3Fv
         wV5JIDX/MCWrcm4OixKgxe3kwRd8rN5ZcwOJzvT9m1YOiTpJeFkQT7kioSOs6qAEphsm
         PfauVJ68mYQYj/KvHTij+jmDSKUBxj/iO3MN3ANzEQD9QKH/vrrvfQBwjnYEkqaEMGmt
         K9sg==
X-Gm-Message-State: AOAM532thTkHj9AVqi7949KgAex3YVrXekJ/sv/sQY31RJop+deswc+x
        unEdGjk6c2oGHHZgogT5uXaBFhtK5+jpHDf/P2CcAJ5h1PwrUeqXprUpJEV+sTPKL2UcWDWZqNH
        y4QrV1lHIJ+j6mI1kbUMrsxtzkg7xm83aZ+JCqmXfiXmFhHblISbBqFwFpZvaKwzsRbkrBPv8Gj
        Zs+meucov7SeQ=
X-Google-Smtp-Source: ABdhPJzHpexJHMKPvKC92yvhH7SEdCiI3T2io2Hr7LKKdU4IyioofEZZjWPIxam7CjASLUYNsdFOOzTVQ3vr90bOnQ==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a17:90b:f85:: with SMTP id
 ft5mr1128pjb.1.1603966201148; Thu, 29 Oct 2020 03:10:01 -0700 (PDT)
Date:   Thu, 29 Oct 2020 18:09:45 +0800
In-Reply-To: <20201029180756.BlueZ.1.I3e9cc07cf60d04d69c8045c442b6cf9f0c3292e7@changeid>
Message-Id: <20201029180756.BlueZ.3.I949a055ddf471aba93424ebaa7eb65c2d7f58682@changeid>
Mime-Version: 1.0
References: <20201029180756.BlueZ.1.I3e9cc07cf60d04d69c8045c442b6cf9f0c3292e7@changeid>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [BlueZ PATCH 3/3] monitor: Decode Remove ADV Monitor
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, luiz.dentz@gmail.com, mcchou@chromium.org,
        mmandlik@chromium.org, Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for Remove Advertisement Monitor MGMT command and event.

@ MGMT Command: Remove Advertisement Monitor (0x0053) plen 2
	Handle: 1
@ MGMT Event: Advertisement Monitor Added (0x002c) plen 2
        Handle: 1
@ MGMT Event: Command Complete (0x0001) plen 5
      Remove Advertisement Monitor (0x0053) plen 2
        Status: Success (0x00)
        Handle: 1

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 monitor/packet.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index b3a6ed24d5fc..dcbed9f0f287 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -13232,6 +13232,22 @@ static void mgmt_add_adv_monitor_patterns_rsp(const void *data, uint16_t size)
 	print_field("Handle: %d", handle);
 }
 
+static void mgmt_remove_adv_monitor_patterns_cmd(const void *data,
+								uint16_t size)
+{
+	uint16_t handle = get_le16(data);
+
+	print_field("Handle: %d", handle);
+}
+
+static void mgmt_remove_adv_monitor_patterns_rsp(const void *data,
+								uint16_t size)
+{
+	uint16_t handle = get_le16(data);
+
+	print_field("Handle: %d", handle);
+}
+
 struct mgmt_data {
 	uint16_t opcode;
 	const char *str;
@@ -13469,6 +13485,9 @@ static const struct mgmt_data mgmt_command_table[] = {
 	{ 0x0052, "Add Advertisement Monitor",
 				mgmt_add_adv_monitor_patterns_cmd, 1, false,
 				mgmt_add_adv_monitor_patterns_rsp, 2, true},
+	{ 0x0053, "Remove Advertisement Monitor",
+				mgmt_remove_adv_monitor_patterns_cmd, 2, true,
+				mgmt_remove_adv_monitor_patterns_rsp, 2, true},
 	{ }
 };
 
@@ -13880,6 +13899,13 @@ static void mgmt_adv_monitor_added_evt(const void *data, uint16_t size)
 	print_field("Handle: %d", handle);
 }
 
+static void mgmt_adv_monitor_removed_evt(const void *data, uint16_t size)
+{
+	uint16_t handle = get_le16(data);
+
+	print_field("Handle: %d", handle);
+}
+
 static void mgmt_controller_suspend_evt(const void *data, uint16_t size)
 {
 	uint8_t state = get_u8(data);
@@ -14011,6 +14037,8 @@ static const struct mgmt_data mgmt_event_table[] = {
 			mgmt_device_flags_changed_evt, 15, true },
 	{ 0x002b, "Advertisement Monitor Added",
 			mgmt_adv_monitor_added_evt, 2, true },
+	{ 0x002c, "Advertisement Monitor Added",
+			mgmt_adv_monitor_removed_evt, 2, true },
 	{ 0x002d, "Controller Suspended",
 			mgmt_controller_suspend_evt, 1, true },
 	{ 0x002e, "Controller Resumed",
-- 
2.29.1.341.ge80a0c044ae-goog

