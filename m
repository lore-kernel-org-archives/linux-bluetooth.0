Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFDE3644C3
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979742; cv=none; b=SGoP/J4PpPMnWOqFUtCMTPxeYwpd4FgOqvMiW0eD8uL8yuOmURBaccm0c8BCny1mdDIDTcHivCchMtJ8tnSG6S05r5ED8JF2a9C+/+BYtldkHJYxSKOHtBZyuyaaoL0hpG6I+Mt93G/EkaztWmm8mhzjixGkRS9+MDtAEmljOlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979742; c=relaxed/simple;
	bh=9wEvukbjp4b6/w3FD8Zenc1hgWI0imUrTmV1g3gI6QM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YWCUTy2veZbCR0Xnl9qqOj0PjPCTRJQOhQip+iUWk0TMgyBrkepAh9yUoC+jOKsqlaL91irtxfz2mIHFhrq52ak3Alltn49q3kEzwRXRFTFIAhSEyL1QvhcWSHtbmmukHABbsyDseWtiAl48lGawiBrWi3dqtX1tqvqgD4EzY90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBlKgvqL; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBlKgvqL"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9305a2121a1so48974585a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 14:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783979740; x=1784584540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yQm5VplBZXud0pT3N1/Y/hXZf2iziN+88C4lxjmpLKM=;
        b=GBlKgvqLFpB5kJcGnI6PRlnIj/H5fb1XL8YORPR4Z6lg2u71QuLGURnauknpVZK7L2
         yJWmJWtDHwkXF5wVqZQ+7RfRAajMZxzP0SFLDC6eUSMh3yd8q68k3ubFUIOq462c7kmj
         OqmGJlX4FuxhUWNz6CwzYmzDXx3ww/SCxAxIVGP8tAjby9V5Fk1Qo0NApbzWCU330dDg
         JHlyVvv9KDEP5mw1nzuYeKFmLXRJF0RhDYFMdY8JEkp+hhKxph8LKgzxrYwb7ecU7xE9
         q2Ne3c6Q9vfuH8uFLil6nl7WP2E8Zl6xvd59YaVxGD6lFyc3QQQy4n36SyjM3iSTMNq6
         Z7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783979740; x=1784584540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yQm5VplBZXud0pT3N1/Y/hXZf2iziN+88C4lxjmpLKM=;
        b=YJhAcqNS2XO8YG3N58pRWRRfKyWmYX2BZyhyWpVe1u0Ghduedm097grGI4iS8dn4EB
         L1BPWlJT/lqCZX1hZA0JVxXjS3X8/AMibkB2tJZ8CRLzUYjejfZgmLSbbNFzUunuHUq0
         D9WbvegUVH8oaS+QyvBz7GdLKbZEkfvSxy4Ehmo4X5M6ta7QMEb/HdmeUlib1OCdoPHD
         2YxLa6357EJl+u+xp6JIso0iM3AOim0exMfukXP5q5OxMiMu6EjC/+acR6eOSd4pvJw2
         jZUmRX5qHBOstkSRNOivW199IOdhcNdLppPHx9YdIrOqQkwcjfvn/LbbKaBboN+1/6AI
         rYwQ==
X-Gm-Message-State: AOJu0YxQQNxa+Ng8w24Of0coel87o0L3cWJbCDSnzqv69S+Nzd6JUVCy
	zRjMUPaCiJjNgVJAWgy+kykyl3Q7i+S892Aq3993/21lZNFZQ0eZ9srXYlC4lEMrNIE=
X-Gm-Gg: AfdE7cmeDubLJjI4p+wR2M7z3KEs1eEn5Nb1+8UCl0MiIJUKL6lgvRky8IIyv6ZXCyt
	23STQ2HuB9bPAk5aADcKDqeyk6MPGnBIAEmUL6XPLimHk+3NcBaCsEP3+F1bCjK+AB3ljT580zr
	1WLRDYjZAOUe4xy+CLvQGcaoEdvYmIzf1/YhiznZLLaKQ/hSOUEIR/3QNRQ5ICxWzk6LIq9uJen
	E7cxlFDqMBIAXzAQ8p/w5jw/WeO7pf81PcP+o0lFtG2tposdRTrQPNrF7dNcT5geaMiVwizCEYC
	8A3D/Jgkt4oyFM3leC3ADP9JJ4x/yk8pkSQxzsfSq9Qnj4meADuB3csiEWtlkpoP2niWYS5PJWS
	UrjlA3sPbAdt4Pj4pSCljxpHrF6r20PcT6plHbL3J2nF439aC0P1/Jq6dUStZ8f/GxsJ79qPxKQ
	n1Yt/TKnkSICy4IWuXoYV+OD9Jx6ZxAgch8vgu
X-Received: by 2002:a05:620a:700e:b0:915:9aa5:b5c6 with SMTP id af79cd13be357-92ef2bb6d07mr1181941585a.36.1783979739815;
        Mon, 13 Jul 2026 14:55:39 -0700 (PDT)
Received: from pc ([209.202.207.85])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cfacb3sm1206001185a.26.2026.07.13.14.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 14:55:39 -0700 (PDT)
From: Ameen Al-Asady <ameenaladdin@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Ameen Al-Asady <ameenaladdin@gmail.com>
Subject: [PATCH 1/2] Bluetooth: btintel: Fix spurious error on FW download error recovery
Date: Mon, 13 Jul 2026 17:55:36 -0400
Message-ID: <20260713215537.81222-1-ameenaladdin@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When firmware download fails because the controller is running an
operational image whose version does not match the firmware file on
disk (the normal case for a firmware upgrade across a warm reboot,
since the operational image survives in controller RAM),
btintel_reset_to_bootloader() sends the Intel Reset vendor command to
force the controller back into bootloader mode for the download retry.

The controller acts on Intel Reset by resetting and re-enumerating on
the bus, which can happen before the command complete event is
delivered. In that case __hci_cmd_sync() fails with -ENODEV and the
driver logs a misleading error even though recovery is proceeding
exactly as intended:

  Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041.sfi
  Bluetooth: hci0: Boot Address: 0x100800
  Bluetooth: hci0: Firmware Version: 202-5.26
  usb 1-6: USB disconnect, device number 4
  Bluetooth: hci0: FW download error recovery failed (-19)
  usb 1-6: new full-speed USB device number 5 using xhci_hcd
  ...
  Bluetooth: hci0: Firmware loaded in 2827613 usecs

Treat -ENODEV as the expected outcome of the reset rather than a
recovery failure, and keep the error message for genuine failures.

Signed-off-by: Ameen Al-Asady <ameenaladdin@gmail.com>
---
 drivers/bluetooth/btintel.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5e9cac090..472542bff 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1363,12 +1363,22 @@ static void btintel_reset_to_bootloader(struct hci_dev *hdev)
 	skb = __hci_cmd_sync(hdev, BTINTEL_HCI_OP_RESET, sizeof(params),
 			     &params, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
-		bt_dev_err(hdev, "FW download error recovery failed (%ld)",
-			   PTR_ERR(skb));
-		return;
+		/* The controller acts on Intel Reset by resetting and
+		 * re-enumerating on the bus, which can happen before the
+		 * command complete event is delivered. The resulting
+		 * -ENODEV means the reset took effect, not that recovery
+		 * failed.
+		 */
+		if (PTR_ERR(skb) != -ENODEV) {
+			bt_dev_err(hdev,
+				   "FW download error recovery failed (%ld)",
+				   PTR_ERR(skb));
+			return;
+		}
+	} else {
+		kfree_skb(skb);
 	}
 	bt_dev_info(hdev, "Intel reset sent to retry FW download");
-	kfree_skb(skb);
 
 	/* Current Intel BT controllers(ThP/JfP) hold the USB reset
 	 * lines for 2ms when it receives Intel Reset in bootloader mode.

base-commit: eab19cb7618e5c50fd1f8c1efdc4e66e16575975
-- 
2.55.0

