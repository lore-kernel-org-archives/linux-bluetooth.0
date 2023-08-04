Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5D6C00528
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Aug 2023 21:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjHDV5i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Aug 2023 17:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjHDV5h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Aug 2023 17:57:37 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D929B106
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Aug 2023 14:57:36 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-790aeee9928so91359039f.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Aug 2023 14:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691186255; x=1691791055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wcPD8Y1vhTS4cLo5TwWcMcUQdnD7VR1S6yJwpJxEoxw=;
        b=mvhBp9BmT+h4WBMP34avgU8buGjoUn7wdJYSYs5KHgKw55sB8K1rc9QGHcQPzu/HX6
         O7wMfuRdVku5/7IF9jJ5qWv/d6XBl6xPa40GKHMIoHvblfGL1/1ec3uAyWOw58Lrfr+9
         jDqGEw2Fpv6f8KBFfeW15ZaYDn1hzVO+Tx/wb04oXtsk45M8ay1jH36UQhtPcfl1nVct
         f0iRvWU3lc+Am3/ruLVcTJcl4IF4h8XGdqUHqlJTs5hlQeDa+Ts0UyMDMZyojKed9XLV
         k9omXscp2OpALEC+wSs8OGy24IpG+bE1XF6eCq1AeUaeipTlW8LIOY1KwhRtnbpGLpgf
         DqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691186255; x=1691791055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wcPD8Y1vhTS4cLo5TwWcMcUQdnD7VR1S6yJwpJxEoxw=;
        b=e5AqJ1cojYZFFAyqqbB7munOG4AEvEtSgl437X/s2XZmL6dxHjBT21a3O6WActPjAP
         l498cBnN3hCz+JjvNZua9SL5WoGM+KfipvxUGIllkPQzp3puhAA8ijS0qK9J7xD+1EVF
         2VYTOu21aIr38ZZR0iSb1VrK90dnIynS1v7cFksHeW8aSIbm8fX8382xFkliO34iA2JR
         BKOAlQ2y8uX/hK3IRgzEyd6sHODO3UJS9HYp4OdxeLbO6TRA3pfz7V3gxzYuby2mSzZ9
         8uWc1lZHxkrcyM2B3fdT0evciBVajJVBtzozfms8hLucCgEhr7cebwXahlJiDhFrt7pv
         M6/Q==
X-Gm-Message-State: AOJu0Yxc5IdmG3WRzs5ZFJAoZOAuFEs+Q5dbFxr5P4eooRtXK1+tReM1
        n0v2Z6d+zXp0p29tDwCReIdcfjXfr8k=
X-Google-Smtp-Source: AGHT+IGEJXlmfYdnmKRoQpWaQTgFCurbJ09quM+fNTwkuvqTjcqc3FVYBXuwhcjTaI/UyapglV5A6A==
X-Received: by 2002:a5d:960d:0:b0:783:5209:c01 with SMTP id w13-20020a5d960d000000b0078352090c01mr3769980iol.17.1691186255419;
        Fri, 04 Aug 2023 14:57:35 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id ft25-20020a056638661900b0042b1cd4c096sm794256jab.74.2023.08.04.14.57.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 14:57:34 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] iso-tester: Fix test ISO Connect2 CIG 0x01 - Success/Invalid
Date:   Fri,  4 Aug 2023 14:57:33 -0700
Message-ID: <20230804215733.1049271-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This test shall succeed rather than fail as this appears to be a bug in
the kernel code preventing Set CIG Parameters to work properly when
there are concurrent tasks only one CIS is being programmed.
---
 tools/iso-tester.c | 29 +++--------------------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index bbf959420488..9b9716e06bdb 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -2402,29 +2402,6 @@ static void test_connect2_seq(const void *test_data)
 	setup_connect(data, 0, iso_connect2_seq_cb);
 }
 
-static void test_connect2_nodefer(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-	int sk, err;
-
-	/* Second connect() shall fail, because CIG is then busy,
-	 * but the first connect() shall succeed.
-	 */
-	setup_connect(data, 0, iso_connect_cb);
-
-	sk = create_iso_sock(data);
-	if (sk < 0) {
-		tester_test_failed();
-		return;
-	}
-
-	err = connect_iso_sock(data, 1, sk);
-	if (err != -EINVAL)
-		tester_test_failed();
-
-	close(sk);
-}
-
 static gboolean iso_connect_close_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -2697,13 +2674,13 @@ int main(int argc, char *argv[])
 	test_iso("ISO Connect Wait Close - Success", &connect_16_2_1,
 					setup_powered, test_connect_wait_close);
 
-	test_iso2("ISO Defer Connect2 CIG 0x01 - Success", &defer_1_16_2_1,
+	test_iso2("ISO Connect2 CIG 0x01 - Success", &connect_1_16_2_1,
 							setup_powered,
 							test_connect2);
 
-	test_iso2("ISO Connect2 CIG 0x01 - Success/Invalid", &connect_1_16_2_1,
+	test_iso2("ISO Defer Connect2 CIG 0x01 - Success", &defer_1_16_2_1,
 							setup_powered,
-							test_connect2_nodefer);
+							test_connect2);
 
 	test_iso("ISO Defer Send - Success", &connect_16_2_1_defer_send,
 							setup_powered,
-- 
2.41.0

