Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD3639C013
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 05:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663162; cv=none; b=ahbpUeWk8S62S9yXq9UjFcc4FZeuPufKPP+RQtSWMZpsr4Q1I+UiSV6D07nzVTYnpwhEuchUAzVdRpiRL8dAbMCFaIh6VZhuqqz2fv8h4epgKLyuz8jdjKqnd7MHun0efUsMuEonb5tkQ9Vk5xqHYpba+WaQgGvrithK++5FzA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663162; c=relaxed/simple;
	bh=SkReEt50Sh/wsMzlorza5xGtChevmrmpKuUaqlEahvY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XuZbYPLjeMgn152VNbUsTJDX33+zExX2TpceLN1pjXLi2rFBSIb0lcFNzCUmoBBG9VwxY0VYxqAvuLROJo1Dbn0Ren6DCmxJOg1Lr375BfolMxWj+UwlcUw0p1uudl6GOdbyDDkqPayBrQ65HUxS9fnyjqfrMOW+BI8CnOk2f2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ELGsFUfF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aYO1FGGu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ELGsFUfF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aYO1FGGu"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A3n3B13802165
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 05:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Y3HWL7FUxAozLAGHTfyAHE79eroZnGgejCg
	9eMjjCcE=; b=ELGsFUfFS2CgEre178hQaMxWd+m429wc59rc2/b8HXXR0dEbHX6
	1Ku4PmyDz6hm1weToPqGdT30Q8znnjR3k2U6K1r080v7gcqTUz8qxAU6FHn7jZF6
	1uHn3I2k/llZOlQH+vZg8o64xQNZgWwBRlspU0NlEwiyyAhZvaOOHlhVaNygd9XB
	bRWDS4IYIGnWjE1hHxwg5Rh52SGAZ15Y8PsS1EVvNBvmRUxorN2YqVc7Ez6wzycY
	i+FTgZ/a415Ttm7bkki/hpAD9m/Haeu184P15sT+miHwFiJRBYFDGyL4/7YkXd4W
	utjzdhZImVy5tSefMl+tLYUNh7W9cpTyDuw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4facqpkhvu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 05:59:19 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c88fc985a65so1004421a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 22:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783663159; x=1784267959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y3HWL7FUxAozLAGHTfyAHE79eroZnGgejCg9eMjjCcE=;
        b=aYO1FGGuLsIqimOztFN+CBa54uCRyXLoEGYs7sGoZBsW+nrYlk9FWwWemV6fHEBM80
         Gu2FVWx7CdCIJwNqwVdEvTEOD9vGscNIpXG9G8Npk2s+Zx5dyHsPyRRGFpPhT0vgMPCc
         sNV1RNLy3ODYhGBk04aPEShITb6svpJaCoXdTrq/O2lAdCnjZCvNuCQj2SoW4rpm63wR
         l7ycWSXljWjRCs87W/yCdLeHfkgua5OzCOuLGi1hOU1MCRuTk4kRv3GBkeAERNTD3d4A
         CGZdDkf4oVVNCN8hrn3RBZ5J58gq+GwtBwDQfuNTZ7+QWxtZlR2amazrP1FUExd9xUB6
         mXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783663159; x=1784267959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y3HWL7FUxAozLAGHTfyAHE79eroZnGgejCg9eMjjCcE=;
        b=TtgNub4Ipz5e/oOZNp9jM7JJdHzvMkdgJep7ErUIlVovVbk4vqbaD1Wkrs6VYOmdQS
         6e+6u52Vyub6MYewVZ3LcbII26fLOtt9HiVtndTsLl/0EvrqYGyr4NGRMfWF7hqUvAY7
         4MWgSOI3dsvfz2W8KgoCUTxAm3aMW3qKnE0GJOFcl27izCxZW7IL1jdZyMJkOEI3fSJo
         JebJlbJOTO5ssQ43CDnprpydO8nU6y6TWgLB3kmKFD+aW6RtvhvPj+Ozth0pU8BgIN9w
         OK7Sb1jalep/XfyamUdKWu8SaccDm8tOKwUae0Yp80/p8nlJvqoMJo/zCfbncAaYyBRa
         LATA==
X-Gm-Message-State: AOJu0YxReeBOfIt+dN8PsjToH/KnkaNLlvb9CZ/ypH/OjkiTSY9+ukuF
	6lqu2+AEl5o8EchIUDF4rK6NMQQE9/qr26iyY5iaG3hy1R4oSalBtwbSU23f4eUeVVF12UDrhtj
	cFF5PMpdA0cT/r9tlfDXrGxKGUYTwzi3NOXha942f5RMF/e/2NXJw2IqqlubQvVj9hlxwrPa1fp
	jIQsU=
X-Gm-Gg: AfdE7cl7K+E+nF0ku82RMmD4Iu2eROO6V5SQ2Io/t6fnENH+9tZU+heTZpbVKytlfwR
	SMD0uB+xB4p2cRpHIzxnM+FYU2vdWGnk2Le98MhtlH+0+u1m91P7JwVo0wk+7MHYHy+/6mNUamX
	CCbX85e99Dh+sfetUpUvM1ixSvogNaJsZmAHiry0zrIk4w+OB/g5O7pfTrjp6p1IYN2woVuXIWm
	J/51AsL8+lZ88uim7a/oPSWskfTuP0jE+6bxujIOLiWD6FDrGsfGlIhWwq6ied5c5BQinoEfG/f
	DbBvV7A2thLjwxGruGCwqpKIcmNdmifiUT1fwxLYOzxQT02ORfoYLw36Cu+acyD17zC3rB6jP9R
	TpJdpBGBSX9Qy7bLvoSngwXL0VilIN22wYmhxpBvb
X-Received: by 2002:a05:6a20:430b:b0:3bf:bfe6:ab6e with SMTP id adf61e73a8af0-3c0bcf49b4emr12815185637.6.1783663158683;
        Thu, 09 Jul 2026 22:59:18 -0700 (PDT)
X-Received: by 2002:a05:6a20:430b:b0:3bf:bfe6:ab6e with SMTP id adf61e73a8af0-3c0bcf49b4emr12815153637.6.1783663158246;
        Thu, 09 Jul 2026 22:59:18 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d7c8bsm39678529c88.12.2026.07.09.22.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 22:59:17 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v4 0/3] doc: Add Channel Sounding API and bluetoothctl documentation
Date: Fri, 10 Jul 2026 11:29:07 +0530
Message-Id: <20260710055910.3691701-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1NCBTYWx0ZWRfX7sWAJanUWiyY
 yLcgJyg0y9DwcekGW/MrrfUbRAXHlSSUNqRYCfhlxuODGZkSa3lZRftVyNKPe8/E6W0c5xPquyo
 /V1eeOJsLCQlUJF7Tr5i8GtOKsVqy9fQBmAB4uOmsZC/f2yg8NExRR1oVg9jfAVlpHob/1/cgSQ
 mHdjT8rTICehsIjOgFBXlpG5TknMbGdapzwUgDZ0S5Ftdx7Q8dKgYCxVkTurynCI821FF+eQXEe
 A31yZ6rKPITvuu20gKqV+PODNB0urnnHhSfJHyi/OkrejPobw2KE2o3OugUHy3nsfPtQ3Znx24X
 SXsyEKKwZjrVuwFfyGhlJD/LfrNq1lIc7Ro/TT0ayF7zabGLwNYy+RP6zwP02JzDJhOy6gE55/j
 fQGOE0rNv1xCWSPuF1oocThF8Z/ok3ddQVvWb4OiQK5kO2v6ICxKUWiF8vAvXZLgohz7h9vN2W3
 oRDIhS7wrtf5n7WfRXA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1NCBTYWx0ZWRfX6iEbH8yQGyOS
 2XyonY5M0IzigkdpFxz5LHb3kaZ03dVC9MsZ1U3cULYYqMU0+CmUfo/KtX5HMMGXoewNv4doOFX
 p79S1hg31JHwbBC6ng8XKwChLnbglt0=
X-Proofpoint-GUID: Tu3PWLxmw3o_I1N1UUCnNgs2Mvpg1184
X-Proofpoint-ORIG-GUID: Tu3PWLxmw3o_I1N1UUCnNgs2Mvpg1184
X-Authority-Analysis: v=2.4 cv=GJ441ONK c=1 sm=1 tr=0 ts=6a508a37 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=iSzkMiWJHOwH8bCpblYA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100054

Improve Channel Sounding documentation by adding cross-references
between the D-Bus APIs and bluetoothctl commands, along with practical
usage examples.

The D-Bus API documents gain :Used by: references to the bluetoothctl
cs submenu and examples for methods and signals, while the
bluetoothctl documentation is updated with :Uses: references,
argument descriptions, and usage examples.

Changes in v4:
- Addressed review comments.
- Dropped the rest of the previously submitted series pending redesign

Changes in v3:
- Addressed review comments.
- Dropped the rest of the previously submitted series pending redesign

Changes in v2:
- Addressed review comments.
- Dropped the rest of the previously submitted series pending redesign


Naga Bhavani Akella (3):
  doc/org.bluez.ChannelSounding1:Add Used by reference and Examples
  doc/org.bluez.ChannelSoundingRanging1:Add references and examples
  doc/bluetoothctl-cs: Add :Uses: fields and document arguments

 Makefile.am                               |   4 +
 Makefile.tools                            |   5 +-
 doc/bluetoothctl-cs.rst                   | 283 ++++++++++++
 doc/org.bluez.ChannelSounding1.rst        | 534 ++++++++++++++++++++++
 doc/org.bluez.ChannelSoundingRanging1.rst |  66 +++
 5 files changed, 890 insertions(+), 2 deletions(-)
 create mode 100644 doc/bluetoothctl-cs.rst
 create mode 100644 doc/org.bluez.ChannelSounding1.rst
 create mode 100644 doc/org.bluez.ChannelSoundingRanging1.rst

-- 

