Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1505101E6;
	Tue, 29 Jul 2025 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753802868; cv=none; b=tpbwVMqtnvmuKowDmiYb/7mshF7RnUyZxSPnvoeYgb879v+vEW/Jlo7qYzDarC9jgvPEVHgwW3Wlqc9sIDGfxe2+naY8v/Vf86QmdsrbCoMFh1sb6ESMJpohfBXcRu/WqtsXbuUAI5i0ugwYGbfqZfUqNlHgYF6jbImj5SRwvVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753802868; c=relaxed/simple;
	bh=vEjY0bc/ws416eC6PETkAarRcOMa4NCrT2KtYjseTzE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nPBxc/2ye9vPbjPetCFk9hqESCm4GPZrecyoVOi/EueF1kaHp030npMdXwd2A52U9oJlj2edK5T+PPrbd6znlVUHWWVJLto+Xvl8RuGdcedbSvfk6DQ1fNcpzYV2W/cAkYsZ1/Qy3ICMuDySF8DMQhVz55EPXrf/U/SIGZxw3gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqIaPYvW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqIaPYvW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C685C4CEEF;
	Tue, 29 Jul 2025 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753802868;
	bh=vEjY0bc/ws416eC6PETkAarRcOMa4NCrT2KtYjseTzE=;
	h=From:To:Cc:Subject:Date:From;
	b=aqIaPYvW1S5tKXLSeKy3MYaODuAeqeXIuy75XCudeoobK9qDvJqJOH9T3kmAbim3G
	 53by5l278qqQdKSRh7GL1h41O8kI0tfA3wHq3OaRotGcsGaiwcO5zIoMhwmZvPssNj
	 zns9JfyMWiENT+qykypxcK5qth4irl1BKqcU7W7VblWzjvGnbZx1GCjxPXW6wSW2ZR
	 pWMu8ov/dQPf4IYUyoRSshqxNHaPAX3nc+YRClsbQST2gk37i5mj9XpSZ63oo0bn+X
	 QQgDuJ0c0SDUvD+iYG7eWkOrVt55zD2fivrk6aro8AEyonEBPviXKqj/sfMBqckZAP
	 eYGLvB+y6mgAw==
From: Arnd Bergmann <arnd@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kiran K <kiran.k@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: Vijay Satija <vijay.satija@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel_pcie: fix CONFIG_PM_SLEEP check
Date: Tue, 29 Jul 2025 17:27:40 +0200
Message-Id: <20250729152743.2394727-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Using both pm_sleep_ptr() and an #ifdef around the definition is not
valid:

In file included from include/linux/kernel.h:36,
                 from drivers/bluetooth/btintel_pcie.c:9:
drivers/bluetooth/btintel_pcie.c:2674:36: error: 'btintel_pcie_pm_ops' undeclared here (not in a function); did you mean 'btintel_pcie_in_op'?
 2674 |         .driver.pm = pm_sleep_ptr(&btintel_pcie_pm_ops),
      |                                    ^~~~~~~~~~~~~~~~~~~

Remove the #ifdef check to let the compiler's dead-code-elimination drop
this as intended by pm_sleep_ptr().

Fixes: d1b3de23042b ("Bluetooth: btintel_pcie: Add support for _suspend() / _resume()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/bluetooth/btintel_pcie.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 8e65def192a9..aa47bc38d298 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2574,7 +2574,6 @@ static void btintel_pcie_coredump(struct device *dev)
 }
 #endif
 
-#ifdef CONFIG_PM_SLEEP
 static int btintel_pcie_suspend_late(struct device *dev, pm_message_t mesg)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -2664,7 +2663,6 @@ static const struct dev_pm_ops btintel_pcie_pm_ops = {
 	.poweroff = btintel_pcie_hibernate,
 	.restore = btintel_pcie_resume,
 };
-#endif
 
 static struct pci_driver btintel_pcie_driver = {
 	.name = KBUILD_MODNAME,
-- 
2.39.5

