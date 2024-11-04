Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0361F583F
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 20:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752556; cv=none; b=YHpn7byu2J/PUhaY9bLWy7HFE6KwEm3WUvPJ/1Hg3JrokeitOBQjcKCCwBOCaq83Nu/5T4HTK0g+czhjqR3GCsknrIIB4OXIHoswPjPWOW0f1XEPMKo533D/bBvPVJCPO7Z2iw7b8g7v3qTm4F24/TPszaDAzyTnibkM1nNXic4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752556; c=relaxed/simple;
	bh=cHKpst/nfcM8K1mHTmbK1Sp8uLyzxkR1UPcFhYzGydY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tMqa0a9/QWbZUCOJGtq/stPF514pY9R42BlDn5tod33o42A2fPgTekCJuyUGq8Lo0W7/BNqsOglAiFX7QT0FAqXW7tgqZaK+l0Ffo0ADsh6BRX1YQksiXqjcAQ4VO56jGbT+4L5YV0ONLRSA9vjeE9uc+B9ItdMVvToj7hWkchE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyQPRsLP; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyQPRsLP"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ec2798661aso2192345eaf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Nov 2024 12:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730752553; x=1731357353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uz45gghumEQglaxtwtVKAAPSmaTFvaP140kymFddoXI=;
        b=TyQPRsLPRZkfh8AivoEZhXUUoZeY7+Fv3+7s3ADyOmRFVf+G8S0iKu8JmnIgCVMsz5
         oNI2x4egJS82FnC05+krJOAWrE9nNl19EI55g0d03F8mhjC+E4D08Njni5AtfXv6mKEt
         B+aO6ExF3Mc95hqvTz2Bi+xx5yrufp9rVP0giiD7SNGo5sYckc6b5M1IIlva1eFi2jKo
         fv395a3OR2DcURw3sLKSabC1MmnGipUEuf0GTT1KLQeui6mjEUCnsMuuobV8AMM1qxJK
         31SPgbqQ0wSZ4ASepqCeXt1K7Fn6SwEgjuP9rX98RNi54DErch1wzPvx5sSwO6epVSdE
         CnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730752553; x=1731357353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uz45gghumEQglaxtwtVKAAPSmaTFvaP140kymFddoXI=;
        b=MjJsWe8GPiER9++hOUPqlfFt4wTyXfqrdqgWKNXlsD3X/nX/eUiPzokKUo7bcpLQIz
         8ANTzTIAEAm0x/bgV/4EGT7LsjBZh9t2dUouJ07A8WraAUk6qcQpSJdutqdVOgKpVFs5
         eYtuybqqe6lDnSdtQuY6NL/lSR4J/08scwoA7Zf8daAqamo7VN1nFmKgT00o+L4YcqFQ
         my/+gX8rTuVbfyzTlNjciW5D6kw1HApJboSuZBymb+kR0mYpd3oqkBG1Old7RYMMmI0V
         LsEkvVIahvFbBPs2pjyORjWGVlkagfE1C5I9uvpZEPvSDga+h1UkZdR2vyN+jLca+znK
         foWA==
X-Gm-Message-State: AOJu0YzlBdC4GDyt++3MMQYIF3nZd54urEYdfyALU+/RgJPEi/Sb2kqW
	n9nmEgrxKcbe8ne5MSn6WXrcmwJkeyVNBz0gsRzJXP/QFRwCHyCqZSSVig==
X-Google-Smtp-Source: AGHT+IGLVrJ87g68CteAoaqUMnzfxpuWx0NaxkFOgwAy3ZBHhrM1nCSmaPqed9nHLCkjZ4I7BtkhIw==
X-Received: by 2002:a05:6358:618a:b0:1b8:445b:af5b with SMTP id e5c5f4694b2df-1c5e344bdf0mr1183113655d.17.1730752553376;
        Mon, 04 Nov 2024 12:35:53 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4a957441fdfsm1846062137.1.2024.11.04.12.35.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 12:35:51 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] adapter: Fix up address type for all keys
Date: Mon,  4 Nov 2024 15:35:49 -0500
Message-ID: <20241104203549.772512-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

66a8c522b64 ("adapter: Fix up address type when loading keys") didn't
fix all instances of wrong address type being loaded, so peripheral LTK
and IRK were still left with possible invalid types.
---
 src/adapter.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2bb94cf1673e..f422bbaae155 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3994,6 +3994,13 @@ static struct link_key_info *get_key_info(GKeyFile *key_file, const char *peer,
 	str2ba(peer, &info->bdaddr);
 	info->bdaddr_type = bdaddr_type;
 
+	/* Fix up address type if it was stored with the wrong
+	 * address type since Load Link Keys are only meant to
+	 * work with BR/EDR addresses as per MGMT documentation.
+	 */
+	if (info->bdaddr_type != BDADDR_BREDR)
+		info->bdaddr_type = BDADDR_BREDR;
+
 	if (!strncmp(str, "0x", 2))
 		str2buf(&str[2], info->key, sizeof(info->key));
 	else
@@ -4035,6 +4042,13 @@ static struct smp_ltk_info *get_ltk(GKeyFile *key_file, const char *peer,
 	str2ba(peer, &ltk->bdaddr);
 	ltk->bdaddr_type = peer_type;
 
+	/* Fix up address type if it was stored with the wrong
+	 * address type since Load Long Term Keys are only meant
+	 * to work with LE addresses as per MGMT documentation.
+	 */
+	if (ltk->bdaddr_type == BDADDR_BREDR)
+		ltk->bdaddr_type = BDADDR_LE_PUBLIC;
+
 	/*
 	 * Long term keys should respond to an identity address which can
 	 * either be a public address or a random static address. Keys
@@ -4117,7 +4131,8 @@ static struct irk_info *get_irk_info(GKeyFile *key_file, const char *peer,
 	struct irk_info *irk = NULL;
 	char *str;
 
-	str = g_key_file_get_string(key_file, "IdentityResolvingKey", "Key", NULL);
+	str = g_key_file_get_string(key_file, "IdentityResolvingKey", "Key",
+					NULL);
 	if (!str || strlen(str) < 32)
 		goto failed;
 
@@ -4126,6 +4141,13 @@ static struct irk_info *get_irk_info(GKeyFile *key_file, const char *peer,
 	str2ba(peer, &irk->bdaddr);
 	irk->bdaddr_type = bdaddr_type;
 
+	/* Fix up address type if it was stored with the wrong
+	 * address type since Load Identity Keys are only meant
+	 * to work with LE addresses as per MGMT documentation.
+	 */
+	if (irk->bdaddr_type == BDADDR_BREDR)
+		irk->bdaddr_type = BDADDR_LE_PUBLIC;
+
 	if (!strncmp(str, "0x", 2))
 		str2buf(&str[2], irk->val, sizeof(irk->val));
 	else
@@ -5000,27 +5022,11 @@ static void load_devices(struct btd_adapter *adapter)
 			goto free;
 		}
 
-		if (key_info) {
-			/* Fix up address type if it was stored with the wrong
-			 * address type since Load Link Keys are only meant to
-			 * work with BR/EDR addresses as per MGMT documentation.
-			 */
-			if (key_info->bdaddr_type != BDADDR_BREDR)
-				key_info->bdaddr_type = BDADDR_BREDR;
-
+		if (key_info)
 			keys = g_slist_append(keys, key_info);
-		}
-
-		if (ltk_info) {
-			/* Fix up address type if it was stored with the wrong
-			 * address type since Load Long Term Keys are only meant
-			 * to work with LE addresses as per MGMT documentation.
-			 */
-			if (ltk_info->bdaddr_type == BDADDR_BREDR)
-				ltk_info->bdaddr_type = BDADDR_LE_PUBLIC;
 
+		if (ltk_info)
 			ltks = g_slist_append(ltks, ltk_info);
-		}
 
 		if (peripheral_ltk_info)
 			ltks = g_slist_append(ltks, peripheral_ltk_info);
-- 
2.47.0

