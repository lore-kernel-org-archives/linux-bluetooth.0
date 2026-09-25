Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC504FC8DB
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 22:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790374942; cv=none; b=GqAWR3rQu8STtU4KhGpW12SZKWqC5w9h1+meAsFL+vAQVxi+pXzAmyBfKWisuU6pWIVGZWMoRiJsDW67Qvhl8a6K8iV+2EQ5e+EDjDjuPl8cP39uRNGYYYCCWUPNEF4DzSuUycQVG1YHV/OWYKHlcNiY6AQgBzi09sRmSCSydpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790374942; c=relaxed/simple;
	bh=WDe8Nwp+8tXA6JvRXC4djLa/L7jH5WXFM1d8o/bcDuo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jzTnAePOklpg65SPHt+wbvf7CSpo1/I5LwLyKR5nG1azchRnM+myQ1Un0FkHLxU7nlWt+xCRDyCSTnhAAokUUDV+RpEsVMmt1STmckgSwBcxO2Sh8BwspQPqtfOii24KRO2ihV+PkW5mRN9ekXv0MJMpY/uZzKrxuB7djAhRLpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nwUVcUn/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LOTkkusI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nwUVcUn/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LOTkkusI"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PIoVNI1375585
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 22:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b1UmO4gb5quvleiJFqJ6eQjdTIgUvfS0JZPGJANlm1s=; b=nwUVcUn/sbesiu89
	0Im27RQQaQxZOJOZMyZhBMAlzBzDobwS2C6op74TgxAPFnj0beZHkqBa7c5CLnsS
	+Onoxmf9CEV3vB/unKZ1YOPE3UGaAQQU/n+S/XnZQKzMLu3prC7rS6/ezNBST70E
	lxl2cAsYAR5I4wGm+pGzk80ICPrSurQ+0Jp/sifqFF0tvKD0k0VwPb2X+2CBrIq7
	5fU+OdvOD5/6+FBxw6szO0tHDhKX6Z+Qe/TOce1QmxOqkzIL9Eo88G8qrh9Nq1Dl
	8/USu0aI7xJje5ILNbZETQU9yXNHd2S6krTrFoFibLz0iIe3VzodIXzYDnvPvoWo
	TouHlg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwr5ea885-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 22:22:19 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-341eff9e381so2462872eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 15:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790374939; x=1790979739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b1UmO4gb5quvleiJFqJ6eQjdTIgUvfS0JZPGJANlm1s=;
        b=LOTkkusIsE9Wap2MY5BQrUzlluLDrops8QAjch2lJNk0q4p+xXbVc/T/fYqK3DCvIT
         axWyIwOK8aPV4rqU9Jx0GgBLqTeoVYOZQ+jKRnTmJzekUU8Dq3W9QlbcA78pt4pURz35
         ZkXffhL2Eg67bu4WTambHRCcKe4MBieyLWRFQNwmHOd7j4oF0KvOL/UyB28vXQ7PkMBm
         m/xPDjXDeECxhgnWmlZD00koalDGEcp3RfD6jModXzrM/HO3h4T9wYep6Ogz3o8csz5X
         mpJn0kW7QPJjcbY/wcjP1r4OEa/gi85D1R0bGg/FQE3RujoNYIe/8aai0HNVcghEw3wS
         WflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790374939; x=1790979739;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b1UmO4gb5quvleiJFqJ6eQjdTIgUvfS0JZPGJANlm1s=;
        b=NMW4wARvnPsdnLaWxVacn6cQ8BmQAAQs5Od5t8a5MTbEpHxZ4zJmvSkA+vcW2Imveb
         4LbqLuvLrZ4JbaA8mELTvCkg0J3orrJauRie2STehdR8LxjWz5O+uAzHLASGd1en+EYi
         2yhnvxtpBYNqEej3Jhu99Dvw6KCUvNo6rgm22acE6ls0F1rjkYkmaM35wrnfD5cQ7fkz
         G5NqcGN4O5YBLCPHR9YGxRGxGX/JcBbfJi03aQU5kDQYCh6r6U8hpCcxEjlG8HMAW/Br
         ZEmRAxVjp/WjQxkfCbb3oeMYmLlThPiHrGjxxYvdOdJTuCFR3y9AAygP9DI0WocUQfiR
         yeQw==
X-Forwarded-Encrypted: i=1; AKwUvBykrkEnKUwHurJpJ8GVyRqb5km6e6ZJP6kXNWOjSai4hKhjJ93BrMVT6vMAzEj+i0/yJc+lTd6rCSJQKcbvMDY=@vger.kernel.org
X-Gm-Message-State: AFuF++mt54Tjn00LjFWJDoESXMfaAlLPGYtWo2S3na+AEmOfTrjwyLLP
	BwUhDN/naKZDu6VkgF+JkFMkkkXu4LUnylkIVfWZLwWT8gyvqIk536Vo1CzjjbhWgy/lC2UQolI
	Cok0TL/gp2oGnnMNmdBOyTNaXMXyS6twfpYuuVMbwr0rEQlCLz+MM/BUgwxTCY1nFQT5Hc+E=
X-Gm-Gg: AYBFou1AcuvLD4PKepmTrrQe96+0SPTS7Xac/qkyPzU4yI0FVucf2SCgbRfVAx9+Mab
	bWzBdfr9p+7BatpXPqROluKgMKKMGslNi8pTIq/rxBCHUqYKbsxsT5+8DOTRggDb4+n78uJb+ey
	2WSSBvSXyy/O5m4nj8dck6S5h2odoP75yUSf63/JSSbyDE6NsK7JMJYysLAA51ZK41bOMT80TAB
	Hw7DskvEPRAlLbKtRm3j2q/+N5rRiRaQNz69w8lk7XW57I8z15gro2GtoRcmkoPUtg7jr+EkCyi
	NYNEKFzpgKcAgm1i55PcoyQ8UmMCddz/saWRbqn9sA5K1Poe+vDrDwW5rmgWf67ZmYSt9R8CWK4
	RcZWWFMCF7n+auESt2e3/t022K16I133pYVMO1jEvk5Xdj2JUVRu2RA==
X-Received: by 2002:a05:701b:280c:b0:143:296a:c862 with SMTP id a92af1059eb24-146cffbd728mr1187779c88.26.1790374938476;
        Fri, 25 Sep 2026 15:22:18 -0700 (PDT)
X-Received: by 2002:a05:701b:280c:b0:143:296a:c862 with SMTP id a92af1059eb24-146cffbd728mr1187736c88.26.1790374937815;
        Fri, 25 Sep 2026 15:22:17 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-342c9c245a7sm1273621eec.11.2026.09.25.15.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 15:22:17 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
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
        Christian Marangi <ansuelsmth@gmail.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Christoph Hellwig <hch@lst.de>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com>
References: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v10 00/10] Support for block device NVMEM
 providers
Message-Id: <179037493652.3059844.6860403127536084948.b4-ty@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 15:22:16 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA4OSBTYWx0ZWRfXzWSvTxb6UWjm
 CkQ8Dl6ynDI7ozHoYJW7p1tirMjI00zYEdGbvkYzHNCMuNZke0453bIgSHLoQs2D9osCD41iarr
 kOxv7g8bDHL1ybfAbZQXDAl/0gQvbDI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA4OSBTYWx0ZWRfX+9nEFMqJEkmO
 TLY/8ZA52f0Cvw9wjV5S7fjksCCCB7V8hMU3VbfeX8OEbNFs+eWeKSBt+GDiLUKv/1G2xgD22Lh
 OovmMPKTR4LOH9+mGt5oP71F/PtuIXCVFI/Dv1y6gbQw6bbunGYLP+W7na5SWRk9Pw7tobSQwHf
 FgYdkojlF1uEJ0T7JzJ7bGUIxTpQCH6EhUIwjTIIhtMDJqlUguLAYLaYzXkP6f40fi03yloZebW
 rDQng3t4OlK2+qmOxLiupH4d7z5SnggI0uWTphCMqldQuG6ZYm1uXuOcho3DiZoiWIPwa3Jq0/4
 I95hx9VApHoz7tdcLn8zO3EbxyxixqzJXkAUC9cQLnagJiTYt9TObQbzVDOVRjbD8ivkGtGICuz
 IktaoagZaRsfZBy5izZhdbR5BN8OXzBlZGUk0J7KL1i1Xbu+QJnEulYaghRE2XknHF/Hsd0+WJp
 Gq6ulQPsleU1zB2n/mA==
X-Proofpoint-GUID: JAvAZO-yWcamEO-zIVCrgZk0zPMVP6fn
X-Proofpoint-ORIG-GUID: JAvAZO-yWcamEO-zIVCrgZk0zPMVP6fn
X-Authority-Analysis: v=2.4 cv=Hf2B3SE8 c=1 sm=1 tr=0 ts=6ab6f41b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=3vxmhWUQDq8JHCpcIj4A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250089


On Thu, 06 Aug 2026 16:38:33 +0200, Loic Poulain wrote:
> On embedded devices, it is common for factory provisioning to store
> device-specific information, such as Ethernet or WiFi MAC addresses,
> in a dedicated area of an eMMC partition. This avoids the need for
> and additional EEPROM/OTP and leverages the persistence of eMMC.
> 
> One example is the Arduino UNO-Q, where the WiFi MAC address and the
> Bluetooth Device address are stored in the eMMC Boot1 partition.
> 
> [...]

Applied, thanks!

[02/10] dt-bindings: net: wireless: qcom,ath10k: Document NVMEM cells
        commit: 753baa59527f8e606c49eac25692b8b08918a3a9

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>

