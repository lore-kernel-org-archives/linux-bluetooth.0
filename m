Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F210334374;
	Tue,  8 Sep 2026 06:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788847502; cv=none; b=raHlHnhsCj/mmQQDTrnVuICCM96GItC60tbhZAw2JqT0xTEMcP1BK7hj82v/1sY8FB3rxVq+US3EJ0k4luJNHeYArB13/idvxK3s9Z2SIgCp3teE+Gd9C9Ihx/8xYQPcykngBONI1izeP0cPFtePXOUY5+2eVbh3poWNdRF8zMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788847502; c=relaxed/simple;
	bh=N6GsYlm4R02HlFRKiSJAP8dubdpupRSeDp/flGHeCaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UtlNDTdWR/5bh9q/v/vKbJkar+ZiJxEkOjd75i6AzKAR5+azFRSHrALEwcR6rGlz+/LOaFEr6VZVZyozJsW7FKC71a03ne13QkRUZiwBlYNjoY7MIft9S3QOWYmkxKaFpu3kRGovdolLirdDlSxVUXSs+hoGFqkKg8JUgRQIVuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: zesmtpsz6t1788847468tfaa76b0a
X-QQ-Originating-IP: bpNdYVvuBaGb0FRVWxYnF25oOD3XLv5BFzCRmSAWrEY=
Received: from localhost.localdomain ( [39.144.190.97])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Sep 2026 14:04:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1778941879433745811
EX-QQ-RecipientCnt: 5
From: Xuhua Zhang <zhangxuhua@kylinsec.com.cn>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuhua Zhang <zhangxuhua@kylinsec.com.cn>
Subject: [PATCH] Bluetooth: hci_h5: Avoid clearing the escape bit for ordinary bytes
Date: Mon,  7 Sep 2026 23:08:08 +0800
Message-ID: <8B4A9BA701BE6DED+20260907150808.13442-1-zhangxuhua@kylinsec.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MAn/YGr3W4JHHXD+oRNLWsVTk3Nj9PXOcGWtOosW5SFK8jxlp8ZOH7vP
	iuDjyyb2vQNdPMqQv94TB3EXqoyp8G8L9zDet+1h1PsCGD/fMIrsXolZyRP1xIJhgdqgOwF
	na3bK3UqdiD/tc1lvBu4BpaDfFKBA/hrxZAqBNvzgknlydv5XCRXSLM9aEWfSM80UuX37iX
	S9z7JyaPWIeHudYgDag8dxKmjb5yT4MFRkU43+i6VgyjTGvMrj0MTvg0jHAHNoyJmPfIur2
	BfSuSqrb6bSEMUsEmKceLmnEg2obhpZndWaK8VMm9VcNxJZ5txvHyKt0xI2ZgKMckkPa+ns
	gMo5gFRd6TY+6Rfxn2uOAihuGfKtEWMgV+m2hjmrJ8UJeoCF8UOzmy6x6AqgRYSv5d/riGX
	Rv/tP4I+guZSHcG0+rbWH/vYAtBsyrtO92gIuvyAC7fcqAhPEG6xNZH+YgXY1FFwkJbvOS4
	RGphlgiydnhbZbd77bJOczHHpZJar/VPLbRHJ8MIYC7Txg+eaSEEfCFsoFVCZFAzYVctewc
	pveUSV8mMHxa78W+GxYfERoBcDS1ULLZOfN1Wd+xM9KaO/HbRBu3M7WCEI5K03pD79qnYYZ
	ZUzdeA91WrYsUpus7rMWqlI6ylOBO8dL+Yu1lDEFogLhXqwabiGEEuOJh+KI9tsf8E7NKYj
	mcGcqlCSk0+UWbD2A59QrYXeL3Q/Ob29UZ47ZhebvpRmUeUYvz71U0DVgbObQ2aLEstueds
	9z+c+2VhIkMfFAhgX+htYtVnMfLjY0pNAJg5K0U8PljzBEnqGXpqvfqC7gliNOXRKsQXKpu
	cjRmQMe+9wmhXWiIKCtloIRoCsg6kpEr3ju0MnNkqpZD9G0WEdLx8JzAJSQdCHrSb00ppgr
	lr1fPMwccnNFWfdDnQn00qPNi4E40jH/3EdcHVu+BE1kNC4PImOEKVO1UMyS3OAkefHMcVB
	8lzKn1BybEe9vdj2Hban/7vZTWqSpks6wID7I4Aanr3tL2lNmwxMLk/CgnL07324SN/W+Od
	oJtdsZeZ9Zz1rlY0xT4AtrLRh2H65F3xL4lhOG93VYFPewfoYdY0JleYDIrMY=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

h5_unslip_one_byte() calls test_and_clear_bit() for every byte other than
an initial SLIP escape byte, even when H5_RX_ESC is already clear. This
performs an unnecessary atomic read-modify-write on the ordinary-byte
receive path. On x86, it emits a locked btr instruction for each such
byte.

Test H5_RX_ESC first and clear it only when consuming an escaped byte.
Handle an initial SLIP escape byte in the alternative branch. The HCI
UART receive callbacks are serialized by the TTY layer, and H5_RX_ESC
is only changed by receive processing and initialization, so there is
no need to atomically test and clear it in one operation.

Keep set_bit() and clear_bit() atomic because other bits in h5->flags
can be updated by the transmit path concurrently. Escape decoding and
invalid-escape recovery remain unchanged.

Signed-off-by: Xuhua Zhang <zhangxuhua@kylinsec.com.cn>
---
 drivers/bluetooth/hci_h5.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index b1999e14aade..37f4d9327e72 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -543,12 +543,8 @@ static void h5_unslip_one_byte(struct h5 *h5, unsigned char c)
 	const u8 delim = SLIP_DELIMITER, esc = SLIP_ESC;
 	const u8 *byte = &c;
 
-	if (!test_bit(H5_RX_ESC, &h5->flags) && c == SLIP_ESC) {
-		set_bit(H5_RX_ESC, &h5->flags);
-		return;
-	}
-
-	if (test_and_clear_bit(H5_RX_ESC, &h5->flags)) {
+	if (test_bit(H5_RX_ESC, &h5->flags)) {
+		clear_bit(H5_RX_ESC, &h5->flags);
 		switch (c) {
 		case SLIP_ESC_DELIM:
 			byte = &delim;
@@ -561,6 +557,9 @@ static void h5_unslip_one_byte(struct h5 *h5, unsigned char c)
 			h5_reset_rx(h5);
 			return;
 		}
+	} else if (c == SLIP_ESC) {
+		set_bit(H5_RX_ESC, &h5->flags);
+		return;
 	}
 
 	skb_put_data(h5->rx_skb, byte, 1);
-- 
2.43.0

