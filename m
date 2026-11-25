Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625950;
	b=F0yFAdrhfNpbWFRe+kt9opOm3BhE4ZKDZpDCtnF8bpCoQiCF5Z/KzsthllYUn6CO+5St
	 ZJH0HEpg4sxyJwT5/xhxEVZorhWQJfUr6MtLLWUJKygNhEbCDl6r8tEzBsgqT156oxOm9
	 YwCEzK0JcYfCVpP0iCeAxarn5FgqvFGyxVvDzOlG1jLi2BqhMc/RnbDV/ojoVgUmdzkXO
	 8m2WpRR4Xzhy+UEydho/1TL5mt+8aTe5I1h9Fi51PnEpEPPzoPywV+S1l+SGwzg9UTYux
	 gpG9Vxhha9Kak5Ek1E2lPPcgNOZJwpP0lbNEh94+oYvBcuv55jTbHVrK5Ydzk0sGFSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625950;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Qu4hHh6qhawkalCxCIplUfASAch41TEA9bSJn8G62Q8=;
	b=RSme5a1RQlTWqsJrmj3dFAfSYG3Vg9q4vym/W1RxtTV2G3zpnzJvTOyErmJ/oeoCGTgl
	 wPBD+dE0eZePkx7aBs3cBlGEcfkFFx8DZaJPNi6O/Yslg9ttdpc5OPO23sX+gdni5OntI
	 EVndkOv2VLEBpl4jcShtG+rR/vUmGZW/6ruaCWx/bi8rDtYSqkiarI25OwLBR851SIIAl
	 XOcKpAwdgOgdCO4JMLA7FcNt0/TLEknWiUCxgQBAnjs2z10Ufei++3jzxJ9y8/jzZnUF8
	 GUJKfAXEgyDRbnl2kOqjrpKXJQLaEO/hNvbAJOxS6N7598heEPulTAvChXZpGTntDAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=UtLqJyuy;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E85606A330
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54E85606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=UtLqJyuy
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so38025725e9.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795625949; x=1796230749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qu4hHh6qhawkalCxCIplUfASAch41TEA9bSJn8G62Q8=;
        b=UtLqJyuybiH1JTJAUhw+cTAnsviRJhfjOycKxBXyByhxec5xVDBXuNxiOiJGjnKeHd
         d0yuTm/o1ZWpWOdaTZL6kdEmv6iSPr1T96pXNXlboEUmUJzNAdT/HVR11ALmEZ9zWG8y
         NH8QmGoWI4KQ6BkuMtIgH0wCNlaaDje7k9AhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625949; x=1796230749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qu4hHh6qhawkalCxCIplUfASAch41TEA9bSJn8G62Q8=;
        b=xEP0kjkyHS7OSouOdgQF5ij7pZfuO4TDcNMts87/nQIbrPkMd9PhUPCVxqMdhGNmkU
         /q676JSaSMaMf3l+6/G5lvB4Lj2XK85KQZBMWwgY1mzG5od9h7E9YdOZ5qcSGnnYsgl3
         0EyoQFd8gGAp61ETL5TRAbijy3mNR+FvNsKbILhAUE0u+BtTq3NlPtCHT1cHzWzAjnfX
         YptJc8wQoExWz+/LcSVZqw/nxth0zqCc0OTHdQszSSbMnDyHWOkXdp17XmaosuNR1npX
         WvbJ3YXPPi9Lf9ej0y/ddRe52Vv51wcBs0Tuz18GO0QZJRVRJAB/E2++Ow83j0+ucV/I
         FpgQ==
X-Gm-Message-State: APuU4Z+ZQyFLa5FVsJ7ipaN9uadTf9CvdWhB6ZjmmIx2ZCvPvJ40ltrs
	M7HsfsKMLGaz8Fo+HQCVXZPlnedGJPg+2WRNw/nDtMsUUTAWf/f5Z2nQJ3CcrI/jiCwFXlFSkEs
	gGnm4
X-Gm-Gg: AZFdTZcnfSDlR6VL/ESGPgce5PFMQy9wS2HXBjWN+2ZSzgn7qmwNRQ7ZLhZwrdorGQu
	62pgdoaFEoO4gQ6EXKkNdGT3dnYeoSl1zEL91yj/cikqDR+ajbRUjH6ZLJunX03fhQUjGA9NZuW
	4sPX+Otkzmzb+u4kOclMT3CePMAkKjc0jfG16FXslzdj7g94wZLOKbND2EVPLbnsKxDALwZKHpZ
	lDZtD3h7C08FAELY/mavH9SVcGpg83srCYjUm/XB7ly7YZPQykCPgJrdPS0OYPtzyYRYMAYY4hJ
	du659TvQhCX6NtWZNSBMOROiu3emq2Z+xYM2jM/YRkJmTUWhGE1WJHuCJCLXRaU1+GDP17+Fwxc
	3HqlmyJgraE6uKyQTWtJ75o3AqjGU7Rb2YVYXC1Q0bltcX2or5poOYAAgOmok199YH5+RmSBbtb
	rqRDOiKML/aMYj3nEdMHGDco8eQaZZgiyRVrp4W+fDfL4T7IlId7PJjfwWLffjuXT/agADn9Ity
	tu1DLaWwosp8YAccn9EvdcZ7G30Adyu6C6qr4jdS55xGG6OEYI8eakX+VCVco1ud32PTsX23JHa
	kVY201HcbOTML2Rw5aFB9k7IoFLM+EhVQJ6Qy/iVYAEkL6euCw==
X-Received: by 2002:a05:600c:37c6:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4bb88812a84mr370799195e9.13.1795625948716;
        Wed, 25 Nov 2026 08:59:08 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm754943945e9.13.2026.11.25.08.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:59:08 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 1/8] tools/btgatt-client: Add BR/EDR support
Date: Wed, 25 Nov 2026 17:58:59 +0100
Message-ID: <20261125165906.1645581-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125165906.1645581-1-simon.mikuda@streamunlimited.com>
References: <20261125165906.1645581-1-simon.mikuda@streamunlimited.com>
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

