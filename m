Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7393A9856
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788154797; cv=none; b=gr8johgeoXdLrzpUHq4Ew8QIKTRGQ0hWdBOrAia5Bh/cPvpC5O3EnFV4+TTZPJ1CgkufIY7XkIu7j9BPDIOQ1FJX3iceBjHxSUYQ5kBzRpeZL4YqxgOhV06n5PJF0gUXkj5NtEKZ9mLSMzzx7QTqUtaBIPLB93muASae1lGvIdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788154797; c=relaxed/simple;
	bh=o2gSCyz3Xi++alhJa0lOV5bJcDtOIULkAVDQXIyuY5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YzyNzEjZkh05ySIWsEU7vIVwxEusIMY2Aiq1uzKo8xkhSdHm9/CAegxS38Lx6ZSzBn3x5HIqv1Xb/PQUy2qjqMNC20zap7xns2qKmqE7ullc6Hr2XdVMB9wFYmQkdL4u+qTuQ5IM4Lm9U7EHultwf21XYLsWVxNxypxnMnIFI70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ildIfNOi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RuZvD3wH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ildIfNOi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RuZvD3wH"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V52VMx2423221
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KLpd6iiIBm+skYcNXELPQUa3re3CrrMiOKBfusIDgHM=; b=ildIfNOiNArBl3DZ
	fXEHhuIxZLe+zuYpBLpnZSY777Jo9eLtxefk+oDAPiVlMCy92IoLJPQxSS7//JLX
	ozebHjdIk69hGDC5YTSnUAZN/FR5JUTnKby2XEP8O+zUsdZD07FvfSdD3Zvfi46z
	lVrx+GJj7iPT30UxyqzWCXr1cxmeXCpf07AM4/YrcPSULcN8Dv+dvy+KIrrvIHx8
	MJ9duqFNvViylS6zmhbdFijvzFEyu9RNIPe/NsYExaiRvhkGI3fc5iMdU6VjLarA
	dE0n9uVjLUESQOPnv4513XT5CzF/6TToDmbcfVW7Odxd2e5XLGOGF8sGaKw4W1xo
	cD6oxA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqe2crb3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:39:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-387087245e4so853832a91.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 22:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788154793; x=1788759593; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KLpd6iiIBm+skYcNXELPQUa3re3CrrMiOKBfusIDgHM=;
        b=RuZvD3wHCPAidIOjwYUUjZLB6FmJWP92RR9CbHxAILFLFYKjd843oDSilkqae391DK
         01zAq1uJOuiTuXKNCKOkuTZib2o3+fr64FGTZsOpIxVqVh8bHc8gFwTA0Gnl5/2CpDrd
         h8pfdXVA9Dl+JdQWKV2EBBPwX3aHLtdmNWI7clYkB0NAvce00LYTzyj0aAWVDjEL5qvt
         UcmDHyYuu4/idCKPNRaoI6eGuHjxdLce2h2vYf3yo0e+wxCVOuy+k9Qk+fP61Fs1/5CU
         BfajVQCMdrgvStX1O0tBXzlOIT/FKaZtFgLQMcwIeEv7cydlkSMlFXhYeTe30AkYauTc
         5p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788154793; x=1788759593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KLpd6iiIBm+skYcNXELPQUa3re3CrrMiOKBfusIDgHM=;
        b=VwJnjpaDh3wnnihlx2y4vHktqFwE3JEHbnT/wS/zOn/2DKFiGadhSV96DnhBIL6qPn
         sEN1+Bqv0woDMsQIVZ4+sFA1tPA9J0E9UQwGnaohb2TRGUBxceelivt8g/l6V0J1zdT4
         sXelJRd4BSWp4xK9OfNIMSiZmthutkyLvdbpWvwoy01W+hoHJMef8jlRir8kVtAJEtNv
         MzbNLOFt0Y1A0OooNAAup+twXwGzcENnEMogUw+CFBnKkP9H+ehz5w+O4OX+CJJU4Gb5
         yrcvAR5st3x8GIupp1KHouY15rmarU6kkiJhX6hBNVW873KqKFYjtcCKPNs22/SxHJUE
         2MSQ==
X-Forwarded-Encrypted: i=1; AKwUvBziaaRD/vz+1dEaiakSC9f2Ah+01hJnZ/gFAwaE+E0pGL6pBz9Puljb3WpptUlzoQ2MFHcItvt238OnGVrHdaM=@vger.kernel.org
X-Gm-Message-State: AFuF++m99b0V+xuA9zp2W7trVGotXRIdIFfc4SYs8BrugaG55Q1ashJH
	dXSWBPK8laCUHdf8GnXycr5qVeVZEDbpBrGHyXF3eRmHpxtX3gJdSDcCflqOpoxPRP7IyFlwBz5
	G4bKKUbgbnwttfppBqK5NRQNAcNqBl7tr54ErFmostPAyNcz4OXSTEpFPwzXWAX0KfcN2waCrpU
	zWSz8=
X-Gm-Gg: AYBFou1rI+k/euxMzlx3ollyeaVM892fxDVT3gqcS5w0hgnn30ED2S6+WPr3dgMbj2y
	uTkp0aNy9NuruuI9HYXk/h7o43Kp1SnPO45mxuB4sKGEHudOYt8x+2wuIowROBUe3Kfupq8JxjP
	zUU4r5xCFvzDTf1PSgeJjfMQZ4DvmvlWUEqppSNnvjHTGq9ogNrurS9wJ4xia105oCnK9DlFuiV
	c2ZmJH4ejNNG9NQP67aqRIPzpC0F7IJe+IJV2WkF6HFJOFGAZmpzuaq6xzn+2/gpoR94iY85SYe
	BnlmGajGPIn3d8tra0T4kDi0pJM90fVdNp5TStfwMlw/JAfJxl7TxZEsdl9OWOPlf5JcUOU/0mM
	z36Ta17/njBB58vzYbiOPO5Rz2T9/oXVaaBFoaLn2BapSXLs=
X-Received: by 2002:a17:90b:3e50:b0:398:bac0:238d with SMTP id 98e67ed59e1d1-398bac026a5mr10841830a91.5.1788154793119;
        Sun, 30 Aug 2026 22:39:53 -0700 (PDT)
X-Received: by 2002:a17:90b:3e50:b0:398:bac0:238d with SMTP id 98e67ed59e1d1-398bac026a5mr10841793a91.5.1788154792615;
        Sun, 30 Aug 2026 22:39:52 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d3fdf6sm25566085c88.6.2026.08.30.22.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 22:39:51 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sun, 30 Aug 2026 22:39:31 -0700
Subject: [PATCH BlueZ v2 3/3] monitor: Support vendor HCI packets
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-vendor_hci-v2-3-9903760957ab@oss.qualcomm.com>
References: <20260830-vendor_hci-v2-0-9903760957ab@oss.qualcomm.com>
In-Reply-To: <20260830-vendor_hci-v2-0-9903760957ab@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=Iskutr/g c=1 sm=1 tr=0 ts=6a9513aa cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=wKszYPmeBrtX0xbgVwQA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 5mCc-hEwYPO-lPTr__KJe0EEYXChTvE3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA0NiBTYWx0ZWRfX5iXpsspmAEHH
 zAm9mF9RHX7J0AhSRGNsQG4p81kTfb/327noGMfDyr8rnMXGMq+1cbLMePWW+boY4vToNk44O1u
 p+kNk0yuF+fh81D2pY7cQV2K8iajwN9Ru6ztvY+2Urk5AWi5zd+uiV7Ce2rL9Rxz1+B6Zr9y+lS
 wqVa3mpLX8yF9FfkukmGn7gw13USNp0LmLktHDBExPJsHHb2Vfk9cOrr8gqKs8tyXlBR46fpUBu
 6ujoeYFon8oFSml9xLgPrfwF+4Hf5v8Co3E8qUs9sKo1yT9VXDQlRS4LmgcYprK3Pp25cUX5jVt
 qqDDA29V5vecGqvbMafCiCpSgVaXEtM09fDyz/LFX0Cgzt2LjU+0Gad8FjkNMyCLKzraoHwK7a7
 Xf1Ntr9Ynk8skrMFVq/YXKznL5lpeb6KswiZ2PXWACxarmfv9bKy4nGx3Mb1/dmvvmrp30uymPX
 HHluCUmEKfzsrCDhIuA==
X-Proofpoint-ORIG-GUID: 5mCc-hEwYPO-lPTr__KJe0EEYXChTvE3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA0NiBTYWx0ZWRfX7NMHjtAl4nhX
 1QpeffAwUsYAbuP8uz3A0q3C1dPqRN2MBGynKcn5K7BugS+rlwwVfX8dmy1ber2l8P1QxOM5jzx
 oWX99koRvYWrhdtgmfa6YKhWXSKTGdE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310046

Vendor HCI packets have 0xff as packet type.

Support them in tool btmon.

---
Changes since previous version:
- Rename COLOR_VENDOR_HCI to COLOR_HCI_VENDOR
- Rename packet_vendor_hci() to packet_hci_vendor()
- Improve the commit title and message
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
+     - Outgoing vendor HCI packet
+   * - BTSNOOP_OPCODE_VENDOR_RX_PKT
+     - 23
+     - 0x0017
+     - Incoming vendor HCI packet
 
 New Index
 ---------
 
 Code: 0x0000
 
 Parameters:
 
diff --git a/monitor/analyze.c b/monitor/analyze.c
index de9c23603a21..59e8ac819272 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -39,16 +39,17 @@ struct hci_dev {
 	struct timeval time_added;
 	struct timeval time_removed;
 	unsigned long num_hci;
 	unsigned long num_cmd;
 	unsigned long num_evt;
 	unsigned long num_acl;
 	unsigned long num_sco;
 	unsigned long num_iso;
+	unsigned long vendor_hci;
 	unsigned long vendor_diag;
 	unsigned long system_note;
 	unsigned long user_log;
 	unsigned long ctrl_msg;
 	unsigned long unknown;
 	uint16_t manufacturer;
 	struct queue *conn_list;
 };
@@ -460,16 +461,17 @@ static void dev_destroy(void *data)
 	printf("\n");
 
 
 	printf("  %lu commands\n", dev->num_cmd);
 	printf("  %lu events\n", dev->num_evt);
 	printf("  %lu ACL packets\n", dev->num_acl);
 	printf("  %lu SCO packets\n", dev->num_sco);
 	printf("  %lu ISO packets\n", dev->num_iso);
+	printf("  %lu vendor HCI packets\n", dev->vendor_hci);
 	printf("  %lu vendor diagnostics\n", dev->vendor_diag);
 	printf("  %lu system notes\n", dev->system_note);
 	printf("  %lu user logs\n", dev->user_log);
 	printf("  %lu control messages \n", dev->ctrl_msg);
 	printf("  %lu unknown opcodes\n", dev->unknown);
 	queue_destroy(dev->conn_list, conn_destroy);
 	printf("\n");
 
@@ -1357,16 +1359,29 @@ static void iso_pkt(struct timeval *tv, uint16_t index, bool out,
 
 	if (out) {
 		conn_pkt_tx(conn, tv, size - sizeof(*hdr), NULL);
 	} else {
 		conn_pkt_rx(conn, tv, size - sizeof(*hdr), NULL);
 	}
 }
 
+static void vendor_hci_pkt(struct timeval *tv, uint16_t index, bool out,
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
 static void unknown_opcode(struct timeval *tv, uint16_t index,
 					const void *data, uint16_t size)
 {
 	struct hci_dev *dev;
 
 	dev = dev_lookup(index);
 	if (!dev)
 		return;
@@ -1463,16 +1478,24 @@ void analyze_trace(const char *path)
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
+			vendor_hci_pkt(&tv, index, true, buf, pktlen);
+			break;
+		case BTSNOOP_OPCODE_VENDOR_RX_PKT:
+			num_frames++;
+			vendor_hci_pkt(&tv, index, false, buf, pktlen);
+			break;
 		default:
 			unknown_opcode(&tv, index, buf, pktlen);
 			break;
 		}
 
 		num_packets++;
 	}
 
diff --git a/monitor/packet.c b/monitor/packet.c
index 0d3b23cc3fb7..7adcf64a3631 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -67,16 +67,17 @@
 
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
@@ -4523,16 +4524,22 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
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
@@ -14650,16 +14657,35 @@ malformed:
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
+				"Vendor HCI Packet", NULL, extra_str);
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
index 73a86f64b242..8c519eca61c1 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -130,16 +130,18 @@ void packet_hci_command(struct timeval *tv, struct ucred *cred, uint16_t index,
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

