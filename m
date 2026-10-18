Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7983937F006
	for <linux-bluetooth@vger.kernel.org>; Sun, 18 Oct 2026 04:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792298357; cv=none; b=ciMUe8AXM14LZpC2PE9cIAF/0jdJKDk3rG+uZEZUAbXkH84jiHMNCT+/OKm5hqeXjACc6MXJ1ol829RSFGDxYPOr+9VLILU0A4AJh6YbH03rf8h+ZMRJsQISAZeMFvm2fJbwMz/eOqmBb7I2/mP5Eh9a3tS1JalW97LhHDYX1B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792298357; c=relaxed/simple;
	bh=G+daI5zPcnbc6BiJcYZrZWnr3iZqvYXHHzfrQX3Rt5Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HRkLqFqSXiuURtN5rG7rOrV2B9RgZZGaFxIgda3oJ0a5fb51II5lbHVFCwU/IUGxVGGRuJ13DJkb75QLV5uvb3NY8TVYxV03KZOQQvRI5RtO7Sq5ePMi7ca9zvmlaQIm7bCWw8Qeo2rf5At8PaX+oLfa1eETIt6MiJOcJtShUqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYcBpCFT; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYcBpCFT"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-824761fa9c2so137381a34.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 21:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792298355; x=1792903155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6y026zDEOfXcLrB5QovyhaFHhUruicZKUHD/tiZfbY8=;
        b=iYcBpCFTs1S7w5mHdqWhRT6bMi4mdP6OjFMeZ/sPx78NUKIZv811ni7OCdS8M+WOet
         Yjc8JbVO2CARS5Z5JVMl6BPxh2l1/s6ZU5BaPZwdRJ4tutfqZuY2Vtu+O6rY6Fb4lbLE
         JVA0N6ZsWNflqdyfyoan7wXwcgcIGYNApSmYY1fd5Q5lBNwXCp+DB2qFTQZhnV+yoXH+
         DkII02zWkMSgIRtX+RYOKwbXhPiDKGXyPEgEdNFAzfJ4XExl5znQK7l/07vIrkjYUSiE
         0ijc3QTWIykRUbOI5/hkbHkWZplZiZ1Ca0iFz6OhUgoU+FntMFOuYM7x6FmtW6nr6S4L
         9vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792298355; x=1792903155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6y026zDEOfXcLrB5QovyhaFHhUruicZKUHD/tiZfbY8=;
        b=us0vCMfC7Cbag1/gMQSiPzGwFe/bfa5C/j2/B6Ypn/y5hHwlSF/TMoPVSEJy2yse/R
         wQrihvDb8xtO/FGGYmk3oNEgZQ3UdlDab6CcxPl5LIwhiQw5y1txxXhhBFz8ThqLGmu/
         4qFQ2CXjVCIoYehivreJ8tK1mxC4hT5E4lEzi+lNiGvBB2bwK9wQkE0qnr14IOOzO46V
         3tn9ADnCEDbGSQ1yB0bCExdmtP2ccto5lA+o9g5QARqmfitvJ5iz8Z8XvOxhRlfr1lK1
         gDptUyiJOm6lbEDWD7zUl6epVCLOdwtLyQisTwxjB1ZAtRgNsETUF4N8Lb/MUgq5zGcz
         +Iaw==
X-Gm-Message-State: AFq9FYKOuMi6c3/t0XeeQ1nSOfufXIk9CS6WwMZX1bTA9ifkJV/Pqwlf
	fZy7npZfR6Um+sh8nkjE5uQvI78BkEFzXPCIXHkzjIMVFoT98AXZVTjMXzXEodn+sB0=
X-Gm-Gg: AYBFou0Yt73Jpd0n5u3Ooj2bVb8nitdk7piNWYPvCCUE2owYd3oYvND4fH5EWWYVqFG
	Fi3SqhUGZEwYm0iVtZtFL5STY2r0dm8xomw8JdCz5o9kMGR2mkrOQPVwjAsCItbST30qv54pFeP
	5eeGh7Rb/ThTB8fYmvDQMdeKgtoS4AZZ6KYe68ibTr/Rw80b01g7pphclWsSJPMtrn7gWXgqIpQ
	6Z1GtguWfPC3lZnXha2NAdl7mk32H+IEhAyfWECbzWFBjVeWrD2c9C8cv89WlIG6tioVgk62IKt
	mkiuJqsWrb0uusWFyaBq9kBzlXe13XpPF9TjYgMGZ4UPGhJiNdOncdls9yTcRSrn+mu81LLtLm/
	xwzEYNG6QELGSF9CQgFcBpjbrZU/v4pm/zgwVSOGVZH2Dgbvm7FwkB16QxsoHAp6KoNluu+EJBC
	1/sb5O66eD8p6qPY2nEw5NoLyKq+i/MGRx4kGFmbkkv7QM2T4nxDDlSyyfXbKfEHaY8x/H40xuo
	KCX+7MBZybpLGMpm0AKDapKMQl5tfD+v8qxwSvYC8OloyVYTBz/Vw==
X-Received: by 2002:a05:6830:3109:b0:845:8d86:9f71 with SMTP id 46e09a7af769-8458d86dbe2mr4473247a34.3.1792298355415;
        Sat, 17 Oct 2026 21:39:15 -0700 (PDT)
Received: from localhost.localdomain ([149.40.56.10])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a0f31614sm5735617a34.3.2026.10.17.21.39.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 21:39:14 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] emulator: Avoid variable length array in send_cmd
Date: Sun, 18 Oct 2026 06:39:11 +0200
Message-ID: <20261018043911.1756937-1-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use newa() for the iovec array of send_cmd(), as shared/gatt-client
does, instead of a variable length array.

This fixes the following warning:

emulator/btdev.c:479:29: warning: Variable length array is used.
---
 emulator/btdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 67eac8fd0..7a8d8a464 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -476,7 +476,7 @@ static void send_cmd(struct btdev *btdev, uint8_t evt, uint16_t opcode,
 					const struct iovec *iov, int iovlen)
 {
 	struct bt_hci_evt_hdr hdr;
-	struct iovec iov2[2 + iovlen];
+	struct iovec *iov2 = newa(struct iovec, 2 + iovlen);
 	uint8_t pkt = BT_H4_EVT_PKT;
 	int i;
 

base-commit: fa6ba55020dee3c3183041c854c347b4582448be
-- 
2.43.0

