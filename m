Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3404C67EB
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446866; cv=none; b=NYV0TXlm7XoGf1uY9IIWLpLzaHqkpRqV9YIBsxr6efxkwmyElEO2QnWR1WNtn2tb8MGiOo0Vo+bjVg+VDAQsXDRRBzsMDIIaWJiZKXxBreMgJQVYnvtDWrexyudukxY+Bv5fK+GfcWdkdTNGCKcGl7KmiZNPkwsQ34cDjx6helQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446866; c=relaxed/simple;
	bh=toVV0s12AE7l1RntzRNusz8dCXyI+H129Nhu7e/SZcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DymBSqDc3vzowAdSeS0wSJhQh2sWL2d+/HEJWpl37aJOj5ATTBiR5ag0a/AU312iLwFvcGTxlLIhcCkKbB8GXnO8KqLLytR5d6Zov9s94hZQJu7883wPbSTAMOK/0IBOBcFv34XpSZUXSGXayyzGehFTzYglrDTkazkmJDcB42s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fReohphr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WzlIAifR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fReohphr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WzlIAifR"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683DAPjY1040603
	for <linux-bluetooth@vger.kernel.org>; Thu, 3 Sep 2026 14:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jvUgfLyif69KGNn8gPHcB9wxKtWJyCmN10y1kpRbBUA=; b=fReohphrXU32NPnX
	drQarxMmDwDyJm5Y9xSB8mIxO1VhRP6YvP1zkwegtwWLVkcHMY63x4LeQxlev7rA
	fNueo0yygf++d7gpN0E2Y+AbkrKeFVWfccPPJDfVGFYKlAjDx6G7Q19hgB17HsnG
	YWHmh+0JM0My+ilkcUX+UYt2tlbjuwF5RO4SJl0j/V6con6MjK+5hNqBSpZ/9N5t
	dykj+4YvO7fMLwgAJlvTVKhacL6jcYrp6K1ygxUaskItOVjayrKVH+ETaBC7TtTS
	KOy5XdpU7xbBG4Arfzyf0YP41N1PHf+Lefv2GaFpfKNFpPszEOeGWfmFM0Kvk9pu
	NtNw9A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1j4japp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 14:47:42 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-384d033f7f5so540873a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 07:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788446861; x=1789051661; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jvUgfLyif69KGNn8gPHcB9wxKtWJyCmN10y1kpRbBUA=;
        b=WzlIAifR4EGUa/hz6jclRq1xUizumpWgIhIgESe5B/oskl7K4diLpktPv92Mcss2OW
         YEGWWHvM/dch3caIxbAWotxM5Wti8fVfWYoU6ySY4G0b6a7pMS0SttmgAgAfIqhIdC9R
         qGhHLiOKAf5updTGLtTrzsICofAuqaZ8P7HawI0ti2ch6N9kIHTE4iz4HAwWRVIfwBjQ
         jZIzm3SjmzOFlkrsyXWJKUxLUCOZM7pInhdT9aSAEbyrpW+7u+yxfym9SDfKPh/DLGsT
         3C37Elye8xp67u/XRj4iTb4diw9MGLHKz3rTAHii+xoKmQhkxnL8yrGeEgR/Ii5JsUI7
         OfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446861; x=1789051661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jvUgfLyif69KGNn8gPHcB9wxKtWJyCmN10y1kpRbBUA=;
        b=fpCD8KlZAcem8APKCpooaCF09n9/CEIa/XaePHxFLZl12/okQYZ56HnNuoFjcdlrvN
         sZj0nE3bI59oumAIWEYMqS8p7qRYfQuznjJq9XEtDczGFpU/kWnSm83MHAOlwZ671VCL
         nokRQrigNKD8F2G9PxVfYtyytAOSpqP0NM8MU5ry2TzfDuBnYEzXvVjzPcMFd6FLMQgO
         LACJklp7JKG8GTPao30U/VvZIPQI148rMRBK+pGkl/cFbmfUVLF3ACoJ/n0rM8+zluOq
         vwzE1dybtKtLQLM6U01Gw00OWwgE94uKD+pmrb5jZuE0hyUX4JvRAlArFVeLAS3hZT2F
         Bh6Q==
X-Forwarded-Encrypted: i=1; AKwUvByJCnNgzoBKytB0wfdrOBIR25C+TL+OE31N+SM30ifO308Dc0UDJ9UkuCpJgv21nTn9mA/BHsxXwWRSz9FhSOA=@vger.kernel.org
X-Gm-Message-State: AFuF++kMurHmxHf+KpHNSmpl87gc1atT5ya89x39qLGlPMq4WeL5Wjal
	WpSIVwWd3W3sBv9drOu6sa2VsVkGls6KnV1mO4j0KsULpT4eSq8jS7KCKyNrZV4sJxtTvtJ/7EA
	6lj53cD+IWxBKRaMwtunYGNQd25Oe5fTDS4LcJPOHI3UykpjNFu3oqIjkbw8nOJDc7YZ/SL9Lj2
	uhIl0=
X-Gm-Gg: AYBFou0I/khEZwLMJMtUsKVruXBAPcjafg3MZ2WAN4Xg3y3L2F0Fdth/03WiZUt+tPJ
	rdWYfNQ1Q8U+JHPNnXKdseBmqtjbKbLKzapuBooiN/elwadNTtuoxw19MzzVLNKP6ICvjqhqzOq
	WjYR8xJTBCZwCHcTAMXdwEjBff2DYpXJ0B+dgVck3vJ1oezQBAyGxaJtO5R72hKgs9kJ9tE/6z8
	00mHJ586BR6547t058+0nw1hJBZX4DNq6mAIabK0AYyR8+ABkCSxrXJEeos3FuhgQ8c4k15GpoM
	S5soQjftNFREQWABUbI0Cv7r8w/Qn4KSHCAHbmTHg7Dmezydi3bpc8rBn1ybVP1BcZbqkSiSkbb
	u8MQCbS47FJo8tBplLoNJ1vzwl2tfoS8VPYbfaDqlwcltN5o=
X-Received: by 2002:a17:90b:4cc4:b0:398:bada:838b with SMTP id 98e67ed59e1d1-39aee277bc5mr13207663a91.6.1788446860866;
        Thu, 03 Sep 2026 07:47:40 -0700 (PDT)
X-Received: by 2002:a17:90b:4cc4:b0:398:bada:838b with SMTP id 98e67ed59e1d1-39aee277bc5mr13207594a91.6.1788446860211;
        Thu, 03 Sep 2026 07:47:40 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243bfbe3sm25794c88.11.2026.09.03.07.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:47:36 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Thu, 03 Sep 2026 07:47:14 -0700
Subject: [PATCH BlueZ v3 2/4] monitor: s/vendor_(evt|event)/\1_vendor/
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-vendor_hci-v3-2-015d62a57c91@oss.qualcomm.com>
References: <20260903-vendor_hci-v3-0-015d62a57c91@oss.qualcomm.com>
In-Reply-To: <20260903-vendor_hci-v3-0-015d62a57c91@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=dufrzVg4 c=1 sm=1 tr=0 ts=6a99888e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=Dei6p5SHAAAA:8 a=7rLAfYvYRfl3bdLfV3sA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=M-Yerj1wOn-OpK7r_3ei:22
X-Proofpoint-GUID: UGc_ZF7ZW-fupXDzJWsiZGrex2M-uiSm
X-Proofpoint-ORIG-GUID: UGc_ZF7ZW-fupXDzJWsiZGrex2M-uiSm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEyOCBTYWx0ZWRfX1GCxbMmQRhvi
 jhifrzpK2Xfp/WOsA3tAvITZLKyVrC8C17vY6nlqJzWBuLq2raz0MEunVcntvoMEfOKvDiPqrss
 lHVhKelkJe3gzUWBxYwMxTNkDo/STYY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEyOCBTYWx0ZWRfXx/n7p2/GX2WA
 SlhT0Z3WwaNDF3z06KH/HChPZ9YHSijUB19vmZpTxCaHJrdLMO9/DrBViI8bGQevUfSW/NJ+sVY
 ZCs6FVd2RMEIqP/neJTU5Tc7uWW93xrEWeuTXEthvavCzGVWzhLM62JJDKdOZhF0nMsY2DBTshE
 iGZjcQgU7pgwoAz/VjHn4aMb2HlZ06kI2jyuZnekdMEJHE/ZEkyjFZbLKSgfVVWZA6uoG0LJwb/
 otyHv7C8rda2M1CdVR2e4sJ6Nv6RsjMZI0iv4+8E18laFdo+Kjm+kPfEunCLah2nkpxizsQJVos
 zP9okHR6+X9hfbnWIfYHpVn9CtwpK4QH+aPfPE2N4gCUDBvWeboRV1kr3baVyjbKWWvpn/JLumN
 vFgtLk53/MzhOzumVY5mnwuVDiLr18kXFK+IErmBWJCB7PE9xw2z0TGSDrFpoEtapBTqnMN4oFM
 hiiRqJ6acKjGg6+Uzqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030128

Kernel include/net/bluetooth/hci.h defines:

  #define HCI_EVENT_PKT   0x04
  #define HCI_VENDOR_PKT  0xff
  #define HCI_EV_VENDOR   0xff

HCI_VENDOR_PKT and HCI_EV_VENDOR share the same value, but are very
different, as the table below shows:

+------------+-----------------------+---------------------------+
|            | HCI_VENDOR_PKT        | HCI_EV_VENDOR             |
+------------+-----------------------+---------------------------+
| Defined by | Vendor                | BT SIG                    |
+------------+-----------------------+---------------------------+
| Hierarchy  | Parallel to           | Nested inside             |
|            | HCI_EVENT_PKT         | HCI_EVENT_PKT             |
+------------+-----------------------+---------------------------+
| Direction  | RX and TX             | RX only                   |
+------------+-----------------------+---------------------------+
| kernel <-> | HCI_VENDOR_PKT, ...   | 0x04, HCI_EV_VENDOR, ...  |
| userspace  |                       |                           |
+------------+-----------------------+---------------------------+
| kernel <-> | RX: 23, vendor packet | RX: 3, HCI_EV_VENDOR, ... |
| monitor    | TX: 22, vendor packet |                           |
+------------+-----------------------+---------------------------+

monitor is about to gain HCI_VENDOR_PKT support. To avoid confusing the
two, rename what deals with HCI_EV_VENDOR to follow its pattern:

s/vendor_(evt|event)/\1_vendor/
---
 monitor/broadcom.c | 10 +++++-----
 monitor/broadcom.h |  4 ++--
 monitor/intel.c    | 16 ++++++++--------
 monitor/intel.h    |  4 ++--
 monitor/msft.c     |  6 +++---
 monitor/msft.h     |  4 ++--
 monitor/packet.c   | 20 ++++++++++----------
 monitor/vendor.c   |  2 +-
 monitor/vendor.h   |  4 ++--
 9 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/monitor/broadcom.c b/monitor/broadcom.c
index 80c95e91db0a..0dbc5eb39bb8 100644
--- a/monitor/broadcom.c
+++ b/monitor/broadcom.c
@@ -707,24 +707,24 @@ void broadcom_lm_diag(const void *data, uint8_t size)
 }
 
 static void lm_diag_evt(struct timeval *tv, uint16_t index,
 				const void *data, uint8_t size)
 {
 	broadcom_lm_diag(data, 63);
 }
 
-static const struct vendor_evt vendor_evt_table[] = {
+static const struct evt_vendor evt_vendor_table[] = {
 	{ 0xb4, "LM Diag", lm_diag_evt, 64, true },
 	{ }
 };
 
-const struct vendor_evt *broadcom_vendor_evt(uint8_t evt)
+const struct evt_vendor *broadcom_evt_vendor(uint8_t evt)
 {
 	int i;
 
-	for (i = 0; vendor_evt_table[i].str; i++) {
-		if (vendor_evt_table[i].evt == evt)
-			return &vendor_evt_table[i];
+	for (i = 0; evt_vendor_table[i].str; i++) {
+		if (evt_vendor_table[i].evt == evt)
+			return &evt_vendor_table[i];
 	}
 
 	return NULL;
 }
diff --git a/monitor/broadcom.h b/monitor/broadcom.h
index 5cb51d81dbb8..36492a4071a7 100644
--- a/monitor/broadcom.h
+++ b/monitor/broadcom.h
@@ -7,13 +7,13 @@
  *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
  *
  *
  */
 
 #include <stdint.h>
 
 struct vendor_ocf;
-struct vendor_evt;
+struct evt_vendor;
 
 const struct vendor_ocf *broadcom_vendor_ocf(uint16_t ocf);
-const struct vendor_evt *broadcom_vendor_evt(uint8_t evt);
+const struct evt_vendor *broadcom_evt_vendor(uint8_t evt);
 void broadcom_lm_diag(const void *data, uint8_t size);
diff --git a/monitor/intel.c b/monitor/intel.c
index 782fda675422..d52b2dc80e4c 100644
--- a/monitor/intel.c
+++ b/monitor/intel.c
@@ -1286,17 +1286,17 @@ static void system_exception_evt(struct timeval *tv, uint16_t index,
 		break;
 	}
 
 	print_field("Type: %s (0x%2.2x)", str, type);
 
 	packet_hexdump(data + 1, size - 1);
 }
 
-static const struct vendor_evt vendor_evt_table[] = {
+static const struct evt_vendor evt_vendor_table[] = {
 	{ 0x00, "Startup",
 			startup_evt, 0, true },
 	{ 0x01, "Fatal Exception",
 			fatal_exception_evt, 4, true },
 	{ 0x02, "Bootup",
 			bootup_evt, 6, true },
 	{ 0x05, "Default BD Data",
 			default_bd_data_evt, 1, true },
@@ -1861,17 +1861,17 @@ static void intel_vendor_ext_evt(struct timeval *tv, uint16_t index,
 		tlv = process_ext_subevent(tlv, last_tlv);
 
 	/* If an error occurs in decoding the subevents, hexdump the packet. */
 	if (!tlv)
 		packet_hexdump(data, size);
 }
 
 /* Vendor extended events with a vendor prefix. */
-static const struct vendor_evt vendor_prefix_evt_table[] = {
+static const struct evt_vendor vendor_prefix_evt_table[] = {
 	{ 0x03, "Extended Telemetry", intel_vendor_ext_evt },
 	{ }
 };
 
 static const uint8_t intel_vendor_prefix[] = {0x87, 0x80};
 #define INTEL_VENDOR_PREFIX_SIZE sizeof(intel_vendor_prefix)
 
 /*
@@ -1883,17 +1883,17 @@ static const uint8_t intel_vendor_prefix[] = {0x87, 0x80};
  *   When <subopcode> == 0x03, it is a telemetry event; and
  *   <data> is a number of tlv data.
  */
 struct vendor_prefix_evt {
 	uint8_t prefix_data[INTEL_VENDOR_PREFIX_SIZE];
 	uint8_t subopcode;
 };
 
-static const struct vendor_evt *intel_vendor_prefix_evt(const void *data,
+static const struct evt_vendor *intel_vendor_prefix_evt(const void *data,
 							int *consumed_size)
 {
 	unsigned int i;
 	const struct vendor_prefix_evt *vnd = data;
 	char prefix_string[INTEL_VENDOR_PREFIX_SIZE * 2 + 1] = { 0 };
 
 	/* Check if the vendor prefix matches. */
 	for (i = 0; i < INTEL_VENDOR_PREFIX_SIZE; i++) {
@@ -1914,29 +1914,29 @@ static const struct vendor_evt *intel_vendor_prefix_evt(const void *data,
 			*consumed_size = sizeof(struct vendor_prefix_evt);
 			return &vendor_prefix_evt_table[i];
 		}
 	}
 
 	return NULL;
 }
 
-const struct vendor_evt *intel_vendor_evt(const void *data, int *consumed_size)
+const struct evt_vendor *intel_evt_vendor(const void *data, int *consumed_size)
 {
 	uint8_t evt = *((const uint8_t *) data);
 	int i;
 
 	/*
 	 * Handle the vendor event without a vendor prefix.
 	 *   0xff <length> <evt> <data>
-	 * This loop checks whether the <evt> exists in the vendor_evt_table.
+	 * This loop checks whether the <evt> exists in the evt_vendor_table.
 	 */
-	for (i = 0; vendor_evt_table[i].str; i++) {
-		if (vendor_evt_table[i].evt == evt)
-			return &vendor_evt_table[i];
+	for (i = 0; evt_vendor_table[i].str; i++) {
+		if (evt_vendor_table[i].evt == evt)
+			return &evt_vendor_table[i];
 	}
 
 	/*
 	 * It is not a regular event. Check whether it is a vendor extended
 	 * event that comes with a vendor prefix followed by a subopcode.
 	 */
 	return intel_vendor_prefix_evt(data, consumed_size);
 }
diff --git a/monitor/intel.h b/monitor/intel.h
index bfb04540c058..e218745a8712 100644
--- a/monitor/intel.h
+++ b/monitor/intel.h
@@ -7,12 +7,12 @@
  *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
  *
  *
  */
 
 #include <stdint.h>
 
 struct vendor_ocf;
-struct vendor_evt;
+struct evt_vendor;
 
 const struct vendor_ocf *intel_vendor_ocf(uint16_t ocf);
-const struct vendor_evt *intel_vendor_evt(const void *data, int *consumed_size);
+const struct evt_vendor *intel_evt_vendor(const void *data, int *consumed_size);
diff --git a/monitor/msft.c b/monitor/msft.c
index d41f10d68a96..1fd13cf88ea0 100644
--- a/monitor/msft.c
+++ b/monitor/msft.c
@@ -364,23 +364,23 @@ static void msft_evt(struct timeval *tv, uint16_t index,
 						" (0x%2.2x)", code);
 
 	if (code_func)
 		code_func(data, size);
 	else
 		packet_hexdump(data + 1, size - 1);
 }
 
-static const struct vendor_evt vendor_evt_entry = {
+static const struct evt_vendor evt_vendor_entry = {
 	0x00, "Extension", msft_evt, 1, false
 };
 
-const struct vendor_evt *msft_vendor_evt(void)
+const struct evt_vendor *msft_evt_vendor(void)
 {
-	return &vendor_evt_entry;
+	return &evt_vendor_entry;
 }
 
 bool msft_event_code_valid(uint8_t code)
 {
 	int i;
 
 	for (i = 0; evt_table[i].str; i++) {
 		if (evt_table[i].code == code)
diff --git a/monitor/msft.h b/monitor/msft.h
index ff6c28011018..8ecc925add80 100644
--- a/monitor/msft.h
+++ b/monitor/msft.h
@@ -178,13 +178,13 @@ struct msft_evt_monitor_device {
 	uint8_t  subevt;
 	uint8_t  addr_type;
 	uint8_t  addr[6];
 	uint8_t  handle;
 	uint8_t  state;
 } __attribute__((packed));
 
 struct vendor_ocf;
-struct vendor_evt;
+struct evt_vendor;
 
 const struct vendor_ocf *msft_vendor_ocf(void);
-const struct vendor_evt *msft_vendor_evt(void);
+const struct evt_vendor *msft_evt_vendor(void);
 bool msft_event_code_valid(uint8_t code);
diff --git a/monitor/packet.c b/monitor/packet.c
index 0d3b23cc3fb7..08051f434ba2 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -11131,46 +11131,46 @@ static const struct vendor_ocf *current_vendor_ocf(uint16_t ocf)
 		return intel_vendor_ocf(ocf);
 	case COMPANY_ID_BROADCOM:
 		return broadcom_vendor_ocf(ocf);
 	}
 
 	return NULL;
 }
 
-static const struct vendor_evt *current_vendor_evt(const void *data,
+static const struct evt_vendor *current_evt_vendor(const void *data,
 					uint8_t size, int *consumed_size)
 {
 	uint16_t manufacturer;
 	uint8_t evt = *((const uint8_t *) data);
 
 	if (msft_event_prefix_match(data, size)) {
 		*consumed_size = index_list[index_current].msft_evt_len;
-		return msft_vendor_evt();
+		return msft_evt_vendor();
 	}
 
 	/* A regular vendor event consumes 1 byte. */
 	*consumed_size = 1;
 
 	if (index_current < MAX_INDEX)
 		manufacturer = index_list[index_current].manufacturer;
 	else
 		manufacturer = fallback_manufacturer;
 
 	switch (manufacturer) {
 	case COMPANY_ID_INTEL:
-		return intel_vendor_evt(data, consumed_size);
+		return intel_evt_vendor(data, consumed_size);
 	case COMPANY_ID_BROADCOM:
-		return broadcom_vendor_evt(evt);
+		return broadcom_evt_vendor(evt);
 	}
 
 	return NULL;
 }
 
-static const char *current_vendor_evt_str(const void *data, uint8_t size)
+static const char *current_evt_vendor_str(const void *data, uint8_t size)
 {
 	uint16_t manufacturer;
 
 	if (msft_event_prefix_match(data, size))
 		return "Microsoft";
 
 	if (index_current < MAX_INDEX)
 		manufacturer = index_list[index_current].manufacturer;
@@ -13791,27 +13791,27 @@ static void le_meta_event_evt(struct timeval *tv, uint16_t index,
 			subevent_data = &le_meta_event_table[i];
 			break;
 		}
 	}
 
 	print_subevent(tv, index, subevent_data, data + 1, size - 1);
 }
 
-static void vendor_evt(struct timeval *tv, uint16_t index,
+static void evt_vendor(struct timeval *tv, uint16_t index,
 				const void *data, uint8_t size)
 {
 	struct subevent_data vendor_data;
 	char vendor_str[150];
 	int consumed_size;
-	const struct vendor_evt *vnd = current_vendor_evt(data, size,
+	const struct evt_vendor *vnd = current_evt_vendor(data, size,
 								&consumed_size);
 
 	if (vnd) {
-		const char *str = current_vendor_evt_str(data, size);
+		const char *str = current_evt_vendor_str(data, size);
 
 		if (str) {
 			snprintf(vendor_str, sizeof(vendor_str),
 						"%s %s", str, vnd->str);
 			vendor_data.str = vendor_str;
 		} else {
 			vendor_data.str = vnd->str;
 		}
@@ -13826,17 +13826,17 @@ static void vendor_evt(struct timeval *tv, uint16_t index,
 	} else {
 		uint16_t manufacturer;
 
 		if (index_current < MAX_INDEX)
 			manufacturer = index_list[index_current].manufacturer;
 		else
 			manufacturer = fallback_manufacturer;
 
-		vendor_event(manufacturer, data, size);
+		event_vendor(manufacturer, data, size);
 	}
 }
 
 struct event_data {
 	uint8_t event;
 	const char *str;
 	void (*func) (struct timeval *tv, uint16_t index, const void *data,
 							uint8_t size);
@@ -13993,17 +13993,17 @@ static const struct event_data event_table[] = {
 	{ 0x56, "Inquiry Response Notification",
 				inquiry_response_notify_evt, 4, true },
 	{ 0x57, "Authenticated Payload Timeout Expired",
 				auth_payload_timeout_expired_evt, 2, true },
 	{ 0x58, "SAM Status Change" },
 	{ 0x59, "Encryption Change v2",
 				encrypt_change_evt_v2, 5, true },
 	{ 0xfe, "Testing" },
-	{ 0xff, "Vendor", vendor_evt, 0, false },
+	{ 0xff, "Vendor", evt_vendor, 0, false },
 	{ }
 };
 
 void packet_new_index(struct timeval *tv, uint16_t index, const char *label,
 				uint8_t type, uint8_t bus, const char *name)
 {
 	char details[48];
 
diff --git a/monitor/vendor.c b/monitor/vendor.c
index ecbfcf2eb817..9942e3d735d8 100644
--- a/monitor/vendor.c
+++ b/monitor/vendor.c
@@ -12,12 +12,12 @@
 #ifdef HAVE_CONFIG_H
 #include <config.h>
 #endif
 
 #define _GNU_SOURCE
 #include "packet.h"
 #include "vendor.h"
 
-void vendor_event(uint16_t manufacturer, const void *data, uint8_t size)
+void event_vendor(uint16_t manufacturer, const void *data, uint8_t size)
 {
 	packet_hexdump(data, size);
 }
diff --git a/monitor/vendor.h b/monitor/vendor.h
index 996ed44cb18e..1ce42a645096 100644
--- a/monitor/vendor.h
+++ b/monitor/vendor.h
@@ -17,18 +17,18 @@ struct vendor_ocf {
 	void (*cmd_func) (uint16_t index, const void *data, uint8_t size);
 	uint8_t cmd_size;
 	bool cmd_fixed;
 	void (*rsp_func) (uint16_t index, const void *data, uint8_t size);
 	uint8_t rsp_size;
 	bool rsp_fixed;
 };
 
-struct vendor_evt {
+struct evt_vendor {
 	uint8_t evt;
 	const char *str;
 	void (*evt_func) (struct timeval *tv, uint16_t index,
 				const void *data, uint8_t size);
 	uint8_t evt_size;
 	bool evt_fixed;
 };
 
-void vendor_event(uint16_t manufacturer, const void *data, uint8_t size);
+void event_vendor(uint16_t manufacturer, const void *data, uint8_t size);

-- 
2.34.1

