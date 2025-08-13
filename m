Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65609188715
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 21:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755119726; cv=none; b=eQDoxtlG0A4MJmAKvkuBBYb+HKlMqyJUCClxgli6nWTBMwiC6Zt0eZo7+Ts74L1fbGa49R2ud13uYy9nmiFoBUYKPSXV/Y7JjszLUSzP1FZJ+wx6kvl8mrnxTHNoynpE3+G34Vp8p9YLI6VZQ7nH5TAIj+MRjuwXNwuIEuYs2ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755119726; c=relaxed/simple;
	bh=v0bOi9xX2qwRuV5ph8bQeR05YEI1n25fILqj5TVAUSY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tEUs3nFeFWOXVY5OZ6NtFMfFd5cvxn04CU2U5IQl2QKPjdHRPXLeXnvzk4HPAUgQNrVLwDfXy+308FAbGiTvfOR177CpjxkjrT4BEDQqfpvND/ff123Wsq5DmGX+NbG2rePWpX82JL/IDu77R7tewfPMiVkjNvYE+sMBNH5D1Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkxI2+jh; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkxI2+jh"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-50f88cd5ac7so260984137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 14:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755119723; x=1755724523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1FdSl0Ehd7Wqv/wH7ISLEtXFGnt5ZXFAuG1oTTTgxGM=;
        b=jkxI2+jhUA/w/JWavmmZizwDU7w0xJDusXF5SS7ETk5YerO+sMX1cHXmREKl7HJp33
         QUn+ITGQxW3tA2D0xsjWverIQtto0GlnYwR3kXKHIWAvhJiHGve2AYPEHBRpuSE3/JpP
         eIKP6bqT7Vc0GcV6nP3zh9j5xcyH6qQ0SbYvoC1IWVsjzDWPxyIZYDUpsGhKSijCQho4
         RMjc6vwHQjmsjYHRQaVWJ3Ga3vsOt+Oo0rKQsU7hr4ik0w5rZs7+7ShFGEB4xTSMbR7b
         2mUq1pJY+4RdHi0lwx4YJftXfXXcakJiTfxYmswQ4JepQ+3V4OhnqH8KKHtAE0DpDfft
         YDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755119723; x=1755724523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FdSl0Ehd7Wqv/wH7ISLEtXFGnt5ZXFAuG1oTTTgxGM=;
        b=jX2avykZmjvz6MIYZRsS5V2lCeFspCz94NW1y17sQrs/2YJjEtc9XflpdyI4zOjtLq
         ru5dYeeStmf3ef2RYvT83x/7BKqRhoHDeas0zZQZcNpax6bsHQXMoiVTZwBPPNM0X54N
         gEyFjaZJX1oJIiM9nXE6/rO3ft7w4poj2ewgDCuFIZahZl4hC2g7rpJzIhvTJEDh1BTL
         XndrWw+iDWY5wJqVtG1RvT3TKkaaVQiC8fEMqpriaXgV9aeb09Een1APZ31uio6RXqLA
         Pw46aqdWAIwimngGXzAgrvsM6qe2IBAXT3YSFgvGlQQrNOImSkLwpKlqX6Ht//c1UjBL
         awzQ==
X-Gm-Message-State: AOJu0Yxise3BdUjoll352a9LuCvKXs2cdHEPc4SZQDGYrYK7VCuInoNd
	nfXUZOnE6x/q7YCa0WgzP8zC5MbCl1H8GyqQLYcyK6zKnX0eIZjlQ8eNan8FjQ==
X-Gm-Gg: ASbGncvWTZyLBpOmyLKgoO4VlQTYU2Ce8juQgu3rLwjR5Mt/g4GCPvqxx+8s70ZDPcC
	RBz74FC+VM5GnfmN5yADrmnu35KWFKpWBfnbkRvthdD3ZtiuHosfk4BtlsF88j4lZ9H4PRC91Lp
	8lH9zmCzWIEufNcOP3ci1JuxMCKBR5Qkm8sPHEsZVaP04860Ctb05V289U8xfkw97jx3zNRyMl6
	6Wae4yTsIQwp5vSUswlEiUSJAnoJEdO4nMrl9kmphV+lypRp5X5R8O0BOM49S6JyUjEAQTo3397
	ItQVKtq6gOQRUjjJxED1yNmdICJfZuQREhtcHOziJFjBGuhL+1WQ7kGnQlLdjZpo7kB7li1dl2U
	GMOVaU88i9JYSzG3EcMk7uKf6niNeQ/VrusGm7XsZFbbXWuHERbeapJJoiHVLEOYFFhLsihMz6z
	k=
X-Google-Smtp-Source: AGHT+IGDlwSKa6t3iySic4yinzXwz3HvXrj+PHkeixRETsQiJVrUrTGrcpsioYSqFV40xWbOFZsRpA==
X-Received: by 2002:a05:6102:c8d:b0:4fb:dcde:3f9e with SMTP id ada2fe7eead31-50fdf6e5ae4mr278384137.4.1755119723563;
        Wed, 13 Aug 2025 14:15:23 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-507dcae5200sm2458422137.0.2025.08.13.14.15.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 14:15:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/5] Bluetooth: ISO: Don't initiate CIS connections if there are no buffers
Date: Wed, 13 Aug 2025 17:15:07 -0400
Message-ID: <20250813211511.90866-1-luiz.dentz@gmail.com>
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

