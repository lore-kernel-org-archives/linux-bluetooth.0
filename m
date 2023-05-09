Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE72C7EE22
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 May 2023 23:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbjEIXf5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 May 2023 19:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEIXfz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 May 2023 19:35:55 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233D94482
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 May 2023 16:35:44 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aaf91ae451so61690445ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 May 2023 16:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683675343; x=1686267343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=btX1OLaWAeL7ZxitxiWdF8CUZTFL/d22j4eEs9fxNq4=;
        b=fYEcx/lPbfrw3RmT5KG97KAj6/TynDtmtUWiirBOwQxzg1dRtjLaQ3g6FQ/EBnlCbG
         Qy2pcmxE9QZCBwzdjoEg5Ia4TFwNRVggZMmHBGGJYVvV9hOLFh+LlfBQ/21D3aSGEWqM
         vAO28qiEhzV3Ob9nQXLvsRLd+gd7F+20b7RzNZZFZESC48pIPczeic8gKJCoumiJ6mQ7
         hswr4cLni/p7GgQ2SsrkxnlZy037v9Sc7Wo1b68S8IhQUBHtV7pjAZEVonU0Lo+VkNLe
         8Qf0GUNUyWaPIN/Iv3eazqMa5/yxFcF4PxPmfDX+l7EfZuaYG63qfLKRZOaWj31pmfvd
         LSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683675343; x=1686267343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btX1OLaWAeL7ZxitxiWdF8CUZTFL/d22j4eEs9fxNq4=;
        b=Y2q/W4Jfh96WvsUXUtFK72lmZY+jOQUU/nMkpPAJcao65HbmnF+HXBCXSkElOykMOl
         kmkCcxJvLCPotl6Izy1FCCaBlc90jRn3OJl7oxEzPd2VHK81YqLQS8nLuRKDLeKGtHA1
         OvuvGsIkHAKuLP6p0T2DWSf9QPmJ8GR1RSJFU+LB1OExZBHZqYqFtBcPCCLRMrv2MKdm
         gLHfbTKKykHJMTO1YmOy2h8XUqaNUkh5gqZ1S8btbLG1zkLR4PyeUa1hI6Ag8cNwT+7W
         g6fqjdfz/tsNtFjWJSXcDcHL9a1lyd/Yl5m+/LlcGx+7Yhb2XQnfHP1Eu7ULfXp83i7Y
         xz0A==
X-Gm-Message-State: AC+VfDy1LlEdMcsar2aTsLTBvOhqTprM8TjqR89NobnvS81+7rxiB5NU
        uz+OcT44Hoyv+9bN/e/VljVidw0SxXo=
X-Google-Smtp-Source: ACHHUZ5+gXq7FTx58FTMdio8IrgbNtQQajGF7d7a7dekbj32u+jJb3O/rIN29c0vYhxFnPH5+mJ7LQ==
X-Received: by 2002:a17:902:be03:b0:1ab:797:afbe with SMTP id r3-20020a170902be0300b001ab0797afbemr15049810pls.8.1683675342720;
        Tue, 09 May 2023 16:35:42 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902eb4600b001a67759f9f8sm2205235pli.106.2023.05.09.16.35.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 16:35:41 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] monitor/intel: Fix not skipping unknown TLV types
Date:   Tue,  9 May 2023 16:35:39 -0700
Message-Id: <20230509233540.3418541-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The code was stopping at first time it detected an unknown TLV type when
it could continue:

> HCI Event: Vendor (0xff) plen 82
        Vendor Prefix (0x8780)
      Intel Extended Telemetry (0x03)
        Extended event type (0x01): Audio Link Quality Report Type (0x05)
        Unknown extended subevent 0x81
        01 01 05 81 04 88 13 00 00 82 10 6a e6 6c 00 00  ...........j.l..
        00 00 00 4b 45 53 00 00 00 00 00 83 04 00 00 00  ...KES..........
        00 84 04 01 03 07 19 85 04 3f 08 00 00 86 08 00  .........?......
        00 00 00 00 00 00 00 87 04 00 00 00 00 88 04 00  ................
        00 00 00 89 04 00 00 00 00 8a 04 b9 49 0c 00     ............I..

So this changes it to:

> HCI Event: Vendor (0xff) plen 82
        Vendor Prefix (0x8780)
      Intel Extended Telemetry (0x03)
        Extended event type (0x01): Audio Link Quality Report Type (0x05)
        Unknown extended subevent 0x81
        88 13 00 00                                      ....
        Unknown extended subevent 0x82
        04 97 6c 00 00 00 00 00 68 44 53 00 00 00 00 00  ..l.....hDS.....
        Unknown extended subevent 0x83
        00 00 00 00                                      ....
        Unknown extended subevent 0x84
        01 03 07 19                                      ....
        Unknown extended subevent 0x85
        3a 08 00 00                                      :...
        Unknown extended subevent 0x86
        00 00 00 00 00 00 00 00                          ........
        Unknown extended subevent 0x87
        00 00 00 00                                      ....
        Unknown extended subevent 0x88
        00 00 00 00                                      ....
        Unknown extended subevent 0x89
        00 00 00 00                                      ....
        Unknown extended subevent 0x8a
        9f 1a 2f 00                                      ../.
---
 monitor/intel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/intel.c b/monitor/intel.c
index f5e9f5932cf4..416f52503ebf 100644
--- a/monitor/intel.c
+++ b/monitor/intel.c
@@ -1606,7 +1606,8 @@ static const struct intel_tlv *process_ext_subevent(const struct intel_tlv *tlv,
 		print_text(COLOR_UNKNOWN_EXT_EVENT,
 				"Unknown extended subevent 0x%2.2x",
 				tlv->subevent_id);
-		return NULL;
+		packet_hexdump(tlv->value, tlv->length);
+		return next_tlv;
 	}
 
 	if (tlv->length != subevent->length) {
-- 
2.40.0

