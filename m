Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97393446826
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427251; cv=none; b=KY5ppISZlaHp3TC8xTHq7Jr/dyixIyOIy4cz5m89Xf+K4wacboRvb6AogYpOq6FRmTpjS0wp3zelNk4fsEjZ95eWSjabBj5nxaB24IrVr2XjAFpu3OoYChyWAnpiwzZatyaN4Ha2avnzKtnZ7dOxiU7TqP6iAG6q5tRA/tXHbbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427251; c=relaxed/simple;
	bh=rFLR77CJJYP1sKLFQ6gl8hLWfcBFJvASp2MjESWcdt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t6/khimqiWIbZg5DfkvB1Xzbk3EHv1+aAZal1TuNqrKilWvYYGYnQKte89cpHcZkOVw6q/xgErrd3Zg5P2qtBdW0cgfcoyx8vlOAvyzFLsvmBQ4MapBruTJfi5apNACa6xuQ8GTO0Ogwi8/pgylyCWMcIHjnbMyAK6r2qEX/aFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dv93W4+k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y0GfYfD6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dv93W4+k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y0GfYfD6"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQtYf1371737
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 16:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Pq53qNpO4Cl13XpVwNXOs8IgmR52etnko+i3TUslYQ=; b=dv93W4+kq74ezcsn
	PoGGxoSG5/baz/ImVuFoETwH6zagLZ5tCc+ntmZUwNhu9mrDn5l/aWdX+3RqR09k
	+qqDCr4MUFHFy2rPZp8wG4vW3hoQDx59OoBFCBpp69kYIrO8bHxv/0uRi1U5GXdv
	Ugw5LFDYcP/hHdAAxrIGONk2mCitPtV6mJXd0G5bL21EoMh6yhU+rkt+32uAL3GO
	Dx7bQgk3HLRrtq7QxCpVI8QG6nyEWp9k4X+OwJ5slZ3KmwCUAiAv1GCKNM0WAkR7
	cis9ttgsPcKrpB3KBWV4g004u3i7whUdRwaCue7TVmdnnOT+NKRa3xMNbpUtrbcO
	bY0fdg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr6yfrykf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 16:00:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5174a236220so23309881cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 09:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427248; x=1786032048; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Pq53qNpO4Cl13XpVwNXOs8IgmR52etnko+i3TUslYQ=;
        b=Y0GfYfD6sZxQ/VKgOBQTnmj/1wel97wvNU9Ok4b2795aL/4JAEsCq1DkCxkEO3mbR3
         J4ZzVTT8F8EMJMy8Soy6R8K00ks31nt+kEl0CEjAnH2M3qHGKBzpcUUsX3cfA635Z3yi
         dCHuL5A3XtxFyTc7XA0+H1JnRcR85SQyI4cSDs9+6z+pvvBgkWbnokBE/dgKCtgy4ACw
         UvvRWL/bGASSZLpqalnh2y6rjV7f6rh99tjSQZJBRrctwHYzPF0lmFza27nzE7tTrOc5
         nWXGOUzC1K63iFSS9Qgk57XA1uRDcm9GIZOU3ztLPCaHPXSn8CPR/46Tb+krZQ0GcFWp
         x2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427248; x=1786032048;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Pq53qNpO4Cl13XpVwNXOs8IgmR52etnko+i3TUslYQ=;
        b=OJwzudpwnRKJMaqes98FXl/XqK05NllPalrrb4/pZyn+o09dmyUJEzsvt/GeJF5I+k
         +XtdEmJMFz01hfh7MaEEZDqwgpcdPUdIlB7q9Fh2dMWXYcjXEKVj3s75Ua9jPbD1lgTn
         jmWgSgWXCnZXuU9VT8vt15WHnPi8GQ1xRzIf0/P8yfk5LdwuBFER3VL5XTHnHYpGMYv1
         42GtvxIGPyiAedAD0qESzQAnnekk5jEXOwjiAGJ2nAtfXmJ8rySKAI0THaScNfoqycJM
         wznNAb3HMRlWvbRjEo3Kzji3OlHQvbobUQoUCL3zfOHOpTD5E/GfYVOX+n38spK/PsLP
         qzbw==
X-Forwarded-Encrypted: i=1; AHgh+RpLn1pyi4eOXFFCCMGUaOfeHd06Dnb5cAq0qQ1tUucTITs4SNP0Ng3MRhrWrM3CnGJ7M5MIFU2X9e5FI6v7ex0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ZSOhj4+PjhgqMB6+cx+BEyHNxXb6/F7RMztra6IV1dn5bLPs
	d6zFFpsOWGYBzWs09GDTY90CWH/9mveFmEDxyKN7foEtHGevY6jR8k23j4cKMc8LPIPA6wLdSNL
	wLsxVtNc04iHlfPSRcpeuaCWlt1ulwdA4FO8rA/Na705IGcMdEBndZ9cWgcPTS3coyJSysaE=
X-Gm-Gg: AR+sD121ASDpmZ5i7SIWsSoUaPJvHi+au0GvcuAiU6hPrfkh6osYEmjygNGfCHVKRDN
	hhGnrxH9tVQCHpFureLY3XwO2Rs+YndTt1EY5fZnf0ajw0LD8dfQ/zMwQqyWQiZ4kyZL7oXDj2L
	QtB1+W2FJR4jOWnX86JMxgQBl6JL1NVBtwN9JrQD8eBBEojhoQ3vKUoKeddeMzzxUXTPjHf25sr
	Dv34kCUd6gsS9j3m74vgK5lEefFe1PGpqffYFZLVIi3KYuNC0aC+04oz0ABEPaRz3yJkuQNN/VA
	yPc30JEZW7VCvYCfzpc7sHROAQvrq5xxSysF9+6y642+Uu5zi0DQmuPOImRaeE32z81BFjDHdi1
	PdqMH/eetWGL3FsUXTGfzsi9nhK2BKP8S18bWaFrMAX8kYmCvg0PMDiJzJ1ugqRGunGtT/6GkLK
	T6jOr+6cP34NUBkVJm6AaVzjI5ifgwFl6HHjpiPNmV5kAoawt0UhnD
X-Received: by 2002:a05:622a:511:b0:527:6d4a:192d with SMTP id d75a77b69052e-52b42cba100mr8220361cf.68.1785427246012;
        Thu, 30 Jul 2026 09:00:46 -0700 (PDT)
X-Received: by 2002:a05:622a:511:b0:527:6d4a:192d with SMTP id d75a77b69052e-52b42cba100mr8218291cf.68.1785427244656;
        Thu, 30 Jul 2026 09:00:44 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bb6deesm85168066b.53.2026.07.30.09.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:00:43 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:00:32 +0200
Subject: [PATCH v9 02/10] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-block-as-nvmem-v9-2-f72935817dbf@oss.qualcomm.com>
References: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
In-Reply-To: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
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
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX3lzjv61KJhUS
 B55m/QWCCtGeoNExNut5+hGHNBKyrn7HnDp0jxnL8gKXm+MS97uzdNUyBV0Vatz9Bj291mPVsbL
 vho9J3Z08+cz7boMyvKHfMODIlMF+3MjxDKSp4CNRAH3qjpgsROohZjb19hgOAhbyhFWtALpJzQ
 rvVXESoAtO6vzUqbvP8XnIrnYqJ5cWUlNy+zpOv8rr9/XDE+tSbJT5Nx4pKea6zWJvgjUlsHvJW
 kSTF6O7Zkac8FNkPcQouUZjtyPgmjtAywxweleVR6+4V2Dfi0a8+g//AdkIQqJXsHg6T9EFNCmi
 mKz/y4pGMlwUCo4FWTVuZYMjU7hucr9BNwxiu0xAE14RTZsgE2rWJPvFHGzPhhhFkX29850VprG
 fJlruRYFt00N2gnFMcXEq6Fc4LcovBpARvzx7etIG7cRKnwrNn1lzF7OSbeFOQ6Jf/Y9m10M4rV
 o0ALuNyz/dWs0ud9WfQ==
X-Proofpoint-GUID: fTRp7ToN6jOYW8NrzwpWxGc-ynR1zdXR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfXx+jZ0hUUatWB
 eiAsb4brzqNS+ckHcalhCfCKx78u5I/IGiaidQ6R55z3hBPB0Y2I5qqBH4G10Xl07FDQWYE4D5o
 LmsRKkOIn4wFO9kjvlRlWf6Eos3aXw4=
X-Authority-Analysis: v=2.4 cv=Tv3WQjXh c=1 sm=1 tr=0 ts=6a6b7530 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=Xy7nGJaRzBGhkMsTZAMA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: fTRp7ToN6jOYW8NrzwpWxGc-ynR1zdXR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300120

Document the NVMEM cells supported by the ath10k driver, the
mac-address, pre-calibration data, and calibration data.

Since such data may also originate from chipset OTP or be supplied
via other device tree structures. All of these cells are optional
and can be provided independently, in any combination.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index d4f4d72ee0d388f43437fc5a3047f90b464a5274..7f9d16cb7c14330e11ce7d567d585b5e47793bd8 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -92,6 +92,22 @@ properties:
 
   ieee80211-freq-limit: true
 
+  nvmem-cells:
+    minItems: 1
+    maxItems: 3
+    description:
+      References to nvmem cells for MAC address and/or calibration data.
+      Supported cell names are mac-address, calibration, and pre-calibration.
+
+  nvmem-cell-names:
+    minItems: 1
+    maxItems: 3
+    items:
+      enum:
+        - mac-address
+        - calibration
+        - pre-calibration
+
   qcom,calibration-data:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:

-- 
2.34.1

