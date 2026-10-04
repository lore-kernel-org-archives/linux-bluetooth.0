Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70663A0EB8
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Oct 2026 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131100; cv=none; b=dITUT+Pl7vNjyz6L783WYM0WeQ4bR3JkpJEF1AuHkfMWWKXC4pvM+WpEswUAGSrcsIxnjxnKYz0yRzheF/oqkLIbkQxae41JFQhrR6zXAoETurAwpiYUjovJsvmR+RQZuzvxECgiKMOzeTISNkYWoOqxbfJOVfX+XGzgB0N+JDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131100; c=relaxed/simple;
	bh=aEgjYHXCubX1djFZnaJrqGx6S2rePES3zkm0ysI6loQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lyA9XUXmtVJq4B6l3aSxMtWSHl2hSfpEAwg+TMZCSobse/iQCf3fd7d5jW/8secRl0tpwqXxbSYdGM4YMM/cpypQBfWJyaUWPb9QaVeG4s12evR5zu3+u4VPkkOs5XGZB+vBEmGC85/gm6gNQ6VWsVlVcW1x+QcnjRne4UriZdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oRXmc7Ne; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRXmc7Ne"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-141a5d476abso64499c88.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 04 Oct 2026 09:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791131096; x=1791735896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y2eOg21KLKrIZ1ic9K99oaOBWngENzssVlnME5t6zBI=;
        b=oRXmc7NeW3Ja/e4SDQniTooWkt+XNEf3VVnAseXeikN41YfGa8pPdPIqye9xIhPTA9
         k+obLooAMMVar31+Kbcrc9YCEAympW63nHip7gUdy9rtkmJAYDt06ArsYlt82njv1k8W
         CAkU32sM/Z8b1aa0sZ0lEHFGbqsMcEvKOyGyHfBq8N9uFwwQxbcL+sgl7ZD1qRyUfuuc
         RyTMNs+J+gw5qLMfmYwZR4/zxPT7X3qwkQAF6SchBRipe6FUbuGWoC/Pha/EKONupv8C
         ZiTFLDGBCI0x+GAKPeAS8fP78io+xYjUGhlKxvKqgyHH2Bgy9hkTfeRnMMNLDIIC9LeQ
         cfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791131096; x=1791735896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y2eOg21KLKrIZ1ic9K99oaOBWngENzssVlnME5t6zBI=;
        b=lqUW7yhCiIb5B6VyeCWoQhHyi4edWAxBTPVRR0mWJq6SsyYetkFXY42f60mrXbS6D2
         VSGbyBMwgTYJvzZClN1qHd7n+2hRJmVTf/ydidgntuuW66MpnZY6D+3XUyq9vZ6I70rT
         bSK6uC3h1qQh3nLq0tAScYf4fn3mKAKCuEA03nxTEG4HNVcttMmcptPAYZtxd9NtWxkM
         6ZxNO9LYFeqg6+cAadMG+Bv0QPzQGoj5NyaJ+aVqoZBjyRLWfQp6bCiaAieK43bS4GJm
         NtVCgkB50/P/VKmgYQ9RSbYN7+tk8iVk5+S/1XrMLJ9HjpVCY7vQfOg0QoIz8H4Nttlj
         Ef7Q==
X-Gm-Message-State: AFuF++kXnqr0nlODHFBUfb2+TtkFUfWUF95ecCl9w77hJW8eb/jBzx3+
	7MSbZR6TJFOuJutlDwClPX8IpKW7Hf4c76Qz9lCghd3XegF/I6pLjQk8
X-Gm-Gg: AYBFou2Eri+Nq3FNWwsaw7uM8VdEbUmicKACH/SioK/o/5bQhWK5bW7Dv9gegA6b8+E
	YLJ6IXOeD0+US08mU6uLcHlQiU2PlomZ0DzS+KZK673Ugh+/RSBky/hDyusldCPdYuMZOVwGZTf
	ri/aCqNT82/o5FiSEqZVyBk4oX/aNgdvK16vczeTfEI2ZhX4m3WOd0LP4LfQr/TTakWZXF1Y4ma
	xYefzacBkOh5gh/YzprZqNh7xzC6A9MlbjjikW2y2s+uevXzXNOQ+ig8xgzsotcTjo5a95vqzeJ
	fctirePA59iv4Nrc9r9S2GNjnhJVtPhOYru5VRIRdwv35O0MUQq2YRuqsJf5I3uZUJxtkLnDLyU
	D0+bBaXGTPs3r2fBE81HPVOB8sZYAQgKJr+33cQVQ3mFgVH0w0Jp7t6/a7D7ZGrI25BEZQMmu7j
	Wn76SEGj+EccSNZzCobry/FF0p8JtNHymojeUd237dpquBW/IyMmzjULpHyMqVyFAJeCJV9SMYG
	v1SX4rla66qH6vcLkHPR7DbP1aWB6h4C6spTKSz3l326XuwC5RPz4YBKtZVyf0L6wGHjkyKxurq
	luKe
X-Received: by 2002:a05:7022:e1a:b0:149:c766:2965 with SMTP id a92af1059eb24-14f5af2713amr19799965c88.2.1791131095772;
        Sun, 04 Oct 2026 09:24:55 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fce90b1esm20522904c88.13.2026.10.04.09.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 09:24:55 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sock: Serialize dead-device detachment
Date: Mon,  5 Oct 2026 00:24:42 +0800
Message-ID: <20261004162442.3968446-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rebinding an HCI socket after its controller is unregistered can race
monitor control replay and crash the kernel. hci_sock_bind() clears
hci_pi(sk)->hdev and drops the device reference under only the socket
lock, whereas send_monitor_control_replay() holds hci_sk_list.lock for
reading.

Replay can observe a non-NULL hdev, then bind can clear it and drop the
last reference before create_monitor_ctrl_open() reads hdev->id. This
can cause a NULL pointer dereference if the pointer is reloaded, or a
use-after-free if the old pointer is retained.

The kernel reported:

  KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
  RIP: 0010:create_monitor_ctrl_open+0x579/0x800
  Call Trace:
   hci_sock_bind+0xd96/0x1190
   __sys_bind+0x166/0x200
   __x64_sys_bind+0x6d/0xb0
   do_syscall_64+0xdd/0x4a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

The same missing serialization lets hci_send_to_sock() select a socket
for the old device and queue its frame after bind has detached the socket
or installed a new binding.

Take hci_sk_list.lock for writing when clearing the device pointer and
resetting the socket state. This waits for existing replay and delivery
readers to finish before detachment and prevents later readers from
using the old binding. Keep hci_dev_put() outside the critical section
because the final device release can sleep.

Fixes: e04480920d1e ("Bluetooth: defer cleanup of resources in hci_unregister_dev()")
Cc: stable@vger.kernel.org
Assisted-by: GPT-6 Astra
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/bluetooth/hci_sock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 6d56c77741e1..81068b585764 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1223,8 +1223,10 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr_unsized *addr,
 	 */
 	hdev = hci_pi(sk)->hdev;
 	if (hdev && hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
+		write_lock(&hci_sk_list.lock);
 		hci_pi(sk)->hdev = NULL;
 		sk->sk_state = BT_OPEN;
+		write_unlock(&hci_sk_list.lock);
 		hci_dev_put(hdev);
 	}
 	hdev = NULL;
-- 
2.43.0

