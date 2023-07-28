Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49808C001DE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 05:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjG1FcD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 01:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbjG1FcA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 01:32:00 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD103580
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 22:31:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso2850615e87.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 22:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690522318; x=1691127118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hSz18IwDLbAjbTQp0yrNtDYPqRtVUfXMwzMYfSKzBQ=;
        b=o0bsA7oLPQo94FcUWIGewKiTELhagrcbXpsKEtqwJVrS9tDXvtIdcx89QD7L5lbGZB
         UBqSVt5mA/1yWFw3Hdq99UTRARaLvQQ1UvqJ3XzSFYCFdxJL/ZcZKfxyFs4Z+EikMFiD
         I6xr52MZR3YNIRfzmm7l7uEtsNY3xUza9gk9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690522318; x=1691127118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hSz18IwDLbAjbTQp0yrNtDYPqRtVUfXMwzMYfSKzBQ=;
        b=KA3FvdP2Sjw5mooY/5TQREeRHeqIpRCcJIv6cDU0fZ2x3fL3BNyK83aw7rjcOCX+uW
         wrWMtlN0s9xjYqOWeLhOdr1GCnQAvuTfdgclXop/DdKKokLrQL8IQnuMERDZItDuDyP/
         8dCjlG8PoRskKMovuorX5E0uaKCPVi5K2iGjEUnPW/8wX1NL9Xd7VFTdJl7EawyDMhE6
         0M6qn+4fpLYRYGnBj5jCMsB4tiKfyl6LFB3VBRFGAlBZ8ZSC8uHSOwz4k03ZymLZi4gb
         mfGRzwI6SQUPgZG4EMHLXFiKIho31oEXe/3ecKCTVf6CGojvQc+/e5BTzt+HRyzmwdZ8
         zYMw==
X-Gm-Message-State: ABy/qLZCogpBt0o1LE145JKC31nqpPHkyaoMW6UPw4ddE5l/WViB4BWs
        fcWjTAFInVAjGB8eEcBt7Tj8zlPRO13pk6mueLA=
X-Google-Smtp-Source: APBJJlFtdxJDeMp3PlFxIgv5i+xKFy1cgJppFeQVNihV/5q65yqCH8rqoenPo9vIoo/syy743Z0xWg==
X-Received: by 2002:a05:6512:3e0c:b0:4fd:d08c:fa3e with SMTP id i12-20020a0565123e0c00b004fdd08cfa3emr960549lfv.42.1690522317793;
        Thu, 27 Jul 2023 22:31:57 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:353d:c2fa:e0df:3251])
        by smtp.gmail.com with ESMTPSA id oq26-20020a170906cc9a00b009888aa1da11sm1590113ejb.188.2023.07.27.22.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 22:31:57 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 4/5] device: Fix pairing with dual mode devices
Date:   Fri, 28 Jul 2023 07:31:52 +0200
Message-Id: <20230728053153.584222-5-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728053153.584222-1-simon.mikuda@streamunlimited.com>
References: <20230728053153.584222-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We'll prefer to pair services on connected bearer first.

There was a problem with pairing, that select_conn_bearer returned BR/EDR
even when we have connection to LE bearer only. In these situation we should
pair over connected bearer, since connection to another bearer can fail.
---
 src/device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/device.c b/src/device.c
index 5a39a6f83..367e2f046 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3017,6 +3017,11 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 		bdaddr_type = device->bdaddr_type;
 	else if (device->le_state.bonded)
 		bdaddr_type = BDADDR_BREDR;
+	else if (device->bredr_state.connected && !device->le_state.connected)
+		bdaddr_type = BDADDR_BREDR;
+	else if (!device->bredr_state.connected && device->le_state.connected)
+		bdaddr_type = device->bdaddr_type == BDADDR_BREDR
+			? BDADDR_LE_PUBLIC : device->bdaddr_type;
 	else
 		bdaddr_type = select_conn_bearer(device);
 
-- 
2.34.1

