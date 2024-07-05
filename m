Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FB713ADA
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 05:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720157861; cv=none; b=mA4BkuxRSSmGHuTAeUPmBAkQ1inOq72mGAHCPlYPgAgWtJ3yyAm4P7w9PvjE47SLg0JdPky8rKN+lWvK4tnV7grPijNgvfV4giRU5Tmg5Jzkv375/08KdbxWdiKfNJdaWAKDKcKRQDRc2n7jvUYmSTaFV690hC24Dix2jo42KBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720157861; c=relaxed/simple;
	bh=zUaDClbwqcWhgeSg8xjgjdkP0TUW4jRtDn92wu87FY4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tSdBjyBnwpy022iDfo7mcQdVaPJ2kX0iqTrNeGZXLMwXFyuj1dgoWmLCj12L0hQF0Hfq3aELstB2iMqSV/EhIs8tbQ2R/zvHDNuZfvWcmiD0SKqu/G2ToGnz5V8JxR/mdCckwvXhGkTktR5NjnmytZZKzdYXmrJ1Qd4R00sTvlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fBDlEk2Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fBDlEk2Q"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464Nvut3020292;
	Fri, 5 Jul 2024 05:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=yBdvZuMkUZQ/U6UzQB72QyHuiyh30T4AcicOkOsaCP8=; b=fB
	DlEk2Qxn3gRF0AboFS6PwuYLjWvTH8WKxn6q9+HlSa0W+h8t2m8FZF2rWWf0TqDO
	P36Q+u4lrFXRnjgllqGlBYx+3OLa8UF8wvoxTsVW3hGLTbL9ZAPAYU73OfFugjCG
	FIybFQcW2fMZcrc+I1CUnrBfxKgMVKEBsm0DnegHU1FSL3/GwjmVsw5MzASG+d3N
	PCRX+3yUwmpVerAQ3IJ9+8OxSPHJO4I+yfzCMSujNayNU1OxiLrg749zTt5EehgC
	Z1kTsrG6RBIukYlSuJ9Y7kyMNAF3yUWGcgab89uESZOMbA2dbQSwb2w9Nj1jZ2kz
	oeboqgiv76sBZM6XFxEg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 404yr9d6xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 05:37:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4655bQD6021264
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jul 2024 05:37:26 GMT
Received: from hu-prathm-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 4 Jul 2024 22:37:24 -0700
From: <quic_prathm@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <pmenzel@molgen.mpg.de>, <luiz.dentz@gmail.com>,
        <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH BlueZ] Set BREDR not supported bit in AD Flag when discoverable is off
Date: Fri, 5 Jul 2024 11:07:04 +0530
Message-ID: <20240705053704.21991-1-quic_prathm@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4tflY5vr-Kq13vA6xLAMJR05y-WqHDNL
X-Proofpoint-ORIG-GUID: 4tflY5vr-Kq13vA6xLAMJR05y-WqHDNL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_02,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407050039

From: Prathibha Madugonde <quic_prathm@quicinc.com>

Fix for GAP/DISC/NONM/BV-02-C
As per GAP.TS.p44 test spec
IUT does not contain General Discoverable mode and Limited Discoverable
mode in the AD Type Flag. IUT shall send AD Type Flag to PASS the test
case, thus set BR/EDR not supported bit in the AD Type Flag when
discoverable is off.

client/advertising.c : Allowing discoverable property to list in the 
parsing function when discoverable is off.

Test steps:
From DUT, bluetoothctl go to menu advertise
set discoverable to off and then advertise on.
In AD Flags BR/EDR not supported BIT shall be set.

---
 client/advertising.c | 2 +-
 src/advertising.c    | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index a9b865a65..a09802af7 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -498,7 +498,7 @@ static const GDBusPropertyTable ad_props[] = {
 	{ "ManufacturerData", "a{qv}", get_manufacturer_data, NULL,
 						manufacturer_data_exists },
 	{ "Data", "a{yv}", get_data, NULL, data_exists },
-	{ "Discoverable", "b", get_discoverable, NULL, discoverable_exists },
+	{ "Discoverable", "b", get_discoverable, NULL, NULL },
 	{ "DiscoverableTimeout", "q", get_discoverable_timeout, NULL,
 						discoverable_timeout_exists },
 	{ "Includes", "as", get_includes, NULL, includes_exists },
diff --git a/src/advertising.c b/src/advertising.c
index 5d373e088..af3ed2b93 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -734,8 +734,7 @@ static bool set_flags(struct btd_adv_client *client, uint8_t flags)
 	/* Set BR/EDR Not Supported if adapter is not discoverable but the
 	 * instance is.
 	 */
-	if ((flags & (BT_AD_FLAG_GENERAL | BT_AD_FLAG_LIMITED)) &&
-			!btd_adapter_get_discoverable(client->manager->adapter))
+	if (!btd_adapter_get_discoverable(client->manager->adapter))
 		flags |= BT_AD_FLAG_NO_BREDR;
 
 	if (!bt_ad_add_flags(client->data, &flags, 1))
-- 
2.17.1

