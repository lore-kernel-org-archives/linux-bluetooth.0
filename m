Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B7C30CD80
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289754; cv=none; b=SFQxciKVUjJIHyhEYVfAFpidVXrqK/627hyqKUUGqoauJ2UG8HWoQweZHD5afKg8cw81cFyDTbr92ebeGt8mUVy1+6buW7CnrhlJ2CIzF+CzLn2ezqoGP65+zjxGsjad7a1b2Jl2e3d0TGvPlzzA/pcfqADJGkPM/4uN0h7Ivac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289754; c=relaxed/simple;
	bh=ldZ309+3v5eVbxYCuM60oGyqudE+fq4WtmLYyrXEv3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rj86QF1nlOxcxVRGeglY9mbv3qYghpZqKyu+tQsXkBtLWbOGtmTxWtn+ZoxraesoiJ7l93T/yl1+2PBvndv2ggUpEEScJgG9aGrDXzSLRdMi1cS85T9TbMyjkK+S8daZBZ/B9OA8f/zsOuOj/+HEtIYzlJgcNXinPCQ5Wzx/Pyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cNBsq6sp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BdH/Hllm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cNBsq6sp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BdH/Hllm"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8TGYU3682681
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 11:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=FbJ4BcXH4DDRjj4fUBvTzihnv9MZwO3KZs+
	Fn9ZLpWE=; b=cNBsq6spRxbcndgrjJsDFJbsjlu0aF3GwZw9WDdE4JxMPSfhuZj
	Dbx9ppSDWw2X3bVCZTJWBCMwENDFhMvwkC7HYI1XF5BBl+nqkGN75kLlcOYf9NRt
	Rhd3YcoqzbRdk7GkDRnMGhxEOGCi8L1Q6DFYV/Y19LRd5Jb76U5Dm9bPPZO/I4VZ
	gAKiqNLvYxJte1SyJpLZwuj+H6MK1fxaogcdrTtPxXj3mkS7E+uDe2z0+qs5dxdo
	JEMySOc9F7JN+HJaR2HMUtsPxoXl5RpY1IigZgntiedcfmOBRk++fMfcUkmGL4FR
	N33XXhIE+0lNUTyxIdv/dz9m9a3wejNKS9A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnmr5vpn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 11:35:50 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b2d83e7461so173065665ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 04:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777289749; x=1777894549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FbJ4BcXH4DDRjj4fUBvTzihnv9MZwO3KZs+Fn9ZLpWE=;
        b=BdH/HllmIJU6eo1ttfEHY+40lnkWIJJNjSOzp12ch/KZBjVvkX4XAFE22KQ7LYKbYB
         65deQpIwPEkfHM8258V/Svu9aEfnWfrWe/GSK+3WEf3244JBgA/ziFlEI9+faqagZWQB
         wb+xXu0erRj4zVJBjNOHpMa1l1nuntws/ccUV9zfrBtDXeWNOsKxodrOlngCIeARALE+
         SqU1Kf4gKw1lXl+kbkdedTMf4c7LGGYbhLKxeeDFzQwJdxBmyaC5tmWfF4XC7S5/XNNO
         T/ceAQoa+fj0jkL7bsZpoMIVSHx8IJGt2X9Z216x+SJ3ZHK8extObH5YZocJIWEAyw2W
         32jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777289749; x=1777894549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbJ4BcXH4DDRjj4fUBvTzihnv9MZwO3KZs+Fn9ZLpWE=;
        b=CLadZTouwJxzSLD4jk5F0kCMNM5CwlBgauecVMmJcSZEOf3oh13hhzdITRB6s/IeOe
         WWj/gU2zl8mWTCrj0q3kxSgLxGB25tfkBhvp83eaPrpadyDVnHFA21WguN+Wxh0iwr3w
         T5vH8VpZ4KT3dRDzbYA7+aYV2pu94uGyuM/x1ufWGsPyZVMl/DDAbqfyYrzrb0N5QoWf
         NlKfoMJlCkGhvXy6PJHagrmUaI1KuWUqj6uke5+UP6zItBS5RHFx86b1BpqBtDRH2d4J
         7s7zZEqCJUsTMM4RK7RdziM8sTQpZiT5zfawE6jeVFougnLM+/nmabr1u67jLAx44HAF
         k4lg==
X-Gm-Message-State: AOJu0Yw4GeuzmqsVbrYuSS+xJ4qJC67KJLLZuTzLv8lfnAjfrmZ8Ilb4
	ne/gzd+aJ3rA0GjQ3izIok2yzmRlj2S87zgzCNwPzjHyPOI99o1r7cbHHL9gWNOVw83/qQOucKq
	j9Nj2V4kcHi93c/r1V/K7vixWK94QRXucfTBkzATc68b6sifob68LGKafoBbROWCCfAEljLJjLv
	by2w4=
X-Gm-Gg: AeBDieuBLYA6jcgvj5mm0bUxNZc3jPr14X7gK0hbpDs1cGVxVDwwJgSokoUYj3Mk4Sb
	UXQXM9TGlZUBHgmypOs3C0+HzlpQy9WUHFpDOKpDMz/cLUaINS0/Lrd6nc5IGhTGzlPa9z5TOQb
	oZIMGy3uFdSqbK1Hi5Xz0JKQPZByFtOqUX6oFbkUpTpQObGzNwm2I2pKyjg/x5gIQDEzRxKo5XC
	vQ1HBVgAFnoeQaKaLDtIaayg+Hh70zV2FPcaWAICbsXq2+otglnvIQc829vV11NiqzsKF+KMzVZ
	f0C7npI+QWP/5H5SZeM1Cd/xhll9eg1iz/qdAyUI9PX3aPBA018M/PIU1ikF/ayTEedv9VtrO9i
	qqEzL130x1+SE+WFvCYZ54SgF1d+fosgnkEPKlt9SUppXA09FW0OKQQ==
X-Received: by 2002:a17:902:8308:b0:2ae:c529:a13f with SMTP id d9443c01a7336-2b5f9eb2249mr300386655ad.14.1777289749204;
        Mon, 27 Apr 2026 04:35:49 -0700 (PDT)
X-Received: by 2002:a17:902:8308:b0:2ae:c529:a13f with SMTP id d9443c01a7336-2b5f9eb2249mr300386385ad.14.1777289748685;
        Mon, 27 Apr 2026 04:35:48 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa1763dsm282921055ad.23.2026.04.27.04.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 04:35:48 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v3 0/3] Add RAS Packet format and Notification support
Date: Mon, 27 Apr 2026 17:05:41 +0530
Message-Id: <20260427113544.1063560-1-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aqCCzyZV c=1 sm=1 tr=0 ts=69ef4a16 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=uroqZWPkk4z-oJcJK0MA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: YE61CE3GPwoiAUAmkVDl9tdMdnYJJPXk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEyMyBTYWx0ZWRfX0wWE3+cz3Quq
 tUVPqov0T559Kwix/I3qb9D5jq1nr2UzMCzR38ckeVeLuOzJ26W06FVu/x5scH5whrHOvPu+R2G
 oGQ59wJHDhG/LYBsFayGMP1SsuUyaP17tcfI4CbBm/EwVDgsAbohXNhlhDfHfMb1wpdIwfVgG0X
 XZh77DdXyPNOBCKsAH9cy9+0rzb8nIT8m+esRFVIxBCXdQr2XDugr1I0UOI8+NDQZYHs0zYx/Al
 fAj1M7vhst3jCnBqF+pEPyE2NY7az7iHxVs5RKehCSxr97eFAC2DF5s+O2MOitSXmXUOFFT6sbP
 vpnjpMEpympvMxc4eeUhsdwKkDud+mBuNOp68SkabdA7ZXtFoyjFw53ms9fbYmZw2HxlstvXQ/r
 3ztFAJt0+038cobyCGbaE+xWKAcwuTRfrYoCG4NSZebLeVIKNH7QPbYV+WJ855FeobgzUmeUOoB
 DCdwatJnwmBsAeDc90Q==
X-Proofpoint-ORIG-GUID: YE61CE3GPwoiAUAmkVDl9tdMdnYJJPXk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270123

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

Changes in v3:
 Fix for cs_mode_one_data struct members rearrage as per spec
 Reading of cs_mode_one_data in rap_hci.c
 Address cs_mode data struct padding in src/shared/rap.c 

Changes in v2:
Fixed missing declaration in src/shared/rap.c

Patch overview:
  1/3 src/shared: Add RAS packet format and sending notifications to client
  2/3 uint/test-rap : Add PTS tests for CS reflector
  3/3 profiles/ranging: Read cs_mode_one_data members as per spec

 profiles/ranging/rap_hci.c |   25 +-
 src/shared/rap.c           | 1376 +++++++++++++++++++++++++++++++++++-
 src/shared/rap.h           |    4 +-
 unit/test-rap.c            |  264 ++++++-
 4 files changed, 1640 insertions(+), 29 deletions(-)

-- 
2.34.1

