Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378441;
	b=e9Ly+H3dleWOTpi+SScDgzkbKAj0Yh0Alp1OTwHQLdMblZc709l1AbvQ7gK8iFGprmMl
	 imYFIDNKnXZslBic2SjCVg5YoJbn8elv4zbu9rwtgX60VO2zaeG4bT/+ELrD5BNHl2noP
	 gf5UcHlvgBa9fWQ42xAFDkU2NBGqp8BjSh8kRofMN+TaukeRjDNMwP+e4ISHIhyiN2pwx
	 2ImdArS3tVvZ0WcRSCLkXcHOUWORCzYjF1PJoncPRusg/VeJ3Dk3AAytnQ/MAyUzJcYlr
	 yDwSnn0pxW2rgXEDe24g1L+SvL0Y1cS13kTu+iPZ4l2oxEvVSfsNsgj7JVN6pYKn4NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=CPKjjumpWwCCmfBFsSYSfMecOLmFzM5vA0ha+XXQ0iY=;
	b=zCb5xwDKMNMgZuc+tNlz9DXz1fHCAOHFkCDHlNWrX6k+/tIsEcC2ovnbu96vkVGOBagW
	 oO549Et5jGaWMRlRqLwfQ2nLJLzRNSXzOPWO3Q1kk/sJYPz18c/+Yri47asNHo2fkL5Sj
	 HB/3LVYteLdQqRbYLX/EMxNMS7e5o9AMhmpye+0RE3nmGx4J6RGdBTxmpcvUdUWJsmR4+
	 gTs5vvc+4ga/sbbHCpBhjoNTyq+FHNuYHqhS4gR8rPZrVOKh3sY/Y77u0GeJY1zlwjt3r
	 YvLyp6x0WFLGA1mfspQKBvUUzvxF+WfIIY8a9dNElluX1ViXyHd3yFrvhwD+1vcYcvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=VMUunERQ;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34402606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 20:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34402606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=VMUunERQ
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so19736725e9.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 12:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795378439; x=1795983239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CPKjjumpWwCCmfBFsSYSfMecOLmFzM5vA0ha+XXQ0iY=;
        b=VMUunERQBPSPW+Ufs/ShyMSTehR2OXeuJm6aBmM3noWD63SP5B3Eufmy2ZpoINboGU
         m6eDJSgI3l/Wp6cwE5vVm9ZMlp7oFYaOdZM60jDQClPNzilHHuwKa2ktb/iAWsIzDrQj
         KyI2LR7Zi1mKWyfaUhKOhemyADlvuozvdby50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795378439; x=1795983239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CPKjjumpWwCCmfBFsSYSfMecOLmFzM5vA0ha+XXQ0iY=;
        b=nVd+nD+YuiSbTHWzhYH8v9KuJn8SxIN7GqIMXAtSq/Y0TE1UU5oUUxWqNCnkMGaeMq
         ovSRL+G5jjd65rOSCbi4x/Y3Qhhfr/Jnm7PpBCJ+wlTgTI3w15xHGhRFKDAexNjWTmS9
         W7E5VV50q+1PWV2cUD9eJF5YtwGY6BkOJKTCpVu7ujfD+N2Ij/Axz1ZygjbedPSU59qI
         h4NZ0DmkzLhHX5wIZkzK7gVOTWmplAPD5hEO3LAZ/cOkC0kfUyNnzNAk1sEhWZV+PszY
         KLseDSFjf94N4z1WJ74/+Zog8oBH/MW+feZ3YOrNJgPLbItoyWF4agODG1K+aoY7Ajmg
         hoeg==
X-Gm-Message-State: APuU4Z+kp8TgyIOgtnDKFFM4LeBGn21RzM+zwAIXC5QADw51S2pSD6us
	jFyumsJfvX3E5X/mB+zN1/Fq3UYqDP1Yih9o0bKGJzmIWQaiCJda0a+TTn8IOMTltyrFkHNuau/
	gIMf8
X-Gm-Gg: AZFdTZdKyYdZhxHPgK/OnMFtiwhmsa5QOZreHuPlyr13hCo7ILwdRR9548ey4Zy0cN2
	RMb9/qlmCrjPH9ZdtuB4utuZbRnzIDQi2d6yJ2mpwBaekY/GYr2lsQUSDPsf8JZsGsqaXqF5cod
	EInOqkZ8Lnw0YCfPUX/aNDLh8FtvT0FUnz1mP/z1jVCYU+yDzhaXiqXSNRqt7XkZTP0QDkDmZjL
	FBXEeNdEhO6sG+DHFUe8Lph58K04km9HJRdQNOfyQ2oBOHJfYrTBVkbhzhfXTo/C4HyxLs+6MG7
	2MRj2htzppwFCySO1I7iu7RSLmJaVLaBTYF52PrUOY/uGDhM/avihPSJ2YeUjYLMYB0McGzBt6u
	AV7whta+lo3oIuToqRxGMOrpR+KSdiubA5LhiDZfT9dCGmzR3urK3lUrYOfvMt8WToG4cLBCt6C
	WmwhwQLziQiaJV1VWLY9VsYJU3aicOy3k3un2fnRCUssz/KvrT1cbgD6x7znP6NwdOU3OvvZBDl
	eXN28/ovgfYgeTr4Mo59gqnCx0OZKVxOo9fMwcNDjlHUZ9O8o627zfZ+an7QkOfXiNSOqgvG5Vq
	qrmn5h2dxliWApB3oMGP1t9TF+up68xnCh9/cGWKR0vTwTC97A==
X-Received: by 2002:a05:600c:64c8:b0:4a0:1c0e:b057 with SMTP id 5b1f17b1804b1-4bb887e2380mr183407565e9.4.1795378439579;
        Sun, 22 Nov 2026 12:13:59 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884c3063sm293963685e9.15.2026.11.22.12.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:13:59 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: ISO: Release BISes left open for rebinding
Date: Sun, 22 Nov 2026 21:13:56 +0100
Message-ID: <20261122201356.2854729-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A BIS socket closed while another socket of the BIG is connected leaves its
connection in BT_OPEN for a rebind, with the hold of the socket. Only an
unbalanced parent drop used to release that hold. Now the first BIS is
never deleted, the BIG isn't terminated and removing the advertising set
fails:

    Bluetooth: hci0: Opcode 0x203c failed: -16

The next broadcast rebinds to the stale BIS and LE Create BIG fails.

Drop the holds of BISes left open when the last socket of the BIG closes.

Fixes: 4c94557dd025 ("Bluetooth: ISO: balance the parent hold in hci_bind_bis()")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 net/bluetooth/iso.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 06f1e7ba2cb1..e6f0bec7b353 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -907,6 +907,15 @@ static void iso_sock_kill(struct sock *sk)
 	sock_put(sk);
 }
 
+static void iso_drop_open_bis(struct hci_conn *conn, void *data)
+{
+	struct hci_conn *hcon = data;
+
+	if (conn->role == HCI_ROLE_MASTER &&
+	    conn->iso_qos.bcast.big == hcon->iso_qos.bcast.big)
+		hci_conn_drop(conn);
+}
+
 static void iso_sock_disconn(struct sock *sk)
 {
 	struct sock *bis_sk;
@@ -930,6 +939,10 @@ static void iso_sock_disconn(struct sock *sk)
 			sock_put(bis_sk);
 			return;
 		}
+
+		/* Last socket of the BIG, drop the BISes left for rebinding */
+		hci_conn_hash_list_state(hcon->hdev, iso_drop_open_bis,
+					 BIS_LINK, BT_OPEN, hcon);
 	}
 
 	sk->sk_state = BT_DISCONN;

base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
-- 
2.43.0

