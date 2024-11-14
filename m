Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A4919E98E
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731612340; cv=none; b=tsEMji79okDR0dnNgK+mEop5L5j137ceI0FcTYbBPykQlFOes3Xl6SiCcsOIMopPtLF3c9/F4SM93nRJd92/PbxHzx1xmj8auXeDupGscJ7ELgEwvHo1jtUYhlLkK+cH64m6v3CQoKcwwN8mldmvhEdCSGvGGlutNkIrzk9zyBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731612340; c=relaxed/simple;
	bh=0+bhxevoKtrickIUyLV3SLHt0wRxBEWhJsxZ7BcJLVc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXMqv/0WkrYUBRW0Vqqw7ZEl44/4oVCFAm8A/oxQxL9G0qlcvVmztA5d8idzpw4jzvRoirjjt1wQyXok5w0TmOqK2m9Q2P/BfuBWeH6L2iIwJFu+6trhVAuoLQYD2gqWAEkTMQCe7iJxw5Nn5B0rdBtvv/Ti98TxLpExGIqJWzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPtTsjCs; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPtTsjCs"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-856d47976d9so361191241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 11:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731612337; x=1732217137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JpMGUJhSDYAuV1a3EYKSNR7JPHa9+0fIstpgIY+ratQ=;
        b=cPtTsjCsVbcBtaIJehTMI4kMIrjxxW6WhGPraTyUb+PUf4Z7zY1nMed8F2A7d+UDCb
         WSoXsuSUUcwsMyO6Bcpw4XXoPRD+Uvk2SuNgtnEqfuITa/88ZvSz9qea6iIhBGmfRV9N
         Jn3pDkUk4RG2+TTqnG+uow5SrgeCmkuiyoNpqYe6GzxQg+T2DC+e5S240RRCoxD5xCpb
         V2RvzfakMpJE54l+Wll5bZIu4bzJYedISTGxAMOblLP21beUEWPXW0ffY37YRjmyZr8t
         wsBJKv8CkPCnZwpgVN3ZMD7KnWueHoHsWlsMBQc9vQ2XlPTzhz7eFNBkAhVK192fAxyD
         V9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731612337; x=1732217137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpMGUJhSDYAuV1a3EYKSNR7JPHa9+0fIstpgIY+ratQ=;
        b=ugYeAbtCs+6mG2q/fPoObYC3L0hQmg3ZVoZ1oF1ydy9cv8job1SBGeiYkBtgmAe+z7
         WbT6DZ6LVwx4TUWKD7vnGsX/8M6+KMkQgy+Uhgt61iSXtaULv8+bHEbK9BP+vj6Zsfgo
         4ZoMHXjIw0bUoMYttwR+dfgvDFO075I9P+8+gKw7gd4DHn2k9p4D6vIhy1X/Xakhpvef
         +aLM7khogFTL+MrbJjIecdBl2K5nO3ht0kLb0BBCohiikfz/vBb885qw2OWgMS/79MRF
         5ZjQ+h/K2HZe8Gf8kyHlL5wx1o6B4uVUlMljGHqv6AfQLd+zEjqdDKMDwsJmaCN8PAvb
         6RRA==
X-Gm-Message-State: AOJu0Yw/g+z3TxcDxifUfASUuvyD66rH/g/HgY8OVsR21wU7nwtsMCFQ
	kUtFc5hSeeTlwt3DxkgNvMyNcNm1G0oPK86wnkZoinUad4NxEtnOMZA9pg==
X-Google-Smtp-Source: AGHT+IFgeG3CiMRs9XnuxmBYoTjb0kxg7/KpvqD633qjUn0M8ASdjvBCeIQuTjJyD6a/yd3DUfp8Cw==
X-Received: by 2002:a05:6102:dc9:b0:4a7:487d:88e4 with SMTP id ada2fe7eead31-4ad62b5bbadmr273692137.4.1731612337268;
        Thu, 14 Nov 2024 11:25:37 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-856ce622853sm213911241.18.2024.11.14.11.25.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:25:35 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/5] lib/mgmt: Add definitions of MGMT_OP_HCI_CMD_SYNC
Date: Thu, 14 Nov 2024 14:25:23 -0500
Message-ID: <20241114192524.1856334-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114192524.1856334-1-luiz.dentz@gmail.com>
References: <20241114192524.1856334-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the definition of MGMT_OP_HCI_CMD_SYNC and its packet
structure.
---
 lib/mgmt.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 8f92b77315e3..f784dcada191 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -797,7 +797,16 @@ struct mgmt_cp_mesh_send {
 
 #define MGMT_OP_MESH_SEND_CANCEL	0x005A
 struct mgmt_cp_mesh_send_cancel {
-	uint8_t handle;
+		uint8_t handle;
+} __packed;
+
+#define MGMT_OP_HCI_CMD_SYNC		0x005B
+struct mgmt_cp_hci_cmd_sync {
+	uint16_t opcode;
+	uint8_t  event;
+	uint8_t  timeout;
+	uint16_t params_len;
+	uint8_t  params[];
 } __packed;
 
 #define MGMT_EV_CMD_COMPLETE		0x0001
-- 
2.47.0

