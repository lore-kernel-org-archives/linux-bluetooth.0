Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DFE3F164F
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991617; cv=none; b=ErSHocUXeJ0ku9Y5FncCBY2VPEIis0WoUFF/vk4hWiMF9vhEni8JaIAIjdxf8yDQnOOKfimqfSHFJl632FO4ehFCwXFpqXr/t41WdVkP+mwaGWMI52LrPLiEaFZg8mr5zzt7r+pKjWJQIdGxP40OIOx+ji9BcVxzLOZAqkOCp/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991617; c=relaxed/simple;
	bh=OKx/GH7ZUq9+Mjfs4xDvFsGX2/Vn8N7/Q0k8/BzXAPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dx0Ecbw8yguqollTWkjl1Gei74QW3s2Oclv3/UakaqKbjW/0HTBalJTnCaamg9ZWLQ5pEyrR0Gy9RLccrojQ2JGJHwkFOX5CRph1IPKOs4FqZYnhQxkO8BZjxLhEe78TZPR+WQBsaAtf/ZDvbwPwBEr4Kgq0wjoaHQ09KnVb7BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pDnRdHs5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LCwN+FzF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pDnRdHs5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LCwN+FzF"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6593wXrE1064829
	for <linux-bluetooth@vger.kernel.org>; Tue, 9 Jun 2026 07:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=; b=pDnRdHs5lvUfpYdk
	Ud7E9GB+W2dPNMQO/F37Vuj4hfqhj/dnsPgXUigUgbsOozzEAotANNaANu2+epFV
	RZXk+ZcPNYW2muCs5isIcfRMowSvT8ovPCDdjGvQLfJ1fAlU2vDmP0d815XesRRc
	cEqYZgd4Ojg6gjoN18HGi0nTRx9ok2UBrBSV6TRnoovNF+dxD+9f9Rk8tWqeHaxS
	rxToI+W8CGDXDn5OOU9hNQ3hOkLV6VQC97yivM6z0UcRKs55eEXVJlQ7TmsDrkdb
	M4JeYKR0v0lrmSdYdrTrZTFD8zllT2t3jeSt57u4g8FDAM3mV34VZCPfafE/RJln
	/zyrtQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enw5m4q8w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 07:53:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-517787172b0so79919061cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 00:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780991614; x=1781596414; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=LCwN+FzF1NDTmCN4MqqtO4+rM54cxcZasLV11jjMbK/7/kRTr3l8UQMclObpboCkw1
         ucCeNbVgNHpmPozxgT0zbSHD8dxxMXOWi09bAujOxlin73Mh8wYMeaGVE50DLvRKxa9F
         jsmn6gY5MdCl9tSucm+y4ex/yPHbat1XVdZCC56wqP5SuclL5wf3u91gquzflMtpfh09
         Sb2tTSgfQduJL6nr8VajlAku3GnxzuF7MlgiycrIS7KP3lUbapTWz6IdASN/trPNzmc0
         /bvAkn0LSgDWVaq4psl6qugBjxFhgxFCVZLfa8+ol+RN0dtxHffLHBg7FbxvzaCWFCB3
         IP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780991614; x=1781596414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=krq/bCMtQQ/MTujN5N87AN9kHYal7o/lgkEkHRM7S41iNFRt1MDZsrEE3+wMq6ACfP
         ftSFTusa8ojeN1ce5GAYCIw8HavrA8DoCgnxaGJrE5Af0KjiHpgdgkKssss+5Ld+jbMY
         v4mya6LH6zk3GcpD+flIjExVgqeS19lXxEGWN+p/b2RuX9vlc7xa3yrdHE9pBmDRqy57
         5J/djDPAdFwuEb1jXGaCsk6vBQQOHzIsoyQGUml1QIb5OBZzHXnk+gIDRw45ctImO3hI
         hCzAz81Ud5VrVJpmI5NJ3kvkvPeobRfiWS0N3LeexJ4OOJGeJOXnROnIaZLpKeEBaJi4
         aE8g==
X-Forwarded-Encrypted: i=1; AFNElJ985mMP1sTbe0XXCWbeiNw40ukouKBdds+dwjqSztaRTOBl9skYq4GvdIrYSpNHTxqRPYxJMC+KsVqnKplkLCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcSSX3Ambbp3wF1hriiV248xoy9BEyeyuBjxBigWrcMSKViCXt
	q/HioH91Xf0iVOR1PZLIk4vTCNV+1m4lqIcCOiFw8OsOqYrm2iWs/9EmlWikMZewhnGQuGpgzZN
	7JAig37xEwEafURjv7ZUxN75KuQ7KBR/JugeQFu/gaL8WrPl9C5eXfbRR2umPmQQFKH6aIQQ=
X-Gm-Gg: Acq92OHzo4qFDSeKrG8hWcRIJ1NSYSeppXb+9zuX18pw4IbMAtW39LngIz2MiTCQAET
	dsuXWlqRjVtcC6x3mZ/CvSfaP32M0NIxrXvrlTexA5iUZqEjO2hcag69LXzobpINUZV0Jw0FfRj
	wPnwqM6vY9MyMw+yp8uCv9fMvbOuYTqsmSIEbt0MHzaQBvt0s4LXm/n6RRNPlBWB52LPjSIVcm1
	XgpIyUI142QaCSMs3fwBsw/Bu2WvobVdzrFn+NwoRcOA/DY/0vVwBlHSQg0u/iKa+eExVXY2ku3
	D96BJ64annMGcvGVZDxBEqso5E/1IBvRWxHLjaXfiHStotIo4SsEygCkfWRZewaSJvZG5UT/xGJ
	8V00JOj92jQq5T0xO9ipiFDLizvjdSqRHq0Wny54M5kZZwODTGeZqk62vohqGvBiHHQD720vNcT
	8yMTfZWHOLyLxGOibfwTk7uT/nlLvBivXNgOVB1H/VuqNekPNF31eMqALSHOQvY6jbNiIap3knz
	NFAxNEtRMat
X-Received: by 2002:ac8:5814:0:b0:50f:bb77:a084 with SMTP id d75a77b69052e-51795afed1bmr263903621cf.25.1780991614430;
        Tue, 09 Jun 2026 00:53:34 -0700 (PDT)
X-Received: by 2002:ac8:5814:0:b0:50f:bb77:a084 with SMTP id d75a77b69052e-51795afed1bmr263903141cf.25.1780991614000;
        Tue, 09 Jun 2026 00:53:34 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm8121631a12.0.2026.06.09.00.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 00:53:32 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 09:52:32 +0200
Subject: [PATCH v4 7/8] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-block-as-nvmem-v4-7-45712e6b22c6@oss.qualcomm.com>
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
In-Reply-To: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3NCBTYWx0ZWRfX+F4h8blMIKNu
 VOLTkfyBIpZJiS/dxR/pcIfnzvU0S+H2fiiPL2rvvNTH1iY+ytsCR/dw0cjuFDAP6s7OAG68CII
 039TTX6e1VeyzCyfIVsOTDBG1Qlpa7SIg3Ecyf8hPPPSC5KUmBTIvHyEMnPGH1t5wWDrm+W9Psc
 Qz91KsgNRg08JmQn0evZMmBiFxdTGe1zmkzL0DAXc+GaDHelQ/ZjD4KTd9cJUwwF0BVNrdQvdUT
 80Zur/44upqx7h2LWHQPModlpDC472uyVFQKagrj3e3ayA7Md+1f3sq9DUgnD7gJD9VgBiZHPTG
 V3GHKY/pURtetSAXoownocivbtPwgcXIJLypvPmYu4Ck3bTRL5EZZ/RN13EUfklXobx1Qcz987R
 btvk9tXWmiR3wnCuIRPrsY2PJRtp5BAoYDC78OBg7noYm5gHpKJw20tp2IFJp/40n8DrX8qKgoL
 UARajhFBsXM24IxlLZw==
X-Proofpoint-ORIG-GUID: FdkWbD5fVU_-YSwt39c8KyaxqlYx4BCB
X-Authority-Analysis: v=2.4 cv=UptT8ewB c=1 sm=1 tr=0 ts=6a27c67f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: FdkWbD5fVU_-YSwt39c8KyaxqlYx4BCB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090074

When the controller BD address is invalid (zero or default),
set the NVMEM quirks to allow retrieving the address from a
'local-bd-address' NVMEM cell. The BD address is often stored
alongside the WiFi MAC address in big-endian format, so also
set the big-endian quirk.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index dda76365726f0bfe0e80e05fe04859fa4f0592e1..df33eacfd29fa680f393f90215150743e6001d5b 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -721,8 +721,11 @@ static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *co
 	}
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (!bacmp(&bda->bdaddr, &config->bdaddr))
+	if (!bacmp(&bda->bdaddr, &config->bdaddr)) {
 		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM);
+		hci_set_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE);
+	}
 
 	kfree_skb(skb);
 

-- 
2.34.1

