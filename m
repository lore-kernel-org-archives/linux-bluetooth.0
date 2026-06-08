Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2263115B8
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 23:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780963173; cv=none; b=qAOinxM+Z4k2xI13Xed7okp4icGjRw34BcNIvC1dDaiX06+/oSuHIf4rRvdGNswNfXXChUyoxRCaWjT8ufVQapOieY8UCJcj2KK9fPXIg/T3l/TEAA29k8IPZyAHY4+Hfl7H1WYqq25tpOLY8cD1GA+TenSoihzyHnvyBbVH0jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780963173; c=relaxed/simple;
	bh=/Sun8guA0veFlnIlW9fOhuytGXSUGg+FORIO97A1fwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MhYGHyt21h+1w6CUb+FdUJjpVH7r5uRvgJs+YZ6nmxqyhYAKBfMvx79HPUnrinl03sJxsUdxXjBJ8PZQrF0RJOoUKkGvYJUhg6BH32fRwgWJwj3eBxmX2RulHlG5YGL1Q4KYcqkutjfZQ8aC4I6zFr4//fFqtogV1svKh6gea6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=QuyT9GKa; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="QuyT9GKa"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-915aa0a9293so419325585a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 16:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780963170; x=1781567970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CxtH5OP25BmXCPFlxsKv6q8JiLqDz6vO0+nFMi7CDdQ=;
        b=QuyT9GKa1jas6roaGGXQMALRvsegAE+ywV5Lz46LCU+rkzC6hcm6+UUFpv7g7Mq2eJ
         aJeQQaBkb++0XuYZ+TWP/LjBDlEyv51wSYcUFqCwEl288QoATUIKhjSBnPgxxeeIBPUi
         bd6ZLqtv8T8D9iDg/bE783wbwnMdBQi/TmYxjPWpFnSK6n4TSZEuTslCFk7DUCuThdSJ
         ouUJrd9qrxDRW1JWh95lxUkL0yg6ndnM2kBjhJp0ceug/CDcyWs7cnBSR/Fd/Ps08IQ3
         GTuBIjgbNetls1GN5QjC8At7mgnbG7BtttoTiRT8zX239V1+tzvAMTtP+Z/IsIAGQCbL
         HDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780963170; x=1781567970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxtH5OP25BmXCPFlxsKv6q8JiLqDz6vO0+nFMi7CDdQ=;
        b=L76CI8LuffQ7rwZEML8JrAKYiIQursW8GhuXRELOPZNP72KbJU+RNFwlJxNGGUJ/UH
         juRyo4OduHqZWc70lFxFozfTDg+qXZtxhupDRyQ05JIBUBvaVngDEE0IaQEPp4ck+Lfu
         Pz6908zhmUEv97eThap35WBvNP0HoKLjueEGzxUX2M3d/epj41h+9PGvcMX66aGR+YUX
         YXS6IUGNemtlmi9pS5r0kxynZYzYK8EahKaCUHnISjGBqt/GqPA9nkg4451G6jSZc2SG
         hq/KE6VgSmxOXpk5xmjy/uKxWEd5BB7CLqkZwGNa3ixHHJDu8Fw5ItKttAdMYEae1YO6
         KCxw==
X-Forwarded-Encrypted: i=1; AFNElJ9Mt6u5NXs4BrP6V77HMOy92aqMDWpA57u5HNYqzR1ddJxzzqtMGAJpH5dYGsuJo4tRBhSRM+bXjfw9t1+vmxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0wZyBZAFd8YKMQ4q2jCmT8M64bw6CLn3INEyv50eo3xnnw/lP
	MYIvPnbvKq4ki6zSpwfoKE0XNOr8ngl8aJIW+BFOItwjtwJ0Gru+5U0uLRmqK7bRy8M=
X-Gm-Gg: Acq92OH96GeffU0A87arhsko73/MLO0S2pHs0dSIgyQzAQCrTg6VkCijCOPqhyeSmjB
	YgNNP8TR/bcX4v7Gj1DfMb4gj/EcOOot6Z+whFBf+ln7iCVBfPZJrJy5VvcZ5GMNm5nE67xRDd+
	rrIxnMQeZuVrkseW89I9RUE26fGG1Ty4fZ2QkMh2wUILt8CDKTJOm44xnyQL2EXUufd6VnowjE4
	gIDvaZxZbjMdhMkQ9lbMFOyHBhKheER4NwjywQ+LWBQpqsBvsy0+eU42gTbmVW/AOr1YPY611Yq
	Vb38zmqupkig8s6RleOJTQ5tGNRknUcQJn8FqOcuCL8LVh8CEMV03V5ixZY1q1O9SZvoyBv/y4i
	mcJoFJKhVlBODL7YH3OEsB6o0+j2BW2WR/PeSM1JubHKeDKZ65DX980TS/RC5aGS98uy831sETJ
	mebPONddL22IZQpO9qxC9eGYAFGrzrSlFl741axg==
X-Received: by 2002:a05:620a:4407:b0:915:4217:bf0b with SMTP id af79cd13be357-915ad11ecdcmr2005770785a.19.1780963169866;
        Mon, 08 Jun 2026 16:59:29 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9158a40d566sm1883209485a.47.2026.06.08.16.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 16:59:28 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org (open list:BLUETOOTH DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Bluetooth: vhci: validate devcoredump state before side effects
Date: Mon,  8 Jun 2026 23:58:23 +0000
Message-ID: <20260608235822.1233691.33d07ec605af.bluetooth-vhci-invalid-devcoredump-state@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VHCI force_devcoredump debugfs hook accepts a small test record from
userspace. It validates the requested terminal state only after
registering, initializing and appending a Bluetooth devcoredump.

As a result, an invalid state returns -EINVAL but still leaves queued
devcoredump work behind. With a non-zero timeout field, the rejected
write can still emit a devcoredump after the timeout expires.

Reject unsupported states before allocating the skb or changing the HCI
devcoredump state machine.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 drivers/bluetooth/hci_vhci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 2762eacf7f20..3401e3b22f04 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -338,6 +338,14 @@ static ssize_t force_devcd_write(struct file *file, const char __user *user_buf,
 		return -EFAULT;
 
 	data_size = count - offsetof(struct devcoredump_test_data, data);
+	switch (dump_data.state) {
+	case HCI_DEVCOREDUMP_DONE:
+	case HCI_DEVCOREDUMP_ABORT:
+	case HCI_DEVCOREDUMP_TIMEOUT:
+		break;
+	default:
+		return -EINVAL;
+	}
 	skb = alloc_skb(data_size, GFP_ATOMIC);
 	if (!skb)
 		return -ENOMEM;
-- 
2.43.0

