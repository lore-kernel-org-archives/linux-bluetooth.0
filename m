Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF138471268
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 20:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784664683; cv=none; b=t54nsacnmNXCfTe+TuBI/srGSnljd7VZNSRwGHdqy3F+ILLV6S0TX9vaebvdi5qUbUj/oUd7wjkaAdq5sy731MEQvZwXKe2f9htD7M003fiHX4mVl+8+z5oiHZlNbCTR5EnP0IS5n9zLGaZN5DTa1CSLynUYncajKmWzzu5OqjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784664683; c=relaxed/simple;
	bh=8STlPBMjUmN2TUHF6C93L4PXle+urAG6HatJTuHYE6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QG2m/MQboYKsWfLb3Z4YruvVhciuWRZEpEnPXVR8jVlv97IWL55x4xRmrnc5LDMy1RQFkEg4O6Wb02rAg5tiAQ5j1v7iJ7WYdNRCBdT2Btblo5mRmJtLlduWYHEjj0masQiqSscJAAzAETXhC5pJ/kqo/nTtbrgI7hSPiBklp3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c2tI1/uT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FRqb4cbB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c2tI1/uT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FRqb4cbB"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LHRLlg2494433
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 20:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8STlPBMjUmN2TUHF6C93L4PXle+urAG6HatJTuHYE6s=; b=c2tI1/uTLTbI3qrI
	YHVsWWP3KOvbPVdx9oWG/BhbtOT9oCiMzH43R/TRHEA6wM8mW1VSOAwL5T85ikMt
	cDFrb8NAef6cCGIBMiow/xUvvlLZ4T6nqkAQwzEI90fUxyHbW50gG/j5uysdaaR1
	z7WU0CwloAijHHSznHwAE+NQF6V4RK8tXmPAEZd7MCHKwQyzsD9HdlgfGUuX9Bjd
	lExltLuIcl5tIHuecN3bmzssjeeVfaO2BZcotCgiw2azvCEO26DZTT26Hxx877HC
	Jerz3gMnqYpIZVWEo8IP+CnFSkxNsKif+0nCnzVu1cppGliGf1cx5wbNroAGs1Gt
	UflqVA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6d8qu6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 20:11:20 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84a350b9f17so2022063b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784664679; x=1785269479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8STlPBMjUmN2TUHF6C93L4PXle+urAG6HatJTuHYE6s=;
        b=FRqb4cbBtfODvPbC8qGqwTzBUeeR+MsrlNpxTm/43gvwu1Css1aFdqkiPkh1P7RTuW
         djU/zDkDTGCmzxW5LAUD3cZzmKdlBaPi5XN6aZC9ECY5PICbhNzk+8EMklHP9kRjOh/q
         d9MY9jJMVtd9ElCzZ0zon8wdnIK1u5HjQZ9xlX2RWvLc8nb3ttUrvEPUvavM7UNcnu/g
         yF0DrYNL1uqcTRDNDwgaIm5zN1OXx0mTgnxIiZVkxcn/w+xIq85jp3EBEEBy6mw9bF5C
         V1pIcq9mY1xXZnS6SlqfVHhGxnQ8CIgWI0lWfQ/U8L+Khct9yMr1uSidu4j97x3zEcr7
         HZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784664679; x=1785269479;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8STlPBMjUmN2TUHF6C93L4PXle+urAG6HatJTuHYE6s=;
        b=sI++t7OT8rUInmzZ0kSJH7WwWEedz8IpEATkqtXoV7VMoVN1BWop3GHCJXYF5JHqAd
         EWRKsroR7+RBPdTkuqHHTpqk/56Djc+Jthp9LJVCVJJPNpwaazeuuHjEb4dtWf1NtpWO
         lyEW2vb4WTq4l9goefVxYLwGVVCmRWDKGRdizzvMDedWpL+wts2Gb3EvvleqjP8TRdsA
         Cbwj1tCC+0BGEM34O0CmNk04v4yQ7HAJGNMc+D5Ad5NzNWm+uAzxdtDsn3nrStJOFkqJ
         YVfqI/+/LoQ+F3eBp+p2DA/bR6Eo51XbbOvx3jSEJqEitMii7epLbLBFgkh7ksyEMYut
         h1hw==
X-Forwarded-Encrypted: i=1; AHgh+RqGGiuHSjKcqZcEk/OaXWnWG4D6+SPcz5PTelaf9NHwyCie9fEnIg3lJWkeojHcRUNF7JezB3ASURSp7KcfiBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxCWQv+prt3qgE/BLHrBdLuOcWWu2oai9Kp+7NWRGhpyH7VtSn
	+9v4bfmejTxRXtTDSunS6UylCObJnXsZUmL8NG3n3qqAsRH7SCHiAzrsGTRRK/4H1gBIXg6h9PJ
	xXh31sD8fuUjYn/H/KCaOFNITvPvPZxd9+KOHd1naIsNPEonoOG1XIoaGcT+A3PE84hX/C5o=
X-Gm-Gg: AR+sD12QJQWiyuB4qzG0i6JTPGblNeiS84KRyIf4NSL8Fc3jmNZewuU0G1it4NSxZeM
	WiZN5/Rpyn27YjeJ/7x2QCn5KYwfIONjWobF6pnc091UXqdruGvup00+5lZlT7oxFfEXzJxt6G7
	ktXRxFCRrMdV51tzNqBqUx5BM2OVfbzgVcg562yYa6pHEUD6cVpzmvlCH3xW1hB8a8qGReQtsNO
	fJgcCQurmMKbyO1ZUsioK3Bbp840nHC+JE1cVba0l5KyKqqBo7+8z/vX6s1Pu95WwOTBrRCPMwh
	WOt0evMpnST45Cj9yZCmn3QUsgWB1BCbdY68pyoacW90DT9smEGIZCM9+AvAguJ1ZWulOa2xZQt
	CeoER7Ka2eEX1GJ6ZSIfhNg6HjypinIEiQROdalRbcVsX0Ml5eFA9JAVTzL26Wo7mPKM=
X-Received: by 2002:a05:6a00:3c95:b0:847:88aa:4f4f with SMTP id d2e1a72fcca58-84e180acff3mr294744b3a.7.1784664679307;
        Tue, 21 Jul 2026 13:11:19 -0700 (PDT)
X-Received: by 2002:a05:6a00:3c95:b0:847:88aa:4f4f with SMTP id d2e1a72fcca58-84e180acff3mr294727b3a.7.1784664678877;
        Tue, 21 Jul 2026 13:11:18 -0700 (PDT)
Received: from [10.133.33.193] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e1723a089sm235566b3a.8.2026.07.21.13.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 13:11:18 -0700 (PDT)
Message-ID: <f9bbf92f-d617-468b-a5b4-2367a1d9a751@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 04:11:15 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] Bluetooth: Add generic support for vendor HCI frames
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260719-support_vendor_hci-v1-1-764523a4ca3d@oss.qualcomm.com>
 <CABBYNZL_H2iRAshF-RCX41jbt0jots5i5W=aUUJC_wEN6wzp=w@mail.gmail.com>
 <0c5a924f-7382-407b-a0f4-dfd7dfe0d5e6@oss.qualcomm.com>
 <CABBYNZJbyfqLGNdXedi4+ZDNW0VNsiChaOTEb02Rz4rYd6UyNg@mail.gmail.com>
 <b37e1706-6a36-4e07-a4ca-8a7dc2bbebe9@oss.qualcomm.com>
 <CABBYNZJn2VvcNZq4xE2XS8ZZ5auVPTwB4W7q_Xpr9eNUALsfGw@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CABBYNZJn2VvcNZq4xE2XS8ZZ5auVPTwB4W7q_Xpr9eNUALsfGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIwOSBTYWx0ZWRfXzjHx2th8yv+X
 549zjYSmM6k9TF2p+bs/Wkfz3LU9MdtEELOY+9ASFkn3czxL5vKfdGoWqFnLgn23eW8KAMsm6vt
 Qp4spN5RnK2wKlDL6wHzUkOLl9vMtjY=
X-Authority-Analysis: v=2.4 cv=Ipsutr/g c=1 sm=1 tr=0 ts=6a5fd268 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=TtAbrmqVTDRL7XDSG4AA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIwOSBTYWx0ZWRfXxAi0rY1TIMwN
 GVbNmDRbIR77ty01zK6qWaBShKLGiZonobFxIax6VlHW3EFuG7JUKMnOUfj28lEToJM4o6yPJZm
 IR0LURxdOLdO9f5rKzh3LQZsy0F1qL3SGRavn6/Gghm9h8qgYpgiOrZYkOc+ZU9PkDuYjjNz0Pq
 JxGQLYICn5GmaL7FIXl7EuTi5SxJK3wRt/MUVxyFMYkbPps7Y2uBHJDLZ+4skUXGQpNqjb8hy3x
 fWDj6VeJuHYacWdYerCu4V/mP+QMtyS9sFsvmXGMHvSt0qYAWwfsCErC+0JnbmTbH7KvUzORltE
 GoVIjxq5BYuVj1axQrQRW0OLhfFzJ5fmDkdEb6i+AOhDuKmY/ZLJAUE7rHQ2tCtYxjc1pMrmbrp
 KqTqm9RVYP0AN8RHn/5rItZepUuVrsX/ZuxId9LrCK2Rh/opKUzu2a9v5qFytZL7qOLc8tUzv1K
 36g3jxSWqXoRm+5i2MA==
X-Proofpoint-GUID: NC4Ukrw0K-VakEp1eLhnM8vHdH0puk7p
X-Proofpoint-ORIG-GUID: NC4Ukrw0K-VakEp1eLhnM8vHdH0puk7p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210209

On 7/22/2026 3:49 AM, Luiz Augusto von Dentz wrote:
> For the user channel I would say it would be better to always include
> 0xff. That way, it remains agnostic and it won't suddenly match a
> different packet type if you change the vendor or something like that.

so, perhaps, you original proposal(Option A) is better and easier to implement than this
simpler one since it uses consistent way to decide vendor HCI frame.

1)
userspace <-> kernel : 0xff + vendor hci indicator.

2)
for RX, transport driver stamp with HCI_VENDOR_PKT before hci_recv_frame()
For TX, transport driver pull one more byte(indicator) for HCI_VENDOR_PKT frame
tell type of vendor hci frames.

let me also give a implementation for this 'Option A' as well.

