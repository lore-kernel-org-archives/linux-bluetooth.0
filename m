Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0073C77B73
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Apr 2023 23:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344400AbjD0XOD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Apr 2023 19:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344395AbjD0XOC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Apr 2023 19:14:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568B330E9
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 16:14:01 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a92369761cso70991685ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 16:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682637240; x=1685229240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hh7rTdclx+rMZsADTYgRxxv+iG2kixOgWMrPKtsLTdw=;
        b=UI07YG/w2BfIJkd6eJlMxN5aBk3a2WmyZwY5ridfdZkw/4id0rJYWO+q9HiGAUnHtv
         svmbinNxguCc9qYKRBUnHzIa0tvf2wayuqghsnDYUeNzSlw00FThpE21wXEEdTjuMEs2
         4fyX4WNI8srPpVqUeYkwnPiGsl7ybKY7b0imR6IspaEbNHsh8iMentvGCnvX+E1J2LQ6
         TnC+q/Tqc//f3kbDFSPvB+/rZqwGtRMSITs8y0KxdSNiCc8O43NHO2ghsJBWgf4ffJb5
         Imb4RS/eCP2VjrLg2KX+bc0j0D8Bu8OwvFECmSLQ8xQ75SEPiev3mfOoBaC0bV4ped7I
         vq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682637240; x=1685229240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hh7rTdclx+rMZsADTYgRxxv+iG2kixOgWMrPKtsLTdw=;
        b=WrkcsOddUVLPmx0tdnDMb9+yOYN9jfw38YgLbtcJ8QQaiTyZ6hKUYF/6hrY9IZp7TM
         UA5ia/5jP/R3JZQi2VqQDAhloQj3D2ZnZRSOCyWlJJMPtHrFbDney+yaqnN4D/reBg/s
         Q9tt02zs9fflAdoOYKwPEgwG+DHjSqjYtr1TXcYyaaAyi0TsmQwkPjK1IW6Z2vsnAjjK
         sGPbek2H9jdh47gJri6FP1sMOSiXA9IukCgO7Wa8MOY+dEehye1BPaqeqf+3CvlrLOyf
         D8L1b9XnAETNmvv2VO5x9BHHxcb1mMyqvzgu0wQLQ181ZEtME75RzTe01QXaYCQfjkqf
         fpmw==
X-Gm-Message-State: AC+VfDwg14aUiBICI+/8yAd1SjbbAsvrhQDfsllRiJ6zzEgAWohw/Tt3
        2gzx/oy/KyJKR8lqJHk13C4GYdR3110=
X-Google-Smtp-Source: ACHHUZ6tftQCK0hCO6BKNbvKxgN8yK+8TS1aYShD+N9ufEjzA2jlkREpyz7JoAxPZWsHHBUeFdF1iA==
X-Received: by 2002:a17:903:22c8:b0:1a6:9ec2:a48f with SMTP id y8-20020a17090322c800b001a69ec2a48fmr3659933plg.34.1682637239991;
        Thu, 27 Apr 2023 16:13:59 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902aa4500b001a24cded097sm12112369plr.236.2023.04.27.16.13.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 16:13:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3 4/9] shared/tester: Add support for NULL PDUs
Date:   Thu, 27 Apr 2023 16:13:47 -0700
Message-Id: <20230427231352.576337-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427231352.576337-1-luiz.dentz@gmail.com>
References: <20230427231352.576337-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for NULL PDUs which can be used to skip a round of
TX/RX.
---
 src/shared/tester.c | 6 +++++-
 src/shared/tester.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index 1feaba48335c..34f807556144 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -914,8 +914,12 @@ static bool test_io_send(struct io *io, void *user_data)
 
 	g_assert_cmpint(len, ==, iov->iov_len);
 
-	if (!test->iovcnt && test->io_complete_func)
+	if (!test->iovcnt && test->io_complete_func) {
 		test->io_complete_func(test->test_data);
+	} else if (test->iovcnt && !test->iov->iov_base) {
+		test_get_iov(test);
+		return test_io_send(io, user_data);
+	}
 
 	return false;
 }
diff --git a/src/shared/tester.h b/src/shared/tester.h
index 49610185a444..16f41022db2b 100644
--- a/src/shared/tester.h
+++ b/src/shared/tester.h
@@ -21,6 +21,8 @@
 		.iov_len = sizeof(data(args)), \
 	}
 
+#define IOV_NULL {}
+
 void tester_init(int *argc, char ***argv);
 int tester_run(void);
 
-- 
2.40.0

