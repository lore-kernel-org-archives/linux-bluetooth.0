Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160BCC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Nov 2022 22:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiKIW36 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Nov 2022 17:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiKIW3x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Nov 2022 17:29:53 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37022EF3A
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Nov 2022 14:29:52 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id h21so59215qtu.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Nov 2022 14:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VHrC1F4+KBRIi+HxhoVrcBzerWPZKq0dFT3HGWGGLfA=;
        b=htKzct1qRxf+7iLXdV4PZ0Y4escAYTW6WRx011+9RY0x2tMgSiI2Qw/aSmE/kTQk1+
         1SKmV/ml0EVbp0w1dv6mfaPANOT3oahPTDXW5itCuYfu99C/3xstuB9GgFZAGtVb6Acr
         hRHPEIXDJ5Uv2A3pndg7WHGlQiHYVTl+LEKS17jEliqauL5Of/pJ8GHnopuNz9uzZF8J
         UysHaZD+5iHE/TSn2RMaJjijlz97+/ysH3pERrRKWshsha6SaERFOVrJWF0tI0eh51mg
         rdYa8cNYnPMHx8gn2HnrigS+2HM8gxSe6/3yHP60vrRu12wgH775F3wIxS2LDNKeZiim
         vP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHrC1F4+KBRIi+HxhoVrcBzerWPZKq0dFT3HGWGGLfA=;
        b=zksECa2CeJv/qNuXlqtK+kEBIbsmKfITIIEAj31jviUioKqulMXCkAK4Y0ARPx++3T
         Y/BpZIe2EkWQ8Cdrqj72p9rAuQ3FB5Zh50i8HJHG827TeU0zLORPBx8tUlV9V2FzkXnx
         iQ5OYwBp7VLexiWYRw6cOM1Hd46ss8T8XO3KaQi9haGzqZmQ6iVF1f7HC7zKSAoL7eKd
         VcPXcfBdYtnMUACW8eKdUdvdqjZzvvpeXJeF/b0W/8PKxdMsEqkmUbiL/iw4eoxbQSIP
         TvfbUUm/2pKS8Rixd+DOFPVOin+qfsr6iRyyWJMOPEJGauOdnMNsr4DMHK1bEFNWe9xF
         CHuA==
X-Gm-Message-State: ACrzQf0l3UX8qJzWN3kvcjxvhfoWsIxiHJj2JYXMgvOVdeCi9TXORWVY
        DytlHYiD63BANP+xA/MqoXhXAKIxWuQ=
X-Google-Smtp-Source: AMsMyM63IL6pE1T/fD5DyQ/81HpCSB1awc50rLOw7hQUqhgn/erzJbXdV2D8X8rv032nKSHsfpatuQ==
X-Received: by 2002:a05:622a:4ce:b0:3a5:4916:1753 with SMTP id q14-20020a05622a04ce00b003a549161753mr31262151qtx.568.1668032991362;
        Wed, 09 Nov 2022 14:29:51 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z9-20020a05622a028900b0039bde72b14asm10518732qtw.92.2022.11.09.14.29.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:29:50 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] shared/tester: Add tester_io_set_complete_func
Date:   Wed,  9 Nov 2022 14:29:45 -0800
Message-Id: <20221109222947.1137901-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221109222947.1137901-1-luiz.dentz@gmail.com>
References: <20221109222947.1137901-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds tester_io_set_complete_func which can be used to set a
callback when all iovec has been sent/received.
---
 src/shared/tester.c | 16 ++++++++++++++++
 src/shared/tester.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index e88dfabdc37c..1feaba48335c 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -89,6 +89,7 @@ struct test_case {
 	tester_data_func_t test_func;
 	tester_data_func_t teardown_func;
 	tester_data_func_t post_teardown_func;
+	tester_data_func_t io_complete_func;
 	gdouble start_time;
 	gdouble end_time;
 	unsigned int timeout;
@@ -913,6 +914,9 @@ static bool test_io_send(struct io *io, void *user_data)
 
 	g_assert_cmpint(len, ==, iov->iov_len);
 
+	if (!test->iovcnt && test->io_complete_func)
+		test->io_complete_func(test->test_data);
+
 	return false;
 }
 
@@ -937,10 +941,15 @@ static bool test_io_recv(struct io *io, void *user_data)
 
 	g_assert_cmpint(len, ==, iov->iov_len);
 
+	if (memcmp(buf, iov->iov_base, len))
+		tester_monitor('!', 0x0004, 0x0000, iov->iov_base, len);
+
 	g_assert(memcmp(buf, iov->iov_base, len) == 0);
 
 	if (test->iovcnt)
 		io_set_write_handler(io, test_io_send, NULL, NULL);
+	else if (test->io_complete_func)
+		test->io_complete_func(test->test_data);
 
 	return true;
 }
@@ -1004,6 +1013,13 @@ void tester_io_send(void)
 		io_set_write_handler(ios[1], test_io_send, NULL, NULL);
 }
 
+void tester_io_set_complete_func(tester_data_func_t func)
+{
+	struct test_case *test = tester_get_test();
+
+	test->io_complete_func = func;
+}
+
 int tester_run(void)
 {
 	int ret;
diff --git a/src/shared/tester.h b/src/shared/tester.h
index c28f61e7fd6b..49610185a444 100644
--- a/src/shared/tester.h
+++ b/src/shared/tester.h
@@ -78,3 +78,4 @@ void tester_wait(unsigned int seconds, tester_wait_func_t func,
 
 struct io *tester_setup_io(const struct iovec *iov, int iovcnt);
 void tester_io_send(void);
+void tester_io_set_complete_func(tester_data_func_t func);
-- 
2.37.3

