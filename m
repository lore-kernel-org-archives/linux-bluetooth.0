Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67943D9DB1;
	Tue, 24 Mar 2026 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342317; cv=none; b=NBBzNop7J/YZWtNa/VM22hNbUyI8yvIFOz5VXA46Fp2iaLlZK3s/AiHIpChLjwbDbSJFqfdWyQRWV8fA2GSCq1uvFZQbbMRd5ACqPKcCc6yxV+URRlg8Sj102bZ1CD9y4A45Zg+l+Aj3DRpc2azfb6aw21e7VtPEK49tLJxGFis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342317; c=relaxed/simple;
	bh=xrCHbguGFIFSrvZ1b6iD5csa232XNCnUvzh5Gb69Sgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T4mZ0a9taELXWJkEyKCFE20RzM3TZz8qcOQtVHwuIkyNvYwJUHw4+sUG+KbaiUe8nCwX6cTcjKhLbPGZWJvk7ZTJx0v1wYr+pDFgo9yndGZyMWiDgxmp69xXivVFc4ekFASMDTb5pLbbJck57aqPJF873PU43wGnezkB52v5Hww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowAC3XWmpUMJppqf8Cg--.7601S2;
	Tue, 24 Mar 2026 16:51:53 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] Bluetooth: btintel_pcie: fix TX queue off-by-one
Date: Tue, 24 Mar 2026 16:51:52 +0800
Message-ID: <20260324085152.74986-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAC3XWmpUMJppqf8Cg--.7601S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr1DJw4xtw15XFyrZFy5Jwb_yoWkGFc_uw
	15Cw1Uu3y5JF1fXw12k3yFvFyjkFyxWFyvvFsrXrW5A348urs7CFyqvrn0qan3Ww17Kr9x
	Aw12qr1Syry8GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUIfO7UUU
	UU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

btintel_pcie_send_sync() reads the next transmit slot from
data->ia.tr_hia[] and uses it as an index into the fixed txq descriptor
arrays. The current guard only rejects values strictly greater than
txq->count, so an index equal to the queue depth still falls through and
is used as the next transmit slot one element past the end.

Reject indices at or above the queue depth before preparing the TX
descriptor.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/bluetooth/btintel_pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 37b744e35bc4..760cb3d1aa18 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -359,7 +359,7 @@ static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
 
 	tfd_index = data->ia.tr_hia[BTINTEL_PCIE_TXQ_NUM];
 
-	if (tfd_index > txq->count)
+	if (tfd_index >= txq->count)
 		return -ERANGE;
 
 	/* Firmware raises alive interrupt on HCI_OP_RESET or
-- 
2.50.1 (Apple Git-155)

