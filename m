Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3923B8958
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 06:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221687; cv=none; b=QNvT3ItBPM0R5OuFrGiiPxVoFe5ZCEAY63y3WfHFxXiwq+/bZ5gSD0j4n+9vVGoz/XZPk+UkMIXRjlDa9QJhGa04iAlAL+mlt8IN3kBepKkLqb5ZT+zeGiN1cS6l1FzIk8hv0UysbOuOnXQq2tJGFCqYLoAQ37LEhPsrBgFRfxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221687; c=relaxed/simple;
	bh=PljwSokI9I7bDnWbnOYmxo1OjA1Gvp19xAtinH09i98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tcWVEKLEv8BNLKaZ6YCoGBC3LWXyZdQYe2lkmjH/XY9OYWchvCdoVbTXE36Efc2O0b6nB7VffPtxM3UG4xYa9Q0K3W+q04zTQVdqR1LvBrzRU5EXDniWeuuLGzwRP0UAj19cYP32DQZmnb7ROPv7SgnMhvEVEYB0GJUYVVw6DWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J3xQ61Bd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iudlhZnm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J3xQ61Bd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iudlhZnm"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S3acah1527475
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 06:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eKCGyZXLs+8bYrvXbjrF48hNb2NUGBExhweDO6fIo/k=; b=J3xQ61Bdo/WLlcB2
	ESFRd8Cht3UigW+TBeERnHi5tUiAnIOiVJAlG4irOakIqu5PFuXC2Dz13AgamoiZ
	70JpptXGR6CDqbv1GZdpn4q7Rb2yg1ScmsPV4ZyUs7nXOSNyRJFiQ3sKXUwjlvSi
	RaUqVTX6fJJxSZnhROXyfq+jN3iDrAJYPN3CkYJbq8ZqtHKYeol3o6OiuFgL70SG
	qO9Eo7iCcGSE3xMJ+Vn8x9RwSLH7O3mgwFRGrV+0wXLho0LgVT99Y9kXvXfIrVRQ
	cnbE22g/mcH6Oisb1mZPa4RivEjZoxwUZdV5X8iTBf09AgAeng0SpY2sagnp8+Yg
	CxNewg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbn8auvw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 06:54:44 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cf2308ef97so1421645ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 23:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785221684; x=1785826484; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eKCGyZXLs+8bYrvXbjrF48hNb2NUGBExhweDO6fIo/k=;
        b=iudlhZnmfb8SpQJWQ7NDjEDnf/NGxwixGB1czkNrdLoQYqcTPNluYrgk3/TXvAYOeR
         BrdnM7IaO95Qo3SJnqNb/thkCNCSBKGiIbbHlFmYx2ES7JCdLBIo/Dx2Y/ObEcj4fnAn
         VMUsB2FIyjYTtBGSeOrG9mgwK7794XxJpb/mjUb/yhNi7+qZlkVWVlPh4l205S+w5xUC
         y3G7fcByArwiYsaUsU4F1iBaBACNGcSasoRYXcn2zJXRT2/z7SeDs4uw2Ba0piey66xO
         JDCRt4CnKni8mHxtLSTWExN9GFea81FDq8Pnl1z7D+coP2ObrnZd/gDXIuXARWlMFbNW
         MuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785221684; x=1785826484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eKCGyZXLs+8bYrvXbjrF48hNb2NUGBExhweDO6fIo/k=;
        b=PaHuG85iOb2ECt81yz0fyGLg+vv2na6XAmNJ1J3Oln2QsmV1PDYHxfk8eihuu9FFCo
         GXUr5K6/v5eNL2UKbAcm6Fr6Y3XfpC0ZWAzU7G4zaatzdaIDU8JvwJlcx1jqRK487hTg
         rZAYjPuzr7krqC1ciPuUhFm/aYHgBWe4QD7FEgYp1gE+H8VOnkEoO3oyeKTxB0U8Xbof
         D0SIeHg9dZL8uLEocJfisPBK6we5F5XL+V0+eNXZBoVv+F3PyuBUIWewvoqJXWswOLUz
         bajxL+CNVw9lX7RlIJ4nm7GFWJE34cutW8Ks6DNrkSSEwGuJUz0dJc0WvMf2FB5dJqEL
         z8Jg==
X-Forwarded-Encrypted: i=1; AHgh+RpJmmPnQTu9PtsiMljY0tfPBnYp41XDaStqxQoCp4C6sVvZEvmu7ept6DvdAo+8d1Ll4Eyp5utw1itNdLFOYgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpLDhvsGIOM8q3Cty1SucUBtVKkApXmh8a+KsZosGrEd1hL42j
	ATZQlbPB/30MNp9+aGW9JM0W+nWKldj7fgWRAoS141MbwEonDT6Y99seG0g54RUSTzHlGU6a0W9
	cJ56iOQCbsdLwz8oh4w8MDDCWHy7ADX4lroH9olsRisZHHCSelHJ1OQ7zaYMDJdHX453XqP8=
X-Gm-Gg: AR+sD11JwtG0eJ95toVEe5AFfE92vZvwyQxG2g4DSlV3U1c8Fu5ZsH3dnV2BxRsFSj/
	h/NTfjOpCqmxyIaG8559sjOpkq77IE5pogTNH4VaCAZMQva3XZPgrIk+gTcM5k7hbAh/ray+DXz
	Z6+u3YS60ZBg3VBZ/DqqgNoVN89Kwd7yWHXTCtHY/zqtdo/gkPTtpdKkhI1L7fm9SZij3MO+OKC
	REGRcJ5Mvl+gKi89sIWcbRIK542OxYG7mxoVP1i6FqQdqV2FQ6k7KEycm/1L5hsP0PKvRf2JYTd
	AXHrimr+e5ctO1omZVvZwSgtuG/lvOkQdF5nkrtlgPwmNh/wD0c0R8bkUzNJ+gt/pcjcZ7YOzxp
	iKB9pi/cI+P1BgJjVISM0pN2Fua5j1zGY3LtXpuhJ606rfvk=
X-Received: by 2002:a17:903:320d:b0:2cc:e7f3:d39e with SMTP id d9443c01a7336-2d015c0d818mr19721425ad.2.1785221683781;
        Mon, 27 Jul 2026 23:54:43 -0700 (PDT)
X-Received: by 2002:a17:903:320d:b0:2cc:e7f3:d39e with SMTP id d9443c01a7336-2d015c0d818mr19721095ad.2.1785221683357;
        Mon, 27 Jul 2026 23:54:43 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e2881sm46260245ad.25.2026.07.27.23.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 23:54:42 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 23:54:31 -0700
Subject: [PATCH v2 1/3] Bluetooth: btintel: Fix diagnostics event detection
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-generic_fix-v2-1-a57bdb81ac67@oss.qualcomm.com>
References: <20260727-generic_fix-v2-0-a57bdb81ac67@oss.qualcomm.com>
In-Reply-To: <20260727-generic_fix-v2-0-a57bdb81ac67@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfX/MzQVm497C8S
 pwxXnRbT5zKuQHbX5jrkA476EabsfzKjK3MPzmXgGKPNajqw95LI3o+SsRbZh1FtC5BAfCj/xVj
 I5A8gh802jplVEqIyjrjTvZm27h9eMHd8OeRmphy23/fr5mUpr4mWmnJIpl10trfWCoE0tXZLpz
 owte9R/WXzysjvAZuNuYAua+8ObptYWFMNfQTQWLfghg0vTTeX/YYm5ba//YQNFl39Tj80RC8Q+
 GhngOmiCrIcod9xWFkHTk+K/1a91UbSx/TDlNhNUqB5qWx/ed+7aQrUDuFVG4Z2AfaQzCacsUGZ
 U2S/4ruO4Tl1zjn7vAfEKwDlWONAPlfJdS853k4fwvBlLhbPOu1bTcUV4jdsdu4RLdNX3q3e1WY
 QqOYIrbBOGZyFovhQgOMErpcEORLczdw9+WQQr1EAULILjtPQmc7uctwDTR3pjMq5Rvje/EEKiO
 cWrgOzWn+5GLVT6Milg==
X-Authority-Analysis: v=2.4 cv=RO+D2Yi+ c=1 sm=1 tr=0 ts=6a685234 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=w585p4NK48lv-ZABhGUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 3PAQWOouqKvPmJNz2hiinjSZ2_GETBwo
X-Proofpoint-GUID: 3PAQWOouqKvPmJNz2hiinjSZ2_GETBwo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfX3wdrnjEvPQjp
 RjvQRc9QUiZbkdsw/LeKEWsNDDLKjR7dNZW42SSUU+key7Oy02KjvkcO/FlPK0cfkJKEYThI48t
 tGE3Lpt9e9UYDcKWeCLfIsGiL9xJ7Ss=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280060

For a diagnostics VSE, diagnostics_hdr[] sits at the start of the event
payload, skb->data[2], but btintel_recv_event() wrongly guards its
memcmp with @len, which is measured from skb->data[3] for the earlier
INTEL_BOOTLOADER check.

Fix by using (@len + 1) instead, which ==
(skb->len - HCI_EVENT_HDR_SIZE) exactly.

Fixes: af395330abed ("Bluetooth: btintel: Add Intel devcoredump support")
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btintel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 680f96c188d4..b800379f91cf 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3827,17 +3827,17 @@ int btintel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 				kfree_skb(skb);
 				return 0;
 			}
 		}
 
 		/* Handle all diagnostics events separately. May still call
 		 * hci_recv_frame.
 		 */
-		if (len >= sizeof(diagnostics_hdr) &&
+		if (len + 1 >= sizeof(diagnostics_hdr) &&
 		    memcmp(&skb->data[2], diagnostics_hdr,
 			   sizeof(diagnostics_hdr)) == 0) {
 			return btintel_diagnostics(hdev, skb);
 		}
 	}
 
 	return hci_recv_frame(hdev, skb);
 }

-- 
2.34.1

