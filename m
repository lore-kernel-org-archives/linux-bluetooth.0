Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECA9368D4A
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 03:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789357403; cv=none; b=gvHrKv6wx8ANhMK+PYD0rMHh06q0UyWWsPjVWSkW8izGUUF22CcAaHn6/2I3jLDxxQ3OySxOLmAfq/0p0c44WzugVY54Clrex6ngljH51jW2gziEzh2c789TGd13jGmbpmTYN9YM1JLXJXcu194m5tbVKwkIp21iWUfrvo4XT1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789357403; c=relaxed/simple;
	bh=w579INk5HIY4CFkQ0m15JvuCIyvCxdEX8EntRbAN1lk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o5WsXK5/uFQ4CoiJP/IuaWoHduUD6z6hkojI7HY7VesvL6rS2hmqZJqFDketMeSk/jU1yy6eR8N/7q/xo8jLP8H6X4RHXWYZojPykrQhpvlwMT7Py1M6Vuc+iDl9aVu6rcwyA/MEK+btA16au+pSW+UQKMreBXIvvBnAV2/3STA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ROULYNen; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZnOfsUeW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ROULYNen";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZnOfsUeW"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E2edqA3511297
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 03:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UYkjE/aA061mfOcjRAR+umhJu7g5L7SSr1+2F6cUv+A=; b=ROULYNen02/KzOSj
	gKahloS2im7tNBizSnmtQ1yfHiEp11Zyt3xEyeT076w2NWr7nQILoba+Lj/d3uFp
	gEzC8kFH4ktgPL08LEeYEIzvmSY9MrtRTtTDDUPQnXqn9siqOcyUz3sOOSKM+Y60
	KcXds6J1SywgMw1aFNK+UWBbXoF+TclBfcj8EWk2J/GrsZah1c3SZeAXrj+FN4TY
	fLL36IcjAEbtw2dT0XkXA8t4amzzJPf33CRizGxDEfAFN6R1Y4KNJ7BMi5HhB9QC
	zwMcJBCrBVnC+4ivJaKFZ8zaGWJJLE7duRwf2HH8jny7RpP2uUJQKkQxIMBQTKPr
	udlckw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9d4vp6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 03:43:21 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e8d1600b3so805285a91.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2026 20:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789357401; x=1789962201; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UYkjE/aA061mfOcjRAR+umhJu7g5L7SSr1+2F6cUv+A=;
        b=ZnOfsUeWGkPuQbQykMykCG1BGXmI3wboHPPLAvW5AkSlEHI5OaNdVDeEp9VaNmbgPd
         qIv3rrqF0BZhyZSMeg6G6SVgVDZOM5LUYx4/ZbVoVcE5CqLxc/O43nhfjcn74fLZBuDe
         hzVkyqrD/TaB9eXr16HDgwQEgp+U2dHZTe8MSusWzuFtM2su3cvLMOFBhCtxyqxFvPJI
         QkHmQ5h+4gaFDfzHvlLUv3ujwJ5rvI+WTcwvUnMkfpjzI0EPYsdhJO0qpQWkodCyjB9L
         S6nw2I0mhydw9fe6RqnwerfGzgTuNyKeeDqUCGKb6tbfxFmONK6fse0Yo3YizWEcIfsF
         uvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789357401; x=1789962201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UYkjE/aA061mfOcjRAR+umhJu7g5L7SSr1+2F6cUv+A=;
        b=XV372vzbrK9u4zRtQ37ZsFmDnlaO5x3JfipUzZoEHInWhIwrlmGwTvNtQTwH3+r1AN
         AL3XpjFMGKDphHjasPPcUCyXFae4tre4pf/6bEi9PQr3CohmRnNyEd0YCw6ubv0BWBoS
         fulU/PWmfFTgS76SJ4cPKnx0QUwcnoQqqoWkrHuwuhAZyvNk7WXc5+Ms1ExKGmD96poH
         cLZ0ZWQiWWagZnCRsHKu22sXMFxYCB6bi/mNwflr8GOn3aK0X2/NOti/P9adYqQrMiEo
         MNYK7wpvSEEuWakia+gkNJu7BnX5cblOfPd87+m1D4VXvHxs/feOz57fFH8kKCDmpae8
         jUPA==
X-Forwarded-Encrypted: i=1; AKwUvBwCPezlBYHOAVvAK2D0u9UREjMaC7YvoRtoz131DE+YHaAus3t8X9gGMecoNeboJEItNivtmFqUHzgr0A19d28=@vger.kernel.org
X-Gm-Message-State: AFuF++n2m36bj0IyS8dk9Gj+sKQnwVOF15wpRhaVjXyupNpiPr7kergq
	0YDAOV3FXhAi2KNlzuPdJZQgvQp92EjKEMyjctIwkP6ftDajgb6DSWjCwyRAFMZAjNrZ4PXJjUp
	JZnk2V9rhdzw6MuOBq9SN2del/wKs/jeJS4TzMGdUcUI2uhkZLvKjq4TbUzWDlVKiLtkvMTE=
X-Gm-Gg: AYBFou3SmBlq4YDlLPBiaoDDL0XgrJDznNT/pABmFpUcnykcgUYGjVo6CzymcM0cC7M
	d580ICuMbzVLA72YO+fR0q5p36GTcrq/SEjrspIJzLJtYqcFaqGBTUrd71W87wCooEmh1/gxkC2
	wjhLDFgRdaOg6ras3LkWh2WcqGVOUsCMVCQ9+kLYHQkHtd/1nNgWiYTl+WoizNP8q/bJb4CIV/i
	q0dgQb/rSlmFu6AG19iiXqIlnrVKXibfMFbsiKusx13VwxpimfHXMOkUQZNkg2eTPGzfBP8g/k5
	VjWfbKPwvZOBC75OQ6qPNMukJL14eYX6vSMPxIkEsM8IGNz9yYUF8uc8HQuGlal777a/6f7uN+l
	jttA6wGqSQroyZIpnGh2le+5DZ6FO0ucsbNwKbCshYsuUWr4=
X-Received: by 2002:a17:90a:d88b:b0:398:bac0:238d with SMTP id 98e67ed59e1d1-39dec21ea0cmr1125540a91.5.1789357400597;
        Sun, 13 Sep 2026 20:43:20 -0700 (PDT)
X-Received: by 2002:a17:90a:d88b:b0:398:bac0:238d with SMTP id 98e67ed59e1d1-39dec21ea0cmr1125502a91.5.1789357400138;
        Sun, 13 Sep 2026 20:43:20 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4ee07f2sm21250894eec.18.2026.09.13.20.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 20:43:19 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sun, 13 Sep 2026 20:42:58 -0700
Subject: [PATCH 3/4] Bluetooth: hci_event: Use 254 as max LE Meta subevent
 payload length in hci_le_ev_table[]
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-misc_fix-v1-3-558c1e4028b9@oss.qualcomm.com>
References: <20260913-misc_fix-v1-0-558c1e4028b9@oss.qualcomm.com>
In-Reply-To: <20260913-misc_fix-v1-0-558c1e4028b9@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA0OSBTYWx0ZWRfX3v6dZ9Nhi4TG
 OdfpVILsWPEpXt0eEJTlUJ614RO80ZesJ9QzpgQZoq8xUfj+NWfl3Ff7rvcL9D3e9l2dBXD3D17
 K7TdCBwZY2WP58GMUrUjVVgwu1/Y4Rg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA0OSBTYWx0ZWRfX87F6TN5bcTFM
 muMZoVfzpcsbkZUs3XI65kvPsPV1g74YTD7+u8pklC+17oDCxDB7S4mdtccmetGZXhrVt/xSdc1
 qQwOdW2XHmVoCQcUil4S7Xx3jT8jggVBrxct4FqANO3Wr/hSae59V4Q8HM2Y3Bxi4PLLrV6nrTN
 sKOi6Uuk0SQTbMuACIRdiTZyZiojX23Zxya/Qi7zasOfB6Akimm+TXRg6C8vP6XBAimp/fXLFCE
 MCTUmQcKXlMFcwNt0+1tX6yeAmR7W1P+oRC9Ox6H320mfdJyF8MvZbUreokTwbCafDCoYDXs490
 Jn9cR8zXjdKILuYk/SkdgTqQB97N/z+h8lXlMbpK496Il6t+CLL8jKxAB2VxppKj7b/LISNqGyj
 DPASw3PkyjGaEuDiUJsXbe34mb3/AAhKzF0E7JY3J8qpP9W4IsA0d/nDMK/ypwZ9iAk82FKIUvS
 UnFSYMZF+WD81sw+Fkw==
X-Authority-Analysis: v=2.4 cv=IOSXmQvG c=1 sm=1 tr=0 ts=6aa76d59 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=A2jjY7DYbelx_RivTkEA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: TFxr9LNVEAXBYNCivaLRN7WIHC2g_Ext
X-Proofpoint-GUID: TFxr9LNVEAXBYNCivaLRN7WIHC2g_Ext
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_01,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140049

hci_le_meta_evt() validates skb->len against subev->max_len from the entry
in hci_le_ev_table[], By then, the HCI event header and LE Meta subevent
header have already been stripped by skb_pull(), So the max LE Meta
subevent payload is 254, but hci_le_ev_table[] still uses
HCI_MAX_EVENT_SIZE (260) for it, which is imprecise.

Fix by defining HCI_MAX_LE_SUBEVT_PLEN (254) and using it instead.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 net/bluetooth/hci_event.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 03b805207ab0..1eacdd93c5b5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7469,33 +7469,36 @@ static void hci_le_conn_rate_change_evt(struct hci_dev *hdev, void *data,
 }
 
 #define HCI_LE_EV(_op, _func, _len) \
 	HCI_LE_EV_VL(_op, _func, _len, _len)
 
 #define HCI_LE_EV_STATUS(_op, _func) \
 	HCI_LE_EV(_op, _func, sizeof(struct hci_ev_status))
 
+#define HCI_MAX_LE_SUBEVT_PLEN \
+	(HCI_MAX_EVENT_PLEN - sizeof(struct hci_ev_le_meta))
+
 /* Entries in this table shall have their position according to the subevent
  * opcode they handle so the use of the macros above is recommend since it does
  * attempt to initialize at its proper index using Designated Initializers that
  * way events without a callback function can be omitted.
  */
 static const struct hci_le_ev {
 	void (*func)(struct hci_dev *hdev, void *data, struct sk_buff *skb);
 	u16  min_len;
 	u16  max_len;
 } hci_le_ev_table[U8_MAX + 1] = {
 	/* [0x01 = HCI_EV_LE_CONN_COMPLETE] */
 	HCI_LE_EV(HCI_EV_LE_CONN_COMPLETE, hci_le_conn_complete_evt,
 		  sizeof(struct hci_ev_le_conn_complete)),
 	/* [0x02 = HCI_EV_LE_ADVERTISING_REPORT] */
 	HCI_LE_EV_VL(HCI_EV_LE_ADVERTISING_REPORT, hci_le_adv_report_evt,
 		     sizeof(struct hci_ev_le_advertising_report),
-		     HCI_MAX_EVENT_SIZE),
+		     HCI_MAX_LE_SUBEVT_PLEN),
 	/* [0x03 = HCI_EV_LE_CONN_UPDATE_COMPLETE] */
 	HCI_LE_EV(HCI_EV_LE_CONN_UPDATE_COMPLETE,
 		  hci_le_conn_update_complete_evt,
 		  sizeof(struct hci_ev_le_conn_update_complete)),
 	/* [0x04 = HCI_EV_LE_REMOTE_FEAT_COMPLETE] */
 	HCI_LE_EV(HCI_EV_LE_REMOTE_FEAT_COMPLETE,
 		  hci_le_remote_feat_complete_evt,
 		  sizeof(struct hci_ev_le_remote_feat_complete)),
@@ -7508,33 +7511,33 @@ static const struct hci_le_ev {
 		  sizeof(struct hci_ev_le_remote_conn_param_req)),
 	/* [0x0a = HCI_EV_LE_ENHANCED_CONN_COMPLETE] */
 	HCI_LE_EV(HCI_EV_LE_ENHANCED_CONN_COMPLETE,
 		  hci_le_enh_conn_complete_evt,
 		  sizeof(struct hci_ev_le_enh_conn_complete)),
 	/* [0x0b = HCI_EV_LE_DIRECT_ADV_REPORT] */
 	HCI_LE_EV_VL(HCI_EV_LE_DIRECT_ADV_REPORT, hci_le_direct_adv_report_evt,
 		     sizeof(struct hci_ev_le_direct_adv_report),
-		     HCI_MAX_EVENT_SIZE),
+		     HCI_MAX_LE_SUBEVT_PLEN),
 	/* [0x0c = HCI_EV_LE_PHY_UPDATE_COMPLETE] */
 	HCI_LE_EV(HCI_EV_LE_PHY_UPDATE_COMPLETE, hci_le_phy_update_evt,
 		  sizeof(struct hci_ev_le_phy_update_complete)),
 	/* [0x0d = HCI_EV_LE_EXT_ADV_REPORT] */
 	HCI_LE_EV_VL(HCI_EV_LE_EXT_ADV_REPORT, hci_le_ext_adv_report_evt,
 		     sizeof(struct hci_ev_le_ext_adv_report),
-		     HCI_MAX_EVENT_SIZE),
+		     HCI_MAX_LE_SUBEVT_PLEN),
 	/* [0x0e = HCI_EV_LE_PA_SYNC_ESTABLISHED] */
 	HCI_LE_EV(HCI_EV_LE_PA_SYNC_ESTABLISHED,
 		  hci_le_pa_sync_established_evt,
 		  sizeof(struct hci_ev_le_pa_sync_established)),
 	/* [0x0f = HCI_EV_LE_PER_ADV_REPORT] */
 	HCI_LE_EV_VL(HCI_EV_LE_PER_ADV_REPORT,
 				 hci_le_per_adv_report_evt,
 				 sizeof(struct hci_ev_le_per_adv_report),
-				 HCI_MAX_EVENT_SIZE),
+				 HCI_MAX_LE_SUBEVT_PLEN),
 	/* [0x10 = HCI_EV_LE_PA_SYNC_LOST] */
 	HCI_LE_EV(HCI_EV_LE_PA_SYNC_LOST, hci_le_pa_sync_lost_evt,
 		  sizeof(struct hci_ev_le_pa_sync_lost)),
 	/* [0x12 = HCI_EV_LE_EXT_ADV_SET_TERM] */
 	HCI_LE_EV(HCI_EV_LE_EXT_ADV_SET_TERM, hci_le_ext_adv_term_evt,
 		  sizeof(struct hci_evt_le_ext_adv_set_term)),
 	/* [0x18 = HCI_EVT_LE_PAST_RECEIVED] */
 	HCI_LE_EV(HCI_EV_LE_PAST_RECEIVED,
@@ -7545,38 +7548,38 @@ static const struct hci_le_ev {
 		  sizeof(struct hci_evt_le_cis_established)),
 	/* [0x1a = HCI_EVT_LE_CIS_REQ] */
 	HCI_LE_EV(HCI_EVT_LE_CIS_REQ, hci_le_cis_req_evt,
 		  sizeof(struct hci_evt_le_cis_req)),
 	/* [0x1b = HCI_EVT_LE_CREATE_BIG_COMPLETE] */
 	HCI_LE_EV_VL(HCI_EVT_LE_CREATE_BIG_COMPLETE,
 		     hci_le_create_big_complete_evt,
 		     sizeof(struct hci_evt_le_create_big_complete),
-		     HCI_MAX_EVENT_SIZE),
+		     HCI_MAX_LE_SUBEVT_PLEN),
 	/* [0x1d = HCI_EV_LE_BIG_SYNC_ESTABLISHED] */
 	HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_ESTABLISHED,
 		     hci_le_big_sync_established_evt,
 		     sizeof(struct hci_evt_le_big_sync_established),
-		     HCI_MAX_EVENT_SIZE),
+		     HCI_MAX_LE_SUBEVT_PLEN),
 	/* [0x1e = HCI_EVT_LE_BIG_SYNC_LOST] */
 	HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_LOST,
 		     hci_le_big_sync_lost_evt,
 		     sizeof(struct hci_evt_le_big_sync_lost),
-		     HCI_MAX_EVENT_SIZE),
+		     HCI_MAX_LE_SUBEVT_PLEN),
 	/* [0x22 = HCI_EVT_LE_BIG_INFO_ADV_REPORT] */
 	HCI_LE_EV_VL(HCI_EVT_LE_BIG_INFO_ADV_REPORT,
 		     hci_le_big_info_adv_report_evt,
 		     sizeof(struct hci_evt_le_big_info_adv_report),
-		     HCI_MAX_EVENT_SIZE),
+		     HCI_MAX_LE_SUBEVT_PLEN),
 	/* [0x2b = HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE] */
 	HCI_LE_EV_VL(HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE,
 		     hci_le_read_all_remote_features_evt,
 		     sizeof(struct
 			    hci_evt_le_read_all_remote_features_complete),
-		     HCI_MAX_EVENT_SIZE),
+		     HCI_MAX_LE_SUBEVT_PLEN),
 	/* [0x37 = HCI_EVT_LE_CONN_RATE_CHANGE] */
 	HCI_LE_EV(HCI_EVT_LE_CONN_RATE_CHANGE, hci_le_conn_rate_change_evt,
 		  sizeof(struct hci_evt_le_conn_rate_change)),
 };
 
 static void hci_le_meta_evt(struct hci_dev *hdev, void *data,
 			    struct sk_buff *skb, u16 *opcode, u8 *status,
 			    hci_req_complete_t *req_complete,

-- 
2.34.1

