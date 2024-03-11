Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894BC56766
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710187215; cv=none; b=n4PePEtvzPzc8jdowTEBMeNvgyvdbcuEg0x+GdZpu1ANduCCq63Zvw+2zSpiOsmq4WB/xFjxC9WF3TBWd8/pFeI15Q+F74NV64cR4P/P4g6l2lfdIx500M8LruljyyhHa0Mnf+AtPN78HT2+ycrvsZG9BI1/DHd8YIRjQyoEKJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710187215; c=relaxed/simple;
	bh=ktCDJFIjZmovCa4O9v41Z8BzLz96D0R2evO4xIPmwNM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKQCk0jnlMHPqlLBHPfKnzSiUqDYfBhfbKHENpTr/yrn6WmsPuqEfsQsIf8ADHyhJ+DJCJTLnNAPGYfVpo0csk/MeZ9ZmgbZ6ow2RTJBgSG94hlh9bMnZIbuI0l3M/RkQKM3p1HFaE+vN2T/GIXPi2+4sMt+k6RYMU71N3rzE2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1FPZ3TV; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1FPZ3TV"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-472b77fd2c3so606158137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 13:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710187211; x=1710792011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SsnJBNS+HenhnUwaG8V/oD8w5HuG+KGc9MIiH1/lxE0=;
        b=X1FPZ3TVwB+7WPYi64sRSsqfwHFe1uVRzEPP5RRLVXT7CiynW+z+FgHXZ9QEZ4E/iC
         QUxpJltBMXSpwmorkd+p1CeSdomyqvM5s46Cuz7JB/QvdEbDF+hyTmDmecXm77+zHZlp
         7p5w6p/MJRj0gIJvjl0enTzdH9WmY8Yu/cNWe3BcmCRiy86FMx+16Owrfaa2WxmA5t09
         Vo9ER9URMhojysZzhQhmVeKSmnPmXhrsfJtURxM3gVrjhx97dyTh1ZD0vYH7YN9ON7Mg
         47zyh2gdchObGuTy3Qsv0SLuhSYZVQNS/SqvWpQFh/uB/FJQ3oUzPf+KAk46DTkjGPU2
         9Kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710187211; x=1710792011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsnJBNS+HenhnUwaG8V/oD8w5HuG+KGc9MIiH1/lxE0=;
        b=nIYvNjt+Yq+d6qGxtwfXpbb4cFY/cwbHtAWhcX3XmkWVnVg4JfRlKWYStTF/z3u1HT
         MvndG+nK0BbGoveu4phvy7EZb8CE7zZzoLjJr6A/61+akFTOX9lBW1UAf3dL24OakUYW
         EfPaktTtbwMqYTZMzoh6489NwW+uuVpygg2lw4oQI04BFdxe4/alBnsF9XxoCeJYfd5J
         +K/XCKv/nqycEkBB6zXRuKAU0M/u+ZiY6nKn4lXLer2iupZbSlO3dMtGARFmFGGDooH5
         AwCM2/DJgU1W8wRy/vVy6jJg/6Qwy0N2UejQsjClaA9eHFyGIJjFfaYcBKa/jGIKHrOC
         eSag==
X-Gm-Message-State: AOJu0YwXyV8EgOMtspJGPJkU2npmWM7iBHSyqfufLI6Be6ZS4nzGXvBc
	dgES1TkBbTP07O18JtH9Gw33rh5Br++s2W1KwskVGWtsyeQWnA3+mF5DA5Np
X-Google-Smtp-Source: AGHT+IFun7N6exPVzDlHYEc3MQ5g44y12oNdQcszXzYZig4Bc0j6dfuLW8PKdMh1H75TSr0+yoltXQ==
X-Received: by 2002:a67:cb0e:0:b0:472:a0f3:9c63 with SMTP id b14-20020a67cb0e000000b00472a0f39c63mr3898639vsl.35.1710187211152;
        Mon, 11 Mar 2024 13:00:11 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id g8-20020a056102080800b00472ca24e1c1sm1037414vsb.32.2024.03.11.13.00.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 13:00:10 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/4] test-uhid: Test bt_uhid functions
Date: Mon, 11 Mar 2024 16:00:04 -0400
Message-ID: <20240311200004.962953-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311200004.962953-1-luiz.dentz@gmail.com>
References: <20240311200004.962953-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This tests bt_uhid_create, bt_uhid_input and bt_uhid_destroy instead of
directly submitting UHID_CREATE, UHID_INPUT and UHID_DESTROY.
---
 unit/test-uhid.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/unit/test-uhid.c b/unit/test-uhid.c
index 8a8eef855bc5..516b5441bd01 100644
--- a/unit/test-uhid.c
+++ b/unit/test-uhid.c
@@ -117,8 +117,8 @@ static gboolean send_pdu(gpointer user_data)
 
 	len = write(context->fd, pdu->data, pdu->size);
 
-
-	util_hexdump('<', pdu->data, len, test_debug, "uHID: ");
+	if (tester_use_debug())
+		util_hexdump('<', pdu->data, len, test_debug, "uHID: ");
 
 	g_assert_cmpint(len, ==, pdu->size);
 
@@ -159,7 +159,8 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 
 	g_assert(len > 0);
 
-	util_hexdump('>', buf, len, test_debug, "uHID: ");
+	if (tester_use_debug())
+		util_hexdump('>', buf, len, test_debug, "uHID: ");
 
 	g_assert_cmpint(len, ==, pdu->size);
 
@@ -228,19 +229,31 @@ static const struct uhid_event ev_feature = {
 static void test_client(gconstpointer data)
 {
 	struct context *context = create_context(data);
+	int err;
 
-	if (g_str_equal(context->data->test_name, "/uhid/command/create"))
-		bt_uhid_send(context->uhid, &ev_create);
+	err = bt_uhid_create(context->uhid, "", NULL, NULL, 0, 0, 0, 0, NULL,
+				0);
+	if (err < 0)
+		tester_test_failed();
 
-	if (g_str_equal(context->data->test_name, "/uhid/command/destroy"))
-		bt_uhid_send(context->uhid, &ev_destroy);
+	if (g_str_equal(context->data->test_name, "/uhid/command/destroy")) {
+		err = bt_uhid_destroy(context->uhid);
+		if (err < 0)
+			tester_test_failed();
+	}
 
 	if (g_str_equal(context->data->test_name,
-						"/uhid/command/feature_answer"))
-		bt_uhid_send(context->uhid, &ev_feature_answer);
+				"/uhid/command/feature_answer")) {
+		err = bt_uhid_send(context->uhid, &ev_feature_answer);
+		if (err < 0)
+			tester_test_failed();
+	}
 
-	if (g_str_equal(context->data->test_name, "/uhid/command/input"))
-		bt_uhid_send(context->uhid, &ev_input);
+	if (g_str_equal(context->data->test_name, "/uhid/command/input")) {
+		err = bt_uhid_input(context->uhid, 0, NULL, 0);
+		if (err < 0)
+			tester_test_failed();
+	}
 
 	context_quit(context);
 }
-- 
2.43.0

