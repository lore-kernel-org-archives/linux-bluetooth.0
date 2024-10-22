Received: from forward203d.mail.yandex.net (forward203d.mail.yandex.net [178.154.239.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A169A199938
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598567; cv=none; b=p9UG+2YAJ524ZvB1GOpR65zHc+SF6EKNnMkzge2s5tDpqa+gmEW902r/jAV4R3pcJgZCmCTAY2OSZ2vhbYMe1fzFa/E/l9jJGYxubvtLJaM+OF7olB6oG9KK4eLHgOXnXoctMO16NwElv3pQ8rkBya5xku5RfLaXDXTZjiPCiUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598567; c=relaxed/simple;
	bh=0ABQQaIokHrzw+GWMCkVMwocgnAKqddBpsZiMYKnFvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d24eJhK/XYYkroj/q9QCqNXWP34HnGR23X5RY8hL7tPFpgrGrBk06jA7Xzy3WZAvpDzxqUw7Kv0W1Ph3PX3jHxJIGPZ5b2MW3E0SRP5fYSqNezQfB/pgIyBEto03H4MwC9y9beWwxA+x5aspyiXYgAF9EoZQRNrf6WbWEwC3j4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=HC6e1dGu; arc=none smtp.client-ip=178.154.239.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="HC6e1dGu"
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
	by forward203d.mail.yandex.net (Yandex) with ESMTPS id A8DA763C10
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 14:54:50 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-45.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:37a1:0:640:203:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 5F860608D9;
	Tue, 22 Oct 2024 14:54:43 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id dsQCj21bua60-069g8wdi;
	Tue, 22 Oct 2024 14:54:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1729598082; bh=5oP5CtucFgYv4yWifb7NXwsFN72lZwI0HP4iemvSSa4=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=HC6e1dGuYz0j7HPpj8nBlwdqD+vAqPE/KhaQAKCu7UKZb+HMKju/KVl7IBYW1O+/j
	 gLxjaeyGq0mu0WaoVUC47w4EtJ+qDBioV8vL9O9Cbz3Ilri0NRjzcSoYu5NdZLGNeV
	 Z35Fp8Xiti1oiWGXl41GHYo5zdsyvbQNjjRr0yfg=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Manish Mandlik <mmandlik@google.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] Bluetooth: fix error handling path in __add_adv_patterns_monitor()
Date: Tue, 22 Oct 2024 14:54:34 +0300
Message-ID: <20241022115434.1513930-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1

Add missing call to 'mgmt_pending_remove()' on 'hci_cmd_sync_queue()'
error handling path in '__add_adv_patterns_monitor()'. Compile tested
only.

Fixes: b747a83690c8 ("Bluetooth: hci_sync: Refactor add Adv Monitor")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/bluetooth/mgmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a429661b676a..92c9808e419b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5301,6 +5301,7 @@ static int __add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
 		else
 			status = MGMT_STATUS_FAILED;
 
+		mgmt_pending_remove(cmd);
 		goto unlock;
 	}
 
-- 
2.47.0

