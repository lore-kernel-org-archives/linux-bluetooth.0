Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3473C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 10:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCPKLu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 06:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCPKLq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 06:11:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D243AB9516
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 03:11:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54161af1984so10793957b3.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 03:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678961504;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DtSR8peTag+7FVObqwQG2UIK8AgoJoOOD5xOkww8fUg=;
        b=Vqx1tPXZl7slipqjTj/RBU03HLDX+Kopxph+y1OCZLR+YOkoC9zMefkuqZfeoeoDi4
         53pmTJmQKGEuof4fKjFvCwPBTfr7Bxd+NMNd6+//qDGXx7ZFPdj5lCNxadH3EI6asJpG
         XpV66FfgOfNkrw//e6MPe8i+rt4ZU1o2rTTo+xa15oFO4V8alx/A8VY45iIniW+HoFWI
         iJGcewU4inPIZWjZmJLBIInzScDWnXN/ACjC0c5biu4gwF8W7YbVIMFgXclrmynV+mQw
         //62v7IwELmwLpPvCEDz7asq3imk9B+3F8QA6QMCPDBlDTrEl2IKQEZL9ZMZnQpwaYsU
         CyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678961504;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DtSR8peTag+7FVObqwQG2UIK8AgoJoOOD5xOkww8fUg=;
        b=ZXzlO0jd5R32kkp93Lsv5LDwH7v/MZYhOaZbVR6oNXiVMvy55NXUykJA+o/M8TWcOv
         5Q77qBclBK3WlKraZ0uMQUvVb6QJc6XbR3/cV4wV0FgdnSjRacdqdch38dDAQOyIbfIO
         0sLXXKFvd18yUWNIPEFpMB+055p3lDzZHXWScF4gHjSHejQdKQLG8vGM88bTJMLfvkFs
         tCN6vbiS0u4ewvqBGCML5dTlKuqB5Se2quR+4es7tx5Y8iIwIAMKkOeAeSZHitHf2Yll
         sMyN6Nzms2rbNWHuizqb6hFLuWSDCPzg8Hd9g5GijmHSD4r+uirNsuscT7aqUeZAkBsy
         e+Xg==
X-Gm-Message-State: AO0yUKVc6tvRhP9zdaKJz8thW4QioKRlhYlu+tHU+EMnwH4oBgum4yta
        7RP5r6VtEgcWMxPOfPrFJHN/Xee7Le187MDT8RFPbbBagB2sKhy36LDA09oAvAFREPezi0yG5Fr
        Xn37Oe2aFZucIoTMiJ+ENHOfA2lbXuyk15t+Z3AdazGUKiLosqPMJNr5M7NGz8FYiNDYT4gte/w
        y5AtLWsJ/gj8k=
X-Google-Smtp-Source: AK7set+9Pv9ZTtKhvmWS/BG19Gkw6tJBJ4CR76H3uLrPj1yEY91L+ij06g5L1Yx+fy81h4n033fRdaJ4UZbF1eS/vg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:17:5470:81fd:9c7f:513a])
 (user=howardchung job=sendgmr) by 2002:a25:9f0e:0:b0:b3b:fb47:8534 with SMTP
 id n14-20020a259f0e000000b00b3bfb478534mr7994759ybq.5.1678961503826; Thu, 16
 Mar 2023 03:11:43 -0700 (PDT)
Date:   Thu, 16 Mar 2023 18:11:38 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230316181112.v3.1.I9113bb4f444afc2c5cb19d1e96569e01ddbd8939@changeid>
Subject: [PATCH v3] Bluetooth: mgmt: Fix MGMT add advmon with RSSI command
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>,
        Archie Pusaka <apusaka@chromium.org>,
        Brian Gix <brian.gix@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The MGMT command: MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI uses variable
length argument. This causes host not able to register advmon with rssi.

This patch has been locally tested by adding monitor with rssi via
btmgmt on a kernel 6.1 machine.

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Signed-off-by: Howard Chung <howardchung@google.com>
---

Changes in v3:
- Moved commit-notes to commit message
- Fixed a typo

Changes in v2:
- Fixed git user name
- Included commit notes for the test step.

 net/bluetooth/mgmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 39589f864ea7..249dc6777fb4 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9357,7 +9357,8 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ add_ext_adv_data,        MGMT_ADD_EXT_ADV_DATA_SIZE,
 						HCI_MGMT_VAR_LEN },
 	{ add_adv_patterns_monitor_rssi,
-				   MGMT_ADD_ADV_PATTERNS_MONITOR_RSSI_SIZE },
+				   MGMT_ADD_ADV_PATTERNS_MONITOR_RSSI_SIZE,
+						HCI_MGMT_VAR_LEN },
 	{ set_mesh,                MGMT_SET_MESH_RECEIVER_SIZE,
 						HCI_MGMT_VAR_LEN },
 	{ mesh_features,           MGMT_MESH_READ_FEATURES_SIZE },
-- 
2.40.0.rc2.332.ga46443480c-goog

