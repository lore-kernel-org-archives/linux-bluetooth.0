Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07AE42B73B;
	Mon,  6 Jul 2026 09:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329432; cv=none; b=S/AFSGCow8LhiEzr5gmhztP5zByNH5pkUojeR9Wu1Y0Vmmlr+B8d7wBvsfQ9iwdxDwZszaijKBkQvYmc9XtYPqSE8f7uNhbhOG0PycYPhB8wPPgVNShIq44272Zb2nGOwV5fBfiFxL5fVpd/ypdEnjIpzmrsERp4a/JDw5tLR4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329432; c=relaxed/simple;
	bh=H7Y92JNx0Wg4SDrjlmriQg5H2Nqk6AC2QMm5e3gbHTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F68ir5j1riXLNDVQz0+njoDojZ+JWwsYYADZBquPrBm+6J3sx8zdWKiwpmjaVB0nfxRGkgo5PcSdgl0bv23r27NnHCVintLd5Eg/q8U6g4pmbDdnuNwGnQ2jz1EbRfwPTaDPRlY6EYtnruwf5FOixKHxx/XBcdqbbRqf+VkKmwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowACXMsuOcktqMBXxBA--.35260S2;
	Mon, 06 Jul 2026 17:17:02 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_nokia: validate firmware packet bounds
Date: Mon,  6 Jul 2026 17:17:01 +0800
Message-ID: <20260706091701.77562-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXMsuOcktqMBXxBA--.35260S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1DJw4rKry7WryxJr45Awb_yoW8GFW5pa
	y5XF1akr4kJ3WfZF12yw4kZF90g39YyFW2kFy29395Z3WYyFykAa4jyryjg3y5ur45tw1f
	tFyDt34rGF1DGr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUezVbDU
	UUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

nokia_setup_fw() walks a length-prefixed firmware stream and
decodes HCI command packets from each record.

Check that each record fits in the remaining firmware image, that command
records contain the HCI command header, and that the payload length is
covered before submitting the command.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/bluetooth/hci_nokia.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index 1e65b541f8ad..be2923231e71 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -354,9 +354,29 @@ static int nokia_setup_fw(struct hci_uart *hu)
 		u16 opcode;
 		struct sk_buff *skb;
 
+		if (pkt_size > fw_size - 2) {
+			err = -EINVAL;
+			dev_err(dev, "%s: Malformed firmware packet\n",
+				hu->hdev->name);
+			goto done;
+		}
+
 		switch (pkt_type) {
 		case HCI_COMMAND_PKT:
+			if (pkt_size < 1 + HCI_COMMAND_HDR_SIZE) {
+				err = -EINVAL;
+				dev_err(dev, "%s: Malformed firmware command\n",
+					hu->hdev->name);
+				goto done;
+			}
+
 			cmd = (struct hci_command_hdr *)(fw_ptr + 3);
+			if (cmd->plen > pkt_size - 1 - HCI_COMMAND_HDR_SIZE) {
+				err = -EINVAL;
+				dev_err(dev, "%s: Truncated firmware command\n",
+					hu->hdev->name);
+				goto done;
+			}
 			opcode = le16_to_cpu(cmd->opcode);
 
 			skb = __hci_cmd_sync(hu->hdev, opcode, cmd->plen,
-- 
2.43.0

