Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363D43BBFAA
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624834; cv=none; b=GCEctSe0hfCnwK/474KtpQ8cEveS+cglRBUHnhFB1YAQk8+0tF+qpOrteZIwuysTkeYpiLNP5t5tOMROlUzM0S9raK3e2Z2om9c36rUmUvMiUv5b01HuHmTNzWHKAkQ4DqxNF87MdT8TiZ0o/epsf8arCCgR6uGAMNW+F71nxTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624834; c=relaxed/simple;
	bh=omsWaqTepohYOXWWxQJNYRx8xH53mX/kD1Of+VTHI9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtdyFCW40R6xfsbFUqOB7TXapI6NNcBypliMBGjtmORgiKrvZILBoGwt3bKWTWF1caKwJaiGCo2Q0WN/LwFPKTOS8fMpN7vMR06iz1wYkQEVktfYbHBLbmyhRkTCwepnJpdqSksX7s/DkPqIKzfhy8W+yUoIFZ0/AkJ7DWdzeDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RiSHyx9j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E7cx6trb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RiSHyx9j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E7cx6trb"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L8rcd2527381
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 09:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aXqihp4PpIJoENaATVYQrP+ahMfTA8xJpTuX+1lu5oI=; b=RiSHyx9j2iS899pt
	i4imXTKXNCJadIodWt7KrpJOxvAXuT+P3O66J9g2MObi8NuU4otqK2gprHKk3jVS
	nFKwC/wzh/NztW0PNukCDlNcMiIs+mp2Yv2aLY9UIZoMZwydSuJ64bcCCMQWtX8N
	3j3qrkB3x+yyXsdkc4raDm5JnUCXDT7gWX4LCbsUVQI0lIiEGanY0p1BJiIuFldi
	VZXx/1/FW4049jYJnTZQ6qwYg/B0f7urKhJLI/IjI39BKL5P+P89BUaE7ZJwkae8
	lRT+S9Yi/EOYSVpl2idVpjiVIOR+p2c/07vAeAeeheXiRBZIrzioZ7b1MQt5v16j
	tPX2xw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1se18jq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 09:07:11 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84a67ed83a6so1437931b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 02:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784624831; x=1785229631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aXqihp4PpIJoENaATVYQrP+ahMfTA8xJpTuX+1lu5oI=;
        b=E7cx6trbcRh1oGgJSQGmDdGOHT1J94i2gYzwcS/VEVXlqEdayrEXfPVkuwCriUg3yD
         YhsYPC8sm/29lDkdGDaxJE6wm04hZ/mErwrzA0JGnVhO/ckD+WhC4/9o6I5kmxt49DlL
         hyYm3Luov2ewB+pIsEshpNgRWqErjgdeXjLTe2mXjphIFIWXdxYPIZ/QbZ7qi883PQcM
         WMKQ++90tw8/AI9RUh1BbNwiCSWjRPoGIK5S8zt7vKaKl6j5/qlAesN+kbq5wtmQcb7q
         L6HZChETN2U63NMtk5O1loGqfPkJ/APsjOwJupsK5iA9hqn/Rt+K5+BwayZV3SJTea/f
         +aFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784624831; x=1785229631;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aXqihp4PpIJoENaATVYQrP+ahMfTA8xJpTuX+1lu5oI=;
        b=LEw5wzBTuvGfSVYfdUQfCWPit61mVCAZkI+e0I60/A05QaYVRvJg7jwkRIqTgoxm9B
         WMMXtjCHCrUcLK2sVb4d1gM5SbYhi6wBE5ijbznF/ixW7CLMKOC23rvB5u6QiTAjhSWe
         mTZwHvCgjnlOSyZPJ0jQ+GkJP+7o9wZZRNEiuF0bJ24cSzPBLtXmqdk17EYcfnmjmh8E
         1VSE3yEdRm0/4UHzf7uGSXroi0aYIbJlgi/wFQqMuYfG3KzJAgf2J71GiGTfYPsW6S7C
         ZbSFJT6U4mmFjj3Xl1YP6giqLwN9m6AaRwsk8tUtmgFwU7OSyhm+yrfIca0DbuWc3sHe
         XWLA==
X-Forwarded-Encrypted: i=1; AHgh+RoM3E1ZToCCbr+5vNqzRTsEuhLDgHUdEcCiQaPn/hyRUMJzF11eSrANIsuQ7QoHDEjBbSfi1PZP8McxpCsjlnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHHRv2RFUkYTOItS2HNJmgyDYwPnfZJrIYuNYCdYLFsDLBleTJ
	gwfN6B7WXV3CDjuod7MyGS8ouck59zjCeeIuYNT+qPlEUEH21fMib1pANO72qyLVM4YuFv69N3x
	mwC2k1qEmtx0HvLcKcxRSdCaUmRF733Opl+Z6LShGaF5valkCucaGvjuntkLjHgffpYP+tLk=
X-Gm-Gg: AR+sD10NRaam/cvpsmdKRMUpBvRmmvktDH7WihdxlCM3yEC9YDOcuJQnH5IBGZtolcv
	XuwRfkKgLFJ0XEqYuQDum0/0QXjtG0mursCZgKdmverPTM5ckRAHqlIekE1FNnCDdH0pxAjSpwF
	WZ4nmmsPzu/4Id0OxgngrhLY85al3icdbdRy/DbUzvMOGz4EZ16ct+LD9hRJPHnkbuHmYlZImyw
	Udb+0vi7phgg3pwhWX2aSYKh/KTzmMZ6E14AvB2qJJSSW0XwskMOulOmgWXZaYMc3QfxGGxIaxK
	T+crKag2fZbP2TfdE5oH7+S8el2ibuaLUk/T3FuO9F8rqPWoOPWKcM+cy81Sd3aTDQyKY2eBO/n
	2eBHRVb9YH+ptgNy494LDQF29i8Nmzjgbkp8AEbEuLZhbQj5R/mzlQzIsUBgJPzBEuLU=
X-Received: by 2002:a05:6a00:800f:b0:847:9b61:375d with SMTP id d2e1a72fcca58-84e032dbdb6mr1866531b3a.3.1784624830908;
        Tue, 21 Jul 2026 02:07:10 -0700 (PDT)
X-Received: by 2002:a05:6a00:800f:b0:847:9b61:375d with SMTP id d2e1a72fcca58-84e032dbdb6mr1866514b3a.3.1784624830553;
        Tue, 21 Jul 2026 02:07:10 -0700 (PDT)
Received: from [10.133.33.193] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e100e4cf9sm8745b3a.60.2026.07.21.02.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 02:07:10 -0700 (PDT)
Message-ID: <12ee8fef-c8b5-4e77-874d-789b24c5458f@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 17:07:07 +0800
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
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CABBYNZK0RSZ6xOgkx=wcme9kUWXFHydAvHR+EXwkp4eJwp-QKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6DpWRkU4_HK-cZIQ7IpOOruI3IRRCpdB
X-Authority-Analysis: v=2.4 cv=TIZ1jVla c=1 sm=1 tr=0 ts=6a5f36bf cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=ws4eqaGXnLU6m-smUuoA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA5NiBTYWx0ZWRfX/pX/QR4Par6d
 PuuHC5d7ZPApIfwLyHQRjBlXm5taOuRb6dv6e/H1nfyJ/UGQK4IfULQprmHeurhcyUovXkOxe5b
 In2BSTLNXLVT5kytUxFf7kH0UOVIJGQ=
X-Proofpoint-GUID: 6DpWRkU4_HK-cZIQ7IpOOruI3IRRCpdB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA5NiBTYWx0ZWRfX2tghE0OPl4hk
 93DBpBtyFzVCiYk6+LW5pcwM1QPDXRYXYQSNF97Iv+r/d9ZKHA8dC6Y2VQfY3KjkVAR3GbqLcVU
 I5I5cLZYTEeW+qOw1uaASN5MNE/BC0g2SAM851nx3u9shy5CWT9BOjmmK0AnaMVfAsDYywJ0l1e
 YItrgIJ+0FLsT7COWgEOrtE0xkpH4YXKSeIPbxtCXS978kBQYBMLTRC02J35jxK0yDwEmdzvKFQ
 ubikFhRtmbnzgY+anHOOrAvMUTML/o+lxoPvQPPdU51CnzzhMmPMUuaj6L/oayO5ueuhdyAop90
 PBnngXuFSIJ8x//qLbF16vxamtxlso+vqDtG7w8wj5V6EuB+QBzy54eHNziwjGFrluZhwESzfQQ
 TwtxaChPhXZuc8didD5CorAZJwqfNmqOwu0Ab8c9f6J32eFHPqKKaogdKw6yoSzhd63PbY5ClLb
 +hKB8757QYU08Hg2hhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210096

On 7/20/2026 10:10 PM, Luiz Augusto von Dentz wrote:
>> +-----------------------------------
>> +
>> +Enable receiving vendor HCI frames, requires hci_channel to be set to
>> +HCI_CHANNEL_USER.
>> +
>> +Default is disabled.
>> +
>> +Example:
>> +
>> +.. code-block::
>> +
>> +    int enable = 1;
>> +    int err;
>> +
>> +    err = setsockopt(fd, SOL_BLUETOOTH, BT_RCV_VENDOR_PKT, &enable,
>> +                                                    sizeof(enable));
>> +
> I don't think we have any socket option with this name, besides this
> should really go as an HCI packet with an H4 header set accordingly.

Hi Luiz,

I named it after BT_SNDMTU/BT_RCVMTU, but that may not be a good fit.
Any preferred name?
Happy to rename.
