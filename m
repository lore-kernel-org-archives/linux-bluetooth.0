Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E0036998A
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Oct 2026 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131164; cv=none; b=f6XqFBNi+7CwlhdovOuVg3f7xHRNGAX3Zj4JkTkAn8UZHfUPiJqPs7kCT/+HPTL5TVLeoeKjEjoN4VA1JaPg2Fgi8tx/Mg9e/b4gQoQPLf6A5S3UEehDVtkyvsKuArdNMPXlv57iee/uTEbj1zUmzgCVEYuBSR+Jl6n8iWRnoO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131164; c=relaxed/simple;
	bh=amK8ElqSX7xxn1c3t7Pk4XyCHGO72+Mj5UglIjSJuJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i6aRzP/aRVDH4RTVGVQnmjNvnRm+mpvOZvjNl4wNptdHAKislXKdW+qjXSrll0GxGPn4nSL95L/6PurTx+n4N99tolZiJAwTUHjZwq6tURH5tTm7PhirvsRm39esR3wTTWrGSvoJZJsqw4l1TLHelxGfsRgXycZsCUXtf+gdIRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8FG3ZPe; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8FG3ZPe"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3511990f211so48711eec.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 04 Oct 2026 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791131163; x=1791735963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jZ1eJoTadH6bv11VGShYOIfVRmew2zzu4O74pMeyNJs=;
        b=O8FG3ZPef9jFyyxb6yzCGWm3oJKDaAmbrSZo7WpLSOz0hVZRI4JFAE/3AGzw9lzy3D
         bREy/c48I0iOEQAu+RUHKEvT0ibRBziQW822LI6R2rJ4/0Jx7ebPDO7VM7fwD8+KC57j
         p4x9V8zQN52SGuKyVGnBaaya9yKx2M8ib4c+8LFypciDRsJaf5UG5kva8+g3pkt3n8xO
         Iwa5KsjHcg6gk/iJZD0GC4qXF+nGB83i7Ye8qLOkJ3mbYDEnV2iSuZu2brfPYOS8YpwQ
         l+tGpBr2owT+mHWlhS6PssJVMk88YevVp+/JQYOjtRflGdqCcd9vOj7qn4UX4hY9qOqW
         +FJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791131163; x=1791735963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jZ1eJoTadH6bv11VGShYOIfVRmew2zzu4O74pMeyNJs=;
        b=wRU8zIVsNqDsCH8yfRu1WONt4iU51vD4AVSMvLulrSJkCxEUNEHD4VxN80fh/isPNb
         5MO6WtON+v+7R4d2K+ZxNHpg9cXqkI5YkzdT19JNs96U/V/F4FAPsk0wsP6N1+7rJcly
         o7v8ar86NQmUKc5HmuIcHsODPTI21Q9wSzioaH0TiUMx1ZdVygCwgdt966ahVUYhXyeG
         JhyerHrkqiFg7bfzSqra387pY5+fEGcewnG6j8cvfjYuRzWWC8bH+cFW38PGUeT8ZuBM
         zG+pVzTobfStYhD85a1RILJeYncG8HiGE8ZFMcNQlHujgbPnoB0vixGVYoFtdiuPPS5f
         rsvw==
X-Gm-Message-State: AFq9FYKrdomI//tlsDfg+KA31twdvUBinPZlf4LtkzBhgPnfPOdtnimN
	WiZzVQjfUYCy3NrIXPBjKdzOIKyyFDc+3XrGrOuVqVzywDZpCWWmKT754txWEQ==
X-Gm-Gg: AYBFou0J0D06Khi56vJ5atXrSigqnTPjzMpSZbAnVlyiQAS7YyKGMadUOvZbf7mYXu4
	O49vuIc9jaSB/Mtaa8fUhQ2VVYEtqh/wXDLG1epqHRkJhhDeFKatBaZsZpiFhGEhvgYC64U0i5f
	1OwwoHTjnYrlLpJjKcxGFVX1y++aaJS/tHLKNdgF4Id4ufJP4X17zFPozQvb0ay8p8VhutJLKoU
	1azg2sg/JFZzzxdAN4d1kN4VlcBTAA7z7KC8NJ2ql2uEKnQIfqUwfkz2QJ+dkoPDLRh9HStRd9G
	8qic3H5jKZtNxCqfxBjX5n+DA97UWtO5qesua14JVcvJ/AGqxtGrtrMfcQn5Et2lzd2Lhxkar9n
	orjby59KfroUMf6Pzo/nGgZPkieSvUB3GnQ3U8zuIyUkrwo5x1K3sYnM06qx5MLGLo/6pB6Epn3
	lVEDkDIi6+AuALAfP/oDZSpqFvXOmtTNb02fW3ZVqyDAwK2PUBCZOM9Ozv1ks8lJt3Pyh3WhG31
	cDel40rNcUCpmcR8sjS2AiCxaok/P1O+zMM+kWtGhB//eTVFa+VqvjeyEB0p0HeGNfzYg==
X-Received: by 2002:a05:7300:24c9:b0:343:fdea:9a0 with SMTP id 5a478bee46e88-34f15028c8fmr17583068eec.2.1791131162529;
        Sun, 04 Oct 2026 09:26:02 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351272ceb02sm11517960eec.25.2026.10.04.09.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 09:26:02 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: ISO: Reject concurrent BIS listener setup
Date: Mon,  5 Oct 2026 00:25:48 +0800
Message-ID: <20261004162548.3968712-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iso_sock_listen() drops the socket lock before calling iso_listen_bis()
to preserve the hdev->lock ordering. Two concurrent listen() calls on
the same broadcast socket can therefore both observe BT_BOUND. Caller
A can attach connA and release the locks, then caller B can acquire
them and attach connB before A publishes BT_LISTEN.

__iso_chan_add() checks whether connB already has a socket, but not
whether the socket already has a connection. The second attachment
overwrites iso_pi(sk)->conn, leaking the connA reference and leaving
connA->sk intact. Socket teardown follows connB, so later events on
connA can cause a stale socket access.

Recheck BT_BOUND and require iso_pi(sk)->conn to be NULL after taking
both the HCI device and socket locks in iso_listen_bis(). The connection
check also covers the interval between attachment and publication of
BT_LISTEN. Reject a competing setup with -EBADFD through the existing
unlock path before allocating another connection.

A recorded KASAN report from an instrumented kernel shows:

  BUG: KASAN: slab-use-after-free in iso_sock_hold+0x119/0x1f0
  Call Trace:
   iso_sock_hold+0x119/0x1f0
   iso_conn_del+0xe4/0x270
   hci_disconn_complete_evt+0x351/0x8c0
   hci_event_packet+0x71b/0xb20
   hci_rx_work+0x293/0x730

  Allocated by task 93:
   sk_prot_alloc+0x113/0x220
   sk_alloc+0x2b/0x6d0
   bt_sock_alloc+0x29/0x370
   iso_sock_alloc.constprop.0+0x19/0x300
   iso_sock_create+0x94/0x100

  Freed by task 93:
   kfree+0x121/0x3c0
   __sk_destruct+0x42b/0x540
   iso_sock_release+0x29d/0x340
   __sock_release+0xa1/0x260
   sock_close+0x10/0x20

Fixes: 168e28305b87 ("Bluetooth: iso: Fix circular lock in iso_listen_bis")
Cc: stable@vger.kernel.org
Assisted-by: GPT-6 Astra
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/bluetooth/iso.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 7657c2a0abbf..2e70c0df9ef3 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1340,6 +1340,11 @@ static int iso_listen_bis(struct sock *sk)
 	hci_dev_lock(hdev);
 	lock_sock(sk);
 
+	if (sk->sk_state != BT_BOUND || iso_pi(sk)->conn) {
+		err = -EBADFD;
+		goto unlock;
+	}
+
 	/* Fail if user set invalid QoS */
 	if (iso_pi(sk)->qos_user_set && !check_bcast_qos(&iso_pi(sk)->qos)) {
 		iso_pi(sk)->qos = default_qos;
-- 
2.43.0

