Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B686C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Apr 2021 18:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006E86115B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Apr 2021 18:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhDBSA0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Apr 2021 14:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbhDBSAW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Apr 2021 14:00:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C0BC0613E6
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Apr 2021 11:00:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 71so6977366ybl.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Apr 2021 11:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=I2qj66MqrwQOGlrRH/iaHJTRUaGSw0TijteQ14aop7E=;
        b=GEcZSvLhypIBDwRd55CfTY9JwSol6ATzEX44OhFnoHURaPoeVoQPGOBtOOqOj88S5Q
         GCRQrGCli2nqtMmZ/h9Thmn0Dqas+xxyutfiBj8zZejlA73lF9Ef9YkrsTuK7O1jM7FH
         9ibMKOC2b6RCAkTIq+HmBlwS4q+prxt92JahRJ0BWZRZR4saCnp2LFaqzFWE4qiOA6Yv
         sr4BLnuh0Yoj3WU5iYB9Z7yThOxwHtu6IhwxkrbSRumZV+emoVmpfgjYl4ltx52vJViJ
         1+1/nk+FeDlA9cuRCrII9zUfaAeL6Tqvwns+Shzc5v4iEG6W/hu9mydWYwJ/2vhSKJqf
         fKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=I2qj66MqrwQOGlrRH/iaHJTRUaGSw0TijteQ14aop7E=;
        b=ZNrwC5SqyW670wyS0j5NQMYPC8H6Tunjxq9cbLBIrIop/7A51S2hQ0NL8BvuWz/6at
         K0GgvGmSWFK9BA/YXrP01F114ujl06hWWM+AgKldSBFQ+pfWlldcXPMU3U0+IxRns9F3
         tExFlRDNjz25tnqiqoC+oiTzXAVut8hRSB4k/Pv19sbqrOPdURqRaSWqdwcPI5xGgDZG
         9TuUakjPsBLMoMCUjXXjyiFYq7htcjYKmwddpa18DAmh6ki67hL1mCr6ZOeU9iT+iW7Y
         hENQtgURYE1bdly/mPLK55Og5arOwgWpiNPIZbAV8uWUXvWME3uhyGx1QRx2Df1QHmJ/
         82mQ==
X-Gm-Message-State: AOAM532vDDub8XnUXmkt+BqfEZ9QaQzFVW0eVTQR2jYa+eRIW/t4eENC
        86aI61dbEsRkNJfpf0PlskfgGvsiYtacoG6pz6wovfbAvzLJJCQN7wNLZALnGiw80U0ZqeF9Jll
        KO+sBMqI4Lw3aoliAAqENqbSt16Qm961aiAiE3YtedZM4IMNG3XtmFdHzjI5zCwyFkr+qTIrPMA
        HP
X-Google-Smtp-Source: ABdhPJyrqUGVGpP+vcwZ1JvygTJrYpvp/Z8tZ4Z40pnJDwHAPxBXClXcLmkPH8et0+28ff1ahLcqvAOqMPNz
X-Received: from yudiliu.mtv.corp.google.com ([2620:15c:202:201:a4ba:ce38:21e0:52a5])
 (user=yudiliu job=sendgmr) by 2002:a25:db42:: with SMTP id
 g63mr20165497ybf.404.1617386419863; Fri, 02 Apr 2021 11:00:19 -0700 (PDT)
Date:   Fri,  2 Apr 2021 11:00:14 -0700
Message-Id: <20210402110008.v1.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v1] doc/mgmt-api - Return connection direction in Device
 Connected Event
From:   Yu Liu <yudiliu@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org
Cc:     Yu Liu <yudiliu@google.com>, Miao-chen Chou <mcchou@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When an MGMT_EV_DEVICE_CONNECTED event is reported back to the user
space we will set the flags to tell if the established connection is
outbound or not. This is useful for the user space to log better metrics
and error messages.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

Changes in v1:
- Initial change

 doc/mgmt-api.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index cab1fffc5..5355fedb0 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -4088,6 +4088,7 @@ Device Connected Event
 		0	Reserved (not in use)
 		1	Legacy Pairing
 		2	Reserved (not in use)
+		3	Initiated Connection
 
 
 Device Disconnected Event
@@ -4261,6 +4262,7 @@ Device Found Event
 		0	Confirm name
 		1	Legacy Pairing
 		2	Not Connectable
+		3	Reserved (not in use)
 
 	For the RSSI field a value of 127 indicates that the RSSI is
 	not available. That can happen with Bluetooth 1.1 and earlier
-- 
2.31.0.208.g409f899ff0-goog

