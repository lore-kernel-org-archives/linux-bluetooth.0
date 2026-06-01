Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35123342501
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 11:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780313556; cv=none; b=Yz43KY868WpYNif+IA+Ppe2zWJvyJFDP1LozfulaRhRqkoboISLberarBLGPltDib+QsL5vRRdUWsr+iNpAe3PiQzbBIbrnjjujdjARy2N6xyh2KlpJmed8d81N72Q6pHHpISF4uw+73tzCjRh78X1S2WpAGtmV/3YOnsftOKr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780313556; c=relaxed/simple;
	bh=6o30cdAL6da64erM2KNEFfKyQAxJbYvFAnMJ4X/B2To=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UPMvaOXqPcoElzDeDoqPQ2xNNJdj037CZxUoNGjaPqPJjd9t2P5abhBql2QyjVS20eH8adLx1CHiVRZagAdxx6/jeNn9woiovjURz2RtmRb3GaiGi3u5ZBMjpOSmQaOgz20IRa/8HY0MZbe6gq1DOuPqHe8ZdOyDqxNU00aeBd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bLjOvhE5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e9ef0M37; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bLjOvhE5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e9ef0M37"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518fEis2740465
	for <linux-bluetooth@vger.kernel.org>; Mon, 1 Jun 2026 11:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B3ZGJB1FTG/N9elrkQB7UE0RwCW9ibLrwGuzABoGwo0=; b=bLjOvhE52cfjaa85
	hCMdcW0Ev2l1F6LvnoKeUbdS/Lvf/pPS/Me76/3swnW4fXqxxZTdqVRP5RdeJsnm
	1r0h801tWFMf/lZ+Siu53UgS0fPQN+oUEx7pfAk6mjNeEfOOE0vAQw0tALmSFzGn
	+Wm9HzpJkyUUMGi0D9OcfvbW1QId7+e9APOMYVGCu7aJ5VpM8nAVfTrsjyu1dqy9
	hTJh7IiTpXg9g6JSVLlYhtfUrDf6Za+mhbwpBYNFXm2cJYAPiLHdQZmrjNgjJafa
	T4XxlOjAhm2F8jpV78JCZs3mpbK2iGzMkLPk7E9aa9jf5sK6ZhliiZ+KMG3PwW4b
	id7tAw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6sqgp1h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 11:32:34 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-304e320dd52so284061eec.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 04:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780313554; x=1780918354; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B3ZGJB1FTG/N9elrkQB7UE0RwCW9ibLrwGuzABoGwo0=;
        b=e9ef0M37BfUBVLZi9M809iRI/7aWKeabQi/AT6WBXQruYUU3Wrw7FS7D2Hom/nvX3B
         5Pbj6Az7AGoeH5AE8x+KndiJWxYSseh1hHRIlmvLo6bQwTRkuE75bCAWiN8ftrAeqa2T
         LXfRWzaUaB23DbACZGALHPDirVy2oFkJUq7z9k162CVBopfHMvmebnl0WOOceCPL8BSL
         /nGmfO0E48ag5FkzPQHBjhGKY6NSnZqhX7T5cp2Cj7mAF99ni5dIDfPYc176d4Xx2rms
         fkQj/pFxcD3kiVI6A+cdNdDFb7/QLtzf9s1jV98CC30yIWvYdajvefwSfYPGFbqSLmF1
         h2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780313554; x=1780918354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B3ZGJB1FTG/N9elrkQB7UE0RwCW9ibLrwGuzABoGwo0=;
        b=mus7nB05VT7ryG2zBbQpjW3LtnUfEOd6cuU3N22I+iM6ImBbqAzPxkHue6NISSwjop
         +h6Bk+7og8aqxvbp0484Vri7uhlHpWdcTu+cajgYb+lp10mqShp4qfo1tlSGvxLVJZBX
         XJo+7OPTTu+ErXLg5dhzFAZtWGiXPmaGf0UE8MSQWhioDwrMnWkAojLF4Nf+XKeG2MdK
         fpJD+oWCOQxmU7R15D5Y/szA0xcrLvsbvb6iryHAxW/YUVJFeWVknAkXaaNUaEAx1WNE
         FPa56VMAr2262egB3W345cnwiV/6zIkVW5Ks9PWmECxIFFFI1wFDZTcctbB/NK6sSS7E
         d3Pg==
X-Forwarded-Encrypted: i=1; AFNElJ+9c9CIsjWA6cAjyD7TdWMa/NK/b2n/jVFLP3cpOd96YSMePY9/USBavPgF/yAS7r3jS1WW4KhU/HoP2GKvyGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxJaGaxMb7wu0qGtQskGApfZUQ5I8pLA4Zp2rK990mD+2Zgqom
	UZfT5Xt0DfF+7MaE2Zu3cChwRKxpb33m6BwkbldL1R1n1Be74dnQlSou7iYiRxQy0Qbdy/Wc0iy
	xIBtTDhxLGJKaD/ufQ6slCNfPOKWcA+W6ahHcVGwdy+KoZLptfnnGOPSNAtXA5b+4bMvhcSQ=
X-Gm-Gg: Acq92OGPkpwQObsMH5pvhgdyErf7QydONQzeWiuFf4slp2VkbAwze6PeRfNhCYrjHxN
	w8Zpjh5Ay0DRy0D8kUa5PGKHsYn+rzSGHfLuKLFk2Mlr4AhmBxC7yxJYScefsnwoE9V0ivTie7H
	6gMqRHLviWsEt5c24axQR0uXs3vkqvH/rZEQFBo5CygPrRiMsGBaAfqKNob1VXpuYwMnfQfDBxw
	S6rnT+8Uo3ViIspNWf3PqCuYyIuKhJ6L8dkks7RShro6q9kDagL+mdduRTG5EH37txMgDlt53Ek
	CzfP6Up72zDnDUgmZ6vN2JW54d1N+moSSOxTo0BmXROd48f8nJ5HuroMrgJvUAs8BBp8ia5IBZD
	7n3EUnLlQAu9s2H1M37sEEpWoKewViD1afLezLwzlf5mYop5vORK6TNOXF+EkM6/qQKE3qnrEJi
	KYJew=
X-Received: by 2002:a05:7300:cb13:b0:2d5:9438:2a02 with SMTP id 5a478bee46e88-304fa4a48acmr2304745eec.1.1780313553907;
        Mon, 01 Jun 2026 04:32:33 -0700 (PDT)
X-Received: by 2002:a05:7300:cb13:b0:2d5:9438:2a02 with SMTP id 5a478bee46e88-304fa4a48acmr2304727eec.1.1780313553303;
        Mon, 01 Jun 2026 04:32:33 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2f2904sm8667431eec.9.2026.06.01.04.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 04:32:32 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 04:30:55 -0700
Subject: [PATCH 1/2] Bluetooth: hci_qca: fix NULL pointer dereference in
 qca_setup() for non-serdev device
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-fix_none_serdev-v1-1-8d0497ba83b0@oss.qualcomm.com>
References: <20260601-fix_none_serdev-v1-0-8d0497ba83b0@oss.qualcomm.com>
In-Reply-To: <20260601-fix_none_serdev-v1-0-8d0497ba83b0@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Mengshi Wu <mengshi.wu@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Sai Teja Aluvala <quic_saluvala@quicinc.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: OXzed7_66jpUED_wRwcbrwZU9_69mQjQ
X-Proofpoint-GUID: OXzed7_66jpUED_wRwcbrwZU9_69mQjQ
X-Authority-Analysis: v=2.4 cv=eqnvCIpX c=1 sm=1 tr=0 ts=6a1d6dd2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=EPjRy8lAqh_CNP4ImRkA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDExNiBTYWx0ZWRfXxMnuu2sSWp5s
 Xbe9GT/7+0rtKHWnPeLo6yK/4hRMOI2TDECgruZ2x1sINU2HMoe1qQ3mq6+7tfLoums+tq7NsJj
 LyOA7loJDhotQT/7fJ5fQiYNPZlo1n4ekjsW7+XkKOrkThDH3fSJuuy4O0S+Ue96RGTuWCGNk+J
 LcuL8G3kZ7hvO32dtNwkeyiH+ugeK/VMgc85rHjQjvnry3qB9RV0IO/K0UFb3swY00u97v3daRx
 ME1tU1hH6S6bd6gbTOq6EtF+HaVR1Xie0du1NRFbdW8kJXD9P6aA7iq35yDY0d3IMH7+f9vd9Br
 HRxQOggtUe0dgTOm4YH17K2CM2Xq2OdLkWQq0fq03dsCrx51HFkLf+f2Ydpq6XkVJ8hrvjj6fEW
 hxPHTu5O80zlrPrt9PsmKe5BEwcUlA6l8mFYW9IYrv8hip4IaB8z8AcS4GsChuhBOlX3d54tWhk
 fTpcSSbFgumWErE9n8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010116

hu->serdev is NULL for hci_uart attached via non-serdev paths, but
qca_setup() unconditionally calls serdev_device_get_drvdata(hu->serdev)
and dereferences the result, causing a NULL pointer dereference.

Fix by guarding the dereference with a NULL check, consistent with the
rest of qca_setup().

Fixes: 22d893eec0d5 ("Bluetooth: hci_qca: Refactor HFP hardware offload capability handling")
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 34500137df2c..cc7b34a61fa7 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1916,9 +1916,12 @@ static int qca_setup(struct hci_uart *hu)
 	const char *rampatch_name = qca_get_rampatch_name(hu);
 	int ret;
 	struct qca_btsoc_version ver;
-	struct qca_serdev *qcadev = serdev_device_get_drvdata(hu->serdev);
+	struct qca_serdev *qcadev = NULL;
 	const char *soc_name;
 
+	if (hu->serdev)
+		qcadev = serdev_device_get_drvdata(hu->serdev);
+
 	ret = qca_check_speeds(hu);
 	if (ret)
 		return ret;
@@ -1980,7 +1983,7 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-		if (qcadev->bdaddr_property_broken)
+		if (qcadev && qcadev->bdaddr_property_broken)
 			hci_set_quirk(hdev, HCI_QUIRK_BDADDR_PROPERTY_BROKEN);
 
 		hci_set_aosp_capable(hdev);
@@ -2073,7 +2076,7 @@ static int qca_setup(struct hci_uart *hu)
 	else
 		hu->hdev->set_bdaddr = qca_set_bdaddr;
 
-	if (qcadev->support_hfp_hw_offload)
+	if (qcadev && qcadev->support_hfp_hw_offload)
 		qca_configure_hfp_offload(hdev);
 
 	qca->fw_version = le16_to_cpu(ver.patch_ver);

-- 
2.34.1

