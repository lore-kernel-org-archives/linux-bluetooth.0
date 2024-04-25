Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C8A2582
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 00:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714006759; cv=none; b=pBE0O5wNDt7kbw1XFfOTNJNGUrGn4a8aeMs1ydl8rdU3BkESmVMPduq45z4Z6+TrYzhRaVuGSwyJUwfG6hHQTYlPPSt+T0sFhm6ctZZ1FIWF7LQXcZ+EFDPZnCdWfaW0Mqxtvk0elaB195YnoPAki94V+J+QncDsYZ4CQogT09s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714006759; c=relaxed/simple;
	bh=zdvpS05jwv9G8NCUBf2T8HsMtWa9JYlsKOqVEHPoDQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPlBIJWKeNPrc+SlbbPtoj6S12kjJalkRvOQX/Ps3RIK5PnYihUhactvGvZnaf/8bYlpaEz3eKgsuu6S6iJsTOAVSoU/2Z2bIUzUXZUKeCweN6IbVbHbCbyobBtOZGEMe8Ljgk6N5YhuVXfOv6UBxlqV4gr6zZzC1UBor7Wm5oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gveyswp3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gveyswp3"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P0Vd0V022399
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 00:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=BxG1ftKjx+NT7U4zzYng
	6RnBgwGpGOD1G9DoFLLTj9Q=; b=gveyswp39DnGjUfKZklsi0HNgEPxLdy41q5v
	XZOK1Gon+bqcq5u35RkncIsfmS/qcJOj/RdDYWtNG3jCp5sZYRW5oA1cX0f0n31Z
	ES0KS0oXL2H7tPNiMnJxmsySJu8iVmabUV7gMVV7weHUe/m+Ev7D+mLPQuDQJVrQ
	E7I2C8jiEDsE7FHX4ClLQmT8ydEsO87Eo70H6H2LtZoH8184lLESk8cBNXqEKrLH
	8B3AJWlPX3lF2h/GpSov4xKMqplt8iZrM//5f8pi0MJ/GDXYBBF/ICvR0CV5TgfY
	b/0XSOxi8DjYqJM9AnIwBXZIp2SJsz0SXtON/jCObx445yMPLw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9pjg5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 00:59:16 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43P0xFU6017455
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 00:59:15 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 17:59:14 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <quic_zijuhu@quicinc.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v6 v7] Fix two BT regression issues for QCA6390
Date: Thu, 25 Apr 2024 08:59:11 +0800
Message-ID: <1714006751-2145-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713771497-5733-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713771497-5733-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PhaJ6U71QwPyNqOPJ_ieaKoI7Qer0dbk
X-Proofpoint-ORIG-GUID: PhaJ6U71QwPyNqOPJ_ieaKoI7Qer0dbk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_21,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=700 clxscore=1015
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250005

V6 and V7 patch serial discussion link are shown below:

V6 patch serials discussion link is here:
https://lore.kernel.org/linux-bluetooth/1713919602-5812-1-git-send-email-quic_zijuhu@quicinc.com/T/#r0a177b0db7f7185ecec9274460fdf8d369d5c255

V7 patch serials discussion link is here:
https://lore.kernel.org/linux-bluetooth/1713932807-19619-1-git-send-email-quic_zijuhu@quicinc.com/T/#t

-- 
2.7.4

