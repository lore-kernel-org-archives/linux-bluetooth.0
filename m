Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990037;
	b=nu5yGnOsmnEwV+EDrfK/69r7jU6sfn8t4Ve/+5LaqEdXMYJ82ZTv4a9D++8WofYRzbtw
	 A7cosBC6nkB2kvc9tSYKUSbKZGtsjy7ZS/k8V7WBr8/GtIBty5/9n6LsDx5SKMuIiMokj
	 Bqwc3DM4CXsFwVVoqpCg4NV+Rb88ZwrAwZqs/uJG/UHQXcq53RNMmQpatu7cejwdxFO4o
	 GjotGq2JBDB5brhJlkk5OXPsUnGYwbe2h5YWt6bU9JShw81q58YkLskLjUFHgQ6Uevf49
	 lIWU8cvRu72hVgiUqgqQ4hqlazY/l+R8Wg7jpzCbCktz3HfiIwL3LPCC0jtX2PAQxkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=p0XlDhv2VLB442UaEyH694WjX0V72bY9f+e6oFTZLeA=;
	b=Vy+tvaaTLdeJpcIfaX6cKuMBh3sHceSZPEKAwEIEBh79xHFH3CgGioThxtzO+50XWAu3
	 58//bQqmZqoCzIjzOCRVdrjOImfkXo8Nst8vSJMJlXOph3PvvvK7o/RBGFgiHmETFpuZB
	 KnZZegg3erS2OGuyKf6UikBEOGitMY5Itlcd+V829hRVW3lA7XpIzu2GPNjp6q2W/hSVi
	 zi58kh+Z5zh2jBG2zeqX2mcOMeAuHjXE7LXz1UjKda5y3L5ljzjtH6lu8K5xjj32h45IW
	 l6EJ3MXQO+cyvuwLh0SmyAOGYlyTxYH+sCWL4TxrQCNthalyNG9UZi8CnTGXI8Tlu5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GTp0t6i8;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B63606A32C
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 18:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14B63606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GTp0t6i8
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5ec690faf85so358668e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 10:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990036; x=1794594836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p0XlDhv2VLB442UaEyH694WjX0V72bY9f+e6oFTZLeA=;
        b=GTp0t6i8Cga0ltW2f3yTjxnVbw7exAa/WBz/XEN0ckoll/ndraGtIz2RXv7O7CglWK
         YqxJw13dfMzURxtTbjgW4FPnRj5GZwVGTEHNLsbdUHkW3nNN3RsiU98e7Du6s6gRsM1T
         1c8CK1rKqC6iH2fbs6aK1M3Uptfs0Op9kjshEBy/p5oQAQKueW4ReGsAby88cNnuz4Er
         6PW5+s3Uni4KRDej5LuV92fC6Rr7D+T8TdEWuCZrWb7cgJZ335gSAUX5/bfZB4I8heA7
         KS7qoXxX3be2jHvQpgZYrt7u+ssfGr6kJkDhyFvOiA3KAwSe6+mkXJFW6ceuevDrx4wR
         6gxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990036; x=1794594836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=p0XlDhv2VLB442UaEyH694WjX0V72bY9f+e6oFTZLeA=;
        b=Q730hIl674cRcEK7sOgbFFE5BmeUmc/ILqoEVVPO+bRegpd/qmsLOLbnap48XS9yTM
         TXBFTQrF2yP1eLkbVYK7PrnovB9KE0rQZbnnfG3uMlwUGdwycKnk+oIwS9spEPYMgpSg
         LIMtIs5nN+KyUtS9K1uPF7036SJ6QFiwokYxbaH3y2wgOSrhLb3XuxwltXld+ps6nbS3
         72Jh1QrxcTKlU1vDfLLT8Hn5xIvtJr5RO7oXpN2vFXaNXQ4gCAJzuWAkdbl/CjMey4BT
         i7C3f82FN8RGp80fWXWr9CR68J/xRtReAe7WnVd+Y0BJ+5mlKbGYLN7W4eaWOUo8PYqZ
         K4EA==
X-Gm-Message-State: APuU4Z8uMWU8fJYfT9iaVh83iKs4SD1Zk56GOSghrWf4dZPPliHUxCpO
	rnYh0cvJnNcrWx1Zdkh4YOGrM2auf/RXERLzASrzaLRAbix9FR4ZK2yoIrZwCw==
X-Gm-Gg: AYBFou1rX0JtEiqAv8D1TsLvQuhkIe4eGF8T36G8qBYJJyVgvyH0Uz/ZXsY4itg4fOS
	vX0c1MMlI6e/NS2UGenZYRKSOkP4E3M+M+d7EjSLzumCFZg1LBchh6QFHyfDzhdmLWcSyQqcMNK
	DHNsdfHaUkQ0o6EzMa4h5ogPcNhgFvNAYesmQ9C7GQF0Iw5ADn1YdkzN/4JvfjspHcNkWuIVLyV
	hBP7gIFagPaxi/BHif+RykvTzAt6Xjy+SZjerkk/xWvNpK8lD1AQ4kdBX6ZyCXw+lKyvY2tBGSF
	0hT4phzXzIO8IUnZsNVuRuvM7QNQGfEUMfJISw9lKT3Kvzu6Ye1z9kk+Y3XH+jJnEdPQoc82KlY
	JCp0avfJiHZExN/t3i+Elp/CMoJ4uoanxPLEBypS7dGtUAGzm8ttcpmBeYkSLRKtMLDobSo2a8c
	2Vls9MSDomTl98+ZkhVcjoRKnm9K+k+TpKQhbgjqKHkdh+x8jSLviTCA4FnHGGFInYzPdIJQ/1E
	cd6YG00WIe5/qSPNWHxumumv5UvXn3LHSZxHQkIf+D6aiF3w2IULzFZ19an1r7O16frPXFZJMin
	UEprbzIdJi+Lc0W008LROW2L26zGtsy2q5EVvcWxDNyXqcXXp3YirX+QEZWJemaN0A5RKcqq/bN
	XVYyarjJKyEAmJjxJcaugRezhAeuYhxT2Vju3/AQdDSS9H7aHgl+GaUDc5nTPQfcGIMo5OdFQyd
	26+STtC3URvU6ktY9+p2caYsnB
X-Received: by 2002:a05:6122:e1a3:b0:5ec:e7e:27d6 with SMTP id 71dfb90a1353d-5ecc43a36c9mr1706865e0c.4.1793990036011;
        Fri, 06 Nov 2026 10:33:56 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64a6774sm1910173e0c.3.2026.11.06.10.33.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:33:55 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/8] shared/att: Add Read Multiple Variable Length opcodes
Date: Fri,  6 Nov 2026 13:33:47 -0500
Message-ID: <20261106183350.3155282-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106183350.3155282-1-luiz.dentz@gmail.com>
References: <20261106183350.3155282-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

READ_MULT_VL_REQ/RSP were missing from the opcode type and
request/response tables, so bt_att_send rejected the response and the
server never answered the request, leaving the peer to time out. The
client could not send the request either.

Fixes: 3c5088f040ac ("shared/gatt-server: Add support for Read Multiple Variable Length")
Fixes: 6ea204dca0b2 ("shared/gatt-client: Add support for Read Multiple Variable Length")
Assisted-by: OpenCode:claude-opus-5.5
---
 src/shared/att.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index e49743b5a764..3055f291f8f1 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -129,6 +129,8 @@ static const struct {
 	{ BT_ATT_OP_READ_BLOB_RSP,		ATT_OP_TYPE_RSP },
 	{ BT_ATT_OP_READ_MULT_REQ,		ATT_OP_TYPE_REQ },
 	{ BT_ATT_OP_READ_MULT_RSP,		ATT_OP_TYPE_RSP },
+	{ BT_ATT_OP_READ_MULT_VL_REQ,		ATT_OP_TYPE_REQ },
+	{ BT_ATT_OP_READ_MULT_VL_RSP,		ATT_OP_TYPE_RSP },
 	{ BT_ATT_OP_READ_BY_GRP_TYPE_REQ,	ATT_OP_TYPE_REQ },
 	{ BT_ATT_OP_READ_BY_GRP_TYPE_RSP,	ATT_OP_TYPE_RSP },
 	{ BT_ATT_OP_WRITE_REQ,			ATT_OP_TYPE_REQ },
@@ -172,6 +174,7 @@ static const struct {
 	{ BT_ATT_OP_READ_REQ,			BT_ATT_OP_READ_RSP },
 	{ BT_ATT_OP_READ_BLOB_REQ,		BT_ATT_OP_READ_BLOB_RSP },
 	{ BT_ATT_OP_READ_MULT_REQ,		BT_ATT_OP_READ_MULT_RSP },
+	{ BT_ATT_OP_READ_MULT_VL_REQ,		BT_ATT_OP_READ_MULT_VL_RSP },
 	{ BT_ATT_OP_READ_BY_GRP_TYPE_REQ,	BT_ATT_OP_READ_BY_GRP_TYPE_RSP },
 	{ BT_ATT_OP_WRITE_REQ,			BT_ATT_OP_WRITE_RSP },
 	{ BT_ATT_OP_PREP_WRITE_REQ,		BT_ATT_OP_PREP_WRITE_RSP },
-- 
2.56.0

