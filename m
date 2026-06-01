Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265D33546DA
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 11:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780313558; cv=none; b=BWZ//N8D36sWi0a46zOyXM0YHmNk+uJ/UQNQ2OiOcroSvUZxnv1ANT4z15XhwdlbGbU34nZYjxmu9MQb0dpIV1nqRGNiowIi6FhywhhLPO6CSw2Wl0YXlY5C0/PKYUKvpx/vYlKWHy6EALABYuosU8+2B7bJFpHcjlNtzK5NmDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780313558; c=relaxed/simple;
	bh=C/oJL4OXMPAkCHROnwSUjkyw0/H3oVbBhabNzweM3CY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JjQ1I7HZeNj/aW5+HrufbCWg1js6bTXxMPEzgNGQCfXXrMO3QXx/cUTJWXT7wPiaGtBBc/RXJH+1nI5FvgMxNm4l7uFIAjP8BLdnWowWMdrjB3mE6JhOdR95+GFG0Otdz6+Hw0eLeJe6Eob9+NpuyVc+he8nChzcoY6y2Z6oI0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YkbJ8Sh0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GdUQlsCe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YkbJ8Sh0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GdUQlsCe"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518dmGn4110701
	for <linux-bluetooth@vger.kernel.org>; Mon, 1 Jun 2026 11:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4k3hU31Qwy98Fe3cp1M3dStfljplsWIx3TYT5kKMZUs=; b=YkbJ8Sh0wzPOhfx0
	4qVXBegwBp3Vq26ZiDVuxUQNQur7AoT85bcqNcV3V+TtzROwcM6XbNoi5Np1oKE3
	MOvyc8fXBu/U1wyGLvowh0OiEbUNJT7S8TpSPd+4QDxBAXfjmHUq/+wHV+lN2uqP
	FqFkEO5VbYhXgFbs3vDZzsXtHfTYR7q9pSsAFE3Vd9egJmHcOguM8FGLKbkRlXVe
	nZn8a/27IlTpGEXVECVG3BUztp9H41gUuO+k2G5+ubWshkI1MeLyvjErQig1/dtW
	k67IUqM9N4uRBoTPVtYp8ys8/fQa9S2kIG2CMAZfnbgU9YFNANvl5jxpK2BLsPIp
	zAUfYA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6s3rnb0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 11:32:36 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-304d8f6373eso133745eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 04:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780313556; x=1780918356; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4k3hU31Qwy98Fe3cp1M3dStfljplsWIx3TYT5kKMZUs=;
        b=GdUQlsCe2uLmvmoK5CCHsPedXY+JI14Axu5x3h/zEvYNK5WBRghpHMPNrgyks7gb78
         1in6XPRHt/6fxjCnux1vu4xlEzfslE2I7W0YYwfNs1Ofh7jp9NmmlaWk2t2sO18ffEPE
         A86pevng1Gw+hH4kmBJEUUTtSghC9eqNHArK7hKqMRL1Rora7e7EHogjYOxN1qbZA1th
         5jQHcTJXem4Mq91iIzMSomj7sgaR/Ug2UIp3q7keTkRm7vbgMlTiAzceZAQZwna8KEA2
         S0zCQ/YHrnXYB7cYEmPNL4BHPCV+69wzMNeaxO5vSkkt3K49Tj+ZDsJZ1j3+q6E3KnW5
         nLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780313556; x=1780918356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4k3hU31Qwy98Fe3cp1M3dStfljplsWIx3TYT5kKMZUs=;
        b=DN8bufVnyhDJiwCx9D4eHwHXtYvQP9DDJVZWfo5qRElIhUwioW17VRyLUvMYznCh83
         Uzn/iyD1MeRgVp5xTa0vTIlg2eQLYcYc993PxA6+R3F+rGLi81ITyln9BJQOABoqNdRT
         DkQS8BBlXdbr9rRKo+Z2iEUCk1nkPSbwvkStJnFruvmMI5O32RvoGSptytWiIP08tNRr
         8fL5M2C9qvWWV0lxD1oeU+iLcsNYzJwcslSwCL8TCjSfBxt+nwyzRWAdrs4ALQM5xAdo
         Q0ZE2ySxv6oWStS4j6v/O6W0e5VJR1j/dvcJOnvEjUHciYCMcV3zp5UpXv5Q7zV3SvyE
         lm6Q==
X-Forwarded-Encrypted: i=1; AFNElJ8XYcpcwqb7SiGPYGJZfSdmwTprB+WLVc+3/gc4/miVnnNdMZtR4R+F2ZmD/Fdak/uzNVV+qm8f02zc8fIQw7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjsOXgFMmetFA8K61dXdOZpP9A5KqyU8U7td09LEz+VCFgw2jd
	7OSBTjB+Ci+nVdMHKfoPizTCrBHLJCgH82A8wMIfywEVBE+7/no629Ok798uOr60YhGADkJ2EzU
	jcrslBK65k6z2qOrLb0vH3ZSrKqoy+Z31sDJVySLiDH1dgJF3pZR0kU5o3AMjBbon/tC89Qk=
X-Gm-Gg: Acq92OHwsuvafT+/RL++LDZXo6VbQVf/VhjFgegWs3epnyR651JiAQMy7RvlKJZ7U+/
	Mm5XaQmR16uopk6CuStGYuE1Mc5tE4rrphOllUKnPmvTjKQZ8ZRAa+NAz+BI15cEbIvqIsJrEez
	WCT6rzSTv0Jf6nGysZv9nib4D2varaGMWl3qCwFuPZa8Ql5SRfKCmX8xXfiMmHYHh+7cYJxkw4X
	30FGCK7gELF6uMybAXcbh0PutP6xjrpRLcfRyOooWLkyrUhrJ+hYD5QZWMyTRx5cEveuMSynLmu
	VfuEIxKGbWRU6AO8nGd2a8e5RbO/K+S5ht7PYGDJvj5SP19Za5B1hmOwjx5SbDZT2t9gUFSp03u
	erd35TuO+B5qIaOGJ80BixbVUi9FHvmrYFU432T/4p4HTlnVovEgHusHjAXTNeTJbxAFrrixq5x
	WALGE=
X-Received: by 2002:a05:693c:2c8c:b0:2da:b05a:5a7d with SMTP id 5a478bee46e88-304fa31c4a2mr2203651eec.0.1780313555877;
        Mon, 01 Jun 2026 04:32:35 -0700 (PDT)
X-Received: by 2002:a05:693c:2c8c:b0:2da:b05a:5a7d with SMTP id 5a478bee46e88-304fa31c4a2mr2203634eec.0.1780313555333;
        Mon, 01 Jun 2026 04:32:35 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2f2904sm8667431eec.9.2026.06.01.04.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 04:32:33 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 04:30:56 -0700
Subject: [PATCH 2/2] Bluetooth: hci_qca: fix NULL pointer dereference in
 qca_dmp_hdr() for non-serdev device
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-fix_none_serdev-v1-2-8d0497ba83b0@oss.qualcomm.com>
References: <20260601-fix_none_serdev-v1-0-8d0497ba83b0@oss.qualcomm.com>
In-Reply-To: <20260601-fix_none_serdev-v1-0-8d0497ba83b0@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=AP3YypGC c=1 sm=1 tr=0 ts=6a1d6dd4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=OD5Mg_is9F9GS7JlITEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDExNiBTYWx0ZWRfX4spLfASmokju
 AZNGU05lxzwjo0ws10E2cq7MEIFauiunrgDptYi0Wm+mMtv1WoNwQ2sgyUEGoPtt4IkLWRPmncg
 JrbJhql75athlW8vr5vv/cYL6/VPXLdEAa7ahFesC6iCGMZZWy29KLWw2LEcjKj484e0AnTGdLD
 LuLvhCbEatM62oZE84czncoYybk1b0i5BPicMj44P3j1p18L776S6LKvLvzPhLbtXyb00r0Fvul
 A2YTExWNxSk0kMydfDColxktZaTTk9MZqZ3ZgFLklNFmCgdlqeNhsci8Oo4usmgDodB83q+AVEb
 udkH9qo1MB2q8kIQTlqL21aDfQ9KMZeJDuvFCwH4095BZbsT27owXUCKKvz8AX7mqKBcRVOVOWy
 RWwkL8asl/mQNSg2aaaxQ3G5gHEGbhIkx/sNnD8otr8XPaGDvkqGUxoAv2rwSB8fCkTPKtXoHrD
 RAc9kXA9lQL0iTIPHRg==
X-Proofpoint-GUID: aiANH_S-lxJzWl1ICXK7nniYfRHHEqGp
X-Proofpoint-ORIG-GUID: aiANH_S-lxJzWl1ICXK7nniYfRHHEqGp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010116

hu->serdev is NULL for hci_uart attached via non-serdev paths, but
qca_dmp_hdr() unconditionally dereferences hu->serdev->dev.driver->name,
causing a NULL pointer dereference.

Fix by guarding the dereference with a NULL check and falling back to
"hci_ldisc_qca" for the non-serdev case.

Fixes: 06d3fdfcdf5c ("Bluetooth: hci_qca: Add qcom devcoredump support")
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index cc7b34a61fa7..244447195619 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1028,7 +1028,7 @@ static void qca_dmp_hdr(struct hci_dev *hdev, struct sk_buff *skb)
 	skb_put_data(skb, buf, strlen(buf));
 
 	snprintf(buf, sizeof(buf), "Driver: %s\n",
-		hu->serdev->dev.driver->name);
+		 hu->serdev ? hu->serdev->dev.driver->name : "hci_ldisc_qca");
 	skb_put_data(skb, buf, strlen(buf));
 }
 

-- 
2.34.1

