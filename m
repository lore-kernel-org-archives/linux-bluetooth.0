Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9DF38239F
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 23:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786748667; cv=none; b=M7DuSm0yq/2Nr/ppmxDUO6/3zEsDSHG6ptAt++XYNx6sJxjUIYMBMejhWX+dKnjmHuiLOFYOo/sU1EPWs2Ux0uf7tEl3lw1bTR+UpBnnAM4edsPgX5ckuhwpMau9fI1IOdnk43/rbjSAZ2GSOlyx5uN2Z6eAS83FqeQebJWfALw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786748667; c=relaxed/simple;
	bh=T1Wz9lKdUyAv11tPv+bgQEEu7yh2xg8l9rVv9QLOCOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tjNe2QXuz+F7xfxW3d2l2f6upKz5n1VffZy1oj8irbvv9+WZWa8ONzHdFJLy92JFPuXIfWreQsYddUbY1xJ6RNJG5bklDLgQH34UqeDCEya9g3IL57nSZGQKQb2pekkxhfwBzqzbWCZ7bmmz0iLl1g39xf26KebZtVRrLOF75Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allthenticate.com; spf=pass smtp.mailfrom=allthenticate.com; dkim=pass (2048-bit key) header.d=allthenticate.com header.i=@allthenticate.com header.b=c6x4Iain; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allthenticate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allthenticate.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=allthenticate.com header.i=@allthenticate.com header.b="c6x4Iain"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4560d6f82edso1098458fac.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 16:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allthenticate.com; s=google; t=1786748665; x=1787353465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OKGuerssb/05gcPsxR7+N3ZpeXB8vuZ0PXZ1dqw/lEo=;
        b=c6x4Iain99hKhBFGVhWjQJe/pBtd2ao5kcd8+I2jIEh3LgJvAqJBah7WJROX91OGSu
         EY1uxqt74oE9R9jSk7yK70JY/FggQV2XOXpoTlTKmcLTqRyMGJQP1pirLdCzsFxLGKhK
         ijQ8WfDWYWNan7QKQl8qI7FC8DrNMvF9le1cqlI+rV+qIJ1LkyAQz9+KDHn7ZcvC0p5b
         SpUKYrgxl3Qcja4IjY4aMTh65gdln5kkQsgPbH7gngk+jH8OVhHdNLOtiQLyci5A4ek0
         FWkHua4xhjhT8BNpLtDXw/73SRZi52RFn1MpdnE+MKPLTzpPBgT0Db+j8/bYi33yUTFT
         OHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786748665; x=1787353465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OKGuerssb/05gcPsxR7+N3ZpeXB8vuZ0PXZ1dqw/lEo=;
        b=JDrh4bkYjAigqr/Q0gV9cLV+oji2O65t9ecPVOdWG9TlQapeHQZAMijIthc+Yi5fmg
         bS2t8OhoMRvLy96ph0X0+wvy2k+Dx1a7GhaiXq8ufMrkA3O6pmsowQLvCWWG46cUmiA/
         5X85wS2l+PMuIC9409700A92aEhMP2A/8K8vmfaXgwcoh6ZPWLA1J+KnOIESUvQWfvVt
         yuqeHwAD6ex0mRcgrZWZvZiSTNdUPE9wxXUOAujpiwflINAq/XzWsz0uUSyMj/p1GKvE
         8WKV1W3se3nHY2wdt4pYl6gBWvSDMe++Dv0iAdVNw9neb9LPt2b0iKonJM41uoSeXnaS
         JxOg==
X-Gm-Message-State: AOJu0YzDAkIU+4o1dIcQGfJI2Esarl0M4VPLK25R2E6LPuD+e6MCqhAN
	Fhb4mhOyyK5v/whQkac0n1Hxs0sZEVv3J7YO3wu74w9BKqtFE2OFEFVshZlN3FtPEXbZcf17j/C
	VrGA1Zr0=
X-Gm-Gg: AR+sD13E1QhKoGK2d930sYaOLwMyvF1AOJ/b7pkSf4Trb/sen35zuoShHPzS9UWCMfW
	QWLZ4dxuwEELiTdl3f7+fGma5p7iXPXxfmgRc2JSlrfPzzfG0B/nVrAbwS4BF5F8Y9h+QbWqW3y
	AfuLEMbJIC5gRSQDyY7tFoYMii7dXNpVK6uOrqKWVoOZ0m9+xlptcfO1QMXbdHnNCFu1EElyDb+
	LtIrA1pYQV2MDTVrhh+KX1Q5EbAYJzTdUXCSggTp+64QIwtfVvU5ejvhjwFVxCvkXpx7gKn6ocN
	p2IHL5E7X3JKe7yCizPJcLLoQrNt2zAJWWXK7M+afEXCUKrJEFhvEQGPk5isf1uYQLAH4VtVNzP
	p0qeLPgchdkghIg0Clh0cwoc8QUXxrhj475g3INXdu3LLQeUiBXzqIgWupdBl804ZaMUUieaLth
	HjQyVt9S7LRRhV6zvHAuoSfWq54sA7wmj0oB3tfIJy4rcf9Kk+SqH2mxWdAGCXTRdyo3WPZD8Et
	UCHGpoEajz93WyT/80SU94pZSbbkUcIYbwOoRmQBPmSkd7ldHjDw4Ja69TIyA91bY2Z4nwxZz8i
	yyyuefveZBel
X-Received: by 2002:a05:6870:c0d4:b0:456:6097:168e with SMTP id 586e51a60fabf-45e9237b879mr7912089fac.19.1786748665005;
        Fri, 14 Aug 2026 16:04:25 -0700 (PDT)
Received: from Charro-Beans.tail0dab7.ts.net ([38.142.242.106])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45e8ff3172asm3308007fac.18.2026.08.14.16.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 16:04:24 -0700 (PDT)
From: Chad Spensky <chad@allthenticate.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Chad Spensky <chad@allthenticate.com>
Subject: [PATCH] monitor: clamp max_len in print_packet
Date: Fri, 14 Aug 2026 18:04:19 -0500
Message-ID: <20260814230419.2042327-1-chad@allthenticate.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

print_packet() derives the snprintf() bound for the packet text from the
terminal width and never bounds it against the space left in line[]:

	char line[LINE_MAX], ts_str[96], pid_str[140];
	int col = num_columns();
	...
	int max_len = col - len - extra_len - ts_len - 3;

	if (max_len <= 0) {
		extra = NULL;
		max_len = col - len - ts_len - 3;
	}

	n = snprintf(line + pos, max_len + 1, "%s%s",
					label ? ": " : "", text);

max_len can leave range in both directions, and either aborts under
_FORTIFY_SOURCE with "*** buffer overflow detected ***: terminated":

 - The existing max_len <= 0 recovery drops extra and recomputes, but if
   the prefix alone exceeds the column budget the result is still
   negative, and max_len + 1 then underflows when converted to size_t.
   len includes the "comm[pid]: " prefix built from struct ucred, which
   is only present when reading from the monitor socket, so this is
   reachable at ordinary widths. On a host with a large kernel.pid_max
   the pid is 7 digits, so a long process name plus a long label is
   enough and btmon dies mid-capture. Replaying the same traffic from a
   btsnoop file never reproduces it, because there is no ucred and hence
   no prefix.

 - col larger than sizeof(line) makes max_len + 1 exceed the remaining
   buffer. LINE_MAX raised the bar but did not remove it.

A negative max_len is also used to index line[] when truncating the
text, writing before the start of the buffer, so this is an
out-of-bounds write and not only an abort.

The check only triggers at _FORTIFY_SOURCE=3; at =2 the runtime pos
offset defeats __builtin_object_size and the check is elided, which is
why this is mostly seen on distributions defaulting to =3.

Clamp max_len to the space remaining in line[], and only write the
ellipsis when there is room for it.

Reproduced and verified by building the current logic and the patched
logic with -O2 -D_FORTIFY_SOURCE=3 and replaying a capture at a range of
terminal widths:

	cols   before   after
	  10   abort    ok
	  20   abort    ok
	  40   abort    ok
	  80   ok       ok
	 200   ok       ok
	2000   ok       ok
	3000   abort    ok
	5000   abort    ok

Reported-at: https://github.com/bluez/bluez/issues/1104
---
 monitor/packet.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 0d3b23cc3..df6c0a819 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -603,13 +603,26 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
 			max_len = col - len - ts_len - 3;
 		}
 
+		/* col comes from the terminal and len includes the optional
+		 * "comm[pid]: " prefix, so max_len can still be negative
+		 * here, or larger than the space left in line[]. Both
+		 * overflow the snprintf below, and a negative value also
+		 * indexes before line[].
+		 */
+		if (max_len > (int) sizeof(line) - pos - 1)
+			max_len = (int) sizeof(line) - pos - 1;
+		if (max_len < 0)
+			max_len = 0;
+
 		n = snprintf(line + pos, max_len + 1, "%s%s",
 						label ? ": " : "", text);
 		if (n > max_len) {
-			line[pos + max_len - 1] = '.';
-			line[pos + max_len - 2] = '.';
-			if (line[pos + max_len - 3] == ' ')
-				line[pos + max_len - 3] = '.';
+			if (max_len >= 3) {
+				line[pos + max_len - 1] = '.';
+				line[pos + max_len - 2] = '.';
+				if (line[pos + max_len - 3] == ' ')
+					line[pos + max_len - 3] = '.';
+			}
 
 			n = max_len;
 		}
-- 
2.43.0

