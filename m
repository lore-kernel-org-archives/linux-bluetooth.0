Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD86311969
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139943; cv=none; b=KPW7GRgkOStlq+x8VWA4HjSjwjgFU2pEFUpoOSIHfKwGtBjoigJUOqQvxDzKetXGHVP97PyaSLc+62Wj4J1UBQX1KYo1hYuSx8D6xBDC3afeWER3P1WDIe+7WMfCfxOX6BJ2qV5h3az5H27bru7zRfNJ2C3GVr2iG3qw6PkCXPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139943; c=relaxed/simple;
	bh=hI1Adll8Xtg9zeRoObXfZt9rtarX5UDkjpGAevFItDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bbN7Qy6jkWh6jLU7BWNJI0muGORAvGkaFPkyeE0FpunNakpJo0NLGfj50UeeACl2IVhcbPMvn9hp+h8PHszfjIFOAplHhsujIcFHzyMPbberwsKZxaO73J2/C22cOVtPn2Qp7m7kpx1JfkMEwjXnk8IiAos1mJNWD7GpoExDfZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MbrStZnO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DwjQGsOY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MbrStZnO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DwjQGsOY"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDFwAc776134
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9qTpsJW4i6FZVN7IQaAntzbiIZCTVZkxFeHhaQuF08k=; b=MbrStZnO4MIE2uqX
	fl4aUs3n5L5zPtAwPPadkTaPjqElNxq4hgsPFm3IUUtC+dkYki2m2gDItOqebx/o
	cOnveLprcnrMKO2o6km6gllvVZj7MK/Mkjq/TXPdWy/EeM9GRu3NSmLppnzMv4Tv
	/Jp4XWcNhRlLaZFFiHPExVcKdt9ONBS4jx0Jq+nbsSQXM5DhiRJD3gV6KQEmehWR
	sAwI38aL2uU2Pfgjb0lpVinzvM/lympPuZisoOkV3/nMXra330f+eurgoclZnQeV
	NRbX74ATuH1QihyPChy2FZD4VO6Rn1LbD7rrK2TyoL6Re6dMF530RxlAcPNrrlhF
	KW07eA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yj90d8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:19 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bfe1e3d45so537096eec.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 07:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782139939; x=1782744739; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9qTpsJW4i6FZVN7IQaAntzbiIZCTVZkxFeHhaQuF08k=;
        b=DwjQGsOYdwt8T1KvyxqWdl38YLVw0wLoLdnNe1ZBd3s803RDxvf7KCKMcUVWuAfq2Y
         4L9fyejJTauuMnuMe9TT5rRysX2F+QBLxYoum76ybvAhZyZtQ74nAqjmxEL+57I4mn0l
         WTmHlhwWN0YirEX06SbIsqXVlq1YonKPRQ5THeQWDyhDuN6R8f6mLe2gks7n6PjX9RYd
         YEi+/VuSbiU+xVJI7Q5tJsrS5PKzKbYzN7V7oeXN/GJvVsEhSuvU4+CxLcyiLHxYV4ge
         BDix/iGme8GbwqXmXcMengJ/E2kwwQbnPDWODCp4Jy1ZvAQe9l0fqtqgqJbAYaCuHZZs
         f6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782139939; x=1782744739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9qTpsJW4i6FZVN7IQaAntzbiIZCTVZkxFeHhaQuF08k=;
        b=XOAT8p9dJXZZgZhVwB4OrJapNHCkvmpMRe1RUbO+tmJFI+CGFQz+N964BrZQd/aOwb
         L2UCgP2w/YvJtZoQ8dqhLZS/qI7zo1wdTDdsZpH9ospJplfYlHhpiEE9x2YOz5phgPlx
         m2KpNj7FOEl2QSsgprxQzlEHkhh7JOPLZxWeVkFGp1PiNnmBBS5cpvCrBJyTeO3XOHh0
         r0ClC7IgIeKp+sT3TtoHHjj/lrNs1kq95JOill70fXSm3Lu7ijolY2+Qi86JOkkaWcoS
         5xB89N3T1N9UpxJdFXmfHjNnINk4i4J4/1RHpxtZPHmaOEq5VezM3EitiwjKCaASr4QZ
         uRgw==
X-Forwarded-Encrypted: i=1; AHgh+RrYiQ2niPq58Z+e4ZqEPioOQofIfMTo6QjBN3HPmlNDGhHhYuTrK0f/cVHE28Jd4YXUVFrEuGvt+FDUOSbzPc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzZFtUXw8AC/6DNdFqF9zsmuS0H3ca/ZN/EJi6F/ji7Yu4Hu6F
	hT4nHx6WWFZIoPJpi8EJiYgsKD7rY7OOXrTW432b04CKvYyI2093J58oft8sEUw0r2bpVCerH9B
	skTAgymkEm0t0mmnc7r3N9Td+oJZ6R7jhtaqstgpJlrwLznoZEAC5F8LQMOFTSQHNI5viw7M=
X-Gm-Gg: AfdE7cnKeVJfc0UTOZ2Rye/mbgwyeqKKn/K3P4nB8CyE0x0GGbzpdTF94Yhhs0a6QyN
	xmIq8zFIDf/g0Xi5tGctSRzo6SERPguGIVciZJs3RPaPHPHzi7KoLYMgP96u31mSwB3yVFPxXy2
	CV14MYyYM9cMJ04I7UJRi5wzhw7LoBqQSy0BznS0ef99zLNcjflOg/+49NW1Y21y84BlfVsoIdS
	vPpQU4S3eOlCqX/O7KcacIa9sYLGR9HoQs9WWRCNwiOkzZqT88WZhzMAO+YSzVnY9yvMisu9TWV
	rg4rqeqJncqDWXy4YmJLrFgsh77KybeBQ31rbF4a+Ft/jcmvfUNXM65dI2Hixpdwh80ETYeirHX
	ihSRf0j82bitDOcAyO3WwdTNQG9nbuAcORWMd+Qm2Rxp+lZwGKJyMqSuMvA==
X-Received: by 2002:a05:7300:e7af:b0:2e6:b55a:76c9 with SMTP id 5a478bee46e88-30c177c788fmr3746044eec.0.1782139939065;
        Mon, 22 Jun 2026 07:52:19 -0700 (PDT)
X-Received: by 2002:a05:7300:e7af:b0:2e6:b55a:76c9 with SMTP id 5a478bee46e88-30c177c788fmr3746025eec.0.1782139938537;
        Mon, 22 Jun 2026 07:52:18 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bddfe34sm12025561eec.20.2026.06.22.07.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:52:17 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 07:52:16 -0700
Subject: [PATCH 03/13] Bluetooth: btusb: Record matched usb_device_id into
 btusb_data
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-bt_bugfix-v1-3-11f936d84e72@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: Q7S5NjAEnjFiMEw01qTtrQ0811RDHZrg
X-Proofpoint-GUID: Q7S5NjAEnjFiMEw01qTtrQ0811RDHZrg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfX4MEKdmP4FyuR
 hnxSoLZL1kATbbYMhHVdEvjKodxKQPWjBhKWQkaVhDgAhLOc9fiHHx/lEVSkkZ9yeElA4zfOCoW
 BvKHd7CMJUKdm3zd6J1cm28WL+yajNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfX8iZsDr85RdWt
 qqaD0H3tNkQwF/LMK5mwer1KxZMjOi38G9BvjT5XJXnAFSey/+Vkz1P6zyBQWQWYPM75LDCIJaC
 OIf6Fhtv/yKvLMxtZsAPeJzBsRVoro9h/+SGYBrv6x6wx8/tGQ+3JrvT/65QfM+DaqjiWAfAXqi
 aaqlfFOL2HRmP+G3guZ506cG+v2UO1JvgJx3E34J99+ctGV0oztGrBI6L9wMscs1fjuvGg5uSqw
 IypmYZUqZZ6fwO+sw9MC8leAX5ysq3sUO9DX/oPo7YCZTyWWfZ3aBxuIp8fFqhbh7QXrjkelsgx
 dgnzy56KSqhgtlJZTrMISczZOgcI/he2YUaDG/obC+6xcUQVfc1xHNAoeNuGIdvK4k88vLWrOjH
 imEh3A5uZtCUqQkKqFwWo2w7sOTNZ28LOgV5tZ7bOeGX2YyNFvW2wZ0ep4nMNRb9bUHhbw1OwMt
 vJvRGWXOMs+S6MnirCQ==
X-Authority-Analysis: v=2.4 cv=YLSvDxGx c=1 sm=1 tr=0 ts=6a394c23 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=kCdYwly7LSaV7O0ZGUsA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220147

Add @match_id to btusb_data to record the matched usb_device_id
which will be used later.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index fa6a223d472d..6a90f012b226 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1012,6 +1012,7 @@ struct btusb_data {
 	bool usb_alt6_packet_flow;
 	int isoc_altsetting;
 	int suspend_count;
+	const struct usb_device_id *match_id;
 
 	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
 	int (*recv_acl)(struct hci_dev *hdev, struct sk_buff *skb);
@@ -4119,6 +4120,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (!data)
 		return -ENOMEM;
 
+	data->match_id = id;
 	err = usb_find_common_endpoints(intf->cur_altsetting, &data->bulk_rx_ep,
 					&data->bulk_tx_ep, &data->intr_ep, NULL);
 	if (err)

-- 
2.34.1

