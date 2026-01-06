Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E6A314D15
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661301; cv=none; b=KPvWSE40bvspG7bwLxM3ldkZsYP1p3+gouMXvDixfz5qV8GSSngwWG2IvxzKnWEzIqVNfW1pqURksOvvyNF/Pfq1x23X38nRFz8BfMxFsY66raem1xGo4PSuLaJyOGHv3EJgLavJ5PqeQpxI+ukrNbnoxwznK9AsKlM2os61Jzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661301; c=relaxed/simple;
	bh=Sxwe6pBBzgKc/Rbx3hGlBLXglP8Dn+Y8xXV50hDaYm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+5gbtnREL2dvSGmI8rs8qhFmZD2FgJeag2d5bAAVW3FW+7lieFAm2/vj20D8wHjKXySmu9Qt6EBrMIDjPwyFSeOf6lQXc95TNsTDFuuP7pdzWOpu9xmemfdoJtP48BpIi6fmd41WH5q3iMs7Kw6+bYlnKrezP0lpf4kYecr21s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aMl9wn13; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=brQWE3/o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aMl9wn13";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="brQWE3/o"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060o9qq2971699
	for <linux-bluetooth@vger.kernel.org>; Tue, 6 Jan 2026 01:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qIHZTxnOdazQFGAJQSxqsY8ozTjZjXZSimhBE4+TrtU=; b=aMl9wn13r2pa8iQc
	y5aGy7bCAivl74SpmiNNqY1QPMmnGAr/jIZztOwzuVz2ne1Foxd0c1Vm4a2qlWtN
	VjAtWDfj0yitBmaOwJBEc3u9vDK8uCaKoTCDQ3T+2pUMdzphj2tni+F2xmQf7ycM
	lYCoH76UOSv3y50Ty9kIVEMRcQsv4CiZzbwrQ0q8dZ7mY6ITEmM523AqOoDG8y/J
	6KcUIzgxvpSBdjEvcH/C4kk90HZXjVG8av5Xzla93Oe37X0FH9AFtlyVieXFwBR9
	WJlqmhB7R2/XaoSxeXrj5lsIukCnvEmROEiUmYcx3R1xuJJTIHEk9R+eqEFIdB9y
	NZ1zyQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bggsvs7qj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 01:01:36 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5e54cd034ceso909707137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 17:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661296; x=1768266096; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIHZTxnOdazQFGAJQSxqsY8ozTjZjXZSimhBE4+TrtU=;
        b=brQWE3/orSr7mQiryV26FRyiOrN5YXEFa+vwHhHgSHirpy+It3gv7vZPSJPo1XUzdy
         kh6sTVOdFO4m9cWsXy2txYOF59lXydX/KTPdCQsrHoN8gkcUQX+Vm3IWUxAH4Np+KJq4
         ++P+0M41dhSMJqv20LVuGjv+kATiOU9FFg3pjraoug0lx09qCq3iYxcCjYG1TWvFhdCr
         pctV9hkRj8tzJhDHrnYxXZFaeVB9b0sDMKxZTuKpVTe2fvgH/Mj4vju9GXjJssN2r7hW
         sVME0+FDBbZnAJizlZP+VOeyr3VqcjLjHwDEkw55Tav71QgwAgJllo7UmjPRhvJ4qz1q
         RdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661296; x=1768266096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qIHZTxnOdazQFGAJQSxqsY8ozTjZjXZSimhBE4+TrtU=;
        b=ZkRGCDyRjO7CVnlXVa4xFVD00pxWSi21WGLjAhCoFH/4MaX3nfTAfcCdJgkwTlvGlJ
         p+3XlGDDKfpCZ+h4qXRuEhAuX1Ufg34CAPbkm6ZHrtP0iiu5TegOyYuYOt5h5lcBbAro
         F+e3Bz3wKFYNCXiJewBB8REJ/NiGcjexNKh5tdT8bijmiZuAtW53mp3hHi2Y5s17DLA5
         ahgVsErUEhYxC+jthurLs5yNWW29XoegwUYPCBFDfk5D8MmVx660hrbIteUmbMOO6svX
         UV81dMBhDKMxR3Q/H3YqBd85rDjamHuCv2oCCLEQl1SQYQb161R2S79HN2hcPqcpf+Kt
         pWew==
X-Forwarded-Encrypted: i=1; AJvYcCVJDdFE1tHFG27KF5SDEjSFpuY295bsfkx5AooCoHxTJGe1/plRR4Td7nouTgF6AaCLlYO5zndp3IV2eW2c+4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN4VFJFIPPQiaPGh69vgEEZ1Ns1nySme4twoiigA5DEID0/WTu
	wkgzFRFFAEZgoNCotTdxIGtLvnViX3VAj1PEk+11WL8i3QEXe3ep+nHDpe5e1Cg+q51y29ORZ3X
	EGLduvxan15ltTq7WOaBA6BEppvRee6EyMSWPcbSeh4VXIkNGjK/XDcmkcjD0fdQtMYrX4iE=
X-Gm-Gg: AY/fxX7fN/1Qu0pJun45BYiKZ6H1DVaFnq/ZpjWj4cuLe6kbFNup+OneHtB5m+7u0IJ
	r2X0Yn+qno1ZrV4Y6KmelsRBEoMUlX+LpQL8GZ2xvjmFhfL7ce8Lh6zfGsWkmtOky81Cxzr0ZcK
	vxm5p3jaNS8L9SMs26FgDUn6T/dYn1pm1TCKWexhZbPbSwY2SYmalREbbF4MH1L30pn+B8gBxtb
	28r6rNtocD1TUOGaI0Er5vfQFyFIqASPb1N5zjw1XBSx17pL2TkRrRlpJ720S4AT3w/Px8WOmiF
	6EBJRK6GTvoY03o0vZEpxNzzjHVbtIOvqmZdHp+gYPwmwKyIPmc0xfCnGqEt+XSRD8uR5p9b1Xn
	2xzkng89PmDHyCDnvRP5euw8zzn1w5x1jwo5g+TIuUwAPBLPs79U5s+kjGY3Cz/SfGPY8myy3Uo
	L8cNmKDgQShqWJySbczUUIfj4=
X-Received: by 2002:a05:6102:370e:b0:5db:cc69:7399 with SMTP id ada2fe7eead31-5ec74329c39mr406511137.5.1767661294621;
        Mon, 05 Jan 2026 17:01:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGebirOgsDiT7jy5CL+h38CH91id84REIWuMIjih8Il5xh+FCp6mTy2jPQ3VA807d2Ub/nd3w==
X-Received: by 2002:a05:6102:370e:b0:5db:cc69:7399 with SMTP id ada2fe7eead31-5ec74329c39mr406501137.5.1767661294163;
        Mon, 05 Jan 2026 17:01:34 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:32 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 03:01:17 +0200
Subject: [PATCH v2 07/14] arm64: dts: qcom: sdm845-db845c: drop CS from
 SPIO0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wcn3990-pwrctl-v2-7-0386204328be@oss.qualcomm.com>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
In-Reply-To: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Sxwe6pBBzgKc/Rbx3hGlBLXglP8Dn+Y8xXV50hDaYm4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXF7ZlqUdRROe+lrbb5qeAmQzNxwRhkFbuQafZ
 1LnRVCUW9SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVxe2QAKCRCLPIo+Aiko
 1VsbCACUB9ZxKyeCESIpnYkNLBvtnArQbybVrFIjFFgB6l3oeJuYSCmeGB8KtWBcWFX2p27bPvy
 l4Aze9U5+0VUf1taw5VP9+CAZWtu0J9j/xyuRRkykC8Cy4zqkDxHYPHOEijFrDMm7mRL+R5SMX0
 EH1oqdcUgqMlq0H99DIFM4hm6AWODt7utQmKjM5NQjq6qy/clKrEbuwMXOFqdJq3gYt1yUbMY+b
 RsiCT96M2hDYAk/EnNDrvSNw+PX1El55uN7ExzhDgQeQ+xxpacGhZkL1YLw54HrtKMAcGhvvDId
 WiS5YD8VbDIFZwP6j7BaWXuWjm97vOokxspiSsDKglf8y87A
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: JJN_thWiayx8Xc8hvOowaJn5P3ATjyrO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfX/ln52r/WKCEJ
 l9JVI2UOZHmzojLHSmE0jDA1OPuahQMDoy9A+NaG1AevA6TUDufGKel66x7o/FHK6sh5tQeiv8G
 RfCwaoKnMd9qfdoIKsvmo/FE/7lG+nlhO5guUO53hzdcTa6ZuUn2zSiTHdh6hV2zXjiEHz9LAKJ
 OBgTUZZQ7vtYNUPElFkLplz8qZglB3u3WEwJJXFAubdcJrZYr8hEnIOLpPWYGYgIE8yvf91yJCV
 FBr2dFA0OM3TuWr44BrbbJ7a6CT9WPazCy07cHhDgAscRm8PKmfHgYUJjJCou1kUhDD81Fbp4je
 7uvVo1tjQStjS/29iiQi39C+U6NPyPo9+Cyors2Hu+Vx0FfODF3mdPknBKIYPwJNRhIwi0KaX3E
 M73ROBUJ0sZ3UunvRjA3XJkISH6b0HujlDCg+KMYOX9rW+CRwdO2FxmtS8Pp4P/Vny6wzklntnk
 aX5u1asg9fHH7yLooDQ==
X-Proofpoint-ORIG-GUID: JJN_thWiayx8Xc8hvOowaJn5P3ATjyrO
X-Authority-Analysis: v=2.4 cv=Yv4ChoYX c=1 sm=1 tr=0 ts=695c5ef0 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Vj5tKrsnPMLlX677hvEA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060007

On SDM845 SPI uses hardware-provided chip select, while specifying
cs-gpio makes the driver request GPIO pin, which on DB845c conflicts
with the normal host controllers pinctrl entry.

Drop the cs-gpios property to restore SPI functionality.

Fixes: cb29e7106d4e ("arm64: dts: qcom: db845c: Add support for MCP2517FD")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index ce23f87e0316..ad283a79bcdb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -850,7 +850,6 @@ &spi0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&qup_spi0_default>;
-	cs-gpios = <&tlmm 3 GPIO_ACTIVE_LOW>;
 
 	can@0 {
 		compatible = "microchip,mcp2517fd";

-- 
2.47.3

