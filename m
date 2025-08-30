Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CDF4CB5B;
	Sat, 30 Aug 2025 20:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756584239; cv=none; b=M18Nl2ApIfW4HopV3g/U/5T24ZB225aBxtPswnJFXDm6ikqNvgdsXErROqMIXfolOtBZlMvX54AEFP0hsglVwJLzogTyRc1f3BvFxcp5m2w/fGJHDzujmmf8Mcj2j6Sz/YLf+suisO9GWvbRDQFfrWfHW+0osb3cz0izpLnLyUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756584239; c=relaxed/simple;
	bh=eJjBGVqjq0Cbd2n3+vzH4ntwM9XJkbxmIAZC7hyK9nY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bm2hFLas0hmhSytEegaOtJtuZjxZHkrfou5q7ETrXI7845Isgdo5utYg5HbhIWCrXqMcHqeEjMutUpeoreF0UIHCQ/GcJ7I137IxCwFh14pbvXOeLznkPaUQSksIreE+aYd6AkShco42qvcgsEfPvsQZRL9WhxtDG3G/MfFnuLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiMwrvUg; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiMwrvUg"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b30f73ca2cso19028151cf.0;
        Sat, 30 Aug 2025 13:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756584237; x=1757189037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sasd4a3SBp9Y+s3Eqv/SPLKSMnkbSzEIL4bBWpanmls=;
        b=PiMwrvUgAYtn0LNda+Yb+o/2VaRDTZh8KKCkEOnPsW2iz4PXLSN6lmy7DIpzo/8RnC
         7MNHLIhRS5uNa3lyat70umjd/lhkXAdrT+Gj4qGKjsof4IXJ9Y3BqNLwsIYQgwlxCkSO
         /VGCkg5PK84pK0BBxJvlR2SyqrRJ2j+q5jf4ABkRRvtOEeH2v31mK/oaw8+KizsSY7HW
         51PBJ5Sk3I2KjAQMibiJL2992V2tUw/tbJ+bB9FvqsFrbm5kL3sk/6U4++n+HeyjAttE
         Wex7wRvCZ1sDCjpDBDfU8g7RHnqEkOADy0nADJy2t/Y8FufBDrB5ZLYnNuuZ/U/Qg1ku
         R3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756584237; x=1757189037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sasd4a3SBp9Y+s3Eqv/SPLKSMnkbSzEIL4bBWpanmls=;
        b=llxlGGZ5mikMjwpa3IJfOtvB+71mP8VE8p0mK89MrhBTWpjINCjQNjESo9A34/bycC
         U/TuLb5NfPiOmzNDad9afUFPqwW34OcUr+uXvpaKQ7oylXbKVEmQODbnE56Tz3H+/PGk
         cWjy5OWZdRmp5kL6klqbv7Jc/FIgzDq/QQMB/aHrAJIaCC4M+MOke+5ZtsK0Zl2KhfN2
         /wBXIcqV8yRVJfvPITYl0/wJ769cvTTa9xjDUF+M02paLuAqd/9f1Bc+u0W7d+K2cyhP
         5mDxGsBB0kQtQobKl5BIZVffYBLPBZZEmfIb25GRNoIq0cuWAS2DDQS1tpRixF48gNaf
         XxsA==
X-Forwarded-Encrypted: i=1; AJvYcCUhNLISbcL7cAX6EUD+uyPYOSqx6MLQ3HeigCkFNGmgq+lCAz+l/qjexZlCJDzflT7BEQS/6iUAajfuZDT2@vger.kernel.org, AJvYcCVAx5fxtmsVyfkQuFvyBimHE+yJamTFz6U7StA8iVaOs+WbOAVA0xDUu3lun1+vmyLA8C90dw/n69vntJ2Plhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8P1f5AgqBo6S0H5LnP49ppRfYHUtQ7k4+m/C37+TCWfnDYYjM
	/2edHrsJdvBSxix2o+Uu0tnuUQncdVeoj9Mc4S6jAMHOAeGGUAV6tA+7
X-Gm-Gg: ASbGncta6E0X3KZj/JVdE1t3LBeK8Zh53QJl7ftrMNbsjCSYW0TPOHh1xSWxfWP5qL6
	isJcuEe3BIeg99gk6eH2SqE+U3n9fcAH67MGIIJ5shS2HSmd+ifvWYRCUVNowyyvqKPMvprHGzh
	l5UJdVV6ajFWSPzxrqQ1YeAmVxEtb1pdaJMquectKyGshyFrJqhg2m/Tpt6E1WMaPlY3/e5B/AY
	y+LBMd90FFTZzzOyIN1D6wt1w0qZlT07cZvFxWTO44wsFkjcWDDa4NzmtMbxcbSH3GPgp91wPiG
	GRr94dRM0j17HgjqRqaJ+tQ5eS1HFaFmOGRUjAY/TvRkDCMqZiWdf7r68mH+vvzHINgqNlXq5yT
	x36nOHZEScUsH+tmP8CQ8CcmBDsWO5KGf2Mnn
X-Google-Smtp-Source: AGHT+IHAOBPvGccG2Yt3x1H2hlqsADA4VIqx5FT2n4SVJvSgKcwCsDFLo279rPL2gyUDstGt/sMADQ==
X-Received: by 2002:a05:622a:4c7:b0:4b3:552:27a9 with SMTP id d75a77b69052e-4b31dd2186amr29143791cf.58.1756584237197;
        Sat, 30 Aug 2025 13:03:57 -0700 (PDT)
Received: from ideapad.. ([96.67.4.241])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b6715desm37123011cf.24.2025.08.30.13.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 13:03:56 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	mmandlik@google.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>,
	syzbot+4ed6852d4da4606c93da@syzkaller.appspotmail.com
Subject: [PATCH bluetooth-next] Bluetooth: bcsp: receive data only if registered
Date: Sat, 30 Aug 2025 16:03:40 -0400
Message-ID: <20250830200339.36429-2-ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, bcsp_recv() can be called even when the BCSP protocol has not
been registered. This leads to a NULL pointer dereference, as shown in
the following stack trace:

    KASAN: null-ptr-deref in range [0x0000000000000108-0x000000000000010f]
    RIP: 0010:bcsp_recv+0x13d/0x1740 drivers/bluetooth/hci_bcsp.c:590
    Call Trace:
     <TASK>
     hci_uart_tty_receive+0x194/0x220 drivers/bluetooth/hci_ldisc.c:627
     tiocsti+0x23c/0x2c0 drivers/tty/tty_io.c:2290
     tty_ioctl+0x626/0xde0 drivers/tty/tty_io.c:2706
     vfs_ioctl fs/ioctl.c:51 [inline]
     __do_sys_ioctl fs/ioctl.c:907 [inline]
     __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
     do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

To prevent this, ensure that the HCI_UART_REGISTERED flag is set before
processing received data. If the protocol is not registered, return
-EUNATCH.

Reported-by: syzbot+4ed6852d4da4606c93da@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4ed6852d4da4606c93da
Tested-by: syzbot+4ed6852d4da4606c93da@syzkaller.appspotmail.com
Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
---
 drivers/bluetooth/hci_bcsp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 664d82d1e613..591abe6d63dd 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -582,6 +582,9 @@ static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
 	struct bcsp_struct *bcsp = hu->priv;
 	const unsigned char *ptr;
 
+	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
+		return -EUNATCH;
+
 	BT_DBG("hu %p count %d rx_state %d rx_count %ld",
 	       hu, count, bcsp->rx_state, bcsp->rx_count);
 
-- 
2.48.1

