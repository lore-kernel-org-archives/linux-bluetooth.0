Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E397CA0EC3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 00:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjILAaF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Sep 2023 20:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjILA35 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Sep 2023 20:29:57 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC35415E775
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 17:10:38 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-770ef0da4c2so194457485a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 17:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694477377; x=1695082177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=W+mnNUKeV688X+Ea11DdDF6SgkSWaOUYEIgspV5SeO0=;
        b=J34rbV/Umm0oD5rcZ7rHSqc/HReI9CRNee149AxdEb+9AYfUF+n1wCJ+FmFuZHeDhx
         gUvGVYLPDJbQCITXqNhClQsG4uoHj2v1Z983J+VB/2/d3zYXD2ifTMAW1ttXhuFM2VZe
         0LIwJHQNTXoqjhTqwLKddink1FFPqfoVydkJhFaaqvMD1nAMKDPzNVYZT/+EfLadVFIn
         oxrgVvTlLUtTq9/x4L2xPm526/mVOJ8naMZlFB3JrePtySqb8rGNNTVU39jGJh17Sl5A
         64tuGwXmfbgOhsW2G444hJjoc88VFBTLcy9Rtj/rol+dvd1JTWVqPgPWfH5j3TtdfyWr
         2CvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694477377; x=1695082177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+mnNUKeV688X+Ea11DdDF6SgkSWaOUYEIgspV5SeO0=;
        b=lHUr6VlJQkWVMR/VTtpfBOokRQAW672Izg1ZBWfKebmibQungoToxb9UCmfY8dpOuJ
         inkrmU3jzjRku+zU531Tm2SCXr0H0IbpHgtAta5BjKXQ4Z4rODsbLkLP0AmgrIMqfplA
         KWvRlSv+coCS7Oyfo3h3IxH2Ss16Me0RzPP0Vf21/VFkWrf/q/MYYifFyj17z8B1wzRA
         NM+MoRx7TUL/ZSKWYQEjf9z+K5E/XknowHje0dTX5McOmMPBaRh6T8KxzfUvmVXCzSqa
         vxZB2aAmy71XLV7e08julbno3tQWJ9/gXYyQrb9C+JMIX3iH5p27iovnO7wB3ihryzZr
         agnQ==
X-Gm-Message-State: AOJu0Yy0YmRRvhm2Bkr2Zn3ZtmW+uKA36XQ8uDFtjO2pIYAzt0FGknNU
        IA7oYqjylK6skkPkKo03aAkhFhCmtQc=
X-Google-Smtp-Source: AGHT+IG8f4YBZraJ7E+MDfxNFo44a/buq3YDI/El5aCGfzCdM+9sf/0cmvH5shJah44VlvfxV8tVYQ==
X-Received: by 2002:a05:6a20:6a03:b0:153:3d8f:cb24 with SMTP id p3-20020a056a206a0300b001533d8fcb24mr11262793pzk.37.1694465689311;
        Mon, 11 Sep 2023 13:54:49 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id ey9-20020a056a0038c900b0068bc2432ee2sm5998954pfb.51.2023.09.11.13.54.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 13:54:48 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] main.conf: Fix parsing of uint32_t values
Date:   Mon, 11 Sep 2023 13:54:47 -0700
Message-ID: <20230911205447.2689657-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Passing UINT32_MAX as int may overfollow causing errors such as:

bluetoothd[2688495]: src/main.c:parse_config_int()
General.TemporaryTimeout = 60 is out of range (> -1)

Fixes: https://github.com/bluez/bluez/issues/583#issuecomment-1713447461
---
 src/main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/src/main.c b/src/main.c
index b5a6f8e5562f..cddf1396197b 100644
--- a/src/main.c
+++ b/src/main.c
@@ -440,9 +440,9 @@ static bool parse_config_string(GKeyFile *config, const char *group,
 
 static bool parse_config_int(GKeyFile *config, const char *group,
 					const char *key, int *val,
-					int min, int max)
+					size_t min, size_t max)
 {
-	int tmp;
+	size_t tmp;
 	char *str = NULL;
 	char *endptr = NULL;
 
@@ -456,12 +456,14 @@ static bool parse_config_int(GKeyFile *config, const char *group,
 	}
 
 	if (tmp < min) {
-		warn("%s.%s = %d is out of range (< %d)", group, key, tmp, min);
+		warn("%s.%s = %zu is out of range (< %zu)", group, key, tmp,
+									min);
 		return false;
 	}
 
 	if (tmp > max) {
-		warn("%s.%s = %d is out of range (> %d)", group, key, tmp, max);
+		warn("%s.%s = %zu is out of range (> %zu)", group, key, tmp,
+									max);
 		return false;
 	}
 
@@ -774,7 +776,7 @@ static bool parse_config_u32(GKeyFile *config, const char *group,
 {
 	int tmp;
 
-	if (!parse_config_int(config, group, key, &tmp, 0, UINT32_MAX))
+	if (!parse_config_int(config, group, key, &tmp, min, max))
 		return false;
 
 	if (val)
-- 
2.41.0

