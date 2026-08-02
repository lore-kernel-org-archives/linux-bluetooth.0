Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828E42F532F
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2026 06:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785652332; cv=none; b=gNQOI9/fjCk1+dH9h4GZnh3UgTxs+QwR5jI8dSIsKMr8UQJygIjW7Sy+XvkiIhDRpBJTPW3oZ+76S6e9WQC0A31hjuHRLX6Gal0iz7E2Me/kMReCUYfFSSB26z7TTVqThtPyuTw/R45gforA2GU7Jn5C4+HFkZ4FMdr1/NQfeNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785652332; c=relaxed/simple;
	bh=Gv51iU7rGZkrFmIh316YaapPDbRmPw09uJ8CkmbN1mU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y7b/juE7t5jnxuGOE8xJLu0ORNoTLc4JL9ifBByO4PM3UyOXDNdcIMnE1MosMbj1YXxUtCP5prGp9he83nDRqPT5IGnt1LdBd5obp27lW0WvV6A2Y6qsrBhqbqw2Da9eo3Iz7Rqeq5uP1QbcA512/eu4fLNZp+JwfrQkmWvDVWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jHVCGjWd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WiFmk5rn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jHVCGjWd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WiFmk5rn"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6724aR5q1212398
	for <linux-bluetooth@vger.kernel.org>; Sun, 2 Aug 2026 06:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1yfDDPi7ak+BE+1D5B1YbfNVjwA9H1rtbf0ZsBdc9Mk=; b=jHVCGjWd9ESOXym2
	8exPHLyB9zJfbkSZ2GGEhMHgntef3s5l244OAhHc8VuS+EvjVjKkcS9eEBMoEMsb
	PSoMM3IoE50xTAY3V+dMu2rAOYjTM/uJXhIyc2h+Lp0gdUwsNx0RTTdnYYD2WA0O
	+23pck/eqGlMotr1F9s8CnCV2kzHKSJiqVfbZgpnO2STg33KAQ2B15aSgPIz2zqH
	jiMrw+yBrYn0GdNTCg1D2Lb4JwqY4/4TIyIjRgh5KcHreV57YNYUtTAJFwIbbHxz
	JtV1v923R90h3UNANrHgWHE0GrKVTu2sF5MIfiwBMYnf0E1ECqxkVrR4wnD5dIjQ
	kx6hZA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8qptbeg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 02 Aug 2026 06:32:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc98d6a88bso7115265ad.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2026 23:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785652325; x=1786257125; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1yfDDPi7ak+BE+1D5B1YbfNVjwA9H1rtbf0ZsBdc9Mk=;
        b=WiFmk5rnMRzNJ5lucGRiBcylzFPJUJk8VkOhxXJiRz/+qTgPRJ4CFaWYbHa7+Ley2N
         aOwDLSAsqn4r07iRqmW75WvdCUYxMjHQ7LP79UP0K6AilX3m8W9GjdrqWO+FycO/Iwhv
         stgF++sgDT+Xn5mJNUS2eapFuioobKuOlhH7sxBpi/C7vSz8gdxssjK/zk3L4qChu6jR
         mK4OZlqwfg9ARO6JsRExQckFYKXW7I9l+SsakdhlZuwTFFHin+smxiUbfiPv/HPntYa4
         X62P3qcOZzb+SqIafnvzpW5MfgAGmsqbPV1ebVNVOJyP9DyOg0uAezjX+0NyNxLj1py0
         8oEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785652325; x=1786257125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1yfDDPi7ak+BE+1D5B1YbfNVjwA9H1rtbf0ZsBdc9Mk=;
        b=PnNp4cUvcdoGsihlhKXxsfq/tIT3HZ1K/llrp9Esa+1Xh0B1v9XY5n4IgvlY63Psz8
         Ih4+jRfouM8Ng0JTYVa81S74voiJgnNEfUSanmaVtG2ZD0GLj9xfg4riuw22UGIIpnnQ
         yTDJJdBm3BPX1yB3Mu55H/vg7IWQRa6IXFcgo1RFhQ/MP3yuJCZBXTkT0+rsru4Oz+Zk
         ZLZsGUL6KpNcfn+9rMz5jI3Xwud67SI07Y9vt1nYdlh9WeFC7kXSMnS0ay+6oUZXSk72
         JNc/RcoyLxN9BDTVD2tcUQRCJXGPvcr0z2QAe2y76oT8SDraKSSFsrIzt91sY08JxOBC
         Rb+g==
X-Forwarded-Encrypted: i=1; AHgh+RqOP4peOVChzhg+SirN9sud+PJhoCws6OsPqY2dwwl9ZkIOkaqwMa/sFNYS0nnkjZI6zZlzjp/cCx+0zhFSQRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAh+WBBKB/846pQZ1ahyfY83/oTudpq4l643riMpF7eXZm8ELc
	kQnOuQjQfeUhFE96oSC0c589ynyWNtzDoOowaa3qEnguQGKbMLudcXzeZUQ+lIH1UEq3LRfyVRn
	Dq0zSasxFGv8N3RivoIlNgJaTrQpErj4i/vTdAJF/EA6dCRFjsKStBe/tn0guzTATr/nelUQ=
X-Gm-Gg: AR+sD13fH3hbG2NW9ohknjoQrpFopZlCMWSb3kcnIFu4LrzyDfnO/WaaSDhYRQNg641
	VW6wioyOWnwwxW88qJREnyK+PphxurFhZjLbcDn+YGfNtgBab866EfjTr/lOg/JspVRzhCaZj2G
	8UbEzmkIB+wuyQuygzdPekJK3Of+tm8hMAd2ZjbbRuzrZpZpfXdb0wYkmsIY+tnv6sAXC7bdadY
	63F7AQnykF3floveu3SFEziSClp/+VmqxD7bd/G7Uyt7zxCbmWTG2akFiNLfIblmf7oYjxls/7k
	f+F5CkhaAJCOJu7OfkDJjNFnW3vrpkzw3m9bDO0cMbj9ru3N7cPZJ094khktzamGig6g2zKmr7E
	yhjZOMjOBu0ESi+jRMO8FDHL+Q6A0JRfmDwhVjSqZKJeMDSI=
X-Received: by 2002:a17:903:46cf:b0:2ca:ecf6:9115 with SMTP id d9443c01a7336-2d0523bcf3amr83541375ad.2.1785652324947;
        Sat, 01 Aug 2026 23:32:04 -0700 (PDT)
X-Received: by 2002:a17:903:46cf:b0:2ca:ecf6:9115 with SMTP id d9443c01a7336-2d0523bcf3amr83540995ad.2.1785652324542;
        Sat, 01 Aug 2026 23:32:04 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c93dsm24233304eec.8.2026.08.01.23.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 23:32:03 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sat, 01 Aug 2026 23:31:42 -0700
Subject: [PATCH v3 7/7] Bluetooth: hci_event: Use 255 as max event payload
 length in hci_ev_table[]
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-generic_fix-v3-7-efdd8dcf3430@oss.qualcomm.com>
References: <20260801-generic_fix-v3-0-efdd8dcf3430@oss.qualcomm.com>
In-Reply-To: <20260801-generic_fix-v3-0-efdd8dcf3430@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Neeraj Kale <neeraj.sanjaykale@nxp.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDA1MCBTYWx0ZWRfXxp3V09GL4lsN
 xg1vlre+CzhwO6twscTJLRCjtj6qKQ/2J0tkmGSDNxOf3WVjaicbbDep7oGA4kzJTeyF1Swu7Qz
 4VDcj+HBs8IUK4QycJvJQjj4sufrUjq0B/nZsdeNWdtd78f7o/CokjdIx7DW5z+r0OJ6pf05vUF
 6vE4o55zOBDSFdj+PrwVUOJZTsGZJP8SvOI0X0j8jWqd70Fo+fcKXW3XtmEorxnBgMqUJ7Sflhq
 JDXfyLlzgAoqfddm2w75ms0/vIN2ASOJM8BvS46uJrEWUkMak69d/cJqy9feoNU7rVmlJt6XckO
 8lLW5qTBp2yPHCSWIhpTqiUzqgzH2kUe7VrZb5yln4ng/FwtJrikWulSC6VNAqWMEq2EAU/kqzJ
 z6dA7ue5mcrnZAASzVdHnGpHxmKdzFkHcWHshV2RlTRFrt11Sc+yrQ9DsbPe/Abf74T2VJvofyw
 S+DazVwJATlNS7RB/Kg==
X-Proofpoint-GUID: za6iUTIEyJrTAP-v8AVeIH7Hi-L_etcw
X-Authority-Analysis: v=2.4 cv=MpViLWae c=1 sm=1 tr=0 ts=6a6ee465 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Fd4swuEyLw3u6wyU_mgA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: za6iUTIEyJrTAP-v8AVeIH7Hi-L_etcw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDA1MCBTYWx0ZWRfX31w8fzmDMg3c
 J0esvzmANCHdSs60+Mw2E9Wkie6pxNcHYt13VPB+jHGHkEUw4uHPx1WDGo0oisVT/6r7PARhHQT
 vPzDDJPu+P1EOTlL7cEaJF80dYU8gFk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020050

hci_event_func() validates skb->len against ev->max_len from the
entry in hci_ev_table[]. By then, the header has already been
stripped by skb_pull(). So the max event payload is 255, but
hci_ev_table[] still uses HCI_MAX_EVENT_SIZE (260) for it, which is
imprecise.

Fix by introducing HCI_MAX_EVENT_PLEN (255) and using it instead.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Both hci_cc_table[] and hci_le_ev_table[] have the same issue. I'll
send separate patches for them if this one is accepted.
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_event.c   | 14 +++++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index cd3520a29131..1641d879dbda 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -3377,16 +3377,17 @@ struct hci_ev_si_security {
 	__u16    proto;
 	__u16    subproto;
 	__u8     incoming;
 } __packed;
 
 /* ---- HCI Packet structures ---- */
 #define HCI_COMMAND_HDR_SIZE 3
 #define HCI_EVENT_HDR_SIZE   2
+#define HCI_MAX_EVENT_PLEN   255
 #define HCI_ACL_HDR_SIZE     4
 #define HCI_SCO_HDR_SIZE     3
 #define HCI_ISO_HDR_SIZE     4
 
 struct hci_command_hdr {
 	__le16	opcode;		/* OCF & OGF */
 	__u8	plen;
 } __packed;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8452d372524f..3879ba302d4d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7721,17 +7721,17 @@ static const struct hci_ev {
 	};
 	u16  min_len;
 	u16  max_len;
 } hci_ev_table[U8_MAX + 1] = {
 	/* [0x01 = HCI_EV_INQUIRY_COMPLETE] */
 	HCI_EV_STATUS(HCI_EV_INQUIRY_COMPLETE, hci_inquiry_complete_evt),
 	/* [0x02 = HCI_EV_INQUIRY_RESULT] */
 	HCI_EV_VL(HCI_EV_INQUIRY_RESULT, hci_inquiry_result_evt,
-		  sizeof(struct hci_ev_inquiry_result), HCI_MAX_EVENT_SIZE),
+		  sizeof(struct hci_ev_inquiry_result), HCI_MAX_EVENT_PLEN),
 	/* [0x03 = HCI_EV_CONN_COMPLETE] */
 	HCI_EV(HCI_EV_CONN_COMPLETE, hci_conn_complete_evt,
 	       sizeof(struct hci_ev_conn_complete)),
 	/* [0x04 = HCI_EV_CONN_REQUEST] */
 	HCI_EV(HCI_EV_CONN_REQUEST, hci_conn_request_evt,
 	       sizeof(struct hci_ev_conn_request)),
 	/* [0x05 = HCI_EV_DISCONN_COMPLETE] */
 	HCI_EV(HCI_EV_DISCONN_COMPLETE, hci_disconn_complete_evt,
@@ -7749,29 +7749,29 @@ static const struct hci_ev {
 	HCI_EV(HCI_EV_CHANGE_LINK_KEY_COMPLETE,
 	       hci_change_link_key_complete_evt,
 	       sizeof(struct hci_ev_change_link_key_complete)),
 	/* [0x0b = HCI_EV_REMOTE_FEATURES] */
 	HCI_EV(HCI_EV_REMOTE_FEATURES, hci_remote_features_evt,
 	       sizeof(struct hci_ev_remote_features)),
 	/* [0x0e = HCI_EV_CMD_COMPLETE] */
 	HCI_EV_REQ_VL(HCI_EV_CMD_COMPLETE, hci_cmd_complete_evt,
-		      sizeof(struct hci_ev_cmd_complete), HCI_MAX_EVENT_SIZE),
+		      sizeof(struct hci_ev_cmd_complete), HCI_MAX_EVENT_PLEN),
 	/* [0x0f = HCI_EV_CMD_STATUS] */
 	HCI_EV_REQ(HCI_EV_CMD_STATUS, hci_cmd_status_evt,
 		   sizeof(struct hci_ev_cmd_status)),
 	/* [0x10 = HCI_EV_CMD_STATUS] */
 	HCI_EV(HCI_EV_HARDWARE_ERROR, hci_hardware_error_evt,
 	       sizeof(struct hci_ev_hardware_error)),
 	/* [0x12 = HCI_EV_ROLE_CHANGE] */
 	HCI_EV(HCI_EV_ROLE_CHANGE, hci_role_change_evt,
 	       sizeof(struct hci_ev_role_change)),
 	/* [0x13 = HCI_EV_NUM_COMP_PKTS] */
 	HCI_EV_VL(HCI_EV_NUM_COMP_PKTS, hci_num_comp_pkts_evt,
-		  sizeof(struct hci_ev_num_comp_pkts), HCI_MAX_EVENT_SIZE),
+		  sizeof(struct hci_ev_num_comp_pkts), HCI_MAX_EVENT_PLEN),
 	/* [0x14 = HCI_EV_MODE_CHANGE] */
 	HCI_EV(HCI_EV_MODE_CHANGE, hci_mode_change_evt,
 	       sizeof(struct hci_ev_mode_change)),
 	/* [0x16 = HCI_EV_PIN_CODE_REQ] */
 	HCI_EV(HCI_EV_PIN_CODE_REQ, hci_pin_code_request_evt,
 	       sizeof(struct hci_ev_pin_code_req)),
 	/* [0x17 = HCI_EV_LINK_KEY_REQ] */
 	HCI_EV(HCI_EV_LINK_KEY_REQ, hci_link_key_request_evt,
@@ -7787,27 +7787,27 @@ static const struct hci_ev {
 	       sizeof(struct hci_ev_pkt_type_change)),
 	/* [0x20 = HCI_EV_PSCAN_REP_MODE] */
 	HCI_EV(HCI_EV_PSCAN_REP_MODE, hci_pscan_rep_mode_evt,
 	       sizeof(struct hci_ev_pscan_rep_mode)),
 	/* [0x22 = HCI_EV_INQUIRY_RESULT_WITH_RSSI] */
 	HCI_EV_VL(HCI_EV_INQUIRY_RESULT_WITH_RSSI,
 		  hci_inquiry_result_with_rssi_evt,
 		  sizeof(struct hci_ev_inquiry_result_rssi),
-		  HCI_MAX_EVENT_SIZE),
+		  HCI_MAX_EVENT_PLEN),
 	/* [0x23 = HCI_EV_REMOTE_EXT_FEATURES] */
 	HCI_EV(HCI_EV_REMOTE_EXT_FEATURES, hci_remote_ext_features_evt,
 	       sizeof(struct hci_ev_remote_ext_features)),
 	/* [0x2c = HCI_EV_SYNC_CONN_COMPLETE] */
 	HCI_EV(HCI_EV_SYNC_CONN_COMPLETE, hci_sync_conn_complete_evt,
 	       sizeof(struct hci_ev_sync_conn_complete)),
 	/* [0x2f = HCI_EV_EXTENDED_INQUIRY_RESULT] */
 	HCI_EV_VL(HCI_EV_EXTENDED_INQUIRY_RESULT,
 		  hci_extended_inquiry_result_evt,
-		  sizeof(struct hci_ev_ext_inquiry_result), HCI_MAX_EVENT_SIZE),
+		  sizeof(struct hci_ev_ext_inquiry_result), HCI_MAX_EVENT_PLEN),
 	/* [0x30 = HCI_EV_KEY_REFRESH_COMPLETE] */
 	HCI_EV(HCI_EV_KEY_REFRESH_COMPLETE, hci_key_refresh_complete_evt,
 	       sizeof(struct hci_ev_key_refresh_complete)),
 	/* [0x31 = HCI_EV_IO_CAPA_REQUEST] */
 	HCI_EV(HCI_EV_IO_CAPA_REQUEST, hci_io_capa_request_evt,
 	       sizeof(struct hci_ev_io_capa_request)),
 	/* [0x32 = HCI_EV_IO_CAPA_REPLY] */
 	HCI_EV(HCI_EV_IO_CAPA_REPLY, hci_io_capa_reply_evt,
@@ -7830,19 +7830,19 @@ static const struct hci_ev {
 	/* [0x3c = HCI_EV_KEYPRESS_NOTIFY] */
 	HCI_EV(HCI_EV_KEYPRESS_NOTIFY, hci_keypress_notify_evt,
 	       sizeof(struct hci_ev_keypress_notify)),
 	/* [0x3d = HCI_EV_REMOTE_HOST_FEATURES] */
 	HCI_EV(HCI_EV_REMOTE_HOST_FEATURES, hci_remote_host_features_evt,
 	       sizeof(struct hci_ev_remote_host_features)),
 	/* [0x3e = HCI_EV_LE_META] */
 	HCI_EV_REQ_VL(HCI_EV_LE_META, hci_le_meta_evt,
-		      sizeof(struct hci_ev_le_meta), HCI_MAX_EVENT_SIZE),
+		      sizeof(struct hci_ev_le_meta), HCI_MAX_EVENT_PLEN),
 	/* [0xff = HCI_EV_VENDOR] */
-	HCI_EV_VL(HCI_EV_VENDOR, hci_vendor_evt, 0, HCI_MAX_EVENT_SIZE),
+	HCI_EV_VL(HCI_EV_VENDOR, hci_vendor_evt, 0, HCI_MAX_EVENT_PLEN),
 };
 
 static void hci_event_func(struct hci_dev *hdev, u8 event, struct sk_buff *skb,
 			   u16 *opcode, u8 *status,
 			   hci_req_complete_t *req_complete,
 			   hci_req_complete_skb_t *req_complete_skb)
 {
 	const struct hci_ev *ev = &hci_ev_table[event];

-- 
2.34.1

