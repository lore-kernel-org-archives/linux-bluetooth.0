Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACCB26ACB;
	Thu,  6 Nov 2025 02:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762396939; cv=none; b=E1t7LlZ5+6a4PcFN1agkkMFIIK4GKnKCGoxNod5SVw4my7CAWI0oVOLclf0r7nIjQ9o1fUkjOrwVnuNVhimAivEK+Yl5XxanDjgV9Chz2tvsBjjZFto3bCJK8YLRk9u97WOhDhuZxVqTE0FykdLG5bFTvuLw8b9igli4q85XJu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762396939; c=relaxed/simple;
	bh=YzY6f7OeDFp+f3iGLJIacXM5jr/u55zCRfzhsK47A6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EVVTJkRQgTbibVqD6Wd8RdGdSROM3B7W/KqzIRjnro4i+UEOHXFTstP2fd8UwvBAWNNZG2X8FY6eim1xtlS3amXpQG3HJ3DPXWafVV016Gb0BA+1ZStnEOTBxr8rcVvfyyaR+7kaugCDqVZsPavLowEbS0w4wnyM8itLNpL6K6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ens7Uj+a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ens7Uj+a"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AF5FC4CEF5;
	Thu,  6 Nov 2025 02:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762396939;
	bh=YzY6f7OeDFp+f3iGLJIacXM5jr/u55zCRfzhsK47A6o=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Ens7Uj+aH2N4i/I7uDstOrT7dgFYGpzpMo7xCE6Uo14PfAXLaZgf5B5NU2u7a1L4j
	 qXjzA0gcGrWVZUIlDE0MsWbNsHlDnDBv0rPmRtpBXwSXSEeh+9qZ4bCx5Oc62sRepx
	 XY6+tu1sSEafkVe4SV0j4uATtYEZg7+9dw9CfTj8dDOkSJH8+d7Rskp4o1w/bJ9B85
	 haNv8aQnmYhXNQ6ZbwbBnhl2922qyRHZhj+LV66kiwaEb7qUtu3MajCTJz2SkF8Jmq
	 v24/kgNWf3UHeM5Xvmis9Sasp+/OHwIPpsVBKg5GnnTdlNLBUxKjMRRGVdpa1ZCt3M
	 bnudRbGnOAEoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF1FCCFA05;
	Thu,  6 Nov 2025 02:42:19 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Thu, 06 Nov 2025 10:40:05 +0800
Subject: [PATCH v2] Bluetooth: iso: Fix UAF on iso_sock_disconn
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-kernel_panic-v2-1-f4ee57845eec@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAIQKDGkC/3XMQQ7CIBCF4as0sxYDtBR05T1MY5CO7cQWGjCNp
 uHuYvcu/5e8b4OEkTDBudog4kqJgi8hDxW40foBGfWlQXKphOCKPTF6nG6L9eSYrm3vNK8bw3s
 olyXig947d+1Kj5ReIX52fRW/9Q+0CiaYMW2tuWpcez9d7DyFgdzRhRm6nPMXN0YtDaoAAAA=
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762396806; l=2015;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=7EXgQeZLqPxP3enyA/KuSjgYFvs5GDmmUNKpgZng/8s=;
 b=/FMxzoJ251QLD+7MXQkS582L8goZyiNwn6WleRjURzJGu8HDwUk35mJvLvnhYAJmzWDxa4cwm
 WQ3tONDM5PcCP0a4piOMdGSkh32bnsM2QrMip7xBdFQL4iYst7jVASj
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

When the phone stops audio sharing, it terminates the BIG first
and then sends BASS modify and remove operation codes to clear
the shared BIG. If a BIG sync lost event occurs at the same time,
the BIG connection may already be deleted. Releasing the socket
in this case can lead to a NULL connection pointer.

kernel panic: Unable to handle kernel read from unreadable
memory at virtual address 00000000000003d8
Call trace:
 iso_sock_disconn+0x110/0x1c8
 __iso_sock_close+0x50/0x164
 iso_sock_release+0x48/0xf0
 __sock_release+0x40/0xb4
 sock_close+0x18/0x28
 __fput+0xd8/0x28c
 __fput_sync+0x50/0x5c
 __arm64_sys_close+0x38/0x7c
 invoke_syscall+0x48/0x118
 el0_svc_common.constprop.0+0x40/0xe0
 do_el0_svc_compat+0x1c/0x34
 el0_svc_compat+0x30/0x88
 el0t_32_sync_handler+0x90/0x140
 el0t_32_sync+0x198/0x19c

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
Changes in v2:
- Add description about this problem
- Link to v1: https://lore.kernel.org/r/20251105-kernel_panic-v1-1-88637054c6b9@amlogic.com
---
 net/bluetooth/iso.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 74ec7d125c88..89c7700ceb81 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -838,14 +838,14 @@ static void __iso_sock_close(struct sock *sk)
 	case BT_CONNECT:
 	case BT_CONNECTED:
 	case BT_CONFIG:
-		if (iso_pi(sk)->conn->hcon)
+		if (iso_pi(sk)->conn && iso_pi(sk)->conn->hcon)
 			iso_sock_disconn(sk);
 		else
 			iso_chan_del(sk, ECONNRESET);
 		break;
 
 	case BT_CONNECT2:
-		if (iso_pi(sk)->conn->hcon &&
+		if (iso_pi(sk)->conn && iso_pi(sk)->conn->hcon &&
 		    (test_bit(HCI_CONN_PA_SYNC, &iso_pi(sk)->conn->hcon->flags) ||
 		    test_bit(HCI_CONN_PA_SYNC_FAILED, &iso_pi(sk)->conn->hcon->flags)))
 			iso_sock_disconn(sk);

---
base-commit: 2747d929617743ecba08eeeb310283b4be681383
change-id: 20251105-kernel_panic-73adc703480d

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


