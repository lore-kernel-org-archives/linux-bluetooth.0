Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8B1C3F6B0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Aug 2022 18:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350335AbiHSSqK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349974AbiHSSqJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Aug 2022 14:46:09 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F249145F74
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 11:46:08 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y4so4859103plb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 11:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=yWIT8ELdmQ4Ipws0XHcGEno+JZbGVTnFAygeqVoNIR8=;
        b=F431rgXQRNMQhv9kYFbuKcIQUQuilDhx7GCahXZD+7xL7niByhLXJO5/3qNKpJlapJ
         ju88n7zEEj9sexboIwMTbE0uOAZh5/Sp9HrFO5R9u8m1sXMNpD2y7w9xijcDip5RM2UZ
         sp/bztZ6SBHNxeoRNRV9c2nTzborWpXiPIvXL61r/hikKpsb5adCJfGENDlp15LhDowQ
         5XBHKxhaAk+PlQDrQDORf9QE0aVZYlh7MfFZ688oCKL8tKZ04EUS5KGWolsT/FVg+thf
         GQ95gVrk7HVldR/V/Ggt+nM8FKckNGgABCGg238VZDCFI1HUv0stoZ8mMBNNYsG3LjuV
         xV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=yWIT8ELdmQ4Ipws0XHcGEno+JZbGVTnFAygeqVoNIR8=;
        b=RVvM6wSWg7LXt5JBLu6hzcryWLQ0keHVNZM5+g670Y/rv+niYUfffEpKCPPj0olYG3
         JMmxGXOpoe/swlskWN0A/sYjZRpm7cd9nnoWg/WCSLhMPKELBcFSxkEPlPh4Mng5BWHQ
         9SSdjiZkrJSo1uMElHBMILsJPRQiCTyR9SveQRbZ8AI45795ccFKubB6bYkvR2vbtG8m
         Es3h1AkagR1y3BT7toDZQr/DIk0UWSzEy+K6pTFyLbNoKF1e2OfqcXvv5Z6FhaX3x/n2
         bJXBz5Wb4A0ZIipAN9Mgpk+2dNsHZUOiI+VfJW806/p+iuJm4CZJF/v9hj7/RWc/0EOF
         kXog==
X-Gm-Message-State: ACgBeo38LJRJMkyyL85TnNqyawQnhFOSIiolxzI4lm0EhFdF3I93Ylr0
        Z/PtptzNN/KW7KKjnGUv68Xn3J6TYk4=
X-Google-Smtp-Source: AA6agR7L7SEGcb3yPxoMDLeFdEucI3q1ZdHTUOz0hgLXSUuJ8p+FMUgnuCaYaNkawK62zdfFFy2gmQ==
X-Received: by 2002:a17:902:f604:b0:172:75a4:33ea with SMTP id n4-20020a170902f60400b0017275a433eamr8481365plg.7.1660934767898;
        Fri, 19 Aug 2022 11:46:07 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n10-20020a6546ca000000b0042a4612c07esm1154122pgr.39.2022.08.19.11.46.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 11:46:06 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] iso-tester: Fix using shutdown(SHUT_RDWR)
Date:   Fri, 19 Aug 2022 11:46:05 -0700
Message-Id: <20220819184605.19225-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

shutdown(SHUT_RDWR) results in socket being HUP immeditaly instead of
waiting for Disconnect Complete event so instead just use SHUT_WR to
start the disconnect procedure without causing the socket to HUP.
---
 tools/iso-tester.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index e4950ead7c69..5727f3055222 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -1185,18 +1185,18 @@ static gboolean iso_disconnected(GIOChannel *io, GIOCondition cond,
 
 static void iso_shutdown(struct test_data *data, GIOChannel *io)
 {
-	int sk, cl;
+	int sk;
 
 	sk = g_io_channel_unix_get_fd(io);
-	cl = dup(sk);
 
 	data->io_id[0] = g_io_add_watch(io, G_IO_HUP, iso_disconnected, data);
 
-	/* Shutdown clone fd so the original fd don't HUP immediately and
-	 * properly wait for socket to be closed.
+	/* Shutdown using SHUT_WR as SHUT_RDWR cause the socket to HUP
+	 * immediately instead of waiting for Disconnect Complete event.
 	 */
-	shutdown(cl, SHUT_RDWR);
-	close(cl);
+	shutdown(sk, SHUT_WR);
+
+	tester_print("Disconnecting...");
 }
 
 static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
-- 
2.37.2

