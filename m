Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E94A17ADFA
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 20:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729716435; cv=none; b=H0PM4X3w1zzuh8nQIoVdiuLeFDHuRD7p5iVSup0GaxcAC0dLLfmRPMhyvl07Hu+rPM1n1XpHXgcE37nPPAudglepre+sqtKhkfja/Tn1h3pJqedyqckeSgHVL1IWMUfB+T9WqErXKj6mHTtL2hYaaPWPaCZfhRQgTimvRzGry7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729716435; c=relaxed/simple;
	bh=qV1w+CduYGYvb+rBO6u8mV7XzWJIHfjELVmhXvs9GWc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtIUun3wSL824a8p447waDFd5K5jRfnCjDCzhMYZdzZEPKn4QqkcXRivKbz7Aj2oJJYJzHep8BREdDArHuuHtqGsoPExTSxE2vaP/vbJhkqJfQAyjtETDwvKpsXTwqWQEKHjLMlFATI/FxNGHVpe/FfURukV6dwmnXCP9OdossM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCiWQ4ot; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCiWQ4ot"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-50d564df009so54875e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 13:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729716432; x=1730321232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpIuY4qniF7o3P1L1HFdsmMwWpqFhjqG5ru635J3Ijo=;
        b=FCiWQ4otIFb0pHWYcGX1ewyzkhMmOXIguHgZ73wiSdHurPOfkC+j37se7eQfzdzu/8
         RIkgvwk8DwKQIdDGmq0+TNNTVHXLvasD2wMf8KzOf5Hc0wLsXJe6LP/TF8Be5yHItVI+
         /D7srS9aUN/NiEa3Kzx06Fz649v9q1H8wRfvwgmOzcTyN5wjgbiWjcNXrBWb4zdAVYgO
         BjQbgaNexTla7BVOepKklyMqRouIyZwNLnc6uCTNJ2JuXchWHRbIVGVwP52df0jLP5Pv
         J0365O2wDlqVddKzlzYIV7rrH58crfN3WQj1DIV1k9GDkottXFs32aEOshXvPAzns5Du
         dcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729716432; x=1730321232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpIuY4qniF7o3P1L1HFdsmMwWpqFhjqG5ru635J3Ijo=;
        b=wNILV+NtvHXeMtPVR4oIhZ4nQYirdeUEfgeJn+r+YzMh1pcQIoi3ivI2xUtLmJ0sBC
         0XQ5FTyToHOvkOWRQfm6hLS3b1XU50axIMd2fGIdbFUwd1HWNJM5mgGESi0PJebQ16g6
         Rr2WElvAKirPs+rBB8PNeFkKunnWHBu8AVGuNvMzvbNiSQ0oGFuF5Atm86mS4BDCPwzF
         KcLtAtaIGmGyNAZYpF+l7nEmu6mYu+qTQ2oc2P/9VwPMcXhn3kmCWEy+eNmRVTGoCB9b
         4oCyDtouC/k7QXUa/BiOg55PQnrR2o3CK0wU+IvFyMv0prTDEtoj+/XA30zEIbg2HRdx
         6htQ==
X-Gm-Message-State: AOJu0YzdA+Iu0bp6SdMNGC/1g+qLHkbeQ0x1IVx8MQ2ds4G0CSI4Tyft
	QA1ey/AGWeGabf5NqCn21VklXoUAtyz/lfv+mTvNj/Sb+OxzvXb54pWitw==
X-Google-Smtp-Source: AGHT+IHh4cxXcbHahXLDY3IyOhMBlnLTGwrlBQyyDLawwM805ILWonGLctENt9bBC5H7+EaxW6Fk+Q==
X-Received: by 2002:a05:6122:65aa:b0:50d:8248:83bf with SMTP id 71dfb90a1353d-50fd02db686mr4484884e0c.9.1729716432551;
        Wed, 23 Oct 2024 13:47:12 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50e19e0dbe9sm1168436e0c.3.2024.10.23.13.47.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:47:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v1 2/5] monitor: Fix opcode for MGMT_OP_MESH_SEND_CANCEL
Date: Wed, 23 Oct 2024 16:47:02 -0400
Message-ID: <20241023204705.2422998-2-luiz.dentz@gmail.com>
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

