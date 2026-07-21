Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4283B2FC0
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784666530; cv=none; b=Q9uUzTwesmP9PrLX45exeynKFHixh9QxaabzVTnUqDFQi0AbPRJVrbg2xrzI3HAzrGKAYaO73A0pTY8u3d0jKzbv8FlmDA5uvt1LFp5aTA38z/MrFI9eQtLAMVgdGkC+GGRxO55zuQplYPcmt0Iwm3vVw4q9TBX/Ft19iNcyYug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784666530; c=relaxed/simple;
	bh=lwdbmLGKUdqtrT85MqXvi7DihUx/SRx6W7yI2oYqhYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0gs88zD+0wrZbYsZnrvMJKKQie4XS1eL8OughqjPSnzTSZRFuYapQ+8KuMnVCVqN9vQsn4aecGy8h7ypjrUcHcgBNk8gGSjz/3bbaUOrFY1RfrDAcLPcXhO4O2v2v/s7mCqYRHeT6JsbslWW3HkXo2mNT0nrwFHys0XLNrWcko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TQgAAMJJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NERB36Y+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TQgAAMJJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NERB36Y+"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LHR8SW2375959
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 20:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lwdbmLGKUdqtrT85MqXvi7DihUx/SRx6W7yI2oYqhYI=; b=TQgAAMJJ5nhBFaSX
	yKDWmenWqVgEDZHy9r7+4TZw7kbE1i4dPq6pb/v5pVzb7m6nGDVrxO4H4cXymUIp
	WTwNyipQ1WEesCyrTsoc//JblcyeyvWf/AxeDUm7mpGc+1YHiNhoJnMN5loL2c4b
	wAxfvZrkGGD4dFUHT+FzlSIF+Rwk9aZeX046iYLTEnECs4uI0npu7bQaoeKVtaWy
	9uTjtMiCw1M8psMQNvYJqZlo87AV4w9OniycvNkcCxkgKKj+vC5QDk5nedmAWQez
	V8RPMx/cVUIRPe7C7ntiJMLhczP3I5UU8Qe7x41TqLc3O8haaNtFt5NZyAAz9tyZ
	QFdUKg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6a8su2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 20:42:07 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3811343bd68so3456933a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 13:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784666526; x=1785271326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lwdbmLGKUdqtrT85MqXvi7DihUx/SRx6W7yI2oYqhYI=;
        b=NERB36Y+FE9AeMU2zpISy5qvc01zcUUfQlg4bfy3O79z2dzG8uAh0SiE/+qdT/OvXt
         jP26sXpBsrgwlRT1xTCHxiCMMD58iCxyj9ajo3e7EoMzt1vjnaXbLgX3ePEMymDQ/Ol4
         MLjRegOhLFU9KYQ9XriHfxaQNbD77qNZcjTdF1NZwqGiQVhQUPiNYVigPeGR9Bu6Pia3
         Ax3H7l04eyUqHQKjMekYMSV4jSol0Tk3QqaTpkMWDuib/261/WABkKr2Ga+4JUNm5u65
         gJMZ8wIUKbCBEIgZpiHronJ0H2PAwUs1rNO/c0yXQra6gJCLT0GiUrFkvSO1OhZHtnUr
         HIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784666526; x=1785271326;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lwdbmLGKUdqtrT85MqXvi7DihUx/SRx6W7yI2oYqhYI=;
        b=TeJ9eiV0e1rky2hZwyDCmFg8mFW/wXFtyiyHWNkchCmrQU9yFeVDrEBThN8V6DwInL
         HsVY7OLa770zmfwSjm0o9UwaT2Ay7kRcgwm2xjDjrETPzEEo3CSvXjX4nKPRh4hNX5ea
         EaZxbjow3+0maj78WAXXD2JoebnLLk4kkJYm8i1FMBXvGAn2J+8xQWuOq3To2uy+F+dF
         /+POuGBFzL3NZQf2fFhgDJHX/9pEleT2Xb1pkg1kHUjm0St2JR0ZQFfVYkaOSVo5VrqK
         IqMpqWNxf09Utk9q9zoPYnpGrHOKZpyin//R8Kb8lfKl9aDuml81uaM5Mmepu/5sJIE/
         VvgA==
X-Forwarded-Encrypted: i=1; AHgh+Ror/irwqQTZ1xKHu+x8VgRu8e8XEGOcfghQ4tNbPIy+uE3QE53an704OKHof5plImmZZR4KmHrqbddTC8RZKZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3q3e9l9k7QKSg8z+RK8kQuTpRrIgM5YNC3Y4qqEUjB0Pg5qoX
	e3OAflJMqNq3+ts2M3bewhyJjVFFblU//UH8mBsDvi9uqFG4hT1FEc6vbxjgm/nmbOffBrex/Zx
	hOwuQPxX2n9Y7+QgV/V9UntEWk1sCk7ZfLCblgnuZQbjboIgXUNvvqSXgbLiHIlepn9ETijxVmE
	9dCaj16hAk
X-Gm-Gg: AR+sD13/xt1VrMSlOYwxOCPoP7p+9aaGAD2RM5Xf/FTtYv9tCMMmeo8HFMVfdpEWq7l
	kFjJ8y8HeRZbJiwky1mEz/aODmiSrGK9tU0n49uW7YisCA4Y/3E2n8mEbTCNgN5YQ06h34RykVv
	JNR6Jc8ogUpDQZnKHkhzxkaWONKuj8c8SOFsuarWVOS9G4XxaKWoBuw5zo21K5iZ4f5ipNGd2mI
	XAFGLLSEYeL5tXnSxzg3hq9o1mXYTo0HgnsLhYounSWdRS6AeC9yNl+q1w/weHglb2B5nH9SPwR
	t7bjIMohq3kmGYP569o/KZ6bhEnSFOBdL22r68mBZ9zOw5tFj6m9bvaC0j64dVQj8Dp2zac5JZl
	QdpUyzL3TjUjBePCeZf46+wz+haBXz+FMEcGqaVfyTDmJaGLUmbaLTFoZW75W85xj6yc=
X-Received: by 2002:a17:90b:39cc:b0:38e:549:9e04 with SMTP id 98e67ed59e1d1-38e92946092mr4024269a91.1.1784666526409;
        Tue, 21 Jul 2026 13:42:06 -0700 (PDT)
X-Received: by 2002:a17:90b:39cc:b0:38e:549:9e04 with SMTP id 98e67ed59e1d1-38e92946092mr4024257a91.1.1784666526004;
        Tue, 21 Jul 2026 13:42:06 -0700 (PDT)
Received: from [10.133.33.193] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e9232c388sm2154098a91.6.2026.07.21.13.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 13:42:05 -0700 (PDT)
Message-ID: <ca8f0b53-5789-43b4-8a0a-f8b77aace44b@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 04:42:02 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bluez RFC 2/3] doc: hci-protocol: Add sock option
 BT_RCV_VENDOR_PKT for HCI_CHANNEL_USER
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260719-vendor_hci-v1-0-df2ac5a50117@oss.qualcomm.com>
 <20260719-vendor_hci-v1-2-df2ac5a50117@oss.qualcomm.com>
 <CABBYNZK0RSZ6xOgkx=wcme9kUWXFHydAvHR+EXwkp4eJwp-QKw@mail.gmail.com>
 <12ee8fef-c8b5-4e77-874d-789b24c5458f@oss.qualcomm.com>
 <CABBYNZ+mYA9xgXhXTUdV4C1jM1iFvFSvYAtVUbGavZObGFuhoA@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CABBYNZ+mYA9xgXhXTUdV4C1jM1iFvFSvYAtVUbGavZObGFuhoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIxNSBTYWx0ZWRfX0DqX3Gn/2gQc
 BVaKmiQgHzdUlV41+gEiG6D89Ms8eaSArif/3sWOefmbf6dtl2ZxSrhcVXPbfOmjlTR4oSKRHGC
 plleEsrVgnoNI/pcf2vIE6zuhX0EofN/IjmALkFwqKQEY0T9V+UH9z9f9L5LwPlSlzaN4oJ22IS
 wLEyLl4LbfVJ+qRTh3/wUUxGsUTe9eAnHI5Q/3ccHhwHFODlkbShgBxXH40RvtoaOGKwFVEn/q+
 u+X16VtEsfJX6aIPhUS+WZpsw7Ehdso/KrI1//ecP4xi/+FlnzuITIZRhm4wG++hfngWB2opcCm
 YSsumL9hov9xkGrk+l7sGjV17A1S6hFdnyaAY/N2i+y39SMYqYlEvKsRcYZPSRrKzHNJKA+Ll+G
 hkormfBxBHM9jglA2CgrN8MF34oUPSGKC3Ozw2/1fYR2Fc040w2PXcLOwqy++863e6xVNHi8fMK
 Sv4cYQ6MSrWN1famlNw==
X-Proofpoint-GUID: HFoRRDmVzRZiBbLfXdCOcrSipNGPu30i
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIxNSBTYWx0ZWRfXwA4L4DO+DSS3
 AKdmugkDqQLXrWuQ/4WeVlyGj1YgpFPdf0Y7LO3tr+XEXi8v5bFNJkc+uXh63IeVfM0TW1vALE5
 M21PV2e/najJRN1JcQA9SVMiBIyVzqw=
X-Authority-Analysis: v=2.4 cv=HvJG3UTS c=1 sm=1 tr=0 ts=6a5fd99f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=MP4AWPDoD1T-dU88cRMA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: HFoRRDmVzRZiBbLfXdCOcrSipNGPu30i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210215

On 7/21/2026 10:06 PM, Luiz Augusto von Dentz wrote:
>> Hi Luiz,
>>
>> I named it after BT_SNDMTU/BT_RCVMTU, but that may not be a good fit.
>> Any preferred name?
>> Happy to rename.
> I mean we don't need it, you just prefix with packet type 0xff and the
> kernel should accept it.

the socket option is to control if allow kernel to send vendor frame to userspace
its purpose to eliminate regression risk for existing applications

there are no regression risk in userspace to kernel TX direction.


