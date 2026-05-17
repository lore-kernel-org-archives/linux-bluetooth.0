Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED2030C149
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 23:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779061774; cv=none; b=sDJHO8QfAdG9xYLYyNdZxpmLy3+rgk0i3h/XEDrvc3y4JaW0ZxjAPsWpnymDxJWkEmr/R6ELG0JsDT1KnNM5qJjSmCdnE5Da8lUQFPcYhTuNi38Wb7WGil+hOw374xgnMUuZX1I4Z3LyQLPvy1g2riAs1yp9dkfUHEmspbR2skk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779061774; c=relaxed/simple;
	bh=18r8WGr0sLy2v2ONuN/uyQDOzOFcYvt1CAOLrZySO8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AX5UIMS9ROesmzRwb70bBA+R5XxMhVe62/fujjElnm3RM0v4/fGcD1+VsjnEYKGt17bWApcJD9i6stYLbQQKzPbjppLxWdUnsQFAivLoP8VenMmNFi+q4u9wrY9JRDe7uHFRZ8IX0qodnOobOY0uMLTAtfSwPskJveheTKj32S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbYGiYS8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbYGiYS8"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso19549265e9.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 16:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779061771; x=1779666571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q4JPW1ddnaHfBwPTUg/aODR+UFy3JRdz5SXqJfspXx8=;
        b=AbYGiYS8nkbo+JbSnshL6H+aBDgClnztbe+pd/QC8uUrJRU+dnJFtiIPFfAyfVjiui
         47tpix7Zk/1Tp68LaGFvzZnrE6TUaTFQv9DemY3TeVSKCSasJkGwIqEG9U5xJOmRYTjN
         X/6Fyop7+EzgCBrukGNDBCkLZnq2PQrRMkDyirPg/olp1e57olXRqVd/xYdmllEoxesn
         V4+N3VyL4jeVMnuS76ua3BGCYEvfHv9FXhuNaqIK+Wdu20edGbbSp7vh8AEbmJ/QQ9+6
         Jlpzv/dro3z/TNYU5v+o1ITHfZ+Kp3sKbTiEVW0YQywqLXFX0VXI/mqRU7mi8E2ple5o
         qkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779061771; x=1779666571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4JPW1ddnaHfBwPTUg/aODR+UFy3JRdz5SXqJfspXx8=;
        b=OUKl7DRneXssUJFzdZA7IzUh5pLIxTGSe+hhbKkPv5wnb+rXdZA5SWFTEkt72RG0BW
         w4cNBom09xPW3E5d/K1Dm4OMsKiewvhnZkI9CmoilIPnVVwJd3YYjINQCEIBAZHessis
         LY9rGDAQcL5dHfFJxGbUNeTVPlV0Hv5uopPN5evQgalwvfJLku2YHtC3xjxITSK/i85i
         ENujjsz6idtnXmQz8LFf3iiwO61ljPprv9YoXK6rbHHPLBcY2WQBKZGwDq65oOW91CMe
         m+wSFtCJGtjB55dU6AAUradR/QFja/R8NAnwSXvR2/1jgKmMJmdV0Xfk0Rlo5xQSMBrb
         7n7w==
X-Gm-Message-State: AOJu0Yz3zSb8uRDvVywBY3FHQvLfNnxM5DrgKtJ0JPGDLqr47LuO3UsR
	4l+ng+vaS3A64NOo4392IhDAeLlzGMP/W0W17fhJSrWFJ3adsgLiBhsY/RVah7T9iYk=
X-Gm-Gg: Acq92OG/a5OZQPBkK/djHijNlgNwe1xA57+4LFOvAlKpsIRx1760UiwYuWa5FmuXWsa
	5rZcVblhR40eKKwkarAHgWPz7LZl93p3QRm7m8o6nzERxLChYBotptlYcG1fJ8LHz+tICJ8YnCv
	x6lLnZ3TbDthKnNsOVVB3pYXw43k37IKGmBRGNJqoStl4TvnTQzUG0tkIKLrksdpTSofx+XzLcx
	uzvP8ju2yIQ+jUYfgghTU0vRq9E4Vm8jGI/PfVGTxlUFJ3m8YTlQbSPH5cQwef1qSsj6+3q7anx
	tbI95d/cUbaPertssXLNq4ERx6EK2UQH8m2V3yKYXfUry3Zy556gF8taGlpTeW81jSwStIgjOxs
	GFUfZVut6vFsNpZhE5Ar9pwJzc28tjp8+FgF4csu+zUrMbxxQrPj9BaZ/basF2pcPkfuGu4hGBc
	wtplh7QJMkKDKkeT06rZFy7wRT8K4Rv5NSvyhBQ8QINtQrxr2aNVNAfQr5f0w88zOANl3LS3BSA
	omxs5DT9P2c
X-Received: by 2002:a05:600c:a406:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-48fe4fa1902mr154323275e9.6.1779061771345;
        Sun, 17 May 2026 16:49:31 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febf86db7sm100133505e9.6.2026.05.17.16.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 16:49:30 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@gmail.com,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] Bluetooth: HIDP: fix missing length checks in hidp_input_report()
Date: Sun, 17 May 2026 19:48:05 -0400
Message-ID: <20260517234805.116570-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
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
the handler reads beyond the valid skb data, resulting in
an out-of-bounds read of skb data.
The OOB bytes may be interpreted as phantom key presses or
spurious mouse movement.

Add a check that skb->len is non-zero before the type switch, and
per-report-type minimum length checks before accessing the payload.

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

