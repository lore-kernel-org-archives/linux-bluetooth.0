Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ECB3126CA
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139943; cv=none; b=Vjh8xHeHGGPDRLhruqLY1bLQyOJtGGuUfEfBsQ3/Uo2PbiiyLtclKhpisyyPDQHXyziyewrknEw3MzVBhntn9K5N6gurxnpeYrGJKltwo7nVUs+4jTAOrsj6a1FviUtAdoUY6mUojv4KXU3TXcx8ri1rCHgq64+J6biPKSBJzfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139943; c=relaxed/simple;
	bh=KlQAV2tDciJBHz066Lqbt/JQnFkB38ZiAvjkY7Pa/04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IgK4i9hyA/J7cccefYWCzkd+AuYhHGaUrqEmk1dOMs2oCluRMbw293D0qxvNGrFubBP8zZ/oiv2JA+mjHqzvczemGWUpsENhEP54R1NATero0hsrjC4QprGUWK2eP1ObG8w4yx0/9uY7mHNumkamrTcQSClUJWaEA7uWjTL5KRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EfitfEpL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kreqyUsv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EfitfEpL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kreqyUsv"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDGK69776499
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	14Obbvd4z6NdWA1t1SKXJ5JFfXqzhEWCNw4XBeZhqg0=; b=EfitfEpL6hP4X6cO
	doBXFjvzTXMdqwECZ3qoSqGWR9srDnHGG0/kgBqjMTlTmDD1c8TFjy8OCKy2YIpr
	kFqFs0lCR7ZsKqQDYVsG0GUJWduz/bzTHw0GELnqdsDrDOnFrkVbEghIBq5QBlwp
	tLs/FYiQqWZwDz3NmYvMCG3iQsBECvUuWBSQI/3qw6Pfl9lskTsl7JIDd01peaQe
	wsIG/rQ4w8XanJXI3IGqub86JnJn88PINGxJZfxzshf3ewOsM9Ijn+0b/r0VavO7
	Gr9lAzMYfu0igSMHF14vrl4ufduuhnbA0QCu7cAbS0gPdrm6wgKE6m3Sp+6B7lgJ
	JdJCpQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yj90d3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:17 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1399e7a6d05so584437c88.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 07:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782139937; x=1782744737; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14Obbvd4z6NdWA1t1SKXJ5JFfXqzhEWCNw4XBeZhqg0=;
        b=kreqyUsvjG8i8urZeCvHpdHWwf3tLUt11wLQESqX5hLgTOscROuBq49LogRJoIaStI
         2F7EWDKJ92kK1O0+xZ+JhbeN82F+f7F+2caq8s8exN9WrP4YY60vp62Y5EtKCfZVcnjf
         bv2TI05jEXvmi4hYvc6dDspbbDcxmnUiiEPC4BZEbYDJ1UaJnANgV0OVnO4AVuSY7hSd
         SyXtTo0s8CrE04p1qLOb1UlwL6Xx9vudFAn7jwFrX6LZew9gRg6PtV5Jazn88VoSw7Z+
         7Nz+t9hJ67UOtZ9esAgSz4esPO5v5nQVny3YkCmAa8WjKgzs+Iv3hWVQLCXXPJyfiKO0
         npZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782139937; x=1782744737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=14Obbvd4z6NdWA1t1SKXJ5JFfXqzhEWCNw4XBeZhqg0=;
        b=Q5VWpN1eh46TlvrJQNjtb3NoMCHEa6MQAfdHoS4fBiuco6rJRQy9Rpz5hSlavc56g/
         Kto/LF0WwOwwSVfrROjDNWD+vM9oQWrXwEYGuQpgdFXgfU91M4eyRUxqI02RhmZjnsOh
         vLR/QYwsH+KxEr0ZIc04FsHvD/a/zDAC3yxsSf4glEdYL7nrIMYOePZO/zjSJsHDt9kZ
         r73E7Mz6WBtqJuMj5XMo0jGJ95rVK5mWyiJNowtCRaXLolBuE/Edu6mpttu5uJ7HrfDQ
         +hG5XTekOCGn4Jc+7yd1zmyLpakL+fkgLcthmoST4+O6dwzfPsdIldtvxvwATQ7Kst03
         o5Vw==
X-Forwarded-Encrypted: i=1; AHgh+Rqz7V4Q90Zpl/arRPCNBbZamRumcAM09pxNAFiFNGgCOHXjx/2fGG8XWOamoJlx7U+mds6oVc1xk9/iJTcoy6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXBCYc65ls0vut8F65ia4MfxV2fO39ehu9mduWvorJa5U1N3BB
	yqGE8R3MjXQMTYSAD88f3yEbfHx3g+yiMOG+OXwJomFoH4lUyEhInE/FFHK0FEoUNVAZ+poWLvR
	2NLGg37+mBAvI6KNgTqdPF4GXugCiSwDzBq7RnJKTojn76rxjuRXshzxZuIz6zYk6PZ4oLpQ=
X-Gm-Gg: AfdE7cnQenlgTz3EcTBfTxpLloYqwjLHxXEzcDim6ps2wuK5+SbVdiGe1GVO57Rtxz5
	yQcNeqSnfY+XpOrxd5biFKeQC+51ZNkcXrS0n8tToPKo8EfP+v1YP8YzjQLMD67MDKxzIS+6878
	UHbOjXxPky+vQ4ucMeoHKndhAyroFzItRp+CSUPRcKW372awnZXzcGXKsRZB9W6GacSZwMiOLnT
	oPbdjSAnqmLLkmc4guZWt/f/t8ueZPwT0HZjc/IocUiw3gP6VQIObOgUHGF4x9qTg08//7ga/q6
	AGEK1fvWWfxO9dHcvEZ1MAvAB//deQB7nKh1xMjDRAoKdbotSCEPbLNhQOetVR97V86tluXsTT1
	kBczIlAPNsLaYKz1iZKcwmkcnXkiI+3ak+CiEa9HeRjAvov6OkDx1wnIXvQ==
X-Received: by 2002:a05:7300:730c:b0:2d5:9438:2a02 with SMTP id 5a478bee46e88-30c52186229mr317956eec.1.1782139936916;
        Mon, 22 Jun 2026 07:52:16 -0700 (PDT)
X-Received: by 2002:a05:7300:730c:b0:2d5:9438:2a02 with SMTP id 5a478bee46e88-30c52186229mr317933eec.1.1782139936391;
        Mon, 22 Jun 2026 07:52:16 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bddfe34sm12025561eec.20.2026.06.22.07.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:52:15 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 07:52:14 -0700
Subject: [PATCH 01/13] Bluetooth: btusb: Initialize @priv_size at
 declaration in btusb_probe()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-bt_bugfix-v1-1-11f936d84e72@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: KHq6c4cioJKbV_GJUCvzpN6NLR67vpnm
X-Proofpoint-GUID: KHq6c4cioJKbV_GJUCvzpN6NLR67vpnm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfX68pI7Gmg5tgQ
 vmrLt7SCWSJIq6OwxrXgKj0WmM7P2e8DA1UUd4x6QbY0zgkGNTm6JGIMsZRfsS6qYATXpsR+A3y
 K3i03CPkqPiZ7iXCLMXFT0FdaM7gnk0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfX0vfp9ytO2WpW
 m+StCTq1JxiCF41r4eKsfSdCOTJNg9BLkb4f8zbRhGKboBid0MH2GLc2o8EXMV/krHBL/TCAMsy
 DBQ3XOlwpIf0jPZSWXN1DjsogK9ZPC3rc1Zml127gFd+p/DKKqouiBpfqNCG4i8FIajIF6pcQta
 JDHsAHLllNxBYzIOT5vvlxgzHrejbhW/g1dt8lWtGds1EyyPB52OYT8z6gsgMx9f2oSixqf+M37
 4WEKl+Ir4JLNTc1snRvxbM5dUNaFfPIGnletuDWfWfrAbBylS5Y6UR2LNN4JsT8Svp5En4or7hN
 ha+VL7donqM8f76hAk0Qyt9JEVlOe0nAGtRl2B4pAOrzum8rLAF61YHDgGihe4K5fxbqf1jkYDi
 NTy/kymYnG5ZKZqe2B5Ix+QCF/9b14dYHaudNHYfcZWK9xUKbrpsj5MV7UWrppBGVNJriFT/QS6
 N1U1uwSckHGYbXm1+ZQ==
X-Authority-Analysis: v=2.4 cv=YLSvDxGx c=1 sm=1 tr=0 ts=6a394c21 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=7HHrRZN38_5rRL6TGbMA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220147

Initialize @priv_size at declaration to reduce a redundant assignment.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7f14ce96319b..5209e2418493 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4082,7 +4082,7 @@ static int btusb_probe(struct usb_interface *intf,
 	struct btusb_data *data;
 	struct hci_dev *hdev;
 	unsigned ifnum_base;
-	int err, priv_size;
+	int err, priv_size = 0;
 
 	BT_DBG("intf %p id %p", intf, id);
 
@@ -4152,8 +4152,6 @@ static int btusb_probe(struct usb_interface *intf,
 	init_usb_anchor(&data->ctrl_anchor);
 	spin_lock_init(&data->rxlock);
 
-	priv_size = 0;
-
 	data->recv_event = hci_recv_frame;
 	data->recv_bulk = btusb_recv_bulk;
 

-- 
2.34.1

