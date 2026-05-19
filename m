Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FEF3D88E7
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779175827; cv=none; b=BCpFPIHnnFE45RX2Q1yNuEwdTtbCEAgOaEXcK7UcWweoTMylj7gTT5hrMjamDC69nF398AptKeKe4x1EkFnDX6SeFyhCSWB7AiJ96hvc40/7ECeyTi4JC94iEZ3PanfYBnA+LdQUV/J7v0vD5DkAm9A+QkcrrIzrBKcFhRjvDME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779175827; c=relaxed/simple;
	bh=E5tbrL6gDSZ/C+kamk4PKO0Wqa9UDvCknl/PJPOeSAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CGj6WqUEH7Vhw4WSE2Lkuj+Vhw7g1NW+4vh31X2MHvK1lHEnOWPyPCYGJmLW5YawIT3t8tB7M6VWadrFpwmq8s67SMXeVAuyxjFwiOrXh+ibbF/pB173qzL+dPlSxzfHKVz2YuCqjaOOIsrFUwvOmwgsaC8gKxVsM3HLVsf7ONA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0mEfy97; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0mEfy97"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-444826c16ffso2745494f8f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 00:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779175824; x=1779780624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J0yD7Ov4S/iFthQxZco1gvVMz6aNPT7+SQbTZFwmogE=;
        b=c0mEfy97zwfhA0j7z42mj6tQX/pTQqWKLjiwLxcd8nkUI7qZjubdJ54X1h5riyVpm6
         GVXpWrTLfaTE6BZj0l7X2PPFiAOcm6ta7M7feP+78Ua0JVIXdScGWXW2W1d3FIEVauVX
         TLv5TdkLE9WTsu/fjfEGswmGSW9YcYTM2pI+nvi63aXIzWoSgAW7CoN/iqklflwX+2GB
         5/hEKtounYZxJbIq3hof8hjhugEI5JnYSelJ1ZG9yy97OuurDX4f+I9VbotZ8npd/0cy
         f2oyH4pYZU1NsbV6fJrXL9ewA5FfWNtRXrNqXJVf9UPHp8zKXcnlWPZzUUUs6hGO4s3B
         2REw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779175824; x=1779780624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0yD7Ov4S/iFthQxZco1gvVMz6aNPT7+SQbTZFwmogE=;
        b=RYqFS+SkxhiJvF69f1xKNZP8fi7jcjknV6wSXKEFQBuslaRA06+BqvFujxbI0E3OBE
         RUqnUxJOgbHxuG+dpz6p7ZUAIM4l/TL2Q0A/+8IE2bci1jurd6HDR0WP9CI9T3TVqhQs
         VHzQ50cd4Tkj8qMlCyHUci8Ll3Lt0dt42O3kjEx9YNhDjjlcn+JXzBMl994YmDRxmgCg
         OJBwMA7WvpIyLqgZlbzxCrxYElbVqfCceot3zpsp0vaupIxR5PmbDO4RxHYt8ghSQpOu
         O1H2VfFWFLHPNe/sS+OeBMRnWnysXKpfRdBp5Ss8Np2uwqnKhc5UpSrhZ7UED1baH0DE
         Y1Aw==
X-Gm-Message-State: AOJu0YypB9JJzzpeIcnA4F9vG4DFc0JEOCZk7SAv6jxoKo77zgPRgk6I
	MM8zwgXlnBEYjdtWW8q/2/DuCkObbI76uhG4/o4aoBvy4xBHtN31vtDgVNGsjb+Tlc0=
X-Gm-Gg: Acq92OEvKa440FQiEfvfjv55SkhAhmvgByJIdEs6NeIpVlp8XFOl1iOJ311vf42ZqG4
	VNiYnN7f+Y/7aqdSQRzJdymw9JqwQCdhp495cFBT2UYqg7OJUSccr2PkIxmQiDyk+d6xyZjrAs4
	S/M3cEAK6GsF/yNEtdiucWkYgtpb4srovD+m5RBiKj9LnhYqcINHBnJtjf2l2S99Z4RKNZpvQH3
	/rMRTDHcr7S+khYFbrD0yXgKHXzB/JVG6nj2WE7zIk/aa+aRkzjDsY7E8miwO8kZN/k/mrW1rrY
	PwlKm9aZVjsEUWEtTHlPhvGyiH9fmU67m99k8A2DnLNYu6csbLdk4dRcgplORq5h13qjFtDY5GT
	xoGpEgHS4c2tqyBsCTK59NB92Cdx4pcjrLKaBJ7tDEJ1zuy1KSH3qXld7Tm0zRuY9hOR71QM+yg
	+ttzxb5qWRlU5jQUGFTTDWeRijnRI+x46C/9Vr/MiyC8dvxWa0rIc142gF2J6Wr54ICQr/aNLNf
	Vi+a4EsiLYo09K7OVn5YKk=
X-Received: by 2002:a05:6000:2503:b0:43d:6a0c:9571 with SMTP id ffacd0b85a97d-45e5c36bafdmr29954236f8f.11.1779175823595;
        Tue, 19 May 2026 00:30:23 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767cb9sm41776680f8f.2.2026.05.19.00.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 00:30:23 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	kees@kernel.org,
	kuba@kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2] Bluetooth: RFCOMM: add minimum length check in rfcomm_recv_frame
Date: Tue, 19 May 2026 03:30:03 -0400
Message-ID: <20260519073003.34206-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rfcomm_recv_frame() casts skb->data to struct rfcomm_hdr * and
immediately dereferences hdr->addr and hdr->ctrl without first
validating that skb->len is large enough to hold the header. A
remote device can send a crafted short RFCOMM frame over L2CAP to
trigger an out-of-bounds read before any session state is checked.

The FCS trimming code that follows compounds the problem:

skb->len--; skb->tail--;

If skb->len is already zero the decrement wraps to UINT_MAX, causing
skb_tail_pointer() to return a pointer far outside the skb and
producing a second out-of-bounds read when the FCS byte is consumed.

Add a minimum length check before the header pointer is assigned. A
well-formed RFCOMM frame requires at least addr(1) + ctrl(1) +
len(1) + fcs(1) = sizeof(struct rfcomm_hdr) + 1 bytes. This single
guard prevents both the header out-of-bounds read and the skb->len
integer underflow.

Note: SeungJu Cheon posted a related patch that adds equivalent
length checks inside the individual MCC sub-handlers
(rfcomm_recv_pn, rfcomm_recv_rpn, rfcomm_recv_rls, rfcomm_recv_msc,
rfcomm_recv_mcc). That fix and this one are complementary and
independent; neither subsumes the other.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/bluetooth/rfcomm/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index d11bd5337..6b300237c 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1741,7 +1741,7 @@ static int rfcomm_recv_data(struct rfcomm_session *s, u8 dlci, int pf, struct sk
 static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 						struct sk_buff *skb)
 {
-	struct rfcomm_hdr *hdr = (void *) skb->data;
+	struct rfcomm_hdr *hdr;
 	u8 type, dlci, fcs;
 
 	if (!s) {
@@ -1750,10 +1750,17 @@ static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 		return s;
 	}
 
+	/* Minimum valid frame: addr(1) + ctrl(1) + len(1) + fcs(1) */
+	if (skb->len < sizeof(*hdr) + 1) {
+		kfree_skb(skb);
+		return s;
+	}
+
+	hdr = (void *) skb->data;
 	dlci = __get_dlci(hdr->addr);
 	type = __get_type(hdr->ctrl);
 
-	/* Trim FCS */
+	/* Trim FCS - safe: skb->len >= sizeof(*hdr) + 1 >= 1 */
 	skb->len--; skb->tail--;
 	fcs = *(u8 *)skb_tail_pointer(skb);
 
-- 
2.54.0

