Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678183D0BE4;
	Mon,  6 Jul 2026 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329390; cv=none; b=ohDSQBDbYtTz4xT/ed9pVn5mug02XUlWppXLLZ3AK4iGY9ulEuPgLoDu3cJM6ZpctOend77MDdsfUTVh4qVQPG3rx49v2R3AxtHoMlds8AIsoMSIXlk1tOOyi9K+kIcDK5xQ1MRMaodaP02ct5Me6MCl7U1QDKQAT6l3u1HvwaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329390; c=relaxed/simple;
	bh=YXN3wQ+23EuHGwg1wfTwUBcVQaeegwYYQCAHnBtEwvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fhmSjW67ElGM+1BP18LaxLuOixZZeQaQdFvf1RvuLbclBQ2wQMlv38k4bfT+Aw9tliq655NrJtlsAA8n0O0U8paeopHuFibEjaSXmEZYwnzUb4uVxQ9VO+nSzNEHnMK0UGic5eUQFLwvRBjkkAnFZosLfKeYs4tvqAfIxWLN3nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowAAnxs5jcktqyQ7xBA--.35199S2;
	Mon, 06 Jul 2026 17:16:20 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: validate Realtek vendor event length
Date: Mon,  6 Jul 2026 17:16:18 +0800
Message-ID: <20260706091618.77442-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAnxs5jcktqyQ7xBA--.35199S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF1rJryDuw47tr1fWr13XFb_yoWkGFX_u3
	4IkrW3uFW8GFy7CF1UCr4a93yjvr45WF1xAwnIqFy7JrZrJr45CFWUXas8Jr47WryDKF9a
	y398Wr4Fqr1vqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU6v38UUU
	UU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

btusb_recv_event_realtek() inspects skb->data[2] when checking
for a Realtek coredump subevent.

Require the packet to contain the HCI event header and the subevent byte
before treating it as a coredump event. Short packets keep following the
normal hci_recv_frame() path.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/bluetooth/btusb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 08c0a99a62c5..8f7ed469cac6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2782,7 +2782,9 @@ static int btusb_setup_realtek(struct hci_dev *hdev)
 
 static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	if (skb->data[0] == HCI_VENDOR_PKT && skb->data[2] == RTK_SUB_EVENT_CODE_COREDUMP) {
+	if (skb->len >= HCI_EVENT_HDR_SIZE + 1 &&
+	    skb->data[0] == HCI_VENDOR_PKT &&
+	    skb->data[2] == RTK_SUB_EVENT_CODE_COREDUMP) {
 		struct rtk_dev_coredump_hdr hdr = {
 			.code = RTK_DEVCOREDUMP_CODE_MEMDUMP,
 		};
-- 
2.43.0

