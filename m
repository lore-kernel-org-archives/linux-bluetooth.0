Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C1949158A
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051211; cv=none; b=JL9OKLFviy+pDa+9+FxApkzxYiBXTKAwQgBSEaKlCdO6F5KWVxQB9YKjaNYSEnnAb8Pm9kYeo8+HCvKEOLy44Vjc7BI9kNWmVN9tpTiv3i1Nz5ymQaxA9OFWIXiv543ZiboXANbpnpoh1K/1gz1lhHJ9GxAQxa3HbkYt2FYJGSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051211; c=relaxed/simple;
	bh=PAcEGguv5Ci6zow8o+tvIiIRDbV3cpTG4m7QA/uCO6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DKe0NQwXzCyb+UV7XoE8KwodzCNaT6fV24SQ98s2lKOELnhv0szexDKetE29bWB8tFF1qf2i0hokP49FyZThlrEGMLVqzhVeDA2o+xZwLb491zYhOVTiNvUX1gp4OY3weavW6+qD56o+BxTSR+MzK5I9vlXmizwkR/6hf3FwIeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pps2lZ/U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OeWOlmOd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pps2lZ/U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OeWOlmOd"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AC7kG41242024
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 14:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vapBzwkaqvpHjBwbkS1xWWGf5FLNHXEfGsLyCdSOTB4=; b=Pps2lZ/U17K2iJTX
	Gi3tLn4Q42Q5UqP/KQXFtw0xnw/1cx6IiGfE/PTz860p8sgTKoNh4rcLTilGFZkD
	AEveXhyRTHj84VPeBg/OmxnlDoxi0jSyJ8wThxO25pPDD/3Gc/wczELaC3oQEKgT
	wdTBPpx9UHiJtdAp6wP65AAucypUf07H8ozqNKRaCA4IJmE0juGe3/dcP+TJmUzt
	yaBaYcQnbL3HZ23V2Xzv3tkv6jn1fNqlkrYW2K9NRWngnVN2jKjCYLzPn+oTIlMM
	75svNbfZ8Djf7KGMjTFXk/A73u52IYQ9wIPL+4AwyNQAN8kZTMZI5Y/H/PvroVRd
	sQdXmQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkrcjstx0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 14:40:07 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e6b5a8836bso1083925a34.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 07:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789051207; x=1789656007; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vapBzwkaqvpHjBwbkS1xWWGf5FLNHXEfGsLyCdSOTB4=;
        b=OeWOlmOd11ju+bTltLF5rtoAjguhKMG649fXPKQjiyEiHNTC/bH+/9ISJNwX32rPVP
         +YA9TD74Lf9cuKsDkhlcNCIx/KPl0iLTgPIK18xE6GPW86EeVa6xb5WhtSfkDCP+s3ai
         ebmtc9/kIdiJUEOC1ojztUtdyaOd3OdGzqH6OKu7QmqSaFpwhNRjrr88zDgy5E2BfqkH
         jkj2bbCs4uzOL6tF8//wMW+aIzAgEdwlCXPjid5mGpkkRdm9EOsTrys2EP8C+QrzYpPb
         61aayVDPYa4B9tMP76rHhrtE+JsPuJ0z+gLcxD05x64qz0t4zL0bVXFWswJLzRxS5+ob
         Qp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789051207; x=1789656007;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vapBzwkaqvpHjBwbkS1xWWGf5FLNHXEfGsLyCdSOTB4=;
        b=L1yZ6MmQn8OXcWtvF46St1j+8VXi+Xkgc9z10OL/Lmu8+4jPGoX74H4nbeOL1QZwEW
         6eR/5Z+G5WC4tz1kzqS/XtP3p+DrgXu9ziglO/lcn40ITJg3sLsvbe2O1Huo45aFLz8X
         +Qwk45gpByx7h3GGsZAcROMTVxwOYWuDoi5XAWLhWFoO96Z0676p9/fq1LixLgkTCF4F
         A6pY9EAJu+c661s2948dBBS7UocEQSTJln1YnCkUpwanrHdznQa0GrI2YQZXlC+B4Mln
         Ag70kRPct0Sm7qRlDgQgJcQ+yMZb6UK7ZX2xla09xCf/S0U6e5RPrpvm1JG0xao2NlGZ
         ncnA==
X-Forwarded-Encrypted: i=1; AKwUvBzLaEVz0XcZuri3B1mtC1Y3gMfAQIG7EnBIIxIIZL+s4M+E9Jmhqnllz3l0tXvhxv8BYrB/E7ckdmFm5oENZjo=@vger.kernel.org
X-Gm-Message-State: AFuF++nt040hHxnUhTAoBQeD4uinwBmGhlAlB43/4MkELFjzuMd3aApP
	aaZR7h3+4MSf3mnxhkY+RQSdbtkKNbBU5TehJWzl6f7nC6pf78/yWKh8qYeIXGxkWtUYlVM1RFo
	8/TeNdqAUcnxA4w64VX1YVBgNMoAaoRfp+YBYGjMmltSHJgdpXash2wK3OW9CjGu8PRCa28Y=
X-Gm-Gg: AYBFou3v8trzdpAV/huRpQ/q69kPfY+pf30R0MC3ZVlfux3Ct2yw9fyAkijXVHCIM0S
	3ipb+xGNxqB9915qTZd0wpXSWoGp6FzWY74PZR21E02jPnFGJzsCCsB/LWxTt9YgmItdokOxs4h
	j3jI1IEP5nX3WmH0uljdPcdD3qeD5jnm12Br5uewfmxe1v3o3BKPeR+VMOcUiEGcmLPgPUFl6AI
	HBTu7kuB+8U74oXRgxCoHzkM+hW5dGkytwZS7vK62PVTgU7bV3HMyDTgZYDmn1QZefYcDrP1wr5
	C6DS7/78tRNYU4d5gT791OFkt6RL7poz9a9IOJcOpMnNdS6PKZdilA/aS68+xBwednN8tZCaueh
	AFikLHhhUIRApFEvB42wXejPm0VyDLGQkphPQs01d6SSikoY=
X-Received: by 2002:a05:6830:f89:b0:7ee:363d:ce16 with SMTP id 46e09a7af769-7fb76e3cd73mr18760314a34.0.1789051206595;
        Thu, 10 Sep 2026 07:40:06 -0700 (PDT)
X-Received: by 2002:a05:6830:f89:b0:7ee:363d:ce16 with SMTP id 46e09a7af769-7fb76e3cd73mr18760285a34.0.1789051206135;
        Thu, 10 Sep 2026 07:40:06 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7fa02cddc41sm20740155a34.22.2026.09.10.07.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:40:05 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 07:39:57 -0700
Subject: [PATCH BlueZ v4 3/3] monitor: Support vendor packets
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-vendor_hci-v4-3-b953ce117d12@oss.qualcomm.com>
References: <20260910-vendor_hci-v4-0-b953ce117d12@oss.qualcomm.com>
In-Reply-To: <20260910-vendor_hci-v4-0-b953ce117d12@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE3NyBTYWx0ZWRfX7sdUjliARXi1
 qHlA9rzhCp9HcxlJLfnP/M0Pe9YYhk8geLQsgRJUaLXkqhIM61Q4af2lk7tJMfq5IV/xrpPOVj+
 7xyitoJ1R+nlQAJJ6GTKWBZv5icEHks=
X-Proofpoint-GUID: zK_rZxlTgnZKutJU-7clePLQEuVnsOT1
X-Authority-Analysis: v=2.4 cv=aef0Dhot c=1 sm=1 tr=0 ts=6aa2c147 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=wKszYPmeBrtX0xbgVwQA:9 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE3NyBTYWx0ZWRfXxQO/FsJKDagN
 2p9B6UEk6265HiLORKVBscPQNNcK42114gd8NWS4GZRVxZsevXZAYe2VKXRdkQZ7+xAnm/vuJx6
 8p5kVNsc5Svhnn1V53k1jXJkUbgWJi3nP0YUezmkPVVcSseLPHP0CHIKv30SW+Kc78T0jaDGUp+
 sqGDxcUIH1GFq/IwnZQSZhskRR+q2seL/vWijINg5FpGZ21/zsqMC+FxfBMCrA8SCTP26ZOXnJd
 lNAITq4UpDAeLx5/WS6oFfZt3Zh1ZfZaq6ZmlDsKButuN9xrYXqS6NQgjscoBLp0sGS4AbPT5nz
 8zl/qNobXkiOtxQLjoc0Vh8bpdeFa6u3AN/SBLgtJuP9PPkE5uHNiHkcocqOrO9KC1DYCO1PwlW
 xKukiqKyXmHFNm49jaialNt4ep44HdRDkNplIfSk7nvvdzUwOVyfIL9m3S4uhLXimngGfF8+fvY
 Ty+1X3E9gYRfPpt0lYw==
X-Proofpoint-ORIG-GUID: zK_rZxlTgnZKutJU-7clePLQEuVnsOT1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100177

Kernel include/net/bluetooth/hci.h defines its packet type as:

  #define HCI_VENDOR_PKT  0xff

  - Defined by vendor
  - Bidirectional (RX and TX)
  - kernel <-> userspace: HCI_VENDOR_PKT followed by vendor packet
  - kernel <-> monitor: vendor packet has TX opcode (22) or RX
    opcode (23)

Support them in tool btmon.
---
 doc/btsnoop-protocol.rst |  8 ++++++++
 monitor/analyze.c        | 23 +++++++++++++++++++++++
 monitor/packet.c         | 26 ++++++++++++++++++++++++++
 monitor/packet.h         |  2 ++
 src/shared/btsnoop.h     |  2 ++
 5 files changed, 61 insertions(+)

diff --git a/doc/btsnoop-protocol.rst b/doc/btsnoop-protocol.rst
index a875db63a9dd..ba1eb858f185 100644
--- a/doc/btsnoop-protocol.rst
+++ b/doc/btsnoop-protocol.rst
@@ -111,16 +111,24 @@ values match the definitions in ``src/shared/btsnoop.h``.
    * - BTSNOOP_OPCODE_ISO_TX_PKT
      - 18
      - 0x0012
      - Outgoing ISO packet
    * - BTSNOOP_OPCODE_ISO_RX_PKT
      - 19
      - 0x0013
      - Incoming ISO packet
+   * - BTSNOOP_OPCODE_VENDOR_TX_PKT
+     - 22
+     - 0x0016
+     - Outgoing vendor packet
+   * - BTSNOOP_OPCODE_VENDOR_RX_PKT
+     - 23
+     - 0x0017
+     - Incoming vendor packet
 
 New Index
 ---------
 
 Code: 0x0000
 
 Parameters:
 
diff --git a/monitor/analyze.c b/monitor/analyze.c
index 9742981ec21a..a8bea9efc784 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -45,16 +45,17 @@ struct hci_dev {
 	struct timeval time_added;
 	struct timeval time_removed;
 	unsigned long num_hci;
 	unsigned long num_cmd;
 	unsigned long num_evt;
 	unsigned long num_acl;
 	unsigned long num_sco;
 	unsigned long num_iso;
+	unsigned long num_vendor;
 	unsigned long vendor_diag;
 	unsigned long system_note;
 	unsigned long user_log;
 	unsigned long ctrl_msg;
 	unsigned long unknown;
 	uint16_t manufacturer;
 	struct queue *conn_list;
 };
@@ -478,16 +479,17 @@ static void dev_destroy(void *data)
 	printf("\n");
 
 
 	printf("  %lu commands\n", dev->num_cmd);
 	printf("  %lu events\n", dev->num_evt);
 	printf("  %lu ACL packets\n", dev->num_acl);
 	printf("  %lu SCO packets\n", dev->num_sco);
 	printf("  %lu ISO packets\n", dev->num_iso);
+	printf("  %lu vendor packets\n", dev->num_vendor);
 	printf("  %lu vendor diagnostics\n", dev->vendor_diag);
 	printf("  %lu system notes\n", dev->system_note);
 	printf("  %lu user logs\n", dev->user_log);
 	printf("  %lu control messages \n", dev->ctrl_msg);
 	printf("  %lu unknown opcodes\n", dev->unknown);
 	queue_destroy(dev->conn_list, conn_destroy);
 	printf("\n");
 
@@ -1398,16 +1400,29 @@ static void iso_pkt(struct timeval *tv, uint16_t index, bool out,
 
 	if (out) {
 		conn_pkt_tx(conn, tv, size - sizeof(*hdr), NULL);
 	} else {
 		conn_pkt_rx(conn, tv, size - sizeof(*hdr), NULL);
 	}
 }
 
+static void vendor_pkt(struct timeval *tv, uint16_t index, bool out,
+					const void *data, uint16_t size)
+{
+	struct hci_dev *dev;
+
+	dev = dev_lookup(index);
+	if (!dev)
+		return;
+
+	dev->num_hci++;
+	dev->num_vendor++;
+}
+
 static void unknown_opcode(struct timeval *tv, uint16_t index,
 					const void *data, uint16_t size)
 {
 	struct hci_dev *dev;
 
 	dev = dev_lookup(index);
 	if (!dev)
 		return;
@@ -1504,16 +1519,24 @@ void analyze_trace(const char *path)
 		case BTSNOOP_OPCODE_ISO_TX_PKT:
 			num_frames++;
 			iso_pkt(&tv, index, true, buf, pktlen);
 			break;
 		case BTSNOOP_OPCODE_ISO_RX_PKT:
 			num_frames++;
 			iso_pkt(&tv, index, false, buf, pktlen);
 			break;
+		case BTSNOOP_OPCODE_VENDOR_TX_PKT:
+			num_frames++;
+			vendor_pkt(&tv, index, true, buf, pktlen);
+			break;
+		case BTSNOOP_OPCODE_VENDOR_RX_PKT:
+			num_frames++;
+			vendor_pkt(&tv, index, false, buf, pktlen);
+			break;
 		default:
 			unknown_opcode(&tv, index, buf, pktlen);
 			break;
 		}
 
 		num_packets++;
 	}
 
diff --git a/monitor/packet.c b/monitor/packet.c
index 058d12dd465e..39e042108c2d 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -68,16 +68,17 @@
 
 #define COLOR_HCI_COMMAND		COLOR_BLUE
 #define COLOR_HCI_COMMAND_UNKNOWN	COLOR_WHITE_BG
 #define COLOR_HCI_EVENT			COLOR_MAGENTA
 #define COLOR_HCI_EVENT_UNKNOWN		COLOR_WHITE_BG
 #define COLOR_HCI_ACLDATA		COLOR_CYAN
 #define COLOR_HCI_SCODATA		COLOR_YELLOW
 #define COLOR_HCI_ISODATA		COLOR_YELLOW
+#define COLOR_HCI_VENDOR		COLOR_GREEN
 
 #define COLOR_UNKNOWN_ERROR		COLOR_WHITE_BG
 #define COLOR_UNKNOWN_FEATURE_BIT	COLOR_WHITE_BG
 #define COLOR_UNKNOWN_COMMAND_BIT	COLOR_WHITE_BG
 #define COLOR_UNKNOWN_EVENT_MASK	COLOR_WHITE_BG
 #define COLOR_UNKNOWN_LE_STATES		COLOR_WHITE_BG
 #define COLOR_UNKNOWN_SERVICE_CLASS	COLOR_WHITE_BG
 #define COLOR_UNKNOWN_PKT_TYPE_BIT	COLOR_WHITE_BG
@@ -4527,16 +4528,22 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 		packet_hci_scodata(tv, cred, index, true, data, size);
 		break;
 	case BTSNOOP_OPCODE_ISO_TX_PKT:
 		packet_hci_isodata(tv, cred, index, false, data, size);
 		break;
 	case BTSNOOP_OPCODE_ISO_RX_PKT:
 		packet_hci_isodata(tv, cred, index, true, data, size);
 		break;
+	case BTSNOOP_OPCODE_VENDOR_TX_PKT:
+		packet_hci_vendor(tv, cred, index, false, data, size);
+		break;
+	case BTSNOOP_OPCODE_VENDOR_RX_PKT:
+		packet_hci_vendor(tv, cred, index, true, data, size);
+		break;
 	case BTSNOOP_OPCODE_OPEN_INDEX:
 		if (index < MAX_INDEX)
 			addr2str(index_list[index].bdaddr, str);
 		else
 			sprintf(str, "00:00:00:00:00:00");
 
 		packet_open_index(tv, index, str);
 		break;
@@ -14766,16 +14773,35 @@ malformed:
 		print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
 				"Malformed ISO Data RX packet", NULL, NULL);
 	else
 		print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
 				"Malformed ISO Data TX packet", NULL, NULL);
 	packet_hexdump(data, size);
 }
 
+void packet_hci_vendor(struct timeval *tv, struct ucred *cred, uint16_t index,
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
+	print_packet(tv, cred, in ? '>' : '<', index, NULL, COLOR_HCI_VENDOR,
+				"HCI Vendor", NULL, extra_str);
+
+	packet_hexdump(data, size);
+}
+
 void packet_ctrl_open(struct timeval *tv, struct ucred *cred, uint16_t index,
 					const void *data, uint16_t size)
 {
 	uint32_t cookie;
 	uint16_t format;
 	char channel[11];
 
 	if (size < 6) {
diff --git a/monitor/packet.h b/monitor/packet.h
index 9d1efdf45258..fc0e0dc59959 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -145,16 +145,18 @@ void packet_hci_command(struct timeval *tv, struct ucred *cred, uint16_t index,
 void packet_hci_event(struct timeval *tv, struct ucred *cred, uint16_t index,
 					const void *data, uint16_t size);
 void packet_hci_acldata(struct timeval *tv, struct ucred *cred, uint16_t index,
 				bool in, const void *data, uint16_t size);
 void packet_hci_scodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 				bool in, const void *data, uint16_t size);
 void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 				bool in, const void *data, uint16_t size);
+void packet_hci_vendor(struct timeval *tv, struct ucred *cred, uint16_t index,
+				bool in, const void *data, uint16_t size);
 
 void packet_ctrl_open(struct timeval *tv, struct ucred *cred, uint16_t index,
 					const void *data, uint16_t size);
 void packet_ctrl_close(struct timeval *tv, struct ucred *cred, uint16_t index,
 					const void *data, uint16_t size);
 void packet_ctrl_command(struct timeval *tv, struct ucred *cred, uint16_t index,
 					const void *data, uint16_t size);
 void packet_ctrl_event(struct timeval *tv, struct ucred *cred, uint16_t index,
diff --git a/src/shared/btsnoop.h b/src/shared/btsnoop.h
index c24755d56729..efa87a8f2971 100644
--- a/src/shared/btsnoop.h
+++ b/src/shared/btsnoop.h
@@ -37,16 +37,18 @@
 #define BTSNOOP_OPCODE_SYSTEM_NOTE	12
 #define BTSNOOP_OPCODE_USER_LOGGING	13
 #define BTSNOOP_OPCODE_CTRL_OPEN	14
 #define BTSNOOP_OPCODE_CTRL_CLOSE	15
 #define BTSNOOP_OPCODE_CTRL_COMMAND	16
 #define BTSNOOP_OPCODE_CTRL_EVENT	17
 #define BTSNOOP_OPCODE_ISO_TX_PKT	18
 #define BTSNOOP_OPCODE_ISO_RX_PKT	19
+#define BTSNOOP_OPCODE_VENDOR_TX_PKT	22
+#define BTSNOOP_OPCODE_VENDOR_RX_PKT	23
 
 #define BTSNOOP_MAX_PACKET_SIZE		(1486 + 4)
 
 #define BTSNOOP_TYPE_PRIMARY	0
 #define BTSNOOP_TYPE_AMP	1
 
 #define BTSNOOP_BUS_VIRTUAL	0
 #define BTSNOOP_BUS_USB		1

-- 
2.34.1

