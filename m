Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23C5C677F1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Jan 2023 21:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjAMVTC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Jan 2023 16:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjAMVST (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Jan 2023 16:18:19 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8B9892E5
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jan 2023 13:16:41 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o13so20124722pjg.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jan 2023 13:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PKHl4FcHTYGz1OAoZvVK8y2v6I21QYioOCPJWYz+G9E=;
        b=lns9ojO3XcHud2zz1j/fmPVww9eZbBHqqtHwMMz5m59w/zUqPbk2Hk0a/YLtZV0W5y
         oIJOkmBAwBfnGl7JShELDrGhFPNYaDaIc9uXfj/T0T6MATdvx0xtRUZc/WqEKPhBUsMy
         K02LFeAdnTL8kJluflgyMAdBwLuy6EWq/aJEx/RuDvEHH1brWHDle+EPG64BTm/AVAFC
         XrZhmVGtEaw7IysfxL6nx4+EpwP2T1O3qzyI4411yhcfffL+Zpo0czNadfdYW5nGG5wp
         14lop5TO/fBKhwfStspbg/GHf/rXOxVLhfg1AwdzY8Jji5bRpOTbgNcUznGlCJRRfFWR
         knJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKHl4FcHTYGz1OAoZvVK8y2v6I21QYioOCPJWYz+G9E=;
        b=PXDh7TMznKzRzgorVOwwsea/e8lB4i2P2GldB/0LzGk0Vjy8DaGXMHGqLoDJO/usbZ
         4p+f6+/86skb3KOKMAaV1GnnX1U5ShI/KhGI78uHCfsVwU9QoZZ89a/dEU1bBygDyTrH
         JWw0g3OIL113xk/Ce6Lp0CdYhQGxCpxBFopzv/+pz+RnThLEUhizCdunEs2THncQRJPb
         wY/wyyAboTUGHxcQE3MckuhH6ofrsECPRoeAOerLip1X6RmP41idDrxNlTHYmtTPG0+2
         VzAEPzppFpHmTP8f7DBtKa/uW4us1+O5j9TE6TSWanbpqzuKDsSFGu1hu7bsBgYRP9jy
         pHNQ==
X-Gm-Message-State: AFqh2kpTvmO2A2Sbh95TCBxMaU4sPKQjOxyvdGLK51AI8vh+E9bm0Wdn
        /nQbIGva+Sfq9ykZlRE8dq+NqijRMIY=
X-Google-Smtp-Source: AMrXdXuKpwgvZ4dyQhin5qlmnyWTV90f8XUIVP+LiQlChS1LCM4Q5vWGv6rEuPyuNPhvh+pOD8mrBQ==
X-Received: by 2002:a17:902:bd98:b0:188:8cfc:6ba7 with SMTP id q24-20020a170902bd9800b001888cfc6ba7mr82612191pls.68.1673644600896;
        Fri, 13 Jan 2023 13:16:40 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id v7-20020a1709028d8700b00192902287d1sm14475194plo.288.2023.01.13.13.16.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 13:16:39 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/bap: Fix scan-build warning
Date:   Fri, 13 Jan 2023 13:16:38 -0800
Message-Id: <20230113211638.303409-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following warning:

src/shared/bap.c:2268:26: warning: Access to field 'iov_len' results in
a dereference of a null pointer (loaded from variable 'cont')
        return iov_append(data, cont->iov_len, cont->iov_base);
	                                ^~~~~~~~~~~~~
---
 src/shared/bap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 0cafb75e69d0..88697988e991 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2261,6 +2261,12 @@ static void *ltv_merge(struct iovec *data, struct iovec *cont)
 {
 	uint8_t delimiter = 0;
 
+	if (!data)
+		return NULL;
+
+	if (!cont || !cont->iov_len || !cont->iov_base)
+		return data->iov_base;
+
 	iov_append(data, sizeof(delimiter), &delimiter);
 
 	return iov_append(data, cont->iov_len, cont->iov_base);
-- 
2.37.3

