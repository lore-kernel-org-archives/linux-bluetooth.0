Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795375668;
	b=oOMnctWtBiQgjcYMtWH4SJc/xhcQlXeDsB8k5yzVC7Lte6w/pFX/ymIjEGj8F/stD3jX
	 +5L7+gWTnBK2aw7O88Uq5t1nh7HKtuI2YQKprtUjwPsU99qMKbc5KbSw+dEV6CpATJjlA
	 whM6TuEHa2W7oODZg4aWkOEwOqEr6q69IXr8E3eKWsgJatZr9wuPOVoULC2rxKlgMPPjh
	 +4h5ZVPRW+eB1isUFsiAhc0HFyl4PgR4SX9l0/3k7Fc/6R4O6T3cFnmgwu6Mq6bjSCHpI
	 m7IOoKg6Mynjwg6pqcabC/3ekqdOLhZxbxeA2SYw/CN839SmsIcYrVmXiDjM/7UJQ2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795375668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=BBZvuayZdvCHczlz0b7O3tYTrVtKbbGXDSy1f+QGjMI=;
	b=iSKL7y9LaW4mHNb9x0W66K5rULicn86zfX2eL817A32pF8NuF0mf6fCEc54RPEkJklC+
	 aRs3zLAbOtOFk3Z09e60QZ00g+TmSGlQRYXi6rE2zrUgU3/ET5IAxQ6GovrDQTKfzzyvl
	 uRlGEbMPizIWsNkdAOm/g288raSTSNYmcQOeS0XAD5o2DaNYuXRqGuTjf2xzET4vFj2Hd
	 3y85A7jkxpeBLpHTS3oe1sLZcuyhe2Km3uP3LaLU35CAbMU5NgQNiX0fZPRd9mKy3+BPX
	 Cp/Cvdw9si+0+r9Id/zQGPyBTMcMjw0dAYH4DqWEyZraBiWgLKBP8Sm7fK8lqZ/EkPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=vviFA7Vj;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D22B606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 19:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D22B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=vviFA7Vj
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4aa5833c263so2434713f8f.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 11:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795375666; x=1795980466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BBZvuayZdvCHczlz0b7O3tYTrVtKbbGXDSy1f+QGjMI=;
        b=vviFA7Vj5l1XocDiFxKz9cPk+SOHnzWeGEX2ROtxEf72PoVorTa9pqAwJ9LYsyUZtt
         Z5doa/aMZRabgMzdqsCpRnFyYKtNnf+wOA+1eU7pgiJ+YLzL1OqLUczxxZuSr9zW545L
         6RkDBhwAw466s4du1guUJ8IynyPFVckr6C87o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795375666; x=1795980466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BBZvuayZdvCHczlz0b7O3tYTrVtKbbGXDSy1f+QGjMI=;
        b=NGEaGZfLBoeDM/Jx04mDWJoF4jN6BfSEuXDRN6H2uDcQBBGpvxYUK6EepVXgXAEqna
         lgXtp4Qg4lz3+t6Smopl1AlaZdcUCkB6JRDWprNrm882KtjVpb1r53xkXRWXM71LMJ6x
         1dkdwaMGFeSXDKofvQiIshm8BbBozu57q+DwhJGMVpF6HLc8maBavuWs2TD8uWiCPNCt
         XCV7dtTNuJiVur12nemLsx+k8JUg/TNKFkvjiO/olequT4Eqs/yrsg9OTYz9qdpMeWE0
         LwmbV/USFEw7D8YqHRp+MuKJCqJB7+UKZFyb93E1ZVjNvGRXmvbZZZuqMpUFCQ1H8yxR
         0jkQ==
X-Gm-Message-State: APuU4Z9xBYnuMiTENusNvaBEVFQxtE+JqF9iFv6/TW3fJyYYdpI1nk2a
	8I8reznDX30w1i3VRcTa9xvRESK4fy8VPIxKDhmz2vWwcfDyW5AIa/V4ytEq7ljeK+gzraydSUv
	LDwiL
X-Gm-Gg: AZFdTZf6jD+OcXrfBANi/wnuogZVIY/qD2MMmBlqR66TNG+rI5v+Kzi2AIi97i0Cu9D
	VWjOIoDoY/MGCkmSSQdzJvpeldEtXGamWl0mwHv9Jv25tQh2HisGIjbGpXZ0hqJ5wVA2Xzjze7x
	3J4CPe4yPBC228917Th9ejc2rrmSdsFtktt2BqTbmY0hgBvnn7jnwvtbgR3RYJDoVKr6Z1+repw
	ljVHZhqjKnaW4HTp0yYvk8vB9HCMGaWU1ORlw+ArsuOpKZyOLXT+9vUJ8kLtaAGOYqGs3OIpa9l
	sY0L0H/ebP30L0gmO5X3waE5XXUe3M9d1hxTsp4Qru6DQkMQ6WGQ6FAA4mUrnQa2Qe7ZyGVHOeD
	qxJIMYw8vYm0huU9Ycb42FRoXwyQSH9YgVFmlXtrRgZeC+64JT+XSe7YyLkdsg85+8U+jKDH+15
	HqjTT0M5hYdHzk0NP7v/i26FS0aGmVIJSrBNaShh3/R0k3on7xtv7Mh1X/kpxe8WhwOk8izWsMN
	OakHWO/pHOYB5dQnQc6H7MPGoy9fbd6qZl6ORauDugkkyMGk1TC3Clw/XH3oHdDHKKqE6aAbiE7
	dcFBecLneYqD1J8+h0S58I9/349EpLVqjBSQH+iuJgbZ0sEB0A==
X-Received: by 2002:a5d:5f51:0:b0:48e:f10:ceb8 with SMTP id ffacd0b85a97d-4abb2168e0emr19005856f8f.11.1795375666338;
        Sun, 22 Nov 2026 11:27:46 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf630esm18647811f8f.16.2026.11.22.11.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:27:46 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2] shared/att: Confirm indications without a registered handler
Date: Sun, 22 Nov 2026 20:27:40 +0100
Message-ID: <20261122192740.2323438-1-simon.mikuda@streamunlimited.com>
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

When no GATT client is attached to the bearer nothing registers for
Handle Value Indication, so handle_notify() answers it with an Error
Response. That is not a valid reply to an indication (Core Vol 3,
Part F, 3.4.7.2 allows only a Handle Value Confirmation): the peer
keeps waiting for the confirmation and drops the link when its 30
second ATT transaction timeout expires.

This happens on incoming connections when ReverseServiceDiscovery or
[GATT] Client is disabled in main.conf. iOS sends Service Changed as
the first PDU on every bonded reconnect:

> ACL Data RX: Handle 64 flags 0x02 dlen 11
      ATT: Handle Value Indication (0x1d) len 6
        Handle: 0x0008
          Data: 0a00ffff
< ACL Data TX: Handle 64 flags 0x00 dlen 9
      ATT: Error Response (0x01) len 4
        Handle Value Indication (0x1d)
        Handle: 0x0000
        Error: Request Not Supported (0x06)
...
> HCI Event: Disconnect Complete (0x05) plen 4      #113 34.912832
        Status: Success (0x00)
        Handle: 64
        Reason: Remote User Terminated Connection (0x13)

Send the confirmation on the bearer the indication arrived on when no
handler is registered. With a GATT client attached it confirms as
before.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/att.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 366ee83d8..10ac4a3c4 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -1086,12 +1086,19 @@ static void handle_notify(struct bt_att_chan *chan, uint8_t *pdu,
 	}
 
 not_supported:
-	/*
-	 * If this was not a command and no handler was registered for it,
-	 * respond with "Not Supported"
-	 */
-	if (!found && get_op_type(opcode) != ATT_OP_TYPE_CMD)
-		respond_not_supported(att, opcode);
+	if (!found) {
+		/*
+		 * An indication can only be answered with a confirmation, an
+		 * Error Response leaves the peer waiting until its ATT
+		 * transaction times out. If this was not a command and no
+		 * handler was registered for it, respond with "Not Supported".
+		 */
+		if (opcode == BT_ATT_OP_HANDLE_IND)
+			bt_att_chan_send(chan, BT_ATT_OP_HANDLE_CONF, NULL, 0,
+						NULL, NULL, NULL);
+		else if (get_op_type(opcode) != ATT_OP_TYPE_CMD)
+			respond_not_supported(att, opcode);
+	}
 
 	bt_att_unref(att);
 }

base-commit: 1adfe662efeff12997df9ddd0960dbd0de9c8ea7
-- 
2.43.0

