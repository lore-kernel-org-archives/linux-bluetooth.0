Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80D938F22D
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 21:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313315; cv=none; b=rRf/FJP4hKC9mQdTMH7Ze+Jkxbgl1O/pmGldEaYERttAK2jOveMS9YwAX+tkMcz8+MPvj3/Cu9bcbCs9LB9gL9mQ7YLOaVbwvKaUiZaL6cWtgFwNpmyw4ygBxHaKFeiS1Sx4kVyAUwMz87O+wIy1RLKwNO0SHP6dB4XNk+XoHLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313315; c=relaxed/simple;
	bh=q8FoWYVLPlkL+kH1MsFlOIr4cXjQCeHlCbdbANhazyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbNRxawWmSQd8chrfjbUqgOz2tLj+JMs/4CmmTtvWEt3iympuiHzWxqSCBznweuqb/epqDEtvA8yzNzmPiNJPqbRmWxgPaIgill8DMJm2+nEUy/sXtYLd0Fxb7HABz7IpJ/jA02mxJsOz02h6bugHUKpcirJUb9XrX3XrP0v67E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQZxUipI; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQZxUipI"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-687e7edaafeso709780a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 14:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779313312; x=1779918112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5t5r4M2iJCMhY9Y3g5BpbaSaxYN98wLxatFgP2FtCk=;
        b=YQZxUipIL3ZA2ejuNDHIE56BWxfIY+R8uUG57g9rLJbtSnMdABJFAUoySHBqN5VXJ4
         yNvOspgMF2wU5INT9InKDCkY1g+3/04zfl2RNfWQBfeM+rKBpZ6dP9IQR1VA1GohhjAT
         otx7yWDrVP0/pMHSDr6O4g5C30AkRmvCVxJAftPX+bYyl8PpzyJ2q6JLz32jrPAlQSBk
         E2kilWioQ1hUTz3qfl0iZW9Bbg9RnuqG+QGycIXJuKF6KQZQFrqcwoU+cKDXBOOxP44q
         VKbl1OV5dWH0bjQ75tXhsYy8cC3vOGPKssNA2UcmVgb2lnh/MPbOj353K/OD6rg9MBm8
         asVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779313312; x=1779918112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h5t5r4M2iJCMhY9Y3g5BpbaSaxYN98wLxatFgP2FtCk=;
        b=D+tHxZKFeLBxPXxGxHmtISK25wkfCTk6rHw1q2D9CGE0WWVRLfhy0ELvybcIsFVLCD
         n+Mavz1skCe4ZO6+Bt5TKWrrjs2mYA/75TGtTtTgy3zrXEJrkvIdKAcpGVPEO+92pi8t
         TjdP3EfXznduI9yhsABUd5X9zLBz5ylfoLA14KP9jeRBCYWJoIFcohdqdm4/Jq4FPo92
         D/EdvsY2yqYXjPYHwUzVEj8PWfdqUjGr4vpvCoO4fRM0e9wcFY+QVD3Bwc5URdQ0/WFX
         pTJZCFy5zCY6Av3VekP9thbHpbQkHks4Fw1LxozJDpJs3kh8l29OLfAxxO5DMrNMQZ1Q
         uiFw==
X-Gm-Message-State: AOJu0YxikhEBGX+o43vXnOr7ubQpsTsJ6JUYLDQV2tpW4VCGbe1YaYqV
	85D65b2GCGKB6zB6XbUwuGs1gUTLvRLhnY2CTqve1SEXkMN7kN5j520YI1AUPKBcpzA4RlVk
X-Gm-Gg: Acq92OEX1RfN4Zk/ye5HxApEAmdf3pJmsBZwgTBZyXUOFy8IFyxBhCpcRU/7nSXEiOr
	DF7AncJ0/CSb36kH3QVOD5zUhabogSALDcEcRhRZLXgiOHMTeJdaDPbHDD1cvvNMLbKmMk79kDw
	CKwY19jooRplMqWPZmSvAnE0rB0E++yUVqjuYOljSOwsSF16OlctP7cMLmUY1kZjBuC6q2j71+I
	uNCaomqE5W3VWiopTNxvQvbXDkCLTYQum05QmZqa7lCz7qwqrMQ0+aiwrg98UHrfPE8LwbzonU4
	BBgBNvE+007MF5V6zRF9U+T2xIE3SV7hdjOOq3izSAuMg8Ca4oM0yqNxgn0uy55w/oVln7V30Pn
	otOQA4UC3PnInfiznCN22CfVZ48dtIxiergXR+LniEZWyt/FRfhoJEJLvD/qiVgJcc/agWSHvNf
	ie3hsPQDMbfGPXS3DASdv2izKjL17KJFygUymVXnhDS89nwku105oezQbKZLB8bPrBlMwIejrte
	w==
X-Received: by 2002:a05:6402:358e:b0:682:d56d:1de8 with SMTP id 4fb4d7f45d1cf-683bcd9f01emr13077801a12.14.1779313311894;
        Wed, 20 May 2026 14:41:51 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6882442b03fsm114869a12.12.2026.05.20.14.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 14:41:51 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@gmail.com,
	Muhammad Bilal <meatuni001@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: HIDP: fix missing length checks in hidp_input_report()
Date: Wed, 20 May 2026 17:41:33 -0400
Message-ID: <20260520214133.27746-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517234805.116570-1-meatuni001@gmail.com>
References: <20260517234805.116570-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hidp_input_report() reads keyboard and mouse payload data from an skb
without first verifying that skb->len contains enough data.

hidp_recv_intr_frame() pulls the 1-byte HIDP header before dispatching
to hidp_input_report(). If a paired device sends a truncated packet,
the handler reads beyond the valid skb data, resulting in an
out-of-bounds read of skb data. The OOB bytes may be interpreted as
phantom key presses or spurious mouse movement.

Add a check that skb->len is non-zero before the type switch, and
per-report-type minimum length checks before accessing the payload.

Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/bluetooth/hidp/core.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 976f91eeb..03838a6ff 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -179,12 +179,22 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
 {
 	struct input_dev *dev = session->input;
 	unsigned char *keys = session->keys;
-	unsigned char *udata = skb->data + 1;
-	signed char *sdata = skb->data + 1;
-	int i, size = skb->len - 1;
+	unsigned char *udata;
+	signed char *sdata;
+	int i, size;
+
+	if (!skb->len)
+		return;
+
+	udata = skb->data + 1;
+	sdata = skb->data + 1;
+	size = skb->len - 1;
 
 	switch (skb->data[0]) {
 	case 0x01:	/* Keyboard report */
+		if (size < 8)
+			break;
+
 		for (i = 0; i < 8; i++)
 			input_report_key(dev, hidp_keycode[i + 224], (udata[0] >> i) & 1);
 
@@ -213,6 +223,9 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
 		break;
 
 	case 0x02:	/* Mouse report */
+		if (size < 3)
+			break;
+
 		input_report_key(dev, BTN_LEFT,   sdata[0] & 0x01);
 		input_report_key(dev, BTN_RIGHT,  sdata[0] & 0x02);
 		input_report_key(dev, BTN_MIDDLE, sdata[0] & 0x04);
-- 
2.54.0

