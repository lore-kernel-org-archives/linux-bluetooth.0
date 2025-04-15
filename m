Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630182DFA20
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 21:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753700; cv=none; b=Ivuka6KZ0ru+vuAJmyXaQMV+fiIiWpWoAFeeCmO2VyS20HApJr2lfim12FoEtUTdZ8t5BPePbXf/DjXLEJnroSF3aZnnH6CH5Uj3rTO92rPoCLzX58PDY7yLkHa0U4yOMa54o2cJGY18JAVnat5w99o4SfmkJzajM3+sN5YJkxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753700; c=relaxed/simple;
	bh=tn3LLMUkmIgzSHBzNCOPge8xddrWH9LcOTg27zwPgds=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J42Q7AxOnIEW0EfZsaedCrOLDFhmCUcbbFGN+Ufu/y1xDTPSciMnqv48KcsWAmHUx1WoxbALFD0uDeLpOkNI/tEDl/+Mb1Y/HpsfUzLSFCKd971BuaTKob66PU8co8GqHB++4sg7nwx1FHOKIoMZvtbpcg9NKXrOj8vwLQ/UgeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhQ/YNe+; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhQ/YNe+"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-527a2b89a11so2546222e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 14:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744753697; x=1745358497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qAWmu4uWB6mmSNQRF8c6wKOSO8fTTfpFkXVXjHgTSk=;
        b=fhQ/YNe+CahBs+4eGa5NSpRHK4Dy3QMQLlbNnkZcEySHCNljsh2FZOXVq2rrrLXpEH
         GvtpfaojskWURBQ3765ZTuAiVSvIKgV5kWTkWad9aMdjwYVrbQcxwObzxREvKFq4Ak+y
         DiwvayYthTeTm6BxIf+EVIncJqohuIyvTO4VINvsgk9znvqCM3I5HR23iQ6vxb5oRc+6
         V1JfhWbv+rW0glQjIri8oJvX4JBzvXBXymNgC+JTYfDs8WAz7RTy8nInNREO6u42k7CA
         f25Ze9RQVERFUYj/PXJolHSd6mXFU4o/sZom3H+uCFOlE3I13FhXLLLJEoz+n/7wBiTr
         qWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744753697; x=1745358497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qAWmu4uWB6mmSNQRF8c6wKOSO8fTTfpFkXVXjHgTSk=;
        b=DS4vafKlTYyYbN4Xk0pAAYvyjqDwxddOqrX13UWTCbW97lkWFz6V4rrQk1H5NIjKjv
         LGFO7ibPvh9fAcRfeNWOROKHRAW4kxGQe4COlONgP7alRfoInHV5qQrqVI/RYLgqWrje
         86EeVEPX/Jp7yqGZRLTB6oudsUD8UjZUsX2h39eIjN3PSRTT/stupsrXdYHBC1sRZi5l
         riX4cdoKHydHhbk/LaGSi+sjzZijXLMmAPtCOIEi1Go4IMw3p2mwrQGtYvEl//k/Ekua
         XzgKPbMsMEI4JJagpGWi9iwTA2mLt9mFbAZrEkimJ3Kxs2mTTH3aKfopTBV8EiRAchRk
         hqhA==
X-Gm-Message-State: AOJu0YyZcUib5dsTrVGfZg0G0Gj2YbGtUtIQqg4lNlh2hW0NHJhHxBDp
	YQpvKo8a7rgHqljYFmwsV0jSzlxWHN44MsZGLDm40CbcghB6jYRfS0cVlGtfVBY=
X-Gm-Gg: ASbGnctT83nkEOOBij0KhZnMXy7UnLDM1puQFHrRty1/4xxiwI+qVInGsbSI+92d/PB
	PhxDsb8VQAPyn5g7s0Unl1S6LebtkFnZZAwVQCt9BqNDEfnIOCrw0+CXIpLXWR01FIG9uFTKa5o
	k0Ol7Ohp/M/kxKA1cjhO5I/fhGZzQrsqqeZ6DY+ATdSIVKfv+XN8mcQ+cGyn+M7z5CPYh9WZtoS
	HDwVstXrbgb7zTPNqSKCAXyF+eLBA9CwbS9/kcOhy2HzJo6H25t2NDcbdczN+NFFXne7oClyohi
	1UvH9ZtCgPagMyaUa7rA3MDei7yVCMm+XlgBvTnWFEbtcP9ITFbsFhCIbP7npmCXFrySAWK7Ica
	6Frq/mbs9IA==
X-Google-Smtp-Source: AGHT+IHcwLMPmq7vYPoLYRHzX7sN1yNxg1hBAHQzBWwlefGiqGdZQpkd1oFLzrK1bQC42rb231vX0Q==
X-Received: by 2002:a05:6122:903:b0:528:f417:6f95 with SMTP id 71dfb90a1353d-52908f9c012mr959811e0c.0.1744753697394;
        Tue, 15 Apr 2025 14:48:17 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-527abe8d740sm2844459e0c.33.2025.04.15.14.48.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 14:48:16 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/7] btdev: Check for valid SID on BT_HCI_CMD_LE_PA_CREATE_SYNC
Date: Tue, 15 Apr 2025 17:48:05 -0400
Message-ID: <20250415214811.1677842-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415214811.1677842-1-luiz.dentz@gmail.com>
References: <20250415214811.1677842-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 emulator/btdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 7e4cb9393593..a1c82ae306d7 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5728,6 +5728,12 @@ static int cmd_pa_create_sync(struct btdev *dev, const void *data, uint8_t len)
 	uint8_t status = BT_HCI_ERR_SUCCESS;
 	struct le_per_adv *per_adv;
 
+	if (cmd->sid > 0x0f) {
+		cmd_status(dev, BT_HCI_ERR_INVALID_PARAMETERS,
+			   BT_HCI_CMD_LE_PA_CREATE_SYNC);
+		return 0;
+	}
+
 	/* Create new train */
 	per_adv = le_per_adv_new(dev, cmd->addr_type, cmd->addr);
 	if (!per_adv)
-- 
2.49.0

