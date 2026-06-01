Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11A62DCC1F
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780313555; cv=none; b=r0QGpixZTqqm/i3KFoRBLk7FahLqjmgYZnnd5QXfupAg9ieAggJ/w6F4/89ScZfi4RzSs72QS2rHTXBRqfv494YgiIHGE9jz3EL50ocbeKBRW0JJo7ygrVOXaWNu7UYivPgNtDpFB389xUGp/rqcMs5MuMmMhhHsZi7BworntKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780313555; c=relaxed/simple;
	bh=7uPIu3zxNjDZhzrxQXN/k/lySRwSmLe4eW4Ajr8rF3I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fxkf1YKxwileLPoXIlIyfIAxYsHcnA7fulmbG4t3ICikdjFY1qYNRxiImudFhB/O58QrUlr8pBwI0a/QBLzuZxYh07v0Qo7jMz3lVuN/0kkHdNgg61EkqtdRGIkUsD9MZIcX6Shr2p4UeKDyyiGbjUuHNQxVzEaZSfU7R7TRFw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gm8e0jxQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P5Gep4Xu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gm8e0jxQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P5Gep4Xu"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6519YAbo3372736
	for <linux-bluetooth@vger.kernel.org>; Mon, 1 Jun 2026 11:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xid0X+0MWRKmVl/wV1IjeE
	IVaqibNbl5MedpkU6x94k=; b=gm8e0jxQTCmwjPxTX9kMSfCfML6dUmRzikaydP
	GRiUGWIn0iC5xobcbwazNvChWGhaxBJS/QdwmlofpL7eAONuH5isDVldnjYQbCUZ
	GlQTmTzBSWYlGa6vb84tRVX3/Uh26uxDN4bGmz17MEQlhRxInrqpg6Y4Rdu7wP4B
	9MXoFSdXv3PEOSKrR1Z9kbojEF5Jb01eIqnmhW8o6gRIY72Vgl3/Ev8NH14AL6ze
	eUMf1QfCNtm/FmP8D2C782h6MzEgjfgSmDOXkmbvjPr5GLcAy/XkXc6Xn/Gw6kBz
	hQCrDAMn5W60oZj4M4JjwBMd/zXIqMhak/hT/J4KWtLiWsFg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh7jh8fa2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 11:32:33 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-304d063f80aso227807eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 04:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780313553; x=1780918353; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xid0X+0MWRKmVl/wV1IjeEIVaqibNbl5MedpkU6x94k=;
        b=P5Gep4Xu0PKOs6Ohz3UZzr0Ne2S5HiF4ZfTZ2eKdPVwXyAwVj6XxIHjteyRaI1jEDH
         z/Pk5OBIFv3c5kfOQ7m46wS8jiLh+sI+FeS82STC2t/mxp9TfwjOD+71e62vvfR7+QfE
         1G7rPLeOJEWE/kV16cjesboEbOEvYCHKApT/ZadhtQFBm8BsT7RoGuOr3uLienYoTSHU
         IRk6k2GuiZD6y7XnnxRU7fgRN7ScovJx4OBJ5GlyvzgvaQKEQaLrAQYyFAAnWXhnIVgs
         JKjme4JA5oSNxwpK4HR/5165VYDX93un0tJxZZJaqO4QmDIY3nM/NdnOIP2GBYPtcGo6
         JGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780313553; x=1780918353;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xid0X+0MWRKmVl/wV1IjeEIVaqibNbl5MedpkU6x94k=;
        b=NV6QD9RpeZPYfY1TSKTl6IWm4uZbL3WX0PWilEdLetW1UDLaju6SDyygsPZz1Tpg7V
         7VKFUabN1hDjWqvdHUnW/asyO8f2gMAV1m6Pex92UlgYfWWVRxX4E+iw4BmiL0z919fY
         a14v+eNwXhNJ60DD9oTgC5RtzVQYCaHc560NwhG9+k37mnf0oUlWr1ul8Tgveu9o2fCf
         YL/xd9eCGLJmxzRHsTKIRFp8tz0jtrF0Yi2+4f8zTsgsSsNAB5j6zwxnzClNqdrJXCzn
         6T7IC0qWKAAXzeRKeW/zpYxBzm3IjkRdtoUltPt+f9P4HkQCH/T1Jtlo9XpQWHg+H/Mr
         az4A==
X-Forwarded-Encrypted: i=1; AFNElJ8PE4qaY9UgBugh+ODN2YILQzz4y02rfzEB23CQW1k6Qs+zcxKCNrsAiaVlhJab8XGJFVNOrlpOUIE8FwV704k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuPifMii78GMLsOIEw1id1qJb9dOJlDvUxZXEjawZjsUC5DIpK
	pYufD83UF+sXvMA0sSypqIonjc/lskEMIHSdGzQ6iuM1KZEHG5CX5Ka1xzrjDWKOAfNsUbuMYBR
	OuqJHzXPvpkMeIGH3Dc4f8ioBhBmdYRI6fKWyWONFOFsPyOPNIm63pmSHNTd2YmCv2CCAKHw=
X-Gm-Gg: Acq92OFUbAzdgeOJ69KcfPnRzfvSSmQvOY1wzSuopqBNKQEYhXrYf6hbldi60uceS6Z
	xRaq1+mm89rYsIh0vQV353cOQBtGlPbhyIAg7dQA8xcKYTrtq10RCrkQgoGcf5L/GWp/AlTxQ4w
	zj47KG5mbcyQvVyvRgVwTO/7+PEOhpqQNFPn9zTxysK5FaIzyPNcvuzxoMpzAinFLUjT7T0jqLm
	6CFj9U8yY/hUY2AlJDE1N/ujTLuIk9zi4RAWuxTShZJ+tV4Iw+3goPfro2uTuO7pN7RBL+CzdrQ
	basuVzOWbxMKjD8M5jhTyCvmmkFjBvVaoo5Cohyri6FeM33FUdXoQ3zw4sppgVD4uReUYemuATD
	mk4LWeQD8s6w0Z+4nfXNDcrO0xSJdwQDhLGGiwczhU+hdir6xkkk/o3yQzx/N0yOR/q3FkjPXkz
	ATCkY=
X-Received: by 2002:a05:7301:688a:b0:2d1:9b35:4f03 with SMTP id 5a478bee46e88-304fa6a2df3mr2157958eec.5.1780313553170;
        Mon, 01 Jun 2026 04:32:33 -0700 (PDT)
X-Received: by 2002:a05:7301:688a:b0:2d1:9b35:4f03 with SMTP id 5a478bee46e88-304fa6a2df3mr2157935eec.5.1780313552597;
        Mon, 01 Jun 2026 04:32:32 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2f2904sm8667431eec.9.2026.06.01.04.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 04:32:32 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH 0/2] Bluetooth: hci_qca: fix NULL pointer dereferences for
 non-serdev devices
Date: Mon, 01 Jun 2026 04:30:54 -0700
Message-Id: <20260601-fix_none_serdev-v1-0-8d0497ba83b0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG5tHWoC/x2MQQqAIBAAvyJ7TlBDib4SIaFr7UVDIQLx7y0dB
 2amQ8NK2GAVHSo+1KhkBj0JCNeRT5QUmcEo45RTWiZ6fS4ZPYcRH2mTcrMNRrtFA1d3RVb+47a
 P8QGX1bDgYQAAAA==
X-Change-ID: 20260601-fix_none_serdev-5f0635c21681
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Mengshi Wu <mengshi.wu@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Sai Teja Aluvala <quic_saluvala@quicinc.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: SMocRTJwwN5zNAgk8OcI0NJ0lRemJkGn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDExNiBTYWx0ZWRfX1RimI/xAP8Iq
 NX212k0kLJuNZLwvrThYczUwMnELwSsnKgczYC0GbZrC4XVcw83bWm+YXjVwXzsP3/XpGbAQZsu
 Zd3PqdbKx3u/aFTdhomF1GR4IPlTALxxDZWJhH39YQpdQLhs8IR+DbSrwgXKrbX7WxmYfureUY3
 tJCrrJ0B4z7mbLVbCKAS6h5LBQt3e+1BC4cWYqvHmJzVhjLthF0/gq1dZ7tzZfbz1nkh49xd7gm
 HJKYD7PouNdw/L99IVAUd7S9znjFNRGOZVLDmfKGI2yZlOgsdajzp0KYGzouerVASJMfvIg7D0D
 USQQNbFcPxwumwGJZNQIjn4UL5F7OUUoYFaMWs4wCpMEefvPhSXTEKIpt/z/xWqHAN05VF6DDfG
 fwiUe/r/xUrE1OoEnC0tkA4ihmLmOU1pNMl2nMYb+kam7vINvKimzPU7xFThhxMQVBZGkHThvUm
 YbJQpTDAIudbULyoTBg==
X-Authority-Analysis: v=2.4 cv=YuY/gYYX c=1 sm=1 tr=0 ts=6a1d6dd2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=_MtBovt6BdkQ8AjZJCQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: SMocRTJwwN5zNAgk8OcI0NJ0lRemJkGn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 phishscore=0 clxscore=1011 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010116

When a QCA controller is attached via a non-serdev path (e.g. hci_uart
line discipline), hu->serdev is NULL. A couple of code paths dereference
it unconditionally, leading to NULL pointer dereferences.

This series fixes two such cases:

 - qca_setup() dereferences the result of
   serdev_device_get_drvdata(hu->serdev).
 - qca_dmp_hdr() dereferences hu->serdev->dev.driver->name.

Both are fixed by guarding the dereference with a NULL check.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Zijun Hu (2):
      Bluetooth: hci_qca: fix NULL pointer dereference in qca_setup() for non-serdev device
      Bluetooth: hci_qca: fix NULL pointer dereference in qca_dmp_hdr() for non-serdev device

 drivers/bluetooth/hci_qca.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)
---
base-commit: 379b101059b44f64f6c5c022724f880a68fed15b
change-id: 20260601-fix_none_serdev-5f0635c21681

Best regards,
-- 
Zijun Hu <zijun.hu@oss.qualcomm.com>

