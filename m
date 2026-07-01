Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003734C8FFB
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921680; cv=none; b=onGn3p8Al9/y3v+T/PFloNgpUlaQ/UppmQJtViKKIvNiWf1M4asMfDex+YHO8BtCzqF3SdzNX8jvZmKkwPpI2zliquTd19iWV9Im7guOlK88kvUtWvK6OGWm/QfCetcJNVNswYbk6fRwb/eLa1GbA2KpjWYjUHJ0v4kBjiup/sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921680; c=relaxed/simple;
	bh=OKx/GH7ZUq9+Mjfs4xDvFsGX2/Vn8N7/Q0k8/BzXAPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rQN9RVqps0LgJouqJCpNpoC6Ht9MpWpUwE6pYYNP6+Vr4tGBngUl37cLbNrSH4tFGFfR91ooAFad9hp/UEeOoi89g2GXyCSDbEJcIoa1LiCq8+xNsLfblbnbloxy5T57OAunMZwhYE2oJlfbp2cTs2HsuUmZE/1AHFO/zsKRzEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pq5NS/nq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F0xEQJDF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pq5NS/nq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F0xEQJDF"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FoS1S1513814
	for <linux-bluetooth@vger.kernel.org>; Wed, 1 Jul 2026 16:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=; b=Pq5NS/nqw8AXlglr
	RFqPdkUwA1KGVsv7K+LRZtwF9K3E1Wcxk47eHkwTdnaldY7gZWQ6ibH3fP9dqRJi
	pbpa0Qh1kylkdNRlU2sHby03bKMc9gW7pcNAAmkJH48C+M/Ba4cjddY6cJ0FheyI
	pukFFt6cPC+ejY5Em3EZrEzYJJdnGgLy86amxW0eQyglo/R93w/eir4Ttv5Ov7+Y
	yhKQsOPbFm8P4KFGopv9y5LXIN9IvvMNq/SSvDowpVFLYJnc8VbvOA01OWsX/Xsg
	ntzgGP680b8EXEOjhjOtVLulFLNmnvCv5G829Z5Isn7bEB+naQI+CzXe5Y1Hhl7D
	7scrIQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jvwcxuh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 16:01:09 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-737bcdb48d2so247927137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921669; x=1783526469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=F0xEQJDFVEYbgZxp8VbFpJfYsHYjUP3AY7P82upjYou1VVLlZGku+jMhUkrnykXuUU
         PQgATBKHC+yIfpCnMFSGmXRzljkxkAqb30Y+S5Pzw7Qob6pgjIOSDt7QMvWzUvTvk9Dj
         KEnbYvqVwsvYkR9Uxs6SsmF/rqxHrlfnM1fXPeRtBeLi1vdUTsCqb3jz2gTXCP3HBQUv
         0dsxkLZJ4Ncha1Zvw7tHyASPz0RCI3CxuPSBbWQbEb92L9D7ThJD9sajGpllpT9LxToE
         myH61lAw/9oQGkpJFzMAVe/opTN9mixKife0wJh6+FdatIfvDlARbu0tHsFbZN2BzUZg
         ZHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921669; x=1783526469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=sKI9K7ikWW7M3zdFdz9mmJUGjd+/z7RGYiLQnl54HUpgkqQ1lQIbTbiF607I9dpdgh
         c9w9HoCVZsuzm2uRssA6F3wTqIbCtr9WuvKN6sd2LwZgNwIU5VX5VRPzbNSxb5IS4g7Q
         J95XuayDeGhGXSe+5DaDjZShhXNZF0E+A8hreTNurbLWOcl9sFje2M/gDa1yH0npyLOA
         GYS2kemdTV4H8jS3ugh0KZtiC7NxUX06gaNVLAAZ6DeFGAdXTosZL5jxIRP2zmGzg4A2
         SwbGOXaWwvsNPTrh7y1Eks/RsxexpBGBxWNgiUVTRB88P1ZAia9QobjNbuboGYgcxbOw
         aR0w==
X-Forwarded-Encrypted: i=1; AHgh+RpoJMwdVUuG6J9YiyWDMJOar9yhwcLBil+QFNb5N1m6R6mC6u206I1Lwpinnhinv2DNdy8e9SgWN54ofsZvGz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuLvsll5/ebicixCGCG8VDPljetysWcnEdfhxkMoeH5ijRXkZQ
	uOb1N+AvFmSFbN++f4ly165fVQBfP4v78NC+s1wP/h/m0wt+PzBjRp7lNlYlwvJ15J5NO1LBb26
	kszELR64jZu+YQd+CLqMmKZNpTA04x59fvZLmAp1u2SjazTy0NRrqiU5NPuzMHjdkom/GvmQ=
X-Gm-Gg: AfdE7cmxCYK6fOecrp82fIil7/XRMofwd9bzPXJKj510jvFcPI7mDmGnnnkmn2n3zyt
	t0e3wFJgsYpxfEumWacOOI1r1dXo794lgRP7dMunh4eqxdzmDDEv0nRd/0SdrZsMei46A7B/M8i
	m5qyil9/8OwaL5GqTjbR0Zb88Y8MeYaxYa5+QamY+fxJICq7w8ipYapA8nDeoGkGg+2UkdzmChI
	uGx+duYhTG6zk6FuvjB5ewbQI5erYnXI9zT8ueLiClP12mJVrheghQ/AA7EwdzF87XLsfqY2L3u
	4Z2hCC0W7Dy2H1LIZuDdSKjiU92piRrU8Q4q4DgX+CVVcs1Plv8KS10elNaVfugE/D3KVp+l+D6
	dfgvM774kTOzR2H/Q8570XWq6fNSkmyPVSIonQZE6iCWKJUmLePIp/Xa0mPoSqC4jLOvnVD5qrl
	87tHBGrB13jSkNLxYB6yk0Lu3oV/SITG9oDTyut6Qd1o9WT4MjRsQHTtaZTiG+rxg=
X-Received: by 2002:a05:6102:38cf:b0:739:d787:be9 with SMTP id ada2fe7eead31-73daa349057mr1035250137.17.1782921668501;
        Wed, 01 Jul 2026 09:01:08 -0700 (PDT)
X-Received: by 2002:a05:6102:38cf:b0:739:d787:be9 with SMTP id ada2fe7eead31-73daa349057mr1034801137.17.1782921665861;
        Wed, 01 Jul 2026 09:01:05 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:01:05 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:32 +0200
Subject: [PATCH v7 8/9] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-8-3fe8205ef0a8@oss.qualcomm.com>
References: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
In-Reply-To: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
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
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfXzoqgtXMvGCtv
 QmCoQGQm+2wH16Ib4xBa7goP34inN2CXhdKiNF/E443q+z0DSvudDoRYcPa6OKTYbkOrNwPpNkJ
 QK2XtBfdGJ6YQ2vQUzJHAZRaybUr6Eo=
X-Authority-Analysis: v=2.4 cv=JKgLdcKb c=1 sm=1 tr=0 ts=6a4539c5 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: bVC835k5UF5ZAS9oo00N9QlPQCagnv4F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX+hGLi1kQDa5R
 lsf94C7uJY9NT+c+R0TiINL3gxV9yIQ8xNthKywgGm9WzbPYb87wi7jN/NrKTJ4/vlz4PUTvSo4
 Accufjhy17tbjlL11isXKXeYBlChkcVs23TmBnzN8B6dlh8SNBNEMQbnj+FrF24pgT9tGPCge4u
 qyJrBp2r9zG7J4WMZZLGn81tvbqqzza+ciuQwPBoeRG1rmssS4QWegiv9EWxtAj4Vd9ZVj+Ys+P
 nQ9YiyFOs/SibsgmgwV7SlgC/XFUbFwfAFphPTezC8suZpOr5HSn0EVnRDl9VILqMWnP96d5CDr
 r4X09/h245yY4Ucy4OPqm49yAoYX8AqdeO/I4uuqIDcClv/Bf6Zq98kW1LOi9HVDGH3YLW9wiG5
 vldMLmhqy2JCX1l74HQpQH8I5rwRow==
X-Proofpoint-GUID: bVC835k5UF5ZAS9oo00N9QlPQCagnv4F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 spamscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010169

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

