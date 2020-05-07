Return-Path: <SRS0=Gf0L=6V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA17C35280
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 21:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4714020870
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 21:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="K8vEbtti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgEGVps (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 May 2020 17:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEGVpr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 May 2020 17:45:47 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A45C05BD43
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2020 14:45:47 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a21so7960195ljj.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2020 14:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RvROpc/zpTt4iCs8QLoqDIqfRFxTZYoIMA8VR31sM6U=;
        b=K8vEbttiEGHaLh0+BzNeX+yKmej0ZLRuGczZZJSQe6SLk7pkRrlOTs6/cffBiZbcpv
         v0DSCGJi9IN829iyLfpA91sdAwMr3KT+Xa5zAzMNeuQC2dXbbnc0aqbasYNf7LCVJINa
         KuHTEtORxRBi3Fn7GWW6mDLENorVEOd2Y8X6z1PYgJi/EcG5CGxrsH4idgYr6Th2Er8d
         je8GJlXOP3UtSGXc+3SoPIfmy7s8+0Mk4KVqgerPdB6m6gNihmGy0E5+IM9ae+IkDI2q
         aTDkzm31tisJDiiyfa5bLLJihQrU/q1X5KA2wfV3EZYCkUqkiUqW5SuwCasqtVVTKLPR
         P7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RvROpc/zpTt4iCs8QLoqDIqfRFxTZYoIMA8VR31sM6U=;
        b=H32ZmsucgO0Sr7W6WeV2mIKWz3rxQ3z6V5nGOQ2q/52bnLMny7mluYjeSaEM+J9uX6
         stfm+s35bZUm9v+LvWWpaQQFkHzeTZ1k4tkYDAlYS6n2+Nyf5roYNQtgWigSbBhpSp85
         sFCk6E2HJuBbSyxS42UOTgjNR7OKrL0xi/V71ncU4VhrGxHseMc2T74GRohPW3Lcqd9Q
         lWMMt9SaBIbPUtmBavYOlB8aDrQqv04Y6kqafwiDqcgc1oXUh3x00xHL4STwKVky6EVA
         sue1IbIVj2Dw+Mhzt0XU3Ju5Pyet3on5dRfLn6FnyG/KQqYf79OsmiFL+bEgTFAra8JL
         cNXg==
X-Gm-Message-State: AGi0PuZXP/qVV/dMO227xaZ1qB1lSgq94MtNMO8q7nvD4dvJXKyoCzQm
        mEL2Qqix9VAuDLEQlsUoU4MrJTiqWbY=
X-Google-Smtp-Source: APiQypIcZpPRF4j6gJop6SA5EIx/ssLSJniSgyYGB7Ohxub3ITG7dP1ewvfcHDGf/Z02zg/ky6QOSw==
X-Received: by 2002:a2e:80d2:: with SMTP id r18mr9518674ljg.269.1588887945446;
        Thu, 07 May 2020 14:45:45 -0700 (PDT)
Received: from rymek.homerouter.cpe (apn-77-115-197-29.dynamic.gprs.plus.pl. [77.115.197.29])
        by smtp.gmail.com with ESMTPSA id s27sm3974972ljo.80.2020.05.07.14.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:45:44 -0700 (PDT)
From:   =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ] client: Fix possible stack corruption
Date:   Thu,  7 May 2020 23:45:37 +0200
Message-Id: <20200507214537.4504-1-lukasz.rymanowski@codecoup.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

DBUS_TYPE_BOOLEAN is 'int', which does not have to be the same size as
'bool'.
On architecture where bool is smaller than in, getting prepare-authorize
will corrupt the stack
---
 client/gatt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 416eda953..9d35b54fa 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -1860,9 +1860,12 @@ static int parse_options(DBusMessageIter *iter, uint16_t *offset, uint16_t *mtu,
 		} else if (strcasecmp(key, "prepare-authorize") == 0) {
 			if (var != DBUS_TYPE_BOOLEAN)
 				return -EINVAL;
-			if (prep_authorize)
-				dbus_message_iter_get_basic(&value,
-								prep_authorize);
+			if (prep_authorize) {
+				int tmp;
+
+				dbus_message_iter_get_basic(&value, &tmp);
+				*prep_authorize = !!tmp;
+			}
 		}
 
 		dbus_message_iter_next(&dict);
-- 
2.20.1

