Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E1FC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 22:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3662E206CD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 22:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rELcQstK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCLWZT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:25:19 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:53453 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgCLWZT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 18:25:19 -0400
Received: by mail-pj1-f43.google.com with SMTP id l36so3128350pjb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2020 15:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4mt3tuBEtrcFQaO04FkgRzkU5NWsbNKqrXQXndd3Lo=;
        b=rELcQstKPE5IjSWl/U7kXUJilMAsicK55Zjm2XYnd2fUrtDOf7vdIEQW2IT76uGbRN
         NHL+8flF4tBMoaqJpVDhATS2rfjV2bGE8/Ta3vSDVZcEfUPxlUB/N7NfHloR+MJJk380
         qlyJFVngFgBHJ33abJ7eV8Z2FgYPSwhj3HmD36Cao1gMUqgv9s5BGSRRu9U6A6kzH0Wq
         hwo9CZUaUfSbMMMxoLE7ayW/B8J1P99klDqVoWYu3BBPIzn/+e7SHV96Wt4n3JJakUFM
         1Gtdrjx8VeFoSC6tEmJp+mWUOsARMc8BQmUepRdJuhhkI8MBgKcvuKqblIKKxqYo4h3g
         MaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4mt3tuBEtrcFQaO04FkgRzkU5NWsbNKqrXQXndd3Lo=;
        b=d0ZYGFdk7awLNFNLr6n8TpNhqt9zet8Xy8pXA6niRw2i0zmM0Bp73uesGaTHO0RjUn
         mDj5uuIclf+dvFWL0Y9H7GHFZkc42PQ/a2Z9AajwhviofqJNAmlm4drzrFWWoC7IyJG/
         CoeYWnK4OTDxr3p4IfbnCTPNF2oFQejdYZJkiq8l6Kseb+ugVdZG66kfiGMZtnyRPBba
         n3BzFe5QEFdvOSPlBwRFua+Rq/iJdwIgWdzPZBTayjhIUPY4fn0e9FFffwq4gsUsmoc4
         +vF26RP5qXr7VzlYHgIiOdpLNztN+3ZFVxn2pFPXb8cuAhmxsISFkvZouGD7tNmCH1aY
         fMVg==
X-Gm-Message-State: ANhLgQ3AupTKU0pv3sgl01kW6nxMM9ANAU4k6wdI2KV9cDy9yAImnMQW
        MYX07d0mgSiPHspq18AUPiG77F8zzOg=
X-Google-Smtp-Source: ADFU+vskse+YOuAvbw93TCHyLhtnn5rhaJHRPrsNvO4MaOOHzdK61W8Pq+fwOBsxpBn3xAiDwHzgfQ==
X-Received: by 2002:a17:902:7895:: with SMTP id q21mr10229632pll.222.1584051917653;
        Thu, 12 Mar 2020 15:25:17 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i13sm4296468pfd.180.2020.03.12.15.25.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 15:25:16 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] lib: Add definitions for Enhanced Credits Based Mode
Date:   Thu, 12 Mar 2020 15:25:12 -0700
Message-Id: <20200312222516.5179-1-luiz.dentz@gmail.com>
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

