Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AB256B95
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182709; cv=none; b=HR9pnokRT58fENq69lCv2zxx3qer40z3UDU1RUtrmqhj/aOWU6s8UnYe64acVaFIeppmOtlAyh0xMFJm43IYmcHe4BSx+NP5wZCDi9fdxJht0Z4vb4PlaGfMuMBFfipu1yTkYLpTSW3uea4zNjPGf5dPxBNZvSg8goenreGpWss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182709; c=relaxed/simple;
	bh=ktCDJFIjZmovCa4O9v41Z8BzLz96D0R2evO4xIPmwNM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VurpbQB2UIlssytyJ53j/yYFP//N1rReRWMiM/UkxWfANjlzB6K/vhN+BzlBJT1BWz3/ADc8o5e7b8d8tJDL0qt3VwH0rA6qVXxXCnz3TvvF0SmyXVVhiX00CUtPJFeJL71bUpnKth4k4nFbq6XtvWbuuj2sOywe5EG4swN6oeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8zZtkGO; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8zZtkGO"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4d34fbbd91eso1113566e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 11:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710182705; x=1710787505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SsnJBNS+HenhnUwaG8V/oD8w5HuG+KGc9MIiH1/lxE0=;
        b=l8zZtkGOajGRwOrInbi0z+hG1cbXRsHcmanAlxgqRJuWyEW6gvyLqU/KxHN78uJ0KT
         Fn6SpLqVxABfY3S7/LhFy8HPkXvDzNpg32HVEUXL+ki5VuFTeZ+GXQ5ilgWVk3Y2COx6
         M7yza2zaa9tQT5NuO2kMSMN7sfehxhBoC83xhKdklObYrkELWQtvHvFKvWZabC0s6rBU
         6Xh1JnyA66OzwOv7lZKXqEYvMYg+cYRfXo+h9oKZoTkaGGOOjfLrvHzDNChm5fjdQr3E
         hvJCJVyOc7XJGxQEVkPU+3cn5iqkjYztk3va9UM8xMnCehlDLtltCr/UocskIcVgqE94
         HfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710182705; x=1710787505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsnJBNS+HenhnUwaG8V/oD8w5HuG+KGc9MIiH1/lxE0=;
        b=aq5O20QRrWvjE/EfTGBA38t7mtwJVQxRoXJvDpisgJxJtA9X6RBzzNzBKdvqRXYymN
         XPAsWv4gSrLYiccntBpXKHTo12r9n1VrRhZ+3Ai4Hl8ygDu+FBnmqPTGbC4ifqEwX9na
         CB5pnE3rvkrMLSu1dZFDyg9Xp6NwM/cA7tNJTbenyGVtL6LLMwFgCuX6QyuCSq/hWw1c
         5deb2ygkHsKXAhng32hzPDR2yJpeop2LUEXg6Lejdwthrk1CWehSBpxSHWWnI6/n9gl4
         QzYudwdkXXGejv25MAAlz8ALs3q0znC//HJXcOzPoWwE67Q+3tfVzw45NCbF2ISvHCEq
         gm5w==
X-Gm-Message-State: AOJu0YwfUx48RsCEpddFblbFF0owHSqguqreB9jb/16lC9D/DhT6GI+D
	XZc047KeZ6LHT0wui5Wxxg/HRcQyciGt0zCoZjRbG5joU8nKZyDY605EJs2y
X-Google-Smtp-Source: AGHT+IHkCb5q2pBzSut0UBJbQJrh+opjuE1Ls8xeAsFGacvtElMrm6isOFnppB3smm3+mVfuH4psKA==
X-Received: by 2002:a05:6122:3113:b0:4d3:1ef2:c97d with SMTP id cg19-20020a056122311300b004d31ef2c97dmr4132364vkb.2.1710182705548;
        Mon, 11 Mar 2024 11:45:05 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id i15-20020a056122128f00b004c003cf5e14sm672510vkp.28.2024.03.11.11.45.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 11:45:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/4] test-uhid: Test bt_uhid functions
Date: Mon, 11 Mar 2024 14:44:56 -0400
Message-ID: <20240311184456.890351-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311184456.890351-1-luiz.dentz@gmail.com>
References: <20240311184456.890351-1-luiz.dentz@gmail.com>
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

