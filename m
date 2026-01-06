Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAF924B28
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 00:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767658937; cv=none; b=UkE9vpx4tbMExEi8/dT+0tMEHPjUxJ0uoz5XOw0z1pTDHC57b8ONkRvfgMtry0/tdlSBaRC+MOg6ykw9nMGl+dMb3gW6Bj0lYOwFmYvy1sNt+PkVBs1nFh5WVpNXOvhYPW/wapWH8fmWpKG+TS9yYDwVjxtofopvCfaJjhzpwEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767658937; c=relaxed/simple;
	bh=psGaNMYCcA3vTNboHCsJCf0mbGjKts7x2MCloWKs00Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8ErOA8/ZSj92m23Xe64FwQVWLrMrV4vUoRNpcDJOuevcM2Y0vZQfjrbZlycof8mdaDwCZ54rU0iFBBtf2jVFb1jbwh9ghDP3mHn7ti4waV7DqZzcbxgQCrB3gpjUAkGdbj1uArKG7a/qJi8e5OL8fUuYz7ch7viymaDMax2XPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UvVajx7a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eNQ1yfRv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UvVajx7a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eNQ1yfRv"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 605I0E4A610316
	for <linux-bluetooth@vger.kernel.org>; Tue, 6 Jan 2026 00:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xybdF3OLB2P8zb7gKJjMg29j
	Qi8VyXoqHV6TjiefLPg=; b=UvVajx7a6P2iguxLmIsaWGb9IWTcZmy71o5u509u
	y/TMIBu4ErdCCV3jX71qVwz3wHUQBBzUXu080aVTDESHAGCiwA+6bQ2mtyVp2oOg
	qN9DVCX1J39X5o1euaoEAvDfsUNb5cU0H3SlWpQOSNT/ZKCY5QfPR4FUOw4Uudya
	1H+rbyriqojW6aslVweyNKgSxBgYA4oB4Omqt1VlcwqwFt8GacWa/pDfPPDb1Vs8
	V52HzTyPnHALMMbS2nMftz1HHq8rFt8criyuhU3nN5NEVVHK669MaxgdtmWdihrE
	udY/GAIddcgSbT3nSm9feY1lLtFZRb2uifErrwXrMT/KLA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgaus28kv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 00:22:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ee1b7293e7so15832291cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 16:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767658934; x=1768263734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xybdF3OLB2P8zb7gKJjMg29jQi8VyXoqHV6TjiefLPg=;
        b=eNQ1yfRvIv6Mfq1KJER6fFtw3zxJxIp90HVJe3fru14cP1vJlQAaFQk6Qqeu3d1qb0
         0iDGXr8VhDh88mebX6QBoVoitdBZAn6EuaMF5iMMAldGsKoIgMEqpBe5DJRB1kcCJXOa
         TlxFhpbiRr3EeNyaYtzTRTVR+/6cZioJ8UK/KoTr1HoRe1R3bjUaC4tBd/sYXMwrJLYn
         b2AOg3T8hdMMdHt9U36tUU2WHDA7sdGzMcAwIcQLCytaZN8TQGeHbnL2pnZL6FucI4b1
         eOqj0RpQmKzMVML9RPjDiM6OvKMA6Mx3po7x9i+5iefyOz6oP6zsdZxIz/T5gzcqTsDU
         PNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767658934; x=1768263734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xybdF3OLB2P8zb7gKJjMg29jQi8VyXoqHV6TjiefLPg=;
        b=MvBI/6ciTbZMmhD5ud28NEwVjpTA9W5X6FFEswCMgOqEIWHeNxu5wao9LwXgiFiRHA
         OehD0q7E0Bh5DkN739uolwaaskCyJeFvrn5ytyak8iabiwY9qVEFuzH9r9P0qkb76vRH
         0wkYSV8G9bTjLDIbmywn25YBxvHEK6tXpcFg6LMtOuWy/RUW21JA86b/5KHkDRuz7QPP
         rAOCHBUxJN6hRJjZArUud/yGbWPTXyNwW6WquqItkAH5/Ejbx7N25qGdjX0bwS08w1kf
         x65GLUWkNqzSUc6Ddf4wW7VGUPrWqp9iHs47A2gauRUCWNyqNRrhVLMOcnzX2qB0z6j/
         C95g==
X-Forwarded-Encrypted: i=1; AJvYcCXmGL7UJu9iQGkv1L3KjVDMDpmbOdSWSz/Bmub2r+atDa2R078qWXtIbSInX3sqyN4F18omDXki8FblhhAXhog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQP0Trzgcz2xQz/Sh+Yhz4ysyT+0r7/LkWCdX8gxOcmRjuZNQo
	e9NiAuNS1T05iBbyYHDGRvuvrmZ5TTNli9JptVVc+YdJVLISA7Px6vSzcm3uhkkPZlBtqIu/mEq
	XP2GXljmlcOCgTGXNJphGkxclzctDDmL8T3D96SzMu0DQ3r+QL4eUvTRQ3BE8tP3SgNq3bkg=
X-Gm-Gg: AY/fxX74yooStSyH1ng9+K7rurZujTqPIMjwWWGJpXTKzUeulUl3qqdqeol9gQ3yqeL
	lKo+3jegEvmQRyhGe1KUWIpa6VBcMenuXMW7W0HdQVbVkptYy2o4ONDqLo9c4fg5F9UFQYGFVh7
	OjVOPv3Bhqx4CPf0UR1S+qG+9OH1GZAS6B9ZPqfmyczdSzLhjbVK/RSXgWRY0BkhVjwI6ywT1B5
	8ao0AdZnccRN3KLP4CMNda6axNe1Vl0y2dmzK298uFdNoJkO0+35bOKADcWCqzTK+XRI9uBv4vP
	MdFi97vjRsOXf2Z3XAewetPpqUx+461SIuK0rQwWrBXcAU/Zv0UCBcUsQKr5C2nhp8WgP2l5s2S
	hixUwWWT9oi9v0Z0Uc2DXgXzyKxz0MR/sfcepYr80tLNQQqrMZIAOSSM2aBGkJNkyz+Bi2QzqSs
	005cadJ6Hk0fkAdr5s4rAj36A=
X-Received: by 2002:a05:622a:8c5:b0:4ee:296c:c7cf with SMTP id d75a77b69052e-4ffa781ff88mr18987081cf.71.1767658934188;
        Mon, 05 Jan 2026 16:22:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoXYD14IHksD1lnlNPMEXn3NfkOeFfiW71G0cqJJxj/ih1y5qOGzlZ11rH5lAKk4LFtCoKHg==
X-Received: by 2002:a05:622a:8c5:b0:4ee:296c:c7cf with SMTP id d75a77b69052e-4ffa781ff88mr18986851cf.71.1767658933816;
        Mon, 05 Jan 2026 16:22:13 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb39fc3esm1539781fa.9.2026.01.05.16.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:22:13 -0800 (PST)
Date: Tue, 6 Jan 2026 02:22:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH v6 2/2] Bluetooth: btqca: Add WCN6855 firmware priority
 selection feature
Message-ID: <zen64arf23paingmokzix55xa5p5loi7e2qrf7bvajkiodekmj@nsqa533afk6c>
References: <20260105055646.3816296-1-shuai.zhang@oss.qualcomm.com>
 <20260105055646.3816296-3-shuai.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105055646.3816296-3-shuai.zhang@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: nSpTvsLS3SUFJg0WOfrWrnD5OecpCcg6
X-Authority-Analysis: v=2.4 cv=DP6CIiNb c=1 sm=1 tr=0 ts=695c55b7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=nHHXIsCO6AQyv1VF1mQA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: nSpTvsLS3SUFJg0WOfrWrnD5OecpCcg6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwMSBTYWx0ZWRfX11q+6eYtCg/2
 TOY+2MXntyLYBDIDNanW7uAoNKSnuEhBKXF++8NRMD5kYCMPSQEVmUEUcI3k0m7VEoEF8IJ75ga
 i6kLwE8b+DX4DqhE8qeagMlSD8JAl+u02lSHKud2nLqHfIiwAbAe7pXWNvZ3v4ly3J3KQB5Bkpe
 eVqVSBddYiRRLu78KJ8gFafBFSh9fSdvX4834yMW3AmWzGlMM8h/ygrjA5VeZUVBtA4vyjNq7gH
 zqKCFNfeQhBcw8gXBqQ16bKFyHup5Ggy7ivYO69VyoakVDMAhwx/K5krkxfiPWOke1zLx1a/OiK
 jHojg3W+5+GDobma7jnwPsSkF8IN9arNykN3qpxFInAikNKYGf5S9+Fq1Zvi4WJUKeKa4+zYxnu
 GHoU3Gzlk5W46g45UNtF24hL1PMVrmIguyzYdpoKoMSzKbN8TrWgSzbQhoLG92UOncLt7D88ZET
 QMqpRMo36EsZinn19cQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601060001

On Mon, Jan 05, 2026 at 01:56:46PM +0800, Shuai Zhang wrote:
> Historically, WCN685x and QCA2066 shared the same firmware files.
> Now, changes are planned for the firmware that will make it incompatible
> with QCA2066, so a new firmware name is required for WCN685x.
> 
> Test Steps:
>  - Boot device
>  - Check the BTFW loading status via dmesg
> 
> Sanity pass and Test Log:
> QCA Downloading qca/wcnhpbftfw21.tlv
> Direct firmware load for qca/wcnhpbftfw21.tlv failed with error -2
> QCA Downloading qca/hpbftfw21.tlv
> 
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
