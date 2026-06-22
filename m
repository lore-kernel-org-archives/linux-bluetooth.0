Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA033112DA
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139943; cv=none; b=oqymZiNYZivLHUEqiaZ8FeVg7ON0YonyiAzSolZiEuG2Kpe+9qwjxkwktaPihz+ta2lP/kUcQzainpDVhpFe4taga/O27FFsi5YeR7VOH4T4gKWzJW8SH+uxhjwKqu26DZjCOr9OcDh1oMdeBcGPtsuGpptUf41WSaTXqgMAcb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139943; c=relaxed/simple;
	bh=6RgOZPClI0alNj5VtNfn1su3o46ooC188/5pwzWrl9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f2rBTXdpoqPl8kY4fo1ZfNFamsWTgYIo9+L4jm5JCZ4O4ldYQLgnCeLWmKAM4GUG+7/TKdnxWhlHoTbF770cs5vNzbStg2OrZuVTOJaFh2LEvfZNP5qHEdowAmEUYOHx3WvOPy781iXTkZ2+VrWHfjMMOsPg4lzKjrFuAMcvc6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qvs5ZcVO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P+SiR2X+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qvs5ZcVO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P+SiR2X+"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDG61R1338365
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ozqx0SScTT48vvKX3IveR+kFbbuGPWgIXovasCAgd+k=; b=Qvs5ZcVOW9com5ri
	TgaGlv0/LcqsQk+6FMF2jI2uPVnylKnm1M6WbwvxNZipbCBYdIrNxDTHMFx8rgIU
	EzVOpAYXqumMqM/nn88tDOL66VNFUF/1MZqxPQ091ndo6qQwh5bJGD1qsnEZNUzg
	NwPcxkFitpLtf1RSnB7jVEeWD5w2Iz9FTHGpZwdbx1FhOvshERNwuSf+yGgj8X+3
	e5It8Ozq+2tCFOE471dIMGiFHe6YKVwTa4N2c4WI4Ko3OjcBGx2W8hxXIikOyRR+
	QzqshzZdT5ZLbEC3A/sjRN+ZF2vexAj0EP347iS6aO8TBcv1mEX0G95RoAsJOkhd
	b7cuiQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey37h8x65-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:19 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-137eced000dso291607c88.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 07:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782139938; x=1782744738; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ozqx0SScTT48vvKX3IveR+kFbbuGPWgIXovasCAgd+k=;
        b=P+SiR2X+TDq42egcm2Mp7A5gPgiy57ibRmgEu8DEccnNdTP69n1hY0p1kguK2Wb/OL
         u5BzveTeId2GMeWE3SdFHE3j8bvpguM++5SGnIpmE9mgtuAZsbAaDYwzMzF2YM5h1nAy
         0uujHu43CrxJePJumlOdqND+V/6jVp7sw2So+du/8yRl3apskbCLqkak+aeVZjpwiq+W
         U1ugIoy9jrSWz+ucupNJTgGi2o7y3kGolZ659efeTVwj46PWEsRXCRacQarjAAUViCDh
         SgrAcvl07kXkceF83KzOevsPz+IP5QUYERZNucL2hqk8EsSGvHNgyou+4XwLUD9VwC5A
         u8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782139938; x=1782744738;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ozqx0SScTT48vvKX3IveR+kFbbuGPWgIXovasCAgd+k=;
        b=P6AT1uzT1iWPkpigw8I0h68R65hspsYUA5IulyEAIG+lXI+cOXhTMPZf4+zopiYlJ3
         CvI0Em8ZU+WT2FgJ6V2BnBZCRYvo1VL2c9eSIQCE9qJ92SJ68ucWRxJbnQaBZ6t8i3/4
         hft/eOmuRw5VkkjkuI9Z162mtvz/LEjZcpNDTWlD2f600/LZw4AVVcx0vILyz8cvKMVZ
         TQZIoEqp5Xmp1Oas4tId3jK8Zhzxg1wCXQMSH5LJyJJD5syJok+pwuyzxn6M1mUyce4J
         ag8g/bb8L4n7YEjAHlQUMaDZOOqAZxPEVTREdtlVMfo2t98dXCU6KfrRL1TjDG6/Z0LE
         HtNg==
X-Forwarded-Encrypted: i=1; AHgh+RomepRIXdD8rSfWVcEiHUdczNSZumaq/nBMvlP9aHrBWH+wkFZPuUHlF62ElNkb7pUM/3JrUCLah6uZVSYsv7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZByYpBzEzodNmgWAV9l2iuCNe9ciPH3ua6xVA/5jlOWWlxgty
	P5V3yZPLtpfa+2OzOOD++L8Z1ADp+JX4REtGxz6lLlJ9gunbcXmci4WonFQMDvY6Q2dVXIdmrE9
	G/bNbxyJ3/scD9NpvFiL54kPg8iR44fWlYJraO2qeyU+wqzWbADMNb6IBWVSB4lX39+ony40=
X-Gm-Gg: AfdE7cmZpHBift028Fws5UQja23M9s7VL8INBfVWF8qH9MRyj3a5Ux2M3165ky4IrVP
	8EDUZiA9/8b+mOh1W77+EDz5USuzIcWbyEm1p2+mODB8WRkZ+BInj7gqDVkyzWTqT5N6Mcx8sMp
	YSCd4wHDzJDKli/lnASmbNSKXjMh2pC1bskkGW2IAEqR0bGyQt5E4lLjuRl5jiLm+G+CEY0KYrB
	WDsPqEC8RDHGyzXctMmHUrYBrF4N7uIetsUqXPtFIypMnSqtUzoLir4m9RmJGmYzKEaO5bnn36J
	FL2c/RpCRGYb5HHzz+d3MG06LDBfc1ftUGa+D40Up+TKHWVnBS86PUoKWUUPiETyMyktJtB7+lw
	N15X+gL19gU4uEcTYH1n1PW8qN5uW7kJOc9vFD9Ls0dev5OZDEE7fEDf93Q==
X-Received: by 2002:a05:7300:748b:b0:30b:f3b8:3e7d with SMTP id 5a478bee46e88-30c523ee936mr244819eec.4.1782139938116;
        Mon, 22 Jun 2026 07:52:18 -0700 (PDT)
X-Received: by 2002:a05:7300:748b:b0:30b:f3b8:3e7d with SMTP id 5a478bee46e88-30c523ee936mr244809eec.4.1782139937591;
        Mon, 22 Jun 2026 07:52:17 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bddfe34sm12025561eec.20.2026.06.22.07.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:52:16 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 07:52:15 -0700
Subject: [PATCH 02/13] Bluetooth: btusb: Use & instead of == to test
 bitflag BTUSB_IGNORE
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-bt_bugfix-v1-2-11f936d84e72@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: gZRrGgW9KN2_Uf2DRbShXncitVyJaL6d
X-Authority-Analysis: v=2.4 cv=ecANubEH c=1 sm=1 tr=0 ts=6a394c23 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=HKrVEy9w7v3RiqOSl70A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfXzrS+2xMdTOUA
 IyiqKRxJ9cOxp4ooipGNTTWJJZ+2UHJtS/XFUbB+Sd+NZ6LI2ZYC9dOMAnsy7/WxEx6dBuYBaja
 DeMhDhlvlVkPsl+XZRSbOSgBUKWZr4A=
X-Proofpoint-GUID: gZRrGgW9KN2_Uf2DRbShXncitVyJaL6d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfX8Gwqaf3opsId
 EibQaAuVEqnAH5k9KnAZZJ4RAMnB3Joa/7WhH7yGyPUySJkZFhoAfZ/T1fBgoTJoELGb1fOETk0
 w+eeYQ/Zffd3P1CmRSD1vhcQ5Ix9dceR/pjSDqcHX24g4Q/478fFhE7QuSn9NdfyX1ZMxE1s2V8
 Pb5+bSJNTOojHNfSmBrUNI5DoYNc9YfkMvYhV4QUjvlJ4WwT21XXOL6cBGopmmZiP6NX9HBJpKz
 Olqdz/a5BLZpfqOHie8t1MsjTS0PEzpI+krIJ1wt3h0gIYIghzZePP7RxFK/LvuSVztCWcRznTL
 PbjWD1UZCSBXcD738pDZTtdsnP/4NEF1oTaK7rzeDL38v4Xd+aPQ3vvznyNRlQ0LXXmcMknLuHk
 g9fgYz+zXx1+ZInRwwnTI7atqxPVsLVHSx2FHM/vPFd5kYgwlE81zupdtfYhn/3Hnsm4cxQ2z7E
 bnnXXbtCK+Wd6Pw9XIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220147

The driver_info field is a bitmask, so use & instead of == to test the
BTUSB_IGNORE bitflag against it, which is consistent with how the other
flags are tested.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5209e2418493..fa6a223d472d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4101,7 +4101,7 @@ static int btusb_probe(struct usb_interface *intf,
 			id = match;
 	}
 
-	if (id->driver_info == BTUSB_IGNORE)
+	if (id->driver_info & BTUSB_IGNORE)
 		return -ENODEV;
 
 	if (id->driver_info & BTUSB_ATH3012) {

-- 
2.34.1

