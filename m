Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58781E776CB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Oct 2023 23:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjJBXNS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Oct 2023 19:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjJBXNR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Oct 2023 19:13:17 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75841BD
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Oct 2023 16:13:14 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so2502215ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Oct 2023 16:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696288393; x=1696893193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JpYutWjFqZxEpDs2kxc762rU/OhATu8xckFRLTT1LHU=;
        b=d1PTaSIA2LWLFKcIEUcFDkyx+0FFN/HruxD9UVVO18rSl8atD5OoOpYI3XU6Ectog2
         wWeaqbzNtwsdPZNivEgf67yBGFn1KxtZ1TFQN3euFMwSfA4q3LKFeNK2Df52vCqrroR4
         u5c/4KhPyux/Jo2f1ZOP+BHChNBo94f2QghHY9julxIFo71w7ZE7Cip9QrRxRt7ujuJC
         GKVAG9dD99f0FKFhjZg1i+a+jz2dDL7HzZoqGmICTHLPcRqGXeoB6kyWtj6wuxSU+JmK
         MM+WAflsv1PtPFpq4na7M7QEQ2Yme1yWjTvKFSzSzKxtlTER5SJex1lIRdIZRJkR6usv
         w2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696288393; x=1696893193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JpYutWjFqZxEpDs2kxc762rU/OhATu8xckFRLTT1LHU=;
        b=GtBdUz9x3tka+Vy9MynBC2iJlfg8PcZbwm4ykPJ5D4tnpz4a3SVwh5fZkRhbu4yodh
         LZzKzIARij+dzUOuusxJLJAi0cRVZYPrfRR2c4VWF3/QWeGDHHUR1leeq3acbYWdGrFk
         NGWOoF5djuMa7eC6t4cmDsYxY1TRdU5YQ+Tsx1C8sD1lJuGNLDnN/BCLSt1PpLylo1py
         pxjC8JC42bD0Ku31cvOJ8Bqc9SgPULf1LRLY99BBE1Acq/YcfNVnafWEjgIHLNPuO692
         6oZPODE3PxkQGv/qo65y67J7hTGKWnxfdZN1PjD98A7bDcQf3+/Iir8VbJSlbBmiglFS
         u79w==
X-Gm-Message-State: AOJu0YyamdJDFx1Q++pDcMQz1pySPUu23qcAHtkb9FjcLpKN0Ua6DW2y
        iA9PSWBgDS+DO0ntZcewpyHwip5T2O9c8V3P
X-Google-Smtp-Source: AGHT+IHKlxnJNi4SSWiFSM88Bj2yslU9i314qDIe101tUiMlsmZrUvdSlRbZdUjbF1jRpFaWPrt8mw==
X-Received: by 2002:a17:902:c948:b0:1c4:4c73:94e6 with SMTP id i8-20020a170902c94800b001c44c7394e6mr15291306pla.51.1696288392950;
        Mon, 02 Oct 2023 16:13:12 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id l11-20020a170902d34b00b001c75627545csm5181817plk.135.2023.10.02.16.13.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 16:13:12 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/6] shared/csip: Fix returning invalid data to attribute Size reads
Date:   Mon,  2 Oct 2023 16:13:05 -0700
Message-ID: <20231002231311.3104749-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The attribute Size value is stored in the size_val not on size member
which represents the attribute object.
---
 src/shared/csip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/csip.c b/src/shared/csip.c
index 04a8d542b390..24d5d6a323bd 100644
--- a/src/shared/csip.c
+++ b/src/shared/csip.c
@@ -291,8 +291,8 @@ static void csis_size_read(struct gatt_db_attribute *attrib,
 	struct bt_csis *csis = user_data;
 	struct iovec iov;
 
-	iov.iov_base = &csis->size;
-	iov.iov_len = sizeof(csis->size);
+	iov.iov_base = &csis->size_val;
+	iov.iov_len = sizeof(csis->size_val);
 
 	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
 							iov.iov_len);
-- 
2.41.0

