Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBE222171A;
	Thu, 27 Feb 2025 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662499; cv=none; b=uDi/zcoXDeDaD/iiYL46hewj+sOd/xmMUw5FIAUbuB1Ydu7hZn/JvnNxA288i64NlRJsZN/r2oXfSOumJTwhxutfpsFfs+bYZ+hHu0YsCsLi3QH8GBqI36aXIlxB6jb6ZOGo4F8cbwp4yYnWX4jU3bBv/Fm5oWUuHekFINoxzT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662499; c=relaxed/simple;
	bh=4w85VXmXVoUwIIQjvbYxTdVX4Ag/SHkxq5uJjoCaTF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RC5XKepc3UVvnC7gxwmQk0qtg8jJAlWLSmvG/VP7j0FtATmPWs2K5M0rhbHlxycj4z7LFdOtat73plXJLIGxMqxmWAs8QUu/La6HJpnoTkXHEYulzTLRQYNoEN1kMhWjBr06M1g1fYTQu8x5+shurD2Q/JIrEM89qSZAhZjwDb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WL/QDkDW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WL/QDkDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038A3C4CEDD;
	Thu, 27 Feb 2025 13:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740662499;
	bh=4w85VXmXVoUwIIQjvbYxTdVX4Ag/SHkxq5uJjoCaTF4=;
	h=From:To:Cc:Subject:Date:From;
	b=WL/QDkDWkjaeTFK8kRxw0ZiGIiqGNvqJkTr5g1NUXZZAIPT+l7JMXmguwM4PpELwh
	 /JL1f7vX8+UEH+2rNhhZqVy0+9SHanaYK4ScksicrSTUbRWD3LLRhG1X1u6ciM5Cqb
	 eCbcVPyWzWE3JFtb2WizIaOSMvj5nZ6XmMX010zZqoXOg41lu+nT96H7rIXB0ZEZA+
	 5c3WdHg5TaPQHCnBv5RG4NKfNe0rbAmtw+oLN0+nNRDmbjveYZ5ceABuOj1lonZfZL
	 8wZ7o/ymUGRad/Zs19C8S8lFXwQaFrVDhccs04f2McZfUb3GJjLbw/hSq12VkcHdQd
	 xQ1jOpx+AOFMA==
From: Arnd Bergmann <arnd@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kiran K <kiran.k@intel.com>,
	Vijay Satija <vijay.satija@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Devegowda Chandrashekar <chandrashekar.devegowda@intel.com>,
	Tedd Ho-Jeong An <tedd.an@intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel_pcie: fix 32-bit warning
Date: Thu, 27 Feb 2025 14:21:27 +0100
Message-Id: <20250227132132.1171583-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The open-coded upper_32_bits() produces a warning when building
for 32-bit targets:

drivers/bluetooth/btintel_pcie.c: In function 'btintel_pcie_setup_dbgc':
drivers/bluetooth/btintel_pcie.c:142:72: error: right shift count >= width of type [-Werror=shift-count-overflow]
  142 |                 db_frag.bufs[i].buf_addr_msb = (u32)((buf->data_p_addr >> 32) & 0xffffffff);
      |                                                                        ^~

Use the provided upper/lower helpers instead.

Fixes: 3104ae5ad1b7 ("Bluetooth: btintel_pcie: Setup buffers for firmware traces")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/bluetooth/btintel_pcie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index cecb926bce1c..e8307eeb971f 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -138,8 +138,8 @@ static int btintel_pcie_setup_dbgc(struct btintel_pcie_data *data)
 		buf = &data->dbgc.bufs[i];
 		buf->data_p_addr = data->dbgc.buf_p_addr + i * BTINTEL_PCIE_DBGC_BUFFER_SIZE;
 		buf->data = data->dbgc.buf_v_addr + i * BTINTEL_PCIE_DBGC_BUFFER_SIZE;
-		db_frag.bufs[i].buf_addr_lsb = (u32)(buf->data_p_addr & 0xffffffff);
-		db_frag.bufs[i].buf_addr_msb = (u32)((buf->data_p_addr >> 32) & 0xffffffff);
+		db_frag.bufs[i].buf_addr_lsb = lower_32_bits(buf->data_p_addr);
+		db_frag.bufs[i].buf_addr_msb = upper_32_bits(buf->data_p_addr);
 		db_frag.bufs[i].buf_size = BTINTEL_PCIE_DBGC_BUFFER_SIZE;
 	}
 
-- 
2.39.5

