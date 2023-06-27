Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D9CEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 23:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjF0Xsq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 19:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjF0Xsp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 19:48:45 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAFC199E
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 16:48:44 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666eb03457cso2813973b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 16:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687909723; x=1690501723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/troVIiGiMkT6tfGvaFhJ1u1RhL1JvOB2FWft19yKnw=;
        b=I9j7ZO3Fg03/EtVzqOjcimOq5Nqqks3Z/xZwdNUdW9B9vudsvws+2HCXCyJL1Eampo
         G5/CXvVg47HAEY7ra3j+l///KuT0JJD/5IUZA96daKKJEY9m0Xoi7/gZ1hXmldfKKfoV
         Ndyukci5xhK+BEYz6BXlq48bk8N2Brb3SlYaAXSxLpnmtvGKkKg5oLMphd/dbjB0Purh
         syVYAqmisKBlOra2lysV4KVHgOXTzQXl0bnccWl+ej6bYFcHzbyIBccBoFS9fMVGWG12
         DHiMzfAa2Fm30cht5idUlDpwxXyy/jjovSrFMNTS6H+5gNA8mE4qKHyBKZZVyplI/9oL
         PKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687909723; x=1690501723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/troVIiGiMkT6tfGvaFhJ1u1RhL1JvOB2FWft19yKnw=;
        b=BfMPiJP7DgXOw8Koib9B4nh9sPnYzkU8cllaefEvXhP24sxMwqhmdBTRVKqiZKUfwc
         WKPP+qS/GY/mY5UjwKnTem44XE7Hbaop7vhzhB1JvxTAmTGcMdqWjEFm7Pt+/sLTOK4T
         VrQZ2MRp04XGk37V3Gyx2JewJ4Blz+5zwLqQoM+qXMGUCUWKPsc3i/tx1BV9RTXJeQYZ
         QO2LdDApHlxftcJOWCIfPvki+BSs/6CP6xyaOqydKLvDH02EdxbGh93Ld5qfpefpzvqK
         iC7+5XeFTHPkVyTde/sXOC9NZhJDRgcpTZGYdQmhf8C56b7LrVI+prwJSk1qwRKmzSZy
         Ud7g==
X-Gm-Message-State: AC+VfDwlhIojC0VHMeQs7Esl6On31GRpECIsPeoS5/7YDYCx0FSYYLEg
        sIiV+3S3Re298fn0a3FDP/73e3mTHU9iAw==
X-Google-Smtp-Source: ACHHUZ4Gf4YGmPE+OwXG5t4icJ7zmOE20tQIK6bdwJk5e4K4+I6kdzIyS9hNrH/xqzt3x34nKdOXnA==
X-Received: by 2002:a05:6a00:3994:b0:66a:3812:7eda with SMTP id fi20-20020a056a00399400b0066a38127edamr18276903pfb.9.1687909722842;
        Tue, 27 Jun 2023 16:48:42 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id j18-20020a62e912000000b00666add7f047sm5859979pfh.207.2023.06.27.16.48.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 16:48:42 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/bap: Fix handling of codec fields
Date:   Tue, 27 Jun 2023 16:48:40 -0700
Message-Id: <20230627234840.2696196-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Codec fields needs to be converted when codec.id is 0xff as the host
endian may not always be little endian.
---
 src/shared/bap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 55f61d91a3aa..cf5d810bbaf0 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -882,6 +882,12 @@ static void stream_notify_config(struct bt_bap_stream *stream)
 	put_le24(lpac->qos.ppd_min, config->ppd_min);
 	put_le24(lpac->qos.ppd_max, config->ppd_max);
 	config->codec = lpac->codec;
+
+	if (config->codec.id == 0x0ff) {
+		config->codec.vid = cpu_to_le16(config->codec.vid);
+		config->codec.cid = cpu_to_le16(config->codec.cid);
+	}
+
 	config->cc_len = stream->cc->iov_len;
 	memcpy(config->cc, stream->cc->iov_base, stream->cc->iov_len);
 
@@ -4347,6 +4353,11 @@ unsigned int bt_bap_stream_config(struct bt_bap_stream *stream,
 		config.phy = qos->ucast.io_qos.phy;
 		config.codec = stream->rpac->codec;
 
+		if (config.codec.id == 0xff) {
+			config.codec.cid = cpu_to_le16(config.codec.cid);
+			config.codec.vid = cpu_to_le16(config.codec.vid);
+		}
+
 		iov[0].iov_base = &config;
 		iov[0].iov_len = sizeof(config);
 
-- 
2.40.1

