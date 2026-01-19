Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CA53271E8
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842488; cv=none; b=muGn1ToyO8LXsXoIzTQ+n4eyJ26bfbcs0kS8XOknap5UXkdHKd454G8bxjg5AVw25upplgQgvfJUKN9wq4uGuekVfQ0t8S3Eu3qPRapVuF3I9Mq+kGKfXL2HTcj17NGiY5uI6g7Xfb5lhBZvdyNTPCN3n4Gw2U1NsBVFb5CynVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842488; c=relaxed/simple;
	bh=VErys9hqLxgSS6Lrdz1CsakdJ/riLD4OBXw0+DkoA9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D1HXMUqDbeU4M14kaMTslsR4T/VXF62H8+JJI1gb/L8CxvFLtyySuBUPEHYIqZJIndkeWinDCUbe1agQ9Fo40wRnUXthlPAg4+4qpducYtCWAdNsYMr5hzw5jIWEMRz1qVZr4dxdOTeDTXzX5svw+veuhT7JIxrUDUxk0YN2Ahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TaMyBYgy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jAbx6U0d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TaMyBYgy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jAbx6U0d"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JGs4bc1044553
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 17:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JwfHhB1nZVxoEXqN3zZuZTlTKGAwslL0h3eFOKQFT8Y=; b=TaMyBYgyxqXXI66n
	ldL5EXs6VC5C72Ry0oFp3PMW4hxS+q3AMfXur0xUyfTesIUhg63/B4XScxlS7Q+4
	I3PZA0hoTAYjh1LHwEwJ215w8EWDUdgpdbQ2P/5nykqHHYBd9KH7a+654t+4wv0/
	6BRekUrbn4sQq4h00zEjaEGbUYtSTCcQ1S0kMsl4wB28jVBPvgw2MrEoRQojWVCb
	NUEvVpGKg82/6f3UxdwxgH+WRVVHBB261VTWwly4Bj9wXFpKZMAsPZwEsTtUOEAM
	zl+ZixhjnO5Dg2EVSkoUpGT1YUMCWCswl+6wV7lQ8e1N2L25vYMpfcTZBEBDTxie
	Fd+DoA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bs79ejvk9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 17:08:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6a87029b6so777214185a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 09:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768842485; x=1769447285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JwfHhB1nZVxoEXqN3zZuZTlTKGAwslL0h3eFOKQFT8Y=;
        b=jAbx6U0dWGEJaP4oA6LktY9K9HjCTEL8Cx//Sa90VIYIGqKjmoH9tgJr841RukDvtN
         4efwBDYIsxSh6V54NKVWOgo5BlPLxSB3OTWYgY3mrIIuRZWOb3oF3ws+t7CHsgeLoTxf
         1SkWcdjrikvVDZ6qPM0T7IFQ7L59Fc3XzgpYFzF4t0KInzxeyofXG8Kzu07pxTdPVzCF
         hza9SyQcbIyn+SWlUAzdIHIKdclGs8VgR4m0IoAs/7FETeooDfn8vdg2m++jJDx1jbhA
         SVwNbDclFBWBIDDMEtGr+G5lZXyoVFkee7xIxMPHpSPdMI7+B2TOuj/ia4d+gpdJWbUl
         RqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768842485; x=1769447285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JwfHhB1nZVxoEXqN3zZuZTlTKGAwslL0h3eFOKQFT8Y=;
        b=ODZE1uq7OIxOMaZ9YGNCXJKl9ncmPaNOxrw3XPhEuQPIZvRfMbabDsZWnT3Rv6Q7lM
         46fHDz+AfJCJhQIZNNbe2gQNpx08fDCgmUQinifKQxeghy9SZDhzDSs9egrD0nGXRMDE
         9K6V9ARuR70mCVbwZLE/wG1AuhJ1IrYdWb1lgH+sBtVXxfW2Vq7XoHp6if4n9nUeM3Ja
         lJG6tj90VPQLr5k06H2q3/7eOEEVZaS/FquhLi50mULqOrE9iaUjKVJb9liHg7+VyV6v
         EkmI5c5a63Wk0gFyYIuJwPwyTzfiMpEcaEq+vS0Piak8MFPyX6tf18hJ3yNh3Ft4I84N
         TccA==
X-Forwarded-Encrypted: i=1; AJvYcCVu/dAmkO9LzzZsv2nhLx1REEGfKOKLM7nyTKLu+HIGtAvLh5GZt7s39Qy6Dc5s1lP7efmgmQZMYPeAUy0+AYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqjiDygxptbRDl8kMXg5YDY7XybHtd43Hk/czWPu7ZnT+J0Kdz
	T6L5GgIvdh05ASaNFv1qedEDls1XaHq0VLFM87pD1RFRUM6c/zOl9JJWpSJMmG9Rp0EiiTY5L82
	lvNe+glPSWVaRiBeyyUsWsY7tWIkGj8oDkIizC0J3cG9+eGapIv5vrbzQSijKrl450MCqZno=
X-Gm-Gg: AY/fxX7fWaEC2hYg6Ojc0RTJWyXPu2yDPmww+L7Hp9qA8iNYq1KmG6v/869UNCllA7y
	Q9uHJGxrMcaH8czsthBSv7/cImKQNybVG1eal6xfRcKEhnkKNFIkqb5pYvm1Qaf6BRn+kMVz46Y
	id17oQXElNbdI5pcReY2SoAX7UL8JlCPL3gMVFIdawPSE3cfBIEEnNAZGVTa+fDRdzEefNr457D
	xjAo+T486E2vlqEVRzNgKa8oHbnbOZpISZ+Z+QSCyGdyA2V1M6qKiJHQ5qf9yzLOAnPRA1HFuLQ
	7SPtpJ9YsN1aY2PmmCUgdOkAUJo2BgNzDBzNTHHYhvYPwlvQ4g0IScjwcxCSBYVVnuvStNAwYGM
	2HLAHCr5k+RileP87BBNI+hSyPgI/8g7GUTXMrMx74wcWWxzscS5W4jE0Vb/TcDuSUX34MaQLTx
	2pytzfSD7RuNyiZJvoCIqBGAU=
X-Received: by 2002:a05:620a:2801:b0:8a4:e7f6:bf57 with SMTP id af79cd13be357-8c6a66e8b5emr1918764985a.5.1768842484773;
        Mon, 19 Jan 2026 09:08:04 -0800 (PST)
X-Received: by 2002:a05:620a:2801:b0:8a4:e7f6:bf57 with SMTP id af79cd13be357-8c6a66e8b5emr1918757485a.5.1768842484156;
        Mon, 19 Jan 2026 09:08:04 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384e790a9sm32661211fa.26.2026.01.19.09.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 09:08:02 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 19:07:56 +0200
Subject: [PATCH v3 2/8] Bluetooth: qca: fix ROM version reading on WCN3998
 chips
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-wcn3990-pwrctl-v3-2-948df19f5ec2@oss.qualcomm.com>
References: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
In-Reply-To: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1484;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=VErys9hqLxgSS6Lrdz1CsakdJ/riLD4OBXw0+DkoA9Q=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpbmTtbjApPeOwaS8Ui7htTq4t79FkzH+7eN26N
 Wsg/RM7z2eJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaW5k7QAKCRCLPIo+Aiko
 1W1yB/0VywSU6J5rQUN6Srp/NRmC/d0jzYMzo0KObisnCcmnAiur+qIhuxBP8UUnwD3z4nVb0t4
 7wOEgvr9+ctMeME9veNQD2ljbj01uhDPTOkt6Bx4LRi7b7lq8SgVbDaSUXqo7OxDrZcCYvuYCzT
 LrgBwaxzr4/EJFttxsOMb0Qkovr+OIvq+Ha523Tjrz0kkcxyxXQ9L2ZVG3FQuo7tJcCZrpRKeh2
 yyJh4OSMWmD5A/QmWk9wA9hkHl2YzlJ5NFewrNcZgLXIQws0tUTDsPSGRGPD8SrPs7DVQpsvOVC
 qfrpvTNWyrusyF845CefxPShXNEcJD20U6t+FAQqinaCNOBZ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE0MyBTYWx0ZWRfX5fV/U2nAnIDJ
 lDxDWHh5SqjKQbb3fFhRatErO6NU1/0Czsk+D/ijtMSGSgr1MNkmBSKIrQktfe1ecgtKJQy86H9
 6DwvLelDSucrb9CC4NwTP76aqvF6XTUfZZ+OOJgTSpWobFX2KT/MvwW8Tsw/OkxYqKZrddiJHMX
 soDmzYak/vuKycfC4dGQZ/epKrFAuY0sh0eZZ61mIAEqTm7H5IPTGE5S+cNPZEmtLmDje2nPtl7
 8hdW76eTpx5l/lp0WuX3pCTve5u1p9txvbKidVdoWATsYl5eBDASkfTs4g1QB6/Sa26pEeqTHsO
 fSjprfBPHqN6Jebn4+rBgsltkmxeeFqtSRNP5t0QFNPhqtyoqVRBLmXeQycFnx6VnyFSngfw/UZ
 VnSoV2aFj6jzFOrZppoGJnhH3n8TifjnbLAq14JiJmKpnMXCiI/pofYvHRoZQ3bto1zfNG1Q+G0
 WI4gnLWJLxJLFsK9BNQ==
X-Authority-Analysis: v=2.4 cv=NY3rFmD4 c=1 sm=1 tr=0 ts=696e64f5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=TaVSYX7Pq2PjI-6xwy8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: otEUvS2puRw09fP9NJ9kNwcK9avyLCIf
X-Proofpoint-GUID: otEUvS2puRw09fP9NJ9kNwcK9avyLCIf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601190143

WCN3998 uses a bit different format for rom version:

[    5.479978] Bluetooth: hci0: setting up wcn399x
[    5.633763] Bluetooth: hci0: QCA Product ID   :0x0000000a
[    5.645350] Bluetooth: hci0: QCA SOC Version  :0x40010224
[    5.650906] Bluetooth: hci0: QCA ROM Version  :0x00001001
[    5.665173] Bluetooth: hci0: QCA Patch Version:0x00006699
[    5.679356] Bluetooth: hci0: QCA controller version 0x02241001
[    5.691109] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
[    6.680102] Bluetooth: hci0: QCA Downloading qca/crnv21.bin
[    6.842948] Bluetooth: hci0: QCA setup on UART is completed

Fixes: 523760b7ff88 ("Bluetooth: hci_qca: Added support for WCN3998")
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 74f820e89655..3b0626920193 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -787,6 +787,8 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	 */
 	if (soc_type == QCA_WCN3988)
 		rom_ver = ((soc_ver & 0x00000f00) >> 0x05) | (soc_ver & 0x0000000f);
+	else if (soc_type == QCA_WCN3998)
+		rom_ver = ((soc_ver & 0x0000f000) >> 0x07) | (soc_ver & 0x0000000f);
 	else
 		rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
 

-- 
2.47.3

