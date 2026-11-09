Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239120;
	b=jzcmOzLFI48YA/4SFaqi6F5qmAmtqYWwiHKIzxKrX0O3S2laryXP3HZ2WsmBgYqr20A3
	 +TM9rAWREMU88OfNXPEYiFm+LXLA8rwCIeYH4OgKCcCYshn2q/s1WWTWWrv8+y8luhf9v
	 zT5Bm9KPo+qSW484hDYJiXqYEg9seXZG1rZyMKsHdB+Y8UtVrZV/pgiePyX3puT50LUpW
	 iD20nZvi9wQHzEivYbPPolHX/UeznwIddLx+zoGR+dwlXErqn+oXXWbtTFxBeQ5VXtOrm
	 kkpMtfbeeqcCWxmu9gVpUitY7hkoO54yZ4L7Ke0bi1jH54vThAKqEORYttHBJLnUOVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KemgZw2XXvYBeDRyJ++OZZAASE53+3yiwsKe32vi03k=;
	b=cjvUqyuiaPBDoKZEVgjVNStJO2AEpYUsCFMwWK+oJREcG1M5Uw204AHsJj5C5VDjo1wp
	 gwmxYSriiMrEp4l9+7WBApQC6UvI1Sqyf1+Mdd0XrtzSnbXqW1m/4g1Eko4ELk4FfpfnW
	 RwVfK41y86GEDI6RYvD4I/3gjGtX4DEBaZalRLvP0dWl516jnL+0g6cYp7ZNjLFMkkr5o
	 c7eaWuIhahbDDXpCWyXWlqemp/Z4Z9k6RComH8T/YmmT8awKMT0ds5NkvvvMvs6IZ2kve
	 /ikzs4yJ52gfVRNh7Z+gDtKZ8/P2SxG7a1wU9IRMRLlIt+o7lT8wBmoEwpuWtNmWxuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QkGaecAX;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293A76082BDE
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 15:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 293A76082BDE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QkGaecAX
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7d2ee9e7093so277181137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 07:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794239114; x=1794843914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KemgZw2XXvYBeDRyJ++OZZAASE53+3yiwsKe32vi03k=;
        b=QkGaecAXbbkOrLmPCy3+yovcXiAaFkKpiXzSDUkDpzwDaEouRtIgaC95oqP3d/T2aV
         iWAwvqNWmWFKlOlkwtbZrSK2IrriozpKgPandjC4R1Esyvyayt4A7AvjgIJYb4zoyGTE
         9c8InDXfDxUCHkQChXDedC4PX+ZEQbp4eY4A3D0pH0N2QFDZqgCN1EtseQb4apDaOnK5
         B18FuEoyvqcntocvd5garLHsinrNeohibM3OKmG91PZkDnEuD9vQ1hKY1uTtrdG8Yd0Y
         keTGAfAsFe9PsPMwo9OcxC8wywUYD6KnlOs8CVxqPOn3urXmiLR5VWwAwbOl6kn66IXp
         vVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239114; x=1794843914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KemgZw2XXvYBeDRyJ++OZZAASE53+3yiwsKe32vi03k=;
        b=pac2ZEmRm/9xhLIWAq/C9o4KG0IX45fE2iAbG7RiaGUju61Qq7WhF9/SeCWlA1AQhs
         cbmgg8bZJKNECPZtb5bM+OwgEtIYQEQ1ZjsFLMORTj74S4aXJvRAoxbtUiaMUvSC+QiK
         JUscyH1btbTn06se7n+EpsASjyaBNKDHsA/WFJlSXwSiB13rb0nnuV/GlGjKA/gvDWvK
         1fX1a2EorogSmyXqCny3IyOH7T0ztdpN465adtOOEmc1OvCmaP2BWO9U57gHdqrTTN96
         bAlGeUw8cxvxLLQwyx68Ss7auBALH5v2SmuFdEEPNQkN4CE4V/bXhyU0b/1XbWoDRvx2
         aNrA==
X-Gm-Message-State: APuU4Z+Tj8Tf7T+I4xYFxQrOCWMG42EAuGjVTAQBhNI9cHigjMmbAeUo
	y329IR9Ek8ebz4k6qEsKdrC1b5QYq9PN2VY8iUUwfvTPsnLdlEQkEJ1Onq2bEg==
X-Gm-Gg: AYBFou3fqCo83j9YL/BsLyThTj/amqY3Y0Umxp/+IhH//cqV0NHXLYU6jWFPeub1Q+n
	yTTbg+Ae35xz/GYdUIhZ68Ri1ScD15JNXncbym2LM/QYSM+ldHxJJhI/5/ERd8ICho4y//PxrX8
	HmS/vqmngdQBGG4EAqb6ag+faUYWkGLhmdBbCKAFbjwc6kbvyvpu/NPG7h8QAA1SHQ3ANdfpFsT
	b4fA4EPVQgHcPFdOJbx9XBIGQnbm94NsJH6cSHCm7ddZC6lnZblh372LgYmZ9RsNUo4Hk6RdYyj
	p84bkNog07wE/C7w0ZIad1+/TEX+4TMssQgs55F/Y1cNrzp3iSuL9EsZeFxeUl8WZIRPkvLViOH
	NYgTIKN3NshkvYvwQMMf7+cJ7klpICSjwqwT7OT3dJt7UTRpVxKcFN63LEUP7Df6RfYOluZGdOe
	VuysIsymlaqqPuCRJ5fTzUz5BChO12JjAdQpZl1se2VeVYnW94Lp0CLzcOboX6KTQkd4wB/MbEv
	pLCQqXQntOuP2Us/ghpvwY8bclJC+Br+BeGE0TLH1InvzMBF/X0fYiGBqUihN59IhbcKZZhq+yG
	eTVTp/cZF4r1rarJVx9syzGh6AakcOq1CBWsFLjiHN1O0jOwa9JQOoe5J+EAC9IkWpM8/GWe5DJ
	pi/H12XqzAyRKGxorbTSesZvCaDn/MXtZLIofK2/KVn5lUZYDm448pYN6SfyWDnjDYZwQj/5uAn
	cyZhc=
X-Received: by 2002:a67:e112:0:b0:7cc:1192:563c with SMTP id ada2fe7eead31-7d2db0df0eemr847385137.25.1794239113853;
        Mon, 09 Nov 2026 07:45:13 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c02a60a83sm4097474241.10.2026.11.09.07.45.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:45:12 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 10/10] shared/att: Fix signature length subtracted once per handler
Date: Mon,  9 Nov 2026 10:45:01 -0500
Message-ID: <20261109154501.1362649-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109154501.1362649-1-luiz.dentz@gmail.com>
References: <20261109154501.1362649-1-luiz.dentz@gmail.com>
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

handle_notify verified the signature and subtracted its length from
pdu_len inside the loop over the registered handlers, so with more than
one handler for a Signed Write Command the later handlers were passed a
truncated PDU and the signature was verified against it again.

Verify the signature and strip it only once.

Fixes: 051a525c ("shared/att.c: Add server signing key support")
Assisted-by: OpenCode:claude-sonnet-5.5
---
 src/shared/att.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index d1930f6af1d1..98e6e23eca82 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -1028,6 +1028,7 @@ static void handle_notify(struct bt_att_chan *chan, uint8_t *pdu,
 	struct bt_att *att = chan->att;
 	const struct queue_entry *entry;
 	bool found;
+	bool verified = false;
 	uint8_t opcode = pdu[0];
 
 	bt_att_ref(att);
@@ -1043,12 +1044,15 @@ static void handle_notify(struct bt_att_chan *chan, uint8_t *pdu,
 		if (!opcode_match(notify->opcode, opcode))
 			continue;
 
-		if ((opcode & ATT_OP_SIGNED_MASK) && att->crypto) {
+		if ((opcode & ATT_OP_SIGNED_MASK) && att->crypto && !verified) {
 			if (!handle_signed(att, pdu, pdu_len)) {
 				bt_att_unref(att);
 				return;
 			}
+
+			/* Verify and strip the signature only once */
 			pdu_len -= BT_ATT_SIGNATURE_LEN;
+			verified = true;
 		}
 
 		/* BLUETOOTH CORE SPECIFICATION Version 5.1 | Vol 3, Part G
-- 
2.56.0

