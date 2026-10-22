Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661674;
	b=RHqXhhoxZ1kvXywyiw7m5e+KZbEbylqF14NqvASfcg8gxJjMxyCdIzyoFpqO9jIyZ7QG
	 MjL7yqgCYNdhC3qiBQ2geEPk2gJYVbsHbzOiiVp7NGU0xljVdNCtMiRhIrgpyDyc5rUNQ
	 2uAOPawHbTU44uuBjix3traFa1oL8wcTUMp3pQj5drsIuVdc0NQE0d8q2GF+nB2V1b1m9
	 kabWwFvWGoShCJ2tOdhSt3r5pBzAzdtX7H+8+hw+f4v7G010hn7RC+Riv9+D7S2b4F8qL
	 Mbd1JzymQiLjBp2sF/EuGoXPIMwzW+RzpedqW5ZzSeO8PJ8ZS39b/dkE+JwKs6FHehA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661674;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1Rj1qoidH8EWT/n0srs42IuX9uVyDVj0QwR1LQZqHvM=;
	b=vASMCir1trRHBCB/JBHwHq24nSKCU2fOdIpfOKVF6bmLW52N9VBVGqPlkajNG3USb7Cy
	 LGmUJx5c62SX2Ef7tAusekDBqOMV3u33zC+GggLgSl3slaEiOTBhbz7eZOPeCjF5CCLYP
	 9OGp4WTHYDErqPqw+uK2F2I/imDmmSP/2QQQW2bmB/rbL3nuKIXK3ChogeeZRucuRk+Ei
	 5/OqP72zDYMQchOwTh1CsSHxhhzIS97dP9Y0bObgy8siFP17XiQN9r3st2NXWsTGa6i+p
	 fIF0vuihOKRQWlEtlIboLFEgu6egldG1Nbc5JJp9noxWZhki4jpkmoY5qVVecVNwsuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PwrcdF+D;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hRMlyKlM;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6170F606A31D
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 09:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6170F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PwrcdF+D;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hRMlyKlM
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M9DrqI3889141
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 09:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1Rj1qoidH8EWT/n0srs42IuX9uVyDVj0QwR1LQZqHvM=; b=PwrcdF+DzUJmRnde
	hI8F1YEjOk3dDfEL5mPGuYlg5y0weZGfzUQvhEGuLehfcUPQnezsoOltce4qCb4a
	bmPBXs1OV01hZAOhn4bcnQWyIoJghdPK9LhVpFL5LaJGTb37Fm3u0Xlx2UnwiDXK
	jsl9tPr5zVPw8tidZPUcLjYo3IInZ/qeMxL2AOkpLF6m+xmqOrz+9gM58ZkNOqH6
	Ggkbama+CbUkq5ipxnbhKEBCjpb9Px3G45hfg7+A0eDpqgl6khjQCo6BC9sW6tPS
	6+wo3Bkk0dpz/4EzjVlGUpkCGhHZrqmqE4tPEJjtwGY+0fxaeDeEwDK0H7u4IlZB
	H721Gg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93c9nvm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 09:34:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ea8a9cfe6so44279185a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 02:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792661673; x=1793266473; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Rj1qoidH8EWT/n0srs42IuX9uVyDVj0QwR1LQZqHvM=;
        b=hRMlyKlM/PU0rsEmYtQAf6/7UWB0RhstTZv67YqjnA/LEr09Khj3cxON7Xmj85I//J
         Y/BKpT00bzRF54MxWuIzCuliHKYX1WarCNYHimoJPohkKrXRWtVlKvwUNqL8XWkavRAC
         w8WjIeVYh+KC5qQjQRbLBozfZdaQrMado8q7hJEJ1JtAuSNsg/m22GerQaQb6UAUz89b
         hftNHCtZzv4vhtN0cgsQDWR8OWJPXmVfj87a34SLysAS9r9Bm5F3j/jx29/lP60QmYrG
         eVsHJhs14jX92ahWfA1EkMSZyQMEH5Vf4MqJSjuYiL9kFSv1eX2HwNnxYakPeLQ1ztG9
         8IyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792661673; x=1793266473;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Rj1qoidH8EWT/n0srs42IuX9uVyDVj0QwR1LQZqHvM=;
        b=KonSbnIl1pKErXbYqergzPTekhxpiDQjW8pe+5CsQZ7rsSUcFlaT0f3x1gdSn+Q5hj
         IaQnA4ApDOBwyjciIGMY3qnPs155al/SD40r1Bk20pqmvie1tUBlPZ2a+29Vj2zpz4R5
         omA/1PJ8ZpqasrycgiocTg+4OqdErI8PAgjtmtxq8JF8SCEyAtyabIhNvozQmxOsNRqx
         acAmZ5+k8goQkexxsb+MOBRVB5QIksOPYf2s1upXfJwGLqZjksmJvSY2ssefXX7OiZqk
         Ja+cCwmYDmW+IHG6dcfMVoWxuvXSGOSMLz3y+YnwRMOZTgQVTR4OW9t4Lmw06OM50JYS
         Ub9g==
X-Forwarded-Encrypted: i=1; AKwUvBzaKEeJNO6mMTeZzwiYFvPQQYosXgpeHiqi7VUGc+SnlJhC3p9RaWo2ioKfCfeMKhWv8Z1XB0AVOG5m22slpIk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwEq42brLfZdE+ZH5NWqDgAXlYjp1lj3Hd4NSF3Rqv4MGNwxMW
	ZpO1rv9akePwztKDMnTlgZF95J+DbYfeTU3Cz/BQSL9PmksqDVz7iF6ney814n0zQZnH1J7LuyJ
	M6otYtOIZeMCGCMFF7yTutcyrdeawVN/wSlEjTESSJbohal+y/gcXEXw8R9PT9pWaGGY59qY=
X-Gm-Gg: AYBFou1gJtOMhs9VdpVXiukghO0lzmMXCgFDwNS6oKBQR8M/bF6qc0lkGnxMEhTyOHh
	yOeafqUdqZk0gJUZZNGQOTdUenf+aQwzp/6o6s7aJl7XHMBuCsCQb+tZcly5eOGMlEtxT2qdHP/
	GAR1TQOmvyCO1m31+fJ4WAGECdc9Jbs36DvxEP9xae5to6nZVijCJfZTvi4opaX2LppH75FLwrv
	S429ZAfeIgEUCSbRLE928X4VQry5/HUTEk4Itw6jCKbLk8uPgo1PRnd8bFttZU27kq3PomOrly0
	rm8ogHRNw/I4xN/KEhenHhul5Ig9CY9NZO9UjJDYzDNKUZsg2XlAfAzWn6ovf8eOrpXibYUqf+M
	MhYZb5SgJV9O3qV0FjUEVGg==
X-Received: by 2002:a05:620a:19a0:b0:93e:54fc:2c79 with SMTP id af79cd13be357-93f57f72681mr930305685a.5.1792661672497;
        Thu, 22 Oct 2026 02:34:32 -0700 (PDT)
X-Received: by 2002:a05:620a:19a0:b0:93e:54fc:2c79 with SMTP id af79cd13be357-93f57f72681mr930303085a.5.1792661672043;
        Thu, 22 Oct 2026 02:34:32 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a55c001sm84619866b.31.2026.10.22.02.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 02:34:31 -0700 (PDT)
Message-ID: <e26f0360-aaed-4e40-b1b2-956c92d34db5@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 11:34:29 +0200
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: monaco-evk: Describe the PCIe M.2
 Key E connector
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Wei Deng <wei.deng@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
References: <0303224f-4c2c-46ec-9866-5ea1fd0fb4a3@oss.qualcomm.com>
 <20260825092715.5794-1-wei.deng@oss.qualcomm.com>
 <isbrpaztfrgwfcleujrn4w26cshbi2mgn57tbh5bubvsegn6lc@jh3ab6htvd24>
 <83b67ab2-ab68-427a-94aa-881454f457ba@oss.qualcomm.com>
 <CAFEp6-2KDxDrfTZLN7KPRg=aavj8nqQr7ftna23n9C1Cpbwwbg@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAFEp6-2KDxDrfTZLN7KPRg=aavj8nqQr7ftna23n9C1Cpbwwbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzNyBTYWx0ZWRfX9zQzRmsx9nB8
 3Kk20tVAhBtoGUmRMge9YrWqLsuM3ZTmd0U8o7Ax50bKJAiVj0Uod2bfiLHas4Y7xoeAhadwpUi
 biqJ17YTlMEKEhHaPtXGDbqBijYZSLw=
X-Authority-Analysis: v=2.4 cv=ReAFmFtv c=1 sm=1 tr=0 ts=6ad9d8a9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=9AbZo8Gtoo8lc68VITMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: rKfKmubmqVBxyKZQyd8f3aQU_vTQHMbr
X-Proofpoint-ORIG-GUID: rKfKmubmqVBxyKZQyd8f3aQU_vTQHMbr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzNyBTYWx0ZWRfX/Im1t2KdBzG4
 0s/b3pgsBNfDHRM/97H6WHl8D+9dwFvvQI1pfQ0nFK7Jy6h+sB2nIm/uAZDQXlzeqBoz6Plh/7T
 3Y/eF+1DEZtoQ0VBPT7Pm8ucJ892Djk1wqk2zjshwQr/gx3X13z9K3mCZlQJ1NwbzBwpFgyAVco
 GMVG6vwIcuOe4EzwWkWgBiYQj/9LxiAT1qdvPDvUwnnCHZxSXOfeQy825z5+F5TamWbT+SEfNvs
 GfnSzdTs4qLZ7OA8rsD++VBZjZaakCQdXo+7wxaJOtd6sCIve/EF4Z8KGpGvdymEWOj223jg0Y3
 orCmgMDPBx3Jnl1c/rkPQ/7AJWmGJ57y1lCCI1GM4rkpr5yomUN6+2mVyS/xn09iLynLLNI3YkR
 BLDvWfYj5veR7XLpwzDgX0MVbnk/NeeiIYVWbgWRg/HTY9/pPtUIx5TI2vh9KsqDQHn3ZeLSScC
 4ZgYu+5A+tDOCTmTGkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1011 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220037

On 10/13/26 10:13 AM, Loic Poulain wrote:
> Hi Folks,
> 
> On Mon, Sep 21, 2026 at 2:38 PM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:

[...]

>>>> We are adding M.2 Key E connector support for monaco-evk [2]. Konrad
>>>> suggested moving the port/endpoint anchor nodes to the SoC DTSI
>>>> (monaco.dtsi) for clean DTS layering, so that board files only need to
>>>> fill in remote-endpoint for boards that actually have an M.2 connector.
>>>>
>>>
>>> This means, the dummy port/endpoint node will always be present even when the
>>> M.2 connector is not used. I don't see a compelling reason to do so.
>>
>> I don't really see a compelling reason to defer re-defining them to each
>> device DT either..
> 
> Adding an empty port/endpoint at the SoC level is problematic for
> uart, port is not always expected, this depends if the uart is exposed
> through a connector or to an onboard device. So we may end with an
> unconnected endpoint but still have a bluetooth subnode, which can be
> a bit confusing... Also why adding a port/endpoint only for a specific
> uart in the dts, and not for the others? This is a board/SoC level
> choice to use a specific uart for M2 or not.

From my perspective it's removing boilerplate. Currently all USB and
PCIe hosts already define their ports and endpoints in the SoC DTSI
and if they're unconnected, then simply nothing happens.

Both 'ports' and 'endpoints' are an abstract property that signify
'X can be related to Y' and I don't see how that's a problem here given
UART is very much expected to be connected "somewhere" (with the
"somewhere" perhaps being external/a pin header)

Konrad
