Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531612;
	b=NZTHMdgX+aD1Nh1x572cQIl3gp7fsZf/UcNlswKYXx87v+7DkTq/aMesXoFZarijFr80
	 N4uBdvemvQXgrWrw5bBVjXA5VGF9drD1ByJ5H81lSEA5iFx9niV1LH4KRZp4kG2VfifRC
	 bOd4WI9EMq6V4ViXF29POlPxP9zdcog3noNKNfpXrEDtAHzqCbDAlt2xbpIVP+lCKFGbf
	 DCa2uv76GDrVFyHs+JodiR9MspAlSsvZGrtMJgqMBn3hMp2QYHr0JqrB6b0yksCXao/8/
	 6h6aM6mRWgA1fd08Chq5YN2wecTHh9rnFMUTCyYamRnGKo3+yVC/O7QqJIWV7U9OcrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531612;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Qu4hHh6qhawkalCxCIplUfASAch41TEA9bSJn8G62Q8=;
	b=kFuCHnnUP3GyqZsvXBOYMTGAdxARHMvMv7+r9cjuS4NOBafEbQgUPG1jYSzWF11TaUH5
	 zm3/utik5QQBOUCoJOImTwyh//28eYDfZkmglnKHTVaqRPCeS6Sz34JPl6AU7uDZ8TaeK
	 egTTkQ6tptSY8MSonVUeqvgH+iSsiyJJRU4F+HSLgMEgAZeMKvU0lRbNoe6U485uAdVbE
	 0CbRS8p095yZGR4j1J8YDeOLIQGEb7dZ25heBmE4/ztGCJZE7ee8CP2ktpZeKEYqHHCNa
	 OBrro6ZBOhqSvXamLeMUWw/irOD8BjuamxkJQCSA/N5jyMlmqMJB/JUiXcL2Oeaeysw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=QFcgRVWL;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC143606A329
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 14:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC143606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=QFcgRVWL
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so3802119f8f.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 06:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795531610; x=1796136410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qu4hHh6qhawkalCxCIplUfASAch41TEA9bSJn8G62Q8=;
        b=QFcgRVWLXl5VxK23kIdMK7GCXUzZ7BYIRsB35Lrgf61vApBC1ZemOdNyfoyzLncFCd
         0X5Kwklr9x1lDPb+TNSF62GHk4X2pg/yPCqfcrOEmre13j2yNNaAymMtUX6AzhLIrQHo
         V+JN7ytCrjLsSAteOZnqZZeFPlhov6uCEYlzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795531610; x=1796136410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qu4hHh6qhawkalCxCIplUfASAch41TEA9bSJn8G62Q8=;
        b=lIifoZWf7s7EW3Zinu+mceEbMRjwcOUwE+pgvxeqMkXfsNpqDxUlguAmhP2h7GrfHL
         uDlKwlBs4LC1qjhsSBEM1dcsdQnnzOQ84SZL2r9pL4Zujhc1fWNApDTYSHAqWQh2SXmg
         32eCUJRUVXF3hCaqKzFxdyRJNWM7ngVgE+j506YhbajVy/2h6mWxFZTepWBGChigZlFf
         FGwvpwxHwwhcxdcxXBZ0s0EyJjsy5nKMY8xiXzNKcbzNyx8Va6puNxv7N5LBmYth9QeQ
         WDnjrtOXM3wGZwuMvhS1ePqpzjbuNWFpuzbk0GdalBqyPRjA8jXSwPEeSl5u/LkpN9cf
         6WKQ==
X-Gm-Message-State: APuU4Z/nHZRB+ZdfDT5XDYKPJsD3hdHv+P5LDl81XlMywDQV119byG1p
	5JxPgOdhfTntIRRdlWXsssNTT+DkqcijdK4h/y4VcUJKBJT1w6bxOGYlj5stLooAr8x7tUEqd49
	jY9qI
X-Gm-Gg: AZFdTZeTE/DSZHzIer6YhkSGoTVn8GBdhHSUZIgmRr+5T2rVNlluSsNGdOOQWANqnRb
	O5gYgpFGC7ufRGbwddEa/9sETAKyBgddrXBJAsT0Dn4z14HVAaBZA9q9Xzkrjhgm86YjqWYo3YK
	oB9RN6c/p5VcFtFhmH/adY7M9/rcvyzh/JJoibyUKSBGf2lUVg9KuD+h1loHLkhOPTrn1XnINHN
	jezdEuh4Qd0tWVpm+L/ImOnzxu89+8KqR7ved9F2PTON3d6tsntu/Imo9noxKhO5KhDlJiYyn1M
	5Ui/JY0Xw813FSIj5MvNlT5HGVgVIgC16PBU6lV3yiT/pdihyuaTGI468ndIks/5Sb6fYWJR3Ax
	W3gIkLVIZHmD4JokklHURP9y7eUz56hJUz+vs18t/6/NPZsuwCzdYYIilVSQY7QoX8/QlFBgdhO
	pBn2gBaxa3v2EbWX6zHKcaWmC4nrvzMN14+SzHfnoKf0kMFnz4hTc0JkIqNI2PtL2vso++F2oAT
	0RwkxV7ywPPkcm/c0+rHrWxjbsYt10bofT3RhXtX0ypP8rFn7muAij4c4kqsuUvOq8lFpSCHrxQ
	Kw38EU/EEnu0/CrKRc0305nqSG9r1r/apcSjQKgaeW04dh73rQ==
X-Received: by 2002:a05:6000:2507:b0:4b7:66fb:b092 with SMTP id ffacd0b85a97d-4b766fbb479mr4377765f8f.48.1795531610351;
        Tue, 24 Nov 2026 06:46:50 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf61e8sm29891561f8f.11.2026.11.24.06.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:46:50 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 1/8] tools/btgatt-client: Add BR/EDR support
Date: Tue, 24 Nov 2026 15:46:35 +0100
Message-ID: <20261124144642.298366-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124144642.298366-1-simon.mikuda@streamunlimited.com>
References: <20261124144642.298366-1-simon.mikuda@streamunlimited.com>
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

Add the bredr address type: btgatt-client then connects ATT over the
BR/EDR ATT PSM, and -m sets the L2CAP MTU, which is the ATT MTU there.

  btgatt-client -t bredr -d 00:11:22:33:44:55 -m 48

Assisted-by: Claude:claude-opus-5-5
---
 tools/btgatt-client.c | 53 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 667b3d651..5a2f5fc09 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -1631,8 +1631,8 @@ static void signal_cb(int signum, void *user_data)
 	}
 }
 
-static int l2cap_le_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
-									int sec)
+static int l2cap_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
+							int sec, uint16_t mtu)
 {
 	int sock;
 	struct sockaddr_l2 srcaddr, dstaddr;
@@ -1644,9 +1644,10 @@ static int l2cap_le_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
 		ba2str(src, srcaddr_str);
 		ba2str(dst, dstaddr_str);
 
-		printf("btgatt-client: Opening L2CAP LE connection on ATT "
-					"channel:\n\t src: %s\n\tdest: %s\n",
-					srcaddr_str, dstaddr_str);
+		printf("btgatt-client: Opening L2CAP %s connection on ATT "
+				"channel:\n\t src: %s\n\tdest: %s\n",
+				dst_type == BDADDR_BREDR ? "BR/EDR" : "LE",
+				srcaddr_str, dstaddr_str);
 	}
 
 	sock = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
@@ -1658,7 +1659,8 @@ static int l2cap_le_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
 	/* Set up source address */
 	memset(&srcaddr, 0, sizeof(srcaddr));
 	srcaddr.l2_family = AF_BLUETOOTH;
-	srcaddr.l2_cid = htobs(BT_ATT_CID);
+	if (dst_type != BDADDR_BREDR)
+		srcaddr.l2_cid = htobs(BT_ATT_CID);
 	srcaddr.l2_bdaddr_type = 0;
 	bacpy(&srcaddr.l2_bdaddr, src);
 
@@ -1678,10 +1680,35 @@ static int l2cap_le_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
 		return -1;
 	}
 
+	/* On BR/EDR the ATT MTU is the L2CAP MTU */
+	if (dst_type == BDADDR_BREDR && mtu) {
+		struct l2cap_options l2o;
+		socklen_t len = sizeof(l2o);
+
+		memset(&l2o, 0, sizeof(l2o));
+		if (getsockopt(sock, SOL_L2CAP, L2CAP_OPTIONS, &l2o,
+								&len) < 0) {
+			perror("Failed to get L2CAP options");
+			close(sock);
+			return -1;
+		}
+
+		l2o.imtu = mtu;
+		if (setsockopt(sock, SOL_L2CAP, L2CAP_OPTIONS, &l2o,
+								len) < 0) {
+			perror("Failed to set L2CAP MTU");
+			close(sock);
+			return -1;
+		}
+	}
+
 	/* Set up destination address */
 	memset(&dstaddr, 0, sizeof(dstaddr));
 	dstaddr.l2_family = AF_BLUETOOTH;
-	dstaddr.l2_cid = htobs(BT_ATT_CID);
+	if (dst_type == BDADDR_BREDR)
+		dstaddr.l2_psm = htobs(BT_ATT_PSM);
+	else
+		dstaddr.l2_cid = htobs(BT_ATT_CID);
 	dstaddr.l2_bdaddr_type = dst_type;
 	bacpy(&dstaddr.l2_bdaddr, dst);
 
@@ -1707,8 +1734,10 @@ static void usage(void)
 	printf("Options:\n"
 		"\t-i, --index <id>\t\tSpecify adapter index, e.g. hci0\n"
 		"\t-d, --dest <addr>\t\tSpecify the destination address\n"
-		"\t-t, --type [random|public] \tSpecify the LE address type\n"
-		"\t-m, --mtu <mtu> \t\tThe ATT MTU to use\n"
+		"\t-t, --type [random|public|bredr] \tSpecify the address "
+								"type\n"
+		"\t-m, --mtu <mtu> \t\tThe ATT MTU to use (BR/EDR: the "
+							"L2CAP MTU)\n"
 		"\t-s, --security-level <sec> \tSet security level (low|medium|"
 								"high|fips)\n"
 		"\t-v, --verbose\t\t\tEnable extra logging\n"
@@ -1783,9 +1812,11 @@ int main(int argc, char *argv[])
 				dst_type = BDADDR_LE_RANDOM;
 			else if (strcmp(optarg, "public") == 0)
 				dst_type = BDADDR_LE_PUBLIC;
+			else if (strcmp(optarg, "bredr") == 0)
+				dst_type = BDADDR_BREDR;
 			else {
 				fprintf(stderr,
-					"Allowed types: random, public\n");
+					"Allowed types: random, public, bredr\n");
 				return EXIT_FAILURE;
 			}
 			break;
@@ -1841,7 +1872,7 @@ int main(int argc, char *argv[])
 
 	mainloop_init();
 
-	fd = l2cap_le_att_connect(&src_addr, &dst_addr, dst_type, sec);
+	fd = l2cap_att_connect(&src_addr, &dst_addr, dst_type, sec, mtu);
 	if (fd < 0)
 		return EXIT_FAILURE;
 
-- 
2.43.0

