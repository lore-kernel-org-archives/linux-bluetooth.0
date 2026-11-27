Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795782436;
	b=P2ECZ3mhk8prw9dNmCMD4KbHaBH/SsIlxsn3kl0ji3zwGJNbByBjkMVxdyp9upc3/+tS
	 fAjAZ1J8LT71v2FG8RXQgqtfT+U9h8xwAAb1rTBdiIEJU2L/4nYPMQHgmasU9roX1X5BN
	 ABsrxpuW0IxCzfw9JI+fqrKcjPNzb8syMWRG8jjpygH2IeHLLlkrFbAfP3o9LFITVI3R6
	 NOccYKxxR9HUTFaRY+tq3IToiOyq8HvWpUT3tue+d0cQm37h6hWEzvs/fWIviG4MKErMG
	 WVZ24sfgys/XaVWcQwHnvLifdMKSoRrYbZCwzYRS6g7drNyO05Iewc24m0ccP88UQfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ygqqbAshNaRZQXcIlH/IlH9uF7tgQ2T+0CvynnyUrT4=;
	b=xme656DyDHEpnbb3cP9hsfSrTo9aBDoxxknnvEk/yUwtXJytc8PRhdMYRVdcxVUnOp4h
	 eAALTL9d8/ufUsDyXbohzw9YCK03RXZgTqXLKX6kgpAVf3kHodvukGS5G08wWS4gsQ+bk
	 4HjX7FdUcGGnufEnusrEkOQHgl6nJ2T8XjQfCF/fyOrVja3mqMrCJ79fiItwEjjlSSRNB
	 ROjDgX7iqS39d9GaHmpws1wHQzJ6spN4OKBCAFQih3GWSMde+KSvEHFPxyGzdJ6Z57O8n
	 D8GJYfwOW8tQkLdsGQWKA0NtziHo569Wl86RCrozeCrkL8CUroUQSD6kZVdBckanGFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=RSI9AeKY;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4AF606A32D
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 12:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE4AF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=RSI9AeKY
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4a357b1c649so4643207f8f.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 04:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795782434; x=1796387234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ygqqbAshNaRZQXcIlH/IlH9uF7tgQ2T+0CvynnyUrT4=;
        b=RSI9AeKYHpcde44Uf2LoK63hBWUStea6PvCeCC7VDK2tmVI6C+faKcesTFqOeQll11
         I57vRADWRekSwPn/17Q3WPKJdugWK08uqf/2SVuDroKRN5ahkBTzeBIoydQCeMfqXNcB
         jjD8vc/kYuynavNt1RNHHePXN0nmJyRLRzQ8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795782434; x=1796387234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ygqqbAshNaRZQXcIlH/IlH9uF7tgQ2T+0CvynnyUrT4=;
        b=0Sj4AvR9BX6OlkvS8zyg0AfqNTdZio3SJywJmT2f9trYpT5SZxJ4n636SvHnJr2o6O
         pucPP8YOB3+DT6YklSwg2QmJ0ZWZMMM/K8BLjMRwuP9jyD0Q4rE8TW4QIU6t9eEXNkE1
         upK7ol+cIQ74Vk8+Ab1KyZRF5I8+rVR0GLDzbOPrrI9f5IaKiJFIPbUdq9S7lqyu62wI
         AV04mjMKI8/hkflY9DxwlkmD4+eYHJnf6m48HP1Pc4FHUykSdOtnZEYabLnMCaC3IJKW
         iCmCJo8kXKoFocKm8pZktxcDqEG+HfhOvSn40L0qYSDu/nDL+v1Pt1hBBB4DFqOFLAo5
         pveQ==
X-Gm-Message-State: APuU4Z851kIMZUj0iHK+AyCZZYD6mtn5iH/CoOcEpa1ZjxDuU49QYefW
	xZOC64OgbUzXuvLK6s80G7vdsdlnnFgRg3rYitEkjUqp5hoiQgl5RTJtQVdhwKA67acogC86Eww
	24GGR
X-Gm-Gg: AZFdTZfmSqY/FV4l3LHWTNi9NWNEHq3oVE8QDElvieos/FhB7trwA60wLL6PaBt0EdZ
	qsAUJtX++ej9Xkytn4fxw7QlGYZ/LE4aP7GstnAaVRuSjHW9992j9ezyrZABVE7NIRi2y3rwi2O
	XevWfDMrX/LcuBEj7nh3mF2EMxuV/xiQM2WvP/3QHN1jUbz1IhkEjiPLveqweWPcwE/ksvXf4Hf
	C3X37IBSUVL2DD7FSp+NCmjfUASUwEbdTOHKHSeBLZcVC8aEMrwxhdrlkGC1MgWgSE0Ea+5oUPI
	d3dsDiv3HCO2fhym2Prbm6L2E3B/pcCzFtZOed9nxb6sHDAHg48z4HLFcoznkC/33B6rKwbuO18
	1UYRmF+PmXvjwPpP2riIeIMZrh8ztqs2w3EFZrBFqhVCeWci+umA66kbCWkxTpi+/sdfCck77fx
	+aaDJN+PjlkUKTzYtHa8v+lbLGKcAOQtHN6QAfcnPH4cwvtHcnEpQUZTcIHA/AezE0Q7kiyak/i
	ZdcHAMXsRN7GjI3Ow0Ox90KTz/xX3SQ7XkPoEKtvvNprM2CQq7tlAt3/cIAoa5d6KHA0eyEj0Jo
	U9UlaefsOt5LpDyPElleebtCKWjKlWubfg+wBRZvk4c6gafOcQ==
X-Received: by 2002:a05:6000:1a8f:b0:4ae:43e9:da61 with SMTP id ffacd0b85a97d-4ae43e9daa2mr43351037f8f.4.1795782434031;
        Fri, 27 Nov 2026 04:27:14 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:1a97:1eed:9575:b56f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b1ebsm48053420f8f.33.2026.11.27.04.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 04:27:13 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 3/3] l2test: Add -k to open several enhanced credit based channels
Date: Fri, 27 Nov 2026 13:27:05 +0100
Message-ID: <20261127122705.2393602-4-simon.mikuda@streamunlimited.com>
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

With -k num, l2test connects num channels in one
L2CAP_ECRED_CONN_REQ, or accepts num channels on one listener. The
first ones are connected with deferred setup, so the kernel puts them
into the request of the last one. The mode runs on the last channel and
the others stay open while it does.

Separate l2test processes cannot do this: the kernel only bundles the
deferred channels of one process.

    l2test -n -X ext-flowctl -V le_public -P 0x80 -k 2 <bdaddr>

Assisted-by: Claude:claude-opus-5-5
---
 tools/l2test.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index e0149c89e..c432296a3 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -121,6 +121,7 @@ static int reliable = 0;
 static int timestamp = 0;
 static int defer_setup = 0;
 static bool stdin_frames;
+static int num_chans = 1;
 static int priority = -1;
 static int rcvbuf = 0;
 static int32_t phy = -1;
@@ -536,6 +537,11 @@ static int do_connect(char *svr)
 	struct l2cap_options opts;
 	socklen_t optlen;
 	int sk, opt;
+	/* All but the last of -k channels are deferred: the kernel puts them
+	 * into the connection request of the last one (enhanced credit based
+	 * mode), and they stay open while its mode runs.
+	 */
+	bool defer = num_chans > 1;
 
 	/* Create socket */
 	sk = socket(PF_BLUETOOTH, socktype, BTPROTO_L2CAP);
@@ -655,12 +661,31 @@ static int do_connect(char *svr)
 	else
 		goto error;
 
-	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0 ) {
+	if (defer) {
+		opt = 1;
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP, &opt,
+							sizeof(opt)) < 0) {
+			syslog(LOG_ERR, "Can't enable deferred setup: %s (%d)",
+							strerror(errno), errno);
+			goto error;
+		}
+
+		/* Or connect() waits for a request that is not sent yet */
+		fcntl(sk, F_SETFL, fcntl(sk, F_GETFL) | O_NONBLOCK);
+	}
+
+	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0 &&
+				!(defer && errno == EINPROGRESS)) {
 		syslog(LOG_ERR, "Can't connect: %s (%d)",
 							strerror(errno), errno);
 		goto error;
 	}
 
+	if (defer) {
+		num_chans--;
+		return do_connect(svr);
+	}
+
 	/* Get current options */
 	if (getopts(sk, &opts, true) < 0) {
 		syslog(LOG_ERR, "Can't get L2CAP options: %s (%d)",
@@ -686,7 +711,7 @@ static void do_listen(void (*handler)(int sk))
 	struct sockaddr_l2 addr;
 	struct l2cap_options opts;
 	socklen_t optlen;
-	int sk, nsk, opt;
+	int sk, nsk, opt, accepted = 0;
 
 	/* Create socket */
 	sk = socket(PF_BLUETOOTH, socktype, BTPROTO_L2CAP);
@@ -807,6 +832,11 @@ static void do_listen(void (*handler)(int sk))
 							strerror(errno), errno);
 			goto error;
 		}
+
+		/* The first -k channels stay open, the mode runs on the last */
+		if (++accepted < num_chans)
+			continue;
+
 		if (fork()) {
 			/* Parent */
 			close(nsk);
@@ -1474,6 +1504,8 @@ static void usage(void)
 		"\t[-I imtu] [-O omtu]\n"
 		"\t[-j] send -N frames for each line on stdin (or as many as\n"
 		"\t   the line says)\n"
+		"\t[-k num] num channels (ext-flowctl): connected in one\n"
+		"\t   request, or accepted; the mode runs on the last one\n"
 		"\t[-L seconds] enable SO_LINGER\n"
 		"\t[-W seconds] enable deferred setup\n"
 		"\t   0: don't enable (default)\n"
@@ -1512,7 +1544,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt = getopt(argc, argv, "a:b:cde:f:g:i:jmnpqrstuwxyz"
+	while ((opt = getopt(argc, argv, "a:b:cde:f:g:i:jk:mnpqrstuwxyz"
 		"AB:C:D:EF:GH:I:J:K:L:MN:O:P:Q:RSTUV:W:X:Y:Z:")) != EOF) {
 		switch (opt) {
 		case 'r':
@@ -1587,6 +1619,10 @@ int main(int argc, char *argv[])
 			stdin_frames = true;
 			break;
 
+		case 'k':
+			num_chans = atoi(optarg);
+			break;
+
 		case 'i':
 			if (!strncasecmp(optarg, "hci", 3))
 				hci_devba(atoi(optarg + 3), &bdaddr);
-- 
2.43.0

