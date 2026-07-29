Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D62E2E6116
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321028; cv=none; b=sYhJOtpRZi2InN5cKVIWyS627If7JeXCuAxdizzLGhKo0BI6Bwb5L4wcy3A/FsAUlOgBd9w6bYCrYIMK54AiJMBw1qRN+SrEITKc4T0nFppgVf67nFYV8gswCX8I0Te6D/1obiadrt+MblHpJo57/yt4YDEDMoEF9yisjiQs4oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321028; c=relaxed/simple;
	bh=RpxxYiwGXx6NrJ12xJYfrN8AbHzgtMzatTeJbVjK3/E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cY+9oHcIGnA7lvnYhwhzsnCCR3zWO0xBM9ZIP4JTQVJTvcN1KGdgpDwjneuWWYT7OZxJDR0pSpdOrD8BTPZf+mPM4DG49CRNSILDdVP5pJRPcCM/iEqYu2/r2v8WAAbBz0PnnHiYOHHM5+YdXcrPJVSIOiSwk2+aVEuH+ffCllA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pMWvxPjS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MmJJ4xrg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pMWvxPjS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MmJJ4xrg"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T9o7oN1870413
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 10:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=WVT+RlcoKfofr85c/LXs86jrHrSMDUvyUex
	MmxD7bKQ=; b=pMWvxPjSnxo37ZqSEgd0tIM3/NfPb+TK8Pa8MwqemS6UOGWSpVK
	ISOPZlxDwX3lhDWrIeVCs3JelhLmGHVPMHUtPVEYBV9B9sdYY5CrjNKj2inc439b
	KKUGqnfq3zFkfK669pkINHME7ikzl4AJavggYp3lKNG3NqzKD6e6NPnABGXCiJrw
	askRGvg9fD6PkFoDXG0/aZKFf0XzWPoeFtOG8nLQbZKSdC4HuNktJJZ0+qsuMnFN
	cXcWKN7z6Xas32ydV7LWYhUdzKe0GylpuIxO3VKzogep3STvq+53BmZexb7VBMIo
	jhiFne45eloV7qlZ3qDpamaqe7firpYclPA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqf83861b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 10:30:26 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ca860baea9fso1611172a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 03:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785321026; x=1785925826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WVT+RlcoKfofr85c/LXs86jrHrSMDUvyUexMmxD7bKQ=;
        b=MmJJ4xrg/hm1t8Jphsoa9MhW0l6+oDsG+AYJE6XSnLsFUBvElqDMznjBTD9J7tMI48
         /prq1jCM1/CAWFs6k/1REJZkd6FG+x7LdyPNZ/Iw3NOHUucDV7XNwa/0VJhDiwWGLeGH
         RQyspIEJFObP9sKpzW8cC/ze0DRncjmkvOkxy0USl/46pwnsh7O5yCXxlNeNg0zoplGV
         qaGOWpJNKH7R2cZspIDtwztpCLIF4k+22QSJxE/7jVrrZEJdWrYyJsm8B6Fvn2Xlfc4M
         AQcOnGySA/bcggpye2YN5Bx6FJPHQZvVp3uilwFHO3fowW9jKy+ch4/XoqMeCAIhNCnm
         KxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785321026; x=1785925826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WVT+RlcoKfofr85c/LXs86jrHrSMDUvyUexMmxD7bKQ=;
        b=hms3SZK2dC6c/CLP1/RUCPdW5u6eRYfLMp2bdNw50fvaC/Zabpgr0JtgYwVciTUgA+
         VMu9KpauKwGkLalbo9mFdUSGlq/+1z4IbKsROgS1T199hWrNSIRgroZSzEoDvO95EJRp
         yhzpez8vQx4MfTYARfblLVGUrxplOaumZdWGZoIUMzMlZcIjWEYHgnOqCaGXg6iEzuH6
         Z91sNwo8VqEd/4ZR75HR2JCums+9HAQ/osYTbtBCTsKDvrc6wgRlcBQjWOoZnUtXzcIz
         OYDr0pCpuLka0ghp7YG+D9NJdcaMl1sHrP2yvKtVpa00f/kRCyr6zKjqkBWwqzuzMfhC
         Nbfg==
X-Gm-Message-State: AOJu0YxFLgKYlbKtBndgKFeljtNP4vNcAOAq2+k0GheYCVBK+ISVlduw
	rdyTprwteVyfPQeDNfXGr2rlwWNRuUUoLq30ecLulSaXLmnfG3/f5ZKEppjHeCNXobn+P7dIPvY
	1fieOt0Xdw6HAhl4yG07KJk9YVhJKaK7pJ/kIIvyfEy+Mctn9LteT3oEJYpJCrMpDwNu9qKdUmP
	Yxk8g=
X-Gm-Gg: AR+sD13UjaY9N5XeMtduBz8FpgtTU3wFJ6bEjs++IBhg7sYj89bW3hoABG/eO8JVNOC
	ah1cYSGGq6sn4DTD8ZMRAPlM+u4JiNxJ9moHj1iqzo8hMwubOi/CLA5iuZ4oO9Db4Pl89kJhg4l
	/p+8SYyOdfeG0tIyUVfNQ7GcojHRUUMpYvm5o82GLEdBxV39imG3Y5YQpjCOVw/GxiJJrv41OuR
	liiCrydWQ2ph+c+T7pQ6nyQQ4yaMw+sdrglzDkPl8jCyCjS6WR8lnqLnG7GeX4ggxP6m/l2bwLv
	ypPmleAIL5Sm6T5SAtJzbMNwOuj/9pODiqz1SoanzUNRnSoQF8573+FLMkFTNxuRoaqOrmEOkZF
	i+OnTJh4IuwrvnqAiCGnSSsovoAIadA==
X-Received: by 2002:a05:6a20:2d0b:b0:3c3:a0cd:9d27 with SMTP id adf61e73a8af0-3c8ad4631cfmr7269242637.26.1785321026235;
        Wed, 29 Jul 2026 03:30:26 -0700 (PDT)
X-Received: by 2002:a05:6a20:2d0b:b0:3c3:a0cd:9d27 with SMTP id adf61e73a8af0-3c8ad4631cfmr7269207637.26.1785321025879;
        Wed, 29 Jul 2026 03:30:25 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7262bc27sm11028649c88.2.2026.07.29.03.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 03:30:25 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 0/3] Add CS procedure data aggregation and D-Bus export
Date: Wed, 29 Jul 2026 16:00:16 +0530
Message-Id: <20260729103019.4178720-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA4NiBTYWx0ZWRfX2XE+VG8AwdI0
 CVucjh/nXnSdXOPPPSEj5QpX2fGp+WSsR6hy4DYIwy6lIbGbr4FQQqyvTUaGTzVkVRapp302mML
 /Rvxok0kmfbVjAkZZSzgu3jYBXfsZwU=
X-Proofpoint-ORIG-GUID: CDA7DkvvcbZwmw3tGzp4_tnmo_34PQbN
X-Proofpoint-GUID: CDA7DkvvcbZwmw3tGzp4_tnmo_34PQbN
X-Authority-Analysis: v=2.4 cv=AaaB2XXG c=1 sm=1 tr=0 ts=6a69d642 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=oIet3pLuq376Fm42oFoA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA4NiBTYWx0ZWRfX2o/TDGHztN0q
 rqEwntaLE1We/YC/1STDmuDfw00adObn/t599noKvJm3lySAXqgKZNlEr+Iwn6mu+yt8v596Dmt
 spqq7z0lcZ9eV1KBD+I3rfANScDj7YxgTDap54xb7ZltdN7GYZ/AGlCSVXzLlXTxFYJxgiUaE0G
 6Ol7ABNJ83OPlE0YpeO6g+mYLhMcTviZUa3eM+z1FS0nMYM4HmpXxX38EQXj8fnoOY8fGkikTJ/
 EAU+7RCpqkWxP8KXy8X/tuOb7o7Xf2Jfl8e7l8KrR8wrza08r/DoxPHw7Fl4F+NgAOxv31xkLPT
 a2DnAcD2Ep735fGuHjlh8vM4aWzx0TC8yl0aA2tkRVK+rJCGwcG7VWGi8MEpqLqGJbltnPsda2r
 +eil5BOslc1FcnqIH2LF+H5+w1Y1c2lUeb5rzgLnqLJwmtS/DF/HXc66rC2btpJzQbS6Tzhf0yi
 8pVDD0TZCOhuQ6vRRXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290086

This series adds support for collecting, aggregating, and exporting
Channel Sounding procedure data to userspace.

The first patch introduces a new procedure-data aggregation layer in
shared/rap. It tracks local initiator and remote reflector results for
each procedure, combines them once both sides are complete, and provides
a callback-based API for consumers.

The second patch builds on this infrastructure by serializing completed
CS procedure data into a binary blob and exposing it through a new
ProcedureData signal on the CS D-Bus interface. This allows external
ranging estimation daemons to consume raw controller measurement data
without requiring BlueZ to expose or maintain a fixed D-Bus structure
for evolving CS result formats.

The final patch updates the D-Bus API documentation to reflect the new
signal format


Naga Bhavani Akella (2):
  profiles/ranging: Emit CS ProcedureData signal over D-Bus
  doc: Update ProcedureData signal doc for byte-blob format

Prathibha Madugonde (1):
  shared/rap: Add bcs_procedure_data aggregation and procedure data API

 doc/org.bluez.ChannelSounding1.rst | 365 ++++++----------
 profiles/ranging/rap.c             | 285 +++++++++++-
 profiles/ranging/rap_hci.c         |  59 +++
 src/shared/rap.c                   | 673 +++++++++++++++++++++++++++--
 src/shared/rap.h                   |  50 +++
 5 files changed, 1153 insertions(+), 279 deletions(-)

-- 

