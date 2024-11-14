Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB6718DF89
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731612336; cv=none; b=X/u2CRl3gf9LU750H3VcwS3VCng73dHBzJ1qcyznm1bbJmGmIEmr3z2JdCgKfL1mu4Q/OoSWdOHfhvBO2r666axS9FJYCcJ1YQ1ipK23gEkjkp4kTtWgLC2/y8oOMBiEpSQ0fLRFk40vn3dRmo5wYUrd4xpPSsNVz8NrOB/A2og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731612336; c=relaxed/simple;
	bh=qV1w+CduYGYvb+rBO6u8mV7XzWJIHfjELVmhXvs9GWc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRTV0s1DbDGUojXBpqY3Ok8RyQ0Xde20Rp6G62oWPG73MDmJBaA/ZnYWUT5c0aK2+nvt7FPzOXir8utzKdPNEBrRe1G2SeVWX1UMCWSFe/ORrstZzG1IfsNHeFBED/bgMwpFWHgoai8wTiXVTspZaZdfIQPE7/KcYERuOUGkneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrQebCFE; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrQebCFE"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-84fd057a973so400032241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 11:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731612331; x=1732217131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpIuY4qniF7o3P1L1HFdsmMwWpqFhjqG5ru635J3Ijo=;
        b=QrQebCFEd1Irowi3jmQdpoUzhSLxIfz+iEIBdXFrVhY2ZVVDEJs8pKYd/vJH4slpbf
         yLSkT+ftm+Wqe2BrehsIO3CaPR6YsSjiuXnMsFIJ5RhdPrwJ7gKHCAiWS2BUsKWFQlrq
         kyFQ7geuCjd1uFX8DkYqgPfaa0gVKd+fEeV/BNhWcz1FxoA0RgpUyJquPDKqPwFeu5Pw
         NHziTESWgpaShUgd6A+iQ33Pk4fnGaDk9tScD+FGXTI6qXfegvzV2R6bPQVkQNaD04/b
         gdtVMygvunpbjngzYgObJgPCg5C6133F2dZlQfoL05Ye7kFyPco3sUWsPzM44gkT3a+a
         /WQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731612331; x=1732217131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpIuY4qniF7o3P1L1HFdsmMwWpqFhjqG5ru635J3Ijo=;
        b=FdC+4fxQjlCTazr4FDNv0WGHuHWuacpYZGZEnbGp9Ls/KPynm44QeUgA1BKs6JLiRe
         k5KNFl9ug2Ieg95Dds71ZwGmWZrb6f4rKj3WdsmfxbH1TEB6kSXYe7Hqnh504Sf9ITp4
         gqOJuERmq1m2p8yIvP7G4AQTv5PD7ySMUz44u7g8IpYKDJdzo0lYVH6ngQitNgueOCjA
         hFXqBKO27CppEJGKbCkLxZqcmaoPvmljfh7Nj4RSoG9kGQhSHpJ1iMtAzczSeSPwgO0U
         rxpg1vILYPZE/Wy5XQ8ncNXNcFm0GbGqluDJa0h0b3M2shrkwz9Hnm6up5I8nfpW+3Ti
         /0Dw==
X-Gm-Message-State: AOJu0Yxun+FjNCRAW9jaLqjlqmPD3L2ew1hfkGIfCL8/4mWVT6yRFqJ2
	KE3iklYT2Wxxo7xhDZiDnWz2JQOI+B9lIFXj1amV4ViXxYu7oKA0WQQU1w==
X-Google-Smtp-Source: AGHT+IFOnO1Bq9IgFGLkF10Iimd5+227YIVqaZfb7k51oyNaItSrR12y5SOdWIcOwUMzkjJbvTEqig==
X-Received: by 2002:a05:6102:3749:b0:4a5:e5e5:f929 with SMTP id ada2fe7eead31-4ad630bd9f0mr189147137.13.1731612331460;
        Thu, 14 Nov 2024 11:25:31 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-856ce622853sm213911241.18.2024.11.14.11.25.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:25:29 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/5] monitor: Fix opcode for MGMT_OP_MESH_SEND_CANCEL
Date: Thu, 14 Nov 2024 14:25:21 -0500
Message-ID: <20241114192524.1856334-2-luiz.dentz@gmail.com>
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

MGMT_OP_MESH_SEND_CANCEL opcode is 0x005A not 0x0056.
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 32a440bbea68..6d869ffeadb8 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -14982,7 +14982,7 @@ static const struct mgmt_data mgmt_command_table[] = {
 	{ 0x0059, "Mesh Send",
 				mgmt_mesh_send_cmd, 19, false,
 				mgmt_mesh_send_rsp, 1, true},
-	{ 0x0056, "Mesh Send Cancel",
+	{ 0x005A, "Mesh Send Cancel",
 				mgmt_mesh_send_cancel_cmd, 1, true,
 				mgmt_null_rsp, 0, true},
 	{ }
-- 
2.47.0

