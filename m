Return-Path: <SRS0=o7la=44=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4579C10F27
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 14:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AE6222C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 14:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OLAXECts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgCKOTH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:19:07 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:41777 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729838AbgCKOTG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Mar 2020 10:19:06 -0400
Received: by mail-vk1-f195.google.com with SMTP id q8so567616vka.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2020 07:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KgINo+FmXFS9/VCjRJK2I8u1n1ONpikVJE8dHnJjrFY=;
        b=OLAXECtsRVVMsBgBTGT2DVPQfugQKOnFF/7EgpqgzJQinX+oVvta1WPPTn3Uc8WWtN
         qHsFQJQEhfVVqRR3yfHNUFTTF5XScMTPw7rLQVJfB2CqeMwrMLcuhaPlm3x+jvGKWIk2
         QjkBILSMqXYvmYxxdjrfsSdjyEqEJYt+9Ucgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KgINo+FmXFS9/VCjRJK2I8u1n1ONpikVJE8dHnJjrFY=;
        b=Sbe3H5RYroPbjozZVKIBk0hJvo+c+bTrkOPvJr+Ba+kOZm1roHUvhjWzYPz6tnmCzu
         stPyMQeR91n6bNedEnuK/JAEXgRl58kjPBR6FqdcRWvSrS8LO1cCwh1XSsgPtNGqIfF4
         qwW4y+lnRjJL+wZmQUhzEyiDw4Z2vHhQEQOkQcY0yNOAlrgGfOjbta7/zAyYdpo2R+Or
         v4DuJfJPklmGg7fuNGTISYG1A48P0h8I0qC9DIK14TgkWjR/nCINl/zaHWIOJY/2kFsl
         ZYi+H/G//+FFP+4WTF+DoDYUVZoppimfOO6e7/klAVvCOjb6/s0GlFd/SbZikqNEevi9
         sqqA==
X-Gm-Message-State: ANhLgQ0LEj34FgjdFy/iMLVl0B2UYlfa2qWzj2f7RzJjle2iS53JonDq
        tK7+1mRw66t3slPMPLYwCeN5+ZpbLP8=
X-Google-Smtp-Source: ADFU+vuNcUQcmIzQ45cGWMWurE1JJ2gcnVh6sdxmjzwZGGdsHrURfYu1A0TUeYNhpsMtBVNe5iBtDw==
X-Received: by 2002:a05:6122:1184:: with SMTP id x4mr1976244vkn.62.1583936343403;
        Wed, 11 Mar 2020 07:19:03 -0700 (PDT)
Received: from alain.c.googlers.com.com (57.152.190.35.bc.googleusercontent.com. [35.190.152.57])
        by smtp.gmail.com with ESMTPSA id 4sm12484428vsk.16.2020.03.11.07.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 07:19:02 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v1] bluetooth: fix off by one in err_data_reporting cmd masks.
Date:   Wed, 11 Mar 2020 14:18:57 +0000
Message-Id: <20200311141857.197369-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change fixes the off by one error in the erroneous command bit
masks which can lead to the erroneous data commands being sent to a
controller that doesn't support them.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 net/bluetooth/hci_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9ce98762559b..196edc039b8e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -603,7 +603,7 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
 	if (hdev->commands[8] & 0x01)
 		hci_req_add(req, HCI_OP_READ_PAGE_SCAN_ACTIVITY, 0, NULL);
 
-	if (hdev->commands[18] & 0x02)
+	if (hdev->commands[18] & 0x04)
 		hci_req_add(req, HCI_OP_READ_DEF_ERR_DATA_REPORTING, 0, NULL);
 
 	/* Some older Broadcom based Bluetooth 1.2 controllers do not
@@ -844,7 +844,7 @@ static int hci_init4_req(struct hci_request *req, unsigned long opt)
 	/* Set erroneous data reporting if supported to the wideband speech
 	 * setting value
 	 */
-	if (hdev->commands[18] & 0x04) {
+	if (hdev->commands[18] & 0x08) {
 		bool enabled = hci_dev_test_flag(hdev,
 						 HCI_WIDEBAND_SPEECH_ENABLED);
 
-- 
2.25.1.481.gfbce0eb801-goog

