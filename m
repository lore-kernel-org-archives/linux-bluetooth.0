Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4167033689F
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 07:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481335; cv=none; b=qc/awnnCuaLIKs7Qii3q3BFaWpzo1xGu1WLjA9ft5fjh7pAA38hjXGG/Y75nfUoWp8SbPh8EkUs0EoV5pFMSCS78eYd+wd2E3fEUWVp8DZY9TKyPOAPm5ZZpbXcLnwL99trk/fkEoDvl6VWKVImAYhWiCcNa8jBTx02oVrMpxsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481335; c=relaxed/simple;
	bh=/jDr+TE5AK7mqXxl9PS0ORJsm3OQGJ5bvCRBcPdRrbg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EVwZgcrMBr2LFd5nkzCfHJqjAVhfVNRC3XafBZjfEpieXQxiiUpWxHXoi+cDbvRWuk8xydHWhBxi80B+DwRCzOzIbVWzrdX8cJd+scylw9XJ40I2AsORaJvDeVB/ei/n9uHTfv3xlJ5p6z9+85fPaRo3acOcFXVszz+Nz62M0Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K1eygaWO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ScUpjeHV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K1eygaWO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ScUpjeHV"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V67DIx2960533
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 07:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=iQeAp1phoAi1CXzrNMAXV+EGZzXeKwaHjUx
	IvIAK5dA=; b=K1eygaWOd1UfJ7XUgEoOeeqaSZBLiroIlccoxJvBmE5k6aS9mSi
	wqyFs1Ws4UW9yNQIIJ/x1SwDNY8sTiR9uMF6gZ7+R29qzO8PPmK6pKKzZECt4/lY
	2UytNHp01rBoXnjFqRXwzGoUABwWFwe/LZZ6lb11abNEtt+QfmwvGO+p78AbWNlZ
	ZLFxFY25UThAdaNiadhY16u5XCJV01zfiqehsVrrv8dGUOApgFuZdOn89mwtFJj6
	Nh87+fny4SDCdIlUIBxsONPPVnQ95Oq6ltxNrPnF6Yz6NSyvczrL/XUQn4PogClI
	o5qw0wvul9xnN+uM82L2ZZ6PeNPxpdVODaA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frp5kg6gb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 07:02:08 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so486783a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 00:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785481328; x=1786086128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iQeAp1phoAi1CXzrNMAXV+EGZzXeKwaHjUxIvIAK5dA=;
        b=ScUpjeHVll7TDSTK8nyd5uaSXiXv4t+hq+QF+2YaRk6V6HYdz9HW0AsXnAlTh2GMNB
         aR7TT6bb6p07EXmjlJuznw75LuqaZVY+G0XPW3ISyixGPA+mNZuIA6n7FFFbYfYyFMEn
         l7/woRawWKeIABxgI6cseIIDzOKl85qu4RBZFQaTp5H4F1ZNSJxUAgE6xL8D5hrqnUZg
         qYsr0qO4eqgTVa0Xfy8StDoXWId4WSC5wvrW1LG/jJ8kh9qloJjdxuP/Kqm/Cl//eWo1
         wnaGm9hj2QwI0NBu42QRWgVHhVxKwoW0l3SWEHXa1av3EDpejgeYOrAfTVEc2ROoPQxU
         izBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785481328; x=1786086128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iQeAp1phoAi1CXzrNMAXV+EGZzXeKwaHjUxIvIAK5dA=;
        b=kUS0Ph9oDqQpCFBSKrHdSBrFUzm4AfYdEi2ZdXfNL8QfCfddkwqbdZAcNvd9lFUHoP
         xSxvt2vUBwWNnf53xPtz+TE0/uktPN8Gl1FvSY4OUJBlA3FLmq3MFeww4kBZvmHmZNGy
         0nCMnkeRpxyWxqRgfUa7VfoZ+Ec3aE5HX5/nQOjtX9CYdcppjsEQGum13JTGOXSLxkx0
         yNY0MK/CwxpFip9OVToCjI+uyhe5UjOnO/XfO3DA84I729SxmrNEknV9iA31RaSmbEUe
         2PCLmMMNaUgWYCfg8eW+KKgQO99MXM0jVrR0uVpktsnshnH1AhGknQJPk4vCtoMJBBhw
         /R5A==
X-Gm-Message-State: AOJu0YyLps5gpOKZNMGbMTynoTh5JFVrsI9AzG5c/oTkUf7hGd5ePlvn
	WL86hzAwRwxb+Prfk1tkOnLjeilOZXPl70l2vowYN+NiL+uUWpktDgYbITBSpy5u6pMR6CQ3hxy
	su+gh+S2FkLTbjmwWp4i66/ysvygffDmrZwH/9btoBPXpA4uMgRf8CReq/5zmEp9hZevgPx0GLM
	i/q+I=
X-Gm-Gg: AR+sD12zBy+Tm6xVoK+lZZBt7hNswnyj1Pvg4EgpXkarXoJwrBuWbaGYYKPX5pKNjta
	Rp0yDApiX1AEMTXcCMGIo0azcFZbAtncybZMFRPmBikpWl8uJZhB72afHj+vmZ7UA2YmJVAttnL
	99jnAxY6vBXOH0ns68X2Z1h/bX3RtjpGvPUOjVLBp+dhqgotHTy+9lYnNWdQuChTXuVJ4/dvlK6
	3qEvggjKjZodrgxkGAy2Al1vv7D5wVV6SfiNTGX+zRCAkSuhnvRJhihTuhkDt3TsIfNIduFPpOB
	1T8OoiXeaZlh8qh/rbPQQH6PRedAx1eFC1cpG7eLJr9euRVEotPgGrVyN3VECvekNuaE2aJlgeq
	Rx7kCYH6KXYvBTArHNl2laznnAPb9EA==
X-Received: by 2002:a05:6a21:7d03:b0:3c0:ac0f:6558 with SMTP id adf61e73a8af0-3c91b063138mr776579637.2.1785481328030;
        Fri, 31 Jul 2026 00:02:08 -0700 (PDT)
X-Received: by 2002:a05:6a21:7d03:b0:3c0:ac0f:6558 with SMTP id adf61e73a8af0-3c91b063138mr776545637.2.1785481327602;
        Fri, 31 Jul 2026 00:02:07 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab050d8csm182879c88.0.2026.07.31.00.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 00:02:06 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 0/3] doc: Add CS distance provider documentation 
Date: Fri, 31 Jul 2026 12:31:56 +0530
Message-Id: <20260731070159.2769120-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA0OCBTYWx0ZWRfX+MkyhzKypT2r
 b7T5Sv76sfYBSMsAf7rJtGdFOA62/wJoYziEKU0/+XSjq/y1aOzK+EBOTFTU0WKbPIdWVd/cuB9
 m2fpBaY2iMHBUFR1fiWV1x3iDA5bbdg=
X-Proofpoint-GUID: QGa0ueFyO1GmeHocGu60lrTOZ2umSmQH
X-Proofpoint-ORIG-GUID: QGa0ueFyO1GmeHocGu60lrTOZ2umSmQH
X-Authority-Analysis: v=2.4 cv=c/Obhx9l c=1 sm=1 tr=0 ts=6a6c4870 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=rmqRgaYpmlVIJLOMcLUA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA0OCBTYWx0ZWRfX8wJ5j/GA2+sj
 BV6U/gApuVKgZEwmPbYR47xt5QvKegizfyJFEVZJitOqldEVas1d7dlKJCWzt8fCayi9NYMnU8V
 1O30StjE54fCybGOwHZJDMqxMkYe5rALRjuZR10GPCEJj7pdn4gPzEOXLkhTjtp3wpWg/ZjBdTS
 AVIbxK1iBG3GwHaAoayNRRcDaR7tmPGZbWueacQueOb4dyGocSbceulWj+vjgzXYNcCrC/dI4Xq
 gaOgOuJpSNO+/w8jhzAcbzyOaYovTL4U5FDB6zWKDfwnoJKLQKZhzMF77bmQGStxHhmEAirsgOr
 7Qup3cWvxUj1JDTumKzNZSITJY5/cVyzQUwllDsBOXi62YHuHCREjJW2r7F1/Vjb0z3J9u48WmA
 QpUnLdZ00+g3hrmv+tuqq1S27iS3GAe7UOV2W9wotAggFj6FLIsZjrhvyyUKZr4T2Z2rosUBH0e
 G8448k4TmVbH0sRnCVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310048

This series documents the D-Bus API that lets an external ranging
daemon compute Channel Sounding distance estimates from the raw
procedure data BlueZ reports, and feed them back for reflection on
the device's Channel Sounding interface

Patch 1 documents CSDistance1, the BlueZ-owned interface
that reflects the provider's DistanceMeters estimate for consumption
by desktop clients.

Patch 2 documents CSDistanceProvider, the interface the
registered provider implements to expose per-device distance
estimates.

Patch 3 documents CSDistanceProviderManager, which a
ranging daemon uses to register/unregister itself as a distance
provider.

Changes in v2:
- Rename doc/org.bluez.ChannelSoundingDistance1.rst
to doc/org.bluez.CSDistance1.rst
- Rename doc/org.bluez.ChannelSoundingDistanceProvider.rst
to doc/org.bluez.CSDistanceProvider.rst
- Rename doc/org.bluez.ChannelSoundingDistanceProviderManager.rst
to doc/org.bluez.CSDistanceProviderManager.rst

Naga Bhavani Akella (3):
  doc: Add org.bluez.CSDistance1 documentation
  doc: Add org.bluez.CSDistanceProvider documentation
  doc: Add org.bluez.CSDistanceProviderManager documentation

 Makefile.am                                 | 15 +++++-
 doc/org.bluez.CSDistance1.rst               | 36 ++++++++++++++
 doc/org.bluez.CSDistanceProvider.rst        | 32 +++++++++++++
 doc/org.bluez.CSDistanceProviderManager.rst | 53 +++++++++++++++++++++
 4 files changed, 134 insertions(+), 2 deletions(-)
 create mode 100644 doc/org.bluez.CSDistance1.rst
 create mode 100644 doc/org.bluez.CSDistanceProvider.rst
 create mode 100644 doc/org.bluez.CSDistanceProviderManager.rst

-- 

