Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A19324B5B
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935820; cv=none; b=BCC3qEQ7Bn2S4fj8sEtPk7mwSBSUp0i5MQcQ3E9Z/7hdZGEuHWYYjpb8ViDF9sHvwOz1MkDICl9OreQ798xjSbhSUR92Y8QGQQD1GlQk0zYHpUKhjdpV6UsB86n71e0zOgyb9DaQVDqX4JzKSt2+98nQVN2p9sb0ict1kRGInDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935820; c=relaxed/simple;
	bh=j9bz+SgudFucVmm8NF9NFnS2fUl7HcnE5Kb1otyXLso=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8xP3Sjvgte5rogHjFy/WPVzjeEc3dOdP9GA4Gw7nma7FwTTGpVluLm2174TRFKrnLVtgUCSPmdxTLlafoIvwqiU7pJiFzUPtQ+Ul4FpakWIuvcXt9h6kSgm+B+k0RnhDkN6mZ2Vd7RJwLhtxcHPcWifhncJWBBL3y0/pt+qN+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fl8eaK6k; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fl8eaK6k"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4d34fbbd91eso811844e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Mar 2024 14:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709935817; x=1710540617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ac+TOeNfDBn3AAxKk7pgLTj6atTlKNmnyNll3+p4OJA=;
        b=Fl8eaK6kExWxK4vxLMX8ffqtrQKtSyJBZKK2RhpdHUycnjlMD6Awo7ZYEhSlS+Q81f
         BUBCK2Twf3aeMvki1ORcH3RLdfD3QAgQblU/vW5YZEAKVV9xBIrEkErYmlyzgMYJSiop
         /+C4Wik5BEtNkGHHK0G7L7AGpYNzKZu7Z2Hxo726+iEue5imH0ZrKMUfnACL853gVkji
         CkrUkxgc0mSQ3jlNjc8sTNYoNibr69oRsn1iGBwy8/lCvvsBQX4Ih2CZQeSCYtWIv5rh
         /Q8a2vIm4cbAjY+eeiiPWKWUXqRiJv+cJ4jMGZ37MQI+213D+HeXYjfCsNWts3cm/Hc9
         km6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709935817; x=1710540617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ac+TOeNfDBn3AAxKk7pgLTj6atTlKNmnyNll3+p4OJA=;
        b=YRFdIzvT5K/yS7aZ+8tMqqmH6jBvOgujtCUeYhf7kcP1KiM54xVj5O3L0r9XSf1ddp
         fV2ToA/P7VXamvuZNVROB2gAdiAlzmrgfBH4kEW2yj5ml4Z3zBIrdzp6jp0bFAjIG5SP
         98fR6LvAKwYTRXM7T2hIh7QrkNKG3Ku6lWzptrPuZABCJrjpuVMrSUET4v+tfCAQ9ucs
         R633yz6UVdHr1FSjWH1ojZWptZrsqarTspQIA/m+ox4+mtPE6PpXoY2yFpaiavjnbTEY
         gwJ7ix8Ty2NaURD+JW1oxMxUU0y2PbP8bISyCzXdaSVW3OoEv+ecsipxmyF/+MghfgE/
         W5pg==
X-Gm-Message-State: AOJu0YzRY5+UphWERpMHKzMUA67+5Yzqq7Qas0M6QEvIedSTcKtT73gR
	ThTKOEFy3YgK23y3KsQrOPsaepquUbe0Yrq4m26pxREXsjKswVwTGyhy7A/C
X-Google-Smtp-Source: AGHT+IG1C/QPtGYNmIiLPmoWuzzLw+EMpHGOV9A6PLigZMTSF3ZqsKqG+8E+2SV5A3WpCL9aJjpYdw==
X-Received: by 2002:a05:6122:4e8f:b0:4d3:3a8c:13ad with SMTP id gf15-20020a0561224e8f00b004d33a8c13admr717854vkb.8.1709935817322;
        Fri, 08 Mar 2024 14:10:17 -0800 (PST)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id el15-20020a056122278f00b004d33d93758asm29039vkb.23.2024.03.08.14.10.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 14:10:15 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/4] test-uhid: Test bt_uhid_create and bt_uhid_destroy
Date: Fri,  8 Mar 2024 17:10:07 -0500
Message-ID: <20240308221007.250681-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240308221007.250681-1-luiz.dentz@gmail.com>
References: <20240308221007.250681-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This test bt_uhid_create and bt_uhid_destroy instead of directly
submitting UHID_CREATE and UHID_DESTROY.
---
 unit/test-uhid.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/unit/test-uhid.c b/unit/test-uhid.c
index 8a8eef855bc5..f2f9cda097af 100644
--- a/unit/test-uhid.c
+++ b/unit/test-uhid.c
@@ -228,19 +228,31 @@ static const struct uhid_event ev_feature = {
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
+		err = bt_uhid_send(context->uhid, &ev_input);
+		if (err < 0)
+			tester_test_failed();
+	}
 
 	context_quit(context);
 }
-- 
2.43.0

