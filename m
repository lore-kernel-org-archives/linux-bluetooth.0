Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCAE423E98;
	Mon, 14 Sep 2026 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379206; cv=none; b=uNaWl+f+OgojzqPSVA1PLH//UVSb0N8+NlU0TJ0FYdpYFSAb9gwPEEpgvmTl0hRn7S/BcYZPqdBOsn+OMYexDeKNWhItx5SbdFaNrDRtt8DZOt0Mk36oOLF4LAaQ+D6FglhVgaDFrZHM73oe4B/Na86qKFGA0SrkpYDrYwe+I9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379206; c=relaxed/simple;
	bh=ZxJ5Pq0RqptmJn9Eg+l909h4n+BhjN/UW1cpjoBnh2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TjHRozllulsk3DfCeA+vmLPib5KFDJp88cIZtDWB5YcmF91LwWjmgPRkQQlXOQYi+DmYcGBmYPgY6yUkTGcfE+5jRK+m0EPSxzSziakIbnVGWga0I8fpeK4TkSslCR32fOBQuowIjQb84gXNpdn9iA6YEFSI7mtou35uoUG9WHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAbH1ILj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAbH1ILj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD0E1F000FF;
	Mon, 14 Sep 2026 09:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789379204;
	bh=x59oGxyHMrxebj6t/IsE8YnWpeSPHvzqG1OSQQ6gcN8=;
	h=From:To:Cc:Subject:Date;
	b=oAbH1ILjlfZh7RZcwTZ2XlN3oPv7dxI1o+n9iOEZf5UeC2XR/JwlU9M7BGSKO7aVk
	 Ds1B2Y6vMWYq66D3vWNJBKDelSSfS55sLBHNHjiJEzrGeohEhiMLdICQsRKJg6eV3E
	 OjKwpiXaWKi87++TIJxQQLyegOTGkxRiB0fZP3QkaLMnWvBYzTsTb66VKTmr0rsGYV
	 nxw4XWp+OzTJrkluklgAiXV+yhshm4AOhVl4rijkswGTRLU7F5eGLufd/JbFvLxCC0
	 8CyTfG7XG46UP0HHrnVrZun8olF3X7VuTQNueESx7BkPNWRR/4eFVuDNg/fTQhFNOo
	 oXoqUuMKOsjyA==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	tzungbi@kernel.org
Subject: [PATCH] Bluetooth: btmtksdio: Fix spurious ownership error logs
Date: Mon, 14 Sep 2026 09:46:31 +0000
Message-ID: <20260914094631.3222026-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In btmtksdio_fw_pmctrl(), if an early operation fails (like clearing
the mailbox ACK), it jumps to the `out:` label and spuriously prints
"Cannot return ownership to device".

Evaluate the ownership return errors locally to ensure the error log is
only printed if the actual ownership transaction fails.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/bluetooth/btmtksdio.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index fe4ca9395aa3..c5f2967f847f 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -360,18 +360,14 @@ static int btmtksdio_fw_pmctrl(struct btmtksdio_dev *bdev)
 
 	/* Return ownership to the device */
 	sdio_writel(bdev->func, C_FW_OWN_REQ_SET, MTK_REG_CHLPCR, &err);
+	if (err == 0)
+		err = readx_poll_timeout(btmtksdio_drv_own_query, bdev, status,
+					 !(status & C_COM_DRV_OWN), 2000, 1000000);
 	if (err < 0)
-		goto out;
-
-	err = readx_poll_timeout(btmtksdio_drv_own_query, bdev, status,
-				 !(status & C_COM_DRV_OWN), 2000, 1000000);
-
+		bt_dev_err(bdev->hdev, "Cannot return ownership to device");
 out:
 	sdio_release_host(bdev->func);
 
-	if (err < 0)
-		bt_dev_err(bdev->hdev, "Cannot return ownership to device");
-
 	return err;
 }
 
-- 
2.55.0.1007.g17ff1f9808-goog

