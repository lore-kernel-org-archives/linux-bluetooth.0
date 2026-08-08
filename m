Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45CE2C0260
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786167196; cv=none; b=bs2yHTgDEOqN8QzcMWf1Zm/h7K4x0v4jG/OFO+0UBWcTWIbdgrYhEN0GxURyFJVRCmzfO83BrBqv1nz2KEo0Yk/xZ1OCr0fnSxWlo9w6f+/ZFY2PfnNvD4pdBYc8KhPTbW4dTJdRatK34ldqVaoyxhdVr4E2DXLuI8uGal44lOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786167196; c=relaxed/simple;
	bh=f+PKGIJQf4ftrFEY6rgBleDvCwFwCbZ1sRMyIDjxU8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ROj+F7nKYTnEFkgC4XlPvg2P79iHVblSgm5VRXNXXUFlA8I0zUzJBBS1qQMuMLVEprmx0dsTy0iH9M9gco2dfo6MsQJGeP++7gubqk8BQg4a4bh+d1RzXBqX2c0ZlHLo6Q7LNh7cfCpuMdxrTYWNyuh2BoeaAyk8LkplfYvISGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moCUv/Vu; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moCUv/Vu"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso213450a91.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 22:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786167195; x=1786771995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oFroGAPZp4ej2DXNEJ/q4PSHjxNJnm1z9YjC9aaC1bA=;
        b=moCUv/VuNa0roKLyGPgZ8RSunSnUUHis+uZXP9InriulBG2q3ODuYJlpWpKaY/bTqo
         pqbFphIjLHEB37LRClrRwdDWnbbkIykQXbRODu/FPeOJbqTlUGfyyxevMrHO/ItiyPd4
         +fkOtCvNms+E/FmP+IsrNq6AHy+rdK0fxnxEYQdCevsS6W/fc6TuJjJP8vpxDF5nFaGR
         /Jgx36wpBl0Rbo4/fr79+Wh3Z6NXgn4nFk1aHCYc4prpef6gA3D1K6RBp+ZXbXGpyHBD
         Nmy18NURe+4TfxCP20hrSSXy/I1BEtT86rtjyf/+F7/Ef3MKzV7Me7RX8uY477PPLpH4
         VULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786167195; x=1786771995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oFroGAPZp4ej2DXNEJ/q4PSHjxNJnm1z9YjC9aaC1bA=;
        b=Au1OSHSbwM9/WVf0qO24JIX4nELdSiBJi1Wm80Ef4RspQhxkRlDPXIw9vHOJyk62Qp
         zBAaR3aIzb4dGz9rcd8IAWDAYffvtUIREpoP3f62z7Zx4NkH4jupIcYj4JygXbdamVjV
         Mh6/eanWbRIoIFQaSVulJWnbUX4O+POMYwu/5x9QfClOZG71okHHetY4FtvE56JtG3Hg
         K8OIx9TkYSy1TMS3QkNyhpNxNKMBuoBuL4y2FqoqaN8M5jUx7nrD9UAFBQ/xU/BcYaeP
         Ch4G1bWyUeJB3kIsrdhFeVWRrVqOT/RBRZcpocLi10qNFDzV+9Ah9K27HE2FKl/aA8fG
         9lkw==
X-Forwarded-Encrypted: i=1; AHgh+RqSHeYL9sD8FvJIBYhWGI6+Spt37OEXdSfsmxMVkA8OMLoajO0ZG7BP6OX82aOr71W2Ng4fJ/uf0mcGA45e7ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMIFNfXQA97amBTPfEnFihpwi25fVqbI22PF1Z4F3oxcVPoDgj
	I7cBklG9CLmyCfSPf7F8kQgpq9tg83lsqfGywJACXEjECv0bklaqaT1I
X-Gm-Gg: AR+sD11gCMwjDdXzGqoerWyzwBvZxY+Dfc/Jf/R5DOg+eDjwY+rRi/U+/eOelElvTab
	bAhMMAssbranH8Xzu+TAWOclwwy0Mc2MEmZhzNeIy1cPMhERBckkTLLQyBYZk4oETbnAJNfusc4
	5Qpbhs5390xAEGAdIIYgREjwVReFPJx8TbojsGEFTOcx+ZWkVFt7EwQTUChN5hY17tqWclUk6IU
	v0cGxdo0P1EBanQW6iFUvRlMvw72xIDu05F4iym/HmVWj2IPqFHY+Tx51+3Ov+uvF4X5LF2oGam
	SJMGIZ/zycLMMdHi7LYJ8UA2uBviECTlQzr+UcVGbPqM2lOoilLlhlVghC18e8ugUlzm7ZaFhuC
	TX+HCaEAqNlVSLBl/JC+NtXeSK1QSeYmXtyfKNhszuI3Iwu9obIPM0NKCTr4orG2IynHIdyLbLH
	CJCyuvoy/mdHndJK4BtC3fJ9loTkW3//omiWh2QT9mIyk=
X-Received: by 2002:a17:90b:4e8d:b0:38d:ec31:4840 with SMTP id 98e67ed59e1d1-3903c5932femr29991164a91.13.1786167194908;
        Fri, 07 Aug 2026 22:33:14 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fd95794sm4856341a91.7.2026.08.07.22.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 22:33:14 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_intel: fix usage_count leak when autosuspend_delay is negative
Date: Sat,  8 Aug 2026 13:30:57 +0800
Message-ID: <20260808053057.2566366-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_set_power() calls pm_runtime_use_autosuspend() when powering on
the device, but the power-off path does not call the matching
pm_runtime_dont_use_autosuspend() before disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() call before disabling
runtime PM.

This issue was found by manual code inspection.

Fixes: 74cdad37cd24 ("Bluetooth: hci_intel: Add runtime PM support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/bluetooth/hci_intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index c31105b91e47..1919547ff2a1 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -345,6 +345,7 @@ static int intel_set_power(struct hci_uart *hu, bool powered)
 			devm_free_irq(&idev->pdev->dev, idev->irq, idev);
 			device_wakeup_disable(&idev->pdev->dev);
 
+			pm_runtime_dont_use_autosuspend(&idev->pdev->dev);
 			pm_runtime_disable(&idev->pdev->dev);
 		}
 	}
-- 
2.43.0

