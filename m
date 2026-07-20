Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398F93ABD98
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 05:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784526079; cv=none; b=qJlOcBh7plsw8SwVZ6jAbjMqdoeoBZ8Xd1men2vujeaxjGDCtwSz3xz+GBSNw6NAcvJAl+0fu2pe8E9+8QgVoXwGPfi4pkX+Jz5R2bwvDQXpCrMMfAXeRebwYrwOiIDiM/gWoj+f1Hokh82bdZNvKofERIYs1KL2ddS8ThjYE8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784526079; c=relaxed/simple;
	bh=lwiXfjfUKEHXZi4B4kKfIfJrjjpe4raYF4jNDfW3e+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iH01EpXuSgNP+rDxhTr/E+qUnmOpInzOfXiM9hza8wCYgyEV9zhg8POQOjwpzfPW8m1m2mpQZGu4tuGFhTP4hUORR/3XHZf5rLkaZRMWrSm7CojmZnc2MP/iPkMxxJxvVuLUcoGTHMs2cOHCWx/lJ9ozeiIlDYB6EqJeqtGQ7ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T5hQDEDr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZOqe7lMT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T5hQDEDr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZOqe7lMT"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNtNaO850964
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 05:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FXpi8RoL2PDBEL+46+twASkEuplplOrhadxaLnmvXFQ=; b=T5hQDEDrf0KwL/Lm
	xLFxjwLA/KtYASTIkuIBb4vthpmbKlTDO7fuEewqmj561n2LgfT8zDYJ1B8DmWwz
	ubF+tWscdV/FkoqQe9KC+2w83f8SXZS/Z/mRXSiKVMIw69MV0qJ78ePIKX5HbNuT
	X7ebw4OF3B7er+/SReufj1yQGh5FopqADYP+rovRw2wz/pe1ycDmh38wiG/X/EkJ
	wH9zLha5l9hiZKp+u77GI7jpq3yCTBiiKI/NMgXIdvV/Ln4EZ4tT1ErEM0Q6/uDu
	wRrD/0YI9+g6rjn3Hr0CXhzkkyrapaExRevUKS+4T+IuPGnxu/IEZwXfsSTp5JTh
	UFLDPg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2dc4jax-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 05:41:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cae7a8b9easo22355545ad.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jul 2026 22:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784526076; x=1785130876; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FXpi8RoL2PDBEL+46+twASkEuplplOrhadxaLnmvXFQ=;
        b=ZOqe7lMTi/LKd/H+KritvS8dE9WorXwX/JhG+VcabrTC6PBEf2TLuL5rQV1zGXMj5B
         vr8oWxar8TUE/DFYMG6PGAbWRLvfkX3GjSKvnKXRWe62pn1ozAN0mYLbs1C1WS7fTJZe
         nJ4rFjG/fg/4xAcVkiIpBT0fJH0wtnAZxnWQXTsJRcku1tM0WJWweOJmPNLVtO4YXFVx
         i+Gws/WcXspc33Nr6EFQkEcqMV3KCgDHoS8WE4/QRdeVLAqmurynrgvgobsQBxcYet31
         f8q+eDZEL8w6k6ZstmJPBzAMfrccQeXBF3WOB2pIBY5Nnw8iz7EcniQXFolyw8wGzjD7
         TCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784526076; x=1785130876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FXpi8RoL2PDBEL+46+twASkEuplplOrhadxaLnmvXFQ=;
        b=jd0ZNpUDFSnvjh4Y0UQYSpmdrMrvRlfOozsGootX8f00wYs5zp6nuMOs0vZup95t5h
         Fw8lHrcadZCbGWcWhiTLMy7pqQnpiACs+1VPsW+sm6dw7s75bKaL8nMGQVKqzh1vIAAt
         2XZc7+vNpUltJ/mLT3K1/njmvb96zsebpBzDU7BDWAn9NDk8sZc2awogETxT53MtB+OF
         qVtdfwKo2m/7RqBxYxwrwbOqUOqV6+7t0WJnDolggIfGmmRiaBIoP7LHHfiY8bFgVTxq
         PVIMbUuYRuIpsbW72h1OjdXt2JTtlw6ZiOfXpBU+K+YwHzxwEf+EjMm5DGa0INa7Zy38
         Z3XA==
X-Forwarded-Encrypted: i=1; AHgh+RoXECpTKeY9p+23vApj2FOEjOfP2lc46f62eWGuCeIrD9Zsr5dg/B0PQq4vb0IEHiB8FNyGxIDjkP+rN5QrjI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0xzRerKBDhaeJANMsyAdvLmcqHjtatHIEtPKGoKuQ/zVjL/M1
	22byFwE7BU/P+C4ZNnZJFsZ8HaVbPGC22QC9e+uPipBZb+iwRwYEAJChh892RSEA7ZADZJ1zw/3
	wIktyxC+bU01ckBtdVVELT4SwJzW/Z8T6zmAwWEQA8Zmdboa/bho2F/ERJLhURyynTV88MEI=
X-Gm-Gg: AfdE7cnVuZT/aIl+zB6kmEVSDokoz32UZW6relTEvLp8KICpUZLH+3FMiznT3tGUt+R
	VDrLVTLv22VWDE9VDGbve3Y2txEZ5UahNc6iZLBgpVQjL7ZHftX8r0KRsy0U//5Z5jWF6oJcxPY
	AHYAaQoz8tcYwad353WBV51YcNxOnowulNHKKdU/6Ze6Zi7/jrleTKBVjWZ+o0v59JUvIt9EXKh
	Bi5lCj5i6s/QoDQ8gr5cLdIok/L/h8QCswtB5ffEzGJfNxuFWFlMCVTzRykwFnizRepPT7g6pCa
	whImXtnFDVUoSdbGW7xEjbHlAZMOCD5qWey6EmUkJNEV68oMOKpjgSTBftWX4gYXzFnxmcLyukq
	pYn2inq6ap721ndQe657XuCJBRPhbVjDZ2H+BstCwV9U91sk=
X-Received: by 2002:a17:902:f684:b0:2c9:ed4a:c3a4 with SMTP id d9443c01a7336-2cf34652e9emr107222305ad.0.1784526075876;
        Sun, 19 Jul 2026 22:41:15 -0700 (PDT)
X-Received: by 2002:a17:902:f684:b0:2c9:ed4a:c3a4 with SMTP id d9443c01a7336-2cf34652e9emr107222195ad.0.1784526075421;
        Sun, 19 Jul 2026 22:41:15 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1de301sm31907340eec.24.2026.07.19.22.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 22:41:14 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sun, 19 Jul 2026 22:40:52 -0700
Subject: [PATCH bluez RFC 3/3] monitor: Add generic support for vendor HCI
 frames
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-vendor_hci-v1-3-df2ac5a50117@oss.qualcomm.com>
References: <20260719-vendor_hci-v1-0-df2ac5a50117@oss.qualcomm.com>
In-Reply-To: <20260719-vendor_hci-v1-0-df2ac5a50117@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA2MCBTYWx0ZWRfXwRcWsgf3zqYo
 2gjVN+w/f5ZjlgwdCiPPRMRAAJBzH+EGfbZDDJVDZM33JD9+XhKEXW0Um+wVB0KaBlLzbYCZOp7
 5wS2HDVuejXjXa8Qo9jmNyQ/AvOEl48=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA2MCBTYWx0ZWRfX6N+G04CE1hnH
 7+WP7k/b3N3r7+an6dERQ4m1OvUKhJZOxRPnc5ZLZ1+cXMf86gxpgpO3GniTOsDmyQricqFIInB
 iTzbcod/7a7zW5iCQ6hwKWgV7tbyk1cFRgsaIetghJlYhx5284N2sq96UEwW89Ph2XG0sppwf2/
 aBIi0PBBmOJm3qUIpuT2BaW8bDuRmnACeX+JOTWYeGjJKGUubwjtKCY51XqyRPIs0t+RYsC1+Aj
 vOtX/WC+L2UA7h8icKiS56NkO3ERPwLVm44Ila37g7VWk5zNVkv6qJNRmqB2LCc+aB8/DKOACi7
 4tmc4AQP/iEOKkP4oGqGt4pAItJGqkrb4xETFm1V7NRY6zY6k0yxS7bUoFwK5qnYlFXAGkd8y+T
 SeZ6Nws1SXHwv/Csg1LYmnzzClvGlSUZva9N8lhVs0twYjd0FJusafp5VSn7f/Gr+fdUdELrnPD
 1kQSGoGq9BDru86QcDg==
X-Proofpoint-ORIG-GUID: 4Pj0liEMbSimbT42K9UPL1ynmE_4R80v
X-Proofpoint-GUID: 4Pj0liEMbSimbT42K9UPL1ynmE_4R80v
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a5db4fc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=UeQ__C3DH6AKkF13xvQA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200060

To show vendor HCI frames.
---
 doc/btsnoop-protocol.rst |  8 ++++++++
 monitor/analyze.c        | 23 +++++++++++++++++++++++
 monitor/packet.c         | 26 ++++++++++++++++++++++++++
 monitor/packet.h         |  2 ++
 src/shared/btsnoop.h     |  2 ++
 5 files changed, 61 insertions(+)

diff --git a/doc/btsnoop-protocol.rst b/doc/btsnoop-protocol.rst
index a875db63a9dd..81cd8fdc71ae 100644
--- a/doc/btsnoop-protocol.rst
+++ b/doc/btsnoop-protocol.rst
@@ -116,6 +116,14 @@ values match the definitions in ``src/shared/btsnoop.h``.
      - 19
      - 0x0013
      - Incoming ISO packet
+   * - BTSNOOP_OPCODE_VENDOR_TX_PKT
+     - 22
+     - 0x0016
+     - Outgoing vendor HCI packet
+   * - BTSNOOP_OPCODE_VENDOR_RX_PKT
+     - 23
+     - 0x0017
+     - Incoming vendor HCI packet
 
 New Index
 ---------
diff --git a/monitor/analyze.c b/monitor/analyze.c
index de9c23603a21..3fe96aaeddb0 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -45,6 +45,7 @@ struct hci_dev {
 	unsigned long num_sco;
 	unsigned long num_iso;
 	unsigned long vendor_diag;
+	unsigned long vendor_hci;
 	unsigned long system_note;
 	unsigned long user_log;
 	unsigned long ctrl_msg;
@@ -466,6 +467,7 @@ static void dev_destroy(void *data)
 	printf("  %lu SCO packets\n", dev->num_sco);
 	printf("  %lu ISO packets\n", dev->num_iso);
 	printf("  %lu vendor diagnostics\n", dev->vendor_diag);
+	printf("  %lu vendor HCI frames\n", dev->vendor_hci);
 	printf("  %lu system notes\n", dev->system_note);
 	printf("  %lu user logs\n", dev->user_log);
 	printf("  %lu control messages \n", dev->ctrl_msg);
@@ -1296,6 +1298,19 @@ static void vendor_diag(struct timeval *tv, uint16_t index,
 	dev->vendor_diag++;
 }
 
+static void vendor_hci_pkt(struct timeval *tv, uint16_t index, bool in,
+					const void *data, uint16_t size)
+{
+	struct hci_dev *dev;
+
+	dev = dev_lookup(index);
+	if (!dev)
+		return;
+
+	dev->num_hci++;
+	dev->vendor_hci++;
+}
+
 static void system_note(struct timeval *tv, uint16_t index,
 					const void *data, uint16_t size)
 {
@@ -1468,6 +1483,14 @@ void analyze_trace(const char *path)
 			num_frames++;
 			iso_pkt(&tv, index, false, buf, pktlen);
 			break;
+		case BTSNOOP_OPCODE_VENDOR_TX_PKT:
+			num_frames++;
+			vendor_hci_pkt(&tv, index, false, buf, pktlen);
+			break;
+		case BTSNOOP_OPCODE_VENDOR_RX_PKT:
+			num_frames++;
+			vendor_hci_pkt(&tv, index, true, buf, pktlen);
+			break;
 		default:
 			unknown_opcode(&tv, index, buf, pktlen);
 			break;
diff --git a/monitor/packet.c b/monitor/packet.c
index 82afef6011d2..1fd8453e2666 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -72,6 +72,7 @@
 #define COLOR_HCI_ACLDATA		COLOR_CYAN
 #define COLOR_HCI_SCODATA		COLOR_YELLOW
 #define COLOR_HCI_ISODATA		COLOR_YELLOW
+#define COLOR_VENDOR_HCI		COLOR_GREEN
 
 #define COLOR_UNKNOWN_ERROR		COLOR_WHITE_BG
 #define COLOR_UNKNOWN_FEATURE_BIT	COLOR_WHITE_BG
@@ -4528,6 +4529,12 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 	case BTSNOOP_OPCODE_ISO_RX_PKT:
 		packet_hci_isodata(tv, cred, index, true, data, size);
 		break;
+	case BTSNOOP_OPCODE_VENDOR_TX_PKT:
+		packet_vendor_hci(tv, cred, index, false, data, size);
+		break;
+	case BTSNOOP_OPCODE_VENDOR_RX_PKT:
+		packet_vendor_hci(tv, cred, index, true, data, size);
+		break;
 	case BTSNOOP_OPCODE_OPEN_INDEX:
 		if (index < MAX_INDEX)
 			addr2str(index_list[index].bdaddr, str);
@@ -14655,6 +14662,25 @@ malformed:
 	packet_hexdump(data, size);
 }
 
+void packet_vendor_hci(struct timeval *tv, struct ucred *cred, uint16_t index,
+				bool in, const void *data, uint16_t size)
+{
+	char extra_str[16];
+
+	if (index >= MAX_INDEX) {
+		print_field("Invalid index (%d).", index);
+		return;
+	}
+
+	index_list[index].frame++;
+
+	sprintf(extra_str, "(len %d)", size);
+	print_packet(tv, cred, in ? '>' : '<', index, NULL, COLOR_VENDOR_HCI,
+				"Vendor HCI Frame", NULL, extra_str);
+
+	packet_hexdump(data, size);
+}
+
 void packet_ctrl_open(struct timeval *tv, struct ucred *cred, uint16_t index,
 					const void *data, uint16_t size)
 {
diff --git a/monitor/packet.h b/monitor/packet.h
index 73a86f64b242..57debcb94bce 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -135,6 +135,8 @@ void packet_hci_scodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 				bool in, const void *data, uint16_t size);
 void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 				bool in, const void *data, uint16_t size);
+void packet_vendor_hci(struct timeval *tv, struct ucred *cred, uint16_t index,
+				bool in, const void *data, uint16_t size);
 
 void packet_ctrl_open(struct timeval *tv, struct ucred *cred, uint16_t index,
 					const void *data, uint16_t size);
diff --git a/src/shared/btsnoop.h b/src/shared/btsnoop.h
index c24755d56729..efa87a8f2971 100644
--- a/src/shared/btsnoop.h
+++ b/src/shared/btsnoop.h
@@ -42,6 +42,8 @@
 #define BTSNOOP_OPCODE_CTRL_EVENT	17
 #define BTSNOOP_OPCODE_ISO_TX_PKT	18
 #define BTSNOOP_OPCODE_ISO_RX_PKT	19
+#define BTSNOOP_OPCODE_VENDOR_TX_PKT	22
+#define BTSNOOP_OPCODE_VENDOR_RX_PKT	23
 
 #define BTSNOOP_MAX_PACKET_SIZE		(1486 + 4)
 

-- 
2.34.1

