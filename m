Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017D323ABA7
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295322; cv=none; b=TuWFMeexYm52ktqJ+eJyq3UAv3y5auv9LOIPsjRkY0pPIYbXzCfd1aPE1ahggFg428zsixZS0JZHYLKcgqozRr8ZPbMxzThuuaoGPs/auEYqrXF4XzNeoF4zqILAAkmB+GBoTx6vLAspGN2XxwQZp+6YqcaglkzAsLEaFnfbtJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295322; c=relaxed/simple;
	bh=BjX3G7hUKzde34zRoCdNIJyWS4RjqtHrIzk7SBHYlMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=clBnIeXhkbHGKetALdmdhGLpQXyAGt5FCe2lWR/++VucpmBqcc4u+tqai30wROiK7j6FzeqVKncwxyrktLsBKzUS8BR1q82jxK0NQaO15P5IK1nr0hJfMdsSqt+ZaERIeX9ET8ShyiSVLz20+ldMTccOWOnP3Hj6cQgdye9tTl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NilAiF80; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WteYnLx3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NilAiF80";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WteYnLx3"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HCSujo1456589
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 13:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NHz+52mTZ1Y
	l1Fqz0o39aL29ch3swm3WeFdFuw//z/s=; b=NilAiF80oY4cfUTmBQrjyzi1qtK
	33Q5RVY9DL8hJyFR3wSTE/HOpfW1MTOACfOvxtsCEybG9F1w/3OTuy/VAgWghdNx
	/yKWDc9oHRBGDa1O7A2ENKXMtyUaJ/tyXgZL8aR7HXMQr0N+deHaZjcSJj5ei/nW
	kDYb46p97q28cLOZWZ5HDLIEQrYzTqA4ISKZyTt6hDF7hutrnT5aY8g537Mmm651
	XlmEl92RK0OndLoUyX7B4nYD39npICUztWzYqUMf0sGvum/Oz45syTKdLKc6UVue
	kCESN6KwmuGNwD/2Me7FYXJ3xL8iVjzZ+5mD7L84T7qRV/wkTHcDqp8eLWQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffj78rr91-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 13:35:20 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-388cfc4848dso9518422a91.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 06:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784295320; x=1784900120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NHz+52mTZ1Yl1Fqz0o39aL29ch3swm3WeFdFuw//z/s=;
        b=WteYnLx3ygwpyXdLU/O+M7QnE5a1FEPzs2eAXu5VIX7p71JNVui7y9YhtGGPMYA5up
         7qDQi+tMT1oecdYtcgokjxnwtH7pCSGCWD+YgBy6H3I5LAjj4Ws33bEnAOTsBOaQPKL8
         yX9Sozm+Vp5f/n7uSg9V3YEV2Ccnc2Cmb1rp7Ie0kUX7EhvUVJpkBvH6I7xJi++UlyuF
         0NjrnZ3Khfp+mBuhvSRQ25NkL/XEkHYe1CG7zzzipM0A2FDTZp05MA5Y3REYyPL6IiwD
         +drXDtJv0nF2mLR1iUV9r/TpF5fPD6yUnCJsi9qs4G2ymsfWnfxxwHuv8nGgrfkebW7L
         lTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784295320; x=1784900120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NHz+52mTZ1Yl1Fqz0o39aL29ch3swm3WeFdFuw//z/s=;
        b=nMDW9LBZdJf7m5EDTA/dexuJ2R+Au0YJEOfKZQlLRavsHaUS+/zeaBTbC/VbSxDpQN
         OAtPOQOLE9r0plfoRSWcgjQXdH6PMlcJEREmLUdKeydlxqnWsTfPxWZevjqzW0x1ymwE
         Tsdc01q1S53GeR92yw6JrmVXaleCbtfQqzH09uq2xkOmQKBoDKWRIp65ZcF30cguZxi7
         OSf+L80b3iL0h/zpbxydGHeY+LNksRe/68ZxndDBqwX2G6aE5ZlCGT2Qz5kEPwzK6M4J
         JQJva8oL6JG80VJ/iMenTXKzQxrzJ2i/JzaGd+nYXwVd075e1iJ4U1JXEwZXKgud/o1o
         2+lg==
X-Gm-Message-State: AOJu0YwNgtS6fZPDJjocZcZH0IVqkNMBvgmtvchnPnYmZrM0WZyv8RF3
	zh6b0emRPVvl/5WwQdbltp3fhPHrWYEJmQ4pFmaokJMfA9pAwWZi0UAuvc2xczKe7JUHpGzchRa
	+nl8IxrSW6YcPL55sO80Wwt+BNAh6D9gCCko4rORMsIw+gY18qbsafCryI0McM5pVFtma+W8b6k
	/nz94=
X-Gm-Gg: AfdE7cmjFhYh1ucMbWmZIZL7W17UDf7pUo5dUrMWDBXiIr+FQx95EkKJAqsZSh3YhM7
	ueBgXR5A26/Q66wRNHDFkel3kVLi0+94WXcUxPM6sRiZq41Rqnao7s3XyyDflCBXb8kb2Z+oP5D
	GJZoiFkyjatPiH8rmefZZt3vQ5cLFhc3AfyCsL0CyC1NAo757uSVoHOECJXyycVjWS3b8ywZGOO
	ThDdrllS9pisKmZWDJZJ/Wa9535CfOTSxD1po1gBMTpE5KJQBxjVaPPnxIwGdFB9wQ0diAUdpl9
	MnZgE2wk7FrxmIg+V6hd3RbeD51ERrJpAGvxZtgzpElikui6LtY5nmby0THUJM2fdtNAqk+JrJ0
	FJ3jncfV7er0HRBhDeSzTvbAgzivxIg==
X-Received: by 2002:a17:90a:e7ca:b0:381:77cd:38d1 with SMTP id 98e67ed59e1d1-38e4b4113cbmr2462251a91.10.1784295319572;
        Fri, 17 Jul 2026 06:35:19 -0700 (PDT)
X-Received: by 2002:a17:90a:e7ca:b0:381:77cd:38d1 with SMTP id 98e67ed59e1d1-38e4b4113cbmr2462216a91.10.1784295319080;
        Fri, 17 Jul 2026 06:35:19 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429fe4677sm6648774eec.11.2026.07.17.06.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:35:18 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 1/4] shared: Add create_context CS config parameter
Date: Fri, 17 Jul 2026 19:05:00 +0530
Message-Id: <20260717133503.3711396-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717133503.3711396-1-naga.akella@oss.qualcomm.com>
References: <20260717133503.3711396-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEzOCBTYWx0ZWRfX34E7Ps1qpn4b
 0/445rUg2MwlVDH2GD23indlVcFtTHlfkKmAeNgk+a4kIIlpJgrC1dl3Ik9ObgwuV1yDsuhR+eK
 JJ2sJzxKTUkinAe82Ijygxb7N6k7+tExtQrJpGo3BymJww9ClXhLjZfmVitqHCJN/s6CpNYp7vv
 8I8Sy0O3BjUhUOD0J8GKNq4qZm/yCl51gCDBdbIDGpymbuC11rAUSLdBpGxExuEW0AGvm30L7E5
 a2SFh8dmc+W4q5cSRZovBzfZpY1T9Idg9FQDwY1g30us6xogHsphc7LmpKYK7K81cobhuusF7G3
 ztl4YJhyF0+lJquaY4e+z0cGcYWWcBszO3Ik7vYId+Nna+xUUayPqCb/8ysVJhFeyBIrwFpiaFk
 jJgxun69IXQDCY3kYaJgsrDyfucaAtQA/kTbrnExlahw15N/fEAA2nD4BfRLSewyvpfES6VXTzg
 O9CbHkorNhxGbSCxr7g==
X-Proofpoint-ORIG-GUID: cpzxgK325e_SMuFlE_H71inqBsr3Nqf3
X-Authority-Analysis: v=2.4 cv=U9Ciy+ru c=1 sm=1 tr=0 ts=6a5a2f98 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EMcJ9hPvQQp2CzSs6tkA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: cpzxgK325e_SMuFlE_H71inqBsr3Nqf3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEzOCBTYWx0ZWRfX4fERHfJZCKxa
 7pAYn+Bcf8Wba9Z818wuxs3bQDv/Zy4LKfzFUKRQ1guYFKyFXS2G1DTL5bB5W/iUSOPsqztifUH
 jP0DhFyxlyUnIlzydW83uzE+x/PUBwg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170138

Add create_context in bt_rap_le_cs_config structure
---
 src/shared/cs-types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/cs-types.h b/src/shared/cs-types.h
index 0d53d4ab8..f894f8796 100644
--- a/src/shared/cs-types.h
+++ b/src/shared/cs-types.h
@@ -10,6 +10,7 @@
 #include <stdint.h>
 
 struct bt_rap_le_cs_config {
+	uint8_t create_context;
 	uint8_t config_id;
 	uint8_t main_mode_type;
 	uint8_t sub_mode_type;
-- 

