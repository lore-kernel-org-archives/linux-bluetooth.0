Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583EC3D88EB;
	Mon, 20 Jul 2026 11:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784548048; cv=none; b=UMaAKrxnHJKXGmxUjbb4iFHGD0bGlHEo81tlo7YtT+mjgfaUp6gCWn9MXR6PD2kxKfIL5OPrGZD21FhtmiPUEoT2/EbLcue4GltfPVldfub4oK7E5JhHjLhVk9FhEnFwFjzLt47oHoLMhgSx7G9M3c4nBWNb5KtQivm2TYOosRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784548048; c=relaxed/simple;
	bh=58VGDWSCh9KeXlG1tmqSYTBxiCQ8EAltFmvMLzrR3Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rCBv+D9H+hUq5j2xgExLx3G3G4yLOi5gAHWBAjNRLdmTQvV1P500E3lqMeKk7EYyKGWbHq3zthwQzPQegMSVe0PHa7/Dt+CIzzQS0ZOFI6z69ky08qwsPozNMxmQyMDa0lnG8yan404m218R8LE7pP9DRzCDRo9Fxif9f+O7s6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAAnlT_FCl5qs6CIAA--.52349S2;
	Mon, 20 Jul 2026 19:47:17 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v2] Bluetooth: btusb: validate Realtek vendor event length
Date: Mon, 20 Jul 2026 19:47:17 +0800
Message-ID: <20260720114717.60749-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAnlT_FCl5qs6CIAA--.52349S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW5Cw4DGr4UGFy3Kw1rZwb_yoW8ArW3pF
	Z8Ga1FvFs5Jrs8CFW7Ja18Aas5XayrX3y7GFn0v345Zw1YqF18AFW8GasIqr1rArZ5tr4j
	y3W5trW8u34UJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbb_-PUUUU
	U==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

btusb_recv_event_realtek() reads the event code at data[0] and the Realtek
subevent code at data[2] before deciding whether to consume a vendor event
as a coredump.

For example, the two-byte event ff 00 contains a complete vendor-event
header declaring zero parameters. The old classifier still reads a
nonexistent third byte and can misclassify the event as a coredump if the
adjacent byte is 0x34.

Require the HCI event header and first parameter to be present before
inspecting the Realtek subevent code. Short events continue through the
normal HCI receive path, which owns their protocol validation.

Fixes: 044014ce85a1 ("Bluetooth: btrtl: Add Realtek devcoredump support")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1: https://lore.kernel.org/all/20260706091618.77442-1-pengpeng@iscas.ac.cn/
- clarify both fixed-offset reads and add a concrete short event
- add the requested Fixes tag
- rebase onto v7.2-rc4

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

