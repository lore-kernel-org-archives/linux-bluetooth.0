Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1A11E00B4;
	Thu, 10 Apr 2025 07:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744270529; cv=none; b=XOZsgXTZbhthGglJ4Dy4+Elp2DypXnlG/DwE1I6cANE5qkzcPcL4dMP2paW47laFd33Bncz88O8IfesBPc43T4z6eg3DA9BsbTxX1/7scnZTvgK1c0RPQkLv4ITS5bS7qtVm+HspNL/alVjZ+ptaIdp32h42Laf1zKYz7+eteAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744270529; c=relaxed/simple;
	bh=dldL0pOtH2f9b9XCjmY7N9RmIIQFk2EfofubS5wtadk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b4YH4eelNNhndgIBunTkrZyNy/nqmcQnfJgudiR6yFaMRVvRm77dr2i1qwZySUJFPdLsCZsj7gqTzUNeSa8i7CHUbahQUF634COpmFUFR4HmxSkpeHlQvhUotKJgH7yDpsW5ybHaSSwkX9PokM7Bcz4oKu/ltTnQi+MriFt8GLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowACXPP23dPdnxdPTBw--.3102S2;
	Thu, 10 Apr 2025 15:35:20 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: yang.li@amlogic.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] Bluetooth: hci_uart: Remove unnecessary NULL check before release_firmware()
Date: Thu, 10 Apr 2025 15:34:56 +0800
Message-Id: <20250410073456.3558507-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXPP23dPdnxdPTBw--.3102S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw18ZF4ktr4xXry8CF17KFg_yoWxCrX_Cr
	1kCas7Ar18JrWUX34jkw43ZrW2k3y5WF4xXw12v3y5CasrCwsIq34j9rn8Ja4furWUKFy3
	Ar1UJF48A34DGjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjuHq7
	UUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

release_firmware() checks for NULL pointers internally.
Remove unneeded NULL check for fmw here.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/bluetooth/hci_aml.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_aml.c b/drivers/bluetooth/hci_aml.c
index dc9541e76d81..1394c575aa6d 100644
--- a/drivers/bluetooth/hci_aml.c
+++ b/drivers/bluetooth/hci_aml.c
@@ -313,8 +313,7 @@ static int aml_download_firmware(struct hci_dev *hdev, const char *fw_name)
 		goto exit;
 
 exit:
-	if (firmware)
-		release_firmware(firmware);
+	release_firmware(firmware);
 	return ret;
 }
 
-- 
2.25.1

