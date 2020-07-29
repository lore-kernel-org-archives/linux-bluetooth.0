Return-Path: <SRS0=Z40G=BI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDBFC433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jul 2020 01:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41BB520672
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jul 2020 01:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="elU2pB4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbgG2Bzs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jul 2020 21:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgG2Bzs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jul 2020 21:55:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57872C061794
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2020 18:55:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s15so1848680pgc.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2020 18:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:from:to:cc:subject:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mXBex8ZJ0TICmkQfoN/8o5iy8D64BOqXLNddA9sjDq8=;
        b=elU2pB4w6l8NTNQ8tqJ2kEzg4xDmwAL8+1maA4Slfxu7cyz9VngP0uJtJpIznk+2fv
         0k5MqcPTC40I2HxxMITY36t7bCF0lTuFnQensM6ZL9CjGD7Jntl97FUGJWEnMCYelcbZ
         cKycQHPv1TpPtzwfua/HQJQJFW4EgZQ+OwE+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:subject:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mXBex8ZJ0TICmkQfoN/8o5iy8D64BOqXLNddA9sjDq8=;
        b=THaBB8R6osE6HjDZqTHmwYyySp3cCiADrsKTbAwVJhAFCnDp4DnLbPhyA2T6tnD0Q3
         RQilZdAS1Y2pJr/Tzpk8E6D6oSisjjo/p2J0sfFi4D2/omuHxKhr+Nbn8lWAweG14Iyj
         Wo75XfmQYRw7syoGErIqWzXOKzPtXtI40d2oycYs5JGS+r6ykx3+rHY92NaBVYTeEvua
         eUpAQX0LG+cPPWv2kwaOhinMjtS9gZ2bF9q0AYWpO0GS83ozm42ZykugrKXJn6BlBpG3
         lCpK7YvdgkJiwLmKYU2V5wQryYdVKDfMiQAjPJo4X3e/W2yvpxBw9+cXGbkBTvpVQEQr
         q04g==
X-Gm-Message-State: AOAM530flA4dJLeyyc6a32cJudwjJ2eIO0QCg1WRWeFk8rFiiusYGJG1
        m031UMlwyBDMZG1E++d5A1zjPA==
X-Google-Smtp-Source: ABdhPJz9LYxlcp5C/TfScjy1fOZGGswITMRqpZXXvhMArKghXZPtYx8J39bcSAgRUuzzTekt20JaYQ==
X-Received: by 2002:a63:7c42:: with SMTP id l2mr27943153pgn.35.1595987747888;
        Tue, 28 Jul 2020 18:55:47 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id lr1sm371128pjb.27.2020.07.28.18.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 18:55:47 -0700 (PDT)
Message-ID: <5f20d723.1c69fb81.6d882.1d20@mx.google.com>
X-Google-Original-Message-ID: <20200728185415.RFC Bluez.1.I14a96397d181666c124e1c413b834428faf3db7a@changeid>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [RFC Bluez PATCH 1/3] mgmt: Add controller suspend and resume events
Date:   Tue, 28 Jul 2020 18:55:38 -0700
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200729015540.1848987-1-abhishekpandit@chromium.org>
References: <20200729015540.1848987-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the controller suspend and resume events.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

 lib/mgmt.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index a800bcab4..46d894ae9 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -772,6 +772,7 @@ struct mgmt_ev_device_connected {
 #define MGMT_DEV_DISCONN_TIMEOUT	0x01
 #define MGMT_DEV_DISCONN_LOCAL_HOST	0x02
 #define MGMT_DEV_DISCONN_REMOTE		0x03
+#define MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND	0x05
 
 #define MGMT_EV_DEVICE_DISCONNECTED	0x000C
 struct mgmt_ev_device_disconnected {
@@ -959,6 +960,17 @@ struct mgmt_ev_adv_monitor_removed {
 	uint16_t monitor_handle;
 }  __packed;
 
+#define MGMT_EV_CONTROLLER_SUSPEND		0x002d
+struct mgmt_ev_controller_suspend {
+	uint8_t suspend_state;
+} __packed;
+
+#define MGMT_EV_CONTROLLER_RESUME		0x002e
+struct mgmt_ev_controller_resume {
+	struct mgmt_addr_info addr;
+	uint8_t wake_reason;
+} __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
@@ -1088,6 +1100,8 @@ static const char *mgmt_ev[] = {
 	"Device Flags Changed",
 	"Advertisement Monitor Added",			/* 0x002b */
 	"Advertisement Monitor Removed",
+	"Controller Suspend",
+	"Controller Resume",
 };
 
 static const char *mgmt_status[] = {
-- 
2.28.0.rc0.142.g3c755180ce-goog

