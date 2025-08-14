Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DE423ABA7
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186141; cv=none; b=OIdX+CqSXnPwp95F4dBDsFb/ET2JRotSIBsLRf10Uu8aQDpoyfK84vjZKeWZXDSwOrVASSA8u1mDbMQIEqMan6GIkH8cfpUgLmsXk8gB/cOLHz1uuyPRdAlU7JoRJKc4YArq/+gjHkNy0cw598tkfDfJpyG8j8LfYh1vjWn717g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186141; c=relaxed/simple;
	bh=v0bOi9xX2qwRuV5ph8bQeR05YEI1n25fILqj5TVAUSY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XzbfD486koY/ts2FRSgzI03kT/VwrTAtNuecNlyv18P+eu5QS5yJYDpSL0ILXtLFXTxDUn2bPMltQ9sAnHbehS820/VUgWSPhLArS2ED9/J/av4DTZ5qqwtNnbXjq4E5ltBvmu/azkF2LISOLFwPFsEYoQSyqUGlGs4MYKK/nRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E90i3X5X; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E90i3X5X"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-53b1740154dso739077e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 08:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755186139; x=1755790939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1FdSl0Ehd7Wqv/wH7ISLEtXFGnt5ZXFAuG1oTTTgxGM=;
        b=E90i3X5XoJwtSkUWZkFyWKB7xBGhVYljUpO2VtCGGeKl7Db57ZHC7k8T2mGL7z3+wl
         FeUomOb0/VbmhokGJ51wLhs5lz6CqjP5NvKI3WelrCTMrOED5hwHXPzRXtuhHxtsH6na
         +fZ692QWXW84fPSMpe/OKzx9SMXB0Rxut7KxoUDxkwhMejXcZVpBoptSP5W8tgUdnChg
         eROTEFG8cx4cP8jrgWHD5Q0EhKFcP3h/zREegDlVhobSYegsmv+99Dd3JjMK0thFwKmg
         0KOopAfz26xSmDg7ZZb3up6i0KEBqAQCBAwekAOGdQ3HncBtTp2ZSfG4dUFv8aRrGV2g
         wXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186139; x=1755790939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FdSl0Ehd7Wqv/wH7ISLEtXFGnt5ZXFAuG1oTTTgxGM=;
        b=WWl31teEEhZhcX40jRFdLOvtnoSvFZN9HwX1DNhAMabDCWxUo2Zbwc2g8ys1HZXxxm
         C/C49vTOQGVjVpJBfOocwQfZhr8AlLSNq+f2SXKstSIwjanzpgUMY9koUjaSQofBU3Cu
         LoQQUSIupgZ5UFKDGaIomJjLrmUOtdOHYGkmH2sqnyj0b75pAqV+2G1zHgmqSIn6AgXY
         Rn9q7ZpAcoIrPOodJh5vCZUHUho0IMWfQrlR/njgDoRrhbrLEBRyyEBZHalqRMtMBtlZ
         eRT6Z2l8WUAsPfAy4/BJKwYJFjEqmcAHytKCMbSXe8fkDGecArbAUddrmcEEmr16KBDk
         vVQQ==
X-Gm-Message-State: AOJu0YzirDUDsWnY1hUKcbZGGUAAtdenLspDyhHmYkJZs0UzYuwjm3GP
	QOXI7S0ZkLtA/j5EjpkdU3szXt71xzdItcrG2BRq9DKWSWcBI/4naxLO5wqIY0YJ
X-Gm-Gg: ASbGncuzi8QdDG1ab6BZ/EqmRG6mpEIMkbptceWSywca/Ld9xFWjcHDqxb8pmVx06aB
	bmwwzHmAhK33ZaTKHOWjmI2PZrUog2lkuJxuIU60gnCtZgItjsgHqvH7gdyKUHdcWcndWTafS0x
	gaN9/7WClfRVHyhQsrUfIkmSOzeWOmeUevXKBW+D4NkX1o4VxRJ0HxsDQ4nyKDzcq9cpiVxoMGe
	t0s4OUORycgrwNkNIWBTgl1OhpQGy12YKife3xRv6ACbpUnejFwLSRdTrUI81KHxA6Cea0c6G82
	uoAuuk0Hk0SfW3qgWecAJMFH1CFE8LgRXSYdLhnUXBoCvcCDLO6WoBwN6DyHfiJYsMrvg99J9dL
	n5X9mfXTmT8/qI/Vg+yOJ2UU9MAnVl4EWpvw6Rnau/EQ0qmzdrL4+3MDYjoHZj7SF
X-Google-Smtp-Source: AGHT+IEprn9ORU2Kbr5oK1OLSpeI+Kzn3uaxFeyJ8PbcSFCcHWKeyyzfuJ5994k2e1VzAKnpcKgAlw==
X-Received: by 2002:a05:6122:6585:b0:53a:d808:1ff2 with SMTP id 71dfb90a1353d-53b19c32c7cmr1383405e0c.1.1755186138655;
        Thu, 14 Aug 2025 08:42:18 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-539b01ae76asm4723431e0c.8.2025.08.14.08.42.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:42:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/5] Bluetooth: ISO: Don't initiate CIS connections if there are no buffers
Date: Thu, 14 Aug 2025 11:42:04 -0400
Message-ID: <20250814154208.8433-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the controller has no buffers left return -ENOBUFF to indicate that
iso_cnt might be out of sync.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 5ce823ca3aaf..dff3fc4917d6 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -458,6 +458,13 @@ static int iso_connect_cis(struct sock *sk)
 		goto unlock;
 	}
 
+	/* Check if there are available buffers for output/TX. */
+	if (iso_pi(sk)->qos.ucast.out.sdu && !hci_conn_num(hdev, CIS_LINK) &&
+	    (hdev->iso_pkts && !hdev->iso_cnt)) {
+		err = -ENOBUFS;
+		goto unlock;
+	}
+
 	/* Just bind if DEFER_SETUP has been set */
 	if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
 		hcon = hci_bind_cis(hdev, &iso_pi(sk)->dst,
-- 
2.50.1

