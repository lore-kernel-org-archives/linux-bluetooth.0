Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793020520;
	b=t3kDzmTHH7owIPJlbrERI9ynO0NwTOdx3IgwfLRA4AOCQpGZHoP/NXAD8jnwdCy58KKp
	 G3kAtKXq1h7KwJ+Jy5+2JAEW74eR5IpLmfyyhWO+/Xr2K4k+wRcxFENZN717RkVTgXFt6
	 VCitpmLh62dZ4UWxKRRehH3r9KrvWjjTydJ9Hvsg9NOIfj/tq5Eom4p+TDscj45M6VoQJ
	 wfTx0giHAcRU3PpCXElfRj7yOXsHBkdpiy2ykci5/NLuPqjPRAC0ZfUtjLzwzIFdjdOpe
	 FdCRu0DtH+T8/K8kS0Abln2Ivz+khVNNxrMedIz1/nwWTpMHofDzUAMHUdITd5m1a4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020520;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=84jO84u0hziUJv1ba8E1DADtbq1uC2cjjK+GpD2t/wg=;
	b=RvubWT0jidwTBXkqrfp2fYkDnK1w/9sY5RX3a6+A4Mcm892cV9cjPkYJRRYjdvVNN3zh
	 YIsjpQdRmn/SMTFyg5xEVXKF/zzjZnnsydCAsrvPPdrR5b2zESZsGnbaxQ4QzeFUVqeJs
	 rjtWgV2zCFTenVabrMVqhYgjV/t2kl8KIJ6Zctnni25Q4sVyFbFvU6cYCsxhYlgv3zS03
	 qHDXjqlsVUpLbJ8dB10qEMKldKO0mmKbWkRPTUuhCg7pVOkxQxJ2CimKRLOTs2MqOenPn
	 eDP91tuIScHIQVezgKojNPAvRygJKAtKtYON1qyUBNo4bzwE8KpQ6ExZUw23SdXMfKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Quo/mo8o";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70693606A31D
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 13:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70693606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Quo/mo8o
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAtNZM2542001
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 13:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=84jO84u0hziUJv1ba8E1DADtbq1uC2cjjK+
	GpD2t/wg=; b=Quo/mo8od13ky6KKMVTZmqAN0u6xX+NRq5hUftIq9FgqUNYHGuv
	ug9xA2fruZD9D1260yCAua0FFiVU2GM60CDeN3C7Duz22U0jSyPN3tQxi1q+bVA0
	X2VMYwijuSBTGynDBnDkI2F+vD7ukXB58GK80wMEFgmTcqcU7mK0C5n0dWZ3qAtY
	q38mTkiIBI95FFOytMRlCLEMtRbZBevXdfU6D9w5Uz6sQt9DWGkAFI3sBXbp2+Nc
	MqVTQ1Z45f6Nftu1lTC51Gq/jts9i4CDhNPF/pNBQ+E6fCNmH+KdZ2PRu+Vav+ml
	GNC2pzxt5ZlX6am4m4TIgt8Z0+ahsI2txww==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsjdajy6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 13:15:18 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QDFG2u4072116;
	Mon, 26 Oct 2026 13:15:16 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 69QDFGjB4072100
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 13:15:16 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 551F523BC2; Mon, 26 Oct 2026 21:15:15 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1 0/2] obexd/pbap: Report NewMissedCalls for mch
Date: Mon, 26 Oct 2026 21:15:02 +0800
Message-Id: <20261026131504.1016687-1-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: gBbhg72tP2apugPc1qPZOoz47oIWNfwe
X-Proofpoint-GUID: gBbhg72tP2apugPc1qPZOoz47oIWNfwe
X-Authority-Analysis: v=2.4 cv=a4elZkSF c=1 sm=1 tr=0 ts=6adf5266 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=nr4HY9R4ZdW8CgmIIigA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1MiBTYWx0ZWRfX41ytFxaYiOVT
 Yj+21cb1KVLpGws/F0oLnfk5ziKMybbxKmi3sk4XjR2ikSZHrEKS5akhDHdlN40OAXsITpzHP7J
 AHvZWnGxyOD8z4I64ipFqmAJG2E1N30=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1MiBTYWx0ZWRfX1yWSLbfaZXlK
 M5TiApq3Me2SSBGylOM/q+hgB9MdLfBglNTq5IAFXk2nXKNWbWm1wmjW25Z3CjYhS73h1lKpnLS
 n/IgECVX66hDXjZPooeSADaV6+GrF921Cdsv5W7pvek5ukB34KhA2pHvX2nLHUc1/ES2d+lUmrv
 GPCTFKDGRYEoRZO2M9vj86xBZ9QvhVVTN7arZANAfNrdzCrD/mXCa3jK1SJjNewQyn9MmlxPvbK
 bvfTAMPIZgI+uV7HjqDcBuWkUxNz44agZWKEQfeeWPUKXUQPXAXjQ7Jsbv/hj6zSlkSRrgWBdF8
 v05DcmcWjZ0izIPXftsRRDKiOBfxgWjEklITQcA1Nmq+57jHlAPg90V+XAorN9wvEVTgMt+gERH
 YdCYs5PaSe1LBYcdoWTIXeC3BHIu3deEHfL0YINJeq3JHtp4savmVuT0WtfYDRiO7MKCi50sNDW
 hVYxbmZitn+IJ95n1Fg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260052

The dummy phonebook backend always reports NewMissedCalls as zero.
Patch 1 fixes the NewMissedCalls apparam encoding, which used the
wrong width. Patch 2 makes the dummy backend count the mch vCards
and report the real value.

Fixes PTS test PBAP/PSE/PBD/BV-05-C

Jinwang Li (2):
  obexd/pbap: Fix NewMissedCalls parameter size
  obexd/pbap: Report NewMissedCalls for mch

 obexd/plugins/irmc.c              |  4 ++--
 obexd/plugins/pbap.c              |  8 ++++----
 obexd/plugins/phonebook-dummy.c   | 23 ++++++++++++++++++++++-
 obexd/plugins/phonebook-tracker.c |  2 +-
 obexd/plugins/phonebook.h         |  2 +-
 5 files changed, 30 insertions(+), 9 deletions(-)

-- 
2.34.1

