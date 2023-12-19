Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5F112B61
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Dec 2023 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Yqij/BmA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702973427;
	bh=fgJ2KFju3g/wz08sEC/4y3Mb+3SSlVMS8pryKc5cH6A=;
	h=From:To:Subject:Date:From;
	b=Yqij/BmAgdInIMZwgnneUDTg+mE9e5hbnfXyahMF91XGwLucTh/qEFYhmAP0Fwm+3
	 AM/7sP1SIUGC3vmzrqlF4d2NbuDTp6sKEMKlY2BC/912wPnsPbRKqPW7+pF18EAErq
	 NZKlXyEDAryRty01qFlfMTfcfZtNufgNN/hNVURBv+xrUFdBHe9vlTbtbawak9KfmJ
	 KaYO00TJXV55igrguU7nsEe6CBCMKTcnWjUUI58dplkumD7fB2ynOSgwPf2FtWKZvI
	 FawJ7DX+Hivs6w848MHk6NqM4Yd6zoJuC3BibIcmhSYcd0EfCmMQLRJCds+rMCqJXh
	 b28JGwSXs9Z+w==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4C704378140A
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Dec 2023 08:10:27 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Fix possible multiple reject send
Date: Tue, 19 Dec 2023 09:10:22 +0100
Message-Id: <20231219081022.41395-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

In case of an incomplete command or a command with a null identifier 2
reject packets will be sent, one with the identifier and one with 0.
Consuming the data of the command will prevent it.
This allows to send a reject packet for each corrupted command in a
multi-command packet.

Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
---
 net/bluetooth/l2cap_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index baeebee41cd9..60298975d5c4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6526,7 +6526,8 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 		if (len > skb->len || !cmd->ident) {
 			BT_DBG("corrupted command");
 			l2cap_sig_send_rej(conn, cmd->ident);
-			break;
+			skb_pull(skb, len > skb->len ? skb->len : len);
+			continue;
 		}
 
 		err = l2cap_bredr_sig_cmd(conn, cmd, len, skb->data);
-- 
2.34.1

