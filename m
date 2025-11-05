Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555372F12DF;
	Wed,  5 Nov 2025 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333333; cv=none; b=K4iMziAtQuvVqKy801gwrR7ATi1JvbfhJz7eyiu/hGQYKIgwwArROwxfBtBeOBSw8lc9x0ymkMDf4r8WMBThcpnJ9ABDclMLbHnFNOmAUKuQfHwg5QkMkPGE8qO0xbZq3muYOBOABoxvfIQEYomBPUuJVHtWOfNsoMFagIbRNHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333333; c=relaxed/simple;
	bh=69P8E0lzJ/6R8ErkBsHZbv0lFG3IxBCu8QrGpXLxM1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OBDdcvdTcf0O48pxErpQfY6akl3DExKU9XH8RxIhIHhBNsrojQbLHijdVcORVB4fETFEJjqoypZ5W9lNLEHGAz0KMdfL7XylwFdJrUCX65eV9g6FiruSqT8tpI5zXap2eRyxB54Pif/gS2DjLI4T25owrU0qjqs4+EXCLJdKc5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWgBAFoJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWgBAFoJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0FCAC4CEF8;
	Wed,  5 Nov 2025 09:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762333332;
	bh=69P8E0lzJ/6R8ErkBsHZbv0lFG3IxBCu8QrGpXLxM1I=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=LWgBAFoJ+EQPWyyG1QATcvY+YKPg6OpdDwXrt6boMeQQlBqKkJdQuw7tuZ8Bj1mzs
	 3OkQ2WJLbXNj9EOy1FnZRedmPQbFoTR9I55q2agm/G+IBU2AhtKIgKaXjRCAW1Hpiq
	 wTSkJMkE/YSzFQ+bG90cg94JSCowwUgeGTS36SVoXv+x4QYUb6xCGCvY5GTfjO0tXy
	 Y+fgNzfx7+D+Ss9oONsjdS0MUCFv/COqnVhj+JI3Yf5cxIJMAi1/CB253dPcMnc/6V
	 tK4tt5gHU7Abp12dVrGJZGLZO9O/E660Fj+RABBZ9R777O3t+Y2/2Dl9VtnpcJffhT
	 1V3SEEgCtowjw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C469FCCFA07;
	Wed,  5 Nov 2025 09:02:12 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Wed, 05 Nov 2025 17:02:06 +0800
Subject: [PATCH] Bluetooth: iso: Fix UAF on iso_sock_disconn
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-kernel_panic-v1-1-88637054c6b9@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAI0SC2kC/x3MQQqAIBBA0avIrBM0E6OrRIToVENhohCBePek5
 Vv8XyBjIswwsQIJH8p0hwbZMXCHDTty8s3Qi15LKTQ/MQW81mgDOW6U9c4INYzCQ0tiwo3efzc
 vtX43iwIZXgAAAA==
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762333331; l=1549;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=S5BJh2ba2g9xJCkHYB8Rff1jMpJFLarygQDk7qfhCww=;
 b=0Es3hP455AD3QZnhIIAzJALsD1uJ+obbNHtlx9EHEvCMso1TC5723gpPHqHVWkrPn+X5+uRtK
 4cb2LTUXq+wBZHpUwMkaPne7ZL6T6dmNLUZnP66TvfICrPwaP8/jMfA
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

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


