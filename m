Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81D558220
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 22:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197018; cv=none; b=sZIiqklYBfxj7SvhmxiOzngz6TjSDXxIcjIElkNaWRaf3a8Pr6EMYq7ppmX/fqETnMlnHZyVgMLj5RUn4DqPP2UdHAyW1jdyvCBqtxMdfpzRar27tgi9zzAYDTilTrRqTKkuqQwgqUiTmFG47zLRWgBN3HmhrvlwNqcCQQU3bao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197018; c=relaxed/simple;
	bh=ktCDJFIjZmovCa4O9v41Z8BzLz96D0R2evO4xIPmwNM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXziZHkV8fR1jbNvuEFab4sv7a8SA5j/wE55cgyQglfrTv1MCDZNXMQtCwUJWXa5DWuDCRXE/FeZLFC1TWWA2BKGGpqu0AmjmdOFWlrNleCAbMbNC67Nw6wwmYFXyJ1zU6EJiTJM1HqVzs7mhRw0LwaWfSXw8HGNC6uS0EC356o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGSR4hau; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGSR4hau"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-47265b3ca14so1192912137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 15:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710197015; x=1710801815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SsnJBNS+HenhnUwaG8V/oD8w5HuG+KGc9MIiH1/lxE0=;
        b=PGSR4hauuHrXbJXvKUunAIUeAGm0wjRfU96tdzDGnKNxXDQa5Yewz2zwgMut1jcjhZ
         P1iSYTq6ABzSWBsfeaqN38GdS4ihlDiIamIVDXr9HbzplpK7VJlGFu7rlbbdVS3qGf0X
         7NpO+YW2+HBhCqJjUqX9jt4mJx+3WRvPYBhKH0yrSl8ORGopH9vXhVV5n5pD4cR2Lx0I
         NlP29BmJ7rW5ptbhLTIVGggjcja3fVzTx4rRBp3AZBIuVc2+gxWGICjVCmxAXfpv3UM2
         fwDiSvyxo5XWYU0VaT9K/kwUiq1e688uuj3jNQBWPgzxHAsBlDyThX1I0zJFJW+9t9Xo
         75Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710197015; x=1710801815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsnJBNS+HenhnUwaG8V/oD8w5HuG+KGc9MIiH1/lxE0=;
        b=a5zakPu5Fi6fkrafgqvulSc/IwGNe4hVSVQnKfqOAAlBLoa3awu81akZjei/nDYikE
         F/dcIia4Jb2KAbbdyp2IJZDYoDRZ4/Q1qLHyqGDGvI5wz9V8qAqmRHS/BzhmmcSi2nDX
         dKuMUgQpc5Yov3cyOyPCQKRlnHKGYyBjKsnu9b1nCWl/9YVrp8cHGHMtJL9qCyeW7xEh
         fXrXxtE2Lq0z+MMGUfLRI5v9IalQ4G/q0IxuNLiXgmmKUMqK8oYgQ1T/zquf2jFSWtBN
         RyHrYTOtKL4NzlvRy+w+ZPoaHUjUU1mhIaKI7sGBInAIz0CKJJ7larOIMxlFAbWNtDXa
         HdgQ==
X-Gm-Message-State: AOJu0Yy1j38uPl6N63XfQC+ctghPbmghLwNmCXX0HZqoHZCox7cSbYUp
	EJhrzeBeFSi8muYZix9CYlrfLySFS6hVKR+zF/+rPZ/xy8kYbAfx2XN4Zcik
X-Google-Smtp-Source: AGHT+IFGB/aL1gieSKTI2dnRLg4T8qqstoiItvfRn+9VKjZxOfmDZOtUSVPDORxEAug7gkPlNyESpQ==
X-Received: by 2002:a67:c911:0:b0:470:54fa:b37b with SMTP id w17-20020a67c911000000b0047054fab37bmr3820474vsk.35.1710197014948;
        Mon, 11 Mar 2024 15:43:34 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id db12-20020a056130238c00b007dbb2f61472sm829979uab.38.2024.03.11.15.43.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 15:43:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 4/4] test-uhid: Test bt_uhid functions
Date: Mon, 11 Mar 2024 18:43:27 -0400
Message-ID: <20240311224327.1023070-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311224327.1023070-1-luiz.dentz@gmail.com>
References: <20240311224327.1023070-1-luiz.dentz@gmail.com>
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

