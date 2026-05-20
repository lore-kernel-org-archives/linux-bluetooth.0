Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC03366DB6
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 22:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779317842; cv=none; b=ivcD5Y9oRpQl2TJtmvGJjnoVqcXUQPrbYxbK4aYvfKhv0F6OooMrS7ZfNMhBG9rn4USJoYcGa3nzgk9lIXX5SYb3ZC6eMC3mSb0EjFqxxFBkKjzWeEcxBng3ZM5gCt+bDm3ehApLNlM7SK1MvBHPEQ2ojtEIPDSay27HbBD4uGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779317842; c=relaxed/simple;
	bh=9WDmz4mIk7d37pNF+Jf3V82CnN2ksLJhxTsJcZyYoPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pp03E3SK31CeqALWy/iZXoBLT67cuw0PLoLDjs0UNaE+sp40wGIissPhPUs8YdsxGwa++ngDPdplfn4NaHhCA0XJIiJDDKa22g83G0ZsW2j419cKzal10wlWk00jFoNqB65jzW0GhSr6y1JI5aOt9aCdeIP59lNhAE1ouKIkU0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SC/CUCJt; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SC/CUCJt"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bd85ebb368fso792871566b.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 15:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779317839; x=1779922639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5LTi7OvRi2audUUcgHNeX3CP0k1T7QcTMVWKqi+l/s=;
        b=SC/CUCJtKH32blGUdu8kFVrjcjBGb45otHujNLAnY0itPJHnV7NEcWihQUoVZiDAyS
         tmxfhH2uLd18VS/c636hFzr60VDqmibXz3eZRh/QLhamHy1NCzTKHdlYNtJOlDpeq1TE
         4oulgBryY4e7e2mLvZhA2IsnMPzkDjbgFY1H6eH17cq1RBG+k5/KUE5uFQi521eXwuCn
         zu924dxshEHNdL0rC1MoUQYMCOUGY0uYUlyHMoqWRT+vYs2A0L+i6Y4CKTSJrhJFAn/H
         z211wZlr5KHqIHiJIrB+0DagwsjwNVW3eQUo0dW2JjDUgk/uD0GKa5xXqEnvBBGJpEHV
         xaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779317839; x=1779922639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O5LTi7OvRi2audUUcgHNeX3CP0k1T7QcTMVWKqi+l/s=;
        b=tYYsBDMu6JbyRYohtrVGxVw6hiaqXqFKZQ0IGQ4Bl/vTy5q1U2phFkZjGwYLBaCD5K
         0exGx4ABZ4xhi7rZdQ6boEB+BEsbpmR2ciaqJLCxBAflxyKa2nojPdeA0AehmOXnO22q
         7Kp4DLgAAurcZpGquWQ+TEq0yXbrWBziP4eyxK2GTjXLyQPhI53183j/CHCq/T8gc7xD
         +Fx+Vi2IuirVYyxEXJ0XY5FgZeXwD7Qda98NvcRpGpIRNRhss6WUtNCx7gbC+LUDeskG
         njgqPdDLosXKHGD2fv2e/6gmbjSyvgBmpbPt4xg/zUufNXHtDVrMjtuvDs09LQAfLhJG
         aCeg==
X-Gm-Message-State: AOJu0Yyq7/QxxVMq68Pmyn1ZzdsqsoMXwX2CSNRMRIenqB4OsnIF7kz+
	gVmPO3ZbMv+HbjJPcRxmRa46tUHtvmgA5cQO7wdt6T698TXE18bDzSFEuVoW2ORj+bdayEfd
X-Gm-Gg: Acq92OH5ePt8trdUMRH8YrwJsdPI6OJyvE59DPuGiF5m7bP+1SY6PQc1GOMUPZGz9JS
	Wk2IjY2utryMUWDtTaFx9EZ2pOVErCQjuvTyYP2YFYMmqEoNqRUjwsCjNWUChsglh3OaNIKsvwP
	2h5M+P6c6qt2O+a5O/hvVHOe8r/9eNm+r0sU92VG5QZQHUsoWzwD0lMqx8+/vQBg3O96B7OrlWJ
	pUtcnH8x1wscW7YP8EWs5hs7g/kY+dRjCWVPF43h0iL57mXV4hqBshtnveQjdr3b7zwO2jSrem7
	LZhDpjWBlBeXdVpRrE2H6JJgzqDhN4ft59RkZF2Sm8d57kLibs3dHVrWVmc7GsUAmvjozPnen1e
	L2LekopM7+IAQBIqkOOKeQpX7LNJkrbYrmhHL8NM6sb9gepQqFNtcJwSxfJirh8moVF/35EmXzL
	BlM5+9TAme3z7WpNh+c8E2PLRqtCTeBz93F3lJzZE8JBOBXQr+IQfw0LA///tCFIQkqRaLC1mpq
	FclgA==
X-Received: by 2002:a17:907:3faa:b0:bae:d29c:4e28 with SMTP id a640c23a62f3a-bdc12aa6420mr10795366b.12.1779317838922;
        Wed, 20 May 2026 15:57:18 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4ded99dsm903754266b.30.2026.05.20.15.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:57:18 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v3] Bluetooth: HIDP: fix missing length checks in hidp_input_report()
Date: Wed, 20 May 2026 18:56:43 -0400
Message-ID: <20260520225643.35683-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CABBYNZ+Oc=LU6d8_xK9_a9yk-TFyaE=0KsNvAwKbNZVs1EJpWg@mail.gmail.com>
References: <CABBYNZ+Oc=LU6d8_xK9_a9yk-TFyaE=0KsNvAwKbNZVs1EJpWg@mail.gmail.com>
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

Replace the open-coded length tracking and pointer arithmetic with
skb_pull_data() calls. skb_pull_data() returns NULL if the requested
bytes are not present, eliminating the need for a manual size variable
and the separate skb->len guard.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
v3:
 - Replace manual length checks and pointer arithmetic with
   skb_pull_data() per Luiz's review
v2:
 - Add Cc: stable@vger.kernel.org per Greg KH's note
---
 net/bluetooth/hidp/core.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 976f91eeb..70344bd32 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -179,12 +179,21 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
 {
 	struct input_dev *dev = session->input;
 	unsigned char *keys = session->keys;
-	unsigned char *udata = skb->data + 1;
-	signed char *sdata = skb->data + 1;
-	int i, size = skb->len - 1;
+	unsigned char *udata;
+	signed char *sdata;
+	u8 *hdr;
+	int i;
+
+	hdr = skb_pull_data(skb, 1);
+	if (!hdr)
+		return;
 
-	switch (skb->data[0]) {
+	switch (*hdr) {
 	case 0x01:	/* Keyboard report */
+		udata = skb_pull_data(skb, 8);
+		if (!udata)
+			break;
+
 		for (i = 0; i < 8; i++)
 			input_report_key(dev, hidp_keycode[i + 224], (udata[0] >> i) & 1);
 
@@ -213,6 +222,10 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
 		break;
 
 	case 0x02:	/* Mouse report */
+		sdata = skb_pull_data(skb, 3);
+		if (!sdata)
+			break;
+
 		input_report_key(dev, BTN_LEFT,   sdata[0] & 0x01);
 		input_report_key(dev, BTN_RIGHT,  sdata[0] & 0x02);
 		input_report_key(dev, BTN_MIDDLE, sdata[0] & 0x04);
@@ -222,7 +235,7 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
 		input_report_rel(dev, REL_X, sdata[1]);
 		input_report_rel(dev, REL_Y, sdata[2]);
 
-		if (size > 3)
+		if (skb->len > 0)
 			input_report_rel(dev, REL_WHEEL, sdata[3]);
 		break;
 	}
-- 
2.54.0

