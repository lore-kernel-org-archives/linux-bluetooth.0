Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AC9450918
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167498; cv=none; b=E66UII20v5ENNzrna+7DL2uJCr4oCatmFK+gYfh1zB7jCKAKSkdkEkYiris5DU4d1D+6m5V1NIaOhhgb3zquUvvSOtwJLC6jrn5EHYaan7w06VsHhCSihN7vixfcY9a3X83vPVoSlbhOcXGh+NpTi8fpM8yluazeRaiIcyPdZUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167498; c=relaxed/simple;
	bh=RjAXLDtyeqYajrszhA7+nXfORAO+2o+t2+Lsa/IoOi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E3gRXcESnm7PLQT5dMmTM5lGABOCnlQv76zeepjNB05/BHrk4/b9K06s699sFztGu8TpeAeOkxsGGfkJdEQqJhW2/g/ZW6ifm5i/MSGFNE2uo+fukIPsEVwmA0+KfeFdkryFJce6MnKuCjh32CqW1DF13/m5YguRiTK7zVC9qLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pngJchIU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jxI+G6b3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pngJchIU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jxI+G6b3"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647BUEm33925548
	for <linux-bluetooth@vger.kernel.org>; Thu, 7 May 2026 15:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q7Clh3n6Vth4q3WERt/c3dsM43tyAEU24nXfs697yQY=; b=pngJchIUuTR6hnjQ
	lUECzDHVo3pz1dlhpiqmaq1DuAFQv80gbFnsc430vvYvth4mo1bwdyR6UWKw5WdL
	WOpcq2EHSqx0x7SuRWqWe2LCyY625A/6sKNH2CPBz1+ERlw6lSn9VmVhjg3m2AjE
	9xjqaSAc6WqXXEOq/Srh54PIvF9/IBE1T0VyqUIqyRFa90B/3Dgo/n+591Morvba
	unefJ2L0hLpbQtFvm9AZTpw+nb43cU0FWeITrCo5GCw5BvFhhlt8ia+b3JuFJtgM
	lcihyLA5QdlvrdltBs6JtiQmmkeQ7kGuSsh/wQ29S1Y3j4W5t0tX7JFr9FIvJpJx
	E+BCeQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0c88bs3a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2026 15:24:53 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-56fab6d9242so2266893e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2026 08:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778167493; x=1778772293; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7Clh3n6Vth4q3WERt/c3dsM43tyAEU24nXfs697yQY=;
        b=jxI+G6b3mTV3gazoiC4aUSTNbP5wqPMTene2mNpHXaXsW7p1Onp1Cp3VYHxEi1ACdj
         NGv6mZSC2cl5w5ZkYaK0AFfSCz7XzDMNjVk2soWHW58RUjNSwPaSofUssRXD7uUc7oIZ
         5Ww61+6zHtUUvujAIqaCTRHRtvyY0Mmw6BKQM31G6jgDY3j7jcaOgfnhRD9MRi2LDDeN
         6we13Oe2MnNANU2vhdnpgfbs/keHR9uTU8W2gxxLgDa/G+Nh4YGn8e3U05OyID3+ycJ4
         mIqAjVk52B85l6VQmIuxOo1jlKVt8PV7oTAZflvmlMBOjlki5XwhZrkqHWjcDDU0QDP7
         FXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778167493; x=1778772293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q7Clh3n6Vth4q3WERt/c3dsM43tyAEU24nXfs697yQY=;
        b=aWgynlSqYQ6KxI+RGyQfXfuaFmQ4pagAMfHzPEMFpBh8v+hRl0VfeJuZDSHKvuIQoI
         QW0hecx44prtiCorL88Afvs+qX4YIVyifRN45QM7QleVSEBrbMG9487I5+NJlJ7vEpFq
         rDoR+F3xCaauKCaZyCXJcXV2MD//x5FVq1cAWGm7ggGda0WgrUnAE/EfFFGU/5D3ajc4
         aVSvqn203tS0hWf6PGcKj8FpeyjVSbLPglryntmQp7mzCc8kE1u6tFroCoZ8wmG0/MPb
         RQnwSk0wZ46ATXiSLBhRCVzltrNrCES1QaCmfvWLibKgloM5O6UcYzS1RHys7E8Z8o16
         FxOA==
X-Forwarded-Encrypted: i=1; AFNElJ+4uOpOZnWTZgQ3wbLrnjlRt4LD4DfGyulRcd9xi7g/eVY4xvhWRq6PBQpDYdOOSZrRAbRT1T9uWXn5VTGohB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUHqzMTogu3b0MMkXZEMK06AkJ4SX5vwtAoI/2fLV5PNV8gPQp
	wt675bEwpYJv9/+O8MLqimxa2yZq2DdmnYPlZeYMLRKx9ygCDtGAusjPqMZWVmByPJPlHXFrm+O
	kducsLaakLP9M0XIsddtK3+rJ6cBJCKGgOXL97tQlAsQCEkho9UlhSacDJNhqxwGuA1tVYcI=
X-Gm-Gg: AeBDievfg1heGsfRXt/8QTMbjpTm3DM2dFNAyDMw5svD5do+6alR5Iy4PVTecIzlwOE
	1mgaRKSHpujn8hN4Tg5YFRqGK0/inr41YiOTk58GB5/Tiu3jX2DDKK9L1QRb4AuUq5oabUZmHbB
	ueZJGp3DKOzJmG5Zs3Se4eBu7rRyGQROt03hA3qX1oQTPKNvQaUY6EcK89ESl8oP4BCwqWptJBU
	oYfwtd7FTlpS/5ZF/tsRR6Xc+Thz0svoJ9F6vT/YQru7qrNIUeW7ySjtBh/Tyc5B+7QRYiT3EDO
	QMBWDv2wIvIBletZy4BBWM1c3ux4CvklAoAtbuwoKye40/cLk++EhEwOHMMYf1Bi2L6wuxnuXHl
	2la7WN499hrK9M0RYjbdx/0RkYTFN0susqI9JMk5+XNZbpUUH7mSKkaKJmBXuXaA9/Mb+mk5PdW
	eP9sWz78ndGuhMHhHQ1CzG2GbV/0k=
X-Received: by 2002:a05:6122:da3:b0:56f:b0bd:2276 with SMTP id 71dfb90a1353d-575591f7b22mr5439010e0c.0.1778167492599;
        Thu, 07 May 2026 08:24:52 -0700 (PDT)
X-Received: by 2002:a05:6122:da3:b0:56f:b0bd:2276 with SMTP id 71dfb90a1353d-575591f7b22mr5438965e0c.0.1778167492169;
        Thu, 07 May 2026 08:24:52 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bca583dd7e4sm240966b.58.2026.05.07.08.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:24:51 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 07 May 2026 17:24:38 +0200
Subject: [PATCH v2 3/8] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-block-as-nvmem-v2-3-bf17edd5134e@oss.qualcomm.com>
References: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
In-Reply-To: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: uubFjt5TjjQZ9bUfCGifh9kDmHu7KUAp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NCBTYWx0ZWRfX0qFpBaveqrZm
 jg9ins0/mg8K68C3ChLm721m+oVn1LqdGZ+8a18HF7Hq/YNGZzk0GaUhr11Brtiz4ttjFOm8VS7
 piz0Fray74QbjzGKvtlTphpKs23kx7dl54qHQDZZ/H0AIR6VPNQ4utJMTyHlXi/OsW8PNuhGdq3
 ZhKYQvqHNLxJoovGdv+ZCEo9cbPtr+kMGzbKKLBGH97HYaZJA5YlDz9QlecnX4R3fFMf2y1AIYu
 zMJpP+0jazHKUqPxgpGaFASOZ34Yi5/sXpqhGDKT0KSBZ8npbUIZPlAuz6nWLPmgHu/P2ZYMVuf
 4aHitnuVnafjgeB78eii3e6pwvdHGlnekceXkhBZ709zmBru+NVCutq94sWv89Jx3fPq8aklQ3s
 ++8gw7YK4R9eiW2fEv6E1KEzkswvUIYbWt7ovMlBSSpg6DrypP0GIRZc4sAwfZ6a0O0nuBRBiEO
 nFbN5nhCvG5CkgEP1NQ==
X-Proofpoint-GUID: uubFjt5TjjQZ9bUfCGifh9kDmHu7KUAp
X-Authority-Analysis: v=2.4 cv=X8Zi7mTe c=1 sm=1 tr=0 ts=69fcaec5 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070154

Add support for an NVMEM cell provider for "local-bd-address",
allowing the Bluetooth stack to retrieve controller's BD address
from non-volatile storage such as an EEPROM or an eMMC partition.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
index c8e9c55c1afb4c8e05ba2dae41ce2db4194b4a0f..7cb28f30c9af032082f23311f2fc89a32f266f17 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
@@ -22,4 +22,13 @@ properties:
     description:
       boot firmware is incorrectly passing the address in big-endian order
 
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Nvmem data cell that contains a 6 byte BD address with the most
+      significant byte first (big-endian).
+
+  nvmem-cell-names:
+    const: local-bd-address
+
 additionalProperties: true

-- 
2.34.1

