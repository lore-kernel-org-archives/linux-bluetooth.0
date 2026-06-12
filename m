Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23F13EEAE9
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270490; cv=none; b=QVIl/2b8QYGjWx0RgQa8cgDSwj06urC25mjQYVzwl9M2KdIf9QUcGjvBzS9jr+y8j1bEgxt/lvYanlmuDBaDc84LLiLStvn7Pu19I/GTidqdpvzCEJl2YCAXkyeFWqZx0i6IZqFkcw82B4IBToW4qLnU1i3ND8rus40kZ0/r2F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270490; c=relaxed/simple;
	bh=OKx/GH7ZUq9+Mjfs4xDvFsGX2/Vn8N7/Q0k8/BzXAPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LMv5Zs/r0xJebmD+5Arl5iDZpTenHrlfIIplNk3GTsrtOEAGbXR7geAQrMWDz7zToWeLcfJiihDvBFv2S7hI+jFncH7gKSrnakvgQXKWjrMgcs7qN1t9uXLBmeUp/fAwuW1PhPpYQ3wz7S7sF357Y0H9bO3eFNKQgzt55tOccIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G5OM1ip8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i6vf09Zy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G5OM1ip8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i6vf09Zy"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CCju7Z3665622
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 13:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=; b=G5OM1ip8TUiczHnG
	jV45VH7AZKJhsfHdm0Wd3H13La1OeotXMV4iMo9k8tf1ubm+/yWIyRg75WQTylSW
	aCLi2PfVB7MHDllFoBXBbJYks0VYRPX8kVTv6NVsqy/ZhVSAs0XWudRgY/99kV1y
	412IKCSsXeD3TwVz4ihANy9FgtXjnvcq58dS7mQQhLCW+2TnSQVUcBy4Ge8YOxUg
	USi8m1BM2Aya68aVeLMvEppC8tLa55Xtb8z9MMVz0m5ewvlM1KQM4SRgILgBjmXK
	rJv0voEjx+j3rEWZKv76SpEHnIEXcEIh1zsKpsW0gF4QyLwgzwRNK2vm6HBqc/ZP
	cZq2rg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1xck6xc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 13:21:25 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-96464f8d13fso229849241.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 06:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781270485; x=1781875285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=i6vf09Zyhx0qOxeEdo+n1eK+WdR/jh08wCpCKUaQyThVVKu/lgXchLKVKgxKFUfTri
         OAf1tA+3IDYjnq56Dzgj7H8Bwd6IJHrKCkQxT2pUif7zfz1NdVGb2BGdvylf+MxDzv3m
         ZLXWgl7cgR58mwireznP6gO6tDxAOyvb9U1bCFCv1JYBgYz6V42JD8Si1Ds/YNdR7ELd
         vwfhjWRwkNlPAiCulvu9UwRS5YFpToRerwEM3WqiuG1OqA3goApn15v1Gut1PVUU1OIx
         atqhg5VMkICCGzf/uqxfqAQhS+STGgxsmWuOQ4uoqxpZI7ROvrFneVZDLv2nssrNZ6un
         gHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270485; x=1781875285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=gnuJDdw+aEsc1aVgm2E3Rcm61ZU5MWgDE/hDsC/Fb7rL8wh8RTvoRaCZXhE0ZzOdYR
         YmmpUrysuThdQdj/JcgHhUnAtPdpfX9WtA8FYMNVhiBiy2R4nPHjdHoU8c/txWPg2hed
         ZMHAoBAF+hgGqz2Q34j+Zu7jw7PK3sPJoN7MjU2HGIKkBiiVtHdF1SwvwJUNTLhkc+vw
         Xwgt7cSO1hGoAl0HVMxxgZ9xivC+3E6Qz53/qNn0CladgVwr2COm0T2adgjX1swux/XM
         G1cUr6BqUrGqZkDKARsm3aR87a+3UDTtKuM4j+Pc/845YvuGCGN7lpCpysFgPUCWY4Uk
         EFuQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xDVctoDTbKav3v85P5Ygf8A+odEaTVlLTDXwvsWIhq+Wfqh/XtfSVMIQMNely38Yk8Td906qdPemc4ZX8vZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6I3BRVCqjOpk59I85QTyVO8KdMKluxw0drk055rd5r6wzBnXf
	P5HeAPu2WRAhhnRL/+RiuGMlgilwEAU7n7YuWonZGq7+5Ioc6uL8/3+zw93CbH5HsxU01LSiFIK
	t8pMa8un0nCdlrEhO4lU3DJ2i5BRlit8OQ6nA52pVfGW6JTeMu65qjKh5EQtqXjlkUtkA1YI=
X-Gm-Gg: Acq92OFLQQ+xt0pXPgbYyLkTHQM9BzBvxAe8raPMzMjoArwwA6TJdspBn8j6EKFayRY
	V2Rtz1ukQ/Ig7OY0tFDlGPqgopcEFMNvanPy5tXIDejF8pv+6ZNkAagdPClPGyfFCx1VqgBQuWu
	Zd87st6bjoda8iZFOG5qnd5OevSW09RQQBt+54t2YfYtHfmpKoGsIfx3ZCfF9UTrtv7CPmVS0yI
	wNv6A5IBDLqh+Ra3nMuuin5+NL8qZ21Ewoml2nB+M1huYpO0EcFz4jDYjrId1xbX7iay/i6a5rP
	pn6WXILEeNGnry5HWhxscI8YK2ULoDvFAQDiDl7K5E6Q2nd2E7i7NGRra5zTSzMdmR2y2uRKQYb
	CUbn1xGyS/xDpk7Yd+DbxM+cm7jsSxMsSVXERx6WOcJbhYzgOOlzun2NNMlAZ0gX3Ma/XF5VND5
	LVvVEhibnsvpAm0mMjrbUe1z10MO48MdJoqPsUFLJ/ndBNKrpBUJBSTuw1oqkONCgZVBqcLZPg
X-Received: by 2002:a05:6102:292a:b0:6d8:89a0:4ae4 with SMTP id ada2fe7eead31-71e88c6af86mr1261395137.18.1781270485198;
        Fri, 12 Jun 2026 06:21:25 -0700 (PDT)
X-Received: by 2002:a05:6102:292a:b0:6d8:89a0:4ae4 with SMTP id ada2fe7eead31-71e88c6af86mr1261324137.18.1781270484709;
        Fri, 12 Jun 2026 06:21:24 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:3510:32cf:db6:13c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfe6f9c46f0sm59986866b.1.2026.06.12.06.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:21:23 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 15:21:00 +0200
Subject: [PATCH v5 8/9] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-block-as-nvmem-v5-8-95e0b30fff90@oss.qualcomm.com>
References: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
In-Reply-To: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX6EAGwjmLI73R
 CnZJ5qB9zZJPcwCNrdnJOwhHybWnPdkOFvvuurDRnJbONECpxThIkELoaMbR5am1XYktmTXDpIw
 yPpP375o5uB/Eeliaiw6nTRB7rCZIFneKE3MaP+SWDeZsXmDPyeF+s7J704+/YuxwhA+mSihjjy
 U2x0VjshVfNFH7qBtKsG4OQ67HvvDa6mKBwmAHWpE3uJL3piD6bA1q5s7a7RKUSEk/JB8rlY1iO
 cVpR81xSD9Gc6vgT1BzOQ1v/TDJRD8rLT7zMi7FpCrlW9bRUHkMe8zQDpPCrskzWnUxDUv5YuI/
 Vn/PeCDroDIPfqXajsRv2q7mfGK/TQB6FaL+hA21acdcEEVznQBojO1YRQ5aMF+IQH0S5wFaVNZ
 xc2Buy73k6N2T3FfbC9h9jNvZokrhjy2M4DPoo2guLY8ZQyoSeGCUgbpRh2LT7Z/Dk9TheQ0JlU
 LiFJ4tXoLQrttHaUhVg==
X-Proofpoint-GUID: ReVhAps-bGNzMVlCj4eyp9oAz4Y5GSQn
X-Proofpoint-ORIG-GUID: ReVhAps-bGNzMVlCj4eyp9oAz4Y5GSQn
X-Authority-Analysis: v=2.4 cv=NZPWEWD4 c=1 sm=1 tr=0 ts=6a2c07d6 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX1xJMSRZ0tbGD
 LzAl9TEkEkfiLg9jVnRUmrzbulXFjkk23Y/0Fmi2a6dp0yrsvqqTZjVk5VE9+JFV1gp6LdTgVDT
 hVyRe1Riz28hwdKZsiu4PuuYkhwPh1c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120122

When the controller BD address is invalid (zero or default),
set the NVMEM quirks to allow retrieving the address from a
'local-bd-address' NVMEM cell. The BD address is often stored
alongside the WiFi MAC address in big-endian format, so also
set the big-endian quirk.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index dda76365726f0bfe0e80e05fe04859fa4f0592e1..df33eacfd29fa680f393f90215150743e6001d5b 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -721,8 +721,11 @@ static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *co
 	}
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (!bacmp(&bda->bdaddr, &config->bdaddr))
+	if (!bacmp(&bda->bdaddr, &config->bdaddr)) {
 		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM);
+		hci_set_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE);
+	}
 
 	kfree_skb(skb);
 

-- 
2.34.1

