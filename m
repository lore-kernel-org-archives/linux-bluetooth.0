Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3165425DCFD
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749479925; cv=none; b=jB1xEf87MWhUrwErFgjmR6v7djVaPjEk3uCsc/FWQYtuSUh0wmECagRqZL9TtDgO5CmVEiirFMIAb369hIfyBOJpuJTQOZj2YhSv0NMQuN3dGxNv3eQ7yO9CDkKx+pGuidJRkbBkBIakHEX29lzx7WiT/+kqV28N2Ijf9URAIe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749479925; c=relaxed/simple;
	bh=XLVpsgnf502PuJA/EKpENm5FX1SEnHTPOXj/uKv+kVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRzfWj6CVXYI0BCmYVk7ORhTyg1OOR9OYBQNVR1gG9yaoy9h8db79Ow5yxLjZnm67KpJKysbggyx9rMZnB0ot4SUBYzPu7fRMhbjpJVtkqiEZn54sgZtQE2klwJc1sREA/wTY2/9b08Af+fYpg64GnZll3uy8yMUBW5ELYfP4Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLxWBWhk; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLxWBWhk"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ade30256175so529524766b.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jun 2025 07:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749479922; x=1750084722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WD6gevOLd8eK8I8WfRmarBD3Imp7HhIMM16g6xn3oHQ=;
        b=VLxWBWhkV429ZXdTwFrJQI8hQvzRv84tarW9lcWqhnXKbhHECLxZLcyTQj34eq7Vr6
         xdG4VgyQz2jh1IWPSwciYoAj9LEfx5gQHw7Hl1wElL89HRapUiMfexwNN9tT5UdJQNeF
         WV0iudv9pyzfLGTOCU47Su6SxtAWmEjO5bXmSXFAoukrhf6tbM1QolxoKTD0x82LiSWf
         AsMES/fuQQdLMS/QLRxPyfZ8hj++AECKzNWYmIDFtDOXEgSps9I97c/jQjsMEPOp/aud
         +SJjR6RgtSQQk+i8Wk2tVmq0z0REt5OQhRhczFRTT7IPPzvh8rkDOThXC9OxFP6hyK/5
         pZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749479922; x=1750084722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WD6gevOLd8eK8I8WfRmarBD3Imp7HhIMM16g6xn3oHQ=;
        b=BUP40I1mr3LmEQL9hAQlUW7UizC15L6UAaPVKbd9rulrsdhBsuZ/7I80PagCLlBMA2
         39zAhwke1+mUy+QDREX33cD3nosMfn6hn13GsPZ4KtOB631PHWmT+RMuBQ8chXb5Wq+N
         X7ms+gyqxFZ+Zo7MkIKgnLuHCq4c6JlgSK6AJzMmLb7pkzcRxZRRg3OkGVLqAZlGxM13
         ElWdyIIKg0rd3uyoJJUFXbH/jtD45cCC63giglpTJz5h3LDOfM/RAbxdEmxVnyLp7tBs
         LNR66/ck/M8mpXzzkTb7mXJvYYVXXDOFaZPWvhRzApOIsypw25B5Gyp94UMaXOBcW699
         q5Pw==
X-Gm-Message-State: AOJu0YwWdy5tEDE06ADUw06FIHjcAk950Ou5BKtIpI06X7evzg+b8izP
	2N9R23vwa5YUvRKuBB39sgFsZG5TBk4XsWLaCLBvz/aysWyI92doleDxbpffkA==
X-Gm-Gg: ASbGnct0CMx0Xh6JEz0c9dCEzA/QOp1VH+OX96k7ZJndR5jI1dQYXfQQk6k96yPKbCH
	01bC91jjnBYRSTOAv5bQy/ViNLWIA/0Qwii1K4sGnozgoyljLUEyQZ/inPtTcuKdLMF/KjJqBIX
	Pn7+279C8HBVov78baCQyn3cH2mTzfCRE52e01myZFzT4WTCCO+jDgFBIPs0NxmP0FiHU5JZmqx
	H7gyOekip47YJmQfHCw4aA9OB/gHDGXlXMeMi04HB2mylb1FnvKpUimgdtgTdCplzNBY3H1jy0G
	0nOQWtvPuPZRL9o7Rgqvs2ffqLmH9D5JUUDtnXC7PoOVOcgxib1SWgpxOmyPw2P3VqH0YPrpj8d
	0+9tNJlbYd2PhhliwtJg=
X-Google-Smtp-Source: AGHT+IGiPFnq9c3pMzqiDzHLbRtCHjfkCdFpF/QgvAX6bOVws86icpQR74QXjvjfHeCLVY5qQQdCqA==
X-Received: by 2002:a17:907:9627:b0:ad2:4fa0:88cd with SMTP id a640c23a62f3a-ade1a9161d5mr1204272266b.9.1749479921920;
        Mon, 09 Jun 2025 07:38:41 -0700 (PDT)
Received: from hyperion.tail59961f.ts.net (B-228.ahl.uni-linz.ac.at. [193.171.46.128])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade34ea5adesm452017866b.80.2025.06.09.07.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 07:38:41 -0700 (PDT)
From: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
Subject: [PATCH BlueZ 4/4] emulator: server: handle ISO, use BR/EDR+LE 5.2 by default
Date: Mon,  9 Jun 2025 16:38:11 +0200
Message-ID: <20250609143811.566331-5-d3dx12.xx@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609143811.566331-1-d3dx12.xx@gmail.com>
References: <20250609143811.566331-1-d3dx12.xx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow passing of ISO packets via the socket by parsing their header.

Set version to 5.2 to expose ISO/CIS and other LE Audio related
features when using server mode.
---
 emulator/server.c | 11 +++++++++--
 lib/hci.h         |  6 ++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/emulator/server.c b/emulator/server.c
index 0ca7d42a3..d86342601 100644
--- a/emulator/server.c
+++ b/emulator/server.c
@@ -118,6 +118,7 @@ again:
 	while (count > 0) {
 		hci_command_hdr *cmd_hdr;
 		hci_acl_hdr *acl_hdr;
+		hci_iso_hdr *iso_hdr;
 
 		if (!client->pkt_data) {
 			client->pkt_type = ptr[0];
@@ -140,8 +141,14 @@ again:
 				client->pkt_data = malloc(client->pkt_expect);
 				client->pkt_len = 0;
 				break;
+			case HCI_ISODATA_PKT:
+				iso_hdr = (hci_iso_hdr*)(ptr + 1);
+				client->pkt_expect = HCI_ISO_HDR_SIZE + iso_hdr->dlen + 1;
+				client->pkt_data = malloc(client->pkt_expect);
+				client->pkt_len = 0;
+				break;
 			default:
-				printf("packet error\n");
+				printf("packet error, unknown type: %d\n", client->pkt_type);
 				return;
 			}
 
@@ -218,7 +225,7 @@ static void server_accept_callback(int fd, uint32_t events, void *user_data)
 
 	switch (server->type) {
 	case SERVER_TYPE_BREDRLE:
-		type = BTDEV_TYPE_BREDRLE;
+		type = BTDEV_TYPE_BREDRLE52;
 		break;
 	case SERVER_TYPE_BREDR:
 		type = BTDEV_TYPE_BREDR;
diff --git a/lib/hci.h b/lib/hci.h
index c39a72cef..96733efc1 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -2311,6 +2311,12 @@ typedef struct {
 } __attribute__ ((packed))	hci_msg_hdr;
 #define HCI_MSG_HDR_SIZE	6
 
+typedef struct {
+	uint16_t	handle;
+	uint16_t	dlen;
+} __attribute__ ((packed))	hci_iso_hdr;
+#define HCI_ISO_HDR_SIZE	4
+
 /* Command opcode pack/unpack */
 #define cmd_opcode_pack(ogf, ocf)	(uint16_t)((ocf & 0x03ff)|(ogf << 10))
 #define cmd_opcode_ogf(op)		(op >> 10)
-- 
2.49.0

