Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABCB2727E7;
	Fri, 25 Jul 2025 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753434416; cv=none; b=tkULaa47X8KCVqXY+HB1/SsSMM/K9LWQaFAyULd6qbx+pq5CnuB7LhuW9NiXSv79PRp386W2Gy/qrdKyvqqKgUZbivgGnBB+cqJaH4RZsv8NVpH8/VqnrV3LshGECiGQR+hV3QZB43W33LuEpwfiOw3rzGddZMonI+z5DdNTSc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753434416; c=relaxed/simple;
	bh=W9bqyNVgz9Pb0ddOMmJHYqt5JzLQxa1th7GNwozuK2g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=deriCRRln1j/PvnOsk/CR5Pb4n0sm47cD0CPmX/OxFmXoRCgqwM7oHpXcMfWOvyF0gHmW+36Oc98fBqek+1pswyG5xcV+3KG1fGxdQd748+8xM3vPk8Lcckvz9I5vozELZ50gZdbgZhSOor0mRkJpfG4ksbIERqxPI7YrfWJRiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNGoTwxc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNGoTwxc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2C0C4CEE7;
	Fri, 25 Jul 2025 09:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753434415;
	bh=W9bqyNVgz9Pb0ddOMmJHYqt5JzLQxa1th7GNwozuK2g=;
	h=From:To:Cc:Subject:Date:From;
	b=VNGoTwxc0DLgsptWiPmz1lkexrENOuTMs23ZIzbTR/FgB1GfUe8vtXVUD1CsgNatH
	 VpYI2hJXr6hDHwnu4cFmphb2T06QFueSwU8QpvcG1k5btqO0YQx0Uh1PWGi88qda9N
	 oeKwPVIWlyp9pUB5bRcu4eoIF+IeScazNPPwcXY5C+8ZoJeFg4zTG+UOL+lnx2TiUB
	 j1+KRzPICeNwuMvdx3QSY/PptZZADwpLVbFlcS2SYd2GQR5Ed1YFhBO1Tu9krYltol
	 pv1kVA2gtQDFr9qbzJICMuDustb1G1ZTvdaBghfUS/XVPuifl1Wnz5Q5LJlgc8bPEe
	 o5027EbD7LLmw==
From: Arnd Bergmann <arnd@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Kiran K <kiran.k@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Vijay Satija <vijay.satija@intel.com>,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel_pcie: avoid unguarded 64-bit division
Date: Fri, 25 Jul 2025 11:06:47 +0200
Message-Id: <20250725090651.2495984-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Directly dividing a 64-bit value is not allowed on 32-bit
architectures in the kernel.

arm-linux-gnueabi/bin/arm-linux-gnueabi-ld: drivers/bluetooth/btintel_pcie.o: in function `btintel_pcie_suspend_late':
btintel_pcie.c:(.text+0x224): undefined reference to `__aeabi_ldivmod'

Since this is a ktime_t value and dividing by 1000 gives a microsecond
number, just convert it into microseconds using the appropriate helper.

Fixes: 33bb9b1ce6f6 ("Bluetooth: btintel_pcie: Add support for _suspend() / _resume()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/bluetooth/btintel_pcie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 9792a49886ff..4dfd5365bb4e 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2607,7 +2607,7 @@ static int btintel_pcie_suspend_late(struct device *dev, pm_message_t mesg)
 	btintel_pcie_wr_sleep_cntrl(data, dxstate);
 	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
 				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
-	delta = ktime_to_ns(ktime_get() - start) / 1000;
+	delta = ktime_to_us(ktime_get() - start);
 
 	if (err == 0) {
 		bt_dev_err(data->hdev, "Timeout (%u ms) on alive interrupt for D3 entry",
@@ -2651,7 +2651,7 @@ static int btintel_pcie_resume(struct device *dev)
 	btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D0);
 	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
 				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
-	delta = ktime_to_ns(ktime_get() - start) / 1000;
+	delta = ktime_to_us(ktime_get() - start);
 
 	if (err == 0) {
 		bt_dev_err(data->hdev, "Timeout (%u ms) on alive interrupt for D0 entry",
-- 
2.39.5

