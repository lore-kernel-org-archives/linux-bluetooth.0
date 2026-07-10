Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5D8403E96
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677478; cv=none; b=JQa2QMJcbciHjIseBcxT/aAmgUU6DPiky0ekf0LkjQLAYH+bQfF4khH1tdMka2Ibu8UVWl3vjpqfHliYqrrld1i6feeCwdW82hGKoxpH0baIeYAjX4mQCrdVHKi7XjLb/EN49RKKJ1cDxAYf1P2W7F2r7koqVjz9fDuy0Ce0wTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677478; c=relaxed/simple;
	bh=8JpUJth9XTvH2/KUENAtj9vpf8EiqqScCzN/6TvG46E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XuQBCTWC/1qxVtv94H022aht5QpGpTTjarIc+F+n78Unpi/ONXoXPpS/MgomXksOimdubnMB/Tqd9HxhPrEOXoWU33QHamVZr+OMx1jH44wCYE2gmS5kwymugMgaRKe9FUAiyYvyqtzNkW+PFxYtVltUrKkB1MovOVhiaPxIcf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=drQdye0z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WbJgLcS7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="drQdye0z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WbJgLcS7"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dS2k172472
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L/+fhSSKhqNyPBIhKtJ3rdCectIRZdOdeDVvpYe5lcc=; b=drQdye0zyYR6/ADK
	eR60QZa7r+h5eWK8gLYEiTp+Om71n1v+Pq0B1n+psFTOnW336SERmkLoUkmukSqM
	stLkpzbs70Kv1wJ8ENJDyvS4IroFhm5204VewBqk1VH+roQwVH6pqsKTx1MTIJlk
	UYZHQVxH7BG8/6b9dOm/dMnRCkkNKs1O66lUiexHBuVodg6AIpKWxRGf8LKMGd76
	gUTKQFOQNmoVz/qiQbw1WolkOJUllEW9VWGeR3gXzPqMn2T9Df7hGWw63Se1URA6
	ecXpjcSqU4SN/QUe6gZqfsu3EU8aie32TihzR29lTYYTpg7JU9mHHV+x4X+EGr2Y
	l8APDA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fanwe9xb4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:57:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0e702df8so7222461cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 02:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783677470; x=1784282270; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L/+fhSSKhqNyPBIhKtJ3rdCectIRZdOdeDVvpYe5lcc=;
        b=WbJgLcS7eW+jP/21gcjR/0ZsyFQ1z+4OSqaUq34tt6yiT656lQcFE1ZSaxDfk+0WUW
         BVTGS0kxpVDzStHCMuOu7+LxxmfORyDGsaAd8OuPN1W515eNQR5i/PDGBLqkuZblvNFj
         ZG0tVlgPXFTttJ4KNcTiv/k/e/sM8S+1xfI+wq8OeRyfZL5vAf8Ek5/Iq53P0FSxAbNL
         m+IIFr47svXKFGR29iPtqIADjNJM7j5syHXAWXn7qXqP3TGoFXoVWVmus11P+31J6c/Z
         bWbbf+AXXpKo6pC/BTewxzmUc5yrD/AvDFBZybw9GCr7j3Iwo7uACf4/G/F0TlHjXDZT
         i1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677470; x=1784282270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L/+fhSSKhqNyPBIhKtJ3rdCectIRZdOdeDVvpYe5lcc=;
        b=Q9WR1AWFSV/+/CQKfj6BUzkZJMVuKUnsh+swUfbFs0ZFAJPu9R52M/QVRL9JI3q4uP
         wRj41hnx66EQ3kySr/VTyWu+xY3syzgOBpfz79zlIsy55mwbqF0ex+xBmKS0FF3PkJmG
         rqK3n37nz+iQS3Sqjo2Yivrw9tEzFkMfMdCFYLCpH+dCykVOso7HGQvsjsiKlKtNlZ20
         2tOh37Fkm9LKwIOWwBmCLmsQnC/SX0B/jwQC6p9TfVLsz5ANwQqjFN4TeofL9mn9Ys/x
         Mt+tjaRKBG2k+s+k6uSb/A8O63wA2koxufIPHA+9NPzusOJkLupeDnTxCHErZuGg09Ah
         nV9Q==
X-Forwarded-Encrypted: i=1; AHgh+RqVh/5wGRyYk7+iYe21fbcKcoE/JPeaKJ9uQhDd616jewrCKfFZo957yV2H2su+fvLvBzOf7AZG8EXNDqCMR6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtOp0QcksilbYdt3n0jq80xecmqJ+oQI3hoYxjV29zWFcN0n2r
	QDxsBGJlq/ynXYyM8zFyA5hAlw9HR1yGdSdABqmLUw4RHsVapAGAH4NjtEqom3MTUWsbeT1Ss8k
	RzwNTEMDDJOE3gcdP1J0mvDTLfRguZ6VUgPxlfQDG1tbrojOqHOT1EcmMsEGVw6ktFMB8jgY=
X-Gm-Gg: AfdE7clCjBO1E4Vk00VlQE6wRFkgYBvx1ejFN0ydZQ9cXw+zfZliPooFCWcujFLRlxk
	dR9xLbFc1MrJAysPLLFxUo8Utn5yEYfiYcms1tVCVK/sGTkXZzttCVQiSvwgqRS3iUxqFrEwWRK
	GKtziEhvlIJvnDWyebAdhZdmdu3e+29XAASkwsp/UTPgbrvHtBW3eeXj+4aKJ/HYbVMgAcC9/p/
	3Dqf5hTYYGgp+5e/Z9Szlo0rFWaNqWsDdZYjStZDi5D86zinfuYMU2m8hSAj7socYukJt5/n1wu
	XGUaWBuh3NcnhLRC7REKyvkQ/xAsEJMDu/VA7L74dZpYWXyz8uwTitQwOck9xNfNZrbheTk62ZJ
	MjzwqrPzqMRsOKQZ27RUP9ELcWFxUFyH2zQr+CWRNXphV6a7zIqvBW4kyihV1PBgfJUCZej76cV
	r1iQLUNH4jIBgIChLI/B2p7G6GA5uZgLZNo2MvnBGLg2IMaUr/5m5OBG6TQmz3P4lTvrwtuuwDv
	QaXz/6MseC4vlXDqM9O
X-Received: by 2002:ac8:5a84:0:b0:51c:1967:5091 with SMTP id d75a77b69052e-51c8b3b4c44mr119708691cf.41.1783677470057;
        Fri, 10 Jul 2026 02:57:50 -0700 (PDT)
X-Received: by 2002:ac8:5a84:0:b0:51c:1967:5091 with SMTP id d75a77b69052e-51c8b3b4c44mr119708391cf.41.1783677469579;
        Fri, 10 Jul 2026 02:57:49 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm265357966b.36.2026.07.10.02.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:57:48 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:57:36 +0200
Subject: [PATCH v3 10/11] power: sequencing: pcie-m2: Add QCA2066
 (QCNFA765) BT serdev ID
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-monza-wireless-v3-10-46253587af64@oss.qualcomm.com>
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
In-Reply-To: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a50c21e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hhiJJhbhXc7jC-Wm4KYA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfXytIR/pjZPrmp
 mgzMVC/gjBZyIUqyI96t7oyr8yjWSFrIB1SWtwkB4XXQjQjYxmzqYV2kCh/iQcRRxjST5ctTwP6
 NO8nEymPw67hPpgSMPg49zLg7NCjvkeqpdmt8mYkUyTMI5fFV2wrelKrLQLVnRo8lyIUDNycPCp
 kIAjJIjCwq+1YE4oHk/r3VhzjjUCDbiOcjI1YsgPmT7xf24tVT5Ong8aX98zIm9CbQOFH3C2xMe
 lBiC9WT+riEDv/PTs1Gw+ClLaxqXMpQPD9cCe122pZe/Eqqdk5Qgym5N5MZm4jwYEJ7Gfas/HAh
 j4qtmm/aeELb5vNArDDyMofGBhyHPBjfeTN1Ms0fvID5dDEzXWrgU3o+00KgEDc/BWDUwCJsYad
 NYRVa7L+ARr7qVrctIgxrQirIcJ4hdViQmSxr0pTWt2BPKqlpcVYdg7/FNKvNXTGAlgDew8WJF6
 S0SlRBDMFSgIs5YrF6A==
X-Proofpoint-ORIG-GUID: iLShNPZ7FqmZxDKwvnNJHffvyfC5HNIY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX3oYL7JhW/g+v
 mHtjVtRJTjDL2qVEXv+1W/ErmeMpG9ctBwp9n0ABFh5+bKD7B/NwYWCTY+gon7KLSrjnI2nK1rz
 WHuMIV+PFaNELf6kT3A3Q47U4aCR638=
X-Proofpoint-GUID: iLShNPZ7FqmZxDKwvnNJHffvyfC5HNIY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100097

Add PCI IDs for Qualcomm QCA2066/QCNFA765 to the M.2 serdev ID table,
mapping it to the qcom,qca2066-bt compatible string.

The Subsystem Vendor ID (SVID) 0x0108 distinguishes the QCA2066 from
the WCN6855.

This allows the pwrseq-pcie-m2 driver to automatically create the
Bluetooth serdev device when a QCA2066-based M.2 card is enumerated.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 4bcd5078609da1be966ab30c73cffae5e578934f..5004e70ebbfc370823098ff6df7b79336c1e6063 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -216,6 +216,8 @@ static const struct pci_device_id pwrseq_m2_pci_ids[] = {
 	  .driver_data = (kernel_ulong_t)"nxp,88w8987-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_PHILIPS, 0x3003),
 	  .driver_data = (kernel_ulong_t)"nxp,88w8987-bt" },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_QCOM, 0x0108),
+	  .driver_data = (kernel_ulong_t)"qcom,qca2066-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),

-- 
2.34.1

