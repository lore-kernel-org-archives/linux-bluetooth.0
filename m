Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964E8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 20:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D39360FF2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 20:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbhI0USy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbhI0USx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Sep 2021 16:18:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184ECC061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 13:17:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p20-20020a25d814000000b005b6a75a370cso2371778ybg.14
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 13:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9QqyaGF5JbGqnPKRFDn9L/txayGrCgZHqvLhXfmbP9E=;
        b=ovOC0zNyqsygqy4pfrfqYUif+H9OBv9b3NlGRi07npWH22eNcoubwrpFOvRjavitQG
         E1ddZeobeG8McmKQd4GpeM2eOPW79DS+Kl99ZD54sBLnTWqW2Up4MIedUPWoLAx3lfdr
         nR1uTnjBxHaW80gtFVNJKlRkwvYuCq31/rshxKJe+fSlgadOWy9B62iKpNJprhASw3Ji
         Gt1nAkXSdsgMU8Nn6ABCE2nF7M21pxOmldGr+zpxh3BmItJrkbeN0xXCR+Fl5npExdAv
         hdeXduGhNKsV3NkpmTVqlhHBUxnlMEcOC91As2Ba+VrRqj/ykzvKA358mZnX9HhKB9Xs
         vyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9QqyaGF5JbGqnPKRFDn9L/txayGrCgZHqvLhXfmbP9E=;
        b=miKUbBvTx9FJgi4sy0nFiyOfmkYq8F85gTRuw/DBTMEY6JO8fI9jRyozlAHgvBi8s6
         RPsNfWXiHqxzBRNewx71+YCE1+54EDoBcimjoMK7JBd/IrZ/gYpc64hYmxPUMANMxbwZ
         kvsM1j4n+aDeQ3Qq9qn5FRQvsOF8mv9EPmntSchI2SG7RNaqh1EEHzk/6/irlrCtKF9A
         PlgKKUlrorFzM3653JKZJk5iNSJsEhDfCKM0i+rhJgeF2RFdfwxD9puQCVnI1/zFOk2W
         by8nYfmMNXUsqeQ3pJOxE2xXhzSqHxzCqwD7lccbEc+rPkfZNsOf+D7vONzutwkWyqwJ
         MWUg==
X-Gm-Message-State: AOAM5320VBcVFqE5fe7LERxW0p3yWYp7hKibxEugO0abKABwJPaqSamF
        3HiSvjxTKB2fzCrB8kyYHAQZxUW62xe0cw==
X-Google-Smtp-Source: ABdhPJwofqbkkZoO0w6D9cbnsKmVp2d6kAsA1yoYYBolU5RpRfZrHNu5HGJWdOMrLlPF6fOlj9CJviFYL7+jpQ==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:8f29:89eb:dfbc:3b00])
 (user=mmandlik job=sendgmr) by 2002:a25:5956:: with SMTP id
 n83mr2108922ybb.194.1632773834349; Mon, 27 Sep 2021 13:17:14 -0700 (PDT)
Date:   Mon, 27 Sep 2021 13:16:56 -0700
In-Reply-To: <20210927201657.593569-1-mmandlik@google.com>
Message-Id: <20210927131456.BlueZ.v1.2.Ied4afb8c4c882e573f4a23670fc060cbc3e319c9@changeid>
Mime-Version: 1.0
References: <20210927201657.593569-1-mmandlik@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [BlueZ PATCH v1 2/3] lib: Add definition of AdvMonitor Tracking event
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds a definition of the Advertisement Monitor Device
Tracking event.

---

 lib/mgmt.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 0a6349321..f23041f96 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -1014,6 +1014,13 @@ struct mgmt_ev_controller_resume {
 	uint8_t wake_reason;
 } __packed;
 
+#define MGMT_EV_ADV_MONITOR_TRACKING	0x002f
+struct mgmt_ev_adv_monitor_tracking {
+	uint16_t monitor_handle;
+	uint8_t monitor_state;
+	struct mgmt_addr_info addr;
+} __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
@@ -1152,6 +1159,7 @@ static const char *mgmt_ev[] = {
 	"Advertisement Monitor Removed",
 	"Controller Suspend",
 	"Controller Resume",
+	"Advertisement Monitor Device Tracking",	/* 0x002f */
 };
 
 static const char *mgmt_status[] = {
-- 
2.33.0.685.g46640cef36-goog

