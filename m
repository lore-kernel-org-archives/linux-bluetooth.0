Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B4E4C6802
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446869; cv=none; b=XOhZ72wAhqjxvjJRXupttwoOCIdLCi9nElCUdknp1g50/pIuvhiDCwARF3+Vdga7Yx39T/RvhOw+VZPoHkTHzgr8umZbNbcuTmP+We3e+zjtlwoy1g37AFc/GkZkiJWULtlRTza8KEnUjseMGphn5sf3RYniCwzmsN6WMZdt+B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446869; c=relaxed/simple;
	bh=RPfD4GIbVUivEF9PyW3zvOjxcjfO/rIEZB9BSNsUCbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aKChj+FuvGuolV4zY3XUBVMHoituSbFFrudYG6khgIvPIWlHl45UCIKCaseHyJy2Tk1pxAEunv+Rrq8GqwdFKxnVhUS7dsl6HBgwfnkumCDSflP7iiHPKmE+mxf/6WbJT9QzZ3KH4wcyTITd0rBFhw27MiecRLznC4jN7+B7Elo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eGjIpiQx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fa0ds6Kb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eGjIpiQx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fa0ds6Kb"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683DAMDH539090
	for <linux-bluetooth@vger.kernel.org>; Thu, 3 Sep 2026 14:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8Ye/4ckphsVg1FGVjw8O+Cv8VOuLGvTGgJRSPfv4rc4=; b=eGjIpiQxqpBJsx7z
	snQgu5ga/rXciQTutVO9V3T9A9AZXe/Gz3ZkbIJ1xFLn3NLQ6ilZyKRLxN/OCkMZ
	jWJl2pwztLlpb4hEa7nOATYnBC9KNYwIlRlGUhrBnxP9pR0IiWr6kEq8qV1qb502
	QzmzB6tt8wiUeHw+Ocy8giKjfSa2NQWWp6YH0yQ2uJn/wkArKMLCCVn8bda7I2VN
	khDIjcdr4zZGEXg58o5GwmWb28idKGDhtgo4oB+einV9kZYfFyn+URJm3bcYh3T8
	lMSpwRe8CGEn2B/R2rZr0AsiLSykvrLeOwEhp33dyTKJEBZjQU9tp+giYDdGNKeU
	Bk9voA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6tx13fm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 14:47:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-398bb9a6408so531229a91.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 07:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788446865; x=1789051665; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Ye/4ckphsVg1FGVjw8O+Cv8VOuLGvTGgJRSPfv4rc4=;
        b=Fa0ds6Kb8lTtyrysBPkefSLbNOaz1xi1KgP/+kqRqwoU/Bwh2L3DKJWp6F/zrf8nVN
         OdJpWzggl88PhpmN031crlbMIz0+hqcX3d13ipCYWwU4gBnjFn9OrKX2d3BHSVijtXYT
         3so9/HP5MbOQ7dcsm3MMezG5VaHllEWh8VDSOqq6juUjLsfoYxvdoYq56q3xuHVNf4NT
         plMwPnljwByuiL2auUBi+nHk8pM58fHXlrI0V8u3dM28rZIAzzJUJ0BuCCrYDF7uxOH1
         MO9FWmJVdH9lH/2b0kLGfuM60Jh+OjC3W39BCAcExef1qQfbzj5v6xPsbtK1fkydligJ
         xyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446865; x=1789051665;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Ye/4ckphsVg1FGVjw8O+Cv8VOuLGvTGgJRSPfv4rc4=;
        b=ASU+OZE22WhpuV0ykRtZVC4zT5jAykYjlYaY4wD2JqJvpa4ricESEdHSVrJhT84iQi
         HbljbfOuqOpxFRGHnzraCEB85rDRtat7SeWBiWuxMd+R54+TNUXYdV4N6Wvhq8oGhPvr
         TOygxIykmc3+qRUvEgGw7m2fk13pCBgh4a1qXIPQQKw8XwPZv63fXQTlFZaMRLbPAT3U
         zjQ9nW4TKVWksE/CKcDkbl2hIwraoFKV7pnSrSlMvcutj5sw9VEqIYZfHgIxUk5EylM2
         2VC1Z6/LJ9+PJoItsTnApvH4t/Yw5EVZYzMADeV8aUhKxFLLPvC3MZYK2Q1cvdjMOx6s
         srww==
X-Forwarded-Encrypted: i=1; AKwUvByXLoj6N6cPSHW9+rJTnlJ/lFMP6oaR4W6IDNVsqAj82KwnRgAJDUxIwo6kGpyxFsD+jS6FNG96Z2RlklueGxo=@vger.kernel.org
X-Gm-Message-State: AFuF++m8AD3DeKth1nulp1Ad7LTClimP9/X6v6v7KhdkghNZEuZMfgvG
	apTqrs6PyPZdgo8m7iNUqllZQtW51Sdo2bfY2r/GJnCSxxEVuwkb2zG2aU57nJFe+Ly08Z/Foz9
	XCcUNyLecWxUScOq96JWx2X8XXi1EqedMqiqhS4jd9bFx+ff0urWs1OWsdmCL069drTlOiyz3Rx
	q9Z5s=
X-Gm-Gg: AYBFou3KbNPnDwlA/8y/ORyppavws8hwHdXGWpXzRvhKGrOipExcZC7yi2iwV6l6b1r
	B/JzYj4rcpeKgqY07NBQYlVYGC4xM3s8FCc1ux1UBFmiSOsi6Xff1jEf8pXYYS9cLvH4SW714zh
	/rqMAMwyh8kd7+5JHPvNC4IXmu5HbDIMHfBMyp1bCJ4+BzIxWh91uxcP/c7EWcT3O71VcF/zRaL
	2kOIlG0sc0uHWvgO9w2A8PfvBAWWhT2QO6hMbflXXJsHcpX74ZGEolke60VIWiwR5d3ibbiEe1R
	GxiFtGHmecbgVJe7FPe4gao6vu8hWUNSrEn32vnvUusm7vfcyzOtGk7gNiq765WpKZy2E6cRove
	UBYyabkjmr99tXEehYj+TwpnR7E3bu3DPFiYWiA17hGXvu0o=
X-Received: by 2002:a17:90b:520f:b0:38e:ab3f:2c99 with SMTP id 98e67ed59e1d1-39aedf3afc9mr13187054a91.2.1788446864421;
        Thu, 03 Sep 2026 07:47:44 -0700 (PDT)
X-Received: by 2002:a17:90b:520f:b0:38e:ab3f:2c99 with SMTP id 98e67ed59e1d1-39aedf3afc9mr13186989a91.2.1788446863881;
        Thu, 03 Sep 2026 07:47:43 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243bfbe3sm25794c88.11.2026.09.03.07.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:47:42 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Thu, 03 Sep 2026 07:47:16 -0700
Subject: [PATCH BlueZ v3 4/4] monitor: Support vendor packets
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-vendor_hci-v3-4-015d62a57c91@oss.qualcomm.com>
References: <20260903-vendor_hci-v3-0-015d62a57c91@oss.qualcomm.com>
In-Reply-To: <20260903-vendor_hci-v3-0-015d62a57c91@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: 5I4RUxiCB3dU4ZQWdN8ZwZzix3Irt7ZV
X-Authority-Analysis: v=2.4 cv=TqjWQjXh c=1 sm=1 tr=0 ts=6a998891 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=wKszYPmeBrtX0xbgVwQA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 5I4RUxiCB3dU4ZQWdN8ZwZzix3Irt7ZV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEyOCBTYWx0ZWRfX9Xsj5yLtOoPA
 8npEqO4sa4Iqj1hvsCLEfnH4CVSjbHsh/dD9FkvoJPITXH4rEbIzb3AGgyuJuLodMd9Lda63ubM
 bZ97VGsHXW9uxi3OuC7nM2e3XOk0+I9eselHQPJwAI2kohQZ81PiP4xkuJ+lRP3NdbEqm5im6yY
 vg5NCIxvx+OUeUmay8UtI/5CCB5q7SJ348mkj0GzxIQCTdvF8+Sp0J/5m0zGb6S7hmIpXFmsocO
 9zI1CseXbew3S8xFFM5NPQCvVXSZ6gLJO+ABBAi+AZKbCf8/k3kYI+Ex6uLTRbCtxpwYSynbDbt
 cZ3+KLgYVipbKl3AcpBlm7wllEfMzjPnprof7bQVc7uOIoRlXWXQXisMaHe1UWYsahmu50wsL9l
 BRAU7xZW9GiNLRpJcD8xkkl/qLlaSlR73mBbsHxbQhW8pG+S+KEkN0Jmz1bDb7ddnKrKa0dsnaV
 uStVaDHu6c9PTvirBTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEyOCBTYWx0ZWRfX13kb/rrcHlRu
 Gk9j2QKF/j2SNRhUB7jemjDA42g+lMlR3roaB/ekaHF+yGCnXmvT6CXnKaQ84n1IfBl29kZp9yK
 ckrRCmAiVfZwQ/8MyFctpbZaSmzz3DA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030128

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
index de9c23603a21..e3b2c2fe65f2 100644
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
+	unsigned long num_vendor;
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
+	printf("  %lu vendor packets\n", dev->num_vendor);
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
index 08051f434ba2..1b1e8c3ecdab 100644
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

