Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECB8314B76
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139945; cv=none; b=qcDRGaLefo0Po5H11KuA6632nBRr8mBjbze/ChM6I1JM1sKCpPTlQ7tUOgb5gpRpCr/cdqO635DwphwLdO8/Pf55vIru+y07gH+SwVVZG3QzHt2KcFf9Lyv7y21BClwgtACscNiBaMevGT4L0Z4g0NqT1N0ksejwdlBx7uoK45k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139945; c=relaxed/simple;
	bh=6NMQB6IDMD3/GAL65iyq1WL2WZiGM77Z5OQj0LrXioA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=esi/NIR18Sfbl4/jNoD0di8h6QNWZ3u3tXpMXzbwnntT/mYMLFmymmxLBLOFmWBP148aw5aZFU1PjABBUAcMxfkvDtkbFHZNKRUqW/wPOHh9AygUGW23JLexFA4Zt6x/AIAWomOau78wQdq7/7guXUmUajmNWsq++8ZexC3JARQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WAHaLH1i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cdq5NvtV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WAHaLH1i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cdq5NvtV"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDSdun1120927
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3fSorn+BUeVEJzi+hjdN1IIZmHl/0iEbRgi53m7QPig=; b=WAHaLH1iTA1W9/xk
	tpQ2LfuDE7ia35wM7C1UbD8MA3b9F/0K/nFeR36kACD5/B7L0cP5W+AAVrlC2xB6
	3rY0sCSxP0EmDZIOSBGkRuDVq9HohuZlZoBPVQ0tcOy6VT/n6J4rWtoH7temZKjq
	yJQ8oLL9xwfTYgvRKyqk/xUlAz3dYGtscyjXPB0WM3QnRCFDkHmF5RSIh2+Et6A0
	zqa38p5pg3M/kuC7hLThtdl2OYsJMztnj8cb7wXVNvpfILW7TfYb9NL62Y7qq3NE
	SlB9VfyIqBlHhxGJ7zL8NoryU9/A5bWrvDAsxjvC8bDdeUlQ5J201zPVZkzkXnET
	3hk6tQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5ye8ab5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:20 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-137eced000dso291626c88.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 07:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782139940; x=1782744740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fSorn+BUeVEJzi+hjdN1IIZmHl/0iEbRgi53m7QPig=;
        b=cdq5NvtVQnLKB9+cUBingEKUHdZPLuE3Nh8ljc0qTyYWh5HGR7kCXV4wNwIMUjt1jk
         peSTmbIwvUgdI5P5RKrbUgh7AvOgbbpE5/NE2APUbDEPo8v6ScroXWLxZXSR7Czb/5sa
         nDpb685q1UR09fimvt2TrCb9l1OvWYlrcTtTQpWieV665PMSnRilyB+Iq4nBkWLtKirg
         MfwjHb0EAOBikid+Lfe7TcYvTTctBdj+4IgoLYy69oHZjEQF9v4CyQ4GlevE7afLPcBt
         1/T8OcAB1+f1NkTZEMIbJaPzP5Z9lFK1aYJ48SGowx47uM6LzsnyDaOPaREjrcLuGPZt
         UXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782139940; x=1782744740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3fSorn+BUeVEJzi+hjdN1IIZmHl/0iEbRgi53m7QPig=;
        b=QOHW6StrjnEL0lSy2RRTE9Q6gSlY5/H/Wa456Oy9VnIcfeoCRROYm1HlUPzTgyXLKo
         6vVfMcTDWtJhvPV1/C8qBTrrtsZ2BxCN3rQAl2yDsXmpoGNHGIMhuEGZmV/N0wC6H/DO
         xSE7fI+CnWUgB3wBqaJYSjg5mqxjZWgaCNtaLSzxi7YKJ6BabGy88fZcASMTHj1U13n2
         N4d21zuDp4NfuWfMJ1eUhwyj8uHgDk43sK96lTHiaBsOZg2Ps9WlCywhAnsCfxYmHHs1
         R3FH4wrUIIyTVVBR0lhYnPZq78MigZjN8x+kud4YGrLwgN4EyQkCNtPA/p44xmauTJbR
         a05Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro3Wmc5e44BM2GQKNaY07fLZwtoGRZ5tEWOqLW/x0HPxxK7lvwUFHu9bzMlDju9hvscbdwzDa5wsFpqM15TF/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+0MFcXBNHAKp5VcqqktbROFlvInCJd8DPWyDuzuhaiVlvs7Jp
	4gHdHG3VwRFQT74F1WxrW40rgJgGOIuWeo9gvzOtKqdW1pANePh+q5i0EpxTO3gVyb9/XUsccEE
	BmwTF2YT2M/MDm1ayiOlGTEHS2rjZbMiYVk0WhCexYoy6aUe5YoHyhgNe43kBstDfZea8APs=
X-Gm-Gg: AfdE7ckboKeTmbrm1UCAA3XavQ9ShhhRErBbRRtyd2sTE+UsSCcv3pjtHKDR+VxpE/C
	L4LsPICzOkPBQqHGZeokE3CTB7Bs1Ebn5CLFJ4Mm/8k3CarE+ZhkFTMohDYzU5I+EHhfOoGlzrP
	qKFsvaYijrr43dOkoVJRfRO4aaySQo4TpnFQsgtJ2nFHlqvL9yvClveZnTe9KppRm8Jv37PZYQZ
	cD4gT4REvAir0tP8tSc2qCbPQnmUlMeW2M+5iooA9IbusAKXM/rOr0HL7AK++38zbLffLYVufG9
	qdHrkPjX+WfocSExN+v2cT//yB+UsgXgEO6p8ANXuDIG5WeskZCK6o2nBXmy017mDmmqiTBid+A
	A9CW3aXkShBIF6tssOlFUkpSkHB6LBHpzc5fVju6FrvzQ+5tPCelmKDj88g==
X-Received: by 2002:a05:7300:2153:b0:30b:e4a6:1aab with SMTP id 5a478bee46e88-30c52443905mr219716eec.8.1782139939952;
        Mon, 22 Jun 2026 07:52:19 -0700 (PDT)
X-Received: by 2002:a05:7300:2153:b0:30b:e4a6:1aab with SMTP id 5a478bee46e88-30c52443905mr219707eec.8.1782139939294;
        Mon, 22 Jun 2026 07:52:19 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bddfe34sm12025561eec.20.2026.06.22.07.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:52:18 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 07:52:17 -0700
Subject: [PATCH 04/13] Bluetooth: btusb: QCA: Do not populate devcoredump
 fields on ATH3012 or QCA_ROME
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-bt_bugfix-v1-4-11f936d84e72@oss.qualcomm.com>
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
In-Reply-To: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: E-RlXitLnjkWcRKqTONVd6O31b68xI6I
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfX3Y7MLXuhNrlf
 aHmWdCKTBean1uAGRvK9fKch0YKUNDhKpHzCLs7KWiNyse8hdd2KXRqdYT9EmLp/uJVVRenA+1/
 KX8lOgN8kp1KcNf5Ki/HMAlrJYVF1PY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfX91rtPFF95Pr6
 0cnE3AoS3HSis7tqZEptK+W8qJeirpKvfPMuMF+cROTEFEwyelFru+eK9laCMTwOS3HeDP3LriK
 7r+9L0UKHwls+PTYqjbqp8KKPyTWTzAS+6j9330TU0TsP2WiWQGVBPSgc8TTg+R3H9v8KPbRDTk
 w6l7z9AWYYo5Pqsh12m9dNfymZWVzHUtMOf5QvKsuFNQOImDm58SoriLU1m944W4oTdFD4MWfuw
 OGpqelgqyOtO2L+EgbiGLK9EHaskkrdbTnSejnHf+wMLPcht3gBIkhJ/ZETkfTPmkWobS4Dz0Yp
 onnoBXHliVUeZJb4sFqv0TKP2xARtazBQznRWnvaT+AJy0NzS2lN9nzLSVi+X8ByVIn0k1vxcfE
 cIZc40lsWXvcPWdFik5rZh3ruFaHvZyBd92VtY4j8pxlKPnhlLyrUpozRXA/tJg9TgSRN7F0ULT
 azZKIRgqRzUZYxtKg4Q==
X-Proofpoint-GUID: E-RlXitLnjkWcRKqTONVd6O31b68xI6I
X-Authority-Analysis: v=2.4 cv=YpI/gYYX c=1 sm=1 tr=0 ts=6a394c24 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=j0w3eOB3VtzsIZiBwfcA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220147

Devcoredump is disabled on ATH3012 or QCA_ROME, but btusb_setup_qca()
used by both unconditionally populates those two devcoredump fields.

Fix by populating devcoredump fields only for BTUSB_QCA_WCN6855 devices,
which are the only ones that enable devcoredump.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 6a90f012b226..184a87d1234c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3708,8 +3708,10 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 	if (err < 0)
 		return err;
 
-	btdata->qca_dump.fw_version = le32_to_cpu(ver.patch_version);
-	btdata->qca_dump.controller_id = le32_to_cpu(ver.rom_version);
+	if (btdata->match_id->driver_info & BTUSB_QCA_WCN6855) {
+		btdata->qca_dump.fw_version = le32_to_cpu(ver.patch_version);
+		btdata->qca_dump.controller_id = le32_to_cpu(ver.rom_version);
+	}
 
 	if (!(status & QCA_SYSCFG_UPDATED)) {
 		err = btusb_setup_qca_load_nvm(hdev, &ver, info);

-- 
2.34.1

