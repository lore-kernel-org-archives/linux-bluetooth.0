Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFB2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 22:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242252AbiCWWlg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 18:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbiCWWlf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 18:41:35 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A3035857
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 15:40:05 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w8so2948030pll.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 15:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fQwh4amWpFaUYFE3yRHpnASrf87h4cacFDES28Pe7yU=;
        b=Bg2e9pcc0QTwSwwA18iSxYR/hz7RMgXz8Wr7HsMOrksSBDlnHDCblZpf1aCgMm+Ntt
         noCT1r0HwxxWFFTxY0amri0FqADO5KqyvVBTUlU5Z2UCa2Jloyq7Gv2UVMVRiPInJ78G
         Z19LTXQHRTLsb2L6ZyMuJ/H4eNk+oAiCpbuzk8NANEr3NNYjxj76nzltk1W6vxJp76C4
         e2ZH31fzMiqKkfu1eayLrpcOBjb840JS5KwNy4m/W2jKfICL6cGOWmxfl3LyzCR7kLDe
         n3/1IHIr7zznbDpiXqQ40uJqECb7lbDydNZ2GRlfl4XiqeHYcZv7LO6VA+f4TlYTkpd5
         mBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fQwh4amWpFaUYFE3yRHpnASrf87h4cacFDES28Pe7yU=;
        b=EanfgfFVo2zuR1pma5AucF0qsETU+B/EUqgzjNhHawf1cZtG5QgUf0MgYScDo4vaQr
         xvbUK0gyJI0vQfqz9sTrhy9M91j3LBeYQCaFQrqZwn+DqcJD5pag+hLhm7lqUiL8HakM
         sktxuGWyEkerwHINx8LUNryF9Xc8P5ObeMAHFtdOJFJc1J4oCSrPKCFkTpH7IFVgHIIi
         J6FjdrE/OwETTcI8bYx5ZXQ9hefmSuqqLBrM4e466beCIKrd7dvoyWnz2u/eaIqnzE21
         0P5z2VbwRVrp4UxTYCHPjme2wXyiYQpa3H+HDHbFLLvqg5c06ukKYPHLy+1pRa+Z90V+
         gaBQ==
X-Gm-Message-State: AOAM531StaltMoExft+GAiqTDTALFNo2VsP7bw6+zmfGUbMxP3QaBwKJ
        MbnpUWCW6W/zkABfNY3UZBc4FG0n0vs=
X-Google-Smtp-Source: ABdhPJy85Ms0W2CncS3abkGKykMexF7Q+sAOLsAGl4Mihgtmk+S3u/d+lsjkGzqqTv/yYlbmXAGTMg==
X-Received: by 2002:a17:902:ce09:b0:151:96e2:d4b5 with SMTP id k9-20020a170902ce0900b0015196e2d4b5mr2335916plg.3.1648075204768;
        Wed, 23 Mar 2022 15:40:04 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7888e000000b004f79f59827asm825109pfe.139.2022.03.23.15.40.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 15:40:04 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] adapter: Introduce BTD_ADAPTER_DBG
Date:   Wed, 23 Mar 2022 15:39:54 -0700
Message-Id: <20220323224003.3736525-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces BTD_ADAPTER_DBG which includes the controller index
when using DBG_IDX, in addition to it also add similar macro for
devices in the form of BTD_DEVICE_DBG which resolves the adapter and
before calling BTD_ADAPTER_DBG.
---
 src/adapter.h | 4 ++++
 src/device.h  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/src/adapter.h b/src/adapter.h
index 35deb1d11..515be3210 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -23,6 +23,10 @@
 /* Invalid SSP passkey value used to indicate negative replies */
 #define INVALID_PASSKEY		0xffffffff
 
+#define BTD_ADAPTER_DBG(adapter, fmt, arg...) \
+	DBG_IDX(btd_adapter_get_index(adapter), "%s:%s() " fmt, __FILE__, \
+							__func__ , ## arg)
+
 struct btd_adapter;
 struct btd_device;
 struct queue;
diff --git a/src/device.h b/src/device.h
index 071576d6b..4d40d1d22 100644
--- a/src/device.h
+++ b/src/device.h
@@ -11,6 +11,10 @@
 
 #define DEVICE_INTERFACE	"org.bluez.Device1"
 
+#define BTD_DEVICE_DBG(device, fmt, arg...) \
+	BTD_ADAPTER_DBG(device_get_adapter(device), "%s:%s() " fmt, __FILE__, \
+							__func__ , ## arg)
+
 struct btd_device;
 
 struct btd_device *device_create(struct btd_adapter *adapter,
-- 
2.35.1

