Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD7C44CAE0
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167512; cv=none; b=MDMy/M8lQvFJHIb8GWJ7h3L4vM5cqw8O2FRDmXzJD/P++LxRYAFPXoCQERxdPh60jueRXHKqFKJxyAtx+4nTnUdI8Y9UzYC7ZOX5/p7Z0ggg7W8NI8/O6mOv3j2lvhU3fD4i3EmDGmBoE3bGjMNFBy4uAvOFCu4pLsbQQSMuf0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167512; c=relaxed/simple;
	bh=cLdgwybwmVheaxNq3A4ptASzy5fGo7sa3nM19lVmCQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DfpTt/vgSPwUXCvfpF5U4mhCkA4RQkOZq+YBzf3F7JrfmP8+SU/wjU8cGotMAT5oKCpoaM8YSowy7Sw57C6ihPB2y91dJdmf/4AN8kuPV5A3HGen7oJPdXzYzp9QyK259ZN+1amD2CPOwBkIEwd4Qw4mB2wHB4ABQUlf2Zrr9Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JNRuu/6t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FAlW2kYb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JNRuu/6t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FAlW2kYb"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647EPY271424508
	for <linux-bluetooth@vger.kernel.org>; Thu, 7 May 2026 15:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oEdzPlvkzmsz9XRBy398mVsjWjXUxo2umSQ5Z50zP28=; b=JNRuu/6tQg8Iq2yd
	efyuW8NpXjne8LakeYYrmxE2IXd0811URgteAZuuZe7hSFzFIjLDs4geR7VhamFG
	n83UxzHDzPwQY0bf2pDm74l1Dbpi+19LuNU2e8Iozs8RmX3DhPdqyCEXe9F58AMu
	8VrFY4AoYHnLwTjLpcLSAYm7/UY4JMH+8frEp7SibnG5+D/O78QB0nBkVdm1mpO8
	TYSdd5vt7KWPhF+nOUX3+HPbeX0X8iooViDwgbzYKKlaHtpQU+ybcnyGr9XHY6wG
	ikXlCr+7RoRcCJ5Tl11QBu+mpsMILrxsHNJNLdBXZoQUHPyBKpG/LJw4k/Phl2WZ
	rI3n2Q==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0pqfsqwk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2026 15:25:03 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-575242b4308so2218236e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2026 08:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778167503; x=1778772303; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEdzPlvkzmsz9XRBy398mVsjWjXUxo2umSQ5Z50zP28=;
        b=FAlW2kYbEFbSRezWYKrHriJT1nLtx00Hme0Ybkk+Wq/NiOaZ/Y/JcLJn+mnHNNS9cA
         Qz3fZOVCJc0CZn/RhXTbWqKaXvK66YfCSDnKZdOBLVUzhqJ9WpjyebFW07P4HucUe7q9
         iC9p8DZiM09iujRtRkcp2hE2RZdIX1KXEgJ+LzjYmH5gpOcWq3tVtOsjLp/GLb3Dd/Z+
         hSK+wAZyvLkBXBSEKJciEKr/Af4kcl2AEyxgR0BLIjMo6rDNUCdGQoMXyCV8XpNRD26q
         Zm3AWKTJjwBp7cyoNjDtgKs5TZhgY5EX2t/yqgZOJJD3fqT7cdrfWN7wjugMNFK3Eq+P
         083A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778167503; x=1778772303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oEdzPlvkzmsz9XRBy398mVsjWjXUxo2umSQ5Z50zP28=;
        b=Flw1LPUE4kOQisoBNlsitRgOsyi2S/P0gYT4FCSjQf2MCjCtuc2ttx9msL3F83MtCf
         9gbTG6JAZR+nJVSbRahWvMUcnpQTbj2zGboO13g1jpzg2L+RltmQMOVUO0cKVeW9ddBK
         nOXW8Ut8TIMjj0noyKqP0H14yXUNB/2/0ZPQE2xwTRSZMWMQD+ycXEj3acteYGEknyNk
         x0+VvSMJOo3I4nTzW1EbkqyR0LmDwIZ97YXAeEQBcOY/+W8NvX6FZKV+lWAwNNHHvHZw
         cFYoUK7FdwlIuBrH8w2y5UG4Ss+ZsPAuw6LnYrrZ94cKYrgh/1grUwcLVgZATqtq+MrT
         8m/Q==
X-Forwarded-Encrypted: i=1; AFNElJ9DXbND7OEilW5VpDpLwli5Z77kpOFQnLcjcdprXeRgYGnckuMi868KCArBEnIkkohin7+7M/DnISD7z9lUmrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz89VJmUKkkPmJbU2qhk66FP3aXzrsXbLbKmyULWyzXLIuPmMxl
	Frh5D8e8mFzq5FZLuRYtwqXsUU7Hf6NMuSKQVCMrKekXC66UyygHw58lsu3vUhq2BkvWHoqFvUp
	vKN61TPl+jxkHQzOFCn8afAIeA6ig4utiEqX65FrSnZoIOovs5yh5KjXXojpOx/ZDmDI/j/E=
X-Gm-Gg: AeBDiesjIqfcIal+Zkv2CUYi/nF2upn2YnExPBcfsh5v/e3CpgCccryN2Vc5v21y+bv
	V5j2H34aXjMCGsLmqVEympVDjqMLRt5h90172G/CfV3xMIPkHInpmKWZNhiLmZQWCturBXil0eX
	FNBPNSNQ8p1vIjO9NA+wbWnfB+gf4lh+xcj8Fb99K4T+OXRELI5U2TMjkHqCd8axdHkvITPRKol
	qTFuibnlV9Vj/RoRC5Gi0t/3su+wI9rdMJMXXlc6vCqjgXMvvyPzPy7SYX7rQTu23VtiDTo6Ii8
	1n9EeOiWg7vt2wON30Y2DMrxgePsp5cAGXiuqthJbbjF7WDSpO5X42L78yhDRROqTXdIQS0OtDo
	kyKhNotf9FYP9lyyU80hFlUT+MJ8FzNdYpAVhEfTnYQHZSQe3H6NHudwO6tfRpU3QZwwg3vPK0Q
	Q/JRnz+0Z/3fqA4oFgL7eqGkQp98FxE/yldeF9og==
X-Received: by 2002:a05:6122:e14b:b0:575:37ed:f787 with SMTP id 71dfb90a1353d-5755968ada9mr5305793e0c.13.1778167503427;
        Thu, 07 May 2026 08:25:03 -0700 (PDT)
X-Received: by 2002:a05:6122:e14b:b0:575:37ed:f787 with SMTP id 71dfb90a1353d-5755968ada9mr5305758e0c.13.1778167503042;
        Thu, 07 May 2026 08:25:03 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bca583dd7e4sm240966b.58.2026.05.07.08.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:25:02 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 07 May 2026 17:24:42 +0200
Subject: [PATCH v2 7/8] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-block-as-nvmem-v2-7-bf17edd5134e@oss.qualcomm.com>
References: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
In-Reply-To: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=TJB1jVla c=1 sm=1 tr=0 ts=69fcaecf cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NCBTYWx0ZWRfX/lWV0blWJcB2
 MzrpaLLKHB1XdBG4lLXS01U/88j0/8xumPOTW8gk3CPFi+VuCKI+rK58UOTbFfZOKvmThpjqxz7
 Gju1cRHAIaPjyM04z4aSwDYWrj+jrxYz7zJyz//anUsDquz553Taat5tqdbdsZCc2hUt2weoXbH
 vz2eRoec/p1u5VGEcqqR/INgeiXs4YWSX77XSiSG1Z4cfNY+pEEXjpU+0O/Zv0qezUx5K9rBInD
 Pp97DAfw8h+GFVsRz0Jr6jN4Cr6rz5Xplfcd1E2Ht/qUIx+Uv8N9oh7lzp90EZ6we36Podgw0Dk
 vapo8onXXqzEDTU1ZCLWIAwEU1pO6afmwG79d4JWXfA1LGl/YrjDYIDYwfao1LTsdmyeFXwAHNu
 gX56kDVtOrThXF8QW2wWjckcYW96qZLfYzrYeT350l0IEnGT1LhLiOA/7bdVaaPoaZNDqa0dI2O
 Grc+Kz8xqk/JThvvtuw==
X-Proofpoint-GUID: Uith9nrZZsRbXwiTysWnh7-r2Ky63VOo
X-Proofpoint-ORIG-GUID: Uith9nrZZsRbXwiTysWnh7-r2Ky63VOo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070154

When the controller BD address is invalid (zero or default),
set the NVMEM quirks to allow retrieving the address from a
'local-bd-address' NVMEM cell. The BD address is often stored
alongside the WiFi MAC address in big-endian format, so also
set the big-endian quirk.

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

