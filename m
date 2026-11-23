Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442180;
	b=tT0d+UGXAaFRYt3d8wW8S/1uSst3oLgXzRo8jS9ffGNdkzyunU9FE8nR4Gkw10MhZs+q
	 F1hXySOz59uKsmsW7aCnt+/djqbSF9b+MKF9E2e8HgvIxabL2pSSF1lGidKb+ca/LvZKr
	 TxYekCdevKJppyhMnyHEUioLtTE03d7woU7IAB8Rb1XsKOFzjfyPfEvjTNIl/KDOQkGFp
	 VdTl1xn2IJHYyaEi9JgLb2XbLmqLolZTicirt19Dky5saTtli1kfLLQbIshjyT/eNVBRF
	 v6I2rzWC1PA/hdOl1H+YK5f/bus4C1rIEHI9PrZT5tx3N5oNF9KcRm50H4DX3qTCFwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442180;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=a5Va2F2EmJxKCX71IGxuO/VT6wpOAYxJK3OKtAsPW2Y=;
	b=bifnp/TFhgifxaBWHDJqMQVPaR3RsRIvAGeRsICEYHQ3V6YxhgjGemSl7gi3XgORBjkC
	 wGhImA0aZWc864uXmziDToNwL+IlY38y2zYI20yyXmrnFKu3RklAwaDVHSE9IAy9C/svn
	 znuc4MoMVIThTzmx+98NnkSc7W+fHrP87fvoFb//6iA5EbWY8w3KF5CIOoJ6PiuHsoA/U
	 cAp0lhGAPt2oxsg56O+BNQe18CbBMvT+AgB/7C+tNwVrf3ZND62Bwd88nJv9kB5GZzLg2
	 2OyadY6MdA0v2I/EOqFmJpsoLigZBOQd5zhiweWVr12BkcsvtJb1ftN6C8OxJSkjGgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OPz1nG6Q;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ihsgwavl;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8459A60A260E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 13:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8459A60A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OPz1nG6Q;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ihsgwavl
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDKwli2442725
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 13:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a5Va2F2EmJxKCX71IGxuO/VT6wpOAYxJK3OKtAsPW2Y=; b=OPz1nG6QtqvIY99R
	0o+9QwtfAkRZRg3EX82sz02jE/W2gYYcXfYGAeun/FnN1X+ybipWWnkx5zydDR44
	vhpmn937JJ8xY2FqFNH57FRsE9AberMNL+oH1lFoUkKem9IOaZ6TAy7nDwm5rTEO
	Zk+zPbmZvBWA/K/abFU5GYtulpQf8TrC/jdYEZ2ROs1eTah8on57BJV/EeYeybWd
	yaUpQsjKO1CtvYKvMPze8OWzoV2X4XbOjmH2CD2ncePKX8LEy8oErwi7PqwhkKsq
	5yomR6mfRdJqHiIcOq8YroygOyIN9nRcBRbDsiGp5HKRn9EFGGUiqtvKKgxJBn7O
	/OZWpg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1k1nms-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 13:56:18 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-949b0d322fbso484578685a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 05:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795442178; x=1796046978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a5Va2F2EmJxKCX71IGxuO/VT6wpOAYxJK3OKtAsPW2Y=;
        b=ihsgwavluhvVp8oGwO3hrlf+SR8+eZcJsJyonoQFrzfXF7HsLHP+YqKLoDjkOonBJz
         UTZqBC+OGL8s+nXHU1hDpGfBuVjavKyK03ckMKHU51Iia/gXAHID7gw+iM7G64/tRbFD
         cPkS1Ym6avMv8lzQCIa9RMMHo20hOu5+W+UWzg2aAZ/tb2YrM9BitryrkZW392uPbFwf
         DRSzdKJtnvSfIiUlMlLZbyPHP1HjGgkZJGpE3MeVtBBgRrDL8bsLy183QUNyyCmfLxxy
         zRcaZQYX6oYWCTKs8OzFQRh6NGOQxbuhyPHsJDfWUNC3VN2yaeP877A+48bZ7iD0qZnm
         Hd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442178; x=1796046978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a5Va2F2EmJxKCX71IGxuO/VT6wpOAYxJK3OKtAsPW2Y=;
        b=u5ZzwY0DouLgkmuVYXFCVXLTS/0isVmO+WrL8aBda1GqWJceY4awsLuhsSSPZb41DI
         4JhwsfR30Wh9lNs96Lr5Qa6UgKSMvY2EuNgeVIENifXXqG5/YlARbrzff8vbNVl5p+Cu
         oAU6J0pUGzo+SKyZLBjZTkTDq+r2KcX6de/dVIadQZemD73C2Y2LqijvtBREYQ71oUQH
         Lec32pSnsBcrYsk3aCFAOosWuIXikIkVP6ZdLODs0sF13elzLxi6i2YCPxaidrhzqRqg
         LDRxwsa51aJpJjyDojtG9WxztCkh3JSMD/QYJB5IdkXydGXIjmJfs+pVgKf0HbsICVhD
         tr5g==
X-Forwarded-Encrypted: i=1; AL+hErFsL0a1bPkVYkslPK8ACwLpwJMJJUCMi9x9thQiNCPX/XKuUzXCZmUH0t7pCXxY+cg8CmFJHTQf25aXxCfhs08=@vger.kernel.org
X-Gm-Message-State: APuU4Z9mua38H1hXp7g/IT5uoNo3TuRX0h2YNyNtdobUM/F5UnZDnAVK
	byP47Gga2OV89mE0sD32SVS8gs8X7lD6u20iB2TLpYnc4v1witCrGte2L28RD0lfk8EjSWssz1n
	3cIN7aqljmCEzwl4bq5hHvsUXSZiOaIdo5IyqZQfRqs9IDJP0OyYmSUgNvT2yMa4mYcyF82M=
X-Gm-Gg: AZFdTZc4VmiHib7uklytYW6KQTU5e1/qzKPEYthwzPvWYKub9ODwnRYGsqmQaxvUzVZ
	18YC8yp6iSZl2tHVWuzKnQ2NGJHtcVnfXx7ECCx2GRWCj3dMdScrhaUB9MX2M0tR/YPYFl+tlT/
	IhzAJGdyQ3BTAZgviTklTgfouSoXnkiq2i0yiOvUaZdYSyGxtfK3HrY2TnFdgcgUURHFLgc/8km
	0eSneut6tWVQrx0x+PwNY2RZmF9N8/VHzeo/uaqOpWzvr+4RpK1q20uMekYFAXmwD898VEiNUHo
	UcsuN7Cs2ooYnF1mp+RV2k/g5P72dVmOGTO3gKcz0y40mR+XXM/MOxS4S0e5tpZN8OO1tRdRX9F
	F+tyrSRnWwBWzFKpxkoSRPxM/6T5/We1uHg9urZUFGriTAPGAPfh7jL7HMmzgYsn9KqTgOuSDrD
	7SdkIM4OlfkgwJwLgKaUhzaOTeOKE4DfceX8MNZuKuFIneUYRfg3HaatNWEl06y7O8QCo6tLW21
	adTp2M93+b62w1T+kgWZ1yWY4W6
X-Received: by 2002:a05:620a:2605:b0:949:6d5c:3fff with SMTP id af79cd13be357-949ba9acf03mr1821251185a.44.1795442177746;
        Mon, 23 Nov 2026 05:56:17 -0800 (PST)
X-Received: by 2002:a05:620a:2605:b0:949:6d5c:3fff with SMTP id af79cd13be357-949ba9acf03mr1821247685a.44.1795442177277;
        Mon, 23 Nov 2026 05:56:17 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:6c6b:1e5a:79dd:a527])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c4353d6sm21724625f8f.56.2026.11.23.05.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:56:16 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 14:56:10 +0100
Subject: [PATCH v9 3/8] Bluetooth: hci_qca: Set 'bt_en_available' from
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
Message-Id: <20261123-monza-wireless-v9-3-450d7d764aea@oss.qualcomm.com>
References: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
In-Reply-To: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX0ZG3WLQ3267Y
 o81BGu7dTWWtvXE3ZKY2Gh0HvIqGpjLOV7VXi58sO66CslX7vHWKqFpCM1BI0iVy/VYjF6gY9Vo
 +mBcJA9mfOityUgb5Jgo/0TpM1lQpEQ=
X-Proofpoint-GUID: hmCjbL66o7UPXgNDNcdk8XHec5j_txCf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX7yLEtF4QFI0o
 LMw4/xiRmnVbob+R3az3ybWdLJCJHwtAtnr6VCUC/SpTQx8CfykjjvQ/iNxC0ebYnq+XbpsWhaT
 n+fXesSXE1NHwVlOA04nQ7RjlW6eO2grSdAafT1AsGoxYZUSiBGy6NrIKbMfzLQaDLDTM1Vuuu4
 diD4L7ly1CRg/wUmD5asMHuUytKTR8XhQw2cAtQA/tDJkktwv6Yx0nNtSeRBeh9BHwoBriO+f/A
 NYtshtjv/qWI1xMqrzwpf+dRxtz7YjI/8s8jGF1hrEDm1MkAZ/M/Vc9piyvCQef/Fj42KTspTT+
 ktJYOfed1RagjUED8f0y6s6MuhizUOXDNymbfuiHbARL1w0YOf/xzrU/1AzOc1NHZBCv/PK/hQw
 w+o2XenEmW5P5NPd0M7qifOq/9nefCDzgRB4owTiqlHyXYjRC5848LL8C6Vr69VRQpE45MGUJyi
 NhSMP9HGIz6rh8rb4aA==
X-Proofpoint-ORIG-GUID: hmCjbL66o7UPXgNDNcdk8XHec5j_txCf
X-Authority-Analysis: v=2.4 cv=cpIOAF4i c=1 sm=1 tr=0 ts=6b044602 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=8YyhkPy0JF_pzLATneMA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230055

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
index 5544dff9d10b5064797d41294b126fbc229a8dd5..3c0239e837fed7ff8d8261b0c61e5163945d157b 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2632,7 +2632,24 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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

