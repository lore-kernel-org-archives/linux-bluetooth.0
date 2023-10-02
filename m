Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D06E776D4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Oct 2023 23:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbjJBXN1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Oct 2023 19:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237244AbjJBXN0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Oct 2023 19:13:26 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A835DD
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Oct 2023 16:13:23 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690d2e13074so239508b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Oct 2023 16:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696288402; x=1696893202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bOC1VWOkzWPvLAfHiyqGBjBEjQKxpPMPr3QmumM+hI=;
        b=gEuvx4kwefP7Q0Pn5wMil5iyl4ZDcWOjNq1tGputuspprYE1axPR3E3YUsa+pHkuCd
         1O9EW4rnAGFnT/RJ/VR4Lahr15aBQE8N93lmm6NujVJ4vdTNxOfhxH2UMhBhIlQSwjBk
         9rEi3ui03UytE552b9icQfPGhE+C+kCVz4pbqXx4l1HM5BAl1pOwCAemBBGl32Zv70TD
         RzxsM9QaJ2y3y2timLDwmgJiVcdKuGNT4VbRlSsPsqsn31kL3qyES9noSNKjhpI4mX4d
         TYCgWeyzjxbhWZdJJ6T/rv3b8XnaJLtf2HT9pWdmpELIHMvy58k4f9sEikJM3CwGNmqS
         xFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696288402; x=1696893202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bOC1VWOkzWPvLAfHiyqGBjBEjQKxpPMPr3QmumM+hI=;
        b=uBRvgwm2cTvJFoHpsU++YMW2AcpVOU6aH63IoTEy7wOVs4jGGRis+f7i4aphc4MyFv
         Rm7NtrFUYCxisyCEjPCIrek0e9PnOg7crzorbXwwxtDgoQEA4uOYK/jR+X4IcMD1z9FT
         mGdcEY7tV9wJvCtLmUuYRnjQqUwQnNYr6053BhNJzJrJmuOhkOwPM5gQ2s30wX09uIBa
         2QEkM24sNIoYGwQVtq4rbpcGM1nNw7UItu5nBZFtPnhG2Vpox7aaR5K8JBvi+hLXT6Oo
         YXg9jiKl53Qgi3+mP3wHqCi9x+N0T36h43keBp78fH6U5DwhWlEtpdb843LDTPP7aZ9I
         pqKQ==
X-Gm-Message-State: AOJu0YxgeQdfeHMz3Ddzr+3NT5MoTO8fyWrib5J87d1VuJAC9QpxbF3n
        TXCRJovk02Q+D9Mrz26RSHeYX/cpVt1jAZOv
X-Google-Smtp-Source: AGHT+IGtye+3+8UyljIW0DCUmMZilPydAwhorVqjGSypd/sULvlUnpocYvlmwe/DCS4zI6ZjG8j8eQ==
X-Received: by 2002:a05:6a21:a590:b0:160:8984:6cc6 with SMTP id gd16-20020a056a21a59000b0016089846cc6mr14298969pzc.58.1696288401985;
        Mon, 02 Oct 2023 16:13:21 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id l11-20020a170902d34b00b001c75627545csm5181817plk.135.2023.10.02.16.13.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 16:13:20 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] main.conf: Fix default of CSIS.encrypt
Date:   Mon,  2 Oct 2023 16:13:10 -0700
Message-ID: <20231002231311.3104749-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002231311.3104749-1-luiz.dentz@gmail.com>
References: <20231002231311.3104749-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

CSIS.encrypt setting shall default to true, not false.
---
 src/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/main.c b/src/main.c
index cddf1396197b..ddb73431df94 100644
--- a/src/main.c
+++ b/src/main.c
@@ -1195,6 +1195,7 @@ static void init_defaults(void)
 	btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
 
 	btd_opts.advmon.rssi_sampling_period = 0xFF;
+	btd_opts.csis.encrypt = true;
 }
 
 static void log_handler(const gchar *log_domain, GLogLevelFlags log_level,
-- 
2.41.0

