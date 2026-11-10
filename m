Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292837;
	b=NjA9yiE4d66frPAaL+WnVyAH5lcY1jLbwIVNWE/SZxQY7rGm//gEbsLtM9ykKUgV8Xdj
	 xXJpZrRk0pQK31480PByVG9P4OFe+s1LynCcf7VJaNm/VB/RPawpzyYcTRq+n3ez4W2r1
	 g1kufjueOpdJzo6+V/xd//3Gy02nHt89d62aDLSJDrn3qaVulkW8f8/15RAeBsJD4acPZ
	 KXl3GQNIkxX0n3W1CT6/URhzBfU5tgwa8GokxUeBCZTPHTqpDKY6M351ddnyp9rtaR1fr
	 hc4ldP9qvORT7rRVtnD3fFGY1DRXGXuMcMKaksTv6yiIAwjkB0074hGbdzGoMTS2ihA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292837;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2YXFXOLWasRraLHbzcR0/nRTNi7YWsnW/5yBPnyszuM=;
	b=mKcKmNxcspQGuTwptncFkeZvw2UWQP3kgQHYB3/KwBIlcZLbdrkq9gLmfuVXRi3EAsyT
	 UIfWAzWpm+2fPC7t6eJHVnNBlkJVgvHnbvhgJdDpwC510aoWrwMwjFvMTYwXqe3Cw9UIA
	 cfIrq7EKt94HYB/9th/SWcBb1C8v4oN5I6x6zWKdXQ6zi1qLHzOZuwVl2lT/BGINoZwbY
	 mvfge60RSuvPOhK6MIkNqDrBItv1RVi6hM/6BU1e9gc7A8jr5+lhDvK7+wepLSihYaWLZ
	 XStHkOuli24vhHYjqtKcm6C81Pfse1O5OPs0L6xRVlL2FGcjPbZ+NmkmwNoQKW1/PTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n+3XgXQV;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gQMPaCSB;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6C2606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 06:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E6C2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n+3XgXQV;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gQMPaCSB
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA4AaHL2929011
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 06:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2YXFXOLWasRraLHbzcR0/nRTNi7YWsnW/5yBPnyszuM=; b=n+3XgXQV+vm2jsiF
	v6D+XyPVSHiAKzqc9QxGWRT/zaVbTIK0VXg74PTAtbKaXP4ynkFiNmuUbRez03+T
	fWFCUIrU8r9inImLvAgaf0TGqi6rfCamgjH8aFc0QJn69ZGXbOaDBnyX8CC7fxym
	Iy8lTkYHNpIlMh0YsK2eRH4hFrbl6gyLFKhBvMn/rUka6343/s6pxdFGbgOsqPYq
	Av8HQJhBYVUKLylq9yDTQV/sUJRjgs8kUi7LPEBbU7EORVXtWrO14rEUbhD1/+Sz
	QG1uh0IIhBOQTV4hX5qpX8rOFNFtdPX2tocdmAL2PCU+yzQRCWk/iCV5CEm1J2CP
	aEYTVg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hufx83dpg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 06:40:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ed121d5161so5456455ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 22:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794292834; x=1794897634; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2YXFXOLWasRraLHbzcR0/nRTNi7YWsnW/5yBPnyszuM=;
        b=gQMPaCSBjENvqLaZ7fMaA65Ut4+0yyGMEx4A391iVBcd1CvrKmK8deQ1Ybu8XGbNQk
         lEvNRJ9ZImo4V0qNTV9OMxwlsI0ewTBUzH84NMskfDTuHAPw1KZjl1IUKy3T9KX/w1mt
         c5bpfslgAaC4VEMXSY+iQbQGMR/9EhGMIFZx9d5es/pmiIuNYIUDqY9aNyn0V850hP4g
         miHguzCV+cxR79ax9Oi8NfiPcaRjjxRLAs08Rez4JZoOBjF4qbNywuPE7aE3R9Wn/+gy
         470mD5BUY0L0tloWGA7NzG89kAiw/ghZi9NrLbTZCn44rYVgi3dufSTC7bLxzd7WhLSj
         LE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794292834; x=1794897634;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2YXFXOLWasRraLHbzcR0/nRTNi7YWsnW/5yBPnyszuM=;
        b=Nd69Arec9N17KH0jH52Aps+KYmSIYIy094gdFabLXQk+kvZPn8OrbK4FrFwSsMLk04
         uDyG4zQd4KvS8fHHsPxeCUyNIIXXoq8RTq05MFQrXotUSRVcpVO5u74yWrP1CM6nAc53
         dwq/tv+Fqup96BY+W1S69VUpC4xMn5qR3tDIOx9Qv/9eEnibB5PE8oODIVPRDe3Cg7ng
         ihhVIEobIcDNfsf+3HeOUTxwt6zDtkhjk7fH7ZwZIzH8uA8KMkkTsZ3dHyOkrkDEZgBO
         MCMzROOHKtrV+F/9IEfA0EnNfKxZmNDU2ppydqHxcSJ4wlycOW/RKg+yWawxWy4S08l3
         w4Vw==
X-Forwarded-Encrypted: i=1; AL+hErHB3ywDF2p8PHUOTXUxe5WoOBGVvlNTGFL81Z59YN33yYh3b9OKnPTmPQx4FDPYNeTLIdbtwteptVPpX0qNIdU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Rig0QclqoFXYj8DT/YvfqLjoTpUVwWBD5+64C8bgWpgFivaUY
	mLRJ8KQ9/jQOoHsPCp6wUocGonBpGJYiWeURK+IGj4Ci/nTQwVUQzLxH2AxyAPHEwdyhNTZWRBJ
	qk5u062rd2rg+ULwFuCI1bRqpXe+Yan1UkQJiJJnoteiSFvZRDsPfsDwX3/5l/iMt5m/19cc=
X-Gm-Gg: AYBFou3TmfsdM+OisjgieIGBP+5A2q3GRd4Y4aIK5dqjT4WKYm5bIN3JWCHvtovqGIQ
	W3XfEUCGefRtwAo+gDCTSLB8UzHVudLVfWHkxVwjsjmV5L76UNyREhAlDB+KJPmyMvFC10aBeGj
	cHhPXDJURvndXossJ8l8r85MyJ58sUd72yxd9Vi/WbK3FattCtu8k8GM1dnmVLbmMceZtNCYrwU
	Z5QRqlkfNFhlxy4aShJeH+DVmA2RGRiBujSBaYiJXI4f0net832P2Mf7dt1Cn4gnKE4qjyCuexQ
	pyU6eiTu+zXYvtlpnumMIapxEBBAnMUpQIuE39haWzSEXJLa2yr7jYR/+l/S7mpwQfZAxftS7xN
	r81ceimXEQTSDV3cx7IUAgCLFojPb+6s35vAFSqNwuqr3YVMXs09xDoo9LpI1UWAoxf67sTe/dp
	p8icmVn+kqHM9VjKJcBSSU7Y1DYFgbjOBbbPjZnw==
X-Received: by 2002:a17:902:d484:b0:2e9:5714:607b with SMTP id d9443c01a7336-2edb88420e2mr27024725ad.0.1794292834351;
        Mon, 09 Nov 2026 22:40:34 -0800 (PST)
X-Received: by 2002:a17:902:d484:b0:2e9:5714:607b with SMTP id d9443c01a7336-2edb88420e2mr27024465ad.0.1794292833881;
        Mon, 09 Nov 2026 22:40:33 -0800 (PST)
Received: from [10.249.8.192] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d4d773sm5153645ad.20.2026.11.09.22.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 22:40:33 -0800 (PST)
Message-ID: <a367cb8c-f2d9-4188-9397-9a46039be14d@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 14:40:29 +0800
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
Subject: Re: [PATCH] Bluetooth: btusb: Use DECLARE_FLEX_ARRAY() for memdump
 segment data
To: Hex Lindqvist <hex@freenixos.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Paul Menzel
 <pmenzel@molgen.mpg.de>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261108042008.226295-1-hex@freenixos.com>
 <b83e0172-2f64-4e28-9750-1a5fb3dd6b41@oss.qualcomm.com>
 <CABBYNZLJpDXTPmE_=rJ=J3oUMWRzybHhut4y1kPTEU8y2AKKiQ@mail.gmail.com>
 <CABBYNZJdeHXP1XjYcTwUdCe_SFfxMETpSQbF7t0FHyxY4YfZQQ@mail.gmail.com>
 <20261109225632.1227242-1-hex@freenixos.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <20261109225632.1227242-1-hex@freenixos.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AbYkjHXG c=1 sm=1 tr=0 ts=6af2bc63 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=I5BWN5-QX7drI1OoIp4A:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: d9S6supUyaYF7XiGLpLPNj87lFyG3zRy
X-Proofpoint-ORIG-GUID: d9S6supUyaYF7XiGLpLPNj87lFyG3zRy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAyNiBTYWx0ZWRfX6MMnOVaHxkIG
 504dKuxMhAprcEjveXo0+FctVyTBLSaaQ8eZgC4SWYODl2T2PsnaXoP8z9tm0jR2FT1GVMhbOp4
 EyPcyKS7+dBSWfJqUGjkHpvPjsIC+DA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAyNiBTYWx0ZWRfX8e3+SAPxQ4Te
 Tq6Yz5g/GPEjwkF9NQrxfma89l1s5FkUgivKT6dUEhxJMUrHyBz5dPXWzTclCjudsHEJ851dDq/
 1soC9UU2u4w447ELsbWB4z/0k9BUtcSf5tQKEqzobP121f52qauIFAn5z/pFQdwpLxBf44lEnCf
 2hH28Dw2Y43X4Ph8ZiBYUMya050DGZTMIgMFYWZ3vDYMPKg7IZBK8kHRPrOROQjNiBcRUcPniam
 YwVyAhvYcaLphzb2/F2SCtRqqJ7SIFhOGZTdI38eNRJIJtX/gFZeg5l/HQVdtWV0KV+k6qWk64z
 JXYTps+I5u0M/y4lZoBjJJ7WLLevA/F+ha4IXU/5O9pvosv4GXKcfNEizmwy+XtSsGgtmjeKIuK
 QuyPeqhoXrN9PU/ySUhldBspeLQwMVHMD5LfW6NrlOERkXc4zopgVDyNM3WYB30IvSVvfgI3osK
 rSj3JoXuiw88kP/B2lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100026

On 11/10/2026 6:56 AM, Hex Lindqvist wrote:
> There is no build warning, with or without the union; the patch was
> only about the zero-length array being deprecated. __counted_by does
> not fit here: the struct has no count field, and the segment length
> comes from skb->len.
> 
>> Maybe not DECLARE_FLEX_ARRAY, but [0] is not recommended for vla see
>> the Link tag, in fact the first_segdata[] does follow it so this needs
>> to be fixed anyway.
> As Zijun says, segdata is only an offsetof() anchor, so it can go
> together with the union:
> 
> 	struct qhci_vse_memdump {
> 		__le16 seqno;
> 		u8     subsys;
> 		__le32 dump_size;
> 		u8     first_segdata[];
> 	} __packed;
> 
> 	#define QHCI_MEMDUMP_HDR_LEN	offsetof(struct qhci_vse_memdump, dump_size)
> 
> The header is pulled with QHCI_MEMDUMP_HDR_LEN, the first segment's
> dump_size with sizeof(md_vse->dump_size), and the kernel-doc gains a
> line saying that middle and last segments carry their payload right
> after @subsys. The generated code does not change.
> 
> Zijun, would that work for you? If so, I will send it as v2.

Hi Luiz, Hex,

Let me give a unified reply here.

I'd prefer to keep it as-is, since:

1) The union maps the memdump layout: for the first segment, a __le32
 dump_size (the total memdump size) follows @subsys, then the data;
 for other segments, the data follows @subsys directly. Hex's
 flattened v2 is wrong for all non-first segments.

2) The current definition builds clean with W=1 and passes
 checkpatch.pl --strict, while changing segdata[0] to segdata[]
 causes build warnings.

3) The struct is the simplest and most straightforward form; it is
 only used to parse memdump frames, so it doesn't have the problem
 DECLARE_FLEX_ARRAY() solves.

