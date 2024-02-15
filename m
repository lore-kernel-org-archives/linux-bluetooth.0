Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8E7433B9
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008756; cv=none; b=NPM8IbxxTEtONtwPKTq82GbgZAUWG6xDO6sRDypYkxmHw8jXC/IKT/9BhHTvvBQBnhpqZH6kkXZeUDc8wnbhKTomAKNvWRBbpDf9LhcbDEKwJAdd4wrU+vv6UHmp8oHz7YgTjPUMgcjyVqTH4pEqd6upao550zZPYO4oTyiGoRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008756; c=relaxed/simple;
	bh=rs+xhSSPojzybdR+KRmx9baMEWRAskn9ddHXn06cgzo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieh5DqKrWor6jvrej7ysHmIrGIwMZUWC+GmFjj547oRMpw/2v96evWgpsaoaGqGEslVDAss9u1Op6IUr/+OFAm82PcTR02vlAhkO5zRPHq8Z4OuzczdXg2y49OIqO39rAAMwOvCP0RHwxu2Yz8US4Z5afD2E1W/M0msd8g4wCFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfwcIHjw; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfwcIHjw"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d5c514944fso871096241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 06:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708008752; x=1708613552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7P5XOQSjOOH/9SMenUqQtkrTkMFlFlHoOyp0fXtf7KI=;
        b=QfwcIHjwRaXbhqcNVrqfkdncs+xwfT/qFsTtEIH4H80ObaaoFb8LbB0xbuTeAmGCSU
         GAp5ihCDtXk9TCnye/XXOtsNq7qI/lXAa8/oFGwygMM3pNzXHlGXsmSvVy2FeKM0dWVC
         k2242jCvvyIi53WFdHqOn6jEMkd3sb3pjJ2tVc/H5uWetQiSVjfXPT3B/2DO/Qmx9qF8
         /ybaOKMF+umaEiBHtD0XzFDzqpBfoZkMolPJmDs1g2/fEFtaqj1mSo4uETVUiSHeipIJ
         /LRQ6Uw7dJrrutjwxwb94/OjbKJBBBx9jLlGLp2y9yxMchreQDRT6uX4oNslGm8XUSD2
         qoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708008752; x=1708613552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7P5XOQSjOOH/9SMenUqQtkrTkMFlFlHoOyp0fXtf7KI=;
        b=bY82p4lskKZBYcV8bRNoVxXAfX5iWh8EB8yo7j0vBYSOzEOCZHYQao0xXI8zFoFZSV
         bN7bEXOYFMWmxJJDex6Y7QcMjR1sdYit1wxH0ze/KFnppGpOxcl2LwC1qYR1P9kCKQ5B
         ACg4JyttB7e10nV5S8wu0d9yPYwA1viGRJSaF1xRVD/ZWNZKoY3XU/7UPqshDftG+xht
         nfcwjI7twUpxe0eTaNZqKRaAAdrXuWUmW7Ax++V0PItFYgzE9nL1WbCUFtuMM/phuBMf
         bn4xkQ8L3lmPZzvSbKP6rXgT6Dj6JIIGe+vJv+9aX4eOMBc76SpqflF41Y9WMn6CNO4c
         PkCw==
X-Gm-Message-State: AOJu0Yw5ifuyzI2pOrYvuBFRVoYIHYkhgmunkB/4DWdV2V9sHppk16U0
	5VY2qZKcKzO/NAJE1x0Y26gSOdXN04T5MLTmUoCX/ORuUO3aQV9SvaDnQxxR
X-Google-Smtp-Source: AGHT+IGcr9S9bJNY/IiT2tlF9PGtfop3ME5zVyzrTzcsIS+rqA/7Fs6yq/373BdeQ3idBGV+AXE0wA==
X-Received: by 2002:a05:6102:236d:b0:46e:ba66:f40e with SMTP id o13-20020a056102236d00b0046eba66f40emr1306553vsa.10.1708008752100;
        Thu, 15 Feb 2024 06:52:32 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id a21-20020a05610222d500b0046d200fe950sm192806vsh.18.2024.02.15.06.52.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:52:30 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] rfcomm-tester: Fix crash on test-basic
Date: Thu, 15 Feb 2024 09:52:27 -0500
Message-ID: <20240215145227.782554-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215145227.782554-1-luiz.dentz@gmail.com>
References: <20240215145227.782554-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes to following trace caused by not initializing data->io:

AddressSanitizer:DEADLYSIGNAL
=================================================================
ERROR: AddressSanitizer: SEGV on unknown address
(pc 0x7f199c3a01c9 bp 0x7ffc26624a10 sp 0x7ffc26624a00 T0)
The signal is caused by a READ memory access.
Hint: this fault was caused by a dereference of a high value address
(see register values below).  Disassemble the provided pc to learn .
    #0 0x7f199c3a01c9 in g_io_channel_unref (/lib64/libglib-2.0.so.0+0x4d1c9)
    #1 0x5565f82fcece in test_post_teardown tools/rfcomm-tester.c:205
    #2 0x5565f83939b3 in teardown_callback src/shared/tester.c:434
---
 tools/rfcomm-tester.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index a9adf7f0f52d..b78b50537e4a 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -30,6 +30,7 @@
 
 #include "src/shared/tester.h"
 #include "src/shared/mgmt.h"
+#include "src/shared/util.h"
 
 struct test_data {
 	struct mgmt *mgmt;
@@ -815,9 +816,7 @@ static void test_server(const void *test_data)
 #define test_rfcomm(name, data, setup, func) \
 	do { \
 		struct test_data *user; \
-		user = malloc(sizeof(struct test_data)); \
-		if (!user) \
-			break; \
+		user = new0(struct test_data, 1); \
 		user->hciemu_type = HCIEMU_TYPE_BREDRLE52; \
 		user->test_data = data; \
 		user->io_id = 0; \
-- 
2.43.0

