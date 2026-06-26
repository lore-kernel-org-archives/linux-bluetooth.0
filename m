Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F8B3A8732
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451210; cv=none; b=JHBvtgx4dofDeohm1b6DDUJZO7fpVuFiCrQ3InLQ3q+06kcqBxAsqD5Up51fOKOBAsYf9mV0WjSNoB8txQJFLBm9rk7KrVUQ5c1c5eqt9RhMec2NuS5wPIg4Ctov3Jz8kt20BYok36aYB1fV0hCxhsYEF920LRAoJSjvNbIcB7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451210; c=relaxed/simple;
	bh=WKgBK9QgtyJcI0h2tkQjPicZvAZwBNsQSOOoAXpALN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dLLO6+Y1+W+m39AoB/TaL0dagaDpzAG9fhbJcIfHTwVQDPd6rgQX1VaWZB+TMit0MjspaSVtBOy5wpuwdtvRJOZJeRYHE0ZimdGEYANzlPHRVuv4B9ldyxk5BfNa69H5Y31f3Py9tQQ8Rc4WuVSmvPh6GT4ecMwAygQj8wcdXco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y4Jt5Qbj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d6fEV1CE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y4Jt5Qbj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d6fEV1CE"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q2ipEE4181775
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9eQxVHI0s6IYSxZbSFmI7Yut85fEmi4YSANEBHXsji4=; b=Y4Jt5QbjF/5P/INL
	n0QLmmov4PLiyn8UrlsabG5AEGxyBK8aeAZ1LOXJD0zn0zJqEQIJPZEU4NPMmEFD
	L9ndMGLSoBGaF3sA15ZIz+FyOzR76Ak1mF574fRw9mgppDPci2S76Knn7ye4k7dt
	RZVoMbpSBqMhoCPg8ib881zhmNfekZ3wgGW1G5/ZgO4q/AVHWqmwVV96CFhwB0t4
	/wjBn5e+DBJ6DmhLyYpIqFu42TUo1nrGW2tA8ORNzCuaFnoVuvScm9QSvYcnTU5h
	Qn1b6JXu4Kh+sEU+LZIASJdGBjZXjnm2UDbbB34x7+7dviesem6yGnhzsiKlRhGw
	YMbipg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f17s8jvvk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:20:08 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c8aa3ca3eso62718eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 22:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782451207; x=1783056007; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9eQxVHI0s6IYSxZbSFmI7Yut85fEmi4YSANEBHXsji4=;
        b=d6fEV1CE6Dfibm+itlBHVzPQkSGRUTShUavtCIz4GjofQUYUY3lHOAV/0ONyaOitjl
         6O08WLOrqn94M/EkgI15QnBYtQ8++aKodoqc+8Bo0i6KZHJ2Fx6D8/i/Dh4JaJvF1+1K
         Jutecj8pUVpkpi5hdB/pbYhP+eFzX+2TV68OZn0eWewp8/eSAVVKAbnYVkV0hpvszBwk
         EANB8oADM4ZxJmuaU5NN+opBqMcCM5ZTcKbiHSmGbe/TCbQ1yfoD6m5nD3MAuyA1jOcc
         m78Gs+Qg+y3zgoDUxVqt0EU2DFRro8/j6Dh5OenvaZ+VTLvfvL2WfyaYWW93NxjdaLch
         DaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451207; x=1783056007;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9eQxVHI0s6IYSxZbSFmI7Yut85fEmi4YSANEBHXsji4=;
        b=Jis2ry3WHK9x4TIIgpC/Lr0mbKiKq9t1iSV7O9+Q7GKy5zRId0CDgCfGF9VwLVs3+4
         uapO/uTv1Ekq6FyezCegzfXRsaeg7E4mDqfPlSVfFNj2R2Z1H8RK9d0jX8wtb649IpCI
         HsHXOydiGfk4vJcZm0FxJMjCBSWhxI772Hopwro2mUedt0RjjlbiLl7+zbnzxc7Fn7wP
         yJU+waeFxZ5rC5ccSWxwSPhXICnaphpk02CS84+RbXjXR29j8kivjzrltuSZlWSb1i0F
         IBtZ8AzRHQ1o3FViPuB3PqjX513IUcuQXAWlYmEmC5ddRrXscArlHgBqL8fHhkrfORM9
         RYuw==
X-Forwarded-Encrypted: i=1; AHgh+Rr0MRvZAOAzvS8K6lzshqrnbGM1+uhLXehZR8dDNfYobPo5T3HW9T8e5VmH/1oOpP6oiymZGT5Qh+tISwC1I9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxalksPRyinE44VCcmUj2Hh9DVUirVIlXooPD8RJ3emKM3mYY8k
	Th/b5T5lc6//jMR19SXJ+cxcXEL9CybLZtf3oBCMTfb4jgO6YqR1BrGeds47pPWPxffeczckodj
	jqTRpLhY3+g6QEXi0FlKa+6D1vaEFqpQe5ezzCvhktuw6RAYbKKVbZq9fB3HYV3dwwV9sIiM=
X-Gm-Gg: AfdE7cnpNMqNq4QMEo0J4Yre01u9IPMaJHUoXu3MD7+gu5LOvnwoLiGbZ3HStqqSV/y
	gnQ7cwNn4Cq7rLrE1FT1rt/NVZqSZnKj+/L9+/xCK5vCPAQjUjgyXBawh1Q6MKGZgT1t0VUQ6pa
	cqUx14W4PxeVKUvBHyI5PHupLbBR+D+i9eZzx3+mcRzlGGEdrpdXiRO3zLDdxGCMeyk56e0jRVs
	ZakxJky0B1XlcnFoAwPJQ7bkLX3agYOBGDqfzrEIFbMFo+jB+voeV9PyW0bENYdO00+nzdi678m
	+dhciszpgi1VUyKQEi5lzICNIUpiifhbBJCjfEWQHlhbYsZjpD3A1WYqRMcLyEfCDJc674P+nYq
	Ds0HWNVcea7T6l26tMEAV3CNa8QIwXygMoQn+BT+7G4N+v2nycWmWwFHP4g==
X-Received: by 2002:a05:7300:d517:b0:30c:5197:3a09 with SMTP id 5a478bee46e88-30c84d5fea7mr2312220eec.7.1782451207317;
        Thu, 25 Jun 2026 22:20:07 -0700 (PDT)
X-Received: by 2002:a05:7300:d517:b0:30c:5197:3a09 with SMTP id 5a478bee46e88-30c84d5fea7mr2312195eec.7.1782451206771;
        Thu, 25 Jun 2026 22:20:06 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4ca240sm14345291eec.4.2026.06.25.22.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:20:05 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 22:19:57 -0700
Subject: [PATCH v2 12/12] Bluetooth: btusb: Use & instead of == to test
 bitflag BTUSB_IGNORE
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-bt_bugfix-v2-12-93396a6f7d5e@oss.qualcomm.com>
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
        linux-arm-msm@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: RklblB7aClY0N4YbJ9y7vkLLZcN5Tlmv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX07hnRSIyKS+l
 LWOUSPJvnfX2bQnIhWT8xKzmxeJTkDCTic+/hrVEuXVn91rF9Fx1JM5xzLGksyfG6cC156sCdzz
 gJWPB04uIJcifRQmDpibGd+0eTPZPYY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX/ONuVJfzhQU9
 IFj/3iZlkCHaq0K2wuYBZL3QIkHUDf3i5NFkztPtZcMgYP3CBNSI5zQ4TI2wo9eGVShW3Z7CkMz
 +MK8Qmo+QbI9cTdZ+3SWru9vlH0YKlVhhtU/snsQ1RL3DPvcJclI5BSRkfWqsaGsOK+KR4VgNSr
 mKWhzyQFsgfcAKZobxV7QKwYonU1oX5zucAmB66SLfgWXSfU7kBMi5zDP+MJwTPn1VnM33tCJCA
 H0+UwE1XvbAPkEtn4dk+Xsyj9/B2jQzDG0ZrYimmPencGj6qaISoU4aKIHRyhDm3hcBQUAI2Vbh
 V8/NS6PrZZI+I5W3GbSIMetHVBNCyx7nlrNU6C9v1Nsw7fw7sHWufRnSYxe9dQR8OF+bGDkqmhL
 w6THZhcu7QfqQAL/Oa8AIV8AEfHu+yM8d9UXk7gtyw5Kc9l8M0yHdxmfgaVKeOMlTF6Ex5O9CmI
 DwMxAinki2LyVDwWhgA==
X-Authority-Analysis: v=2.4 cv=GKo41ONK c=1 sm=1 tr=0 ts=6a3e0c08 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=HKrVEy9w7v3RiqOSl70A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: RklblB7aClY0N4YbJ9y7vkLLZcN5Tlmv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260040

The driver_info field is a bitmask, so use & instead of == to test the
BTUSB_IGNORE bitflag against it, which is consistent with how the other
flags are tested.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d2e15a91584f..21e125db1b1f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4109,7 +4109,7 @@ static int btusb_probe(struct usb_interface *intf,
 			id = match;
 	}
 
-	if (id->driver_info == BTUSB_IGNORE)
+	if (id->driver_info & BTUSB_IGNORE)
 		return -ENODEV;
 
 	if (id->driver_info & BTUSB_ATH3012) {

-- 
2.34.1

