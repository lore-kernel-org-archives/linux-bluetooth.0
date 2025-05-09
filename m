Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6346529824A
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 May 2025 20:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746821892; cv=none; b=g/wVS8tJY1YU3N50MAbApZUJtoTiJ3Sph0bO19zWPzfBoUZJ+pVE43KwKdjoLh1eRX0VRwituMmfkimdjm06cbwdJRU3wVlF/tEzqVwGo+kVAzkskHdmAQcXK6xYTTfKe824p3pCAMTyzipjDQtaXUAdOHEMqYuhg7o6UjMii0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746821892; c=relaxed/simple;
	bh=EW2WzozGO0UG+MxHrbCWktHtfo7b6wSPWpx6RBeM/A0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OBqakhNOaPdatbgUPhvycmXLVldGwUm7esleUaCuum4hayRpKoUsU4p1VtMQtXDEEePRRrlFuXJbVZOivAP27c5NJMQNd3HYhjulFPSMGaE42Qg+FWuISmBnsXmR8Bwfs6YnN0V5cO9yJ5rB5tZGxa3S4y2eJRwZ7tZI76RGjl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGc7N3AZ; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGc7N3AZ"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-527b70bd90dso966044e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 May 2025 13:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746821888; x=1747426688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaAjeEXdPdgr3L34i8hx2y01MRMv3f9eWTiIgJOe2IY=;
        b=iGc7N3AZo3sP5PudBwrRk+x0C6PIX33rj+oXv0iHMabzH59qBMW4GgWMr1IHjy/UdO
         kQ+IypaPlVDMOFXjH8wr6cjLs9E2CPCJv0h7bUid0PjySJZIQovAXQivpXDqc2iv6WsX
         L1qBAmirx9cL+CJTg8UamNM8xljR9Vm7f8fMVgXnUXqgRvUJbpWCkvNdF7Mvu1V0Im/u
         XfUbmnCtdSKE7KzRdovHftYABk3Q5ActbyBCMjQs41SuCRNLZACFJ/q7sEoij9agBz2j
         DgDI8kj2z9TbNhYcQAQJmoTzGm89fZRdOnqOdGNQZE8P2G8pf24Nj9yXaPJ0O+JBwF/2
         KUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746821888; x=1747426688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaAjeEXdPdgr3L34i8hx2y01MRMv3f9eWTiIgJOe2IY=;
        b=ErPYn8LKl9Jy6pvgvUFQRhaakRJXhUcLKv5PqIxKdpAMw6TmI7rc/MOj2fcflLvJHF
         fegHDflDzpWCN13c9RPl6UVLfTC4Hp38IF+nGVLeBbp7nFcoPRJMqz4IXyD4eb6zc3Pw
         WiUHZMEGvCRx1lTr77Wp1aCAregvQXbFMcQbfaLC9pDjJ+OX3RkfmY2Kj9P/5Rveek1W
         ueAel2vOsLkh6zrYE5ZmpZwY5Ni1PrshPpK381a61u1t0vh+X3OguoOZN/FLgGYhZqFw
         cd+e9OeyxjE5VVgmqs21jE4cgCUb+HGyXcLEekjDlj6ioA+YoH+EiP8arWzrIO4Xn+TZ
         Bv4A==
X-Gm-Message-State: AOJu0YznhbUeunhpIlehPCASt8x/lAumFIsM7KHcKkf4FQcDqcs8oK4u
	LHzp2VL2q9N2oro3DA2JFMtR279K8IrZxGxiC1jFsjGG8Dtx0aDmT3vUm4SHApI=
X-Gm-Gg: ASbGncvT9p/Lmi6GYJTsLoHxuOKnXi8V0Gv86ZHWM3SeBbMT1N/r6Xl+w2PNFMbXLXL
	4oecAkIiEPfZiD6oVYeNIVcQUoqwW0dIhfY1+jEC5c8VPX7VcyF1m+0FX3gqHKYute/GIGs1qkz
	lnmZ+2kBSbIjyZZ1f8YTwIXM8Y7qitn4IbVcibx/XWI+KBUfDmQa8ICw6kL+Y6WtRa8SgMuJBS3
	/OaD2n7cUUU24I6VSTJSdLDoHCYESMK7EK7eMemSqNybo5xg4EUf2TJyMCgj1/+mbPdc2PIHoUf
	AJqbs1d0Kyh7/6f1HvOqcKnmBPl9w0Nv+ShINVuMEGBRObolZdV2+7f0rqdZ04znM2Icv0t+qIk
	EVcXYwemy9v+/lM6Zj51D
X-Google-Smtp-Source: AGHT+IHgmtTmWQNhWYWSN+O4/IaBn+o2MSxKc2Jzs0l/i1DuscLzCJUdxnQP+zZBO+BhCSuhf6LTEQ==
X-Received: by 2002:a05:6122:1da4:b0:529:373:fcb7 with SMTP id 71dfb90a1353d-52c53cebf52mr4109733e0c.10.1746821888562;
        Fri, 09 May 2025 13:18:08 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52c5372b124sm1833031e0c.12.2025.05.09.13.18.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 13:18:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] mesh: Fix possible null pointer deference
Date: Fri,  9 May 2025 16:18:06 -0400
Message-ID: <20250509201806.643057-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes possible null pointer deference for label reported by
cppcheck.

Fixes: https://github.com/bluez/bluez/security/code-scanning/1771
---
 mesh/cfgmod-server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index e5d5a86e0d8e..f9f80aff7920 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -203,7 +203,7 @@ static bool save_cfg_sub(struct mesh_node *node, uint16_t ele_addr,
 
 	id = (vendor) ? id : MODEL_ID(id);
 
-	if (virt)
+	if (virt && label)
 		memcpy(db_sub.addr.label, label, 16);
 
 	if (opcode == OP_CONFIG_MODEL_SUB_VIRT_DELETE ||
-- 
2.49.0

