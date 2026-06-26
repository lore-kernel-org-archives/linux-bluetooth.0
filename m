Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600943A1E81
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451199; cv=none; b=V0NW5ZBZ8v5Q0XPGmNvToV7C1MgigAPbr8Z78JKC33axDEml5W3newWDiZGPZiIwoUxM1d2lhFP9n3vJTwe4atAgQHZgL1KZNCErMJTwEH2a5Pi24tt1DqJqzaqZjUp7VBAwZ+ihGHmRRNzt5TnSJ3YMU4z4jsiyyN+2dXLPuzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451199; c=relaxed/simple;
	bh=jFcZSODU4EEYbu7XM8Ar7+jFvTy2vGw1OopoZBkWQ5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQLJwcpbCODCGbJHzeWFd/qtPsd23GhHBB59wIZSV69jGlTGqJXxIy3eCIP78faQ/v7ZgXcWik+OygWgjBGODoGxY1Fn7es1CiJQVWtyzBKI61TdSQoj6pi9UWBD2iS/QbwWfjr9tgMBLz+xys9HDKlUt78NzwC0o6Rm9lnYbl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oJ0dYeJZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WmPSC5zn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oJ0dYeJZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WmPSC5zn"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q2ilLV120160
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KTul3dgdpD7qagMI1GRAj/SE9fsLTKfErHkSL7MpL5k=; b=oJ0dYeJZP/XIFhbN
	jZEzUM7+uKGQe9WIEZdARcZc5VGsExepCNamcMxIiTffw0x6PCw+H9xj4GNZx6jb
	3297t5qSjl0NpEWAnEXoKlrBrSesd4a71RdEAkSABrC0C9LNSnB9QWqPoil0ZkNT
	rVxwCeSXlb2M7AFcIcdPo9zIdpaKqvJ+Gxl2PAkxtEHizXJui0LOUHJrZvBqtD/U
	V4TFyydGnqYqxjX3sXHLQXeNFd/lqscyv8cYAuOQqxtEm+/zfNNEeOR5Zpey0g7U
	2O5U8RWOZTVMPxft0LQUQ5JMLgo8o+/Yiisy828x6b5/NC4QtcKvKYCrQQX47c3Y
	eNP/0w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1askswwc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:55 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c6858dddeso73837eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 22:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782451194; x=1783055994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KTul3dgdpD7qagMI1GRAj/SE9fsLTKfErHkSL7MpL5k=;
        b=WmPSC5zn+VAUQMK2IZlfSyL7eDegzScG00Dlu9NqZxrCcxqt5AaUEqflKBp1eOLaxo
         IjwRpaCBOFRkwG6vz8IkMJ14YxgDpLv44Lvf7JZz6x7G1iKPEr2Vu/nxCgjNQBo4Kg6L
         G+7sjUB0vVm+zJkxa/8pRGy6VgmoeDe0zZAkXj0d7RpOnzcHLMnLdAQ8y/JyoUobUW1P
         ndw+mDXxj4DYhN2nzkYaZVb7a/YMy1kfkjlwhELipzjTxcA3iH+NXZ80mIfbroJy8s+W
         RQPXMWjs1bOjP2DbRfZ82kCc1n/34iguOfx/K+ECMlOpbOuI6jL0nDewjQhwaRUqZZvR
         qFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451194; x=1783055994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KTul3dgdpD7qagMI1GRAj/SE9fsLTKfErHkSL7MpL5k=;
        b=TvPVajO/VDZqA2ZF2yxZN5Tjv/0Pqchv/7SCcdcumQ/3KS2QrwY5/ATcCTygS13v1R
         20Dx34GH6l2hyrJcUFrj7B69/hkdWmm+i9HjvcTARlpBdZ4mHQdlb/nWUEQNlrdfzzdi
         500SLWTskilr/l/dc0ks8mo/vEd2jbJ5xFgtl3dAYMOKnapTNcr0FpOMtTPVk83VDXiD
         x8bSHrMz5rtajpvLoyjxry1ezi38vfrWhSBrmQr4+RprGnFZIAVN6Tw0GXNAAIN6XWOK
         OTbgo06cb6IPCUYBNHNvIrXuRTnQlvhszzfKVNtfrqvhkvgns28x3eYrmTFvP+rp9xMP
         JOkA==
X-Forwarded-Encrypted: i=1; AHgh+Rq70kA6CGvM3w4UPl4Q0C5FEQmcIpJE5JPAese2e2pjxBqGKOFJ6m/e+Vpt6zSPgasAd4TcEwKpp3fRQ14GzhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMgE2TpJAnRHMtiA34MObHQKfn9wAZEfBp4Z89El9FhFlq3A0C
	+v6JmKhYoZH5ynfizKiBzsGenTRaWFfQggk+0jfA+RkMs5d44Uh59DH+e0pGCSI38nMCo91CAli
	2VV7WfCtLhY7cHBNsDx9KTLhxIQ6Y/jlQUfomHlzg0LT2NdJ9wHS78a46L/YtDdiLYCvyWnI=
X-Gm-Gg: AfdE7cnseM2Zv85ScgxOa176MELCtDNMYCwTXRTUmoffQ3YMH/C61JjJGvBH81g4HRE
	ekGMQai2xC2klRKBbvJ7ju3ZGUHGdZ6aOrw5XBoc5cdAI0DK6OMwcFQQ2IgMoAOp6Hg+ExQTUny
	lubPyRvbT0XYA94ND40N+LgPe0r7DULmWLUtsASbdCmiMW9Z6KRZ7Ej5NVXZtQyAj3DNQ9QAegl
	7l2BkYRi8BrwfeZKK2Z1fdmRvfOzqxCXoJ4tezSQ8H+ma2GvHiUw4jQLAWfLyVKy0KzJhDgj+ez
	qykOzqjZ7w2emIwp9FwKIUYZb0jgqDGD37NxIZg3nzq6ICQ6I9XFE70hP8nKBK+xWNPsImaScMK
	ZOz7PyUNr61PbLWvASB3WDQJM5GO27KOKtuQ8Q72ptbk8KvAX0uyuEGQDoA==
X-Received: by 2002:a05:7300:f68d:b0:30c:4384:95ee with SMTP id 5a478bee46e88-30c84db28cdmr2946960eec.5.1782451194337;
        Thu, 25 Jun 2026 22:19:54 -0700 (PDT)
X-Received: by 2002:a05:7300:f68d:b0:30c:4384:95ee with SMTP id 5a478bee46e88-30c84db28cdmr2946941eec.5.1782451193728;
        Thu, 25 Jun 2026 22:19:53 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4ca240sm14345291eec.4.2026.06.25.22.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:19:52 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 22:19:49 -0700
Subject: [PATCH v2 04/12] Bluetooth: btusb: QCA: Fix populating devcoredump
 fields on unenabled devices
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-bt_bugfix-v2-4-93396a6f7d5e@oss.qualcomm.com>
References: <20260625-bt_bugfix-v2-0-93396a6f7d5e@oss.qualcomm.com>
In-Reply-To: <20260625-bt_bugfix-v2-0-93396a6f7d5e@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Tim Jiang <quic_tjiang@quicinc.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX4ZA1kcBIlxVP
 0HFiHAlUZOMGxivXg+H3UpPH/eSL9OEzTSiqMi0dz+Nva3tR+lBxx7RbMy03HNtACGBv8W8LmXS
 F0dwn+ObVAkcHLl51g4eiEu1y+yOkQk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX8fsdDrPppnY0
 DuPyIEMm9uMwIBspwtGLe9IMmd7MFuYX6d2UO0TJFJnVL7sDKAxrjnIL71cKTNR5/M5y0ZSgyQ2
 WM9aIPIQbqxE1UrvBMT+znx0XpvyzOfPJ7IrQJbLXRZKt8xMxnC91aZk2FSDc8zJfKKoYircjQb
 mQP/s8Lw5EI70HnkefvNZOgxO6BEGz4Yqcpd4uMCKzYmT6iNDmiRWPYzZoxCsO3HTjvydOXogYi
 3cWymMrBQ61rrhlRvuu4AZwENq15RFdjMp/W+LUEt+sHvW8Tvgp1k8YxsseOLWPlcrJalrMi1Qi
 tx/P88ceIc8UOin/pBYMrMJVuNgQwoYPeWrS6dD0hhnatL2h/0Fgsh7mqdfhlEPtHLqDP6X9BVD
 W24qfvMWC6UMv7j0p5CbGlY6RlFqxoos101CL+ZuQIfJPzcsninkiBXC26AzY9A+1xBrRNcTZhQ
 sUcgvVwi4Xa8bmJJfVw==
X-Proofpoint-GUID: yYxsuCzGvPiX32up2ooN0W2-mbHvN64k
X-Proofpoint-ORIG-GUID: yYxsuCzGvPiX32up2ooN0W2-mbHvN64k
X-Authority-Analysis: v=2.4 cv=AMxnnMPh c=1 sm=1 tr=0 ts=6a3e0bfb cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=j0w3eOB3VtzsIZiBwfcA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260040

Devcoredump is not enabled for ATH3012 or QCA_ROME, but they
unconditionally populate devcoredump fields in btusb_setup_qca().

Fix by populating devcoredump fields only when BTUSB_QCA_WCN6855 is
set, which marks the first generation of QCA BT SoCs for which
devcoredump is enabled.

Fixes: 20981ce2d5a5 ("Bluetooth: btusb: Add WCN6855 devcoredump support")
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 31cbe075edc9..0bc7d7b61b25 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3709,8 +3709,10 @@ static int btusb_setup_qca(struct hci_dev *hdev)
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

