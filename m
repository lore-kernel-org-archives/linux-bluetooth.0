Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC33C492E4E
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051211; cv=none; b=Mq4+HXVs3QYZ/ys4Y7MUkGEYtCfVu3IO6iRXWU2KX0d84yx3pQNzzhza686I5DjQLgnk2+xFc7oYUk3oxi+QSKWKxiVX5N4d/fBbRMdMLdKG/EhQUQlZRfQvKUj6BEHZVJg2MOLhKy1X8fZpfPfMi7JZB543koeHL77wi2L/k10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051211; c=relaxed/simple;
	bh=nGZreA1amTgzCPBA3pk9j3iYkm570B956O1G7sPHObE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ka0k/9q4gxYCGgi0wJ07kf9GSex/d79G3e+3v0vTDsQsllcPJ1uPIiM7fNjWQtcUYaeGPQA78QmQAan0TQFuiSQ62ED+rgGtRt2nDf27+3XeBTOxLYCj4uOamIjXhZw2joLk/hSB+45+Lw5nLxdNkfszt0av8ITs+q7fUXNyh5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cgFqw294; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gw32IV3R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cgFqw294";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gw32IV3R"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AC7jSc1241987
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 14:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KgjPny+eSGIgNXcSG5I6onSrjp3K5wwDfeW3fNEHLX0=; b=cgFqw294BhjbeoSA
	urLg+kN/HPgn8wns9sFJMAK7dJPKDSMZYpIvMx88f5TGpUrhpS860/I4//WfdkP5
	bEvU+PEu3H64QlO0tjJV/oNQ17ozfmIqVIxayGiQBr7m3wKwJl1RxDa16iAbD2F0
	VkyyGEndPCz2zBNWr2hWO1LsgRiOkCe8Q02wuDuY42nU0csq4SL71qdj9l24JoUc
	2UAaalOkyhXv9spqJm+mothX5nViyrJY0RvtoVBaEO0sdcf8ryO4F+Ydi2Joo5nt
	F75Tpy8Y8majNexw6vAzakqxt9159+y6XJkDy+Qn+CMcRptHUKEy2jwiubzw+A/1
	G8yFjA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkrcjstx3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 14:40:08 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e9e8723ae1so653281a34.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 07:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789051208; x=1789656008; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KgjPny+eSGIgNXcSG5I6onSrjp3K5wwDfeW3fNEHLX0=;
        b=gw32IV3RSMnnsvzIpJ53YwC/5v5aUVVHaNhScEAKuhEVyZEKL/pzE3ISoJhzvAzYwh
         iAr8WUiPLjaBsnimOIbDqsc8FztDNH+WqDN8EeI2xojA/Gs/i1+n+GYOVf1b1qG2SGUi
         HK7LUIZqjZ3LV5eRPZPi++t+0yKu5e79gkmEkdjW29mczUyLeBbg9QqrtFNrjjETtZ/l
         y/RgAwlb3kT6yj7qYizJUrGmuJ9EhHG4OpBymzx3ygNise/+/y1h86M3UY3xtyWeRCP8
         oONiPd8kQGepDxYWly/e7n7u8YobjZA2PHeXU1A8Pm7y58FlkLnRfSvEGzS6+mdbq8ad
         1giQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789051208; x=1789656008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KgjPny+eSGIgNXcSG5I6onSrjp3K5wwDfeW3fNEHLX0=;
        b=CRDVnuQSuNQz70AcI72p0W0tFOGys2sZ4e8i4cIfM7Yj+i7ZeZj+6hExJP10U1ABrj
         Hpb4UwrSg3eebD6rC7FpLaysa7LJ9JwB6nuTXcEo06bO7+vCnZgtE4R2JhiNXqJi4Uuy
         pOAi4HvA2VHwg5DsijBiwUGCOZT00n7sFYoLvQa6zY0a1yUv20zsYd9TUSFR2fYHh4IM
         zg8cNTDlRjwPMkXM5HlDXDng5ztiKKyhBd4K7rPcst7T9BIJ5xdCDM4CMD86NifBjlBT
         Oso/N5uPZ4N7zTdrDP3m0QFIV3j/xearbO2Uu+bx3WgQrMEkV0+rjdJ7aIycCLpWO6yi
         xHVA==
X-Forwarded-Encrypted: i=1; AKwUvByF+15xgi4jUcBMKjWKKvhaV90+6e3h9O3xrTRfs4mE+Jox4Atxch40n7kh7jvBsVtuHg+lAFge16UGvOfD89Y=@vger.kernel.org
X-Gm-Message-State: AFuF++mBEncAAoKsezEjCZC3iwlrMvR9GPGC91l8xIhqC++VcQ364evn
	va0XDHtXF9RdnEf7VRi5ZbtjyigGoRH8V4cA31mFPKEj9oYJDh4CrxaYlEY9MuxbFBPmTVDG8pL
	Rl370L6qmzmJliuyf+ytMt9CCSf0MMP/AocqGwh7RzRq3C2dv2z5+rnto6X4OeczH3GKQaGQkWT
	8Vtrk=
X-Gm-Gg: AYBFou300nRVeiOPkydsGgQi+hk/+TslwJOWoH0bHJzlapng+GVLcehnSkxjPehAKUg
	2FQaFQKLIFNhEKAm6mJKlGjGh6wn0Ei4K0hrj26l6Nlz9salPIXY3f13nB+HTxHs56en+SbGYRI
	XVL5aBufFXIuJx+C6GNmpWlHDWxUuJh/PC6mf9/ooaEB1JkTB9P2DjacSnT9HqR/JZP55Wnsm/U
	/mEvBG8SCCE5Yebp3aeI0O3tYlAKh6oHBgwtZ6TUTIZp/XKUQoZB04oIJovnTNd7JIugwPSUoUN
	WpHpW4urCoVrCp0DCKLxKu/3LNEwqtqKaNNo2dzW6E3oqQwfnBo51gDEgS1hbYufzlGe4bs8LUr
	Yv5ZDoLOlCsM4LSjAZHEdyVw8y3lalstQUObKTgRpkElyHsQ=
X-Received: by 2002:a05:6830:3495:b0:801:b3e8:25ab with SMTP id 46e09a7af769-801b3e8a6c8mr5287709a34.2.1789051207830;
        Thu, 10 Sep 2026 07:40:07 -0700 (PDT)
X-Received: by 2002:a05:6830:3495:b0:801:b3e8:25ab with SMTP id 46e09a7af769-801b3e8a6c8mr5287560a34.2.1789051203817;
        Thu, 10 Sep 2026 07:40:03 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7fa02cddc41sm20740155a34.22.2026.09.10.07.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:40:03 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 07:39:55 -0700
Subject: [PATCH BlueZ v4 1/3] doc/hci-protocol: Fix missing & on mtu
 argument in BT_RCVMTU example
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-vendor_hci-v4-1-b953ce117d12@oss.qualcomm.com>
References: <20260910-vendor_hci-v4-0-b953ce117d12@oss.qualcomm.com>
In-Reply-To: <20260910-vendor_hci-v4-0-b953ce117d12@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE3NyBTYWx0ZWRfX/aac5MhyA8DU
 rS/fUjyW6chFIYe9DY83+XXf1dc4xpx4aaIuTfRKQG1nh4gYO/u+3qNhQjjfQIvXlGHTDDWoinX
 +18u1P5+3yaafEGF1lmfSIezCGwcMqs=
X-Proofpoint-GUID: TGF4xwdjYBf1HD2XrispmTSyQwyAPvpy
X-Authority-Analysis: v=2.4 cv=aef0Dhot c=1 sm=1 tr=0 ts=6aa2c148 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=wa7QpaTpAAAA:8 a=zpTOe8WlNf4vmfFp-y0A:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=ehqneT2-Ts4HTEaPPMaO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE3NyBTYWx0ZWRfX5hjdVWZIUo68
 h+M02Rgtr7R29/NRN8abxoDwkN7pVWEPDe/kcW1A8hiHHxMcFKu1E1IZsFkxnnHEV/5WmYNErTi
 CEuI0G6cE/wanYnyqEQaIdMkE22dhRKxFQ0EtRZ43LuVXcDoPYKnDpS8W9TMKFZ/o/5pJ0pt22x
 T5q5Y7PnX6HG+Cuat+0Eq6nco9VghXSyylzHlQjK3zQCzztSrOwqdkjojaQYcAiE2m4bfHhaWmF
 p2wFT076WhKweaX/VleK8XKfMsBDAQtSUH5KvumhxEEYPLcyBnfsntxM0W1bV5OImDYiLU0mOgE
 cc4nUuEb8/rWF1ERjpcn2hQXwKdFRzAQnnBZ2H7ImUS3Igj3fIgjTDtHvqVDvZFqii3OY7U1HBa
 QlhSlxqOwIgW5KhkPjfaSwfHDw186zxfl8Y3cNHNt0Ycy8aqm2iRpkEI/3+tu93yXemOagPeLxD
 aSKJ8LI8bCmbvnCnIdA==
X-Proofpoint-ORIG-GUID: TGF4xwdjYBf1HD2XrispmTSyQwyAPvpy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100177

getsockopt() requires a pointer argument, but mtu was passed by value.

Fix by using &mtu instead of mtu.
---
 doc/hci-protocol.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/hci-protocol.rst b/doc/hci-protocol.rst
index f28684655842..db10b35df736 100644
--- a/doc/hci-protocol.rst
+++ b/doc/hci-protocol.rst
@@ -129,17 +129,17 @@ Example:
 
 .. code-block::
 
     uint16_t mtu;
     socklen_t len;
     int err;
 
     len = sizeof(mtu);
-    err = getsockopt(sock, SOL_BLUETOOTH, BT_RCVMTU, mtu, &len);
+    err = getsockopt(sock, SOL_BLUETOOTH, BT_RCVMTU, &mtu, &len);
 
 RESOURCES
 =========
 
 http://www.bluez.org
 
 REPORTING BUGS
 ==============

-- 
2.34.1

