Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD942F12A5
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 02:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779761914; cv=none; b=kDSw8yy57gThDtEjkKtFj3qoNCzRt90Bf0TD57UUU1fOtkRft07rwnjFL81zEFmF1RmtKBVt4yHYqUTHO29tMKoEaCTkhc4mCF6O/qc9+oksHOQUmxiiB5DmimVxDJPdCkvjXDSmcEFg/bE9BPkL8TQMuEH+7ZFdHojcw3yLPB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779761914; c=relaxed/simple;
	bh=ugOr6h9qKSCXcCA2J2qmDK1c4p4CH4hY+NbjnHqvdDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g1xOro1c7Fe5+J3DpDMutmhhPRsBZi0XkaCsAkXXbYBwtk1SfiIPxjWRi/mE+z3EKh4PVJswlM/1axVYtbGF0AseddN3rkRIHUXF4gXYigsERRKk5eRyLhE941MJbI2SA45twU7x307qS9fciANcOZWpIXtBq2aUP0KgeXtn4Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJyEA+Fu; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJyEA+Fu"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2baca4df358so62781465ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 19:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779761912; x=1780366712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xaHr4apjjXax6lzaZFsAAU5p0KUItY7eRXmilQ6CXh4=;
        b=RJyEA+FuwvFylfdlVWo6rFpJ71bFbR3ViQf4j6KV69Sg6pCf+oUtwihhm8XTdJP/5t
         apeT0x2wQxiuIkMLZLQSfOARMNqVHpFKmiFZjyPSX9z2zoOSeMMV43eQUkPBBNCdePLN
         N0NjVzJrQ2zPsw+Jb9vr5UV+iBJj7WZpa4KddUqPbNYOFQS8erAj5+j4Uw8iYVLjBH5M
         R/lI/J4oC9tK5F3YWUwJ93kGbpdmeHzDOtbuBYq1fYNEkOm2SQG9+9RcXL6TxpLrkBeS
         xr+iUimqIUxYNT1XvKLf3thnkLZmNH0ZQ+t/q/ksqoBc1LTkvSC4xAMzyYDiJvGF/A1Z
         0NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779761912; x=1780366712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaHr4apjjXax6lzaZFsAAU5p0KUItY7eRXmilQ6CXh4=;
        b=G6mh4bDxr8dS3sqLfVhwPmWNcaNQSvPkkYjztb2mZZHc+2loOX35PNy7+/tLyaJWRI
         tzeEUGBn0Z1mwMP0p8xfDebB1i3Z9GTbfvrjd/57ghK3vRJeTZ3YEha9x2e90Q4DyONb
         hNLd1GEok7ifXGmA4sE61c4bU+vJvJSHjNWLatK5jon6/V8lulD8HGaW+jN6w8D+4aPx
         jKXQBoPNHYfaF+fT3wzP9YFjM6F+T3xvW05SO0z15R7i2/4WJKklVL90hggzxSi1ds2w
         JM7HH54LVKY3g933FJJgqzmnrsjfCWdWBpI4ddjEQL/Pvq9Y9jQP9LLZNR98XmeoLeft
         7ezg==
X-Gm-Message-State: AOJu0YzBiPwKmnDNjtDu8Vsn4b+jGt3Y61yzcVTVfdduY+8FTGQP55Mp
	TQhw4OgqXlmPeBeKArBL/8Wa6XfvVC0C+mGIiIspN00yTQr5hPAoc/jGNtQPlo7p
X-Gm-Gg: Acq92OEhxgBNlsRIYn7GoxS46D2/lEElkyawOoUR8yCPBV3PwqlVbbo5h+OdKurPwzc
	rct/CLZZ1CLBjfRs2SJ5dIZSBNtbuT+g0sjzm6rEKSbm8WcMr6MVnuKdMDWByUkTDzerMhzvoFS
	MoOkie2PiIltmr61MG2qiREsOfb6kiHD2smF4cFWDKkHBW7USGs/ZBzUgQ9ft7FQnWy8t8nEdGd
	IOwStr45kKVQEXb0uLxKgueMjVdfRPrZwZC9gqvNnHMKTnAezHemzi3cemlys4hnnbB8Z1YRLAt
	qtbQS3TkUs8gM+zDdhz55cMpAlXJZQMSwawiH3wPqEBz7EXgiV2/NE5FY6v7UQhoyX7S8wLQqt9
	ZgRC3QNUBx8TlwW2NcvA87UWQ8h11vBUsjv7GvO1k6vR7AetcfRcXX1OpTX5HkUtCX9D9ECuiqy
	s9MTXPrwNX9PmkJpUIywQYSshjc0RD2ihlkB81OF4OBL2sRWezwOApCYNd3P7ikyjkSvJXtvwvU
	FhebAuLPNjVDohXGiaMNRcB6jwBQsydmuOgFmA6fxL7taCqa7blfmJkE3otz5YXqh1wS3j8Bw49
	eNmFlEyTq04wNL8=
X-Received: by 2002:a17:903:196b:b0:2ba:6ebe:4897 with SMTP id d9443c01a7336-2beb069a893mr171232725ad.3.1779761912481;
        Mon, 25 May 2026 19:18:32 -0700 (PDT)
Received: from codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net ([4.240.39.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb591d07fsm112242735ad.82.2026.05.25.19.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 19:18:32 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org,
	johan.hedberg@intel.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1 1/1] Bluetooth: L2CAP: fix heap over-read in l2cap_get_conf_opt
Date: Tue, 26 May 2026 02:17:47 +0000
Message-ID: <20260526021747.31634-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_get_conf_opt() reads opt->val via a switch on opt->len (1, 2,
or 4 bytes).  opt->len is a remote-controlled u8.  All three callers
loop on (len >= L2CAP_CONF_OPT_SIZE), so the loop body executes with
as few as 2 bytes remaining.  A packet ending with opt->len=4 and
only 2 bytes left causes get_unaligned_le32(opt->val) to read 4 bytes
past the buffer before the caller can act on the return value.

Commit 7c9cbd0b5e38 ("Bluetooth: Verify that l2cap_get_conf_opt
provides large enough buffer") added a post-call len < 0 guard in
each caller, but the over-read fires inside l2cap_get_conf_opt()
before that guard is reached.

Add a buflen parameter and validate L2CAP_CONF_OPT_SIZE + opt->len
<= buflen before any access to opt->val.  Return -EINVAL on
violation.  Update all three callers to capture the return value and
break on negative.  With the bounds check ensuring the option fits
within the remaining buffer, the post-call len < 0 check is no
longer needed and is removed.

Fixes: 7c9cbd0b5e38 ("Bluetooth: Verify that l2cap_get_conf_opt provides large enough buffer")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/bluetooth/l2cap_core.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fdccd62ccca8..6052ffb280ac 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3051,12 +3051,23 @@ static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn, u8 code,
 }
 
 static inline int l2cap_get_conf_opt(void **ptr, int *type, int *olen,
-				     unsigned long *val)
+				     unsigned long *val, size_t buflen)
 {
 	struct l2cap_conf_opt *opt = *ptr;
 	int len;
 
+	/* Guard opt->len dereference: reject if the 2-byte option header
+	 * itself does not fit in the remaining buffer.
+	 */
+	if (buflen < L2CAP_CONF_OPT_SIZE)
+		return -EINVAL;
+
 	len = L2CAP_CONF_OPT_SIZE + opt->len;
+
+	/* Reject options whose payload extends past the remaining buffer. */
+	if ((size_t)len > buflen)
+		return -EINVAL;
+
 	*ptr += len;
 
 	*type = opt->type;
@@ -3437,9 +3448,11 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 	BT_DBG("chan %p", chan);
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
-		len -= l2cap_get_conf_opt(&req, &type, &olen, &val);
-		if (len < 0)
+		int optlen = l2cap_get_conf_opt(&req, &type, &olen, &val, len);
+
+		if (optlen < 0)
 			break;
+		len -= optlen;
 
 		hint  = type & L2CAP_CONF_HINT;
 		type &= L2CAP_CONF_MASK;
@@ -3675,9 +3688,11 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 	BT_DBG("chan %p, rsp %p, len %d, req %p", chan, rsp, len, data);
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
-		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
-		if (len < 0)
+		int optlen = l2cap_get_conf_opt(&rsp, &type, &olen, &val, len);
+
+		if (optlen < 0)
 			break;
+		len -= optlen;
 
 		switch (type) {
 		case L2CAP_CONF_MTU:
@@ -3946,9 +3961,11 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
 		return;
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
-		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
-		if (len < 0)
+		int optlen = l2cap_get_conf_opt(&rsp, &type, &olen, &val, len);
+
+		if (optlen < 0)
 			break;
+		len -= optlen;
 
 		switch (type) {
 		case L2CAP_CONF_RFC:
-- 
2.53.0

