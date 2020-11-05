Return-Path: <SRS0=JOhI=EL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841CAC00A89
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 06:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F72920936
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 06:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GSZRtBDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725320AbgKEGkr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Nov 2020 01:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgKEGkq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Nov 2020 01:40:46 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25A9C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 22:40:46 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id e23so357088qkm.20
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 22:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=cHsyr7+Xnk8MKrJWSSQ723ouixQm4NmMA4sk4MHmrho=;
        b=GSZRtBDW14qaToV1YmetfSClAs4smDFliKdolHW16bZyuukhCbqJxdF0cvqJc7zxO7
         anjZPn8eIVFahDDTjFhPAfzpVYA89b/PE+H8hcuPmEqlYWHMkuupS5NPzTpdsPIpty1N
         Wh575HPdTvPwpXKO1BUSOb7jiIpt2uXFPr8zebXZqjj5ehWxUc+BizKvfhWg1Hz4Giuy
         Tm8RcGpApsbyAOYcoTr64LZMeRgFPSv7IayW01jm0Ts2HKQbo5VixpUbreVrXgs/mkGH
         TeGUQnoTQo3mQe2HpEj8byo6tMNZRL9evWw420faNPNXyy5YzvYagmCGeA4R9/1Q/+/Z
         Bi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=cHsyr7+Xnk8MKrJWSSQ723ouixQm4NmMA4sk4MHmrho=;
        b=P+dWZ1fvzqAD4276WN08sR2kW+R4F0teM9ZBhCZtuo9WkeJCWt4VQZfsBHXZjT/sQz
         6syrJPlAjS1gfnq5XOvCHeUFCmvDWKrAB6D4AMa7wFRdOvprCOHJqY7lwatZmVKEJn8k
         WDh4DLzXI0RfecIMRWB28r17z/uOTBdoDkLkvWzxfGWayeBYWlbms1QP/F0detdh86HB
         rnd5RLz8HC4LbY7Ww8J8Gj4RwEs+FGlKA8REzrB6D2rY9hoFDT6GuUyDl6oHGtPpKev8
         FdoFAG288XAd0D9pQJX7zx5CTHEkUzK2YEY30l6ofjiYitRgQ6EVJtDfJOIeuQFtIZXk
         55VA==
X-Gm-Message-State: AOAM532xmsZj8tZgU1Hwgq86HvaYdJMebPEBSbXyk6rzJ4elDEt9FyND
        cgA74ZHmQNh/Icm4UCiaDFJm+RgI39XpVe+NIIIHwXGb2+wOml9coPlHWfwwBwYqkvTApnpRlJc
        PZaNKtuU34j3126SaNnMOluKOP652CpSkB3Q2+5AST61HxCVdx6gMKCNyIcwB9cPvPv/KcZeut2
        4V
X-Google-Smtp-Source: ABdhPJxH3WC6Ab8N3IEb1KxMrppmG99SpIzzwODoG7VUFrmcluACHHZYGbTdkfHs7j1HuZl2cXqd0c2JUoOw
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:ad4:46ca:: with SMTP id
 g10mr1087040qvw.2.1604558445699; Wed, 04 Nov 2020 22:40:45 -0800 (PST)
Date:   Thu,  5 Nov 2020 14:40:32 +0800
Message-Id: <20201105144005.Bluez.v3.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v3 1/3] service: add adapter powered check before connecting
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

When policy_connect() is called, there might be a case where the
power is just turned off, hence the adapter is down. Add a check in
btd_service_connect to detect such condition.
---

Changes in v3:
* Update the commit message to reflect changes in v2.

Changes in v2:
* Add adapter status check in btd_service_connect() instead of using
  btd_device_connect_services()

 src/service.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/service.c b/src/service.c
index d810fc3b05..21a52762e6 100644
--- a/src/service.c
+++ b/src/service.c
@@ -229,6 +229,9 @@ int btd_service_connect(struct btd_service *service)
 	if (!profile->connect)
 		return -ENOTSUP;
 
+	if (!btd_adapter_get_powered(device_get_adapter(service->device)))
+		return -ENETDOWN;
+
 	switch (service->state) {
 	case BTD_SERVICE_STATE_UNAVAILABLE:
 		return -EINVAL;
-- 
2.29.1.341.ge80a0c044ae-goog

