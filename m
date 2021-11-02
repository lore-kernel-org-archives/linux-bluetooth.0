Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12620C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 22:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E31D660FC4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 22:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhKBWNZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Nov 2021 18:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhKBWNZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Nov 2021 18:13:25 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47BBC061714
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Nov 2021 15:10:49 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n8so1047726plf.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Nov 2021 15:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bcxWBJkF0ymGM00bcxzE4hfHy91O95ng8k4cnvawLyQ=;
        b=mjmIgUMywQaPx6pBkhUKbPOQSQEyUQmn+ImVQyR0Zi6/FLGg73otz4UBre8p0iPAzQ
         BAxKeQC7ZwC6W2OMnfRO1t7P3QwBSfYEITGPzHmEYKEzZ134tgW0K7pdxbpF46RzDTqM
         wo2TKj3Waon4zjE4vzU5hokoM2eUZVsAghz1T2WQv+7XqjcnhhLNhREW0ZwLafjVYH0T
         gfHL9wvfeIry5w89YpcKm4IVU+pLgflCjgst2/NGxfjG2hvytzHrEkgS3O4kiYs4spUf
         sNk5Z1GMJVrmt8yYbipMexyqcAzEKF7ht/Hf9mkF/jmiTQed57/KDfx/U3wgvaQ8SMp3
         YtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bcxWBJkF0ymGM00bcxzE4hfHy91O95ng8k4cnvawLyQ=;
        b=q8iqMve00uBFYphFzIsC4lfGoG3WZkp/7GIYGDo1Elu7xUqn6o91U58YAkpBXSVTEM
         umkZVgvLloVyoypm2YfoP6QcX77YkyR1ug8UZa4o/jOcogkmycEmwYAfIoW1pmUs2oVd
         ePZOdonb4LHz4gLfBJJa+nzsBRYeB0wv0GeA6HKvZmYnpCFxvf4X5kEOEUkWjz2e7hPC
         n+3vk/IC+SAnjUCGwkXYe70IjBRssZCF9xZMt/TiWViV/4zctzUPiiZReUkr1k+Rvzsb
         4bgmZL4SNo69IYYO4GXdAg5N0lFvqeuPqTcWC80i9tR/pZLahf1DvfNHBGb/zVa3zMaD
         rIbw==
X-Gm-Message-State: AOAM5313F4lv69PwxmUBpR9CyPGgmaciMjSGdlN7SuUG4zAgCNqSB3kO
        vIqI+IrhhJOOfF1YK/NsAho2uq8YdRw=
X-Google-Smtp-Source: ABdhPJzv6ISWga8pyZOjulc/eL5pHdXxAI6E4uJnwGSWuKcF7rp2Z0ZqyJ2pTJ4dMXM1X5/YIou0Pw==
X-Received: by 2002:a17:902:cecf:b0:141:e15d:4a2a with SMTP id d15-20020a170902cecf00b00141e15d4a2amr16591335plg.66.1635891048907;
        Tue, 02 Nov 2021 15:10:48 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f8sm156450pfj.36.2021.11.02.15.10.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 15:10:48 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mgmt-api: Add new action to Add Device
Date:   Tue,  2 Nov 2021 15:10:46 -0700
Message-Id: <20211102221046.23293-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a new action, Action 3, to Add Device command so it is
possible to set the Device Privacy Mode which allows to connect when the
remote device uses either identity or random address.

Since Network Privacy Mode is assumed to be the default Action 2 has
been updates to state that would be used when the device is using
privacy.
---
 doc/mgmt-api.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 97d33e30a..ea91155b0 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2027,7 +2027,8 @@ Add Device Command
 	Possible values for the Action parameter:
 		0	Background scan for device
 		1	Allow incoming connection
-		2	Auto-connect remote device
+		2	Auto-connect remote devices using Network Privacy Mode
+		3	Auto-connect remote devices using Device Privacy Mode
 
 	With the Action 0, when the device is found, a new Device Found
 	event will be sent indicating this device is available. This
@@ -2041,7 +2042,12 @@ Add Device Command
 
 	With the Action 2, when the device is found, it will be connected
 	and if successful a Device Connected event will be sent. This
-	action is only valid for LE Public and LE Random address types.
+	action is only valid for LE Public and LE Random address types using
+	Network Privacy Mode.
+
+	With the Action 3, works like Action 2 but instead uses Device Privacy
+	Mode for devices using LE Random address which allows the use of both
+	random and identity addresses.
 
 	When a device is blocked using Block Device command, then it is
 	valid to add the device here, but all actions will be ignored
-- 
2.31.1

