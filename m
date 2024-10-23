Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEA51E0DBF
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729716440; cv=none; b=cekfWx1eECk+odWgajclKHvH8g8pgXNDB7+A08Hmdo8oFyhh7NBJ/lx8s1DDeK3qLldoGcx4LmHU7d604KRJmK7OnQDilZKreRh3dH80wuGv0UGbvfx0wHOfhsMi/2/Sj2z00Am68zWXTE/WdqQez40iY5QpcZHNKe9IxAdIhA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729716440; c=relaxed/simple;
	bh=0+bhxevoKtrickIUyLV3SLHt0wRxBEWhJsxZ7BcJLVc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txQRfKUI6jKh/Iz9UFn8JqSESwBzAJtwofcNzTapssFea0k91ylEqHfWyJRNa4wFWSRTvZQl1MRYeMmvk7NbGKxm1McHsaswRHESP3ZMu+NP+N5M2AckxtWH1glFB+RGBP49cMHE198EpmSER2m0v29YoaslR0xQgM0EpV2U5rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYLDDWI6; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYLDDWI6"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-50d2e71de18so59022e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 13:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729716438; x=1730321238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JpMGUJhSDYAuV1a3EYKSNR7JPHa9+0fIstpgIY+ratQ=;
        b=YYLDDWI6sQJbKy3pKh0CY7vhqU2rYcVe5VNhvZ1+p7VIkt017jW6h19BJrT7nLPDLz
         5+K8gzdzhFnsxOGdqECp3tjIQ7TAyQG4wBbn8UMCBmg+9LkAHJJfRMMuWmj6rMElwnVJ
         g2nTTmcXqpOgY9tuG6SpanoazF3aucoE7dmTHQownYjb4WSK0JtxeZCaj0Kukl+gq+vv
         eGwZgfNo9lD16EkmLSblHRWSryjSFN6jgsW/JhBCpqU33JTgg8OCVTj4o48OF50Lk/oS
         zUQLr8PNjBlA0AzSfeYyvat8BXo3PuoEFzQVk3EhenDmdgQO23o6L/HyFZnlmF0zlbOB
         MoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729716438; x=1730321238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpMGUJhSDYAuV1a3EYKSNR7JPHa9+0fIstpgIY+ratQ=;
        b=mYen8PKgL5wavjbs8fy/ZfGSzuzgKAiAqs7Mj4EasHLsx+WS3nYdr/U2V4xNzaCoWl
         G9KVP26lYNgi4j2fOuD7DF2L7o7h4vZG37Gd9AmItpSvtvDxhxXV6HkbW5XTNSOGFjab
         rMIf0UN4E3RtcUrNitMyGc1CKsIPuYCZ7KFIrVSi7vy6mHG88bu3iTuNyAR2qJwL4XFP
         3obzDhEoIVoPm7x83stl2SkXOT4048HUOTQ7+vdmJIEypCroAxUf5F7nXBMSKkkyRuSN
         uf2oLr6SBncJPQswkrOyn78plAKoQryGyZe0M9oqDb+yi9gl+Hod2gUAAApVCR5P7FVM
         Toig==
X-Gm-Message-State: AOJu0YwwVnDneEJwtiBceQ6bMf/d8Z6DTsIiGN4+S08xHdSfGYCNIxRr
	Ra051HG8S3iaftkl4W2VGrL62pkHADMIdBdVt4bpxmdVXulG6DgJjIfalA==
X-Google-Smtp-Source: AGHT+IEgcIWFVPe/BQGpGVxPzgorQ5kkbJ9j9PLQHGzm4ZK4GQUokFmiSfNY3upaWgBfV82RVd7keQ==
X-Received: by 2002:a05:6122:659b:b0:50d:5654:951 with SMTP id 71dfb90a1353d-50fd0216b1bmr4825013e0c.5.1729716437616;
        Wed, 23 Oct 2024 13:47:17 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50e19e0dbe9sm1168436e0c.3.2024.10.23.13.47.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:47:16 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v1 4/5] lib/mgmt: Add definitions of MGMT_OP_HCI_CMD_SYNC
Date: Wed, 23 Oct 2024 16:47:04 -0400
Message-ID: <20241023204705.2422998-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023204705.2422998-1-luiz.dentz@gmail.com>
References: <20241023204705.2422998-1-luiz.dentz@gmail.com>
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

