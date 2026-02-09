Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E09933ADB7
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770624390; cv=none; b=Ciu9sNjodS82agz04Ls/A/qgUYYlatMrfKcmlpj3GdQ6LADQrugfzyy4+kha8ce8D6X7NUm24TMmy8tFvHk2qKrIXdThB4TpBBTFz5ZSlOFTeAw/KOc3fG+HY24BmeK176ybf9FrzyqpkHfsCjI6Q7JBaltNbKwRjgBwFkFnD8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770624390; c=relaxed/simple;
	bh=NwZkZd3x0F6Rk9OACyZ+Tb3Qv9NN+TnPmiBEq0ZzE30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jB4DrVEiLNS9gWCbhGzStttgXG8Ejb+aaFkMBSs6ph0++cRTKZv/iosOZGD00Cgt8yX4R4I6KuXp7AR7+sDQhve7smrjn1Drw4xYTp52vi3bHrk4VeqY90iFFPgSW5LS8XzOywSDOFryiDPi/Cv1oqsTAOV5yjP0TwinLwvDD3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AjBEhDw8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=btGUeLOW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AjBEhDw8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="btGUeLOW"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6194T3Tm2599746
	for <linux-bluetooth@vger.kernel.org>; Mon, 9 Feb 2026 08:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sNI3lzVkEBQ
	S+BoxTw7c+JVyJ4uoevI1lC1p3lobflc=; b=AjBEhDw8gkFmKF5EhDr6IDBn1xq
	+sODPuFOkHoRV5yjuwnQvzrJ78yPDM5jo991zIJqBIwTffCQOhqe5AuEa85ujajm
	nQ5/W6LKNxpmydFWgSvHZOyUNg38fZdDJSPCIs6qMZd6UEbYKXEC0bjEIqISzJLz
	ru3oFC5joVClOlHYhXox8X7kW4wc6GGuM7uktHWzs0alzIcj1XoWRpMTPcSl6TSk
	diGhBTSCCj/ad1undKGO0cR5OpKD7h2HLWVOf7bTipDpQyy1+2F21Yh5askXEMZx
	sewrzs4H3wUs1Z0X7U1tFAq+wtrRnCB85qCTxuryalMIxbzwePHZSRl6LCg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c78kh0nqd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 09 Feb 2026 08:06:29 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82436a49592so2235932b3a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Feb 2026 00:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770624388; x=1771229188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNI3lzVkEBQS+BoxTw7c+JVyJ4uoevI1lC1p3lobflc=;
        b=btGUeLOWItOUFMhEDsnw7CNKRBHU74rEcaiDkTYlUlmiICt2pVJLaMnowgqGlSVFhJ
         Ll2J/sacyuXgY5JB839WyXXcCKOKj3H9tImUK6juHF595+aFxbYYOgM4LXksWwx9RTgd
         B8EL2B2pSr8KjgMDrqT/CmdoOsOJbd/f103Ks3lK/Vi/3hkFv7F1RAdjnEEfDUtHrVde
         o4SAXsQviG9GOZAfsxx0gqtej6Sho0K81xvtABeLauEEiLAv7dS5XQ9IA4oaKaZ4o54q
         5rFJNxuCZ4ZpbV+I9Xc2Fq6JpHOCuZjMmA8U9GJIzA7Y4nm6gc6l7by5a5cNUSpPfEPz
         k3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770624388; x=1771229188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sNI3lzVkEBQS+BoxTw7c+JVyJ4uoevI1lC1p3lobflc=;
        b=GPuzi3r0s35xxsSUS2xhwNLlYhhB4/NIq0GIfp9xcwo6Gja4nPoc43hbHVMiw+6pcK
         +SwTTtT1AvSoliQMhO+/524LGzUW2/6mK+ASn6z54rX8lRgce1HEv25UrzpSqvn1qY55
         zB9HHLYcVGNQgc+ntGCqIe0rUMICoSYP9TyAb+1sVCpgQGpSQ7YBE7xkF2K2RearQORB
         HrwRYIssLgLA+gq0QWwUWBi9uSVrWpV+2eJqE2ncCt+qJH4y6ZkTPB7OvRakNxfB7O4j
         q0qiXZoLkp3LYRE8BfWD+u75lgEyjCGnSfL6UocomeW/9xJijQaTCNxk5qjskUxImmil
         PMsg==
X-Forwarded-Encrypted: i=1; AJvYcCUy1YELGDrJ+Zc+M5elHavBoN1K/8QVOv9Qs5DYAS1RUVg4kvg6G7e6a4MISfCQsDQD7lAZ3Tqw1GwgZfbRL8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgazZkRjccaiTQgKdu/ImVQ2qANufwYR5FCdqONMnG8pKew/Oq
	ua50NCm/8PhtR5fkBg8nEnEvJttVQxRLWReyqPOQIAE/KA50wwSoyTxP+cjJiVUKWCslgWCqOvn
	pMebB3fahzUZiti9QXYfZAiVEbeZ90tzAdwYfTh67PMJJK3WkTESTkkWA3WudxO6Z46iCOx8=
X-Gm-Gg: AZuq6aKsO/e0+cLiwzWKmjYzKabn7VwBarGyeBYJe92JpdLe96PvvpY6ke+zCprgugC
	mWRNdBWnh8mK1VxG0oNamHNAQMa5gn9UJu31l5O7HBRYyO3LxnG1AJY18r8Ya0P+Gp/vPlqQiMi
	GT785cZd5UoThvQvBfD/xM0dQ+bQpIe5cVRb0tE4yBSlJhw0rnWL7jTmvyg59IvGtE3sh86FbVh
	mJL4zOfLZ3A+7JyFkouNUjzJj1+OAX/zOXBVq3sGL1Uepwt3T0pLkkeZiW1/1Qgez9TsdQrpM01
	t1z2P4sl8qhJNFJtoAKryUUOZH5tyhiQom8p5rBIpY4Czj4L3kL/sGQqm6L/3rtiqrc3zPzQmMn
	cS5BNLKrenhu8ec69mwaGYzrpxLz1YUb74PaBVZA=
X-Received: by 2002:a05:6a20:d524:b0:2bf:183c:ac86 with SMTP id adf61e73a8af0-393ad00062amr9948233637.25.1770624387748;
        Mon, 09 Feb 2026 00:06:27 -0800 (PST)
X-Received: by 2002:a05:6a20:d524:b0:2bf:183c:ac86 with SMTP id adf61e73a8af0-393ad00062amr9948193637.25.1770624387136;
        Mon, 09 Feb 2026 00:06:27 -0800 (PST)
Received: from hu-vivesahu-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb4fb713sm9202221a12.3.2026.02.09.00.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 00:06:26 -0800 (PST)
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vivek Sahu <vivek.sahu@oss.qualcomm.com>
Subject: [PATCH v3 1/2] dt-bindings: net: bluetooth: qualcomm: add bindings for QCC2072
Date: Mon,  9 Feb 2026 13:36:12 +0530
Message-Id: <20260209080613.217578-2-vivek.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209080613.217578-1-vivek.sahu@oss.qualcomm.com>
References: <20260209080613.217578-1-vivek.sahu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Nt7cssdJ c=1 sm=1 tr=0 ts=69899585 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=VxM-c8O0AL3WG2ldIhIA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA2NSBTYWx0ZWRfX4jtlDt2Udh/q
 0P3/UhL9FJPBcbgj9bjVZR/A3luUqcwdkyYyAyFLhL7zoj7adQivxSEx/4gEiJRkza8495fgRdi
 Wq/QUX/t3jtGzY0bTBiisBLV79nb1ZTIh6/2Ip/0oRH6GCIWKYu8j+KBgBFSZQR65lqYOuW2fq5
 qiyUOwiK0ML0WIdmxQYxrbV7JWl54voleMHwE132N3X01m+VCOoYEZflbeYpxdib60nDu/iKYgD
 bZU3js+0/QNjXnMGNVQC42LwmI36qQ9eiIf/n87WO54lzxWDDnsJNkmW7btnxfs509PfhqM8o5s
 a1ZNh27ulOqwnrkIqalwcfY9hliJuXsNL7o6xyM+NNqGt6AtrZ2c14LsD011OXrBOpQJN5DoeLL
 2xaIEOlROgel7/y/ObNT2UmMIaXLWk98d6enQrtIR9ttJ8Xz+y/0ciav2bf/ftSFIA48XJ3X4su
 UIgTolWDdV5pQh5zDEQ==
X-Proofpoint-GUID: bxfoT_cZ4z438PqdSTc2WIP2sCPWv4X6
X-Proofpoint-ORIG-GUID: bxfoT_cZ4z438PqdSTc2WIP2sCPWv4X6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602090065

QCC2072 is a WiFi/BT connectivity chip.
It requires different firmware, so document it as a new compat string.

Correct the sorting of other chipsets for better readability.

Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
---
 .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml  | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 6353a336f382..85cf65efca92 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -18,13 +18,14 @@ properties:
     enum:
       - qcom,qca2066-bt
       - qcom,qca6174-bt
+      - qcom,qca6390-bt
       - qcom,qca9377-bt
+      - qcom,qcc2072-bt
       - qcom,wcn3950-bt
       - qcom,wcn3988-bt
       - qcom,wcn3990-bt
       - qcom,wcn3991-bt
       - qcom,wcn3998-bt
-      - qcom,qca6390-bt
       - qcom,wcn6750-bt
       - qcom,wcn6855-bt
       - qcom,wcn7850-bt
-- 
2.34.1

