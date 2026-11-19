Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048433;
	b=elagDEfJuLmMquZoa1bj7bI0s45I1mVqcP8PElGwWuYaXkpZHRC1DbJxKNH5//YtTaH1
	 fAFNLjk7qczFVWB7odWIOKY3hEVlHddH8mLUragCKl8MoFHVUs4vgso+06zdoY4ItDBZv
	 yOpBsgUCtjgug5v9xy+nzCEavRRxN4DiP/C3j9hUjlhdJ9khlK1/LxolNdP04OktgFcNO
	 M8Ik9a7mUrR8dOwAXpFSUfvvo3lJQBVZIQ9hwYgrOv/npDvLPyPwED498mz+smya2kSXH
	 vxI0lIYGvJkdVJc0RztDPVkSRM/MI4aOy+FjW5zL7Mp+rWkJfxWX90fKrYcpSbwxgEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BECM4ZSDkmQgHHtP0Eh1WIBOZgIIAyKbWDWF+oD4oGE=;
	b=5FFrcfe/2WC6mI5ZE/bwIdxycNf0EghAWVyVTGpUuQdNnvAU5RCs74BVs2Y2RDoKs0O+
	 VKhFHrOlhriDJlHgpS1IrPGFU7tLu1aQ1aZFgkqhG6klao1++cwDmO9nKK6fpVRkoouG0
	 YPOnctq44bGo0qN3sHVllj+I8oOixwdvuzoiigqilkggoiuQgMI5pYePpuVAplLr2jyDA
	 nHrQaxh+7yR0NKmNRAC3oXEsYN0UsltqpxIe2D/Fi8kPyjbH4KxNzCAvwG+FgSxcWBqJV
	 BKq3IL5sPGotVAPjBa0JsuFpaz3BvyTPfPZgErwVBwugfwD2AtZbKaZQIvcguxINTcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nkdBvxGy;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAA660A2603
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 00:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AAA660A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nkdBvxGy
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-89d6bd67045so240338b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 16:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795048431; x=1795653231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BECM4ZSDkmQgHHtP0Eh1WIBOZgIIAyKbWDWF+oD4oGE=;
        b=nkdBvxGyfgNROXLkDL00B1ULI1aQ1ObsAr5tIDfgAWRq4VKxZLilqRaikiurg446Be
         Y7KGo37ifVfuOucM59a70bYthk7dEL3AJQKLmVc04GU7oltZfnZdQ4UVhUSG+NGZch+y
         fFzFtPmw5Tlwe398hYc3Ac2O2PX1fZ3qNEjrNP7+wW4kSU5kdb3810f5VpdVonJk9i/u
         wczSqN6Bnp8IClkewxFfkTboTx892Af8wR2xDGfwaOPDgluU4HjmKYC5g8rSLi6S2vNY
         VTqDYNNGzhRfFwsCF/PtbWSVSnognYq9Qz4c6voURzzyRno/om+EEg5/Cv9Jjj0vh1t0
         AMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795048431; x=1795653231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BECM4ZSDkmQgHHtP0Eh1WIBOZgIIAyKbWDWF+oD4oGE=;
        b=ecl6N28In/MTopR27dfc/XYcmcsRr0vA7sbH0Ot0TYxWIiA/dz5nIdH0fp1CUnniAz
         KwdjIVqRHr4wyQXF/AD3MOzqEdvMqtku+XMEaWTL1S9bbrOT5fN1x2NkkSqNIzt3FRT2
         gz1plgQicFDSjJnAaJdJImmvNDx2UQkIxfGLejXX8YVnRaTu1Y//hk8pAKdioMPbZ2jb
         ASxcIpoF0Mbd6qh98dZItzqB9MejdEijC5zmj77x+jBj2FhOD89dED6iNFbQhSe1dmZU
         1FdTMP8Vu5DY66sncVxffsZnC3r52B2vLb8gBJjtDcfKr7Aliy/Us+orFBqYpATL6tdh
         iK3g==
X-Gm-Message-State: APuU4Z/id9XoJ45npEsrEfWXNiaALbRPZpV1wmWUgxTSuGoPVT9SX8AB
	ROCWiav7TYtW9IocDl6T1lAS/LgQWjIJN/ElQiBFopjHSq94JgNSWeCD
X-Gm-Gg: AYBFou1jyEMEulv7/ylwt1jlu6vbS6qUoqEB3BMRBnd49QKkZt5JaBqnBX8eNiClOa+
	raQ79E6UfEurFQLGl2ywVM4UPU/xJ1L5+xfAwhm25kKo3FXI7xrt28/FIo4WTEQwTMYX9+1j719
	OMMjJzq4HDkOflQAhklchcRPAX3PCixy0zM9c0wUkfPK+2+UKRzxo08DztuE8f/x77aQHf10vu9
	3AXbUlPsluizEEDSoL2CIy9CfZieTpDcJ8fhpfMMwnNMTWIzYb1L2sPGp1UUvx/FprqT7Ud1IeU
	AeVc7FFTHAFnJKi1HN8m3JkSMktZ6djBzpL8jabkHQ1kxMqZPmY3QHVCheO74ohHLb0US/I5VV8
	Eqc15hxFYoCehQ4SneanI+gZugU+eES8Yw6HTN8hfqScIuxyQ35JxMwJKNpUuEXeiKryYdlAQVf
	hq62OO3RD6IlB5djA5sJ9WmM1dDc8jT+1hnrkGic3STNrjvLmcmrsmkbqMQwpzaB1B5x5BbkBXo
	UMUOtLRhuhYBXDXayFS4J4oeScAx4xEpdcY6EyNa4HQTybUZoBcuTsTuVghYOMPRuZxEHdG5UOf
	6jZg4hvnBs32iQt/5xTj60lo
X-Received: by 2002:a05:6a00:4611:b0:8b5:a10a:a3e8 with SMTP id d2e1a72fcca58-8c788973cf3mr102502b3a.44.1795048431538;
        Wed, 18 Nov 2026 16:33:51 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5c7f99f91sm1906491b3a.5.2026.11.18.16.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:33:51 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v5 1/4] Bluetooth: SMP: Publish root channels after initialization
Date: Thu, 19 Nov 2026 08:33:40 +0800
Message-Id: <pm-bluetooth-objects-candidate-0184-v12-e80229724d6ad14ca88c-1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0184-v12-e80229724d6ad14ca88c-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0184-v12-e80229724d6ad14ca88c-0@gmail.com>
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

smp_add_cid() marks a channel as fixed before setting its operations,
address and parent nesting level. Once it also sets BT_LISTEN, a global
fixed-channel lookup can select it before the remaining stores finish:

  Controller A                     Controller B with the same address
  smp_add_cid()
    l2cap_add_scid()
    chan->state = BT_LISTEN
                                   l2cap_global_fixed_chan()
                                     select A's root
                                   l2cap_new_connection()
                                     call chan->ops->new_connection
    chan->ops = &smp_root_chan_ops

A per-controller mutex cannot exclude the second controller. Finish
initializing the listener before setting BT_LISTEN, and serialize that
state change with global lookups through chan_list_lock. Keep the fixed
channel type assigned before publishing BT_LISTEN so connection-oriented
PSM lookups cannot select an untyped channel in between.

Fixes: 70db83c4bcdc ("Bluetooth: Add SMP L2CAP channel skeleton")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 include/net/bluetooth/l2cap.h | 1 +
 net/bluetooth/l2cap_core.c    | 8 ++++++++
 net/bluetooth/smp.c           | 3 ++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index cf5c2df68af8c..e3d826772db66 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -982,6 +982,7 @@ int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm);
 int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
 
 struct l2cap_chan *l2cap_chan_create(void);
+void l2cap_chan_listen(struct l2cap_chan *chan);
 void l2cap_chan_close_unlocked(struct l2cap_chan *chan, int reason)
 	__must_not_hold(&chan->lock);
 int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0d4f3341bd47f..319016eff9689 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -456,6 +456,14 @@ static void l2cap_chan_timeout(struct work_struct *work)
 	l2cap_chan_put(chan);
 }
 
+/* Publish a fully initialized listener to global channel lookups. */
+void l2cap_chan_listen(struct l2cap_chan *chan)
+{
+	write_lock(&chan_list_lock);
+	chan->state = BT_LISTEN;
+	write_unlock(&chan_list_lock);
+}
+
 struct l2cap_chan *l2cap_chan_create(void)
 {
 	struct l2cap_chan *chan;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index f8f86b8f73f05..948a847c0dc23 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3400,7 +3400,6 @@ static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
 		chan->src_type = BDADDR_BREDR;
 	}
 
-	chan->state = BT_LISTEN;
 	chan->mode = L2CAP_MODE_BASIC;
 	chan->imtu = L2CAP_DEFAULT_MTU;
 	chan->ops = &smp_root_chan_ops;
@@ -3408,6 +3407,8 @@ static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
 	/* Set correct nesting level for a parent/listening channel */
 	atomic_set(&chan->nesting, L2CAP_NESTING_PARENT);
 
+	l2cap_chan_listen(chan);
+
 	return chan;
 }
 
