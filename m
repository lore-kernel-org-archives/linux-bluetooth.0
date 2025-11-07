Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2441A33B964
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541685; cv=none; b=rsGH/oIUoU5FC9ynynoAmKXuR0+gP/RFuP4akxQQk0BHk3KGAfsqF3vqlin1CXbfrkNA5As33kBv6EzqLHSPE9OznfdMck87Q7x9GTjcKgaD3vJPzhGxempVk/oaliy6UIQvF7NcJ44q3j3XOki4MEASsJQcCyDD2Te+HHY00qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541685; c=relaxed/simple;
	bh=A9111DUggdPLyFnwCY/jwNUHpJUOEU64ikoeOQaXuoA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/cUBE4QkxzxBD8Dnd8sP7b+JOz2Q8LFq/9rTllKnscjodHeTG7LX+m6irLTb/XoRuJd1cQyeIjRAlUMsL9GFf+DgW7zmQjxWeOZV/TisflcZxXda3pxl9rhwuVaLISq7wXPfRnR9GQ0SoqLytQUgATcSp6Vuiolv6MRKZXvBhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSIYYenf; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSIYYenf"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5db1e29edbcso368923137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Nov 2025 10:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541682; x=1763146482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71EU8+mMCRCBas/J1N81DTG0AzQF0ZNZ6dYYexH7Wy0=;
        b=ZSIYYenfT8ukZ3vcUE92Z88yE1/pAgmcjMeUH78Gwkcgas7yC7/ftSxr8XokZMQBHy
         ppBKd+bBVgmvgLwLSpatZOfsiUy2eRBXt5ozDEcMBHAvJ197tfXSQGdCyH3txRW7+GyI
         M/4hxKqJ2mJLVLBcpz4fx+ym392MTHMBDQZQq7fgqOm3cyy8cOw8N2qM6XZRyrhfXBnp
         ule3Kn5zC1UGYVTQr6DR81km07EQ702aq8xNNrhpr4Om4txkh5W8OSIAAbSC4/5Uzxz0
         cyTVNCC6u/Tq7qIC3RarlvfTk9hp+IFEoArRm5GqYiT3s6PxYupMxbcU5+tyDF6r82nh
         UliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541682; x=1763146482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=71EU8+mMCRCBas/J1N81DTG0AzQF0ZNZ6dYYexH7Wy0=;
        b=NbgV/2Fqc7Z9pJfhHT2VpYQhmKNwVWDVDkrjfA/XwmWh2pAkFGxcB2LvhsRWxU8dS1
         9bNTBDI7/RhMu9dZ32joK05RMcbBpAvGBrDtK8ksY6TYoISgJnBh3Q6Mt2TW8Js2Xz5C
         i/d6AT1zXuvR2K0XUVJWh2uTQtBJhBYQthQaUcc89+C7ryR3Lgdnqs9xC3lJ6qrIa4Li
         i/Y5/8yh2qqiDmlUnT+RfPrbwRDHZgzTaN3X3Hy7n1zqKOfUgNiVqq4sSwXOlMuyS+sD
         Jah7BsKzTUoN4v/YbRJSwFSszH6CVtV7DhgvNc8je6ll4ZosIA3s3kwOHKsUnVuaF9Ui
         I7Qg==
X-Gm-Message-State: AOJu0YyvoOaq94TCKGdCElUnQaBtgBdqgDcdPAxUYjsjHKjumKIImWjB
	Zy55hd1aSxS18Kwgt2OLLmuHRwFAFzxtz5l2+ydXut4IUnm7vRXfmPNdR7f9og==
X-Gm-Gg: ASbGncsOMvdyeO1kAbY4BaRsBf827H0C9MZWlkJlqxb3NImYgcJ+rzk5R42xeh5GOeC
	+JVdk8oXmVXrOUpKZCLnYTc4txKZhSGtXO0cnd6HV8Ean+i8M0OERZ+jMUmswuJk7/n9i2q7Sja
	bSi8JbivxWk6AQcBO3zFzXQrjAOcwUiYST3Yqg8Wb/aIWZfhOUQuF9hYMIXg5ftwhyKcLUevUYz
	PS1ffQZx6H4IrRKWoYo3zEoikQteW+F29mwvOaSotau0TSM/L19fHS9eBUCGQMtvzSvLd8NRef3
	D6MbsYoCbM2bMBmYwsI/gjNHbS79Iha0brOsUzMaTUG3BTqy1hEtGSd3+YK4+Ke3glXrcVJjNbg
	ByJmiTvzNrNXp4hWtBW/FUpuXSXKp3JKRl1dIUdZnl1ydBbiG6H1mJdupiLui5t2pCTNt+0UeYc
	daN59Bgd003f91+A==
X-Google-Smtp-Source: AGHT+IG0+Pg1wDNi+0uTfoxacSOg5JTbwa+XJ9PWJcM4+OISRTd0CvLslYN022uzdwJdvc5YpwYBhQ==
X-Received: by 2002:a05:6102:3750:b0:5db:e64b:f68c with SMTP id ada2fe7eead31-5ddc4816e47mr237506137.33.1762541682350;
        Fri, 07 Nov 2025 10:54:42 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93708522abcsm2738698241.0.2025.11.07.10.54.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:54:41 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/5] bthost: Add support for terminating a BIG
Date: Fri,  7 Nov 2025 13:54:25 -0500
Message-ID: <20251107185428.1161318-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107185428.1161318-1-luiz.dentz@gmail.com>
References: <20251107185428.1161318-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for sending BT_HCI_CMD_LE_TERM_BIG via
bthost_terminate_big.
---
 emulator/bthost.c | 11 +++++++++++
 emulator/bthost.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index faabbaa36a4a..9f9538d0dc2c 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -3780,6 +3780,17 @@ void bthost_create_big(struct bthost *bthost, uint8_t num_bis,
 	send_command(bthost, BT_HCI_CMD_LE_CREATE_BIG, &cp, sizeof(cp));
 }
 
+void bthost_terminate_big(struct bthost *bthost, uint8_t reason)
+{
+	struct bt_hci_cmd_le_term_big cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = 0x01;
+	cp.reason = reason;
+
+	send_command(bthost, BT_HCI_CMD_LE_TERM_BIG, &cp, sizeof(cp));
+}
+
 bool bthost_search_ext_adv_addr(struct bthost *bthost, const uint8_t *addr)
 {
 	const struct queue_entry *entry;
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 4061c0be5349..ce6bd820fefe 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -128,6 +128,7 @@ void bthost_set_pa_enable(struct bthost *bthost, uint8_t enable);
 void bthost_past_set_info(struct bthost *bthost, uint16_t handle);
 void bthost_create_big(struct bthost *bthost, uint8_t num_bis, uint8_t enc,
 				const uint8_t *bcode);
+void bthost_terminate_big(struct bthost *bthost, uint8_t reason);
 bool bthost_search_ext_adv_addr(struct bthost *bthost, const uint8_t *addr);
 
 void bthost_set_cig_params(struct bthost *bthost, uint8_t cig_id,
-- 
2.51.1

