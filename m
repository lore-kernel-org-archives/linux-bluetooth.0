Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C2C303C8A
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771415408; cv=none; b=cTFVj7zZcPShhZhzINRM64kLqtUlAmnvfT7jmT4/QRfNOUVQ4Qx4wV9uIb89FbQsy0h0lCpbO7HKj2E9WijxkK+5IDGeElDpF+XeZoNI2pGXPzIws/yMyxSvY12cfbKjKVJV3ggVAIDYgNCsXW1E8LPRRX7jgYt7DIGjmOTkFlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771415408; c=relaxed/simple;
	bh=uTkG8SxfGXtGc9hF4EQnstCUvDWSkWDpXd7z4HESRew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iZ7B+LVbTeqlWRSy3avP/zZkhFF7oh5j/Ern8WlCKnR0Svq/ZG3YW3PEmF0wjj45EsThwufP1ss5dQt+B0Qm6HMxI9Hhmwa2GpN9kfBUodbeaAzrI7j/OC3bS4Arb+Rv20n9C64ut3vxpa5/DmBJHXFxUefHUdZ4gd+HXDAIskQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oP8LUnM8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QHF3ZP+l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oP8LUnM8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QHF3ZP+l"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HMOehT1029650
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 11:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=GZc29+Xgdrc0I46kmjFs+LB5LdhfkOU3l2G
	Io8AJDOE=; b=oP8LUnM8aAwmbcdVfPD2lpzIYURxJI9lrkg9UqsyMwOLjMmpRAL
	7EgkrJyI830Kdqashn1A7ZRZN/nc5KHDHJiOWqozSjAUGwxztAuFJmi2bA/xwjs7
	rvhwKcqkt+Fd/cSXgVWGDC/dlTOmMwLCZBQNXVR9tBNcsG/Iptzz6FM9RJKQsaWz
	2wbjSnCrz5vzl6YICsvj93q0WKH2/Z99DEwlN/RrEXJdVEZn+S1EONMsze+KEATq
	KGYvYJoY6c31nKIL2fiS/Y8xbQ5awHfDUC8EhskKdLX092fDRiU+LXbeobp9v7GC
	7segonXsR80ws1Od2KGjA5I2vRPWCSed2dw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cd13rsqhj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 11:50:06 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c6e18b8fe1eso574270a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 03:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771415405; x=1772020205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GZc29+Xgdrc0I46kmjFs+LB5LdhfkOU3l2GIo8AJDOE=;
        b=QHF3ZP+l5ACN8eWiTwZ+HztyIduLIQRxU3E7JR2uL6RVPcHK/EQ+eT2qX1E4URe1ZR
         +XA4WwPX0QduocXlO+ZlwE0huUXe2fzN0QfdwYa691zUWuQM6id2p29TdmpGimHIu1gm
         W7CmIi4l2bk5DZNUUjcuGL8RUyI4y7e5BmzE118svN45ccxflTTw9HP2rkITvkAUsZfn
         sf3x/aXmxiwvokTfPPJRJ7MXB1qgoNqiRHqVSELnW8vMNhRsLOavbZOtHyQ7D3H8uVZP
         BayiTHRXX83D6cgmIPmGq09H2mILNpeJ/sk9PTts6f48I3TgaaNj2ySaWIxHIkNceOQQ
         68dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771415405; x=1772020205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZc29+Xgdrc0I46kmjFs+LB5LdhfkOU3l2GIo8AJDOE=;
        b=wLIVMXzXwqX4UZUZ+sKhX9KAfZIRRP37KjnqbT8pqqLQa4O64yKksVvmqa6u74sGaN
         2icVAuFDkukKNc8p3/pZo0hOueFPVGxRKO/GUEK4GiZG+8arAgPxjAgzeLgCrLbLcnbS
         q8mxIgYa1cjtlawgYdV2w4sQdaW8JaZj+gGxHDhi94hIbpbObXDtQkN3ch27iM0VdvkU
         IbrN5lKALKVkeR+mQJ1WLRYz0tsEht1xd05EnwHvHGdMAOr1w25jL0zm9Eben1en7hAr
         im4JOhR7KgL/ne/XcoAFmZQbdrwKPq7z/aRHGvFI6DaBN8HGijKhWAUcCNglPCmnBnJp
         2HLg==
X-Forwarded-Encrypted: i=1; AJvYcCX05lyu7G9msteVV5B6g44LTNrFgRSWGXlUykQUQKR8T2u/ncspp2Ihk30bwMjNKysYLbf/PuExFsYdJEEPa4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDj23P7LstlPZeahwLyC41FKpvp9GcUHI8KNczVBztxsYs6v4x
	ZkyKwtFNQpDiloaKgv7ybu/2zbzaqUdTqT+snm5DNN+nrQpCtFncNG9WZm+jtUvxXrfvY6mAxfr
	hTPSDaS1Vyl2raU033CVgzefcSbRMz1KXfPPFxVpQu8VFmZhZgO1St7m4Kgayp17nZakU2aM=
X-Gm-Gg: AZuq6aLwPB8fd24rQ2TX+TrUV8vk/psPSSUmlCrsd/OgnU3TMyDgF/iw1uJ1zkxNnRe
	3Lw19FkiaBRxs6UkH3BF7KCX5nsAEpq2TRNaiNFUAt324Yb88tBvCAFPxa/1ZVr5ewmxdv6pWfQ
	3xg4WqpKqvHD7hqAOO5pcaBaENmqsdqkuh5S1oBxAVAynM0EHue9olGcnOeULbk4MuTIHzXtMSr
	AbAelQ6YFme3eu8QBTRv5HO0iihSyNmoZAg8aiLbhZJctwW9W1lmPih0VVEOrBqL8g3VbLCy5gj
	fyx6rYhhhSRQLEqhqWLGUV1ERv06rEgeF/efxtMRQUIUykdlbWXtJS6MLXJr6L1+o9xzlEDoU6y
	ClEpfyPumv60R4f+ZXXDnTj0EOuX4B7Eo3u5Tkde2bU27HyHr7OA=
X-Received: by 2002:a05:6300:4086:b0:376:5199:2708 with SMTP id adf61e73a8af0-394fb1f2285mr1782790637.1.1771415405150;
        Wed, 18 Feb 2026 03:50:05 -0800 (PST)
X-Received: by 2002:a05:6300:4086:b0:376:5199:2708 with SMTP id adf61e73a8af0-394fb1f2285mr1782762637.1.1771415404701;
        Wed, 18 Feb 2026 03:50:04 -0800 (PST)
Received: from hu-vivesahu-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e52fd08fdsm12459222a12.6.2026.02.18.03.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 03:50:04 -0800 (PST)
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        janaki.thota@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vivek Sahu <vivek.sahu@oss.qualcomm.com>
Subject: [PATCH v5 0/2] Cover letter QCC2072 enablement
Date: Wed, 18 Feb 2026 17:19:53 +0530
Message-Id: <20260218114955.3970974-1-vivek.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MqaXaUbnAG6QZ3Zxsijxm5XAMq3mhFqA
X-Proofpoint-ORIG-GUID: MqaXaUbnAG6QZ3Zxsijxm5XAMq3mhFqA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDEwMyBTYWx0ZWRfXzFhfaAhqqIMe
 fSSGjpUSrW1jTaUS6xfgd4zNV8AQBTxIbS4YbpdJyyF11/wai7mbLmosf/ENXNIHa7Cgs5K1ppn
 6MWoSw7fmBo33gartVrJ9PLKXHDoL7cXfhK+UeuM8RwnorDCJ42TKJb26x81nSlcyUvruzQfDoq
 CphraaBQqM/svPyQ3ImPtMySkRuu1+KDTF5V3gu8um2pSmC7pKpPxet891DEGP5XDvYEznS4U2Y
 C1f9qsJTr5gknXNsKrqEDfx1mUJdFqdlOiv06F0JTRkrcwuGEhosj3kgKCezwvwOxnKWVvmhX49
 2smWoOJLdiLBcY91+jh7KZje+j2G8/o5CMGTbOg4+8I/xdy7IlBxVNUZ70vYNPEnvChb4K0KaXH
 DM2V6H4dEHCvO2U0Kr42JlIQQwNzdnsp5mNckL500nAMn0LvkHzEzbfhl33zXKc+VJ99Ucq37Nb
 FTizsXYl1ir9MgbKgQQ==
X-Authority-Analysis: v=2.4 cv=Q8rfIo2a c=1 sm=1 tr=0 ts=6995a76e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=3MU52FBw86mTojjfF-wA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180103

The history of the patch set as follows.
v1: First commit to add support of QCC2072 chipset
v2: resolving review comments to sort the chipset in the switch case
    and other files whenever possible. "qca_btsoc_type" enum in
    drivers/bluetooth/btqca.h contains all the soc type which need to be
    enabled for BT enablement on the target device. There are few places
    where logic of framing packets transferring between SoC  and Host
    depends on the which generation of the chip it is, refer api
    "qca_read_soc_version". So It is not sorted in btqca.h file.
v3: indentation fix and "qcom,wcn3950-bt" is deleted by mistake.
v4: made a separate change for sorting chip name. added new schema
    for qcc2072 dt-bindings
v5: correct dt-bindings commit msg and place QCC2072 to the correct
    order of chip id in the enum.

Vivek Sahu (2):
  dt-bindings: bluetooth: qcom,qcc2072-bt: add bindings for QCC2072
  Bluetooth: qca: add QCC2072 support

 .../net/bluetooth/qcom,qcc2072-bt.yaml        | 47 +++++++++++++++++++
 drivers/bluetooth/btqca.c                     |  8 ++++
 drivers/bluetooth/btqca.h                     |  1 +
 drivers/bluetooth/hci_qca.c                   | 18 +++++++
 4 files changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml

-- 
2.34.1

