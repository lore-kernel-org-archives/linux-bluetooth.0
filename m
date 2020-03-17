Return-Path: <SRS0=BuFd=5C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D45CC0044D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Mar 2020 02:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E69520674
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Mar 2020 02:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boqXUrE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgCQCLp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Mar 2020 22:11:45 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:33663 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgCQCLp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Mar 2020 22:11:45 -0400
Received: by mail-pf1-f170.google.com with SMTP id n7so11050297pfn.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2020 19:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4mt3tuBEtrcFQaO04FkgRzkU5NWsbNKqrXQXndd3Lo=;
        b=boqXUrE213v6KYObpcixyD5td/UAvzQ5o4eU13LE3iRZisOuisIjgHMpzXQJfRwOtW
         hAnPKIfHzWljMrWTObKCNH/2sijm2SkPCkuMNpw3Oxxpof6yFZRfJAFvyHI1YpPYuOsZ
         NLDLuy7x4bb6/+4TmD7ieHuY6aBb7zn4P4XybY3L2kQJvde3grHhKYlXaEJf34+BAsdh
         /okBcjEW3JorBrYNn3mPZ6OroTHcqTX3YhRcCnt9CTZw3cOGh8/3Ti7xFNjXbJdH2wTy
         VFJy95aqa9y9NxiVElZoADzXbGSfZgSGRUG7T/RU1cePNXGXHkvb+BEvkX2mP0CJHegQ
         SK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4mt3tuBEtrcFQaO04FkgRzkU5NWsbNKqrXQXndd3Lo=;
        b=j3S1ShbSP6yd6rTeYN6jDdyjb5GtnH59sgfu0SV/ceR3aSzVlrQhkcYMFTKRplTH+q
         SHq6rvDmndn9ur3HLvQWTXCxkwFXBZeH51omJoXgbOca80rOLBRtHMOBVR1s7rsriEsL
         oQi4PU6gszfsKdnX1wPubSGgb/DGI7LjcsAGdn0zCNtMdcvGyZ3GYdFXwrydfWGZAgar
         gc7Uxv5TfJKyGNkUwryFUg+3Wh7nWL9Ej/6rfPwK7ixxPKRBqwQIiOUPiOOfBCD9WsV4
         abzhb8ccb+F5CBFhVrlN67Xj+4aoG4bYS0q9Mz2q8hDt+YQfnWXgZQb0W4cGRQlFpFlg
         d0pg==
X-Gm-Message-State: ANhLgQ2jC9KR930vXO8n6AVMEm4R/nh8F7YyG9ilJhWuBUR1JqIor+2l
        SWbvrLYX7ztjq+/94didAxsPBgCvLS4=
X-Google-Smtp-Source: ADFU+vuvfgYINE+FOUkpQwljS3btfL+Ih2kCPqauTx9fSFze/uFiSUknVY/YOYlz+6piZFLvqsT/ug==
X-Received: by 2002:a65:6795:: with SMTP id e21mr2668180pgr.270.1584411103882;
        Mon, 16 Mar 2020 19:11:43 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f19sm700769pgf.33.2020.03.16.19.11.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 19:11:42 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/6] lib: Add definitions for Enhanced Credits Based Mode
Date:   Mon, 16 Mar 2020 19:11:36 -0700
Message-Id: <20200317021141.16398-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 lib/bluetooth.h | 2 ++
 lib/l2cap.h     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index d14217eac..47521d50e 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -141,6 +141,8 @@ struct bt_voice {
 #define BT_PHY_LE_CODED_TX	0x00002000
 #define BT_PHY_LE_CODED_RX	0x00004000
 
+#define BT_MODE			15
+
 /* Connection and socket states */
 enum {
 	BT_CONNECTED = 1, /* Equal to TCP_ESTABLISHED to make net code happy */
diff --git a/lib/l2cap.h b/lib/l2cap.h
index 5ce94c4ee..f9ceb2f33 100644
--- a/lib/l2cap.h
+++ b/lib/l2cap.h
@@ -197,6 +197,7 @@ typedef struct {
 #define L2CAP_MODE_FLOWCTL	0x02
 #define L2CAP_MODE_ERTM		0x03
 #define L2CAP_MODE_STREAMING	0x04
+#define L2CAP_MODE_EXT_FLOWCTL	0x81
 
 #define L2CAP_SERVTYPE_NOTRAFFIC	0x00
 #define L2CAP_SERVTYPE_BESTEFFORT	0x01
-- 
2.21.1

