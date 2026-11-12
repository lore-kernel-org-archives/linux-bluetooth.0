Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794454473;
	b=FNR7zdD9uWuUmKpl3JtraeDREIt2sTyTqtmkedSACBRr7+sTxM+eGFVaczODb2LLUCEF
	 xoMebjVtMoKSoIyXkdw1DlsMXgOHV6u3mS99dn8C80lgfh3bY5emJA7nne6oUSrdDJhxJ
	 TPKxnWLuwQh/oYVDwigS78jtWr7MaC5Cq713TYMRKQAIg2ZBWRkNGaERSK5Vckvguarel
	 9kIBC/0uwc1y1MpE2o1vdxDrfKZ7iDLrUcU0N5FjDjcDRkSstd8HT42oeibAocGPOuQyG
	 ZKmSzU7PAyXBNljhBD6fCDlO/OF+rK8sYRSqT6P73wogXhvNnAc8Nud+fjWcidp2y+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794454473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VlxOhg/fn9Akuy6YRvk2mKgW5TM+VVrtc1bU7/ftshs=;
	b=FQvhNP90xVPKL14RSyDT4IiP24pqgA9RE9roMIZF39q24dHv8gddHC1L4xGVtkg/a5og
	 woeHhaz1LPjRbOceB4pv/OBkpSVg7mr+yC+RaezPXtiNlP2y7WZWrOMT4BuIfHM0/RVxb
	 lawnDhpWolPFJoUfX6/IgDsp/At4jQX3L+vMAI5bBB61JTt0MfL6UU9UAie9qxLSGZ9vG
	 wFH3Q9h66HDvs00nvbrAAWko5CFthygl+jsVTX78dPAwkjsmI1vG8T6oOoJfqB21XhBFE
	 axu8b+g2VaczewMqxkFYRjmRFJUAnZViS1g3WhfvaoXxn3K1G1WAp5YWf14KZvesIEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LQEnUdOh;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC29606A327
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 03:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DC29606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LQEnUdOh
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1931ff67a29so6899162c88.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 19:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794454472; x=1795059272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VlxOhg/fn9Akuy6YRvk2mKgW5TM+VVrtc1bU7/ftshs=;
        b=LQEnUdOhwBW5s7ZV8xTGWBpMZFysMkNhWCPMuEQ2mEpoHyNM+nMQ4GvNJ0/HvgbD8A
         UsBsaeY86DIbHI/OBZoe/vFNAdJ3c3d0/mI0dpZSkkB9x0jzECYUEUhs296qpqKkjb/k
         /reofNJ+OLWjsqdol1imH8jQCeWugHtjNbKXz7vIF6KnRc3mqimBIlX3zuolyMMZcEo7
         WWDJ6EOYLFMCMtkhPn1uZ5AUnSGkIbtF2E+6GYSIhNT+Cre5N9dTOlqfypTJ1Nw6vikh
         vVq1TJynlzRWEdE3miSgJFOv613iHimQwqMRxmKJlrJ7XBT5OtPk56LhYp7fj2SiGj9c
         mbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794454472; x=1795059272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VlxOhg/fn9Akuy6YRvk2mKgW5TM+VVrtc1bU7/ftshs=;
        b=1dhpEtFdqMGF3MgteJ1mwrkr/MaOCbPuBaIK2EOXe3hZz+HiBC1fWVR4XuYc6xYc4Y
         KyUXyZl92mmN6gc3ACHc+YkMMDr532ah4ZxhHz73cxLGyE8OSWJJ/1x/Pe610mJnkN5H
         BQJwMUNb/1OMJZqMNQXjSM6HMVbfV/oDOwJQUfsZjoDgbIRz+lNq/XJr3Qd4qaxewuib
         22LHgU+JhPJ+bXTfGV3tr3iZa1jPcDfvwMTcjjQ7niD+zWYVVers+gDlqxLZxaXWDBy8
         NK8slg6IxA058t0Gq54t+RPHY/5Va1bXbkr/C+pygObKliLMc/2YpTcHj/EyplZ1RIxG
         7mkQ==
X-Gm-Message-State: APuU4Z/X1wpZevy6OSxdcIkCwfQInjs7949HBqYI7KJN0cBdkC/hLmNB
	/gnj6sLjcZqldloQqW/MucuJBnzrVD4/AlU3C5W6wytKBxY88cMNitfO7ZLD4tGwvpo=
X-Gm-Gg: AYBFou1QPkIZ9ZLz/boobBua+Ce/lKoL2EjtKiiREJQ5NzuUOO1/UTrvJaMBlDXQtpQ
	eefeABQ6I5oXIKrUZfbT1Rbsu1FkNmYySP20Q7+Vd+yxarsULi2e1UV4v+VJ+Eo2mBXJI4WiXz+
	hssW92xDXxqslLLtiMXOwvu0p5y2d2e0ccot8BWTVwm+KE0lEW4luWnPEDbjzg4SaWlvY92ClgA
	LKCpV9nZ8RNREOZTVDQoNwoEr8BSu17i+5ykmKWpfvMTx83v0i+p3wNUHur1gyjNPLqgkUUqxEY
	3m431ZQd+ZhcpvZv9CwNZUMxIsVqDYxl90IZFQ9jKpvawNpI9WJQVqxcd7U/KpyZyy35MUCk60j
	J9N3zYO4iJY7bmMqAvdY9zhlV2sJNRfmUDparH+oRb1bG17MJs6c39xMBWv26O+GcH3oCLqRWPV
	v6eWwG972ZSffgd1lhKdtum3b75WO56LfMpEa5YxwcFoflz8vbiV36xZkWoYImf6/56iVo8y3BB
	C6kVeAKP7msr10sJ+Mk9/ntdcrbBWhKx+psx6wttF/J2x1yUpUqSCR33AQv26doM27MUe5y8iiU
	r4Xf3fYdQaQH9YVmJ4G0qsK2fX7PCi2V+g98MKippmS5/bYzyDC6fbvsEGER6+gOnePOKNOCNww
	=
X-Received: by 2002:a05:7301:678c:b0:36d:394d:e696 with SMTP id 5a478bee46e88-37685e6c8b8mr6802224eec.29.1794454472410;
        Wed, 11 Nov 2026 19:34:32 -0800 (PST)
Received: from localhost.localdomain ([96.44.128.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bf3e18sm43225473eec.16.2026.11.11.19.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 19:34:31 -0800 (PST)
From: Weihong Guan <weihong.guan@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Weihong Guan <weihong.guan@gmail.com>
Subject: [PATCH] Bluetooth: hci_sync: Drop the command's sk reference
Date: Thu, 12 Nov 2026 03:34:28 +0000
Message-ID: <20261112033428.898540-1-weihong.guan@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_cmd_sync_alloc() takes a reference on the sk a command is sent for
(sock_hold()), and hci_cmd_sync_complete() means to drop it, but looks
for the sk in the response skb, which never carries one. The reference
is never dropped: every command sent with an sk leaks it, and with it
the sk and a reference on the bluetooth module.

The commands sent with an sk are LE Remove Advertising Set and LE
Clear Advertising Sets, for MGMT's Remove Advertising and the instance
removals, and Read Local OOB (Extended) Data. After each, the module's
refcnt stays one higher with no socket left open, and the module can't
be unloaded until a reboot.

Drop the reference from the request command, hdev->req_skb, before
freeing it.

Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Weihong Guan <weihong.guan@gmail.com>
---
How it was found and tested: mgmt-tester on a Raspberry Pi 5 running
7.4-rc2 with net/bluetooth from bluetooth-next (hci_cmd_sync_alloc()
and hci_cmd_sync_complete() as in this tree), reading
/sys/module/bluetooth/refcnt before and after each test, alone, with
bluetoothd stopped.

Before, 11 of mgmt-tester's 515 tests left it one higher each: Read
Local OOB Data (SSP, SC), Read Local OOB Ext Data (SSP, SC), and every
one removing an extended advertising instance (Remove Ext Advertising -
Success 1, 2, Global Adv; Multi Ext Advertising - Success 4, 5; Add Ext
Advertising - Success 22; Ext Adv MGMT - AD Scan Resp - Off and On), as
did the removal case of the single-set series sent for BlueZ. A full run
left the module with stray references and no socket in
/proc/net/protocols.

After, each of them leaves it unchanged, a full run leaves it where it
started, the same tests pass and fail as before on that machine, and
dmesg has no refcount warning.

A command whose request never completes (a timeout) still has req_skb
freed elsewhere without the sk dropped; that path is left as it was.
"Bluetooth: hci_core: Fix leak of request command on tx timeout"
(Jiakai Xu, September; patchwork series 1168176) frees req_skb there,
and would need the same sock_put() for a command sent with an sk.

 net/bluetooth/hci_sync.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index d5177e146..931494348 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -31,21 +31,23 @@ static void hci_cmd_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 	hdev->req_result = result;
 	WRITE_ONCE(hdev->req_status, HCI_REQ_DONE);
 
-	/* Free the request command so it is not used as response */
+	/* Free the request command so it is not used as response, and drop
+	 * the reference hci_cmd_sync_alloc() took on its sk, if set: the
+	 * response skb doesn't carry it.
+	 */
 	hci_dev_lock(hdev);
-	kfree_skb(hdev->req_skb);
-	hdev->req_skb = NULL;
-	hci_dev_unlock(hdev);
-
-	if (skb) {
-		struct sock *sk = hci_skb_sk(skb);
+	if (hdev->req_skb) {
+		struct sock *sk = hci_skb_sk(hdev->req_skb);
 
-		/* Drop sk reference if set */
 		if (sk)
 			sock_put(sk);
+	}
+	kfree_skb(hdev->req_skb);
+	hdev->req_skb = NULL;
+	hci_dev_unlock(hdev);
 
+	if (skb)
 		hdev->req_rsp = skb_get(skb);
-	}
 
 	wake_up_interruptible(&hdev->req_wait_q);
 }
-- 
2.47.3

