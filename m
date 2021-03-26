Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062F4C433C1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Mar 2021 16:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D320A61A1A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Mar 2021 16:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCZQte (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Mar 2021 12:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhCZQtM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Mar 2021 12:49:12 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6D5C0613AA
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Mar 2021 09:49:12 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id i1so6138952qvu.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Mar 2021 09:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8AfnT0sfGUySac9xk8hyPldNvechcbUigSIPRiA5bt8=;
        b=P92NwaMQmFEw9nFvejqg2yBu9c6vZhxI9/CNppzaY/Vaz0BkuYgbrEM9genbAzPcU3
         wfyX0wAXpP2QnPVwdPTHLkbzOZG9Dok3j+W1KvciM5hXiW/ov2oZLBXrkMvUTmKIZ+/e
         c5lKhwmbEsBLmOT4PNaMD3HQWAkCD/BhlHCjN73GvtIrThqHn50ammUrk8SnpUylTVwj
         1fRlC+rWJkQHYYpSrZg3hROhl98eLIf2XHwyGeulVWBcPO+de3A0vGxlWp6ua0MLc47I
         HfjO/pAfvqf8Q/ZJofVkKs2VllNACW0Z+oG0ibwo+b2k2GdeJzKBCSKuHFk5ICzyiree
         3O2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8AfnT0sfGUySac9xk8hyPldNvechcbUigSIPRiA5bt8=;
        b=uDZHL+m9dfzHabUKtua2OMJug0yduk1VxAvENy6rYw1pSSMoSMQTIrTbrtbPIoTMhx
         +42IsiL6SWCwRLae7hwTT0tNV9yR4GlfswabvC6xdRYb8/S0KD0c7TsY687rOwW53Jiv
         nGpD0nDH0WEtqqP8PFCiJHWw/r1ZmFwc1SsyJh/a3Ls0+QKCP3PpAAAo9UPilU+mFaf0
         /5cbn5WWv/5r0/cu+mqsueOBBmInp9WKvVQXtCSwijuOR4oNaNBWFlDa0sPnnq1TxeIE
         y2hDHCLjhc1Q1d/7/gFE3ObYR6RgoekPIYWTqRpiGRb+2sv+V5oUrC8Y4x7mn78+ROh0
         1pQA==
X-Gm-Message-State: AOAM530k60+F4i0Nm6aOQrGV1DFodxqlWfzR1aubIhq5y45qecQezdVa
        beu9TodbLnPsk7yYr8uo/Ma6VclvWd1T3jST1qYADvCQ4WkHDUpo9qsAJayZMsyS0M68dS1QqUg
        XdSNLPFC55Ny689rYa2Q//itUBaZGl64L6mgX9Ai/VY4uVq2GW2rHrPlj7ypo69SpumkSRzvxZc
        3Y
X-Google-Smtp-Source: ABdhPJwZMtJb6TFJpAK1f7ajUI25I8vZ1l+OqzL9/8zfxDXlVtaYQK9CjCNLsCQU+7aD8cRiVNIWbyhka9XT
X-Received: from yudiliu.mtv.corp.google.com ([2620:15c:202:201:8d14:929c:55ae:6996])
 (user=yudiliu job=sendgmr) by 2002:a0c:ea29:: with SMTP id
 t9mr14452188qvp.52.1616777351274; Fri, 26 Mar 2021 09:49:11 -0700 (PDT)
Date:   Fri, 26 Mar 2021 09:49:07 -0700
Message-Id: <20210326094845.RFC.v3.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [RFC PATCH v3] doc/mgmt-api - Return connection direction in Device
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
Signed-off-by: Yu Liu <yudiliu@google.com>
---

Changes in v3:
- Reserve it in Device Found event

Changes in v2:
- Use next free bit

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
2.31.0.291.g576ba9dcdaf-goog

