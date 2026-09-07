Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DC736B92B;
	Tue,  8 Sep 2026 06:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788847743; cv=none; b=RyNWZ84piGavkX+NaGpvcSAdEMihKpMz0OaaaW+0GXbA8nx9ZJ2m11oEEc8q7rlBj/bCjQ9B9+qXWlBpjMvWeGjGtVxinRKTP0/ovt9lA4/kOMPG6pA3nsgWLafazBV+hgOrDKJLU4PhEyvcb24PG6ZO50HID5DU0jxSxE+lhk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788847743; c=relaxed/simple;
	bh=fcaoUqvYL76N8Nw3lHrzd4EC+S+gqT/vA0ds4HsboWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=okUeejP+RWiIGv4QJZs4Va8frU5NYrgPC322Iw2ZmF2UA1f95ML+qVMPAp/vPpLDnt6yqKdmKMY+gf8SG6lWe+z6SpsYF6leSxYN5OK8fuCipj/uidKwNkwUbDfxd7DnH4m6Prep19KtG7Nm8Vfx0i9UH9AQMUeqcyy12/VP8pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: esmtpgz16t1788847715tb7285871
X-QQ-Originating-IP: SEfJL9rAMZDeKA1FN1dqC0EMj7Wsjq2WyNAmPvWjSAY=
Received: from localhost.localdomain ( [39.144.190.97])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Sep 2026 14:08:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6356268314036142137
EX-QQ-RecipientCnt: 5
From: Xuhua Zhang <zhangxuhua@kylinsec.com.cn>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuhua Zhang <zhangxuhua@kylinsec.com.cn>
Subject: [PATCH] Bluetooth: hci_ll: Sleep while waiting for the controller to power up
Date: Mon,  7 Sep 2026 23:12:45 +0800
Message-ID: <8A1A2E77C277A87D+20260907151245.13609-1-zhangxuhua@kylinsec.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NV9lVvsB36OptcF2U9IILXEVFGnRylEEm9GBKVP8F9X/yZW8a6QeoqPl
	L3UTSlpMA0plIPQfGLyfQQhlTOfKoJkFeNjBYxSFZUgm6g9gysuUeL4kjH5x3Od1wT2TL++
	Xms3AgIdTN8XP9OFKn8KNxo+v2CyfISlmJDLUciMTmnUjdjjyV3t32XlPjI3iUW2M03MsbG
	jim9GnqafNVW0XSCnzCw2J8haVBHzBVWKOlbUSnrhjRkD26zX2VKpk+dCyIVwk1Te8vBoav
	CVIHsgl6mDkD+OnMFGKUSLvzxVM8Huf89ZiO8/qhLOtEtLG/6yi30K1X+jMPCvFV4Vg2App
	AyAre13ryMDg+IMPR/AQbRWvOJlvCpIepBkspqonA41gGGalCfoZywtIbqgLYnwZ67RCgoB
	6ySN8YG+3o7pRfUMoTEVYDzEFNiWSnVvcOXT4hIgI02G5QlT3t9mJktm7UB628e2vc3TT/+
	S8Inalo79oaY9zWR4xK4iwyqDnqweG6QjI1/LK/ezxiMnq4Crg7xg+JiH+5yOpmAm7vIn0d
	4AzAq4D7p5PSB0xWInCbtOThQ6TGxgL27ATAINmYu7ac6h7bb7ntMyclGdrPa0wvQxgvqdV
	ePpK62GF2s1yLLia5sXPAEM1yND1If4OfUdb5yWssBk6R/zmw0uNLDpoYYuBEK2vSwyBe7l
	LRTKpG5LxtA3IpxoSuzc23BQrsRCAJ1AklIQqTc1orHApnAdE0wTQP6jL6m945+AD8x74zZ
	7DsAsZ2Qyu2P8tyeiYleigLq6CvQLwM+q5dLsAiY465GukVpwS9hJW0Xlsdg9gVtrIWM6H4
	c3a0T0gtTSn4oSj31eTPT1K6h6dkO2UN8wqosj6uRJh2oQs6gNMxHSaaTYg6DolGQCLZKqN
	yVgRR6Cufyqshwup4xOOCrf3v/k0QLbUi6G1zrxf+tjV6Abx7EAmje12B6e2zIAvbjr3SYd
	4h7xFsDB1oM8mi4O3y/RHQ+1/oGbdhHWxyBWzeghlAlBzFEDWsswVDtRzwh4Legg4FCQhiS
	ZvrJWmQ6B5FCpb1c+KAfULCi8ooaYiT4cfmiDe5+dt7iCjRKc2
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

ll_setup() busy-waits for 100 ms after asserting the controller enable
GPIO on each firmware download attempt. With retries this can occupy
the CPU for up to 400 ms.

The setup callback runs in sleepable context and already uses msleep(),
gpiod_set_value_cansleep() and synchronous firmware commands. Replace
mdelay(100) with msleep(100) so the CPU can run other work during the
power-up delay. Keep the requested delay and subsequent CTS wait.

Signed-off-by: Xuhua Zhang <zhangxuhua@kylinsec.com.cn>
---
 drivers/bluetooth/hci_ll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index ab744001dafc..35adf869cc1f 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -629,7 +629,7 @@ static int ll_setup(struct hci_uart *hu)
 		gpiod_set_value_cansleep(lldev->enable_gpio, 0);
 		msleep(5);
 		gpiod_set_value_cansleep(lldev->enable_gpio, 1);
-		mdelay(100);
+		msleep(100);
 		err = serdev_device_wait_for_cts(serdev, true, 200);
 		if (err) {
 			bt_dev_err(hu->hdev, "Failed to get CTS");
-- 
2.43.0

