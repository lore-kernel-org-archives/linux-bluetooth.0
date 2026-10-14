Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F92516170
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982996; cv=none; b=ZDYWz9pGTdBwy2xfUHpg8qv1dyoTUonzszLl7JvHnK4LX3FVWYcbvByrgbngiC661HWUvRi35MY6La5xjY/Lug04LoiKD9N+geLsGGDd63KU05mD5RObEeKOxiJERKyglYDhISKrjdjtHsoNDjQbmrel67i2q0BgvvaVEdfcOTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982996; c=relaxed/simple;
	bh=o3CLylce040Uzmfs746UWO9V4mjo6gjq7klcNZMuAik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fvdVbjE/HRVb11yIPd3bAdGba8jC1Sd6KsgNQwzGLNsnrpg+DLN7kpwTOP7MgpX45MP+3RaE+Dn0QyOKsmICLYqko9D1z4s0jvvYrJg6JC1g91gWWUzric/o9JHyfx5GifJJGpHYwGsrMzVAWIjcBOKBmzRtfMgrdkni/jc57aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NqIEWlTp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VfhcwsVZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NqIEWlTp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VfhcwsVZ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EBPCcV3365340
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 13:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f6GuRcuGOLcIK8U1i/42FXzU8VT6SBWZltoaozE4kyo=; b=NqIEWlTpj31oiWxd
	VyDcdIJj8hN4vD5SJQx92tB2Jj0meGvtc5ahP2salRE/mmW3MQAtDCcaFPJTdwJr
	vIvMOXNk3Kz742RCCT+YsYQlm/msQ4yqYu3RtVaa9oIOlEnzNzSZcuXAbIwkSGjm
	c/ZG06+0CuS5FFLcSn/Gl20RMvMhdtrZq0nNhM3fLab+kr7p1KTTcHssRanQ91Mb
	JdQFe1QiICXanOb2Gn4u0na/EKz7jMblM30ADgHkEYeiOy5i+GR+PUuCbCNvz4Ce
	arYcjFUwHepDgIcFfk5j/lG8ekSRfJtixneLEHFz/HzzoDsd1RgS4VO/Sm8bwPbs
	qIve4A==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4621pd5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 13:03:10 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5cf33256d2aso4971837e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 06:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791982990; x=1792587790; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f6GuRcuGOLcIK8U1i/42FXzU8VT6SBWZltoaozE4kyo=;
        b=VfhcwsVZ51wdKvHK0M3aldmagg0SB1fF/oZXBamuodWQn6Db4HB65FJ2zzK6vXRrrq
         nbo4S7a1JwPi5m1sv7PGVM6sRts+W4H+78+WcyzokIPOBDWSsxNTVZKip7pod23LkTjw
         K4iv2KIe4SZUwRxm1HHvzAM+r+dqI+DuB4lS8a1I5OArpvrfcTXCi/MiibFFq+Ch6/vv
         b8qHGIBbKeKj+w6UVhIgcKbn17u+3Gm8rDhlf6JdYimeMQjOop7X8/42DQkEZ59CgFJW
         j1hlGNXHA9vU0wyJHierGiOirB+tckTUFCpZ2xi8qDBxK49SnyVCeedJbtRIS9VbxgA/
         kVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791982990; x=1792587790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f6GuRcuGOLcIK8U1i/42FXzU8VT6SBWZltoaozE4kyo=;
        b=XlhmRgWcyqh1771sYBYxr/JNaUWnXLAO2EMAFFe+QfuX8ymd9lgusxur9Dr1wjd387
         PbTBezsOZzY5sYQ+quDEf+27NacK+j3JTZdBkOgBEghX1suaKKfGY99W0QWR/vsffDgm
         axYthRNrNnxfW/TxjMBB99IczNr8eykuW1Nt946sYfSM3Cwk+LpXpx+A2t4JAMy2FQaW
         SEsSvOH+5MJ+RLqTorYjU9ikitply5EJnnr36olgBThXn2d2zvaNHeLGHt03Pwf0iEZ4
         pj2Mt9566goGwpHBW6Q7DBe/oTqmgpHJepO6rp7R6y75d2xh7hGFHLuKLMe+VXp0oagG
         SHIg==
X-Forwarded-Encrypted: i=1; AKwUvByY2uZvVIdPoX5XCMtbrYKbj7XaibaK0iU3oU0PbOdLNPTG0+UUzL0ULlxx1ttlX0zIQwKXlHds27Pw0NZRPNY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKyIoYV/ik5VRX7fE2SpU6CUdw0agqHDKL/b6TX8VzYaYmg1GgI
	c5ozreraTH2zxTyHaaB6p9R4ZJJOKTrX1kEebjIsuQw5lONtVbzBsYkoIdM6Ug3GN4frk9TssrF
	qgdcrpHoAmAnRlmzLgumgDo8UA6x3RYv5clUytaG/r0vX9e/nDM3l95qfx7WO9gSpm/GZ8I4=
X-Gm-Gg: AYBFou16PV8LvHBLGYCthJUzdFZr9/juTNHaBoH5y6OpmkNsWFirLkhlVT05mWsb96d
	J/R9VcFgzV1f8ix62u4sEJRYtkPV2V9qRglaUo7rYHJxR0uxu3CnnProMLdZENWpjWr67ewbAXQ
	3dWNHkh2up3FieNdEKYP75EUGdxdCzlAErrsTjt175MYjSubaTzpI8PSP3E82AQzhYl/QQUEoBu
	Kz0gyPK2dIxME0d87ge3qSIFCa/qrLGDUQkg5vOtDRfrnTMT/TY8Sm/uVS9RmAxDwRe9yEtL+QB
	NLfHEcD6gvvkxRAezy3wTxiNCbZMBaiywpG88eNn5/ZuUiGCv/kVQ+/VEMIrpZGk+QOLE6tFthJ
	8PO6AJPz67A==
X-Received: by 2002:a05:6122:6004:b0:5cf:dd67:cb32 with SMTP id 71dfb90a1353d-5e91e5b32e8mr2980450e0c.6.1791982989213;
        Wed, 14 Oct 2026 06:03:09 -0700 (PDT)
X-Received: by 2002:a05:6122:6004:b0:5cf:dd67:cb32 with SMTP id 71dfb90a1353d-5e91e5b32e8mr2980426e0c.6.1791982988613;
        Wed, 14 Oct 2026 06:03:08 -0700 (PDT)
Received: from [127.0.1.1] ([86.121.170.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bcece106sm567795e9.9.2026.10.14.06.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:03:06 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 16:02:42 +0300
Subject: [PATCH RFC 4/5] wifi: ath12k: Support MAC address from the
 firmware node
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-b4-nvmem-efivar-v1-4-187c85f65018@oss.qualcomm.com>
References: <20261014-b4-nvmem-efivar-v1-0-187c85f65018@oss.qualcomm.com>
In-Reply-To: <20261014-b4-nvmem-efivar-v1-0-187c85f65018@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2249;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=o3CLylce040Uzmfs746UWO9V4mjo6gjq7klcNZMuAik=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBqz318DQUQZj2g3zPetmcXTmEY2JotdT6sE/6vQ
 tfCBrH1k8mJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCas99fAAKCRAbX0TJAJUV
 VqqnD/wP5JoMwF0ih0vuQgLKP4VIUS96MyhSknO+sjN/Q9Q0BrULeCLswkUyfHTEpsR2Ck1Uevx
 Da3W8gUrShICjvJ4HUdEgOa3vej4kDHzMvVWof6koUhvLnFoeTP6gmyuaNI0e46aFhaqsOroVgu
 yQUVpu5+grq0ES9g+Rdz0Xp8T5sF3iU9Pr9Rk9xcZhZc7hJFdjeriffHikx0qswUGhg3dOoKIHd
 dOIdJAQ9H222ZSuUCOSyTLItTNs6lOb7vDo8OnLIfcakNC8Aywh9AZZnjT8va7G2Rk2DAoDwVYa
 iTesV0M+K/CW5ek8DOSiCwfOFx5cU0EoQHRQOmphakzLzQsU3nMV/gKmgbUeLkfUum2jn8z+38+
 dvu+0FsKanxH/fzteGSNH0QUnTYIDO2vI78BqsqW/RwyNl9bSDSspaisBgbzLosu/Avsfg4abQ1
 M2oia5hnYq9HrYApIxBtivHJLVD7D7tPAu+TFTKW1EDLIEsClDug0TspuRAwpG7/Dw4ZmVX85ok
 4afY1xGZXXvSjUU7RWHD9j+OpsLgz/JK38pL/bB3wPI3zlAvmSI7WAu1JcHeluS8AQ8bjbZf+m+
 JTUb/Q4nAq8SfY/7o9IgJH+rdO1XZHPE0WaglSCFiF9X8S3YGz+t9R5y8HtRu7uuXBhaw/P4jo7
 vnrZnX8znYCQtRg==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-ORIG-GUID: Frn1WIJqDRYtcQtYIUBGZtz8RXVx1CWw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MSBTYWx0ZWRfX7uccO+k9oBT3
 FXu/afcSuBqARuodz+codrN6sBwP7m0zUcoRnAkinkE12PxmdX8AwYlNLx3u6XKanzbVicH64sS
 yAorX82VDV6zFYucBC8EfyGxi58r5sFLvfERenrOhhYlif7LmiviDhSkgEEWP1sB4GpLGomL3uy
 nevyO95nKXaLarK7zSOd3bMKOzLSDRhGaHoz5F4acviKJw1RTyZcePUFW14mjseRv+awiBnL/jN
 peWQ2cVCNoHW8cbpUdsFHt03mqtp9L8lnx2sMXZjssA23qO4x4hNzIzIIREWbhOdIVsxKKPOEFO
 rzVgCtzLDmu59+VDsJTfO54Ua/MIh7cQEevxAYeA6ulV7niL4NglkQgI/SN1ZLY5HiW2si1psXV
 zFqMd3+O4E33rJSSvePlwKC+8b4WwGmLM9dTiLU1eaWNo1QxIWQqE1DRAKAeq5lFmB+1TBWF9z5
 BDZ5sUHA4he0X2T39Tw==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6acf7d8e cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=Rt3kCFFBWhWisHNmluDamg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=miyTlQIDcyHKYiHs0IUA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MSBTYWx0ZWRfX6681nkN2hQ3b
 pZW8kGW7tZ1qJ9EnJrdRCN4j22Wc9DDom82OyrYsIPjybz6wcPHa+0UNhSGD2shIO8j06JwbmH6
 DEd0ZG09XHGhs5NhWfiZccBJtiUJves=
X-Proofpoint-GUID: Frn1WIJqDRYtcQtYIUBGZtz8RXVx1CWw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140051

Read a MAC address from the device's firmware node (a DT "mac-address"/
"local-mac-address" property, or an nvmem cell named "mac-address" via
device_get_mac_address()), and use it in preference to the address from
the firmware board data. This mirrors what ath10k and ath11k already do
and lets the WLAN MAC be sourced from firmware-provisioned storage such
as a UEFI variable exposed through nvmem.

A device tree / nvmem address takes precedence over the board-data MAC,
so an explicitly provisioned address wins even when the firmware reports
a valid per-pdev address. An all-zero (absent) address is ignored.

Note: the provisioned address must be a valid unicast MAC; a multicast
address (odd first octet) is rejected by nvmem_get_mac_address().

Assisted-by: LLM
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 01f8c6572f65..f4d2d0377c8e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -14878,15 +14878,27 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	u32 ht_cap = U32_MAX, antennas_rx = 0, antennas_tx = 0;
 	bool is_6ghz = false, is_raw_mode = false, is_monitor_disable = false;
 	u8 *mac_addr = NULL;
+	u8 mac_from_dt[ETH_ALEN] = {};
 	u8 mbssid_max_interfaces = 0;
 
 	wiphy->max_ap_assoc_sta = 0;
 
+	/*
+	 * Allow a MAC address provided through the device tree (directly or
+	 * via an nvmem cell named "mac-address") to override the one from the
+	 * firmware board data.
+	 */
+	device_get_mac_address(ab->dev, mac_from_dt);
+
 	for_each_ar(ah, ar, i) {
 		u32 ht_cap_info = 0;
 
 		pdev = ar->pdev;
-		if (ar->ab->pdevs_macaddr_valid) {
+		if (!is_zero_ether_addr(mac_from_dt)) {
+			/* A device tree / nvmem address takes precedence. */
+			ether_addr_copy(ar->mac_addr, mac_from_dt);
+			ar->mac_addr[4] += ar->pdev_idx;
+		} else if (ar->ab->pdevs_macaddr_valid) {
 			ether_addr_copy(ar->mac_addr, pdev->mac_addr);
 		} else {
 			ether_addr_copy(ar->mac_addr, ar->ab->mac_addr);

-- 
2.54.0

