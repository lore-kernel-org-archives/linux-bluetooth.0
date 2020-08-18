Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8218C433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 05:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA4D2076E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 05:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mmM4NjcD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgHRF1x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 01:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgHRF1w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 01:27:52 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DEEC061389
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 22:27:51 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id f9so8717062pju.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 22:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U44b4+c2+olFule7W68+p6jyhTFBkegeEtIt/0fejrE=;
        b=mmM4NjcD6RHrPZGuYTJr2o99PBBBOKjtWHWkkD7FGVUswc5QcQ3Yt6hypJP8wfDp98
         A4sH02Dj6DoMhwVcUQxJoUI+vjsL0/PZck6QjUUHU6OkuusJ7pyrA0P5FIt7+YVNx775
         QQ3Yi9TbGrZlkmrCEu/S4lv9kg8ggfLOjSiZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U44b4+c2+olFule7W68+p6jyhTFBkegeEtIt/0fejrE=;
        b=CCeK7dJPoPtBUP+OzVtMmil5Yc9ikxFA5JUKqxTIN8OLvVFqjeUMJucoIWcgtI0B/H
         IBH6Q+l4V4wO26CiW5NxNq/qZGHNvSUukfA+PnnRLsx1d4pncFrB2ppW6tFGPT9O7AB4
         YY2DBL5GuxWxhjFRjaimlibodXSmroxSzzmUqrXTRYlroDaNFyRrCewzcK3VPj+OXzWm
         OJvI+J1NXDx3BPj1CgEK10feNV09t4IY6lik0Dn7RnJomqIB43kL2UO1p7jrpz+hnuiE
         tWVXOVSjRqn40FXnm/sFfLNXZ4FTxGqDsxeZnzhs1o3j0xrz02568ViZ47uFrrUo3BWy
         NEuw==
X-Gm-Message-State: AOAM530ghmPe/E5WruweO8S2VMnwoLeaPIMykoIXQFEYXJYZ+JRx84YJ
        52gUK2XEghX7hAVmdKv5B73oOMC7+lP+Cw==
X-Google-Smtp-Source: ABdhPJzuVXmCgZamMqBYryZvfkRlnfyBU79cArFfJWJ6ojMbFUwB0C+jNuCC8J8oK0TenuvZlezqTg==
X-Received: by 2002:a17:90a:fa92:: with SMTP id cu18mr14850105pjb.215.1597728470867;
        Mon, 17 Aug 2020 22:27:50 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id n12sm23459315pfj.99.2020.08.17.22.27.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2020 22:27:50 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v2] shared/ad: move MAX_ADV_DATA_LEN macro to the header
Date:   Mon, 17 Aug 2020 22:27:46 -0700
Message-Id: <20200817222717.BlueZ.v2.1.I716fc87b0c97e5349a04766a61ecad1f5b0fd28e@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This moves MAX_ADV_DATA_LEN macro to src/shared/ad.h and rename it to
BT_AD_MAX_DATA_LEN.
---
Hi Maintainers,

In order to avoid duplicate definition of the maximum data length of
advertisement for the following series of advertisement monitor API,
we'd like to reuse the one in shared/ad.

Thanks,
Miao

Changes in v2:
- Rename the macro to BT_AD_MAX_DATA_LEN.

 src/shared/ad.c | 2 --
 src/shared/ad.h | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index 8d276842e..6d882a9b3 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -33,8 +33,6 @@
 #include "src/shared/queue.h"
 #include "src/shared/util.h"
 
-#define MAX_ADV_DATA_LEN 31
-
 struct bt_ad {
 	int ref_count;
 	char *name;
diff --git a/src/shared/ad.h b/src/shared/ad.h
index 19aa1d035..17e3b631b 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -27,6 +27,8 @@
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
 
+#define BT_AD_MAX_DATA_LEN		31
+
 #define BT_AD_FLAGS			0x01
 #define BT_AD_UUID16_SOME		0x02
 #define BT_AD_UUID16_ALL		0x03
-- 
2.26.2

