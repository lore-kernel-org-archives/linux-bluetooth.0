Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226F3A932;
	Wed, 11 Feb 2026 18:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770833040; cv=none; b=IIotlyNsEO6o8CKnLJow7iOCrA+2hKaEUhJTlP2v6qFEYuNQNAO2cYnPGQ0fXdcdXdPsHHQ6b2eCfspMlPH6p8jlg15GeZY0+ydoBe0Q9RoWvsQ95oFe99vyGVAb3OOCQ2t7kOoBvwhxHUQOhB6yglPxI+yDVS8a3YUODWLVy9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770833040; c=relaxed/simple;
	bh=vyKSFORLM2cN1270f6DjK7rKY1NTQHEVODNcrs5OddY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a4edK5ihYYT5TF4Q05+3NaqfznHpNyHdGcgRkOTRfBJl5pIzJRUX0yN2baZGWx4UijIhpjAjBrE8cwDku7+CGTtGgUBcTB+rB1SjUrjyHPO46Mcx7jXPFV/8DdciLx3q5ns0tFkMYQwG95ei+53IbQu8L15AWCHycbUGb33PPto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CyUAQ7rK; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CyUAQ7rK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jUc5l0y+9dYqlYy2SlJ8i7i8aKeN/PPhrArIcu7flas=; b=CyUAQ7rKYJz5b8D47jzX5MlyvT
	92UfW+BpdD424pHoVJRsVWp9j0/YyQkuQetuIfDb+dQEJq2mEPoTh6ONJbW6oFKipY3iPV4MQavMF
	PeEU1s6a7MqIhvCnbWNZ8oPO1UbluPYQQN6hIbjMZ9re9S8qICORkzSjM/DUwX1V+RjAze2+qV8Sw
	2SX66ReUl57kV4OM5VAQpELdfDh7U2yTEf2a50tp7+u58j2tTjK2LadSDG3KEdsmbqJOlhkILBr/y
	YJ+6AvbPb+o2P1F71iRYt9sVrAlOHI734YYkWNeD8xLdaZOPRIpLNrFVWmyNctS3YsQitvlmPGmS9
	RWW54LZA==;
Received: from 189-14-87-116.vmaxnet.com.br ([189.14.87.116] helo=[127.0.1.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vqEZ8-00HClS-3t; Wed, 11 Feb 2026 19:03:54 +0100
From: Heitor Alves de Siqueira <halves@igalia.com>
Date: Wed, 11 Feb 2026 15:03:35 -0300
Subject: [PATCH] Bluetooth: purge error queues in socket destructors
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-bt-purge-error-queue-v1-1-42159dd7bb28@igalia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MOwqAMBAFryJbu2ACWngVsTDrU7fxszEiiHc3W
 M7AzEMRpojUFg8ZLo26rRlcWZAswzqDdcxMvvJN5Z3jcPKeLHuYbcZHQgIHEUFALeJryulumPT
 +t13/vh8mdktuZgAAAA==
X-Change-ID: 20260211-bt-purge-error-queue-bcccebe5cc25
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, Pauli Virtanen <pav@iki.fi>, 
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, 
 syzbot+7ff4013eabad1407b70a@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Heitor Alves de Siqueira <halves@igalia.com>
X-Mailer: b4 0.14.3

When TX timestamping is enabled via SO_TIMESTAMPING, SKBs may be queued
into sk_error_queue and will stay there until consumed. If userspace never
gets to read the timestamps, or if the controller is removed unexpectedly,
these SKBs will leak.

Fix by adding skb_queue_purge() calls for sk_error_queue in affected
bluetooth destructors. RFCOMM does not currently use sk_error_queue.

Fixes: 134f4b39df7b ("Bluetooth: add support for skb TX SND/COMPLETION timestamping")
Reported-by: syzbot+7ff4013eabad1407b70a@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=7ff4013eabad1407b70a
Cc: stable@vger.kernel.org
Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
---
 net/bluetooth/hci_sock.c   | 1 +
 net/bluetooth/iso.c        | 1 +
 net/bluetooth/l2cap_sock.c | 1 +
 net/bluetooth/sco.c        | 1 +
 4 files changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 4e7bf63af9c5..0290dea081f6 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -2166,6 +2166,7 @@ static void hci_sock_destruct(struct sock *sk)
 	mgmt_cleanup(sk);
 	skb_queue_purge(&sk->sk_receive_queue);
 	skb_queue_purge(&sk->sk_write_queue);
+	skb_queue_purge(&sk->sk_error_queue);
 }
 
 static const struct proto_ops hci_sock_ops = {
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index e36d24a9098b..0f07f05c1557 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -746,6 +746,7 @@ static void iso_sock_destruct(struct sock *sk)
 
 	skb_queue_purge(&sk->sk_receive_queue);
 	skb_queue_purge(&sk->sk_write_queue);
+	skb_queue_purge(&sk->sk_error_queue);
 }
 
 static void iso_sock_cleanup_listen(struct sock *parent)
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 9ee189c815d4..39d12482fa0b 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1799,6 +1799,7 @@ static void l2cap_sock_destruct(struct sock *sk)
 
 	skb_queue_purge(&sk->sk_receive_queue);
 	skb_queue_purge(&sk->sk_write_queue);
+	skb_queue_purge(&sk->sk_error_queue);
 }
 
 static void l2cap_skb_msg_name(struct sk_buff *skb, void *msg_name,
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 87ba90336e80..cccfaf560317 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -470,6 +470,7 @@ static void sco_sock_destruct(struct sock *sk)
 
 	skb_queue_purge(&sk->sk_receive_queue);
 	skb_queue_purge(&sk->sk_write_queue);
+	skb_queue_purge(&sk->sk_error_queue);
 }
 
 static void sco_sock_cleanup_listen(struct sock *parent)

---
base-commit: 192c0159402e6bfbe13de6f8379546943297783d
change-id: 20260211-bt-purge-error-queue-bcccebe5cc25

Best regards,
-- 
Heitor Alves de Siqueira <halves@igalia.com>

