Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779EE35AC12
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451191; cv=none; b=GkzkCDCNAMM2QWDNSulPu4BhJX1aPAxozMXbixUye4LO7LKJM8y5TiaMYONP+KD4ak+qY3Z7XfxDYkIechA/z2/eyqUXlqI2KaBQDTBo/Xw86/oKKo/nlRbjd8L11t6/tLIdvp5X7G2Lowm7hyufkle87ZRyviC4rJwXI5YToz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451191; c=relaxed/simple;
	bh=jTg9E1ynP2Qq1NFZ+ziPA7X/SBa1iI8s+zldG2gCtgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PteB4l/fqk0HMar8aN7+2irfc2Xe2V8dCxEm/gG27My5MR3bz22l5E2jy2MwVwk9+FfRfXK0bq2/Iu3MeKsZFYY+KG0kpWvQc0NN47CAMXpyFEMapKaswwzBXsw1ON+wLr22K9ORjwitNg8izvunE9w5hosydAGxsbFqQv7lpYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eENWCJGO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KsWr5hPe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eENWCJGO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KsWr5hPe"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q41VdQ3787633
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DfD9IhxO3rTPNCWLoLKKynmSB/NaD1BEuSysuzreQxg=; b=eENWCJGOFIiqkLHX
	Vn9X5WbU8WVNsb3Zrr5vrewSSYosfBPNapL3xgaJQ3CA8hzBI2Ue5GfV2VxM955a
	QsZHiwqd1FFA20bnBQlyc2iZwKVOJJHxt265xAIBuJHmMI0jMw6v2i67qPC4ljto
	yUTiqTXVS+XI3V6yWhvb+QN61/heicaty7FXciTwPYuDINtHEX8Jvb7fVug6h9vg
	Ss6inTB/R7DsZXdhz6iUSytb+ZnH6b2g5JSQClv+PbCq0AE/adbjwqOtANQ2HQ9S
	rCbi8XWjthaJz33ZxCb0tZaTUNH4Sp+uwRpr6L6rG8lRXEU0S8B1TrtERrrdY0y0
	O8VQaQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1j1nga6x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:49 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30b7fe4d3f8so78141eec.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 22:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782451189; x=1783055989; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DfD9IhxO3rTPNCWLoLKKynmSB/NaD1BEuSysuzreQxg=;
        b=KsWr5hPebuelStGGV75zNQ3UugS2fJdAQL8D5eYdot05JDIQLpJpVngrzEwsuwP91W
         NwxefgolUcCYaIZUZOq43aFEYC7DTynsDNFSNS3Z9Om02TUY7w/6vxglNnM3eCbl1TPZ
         wCA4/pf/xZb8DhxPpnehjmG6BvLYrK34yqSARWaIXukFkl3ecIifWq/YPBX/ukTZsdkT
         PePVKPazqfxQTYOLSNEquX5PceDT5mMFh27gFXpCZZAKXTTwpRVYHjk+qwTlOAE99Jg4
         HBqbainYACU56TzD4f/+PChWbgOFI1NZuMHHKiHk2nx6PaQN+mpWxcPZSfP/qZUd3KzI
         mIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451189; x=1783055989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DfD9IhxO3rTPNCWLoLKKynmSB/NaD1BEuSysuzreQxg=;
        b=AaGwBz9Hiu2E/+lADejE7I5NWC/MDi73Pc7vS5QvT42b7wH/bog1LnSAyKUdCFKbz1
         k+RY+D8rjO2jh0WWqys/k/HLMEadngAHtL+yAG1SZ+HkuzpjClOX3ctbTVHN+1zP4J7z
         9ioTqVFWSVaWTx4nghA9NgfWFWIPxceTG0LNdCN8cHVr+zZkZ36MzVcS4gCblRBsRgK9
         tLEWCikAbuSy14oPD22JOydC8+v8DYOj0lUO+IGxF5yk3q5OtFKwMPiLxu327cXIEQ7W
         SoqTyrfSz5+BbPxJTzB5b8L4tuUsbGtj0u4DrIxh3MnfDmYPbjdxdkkLCmckUT1Pc0SS
         +i2Q==
X-Forwarded-Encrypted: i=1; AHgh+RoPb+iT5hiFSApRvK2RmFjDnGH5kD8GGUIuMI7xzMzNEDA1809IuRdSO4OsL169VnshKzKfHG9BL8/oChMOV3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAMnS27O9jsKlctXXcVF7CTguQmjszdmmAGglia4aj9Rhh1IMs
	sXvLI5N3g7gZDTjN5J360FpJksd3uCLKgU9wahrRbT/qWL7+EldKZQWl1feJzBGV9fgvR0T9d2r
	Udmy/DQOZQHVOkl4TmGwPzdAvj7UZds2wrMw4tE/7MApXYlC7pkZ+I7eaa68DDrwZwHxGlBQ=
X-Gm-Gg: AfdE7clgYiaMIlEvubQw+tTFpj0TLB2uqRhrk8zSwQjc6oDiXsCAshImTpox6r3SpUe
	4LgFB0O7nHoR4R7TCdrx1AE7ruEEkztNWIz+uwiYyd1EO4StE7N4Qfglb8u2JDNeDKBugzokYM0
	jPl23nT7Mw1r1Dowk3pP/YPoltMsJJC+54fwQOq3k7yqoUnF8OfxqXIJpwgCg6W0TaV9gcbLpnC
	BtWaHH5IWyRkiBTC0KF2OdB0U+tJQwqvhSRnqy4DZufmyD7czWuecT3iaaFG9miVTB040cdtsiB
	4naUof6e+l4olZfDcfzPDMfOMi+sHKl5KjByPQUCVJmTxX8eRkzC8FCgSDEImX3IPjPrdpmdsTD
	I5xXtETdxIrO3d3LqXQGndmWGeAFJBe4O/T58HELjwpnhhRNSPu5zZ9Jwdg==
X-Received: by 2002:a05:7300:7c21:b0:30c:52ab:806 with SMTP id 5a478bee46e88-30c84c92cd1mr2773118eec.4.1782451189092;
        Thu, 25 Jun 2026 22:19:49 -0700 (PDT)
X-Received: by 2002:a05:7300:7c21:b0:30c:52ab:806 with SMTP id 5a478bee46e88-30c84c92cd1mr2773100eec.4.1782451188541;
        Thu, 25 Jun 2026 22:19:48 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4ca240sm14345291eec.4.2026.06.25.22.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:19:48 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 22:19:46 -0700
Subject: [PATCH v2 01/12] Bluetooth: btqca: Fix qca_set_bdaddr() waiting
 for wrong HCI event
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-bt_bugfix-v2-1-93396a6f7d5e@oss.qualcomm.com>
References: <20260625-bt_bugfix-v2-0-93396a6f7d5e@oss.qualcomm.com>
In-Reply-To: <20260625-bt_bugfix-v2-0-93396a6f7d5e@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Tim Jiang <quic_tjiang@quicinc.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 66JwZY57L9Xae3acIVAwpCBrO__SjA-l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX2z04+BN0WFGu
 yz0C+Q6xIhn2ZzIssuRuStaaYuaSkZsXlrpmUTGvPdmW8/5w10TJqkDdb38KvxcA9W6tND9FThS
 Ld8VyRXWE3orhd7JRkcKgLR2HNTDvaV/jmPrRTIAHpG4azSuDIMJXjGKsPQoozoAM1NjbzJ2FCW
 tO4tk2w3+JpzghNX5sTr7zKatAsuFNIS1xKrhNhSVXS/0J8ni+5ItyX/jYNq0PStlanUlBg9yVh
 dZZCJT+X8iYjCzA8WO0rSN3Wg5qgD8NXKNLck/+NUvJaraNWELI06ocgnLnSUPWx6qMMDABic9K
 apx+SIMy/J3x4y1lVrqsIXYzO0Yot46Fb0LMOXRiV6+RS00BIDKGer9p03OsjOUcQ54V6lcJg9V
 +ZQa4OQwVj++HefLUKT3ymV/NxFo9/OHe7qkPYlsEeDGI9AYoc/W4xtj+CcX3bsetucBAuIsRRT
 ymdoqWA8SviWEFrmXqA==
X-Authority-Analysis: v=2.4 cv=W+cIkxWk c=1 sm=1 tr=0 ts=6a3e0bf5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ErUVIrnS-jkk5iPv-M8A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX0tD76j6HSBEf
 Wv5TPAxefBdQETM1cXRHlN+iqceU1rkcY/6XWPO69r2BFwdyvrmcIdmTUy/Mvuir5XBeeoHhBHH
 5PUtregx2D9n0yErd9eNlVDuvaPdtPU=
X-Proofpoint-ORIG-GUID: 66JwZY57L9Xae3acIVAwpCBrO__SjA-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260040

qca_set_bdaddr() waits for HCI_EV_VENDOR when sending
EDL_WRITE_BD_ADDR_OPCODE (0xFC14), but the controller responds with
Command Complete event as confirmed by btmon on WCN7850:

  < HCI Command: Vendor (0x3f|0x0014) plen 6                    #3 [hci0]
          11 22 33 44 55 66
  > HCI Event: Command Complete (0x0e) plen 4                    #4 [hci0]
        Vendor (0x3f|0x0014) ncmd 1
          Status: Success (0x00)

Fix by passing 0 as the event parameter to __hci_cmd_sync_ev() to
wait for the command complete event instead.

Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device address")
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 04ebe290bc78..27f03690af54 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -1029,8 +1029,7 @@ int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	baswap(&bdaddr_swapped, bdaddr);
 
 	skb = __hci_cmd_sync_ev(hdev, EDL_WRITE_BD_ADDR_OPCODE, 6,
-				&bdaddr_swapped, HCI_EV_VENDOR,
-				HCI_INIT_TIMEOUT);
+				&bdaddr_swapped, 0, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
 		bt_dev_err(hdev, "QCA Change address cmd failed (%d)", err);

-- 
2.34.1

