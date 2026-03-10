Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B90B285CA2
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 23:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773183787; cv=none; b=hRPErP7Fkhbm9wAu5V0aA6tacE10aQ+IdtU6T7dTuE5ollo1amaUmpfwVo062EGY4WGxruaCez+97s1g5zoG8gFsPZKH0BabR8hWN9RGhVvBqzNFfyuNvxdj3cbemA2KIrCcvQNyoWQiYMmHW9TmVm5f96bGTHVa+qags6e0MD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773183787; c=relaxed/simple;
	bh=9rPLcD8BIZrdbg8Oyl4ClN+isoL1y4oxPSnddoXMDL8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ocAzr+q363/i8iCCw7uVpFIZGQ3EyL3PFRqpuCWWXiAFnAksQX4DMfutuoZc8GQfBQZDWazLhhCLeaCIuDesexk4AlfPAK5H+vJkJSHYhBqWA7aysp8e8UhBP52lUoi9tlbxYiaZn4WgKW6492PWX/7XeOmX4utqODWEKlIsL30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MUaiD9o7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I6CCFHT6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MUaiD9o7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I6CCFHT6"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AIZIoq3296707
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 23:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bBYHOAqp6lRrhRn0NU9dy4
	EisUfXlx6xS/crsALosvo=; b=MUaiD9o7zr5Ti5t9tZmsxKa4Ep3FoMCPE2f434
	hOsUY2xqD2czkbUvLvh2jEAM/yBd7FtEcictKON6htqolCPCRetyWBWPHHhhOPGn
	IS9v52WaKv5hZT1pP0PyXGycd8UVkJYjQbs8jM3Wv0ggZWdMw4w3pNGzMtcs2N0b
	BlA/OVIX2wBjGiIA4M3tD8z1lya+JTqbeHJbCSt74aV2uFcPw8CSyRfARgMEY2SZ
	M45NAhFPUDXfp6Hy/9rXGlf1aaqg2aGotVTH6afqWVN4Qfco8sdgFEyfgZu8LaE0
	UeHR3+XFJTkVL53MaLsIpRVCx4DLeeM1hMrCJJYI8prH9HSQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctg1mu54a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 23:03:04 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-94ea1a86410so2709140241.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 16:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773183784; x=1773788584; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bBYHOAqp6lRrhRn0NU9dy4EisUfXlx6xS/crsALosvo=;
        b=I6CCFHT6yWkTvjIs+GIQC2kOy6egmCJ2Pg38ovnLZsrPiDwD6FKPvVKjT5DMcIvVJP
         C9UR0jm/8CbFPm7HOrQTwTUvSdwTqMV341vTAXH9P5aGrfTbRZf8ZBQsKUEXPMB0lCRx
         Fdz4SXex8fc6EH9R6dro6mrB2RAlF9s2oqEAfkdIV8dUu5nYnynylfIrpaw87sLS8a9o
         huL0kWiZFQx25DNf6UeBiSliojkw1068BPm4/iVAPmWB61Szm9Cw8ekPDYT9KxrtZpBa
         Iq1guW6BLJftR1EBVzvj1P2wMErik6qG9InDLCzb9bGR4fIXgwSSnfpnjp5LXeAIq9jS
         SAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773183784; x=1773788584;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBYHOAqp6lRrhRn0NU9dy4EisUfXlx6xS/crsALosvo=;
        b=WWMdxhu8cDE6RZcYs7A2SU/b/cMGpKPBW9fmkm/kf/zKU8TLoXJGkHxfkLnbChVNmC
         BtZlYMSBXrNEyGtxqGVoqfdQ/acsCHRxyRA/JqrCDRLQxx0HDHpKTkW96dWSOF/CoT9Q
         HbPOPCQ214qEY2MZAhgipPW1d55L51pMekM+hqpSbDncRwH3vlRZq1BDMENtdedEs1OO
         eBdvCWF+biH45TS9hQrRrO0qCyB9DvuzsiIay7DFFKVOY4BbmRUxdAtmjvGC6Ukdedco
         cAbOJTkrSrNTKwDNurZrJDR5PkR7akG5FjXkHHQPk6dNJIqmF52pIjUko4OTXTuAI9T9
         rulA==
X-Forwarded-Encrypted: i=1; AJvYcCVyJMyCAHbQ/e9OWczh3ExMcrWFVnwrxiJOlDkQcyE2xirTivOjdYtJ4V1/5v4PMVog2EOHJYTGXRKEDgoYTJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/hXwyW2qDmDwsdZa6pDeFaxww112rkyCyeYiUPUyc/m1unAIC
	1YiGVB2/YtY1Tp0TlzMz5cb3GHNuYb8XWkm9lAncaRWxV5pOwML1dOc0YWYM2VdLIqwPwwImoJb
	Jqy1CQQtK9I9EsGkPbjY8yT8/oZOL4OMs+FSZJN+AQbX9GBEvHLjAdDx8ss33vWL9zNeiUzE=
X-Gm-Gg: ATEYQzyLnpXSdeP3zEnUH4HkSmOOaRVB2t9/AauIvuJJnebYxzLxbavz+2OjiluCLwB
	qCf8rTupKVf9jCbqkQqpDyILs/AJSdv3Er8ww19ng+QdGkvbxdtH1CAMLjW7d8G+AL7VDy9vBgd
	NH3JxNYOV1m7OnITEFrChN/pT62ww2xEb5yeSRrM/KP4PEkJnfea1k7yxdo7R5FXp3KGrSPdaYV
	m1Rqp1nY2mrfxNvnno51/bWKPT+/SDy9uTDUU8vnyQMAJElJDML/heNIJyVTyQ9oveae+ST6sJ/
	vafk739XuaCWhMr17C8dTOv6CzJVtwS2sG6hPb/d7GusGSbR1TXwZjH37aLkUYIl38r0zioOWYd
	zdu6JketUe4VkfY4eoGyHIOO1z/VDWXR3nBXyApF7tQq/eJTnkY4qNFnjYoeSVd01z1mhw8FY0h
	bgY2Y3URLWy9Z6jrvVCkjKiCUdgj2JM/w7KSI=
X-Received: by 2002:a05:6102:f07:b0:5ff:dbcd:3453 with SMTP id ada2fe7eead31-601defb73c8mr183758137.34.1773183783738;
        Tue, 10 Mar 2026 16:03:03 -0700 (PDT)
X-Received: by 2002:a05:6102:f07:b0:5ff:dbcd:3453 with SMTP id ada2fe7eead31-601defb73c8mr183733137.34.1773183783159;
        Tue, 10 Mar 2026 16:03:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156366a74sm80743e87.75.2026.03.10.16.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 16:03:00 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v4 0/2] Bluetooth: extend WCN driver to support WCN399x
 device
Date: Wed, 11 Mar 2026 01:02:56 +0200
Message-Id: <20260311-wcn3990-pwrctl-v4-0-70e571a18e40@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACCjsGkC/3XQwW7DIAwG4FeJOI8ODGHQ095j2oGCWZGapAVKO
 1V599FEk6Z1u1j6LfPZ4kYypoiZbLsbSVhjjtPYgnzqiNvb8QNp9C0TYNBzAEMvbhTGMHq8JFc
 O1AWrZDBec/VC2qNjwhCvC/j2vuaEp3Nzy9okO5uRumkYYtl2I17L82BzwUTu4/uYy5Q+l3MqX
 +bXzYL/3lw5ZZSHIL1ioK3vX6ecN6ezPdzxTSuLWOFbUYwz9aBAU5jQCpgUoHf4jyJ+KPzhF6p
 oipHaB25Cjw7+UOZ5/gJvwNEMbgEAAA==
X-Change-ID: 20251229-wcn3990-pwrctl-cfa64f9d8167
To: Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Harish Bandi <c-hbandi@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2126;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=9rPLcD8BIZrdbg8Oyl4ClN+isoL1y4oxPSnddoXMDL8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpsKMiKobqc2hRxJ8iMRpZGB6e6Mbn86CcotC1Q
 Xt4m0C89+SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCabCjIgAKCRCLPIo+Aiko
 1bytB/0TzSSxGHV/qUKB3wG+wh9KAztSO5g38Zx0wfniLr4+z1dFi+pvRvfm3AyZxv/fT/fvs6W
 LR6lcHuZVzchaPqI13F29SCrrj17x5dEQJWCMB7STYgUxjr5uLwRtrUcEt68S7G17bUFLkMapfN
 DTVF+f8Oxjq/8uTp7WxTJ/th+//xVjq52KaQSGKBgdOpOIXCcb+ThF3u5DT5//FWPL8i+z/9UzE
 CkIxS5DQb+Ems2kLswvbea02k8oG22j+DAftRDCbhEcnuPCoW4KJ80m/3Xw74ExAemw8swURGyf
 QBTovKmaGzcOM7CWzcVpUQeGJjKTNtZvUFp+kbwXYNO/1++b
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=YOeSCBGx c=1 sm=1 tr=0 ts=69b0a328 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=sVAF8I02KzBGxPgs2jAA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: _hP4_Q6JXg3l4bHZqy2aTydfeYgOqTwS
X-Proofpoint-GUID: _hP4_Q6JXg3l4bHZqy2aTydfeYgOqTwS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE5NyBTYWx0ZWRfX/+kEMmSC9i1A
 sw4IcTlu1NhbIeKUYNAbWs7Oxk52AABDoHH5jelb5ogZxGAtCPXsQsM+V6Ab0HuNC35UW9o0QV2
 L6jhNf07VHzde/+RiW7/OYrXURcHN7xXkU/7HnXA/gU0o2OogE12FS/lowz3lt1y7dVzXxGSeSO
 LTp06AmoDWyL5TuV2kMO9k4yg0TH3Xbt3bhavooGW1NHRBmhjoVxVnGSkFQ7mpet0y0nv9gZzuV
 r18cN/objDDCrqX6toMM+6k3zcNsMxcob2gNGVKmsimIgxg98xQqVicynmFARXSmOwE+qW92iW2
 +EMsRlex8auzu2vztJ35cyXUDxImGSzZc3o8Tiiu3HtLYI0v5tEoqhqzk8iVVTmpQNF7G/lSskz
 L6YJN5y8S7fnHVGW2bhuS/eUfWmWvPHpR0zSu7Wy7ctYpt0bDmfQYHzGrH7Q3Vtd2Frx5MB0WUh
 kod4+1R3DNJNvSmTsYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603100197

Qualcomm WCN3950, WCN3988 and WCN399x families of WiFi/BT chips preceed
the later WCN / QCA devices, but they still incorporate a very simple
PMU on die. It controls internal on-chip power networks, but, most
importantly, it also requires a certain start-up procedure (first bring
up VDD_IO, then bring up other voltages). In order to further unify code
supporting different families of QCA / WCN chips and in order to
maintain the required power up sequence, properly represent these chips
in DTs and modify drivers to use power sequencing for these chips.

Backwards compatibility with the existing DTs is retained by keeping the
regulator&clock code in the drivers as a fallback.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v4:
- Rebased on linux-next, fixing the merge conflict.
- Dropped arm64 patches for now, retaining only Bluetooth patches.
- Reordered patches, putting fix in front of the feature patch.
- Link to v3: https://lore.kernel.org/r/20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com

Changes in v3:
- Dropped patches accepted by maintainers
- Changed ath10k to call pwrseq_power_on() unconditionally (Jeff)
- Added copyright headers to the changed ath10k files (Jeff)
- Link to v2: https://lore.kernel.org/r/20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com

Changes in v2:
- Split the WCN39xx PMU schema from the qcom,qca6390-pmu.yaml
  (Krzysztof)
- Expanded the comment in the WiFi driver (Bartosz)
- Changed vddrfa1p3-supply to vddrf-supply.
- Link to v1: https://lore.kernel.org/r/20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com

---
Dmitry Baryshkov (2):
      Bluetooth: qca: fix ROM version reading on WCN3998 chips
      Bluetooth: qca: enable pwrseq support for WCN39xx devices

 drivers/bluetooth/btqca.c   |  2 ++
 drivers/bluetooth/hci_qca.c | 26 ++++++++++++++++++--------
 2 files changed, 20 insertions(+), 8 deletions(-)
---
base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
change-id: 20251229-wcn3990-pwrctl-cfa64f9d8167

Best regards,
-- 
With best wishes
Dmitry

