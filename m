Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B7D3A0E8A;
	Thu, 20 Aug 2026 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234792; cv=none; b=gVjmRVIJFqmz1PueVDu50Ch45AETD/JNOSulTxjzjRSUUBwJkac00iWUut4xyVseiY8viJVhLTriNPud5cCYhy7xCmPIyWJVkFdtZGuaxQQvoGUFVQ9oz+/RD+uiNqU5a9LjvObT8sr2v7pSbzA+NMMYX+smsU+0CiLxSEn2WuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234792; c=relaxed/simple;
	bh=jYTKj2mmdHTKZaHQ7axq29RV7SOZxWPYNog6jsfNJUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GV7MjS8qozcsTpUSu3goeQFhJPYghiH9f3zZyOPr3Cii1hVKGvtwIpmabTw5KVqcSRGEvWtxiTQvpAg0i5LDnmkoRiEYhsXIWFhdYjrcSPZzlr/7dbfcNZ+eh5+j8hTAkRZoeFCxJWzT7pD1miiXHMwGvhk1xSKy1FK3NAAO9wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from jiangli-ML110.tailc3b79e.ts.net (unknown [159.226.94.103])
	by APP-03 (Coremail) with SMTP id rQCowACXmzm7CYdq1ErhBQ--.29712S2;
	Thu, 20 Aug 2026 22:06:17 +0800 (CST)
From: Li Daoxun <lidaoxun25@mails.ucas.ac.cn>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bluetooth-next] Bluetooth: hci_event: Use General Bonding for ATS2851
Date: Thu, 20 Aug 2026 22:05:30 +0800
Message-ID: <20260820140547.1148128-1-lidaoxun25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXmzm7CYdq1ErhBQ--.29712S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWxAFWDGF48tr1ktF1rXrb_yoW5Cw47pF
	Z5uF1SvFWDJr43Ar17Jay8uF95GFn5Wr9xKrWqq34rJr4agay8Krn5Gryav3WxurZ8JF4F
	v3Zrtry3W34kJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
	cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx
	0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY
	02Avz4vE14v_Xryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
	6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07
	bo0eLUUUUU=
X-CM-SenderInfo: 5olgt0x0xqjko6pdxz3voxutnvoduhdfq/

Actions Semiconductor ATS2851 controllers can stall BR/EDR Secure
Simple Pairing when the host replies to an IO Capability Request with
Dedicated Bonding.

This was observed with an Actions controller at USB ID 10d7:b012,
revision 88.91, while pairing a Sony WF-C510. After the host sent
Dedicated Bonding, no peer IO Capability Response arrived and the local
host disconnected after approximately 30 seconds.

Sending General Bonding instead allowed the IO capability exchange to
continue, followed by successful Simple Pairing, link key notification
and encryption.

Add a quirk that substitutes General Bonding in the HCI IO Capability
Reply while preserving the MITM bit and the connection authentication
state. Enable it for ATS2851 based devices.

Signed-off-by: Li Daoxun <lidaoxun25@mails.ucas.ac.cn>
---
 drivers/bluetooth/btusb.c   |  1 +
 include/net/bluetooth/hci.h | 10 ++++++++++
 net/bluetooth/hci_event.c   |  4 ++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2bae85b001..e82cb0c44c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4384,6 +4384,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE);
 		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_EXT_CREATE_CONN);
 		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_WRITE_AUTH_PAYLOAD_TIMEOUT);
+		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_DEDICATED_BONDING);
 	}
 
 	if (!reset)
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1641d879db..ee01795ea5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -320,6 +320,16 @@ enum {
 	 */
 	HCI_QUIRK_BROKEN_WRITE_AUTH_PAYLOAD_TIMEOUT,
 
+	/*
+	 * When this quirk is set, Dedicated Bonding authentication
+	 * requirements are sent to the controller as General Bonding while
+	 * preserving the MITM requirement. This is required for Actions
+	 * Semiconductor ATS2851 based controllers, which can fail to continue
+	 * the SSP IO capability exchange with some peers when Dedicated Bonding
+	 * is used.
+	 */
+	HCI_QUIRK_BROKEN_DEDICATED_BONDING,
+
 	/* When this quirk is set, MSFT extension monitor tracking by
 	 * address filter is supported. Since tracking quantity of each
 	 * pattern is limited, this feature supports tracking multiple
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2f5e21ff97..5496913d8d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5386,6 +5386,10 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, void *data,
 			conn->auth_type &= HCI_AT_NO_BONDING_MITM;
 
 		cp.authentication = conn->auth_type;
+		if (hci_test_quirk(hdev, HCI_QUIRK_BROKEN_DEDICATED_BONDING) &&
+		    (cp.authentication & ~0x01) == HCI_AT_DEDICATED_BONDING)
+			cp.authentication = HCI_AT_GENERAL_BONDING |
+					    (cp.authentication & 0x01);
 		cp.oob_data = bredr_oob_data_present(conn);
 
 		hci_send_cmd(hdev, HCI_OP_IO_CAPABILITY_REPLY,
-- 
2.43.0

