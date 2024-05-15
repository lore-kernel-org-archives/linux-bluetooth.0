Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87A3156256
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789579; cv=none; b=Pg5ZGnJ7Mn2JFd7Phal3NCByteIMbhgKy2gyrOICZx5h6rwrogXcm6tk0ttjdRcWJUqeXWof17VwLOt6m+T89STpH0tzoS0hQHGG95Wu2EgeFXAyRs6BlALIV6ALdQMKsLW5YfMctcKy11BrbmWJds37JqRsueY101dzYVuNJs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789579; c=relaxed/simple;
	bh=VIuAmRE8nO/J3UHLv/JJx1vQzvRS/zObSE/ZHnyabNU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYGTnXGXlnizgs5qIUJzy5OYBanPTSySFOgO7dDR/GvbG3swnot/+5W803UZ0M5+WZ4sUMxBZshpqbxtA2Bsms/geufcmPh8Yv1xuY0bSJW5YufhA5NTsTOhARu+7J7BZNNcbtjL3rTnaLGkQ8NEqkRTvdBYBYrFyHsxGj/xs84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzxdF6yk; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzxdF6yk"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-792bdf626beso643145385a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 09:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715789576; x=1716394376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+wfVKVUYiLyErPZON/jikVxcIVeYEcr6S7rKaXnSjI=;
        b=DzxdF6ykTQhTSBffhaMfKPf+Qfueam5vAwN0OISvbGefyd9JQIccPmHaau8VRTQyRv
         vDoEsMcfIb9onpPBQdb6NSCpPisEWvIIp86JvSo0zenn3Qk7qvZNC0ao8uwiYl+GdYFf
         pmIEHPZe2BFvNT7eVgWPRjej0S38A6F3cO1TL/ngo1aVHmdYyu51XFvWYzoA8Ksx7n/z
         B2/C5ceGmVtzMKzl3tJ2iPOvTzcRnznCBCOtnFxxQux7zR1RqJpVR7qOHowY7WSlef3z
         wQMfUEDqsOJ813RGVQtkZxmfAyWT88CuCBc4huDkl5fnCuaX9tJEBilROKHh2YWVh3T9
         rU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715789576; x=1716394376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+wfVKVUYiLyErPZON/jikVxcIVeYEcr6S7rKaXnSjI=;
        b=xNq/MJKu7RQpikUD2ZoEFOGE9mhoh+iH4fwjCiQg9WUZQko+oDMFvt96dpDruA2jqc
         Fx+qtuXdaVyE+S4Q3POlKz+i+Buz0pSneCQvLVdDxGnsWObW0M3RJsyc0IwvEXP0YV/F
         5fzmYPun+iScXxDQ+VrRb3BYJuN703PnA/wVhHjYq88E9ncRrtim26Y4gUjJ9CAz4Wz7
         xd+CB0quNPsJMEQwrWFYqAYl/ninf03lLCOkt4m/IeY9ke+48ZNbY2yfBzENt++zmN/9
         XIeJrQySgEM+U4/0OWVZu9W+V4d0pT+UrEAYNC2XQMduBzq5Dc99yI4Lb9JPxMyph3T3
         pPOQ==
X-Gm-Message-State: AOJu0Yw/wyuwgt/wuoTZiS4oI4VwyOsr9Z5UzEiyVMICEPqUdsTfpQZM
	Qo0Oeg7GkjiPfDn3z0aoNqOXxq4EeQCaZ+zl4Jh82HkjdNlCBFYOFFCOwQ==
X-Google-Smtp-Source: AGHT+IG8n6Wa5R5rIpsAPwvOFir8A4fy0OMIddP8drdYpU8gX/SP/nQsY1CdLY1Hb4gaaaHLtVfP/A==
X-Received: by 2002:a05:620a:414b:b0:792:f3b0:c64a with SMTP id af79cd13be357-792f3b0cc1fmr596463585a.31.1715789575938;
        Wed, 15 May 2024 09:12:55 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4df7bf7beb9sm1819877e0c.20.2024.05.15.09.12.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 09:12:54 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] advertising: Detect when EA needs to be used
Date: Wed, 15 May 2024 12:12:50 -0400
Message-ID: <20240515161250.1714375-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240515161250.1714375-1-luiz.dentz@gmail.com>
References: <20240515161250.1714375-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to detect when an advertising instance needs to set the
secondary PHY in order to force EA PDUs to be used because its data is
too big for legacy PDUs.
---
 src/advertising.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index b9d923d5d2c0..5d373e0884b1 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -884,6 +884,13 @@ static int get_adv_flags(struct btd_adv_client *client)
 
 	flags |= client->flags;
 
+	/* Detect if the length is bigger that legacy and secondary is not set
+	 * then force it to be set to ensure the kernel uses EA.
+	 */
+	if (bt_ad_length(client->data) > BT_AD_MAX_DATA_LEN &&
+			!(flags & MGMT_ADV_FLAG_SEC_MASK))
+		flags |= MGMT_ADV_FLAG_SEC_1M;
+
 	return flags;
 }
 
-- 
2.45.0

