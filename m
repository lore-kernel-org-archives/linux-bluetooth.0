Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429543;
	b=NWD8qYRftLBLYy8TLJbXK/izuFu7+NmsmRea/G+eYy06Zs1HjrsnRTIyqlqZSH2zO4Dw
	 yIdtpdpzv7ciCj2DxNaV37keTJj1++d37brecp9GQPxkDYJWxBlUfdzbttTbo93M/l8xh
	 ciAMa08Zv84cWwxKRAt4mwH6tStTtro7RLHaty+GuzFiGLxzb98LWCeP7HDEZCLLvZegH
	 bGIhFsJvwKPRKNaz+1d3A1L5+OltkxT/uYZkqRuQEAWijcfPd+rdD9tsRAvXt9TemUydx
	 1OApkdvdatzas54XEZ2uQkW6mwj6HYXOPWEzbSJgKzHc7KbNfRM6bUXh5ZmzDKtV0Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429543;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=zuHpqQkWP8DCxuWOtgyzddlRMbuSJfJbAsNyifLrpAY=;
	b=2zvr6dgDneUfq3hse4Yjq5DUlua+fZRbdE1ntZ+4APXZ7dWCbzGtoEm9Q4gGjmWbMMUV
	 b2ILm+hZIo3O1Mt7dWZBeaFsEq1xGnfMMGRMKNUnlsD/rcysPUyC+FAxXPd8BmJ4LoNCf
	 bTuDL3U8uQNs7EhPE5DbOouV10if8uj19ibyPB6omMYBXYihb4FCYKxbBIVTPYKKiaz9V
	 pYcH2TZt8TAMWrb6dJlJDp2/pXdB53Dh+UCq3/Ck2hGV7rmk1Qh0PFeFWvDCcxaW/T5yI
	 EEBZNGL8Kv/Z5Vf3H0Gqlm7kGEwAQJNh7fZHma6jJ8uO8MUMuL7A/QFAVPnG4gZLXUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pzMhzkT3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BIpxouXS;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D18606A338
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 10:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25D18606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pzMhzkT3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BIpxouXS
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9Fw5c1543961
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 10:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zuHpqQkWP8DCxuWOtgyzddlRMbuSJfJbAsNyifLrpAY=; b=pzMhzkT3QRT3OAzR
	CB/AD6PqcTEBNKUx0VU4nn0GAIJvP8xn35LrjLiZrtDog62ek/bciB47YEzx6fLY
	oK6yaUnqAq5O7nEzREivPypxTMeHcHCFRb8yLKQP0N04+x783La4SvNZvA1bv8aD
	cr8GCIvFc/TTvgsb+y6pHfroWg1etk3gRaXGwxp0lhNEHXJPW/c60R2hOtFJAYaf
	94it+0Vb73SV5pf8en9IkpZ/atBav2rhtVwOoy+iNV0D6ocFeVqMFNLDQ0rUWdWP
	7AvgLTY6Rhni7l8EQlI32F+7x2p7pPS1rLtYjDEnm26VC6IwkhWWfIScdkxCmjif
	DJANwg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fy00xxr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 10:25:41 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-94961ed97d6so559708885a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 02:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795429541; x=1796034341; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zuHpqQkWP8DCxuWOtgyzddlRMbuSJfJbAsNyifLrpAY=;
        b=BIpxouXSSc/54BaODqdngfTIsb32KsP120FAsUwlUFAdMc76dbcxIPthYftn7cjNbC
         JDEJSPNim24fLSfbrVLWcIC2GVNX9tQsVB0AU61T95k9130Bk2LyLZayosCL9kRTNU6J
         2UobXj6T75Up2FdpXpGWQChLDdDjCJIUYPf8D+pCYO3P5h5Ks5Ai+se74s2/iUYgWe2p
         2gRB0z5ZwdUX9V3p3N8v86r8CF+PJjsTSviZn06sYU39O7z/LfzP1WDt3OGEExfSJoxQ
         PS//zqZhA6GRuykuA2VhomBwTZXt3C1pcHfCF+sxq2X4TBDlU6umwQ7i68SA8hlUuwK6
         Tc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795429541; x=1796034341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zuHpqQkWP8DCxuWOtgyzddlRMbuSJfJbAsNyifLrpAY=;
        b=aE+DEt6uRtCIAEvwms3tj7L83sRbNI3fOvXgR1ODlMuq5T6PsaWa3YnAjyaarf893S
         dPbqJbcPU3y4YznReXMzZ6YTrXH6wZmyCezIsqQEhVQWhoUOhwIzwPR0M0nftl7aowkX
         rUVqnqziYLFuwSNzmLYQc0okCdoHUN2aHyY+ymulgL3EZYJPNini3ALQfWP9d3hT7sHS
         pj1LAZP+kZgh8fT695LLbMjiaYoztLMA6wuBRG9T5w8K88kBWM1+uU30mON9Ty/SInFN
         58L1zAd659jYSIXCbMY0xJfKgBC0oKkZlrrjUTKMttPl5ZgYPWIQEjONF/s/MhD9jsi7
         V/Xw==
X-Forwarded-Encrypted: i=1; AL+hErEMJkOAGlnXoKf8rWtxea73QiMY3jELfVIKoHFZP63dPs+rKoYtqLch7fT7SamIPipPt/MYdbjhZJbAvQVCBY0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8++CvGlSOAmX58XXsOoik+HhtOEAFU/IjBdrsxEHgIy0nmiD+Y
	kp5bI9lIpT6i3n+mtVNa6mQMZgcLfNosEMu4FrKPsRXE+Cd048w5mKcxIr4Q7QVYcLr2GGSyqPA
	rUZTZWQmn+AgFSGnhaP4S3vifhnu2GuOQPHChaQYkseHoIU4FSJFblnFlBgb9WbGZHu1gKVI=
X-Gm-Gg: AZFdTZes5jCRYVx3Se/PoXP9Lqd58m4VooZjRJFbleNtYGaPy9taO51gw3Q+l3amJQH
	jLFd/3/z9bR7VlcRlnG0ewmhNSVIUgDchAg0vvvXUC22GS+fSbKwUQCFAj7i21QOObwUZIiIJxA
	0x77CceiuerjxFHbwv/pEZY9dPXEoFj7CF/94SU2Fm0Ydnz9QuwvCsY0SFUoFxlTgXrfVqcqzi4
	iWbtTnr/nGGtpH8ZSq4g8k1OvdkKfCAv24pb3l61a8OcuuR0NomALWnic0iIyzzIP4J8iCTPY9G
	P0YAU9bcPbL0ZKyEZXKEHL22HEeNNhpnab3XPACgaW8ElqWnwUmk/3hQwi7Mfn3s6kawlmC0BuD
	lAhANFq+CiX5bri56/Ha7w27e4nCDpxOOuxspdQvH7sADwSgm3ns5wfLzWP2FvTGgcRtBl7Ef4o
	fJKdC/qhZ3/Ks5l2iujnptXGHRVqZ31dVveo9pPAuHpS2GY8/tPvFRpA/U5PChpLYlif+eqFPb4
	CSbnbTyEvUnpgEDFGbf89c7An3/
X-Received: by 2002:a05:620a:2243:10b0:949:c64a:82c8 with SMTP id af79cd13be357-949c64a8922mr965994385a.39.1795429541157;
        Mon, 23 Nov 2026 02:25:41 -0800 (PST)
X-Received: by 2002:a05:620a:2243:10b0:949:c64a:82c8 with SMTP id af79cd13be357-949c64a8922mr965992585a.39.1795429540713;
        Mon, 23 Nov 2026 02:25:40 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:58b4:dc38:81d5:3c3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm634166845e9.4.2026.11.23.02.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:25:39 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 11:25:34 +0100
Subject: [PATCH v8 3/8] Bluetooth: hci_qca: Set 'bt_en_available' from
 pwrseq controllability
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-monza-wireless-v8-3-a8b38604be6c@oss.qualcomm.com>
References: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
In-Reply-To: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX92k1lzcubr/W
 DKkc947QuUZsaZ1ytsAD0hpkMZ6dRV9ZHg4aCKONp8tqZ09QJ3ZX+RlstGpXUxzF+OlPZgSUfVU
 i25l21CxAO+u4TUaadeP/9IWjIQslJoWLJAMvvZ3o46UHnmqC81MsOwd55B1dEV04Bmw2qFgNbL
 fJ0t+pte+OHUw1WfsyMLlYRSzelCbJE0/3uP3RYzzCl+Wx362/UG/03GpHBX+8pLKy7ROr+SBk6
 8QFWmOS3cqvpMuUtjYGM0kXtnogKgDoDc3OPaYb4c3HH8IA9dclYbU2maXzYzMvNje8HlDGCuF/
 XQHPX3i24NHrOVKSM03Ca+/+sxvmgYXS8Ter8IHG5DhEZDWKy3tnX9oZm5le7DV9C3yVLIVKdA0
 jUbkYqiB+iap6cOJRan0ObTUWjLPUclsqpmTy78JdEdPAlJRLdlShnhPIODijNNXvVdApbVz4vG
 nxsD9npYxaQCDGXGknQ==
X-Proofpoint-ORIG-GUID: 20xUZUwU2tC0w40kWEDuDDKtEs4ddFWk
X-Authority-Analysis: v=2.4 cv=QrXLTlyd c=1 sm=1 tr=0 ts=6b0414a6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=8YyhkPy0JF_pzLATneMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 20xUZUwU2tC0w40kWEDuDDKtEs4ddFWk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX/7XzQ7iPp6sm
 l5aoojGtJtWVEZT6Ki52FsyDa9jft0cmWMyBkVZ5ogjkqmYZOH/y5AWXDF9g3SyuLrMpO4V7/bY
 R2p1oVdcrkRSiYRZIoFESiKcrk9yxAk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230041

A Bluetooth device only needs the non-persistent setup if the host can
gate its power, so that it is actually reset on the next power-on. When the
power is controlled by a power sequencer, whether the host can gate it
depends on the hardware wiring, e.g. the presence of the BT_EN or
W_DISABLE2# line.

Query the generic pwrseq_is_controllable() helper whenever the BT power
comes from a sequencer, regardless of which provider it is (M2, WCN, ...).
If the power is not controllable, clear 'bt_en_available' so that
HCI_QUIRK_NON_PERSISTENT_SETUP is not set.

This is based on Manivannan's original patch that keyed the decision off
the W_DISABLE2# device tree property, it now uses the generic pwrseq helper
and handles the always-on case.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 3b2792a3639cfbd9ee7a781b6e4c26c660495391..1b7b011cd6adf682677a01bd8d501a92ce896ec7 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2631,7 +2631,24 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			return PTR_ERR(qcadev->susclk);
 		}
 	}
-	
+
+	if (qcadev->bt_power && qcadev->bt_power->pwrseq) {
+		bt_en_available = pwrseq_is_controllable(qcadev->bt_power->pwrseq);
+		if (!bt_en_available) {
+			/* The host cannot gate the BT power individually.
+			 * Treat it as always-on and drop the pwrseq handle.
+			 * The descriptor itself is still released by devres,
+			 * so dropping the handle here is not a leak.
+			 */
+			err = pwrseq_enable(qcadev->bt_power->pwrseq);
+			if (err)
+				return dev_err_probe(&serdev->dev, err,
+						     "failed to power on BT device\n");
+
+			qcadev->bt_power->pwrseq = NULL;
+		}
+	}
+
 	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
 	if (err) {
 		BT_ERR("serdev registration failed");

-- 
2.34.1

