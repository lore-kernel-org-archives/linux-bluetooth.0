Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795782435;
	b=Ad/Rmc4+iI9QBz0TKKv6S3CbIfzD+mmLJSHDTvUfaGsxD0WYlUPHwoaUjUT0W84TvJ3m
	 4zpTcis0/DyMz3SB0WB4MXnqjMh7i2dFPYd+mWyIa0X8dQJiJAtzRFrEPDUnyXdFZHxXH
	 m0u3oXOfLOYBEPugfEd9sgZq8cnnO2r3P8OxPNFdFjQP3NOhDZhpj5wGrTsQfzUBuNvwG
	 zcVRwJ5CuKcQRPDXDjhD5HhMsl6hKVpRYNGokYPFliSw5MbubkwLiEqzdPw6ZNYVSpX7z
	 pw25Ymvf592PMyhNt7/vN9sjRnl4M6AW7aygbpefHGKmW3IK0/e1iDf3eYrZOnHeufQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yENNkmY31x3X++2X3tmmsBLfXaNfduzp6BbIwefqCTI=;
	b=RLYEnus4GbnikXMErRmNmm5bxyRiYnvHKQJGVjP6e1uvfz2GNZbvCvag8vnAxjY5sdqZ
	 xMOwjw+pJ15UzLtoSkdsx9ftRXkpYy/dzEy3YXY/6ql0i9mmRzI2zOxXgQFqsUXn+m0Zf
	 X5LpznjvwJ106B155IEDdIpyjHqWHrTbf7cPYzOnC5Y+fTxPbqUxqV8h2J4dX+dtXiV0m
	 revZNoe7yKfTAc34nA5KUNoTgGTVF3jRxCjkyRICImsyh94cdZForWYRaQWaxx8XmERZV
	 0X24zlgJ1Ny3YDAHWilX+0xZ4Glbgy3gGoXFY4/Qa/yYfuQyz/YN0KtSzaTJYDER4kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=1N+6ToKL;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7A8606A330
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 12:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE7A8606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=1N+6ToKL
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-490d59c3edaso5471241f8f.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 04:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795782433; x=1796387233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yENNkmY31x3X++2X3tmmsBLfXaNfduzp6BbIwefqCTI=;
        b=1N+6ToKLQHtQzV3+jZPQTuiWYajtEbF8oKzKkDrW3lPj73WYPsPkpPTGKUY1QdgUZo
         c55Sg3petPOFbJQcVlaM0OU/7etp+2szSYBOrN1t3bpTC2kC2YbPY9p/gcIgrK5KsUjH
         DO4ifhx26zxZsqEUaWr5Kt1EA6prDGWrB4l+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795782433; x=1796387233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yENNkmY31x3X++2X3tmmsBLfXaNfduzp6BbIwefqCTI=;
        b=Ayu3lQ4VwUvRgSXm0NSM/G4NXXD66W51d60VQZUNLgP1vWGpbq4nG9+m8Rk111pidI
         lUAiHmGYhaTlrWY2tDselMl/7XhE+YMieo+T4AWAu/y47dnFj3L414YEwHnUKg6dVMgI
         CBXQGE9IAL+AdKztBXWbfYKNizGf2bZqLjj7+dkJnIYtv7/WfN/jxCTYyKSYaKiFTck3
         S8dX29tppoUiNja8CL4uDb+AGBdA2DZXhqauysG4c8pHCLkQlqU0GRpB5CeAPPZQsPvF
         iTAC02mygAh7Pu5vu2hZAFVAaCBTeIlROI9Aa1Gkj89sFi4zNSImUmKKRGPs0uuFKNC3
         jQKw==
X-Gm-Message-State: APuU4Z9gBtpt7TUo/vuSDyJz+DA7W4zRUz+zWA+7aq0TaKHesITSYZhW
	V/gvGv0ROd0gdPeWrHD9H352AFq+1RxuyMO3u9TpnirfdQnepC/EVNLLRYayIAbgSIs2VaKHKsX
	alCqa
X-Gm-Gg: AZFdTZeXbsA4Q08ZY8WgrEIAXbIIqLlgBXuJh3EZr31412PrhABmJ8NFH8bR7dzJ7Y+
	9AcH3RcFhI/L8uOf1sSTCBMgWVMGQMg8RfUlbXUMjqXWSRZ/2hwZiy3/MGzNlQ0u0voH4FcVfIl
	C3D8sn8iNivzXjNOesQEdcTWRu5UAcjAdI3Y7+a8OhHwfFkztkzCuAFfAqD/PuVc/VQ3Wq4aOlb
	ucXNvyrknMJQ2VzOd/xXoBovi/FcaWxMELcBNdUTQeLcow8J4lYm8qA2dvhbTJVRPhjFpwlHrA5
	ukmpzhdnMxFwtw61/JsKTHQq3jaMatqSC/Qz/33ZEKbqAr3mVoB07q5PMi5PIo4XY/+6wz/QE8S
	Q9wJETL2dpjS6yA+WJy3184JBl39YWwglGGw9llcBHkH5V6FpORONK0lZ5LkQnZY4pwvPWDS4W1
	ttk74IhsvT2oZSb1nMGZouew+tx+L1xmqz1OF4FbWpcg175DqUeoxDjOEHzkaURipjnU+iKX5jT
	AxYCfH2mVfSLaOgA9fXibqI7dczYC9ijAYfXkmmfnTiL64o4qTjSSTp8HeY4wxeretgqHMxS3TE
	Ig3Z1lfuLqHNVfhIt/qfW3Pxuoc2E2k78kjqYY4gpRi00EAkpg==
X-Received: by 2002:a05:6000:40ce:b0:488:8347:a110 with SMTP id ffacd0b85a97d-4abafd02fa0mr51503578f8f.7.1795782433239;
        Fri, 27 Nov 2026 04:27:13 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:1a97:1eed:9575:b56f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b1ebsm48053420f8f.33.2026.11.27.04.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 04:27:12 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 2/3] l2test: Add -j to send a burst for each line on stdin
Date: Fri, 27 Nov 2026 13:27:04 +0100
Message-ID: <20261127122705.2393602-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127122705.2393602-1-simon.mikuda@streamunlimited.com>
References: <20261127122705.2393602-1-simon.mikuda@streamunlimited.com>
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

With -j, a sending mode waits for a line on stdin before each burst
and sends as many frames as the line says, or -N's when it has no
number. A tester can then ask for data when it is ready for it, for
example after it reconfigured the channel:

    echo 2 | l2test -w -X ext-flowctl -V le_public -j

Assisted-by: Claude:claude-opus-5-5
---
 tools/l2test.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index dbfeae50a..e0149c89e 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -120,6 +120,7 @@ static int linger = 0;
 static int reliable = 0;
 static int timestamp = 0;
 static int defer_setup = 0;
+static bool stdin_frames;
 static int priority = -1;
 static int rcvbuf = 0;
 static int32_t phy = -1;
@@ -1078,7 +1079,7 @@ static void do_send(int sk)
 	/* Without -b each frame is as large as the channel's MTU */
 	bool follow_mtu = data_size < 0;
 	uint32_t seq;
-	int i, fd, len, buflen, size, sent;
+	int i, fd, len, buflen, size, sent, burst;
 
 	syslog(LOG_INFO, "Sending ...");
 
@@ -1120,6 +1121,19 @@ static void do_send(int sk)
 		usleep(send_delay);
 
 	seq = seq_start;
+	burst = num_frames;
+
+next_burst:
+	/* With -j, a burst for each line: its number of frames, -N's without */
+	if (stdin_frames) {
+		char line[16];
+
+		if (!fgets(line, sizeof(line), stdin))
+			return;
+
+		num_frames = atoi(line) > 0 ? atoi(line) : burst;
+	}
+
 	while ((num_frames == -1) || (num_frames-- > 0)) {
 		if (follow_mtu)
 			data_size = omtu = current_omtu(sk);
@@ -1149,6 +1163,9 @@ static void do_send(int sk)
 						!(seq % (count + seq_start)))
 			usleep(send_delay);
 	}
+
+	if (stdin_frames)
+		goto next_burst;
 }
 
 static void send_mode(int sk)
@@ -1455,6 +1472,8 @@ static void usage(void)
 	printf("Options:\n"
 		"\t[-b bytes] [-i device] [-P psm] [-J cid]\n"
 		"\t[-I imtu] [-O omtu]\n"
+		"\t[-j] send -N frames for each line on stdin (or as many as\n"
+		"\t   the line says)\n"
 		"\t[-L seconds] enable SO_LINGER\n"
 		"\t[-W seconds] enable deferred setup\n"
 		"\t   0: don't enable (default)\n"
@@ -1493,7 +1512,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt = getopt(argc, argv, "a:b:cde:f:g:i:mnpqrstuwxyz"
+	while ((opt = getopt(argc, argv, "a:b:cde:f:g:i:jmnpqrstuwxyz"
 		"AB:C:D:EF:GH:I:J:K:L:MN:O:P:Q:RSTUV:W:X:Y:Z:")) != EOF) {
 		switch (opt) {
 		case 'r':
@@ -1564,6 +1583,10 @@ int main(int argc, char *argv[])
 			data_size = atoi(optarg);
 			break;
 
+		case 'j':
+			stdin_frames = true;
+			break;
+
 		case 'i':
 			if (!strncasecmp(optarg, "hci", 3))
 				hci_devba(atoi(optarg + 3), &bdaddr);
-- 
2.43.0

