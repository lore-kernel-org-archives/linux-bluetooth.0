Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230486;
	b=Rpv+kntoZqw1xSevb5fBcSlDqtw3FXryqqEX9lNx/tGIodWFlmFPuoXLLmv9LYkX5ylL
	 U09a0H6Moi8MaiklcIPf5Ju4Y/N0psQeptVVygiie+6XBGtsv5jKBU8mvZCPlT7HjgmiM
	 165z2FjFKX4dq7uViDG6sbqzE2AKDM9XERWsv4LhLOPoZYqFLPGvmHk3pfFsxs72g5Lpo
	 QtRZfLYfMS3O+8okxOIQR4TbZwmKpB/qRZ05vQPDTWjMRCjlOK6VwzYIyaZDF60AGJLDR
	 qPfyvRkrDuSMbKziRXUN8mCpnWYJ66voHH3rZlE1k9pRXNDN6cVM6xRA+B6ERVkaftw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230486;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/NSerIK26JDI0Rl094/CDPF+220aUgaJX4IbYbyMv+k=;
	b=MBfuUMVEGlCb8Sk2Garb4AKzpOu16bBUU/SVdD1Zo39/OgqVkkXFCkPQSqgqeqzSsny3
	 u3Qwy7SZ2QP9kFLoEVFU/Z0l4bbDyzQ7Hg+dojotUgoJW2+lrDfkZqcdqRJpkWn/Fi3rI
	 jXPK3FANDqsKHHXDmHXIHuFGmKoQ+OU2QYnzYfm3Cw5DpHtZajYqT4I/lM6Nqeh4FuMqZ
	 /r8WmOWG87kM9xejWgbA2FxqmMrsG6HgWmowRHuNIXSQeWAIA/DdH9WsEBNm4iSdjxCAY
	 NOg0MRCPhf1tZWNPYxAdvMp1+mHNY9fGU+O5Dnn8xRZ8tk1ureXcsv/kTraCwhJGh8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hkJMqqVm;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E2zD6PjI;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18910606A331
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 13:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18910606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hkJMqqVm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E2zD6PjI
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DFF5b359369
	for <linux-bluetooth@vger.kernel.org>; Mon, 9 Nov 2026 13:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/NSerIK26JDI0Rl094/CDPF+220aUgaJX4IbYbyMv+k=; b=hkJMqqVmmtkUGTb9
	KAsWQ9W7l6lXLkPOF6/KtZHHkva9eAlkhTzfA5GglsKQ9S0LzwXLDICUDT7bSy2W
	gzFWKj6K6dytefVXA351q9gAUaUoEvA1PsOl8pJFn9cL2THl37bNMsdx8F4b8U+M
	OKkqg0rcHyZJGngjqwXQ8PgOoh1TCZkB8Cj3lFhvqe1TD9wqlh0ZEn7uZHeAxRy+
	99s7N3K3AaAjNy5LkjP+Z5Gp0etbncYnxm6nEzU2TO76tn1kIina3KdcsOQk3BRK
	FvdlAW+VprRN2b7RIHEc9SXIBX0uc7UlPXFInMw4w6lSbsZJcDchIkDjJXgW6Zi+
	dqHT/w==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2ht9x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 13:21:24 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-540e2737afaso142589b6e.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 05:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794230484; x=1794835284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/NSerIK26JDI0Rl094/CDPF+220aUgaJX4IbYbyMv+k=;
        b=E2zD6PjIe3rc2o4+u16yBnbJ6Jfqm+Z6gFxdqii4HcORQ9KoHQiQs/PzwPgBYgum57
         rsp0BhBl5Qr06C89A7VCI5HlEdahi5dk0EEtnpAXeE3D8jhxJRWqxOWLfcaD9NzJ7OC3
         4ab5d94Rn97gMIzadwO2slxS/to8jUrldI78XGiwYoMOC+hE3fO8NV7sIxgzJGgAIpew
         Ri2cosou17OZCnGBljppNOEyIOLuBxJse0ybz6ICcA8vesi8TVHo8ojWrsglPum4DTxq
         6Uztj5y+/kwKEJEMYye8Ax56LmrV1NosKBK96Byu+1VinU4y8vJd9qXibrCHuj3rY75k
         GO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794230484; x=1794835284;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/NSerIK26JDI0Rl094/CDPF+220aUgaJX4IbYbyMv+k=;
        b=uXKYy9/Zh9H95ygUU1r0emNDIApUdfO2PPh2mXa70W8gxQvWDg8d6LeDsZM1BecnNz
         niPzgdnCGl7W+n0PALc1YmEiLTTB81kQc89q8f13VzBJVKBNxyFfn5Hxs8AM5eDPt6Vn
         oHJvhBKSD+j2NT5lQJy0d28vjKtQC5F12NbIzdkp8aGtYzLIjJOllADzo43aWy+nNZ4T
         iuu8ojN0yqD0HSrHFfHZqH0S7ct+3Zjh+2yHeeS8O9G0XT5UjPs4y2NxbKu7e4kgfCd8
         Nmut7+lvU4Nc8Z7cymk4pz45tSd0cAtEokYgiYjgz8CJCRRdUwYgpz9Qvweb5ECjxNrj
         BRBw==
X-Gm-Message-State: APuU4Z8hdZX7nycDPZZCN7ehTw+qQO/6iByaK1EteYwLNoe3k4qrMLOW
	QQalxm4LDBxr72apPqbrNjTHrj+ag71FzGe8mDe9t9sF4A5+KyZEiaNhi5r1mjVftKxMBYZ3RIS
	8r2tTS0uHJ0Picz4CfsluGEWu80mq1dzp0zmvOrekwwjrFX33W1kDfJWmSLtVFAi0uS6uPs8=
X-Gm-Gg: AYBFou2ud19ZtGQCy7vbF1MjwW+6b4uwLdYPKehzlFmBpcyumKnFMOY2m5d/t0hk6G6
	WSRuisMAQOu9UxIeV8aBwjahLch/9FHC/vAR08KnutL8DzVzGh4pqST6gO+AtgHE4dTLAsluaUa
	rTMSqJwuY2cSJf6i+KemiSisv1NtugiPv7aRF2BiHOZeM+EtWgG9bKXNvUbccq4KlYIUfBlFxxH
	Ju7MgUcn2+QxFHAPHfFfuohoIsz/T8ZaHY/mkPX16PM9zMUcWnhKQfVtFRpX7z93SVJPkATNc4T
	NXuOGdYWBKudfzz3hjafMULhFAe04sfn7xzSqfDrYNsYYW3TZuDRA5XGROpsU2Y2De6SqnD7GJh
	BZKrUQXvhd985ltqw2Wq5a0eArMcJNN4lfsJLkpy76CRIGVRm0P3hsy8xJKpx+LWMdbnQVQl+cn
	5VjvRUVyjuehWAyv69EM688oCQGAyNDUfFsXhLLQ==
X-Received: by 2002:a05:6808:151f:b0:55c:836:5991 with SMTP id 5614622812f47-568145d16dbmr3514864b6e.3.1794230484123;
        Mon, 09 Nov 2026 05:21:24 -0800 (PST)
X-Received: by 2002:a05:6808:151f:b0:55c:836:5991 with SMTP id 5614622812f47-568145d16dbmr3514829b6e.3.1794230483624;
        Mon, 09 Nov 2026 05:21:23 -0800 (PST)
Received: from [10.249.17.71] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3755e936bsm16424052c88.6.2026.11.09.05.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 05:21:23 -0800 (PST)
Message-ID: <b83e0172-2f64-4e28-9750-1a5fb3dd6b41@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 21:21:20 +0800
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
To: Hex Lindqvist <hex@freenixos.com>, Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261108042008.226295-1-hex@freenixos.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <20261108042008.226295-1-hex@freenixos.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af1c8d4 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=1yMu0EPtAAAA:8 a=R9AuS3ga4yR-WR3Dk5QA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22 a=SEfTHXpE1d58HhVYHZyM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1MyBTYWx0ZWRfX++IBVxeCyS1A
 r0hYTL1Oos5gOI4nv2MxAX17CTb4LS/S9Ng9tFU2LN4aq2sd2x09J55kS5505MSjTbl1RLYEvka
 S4Y5arhvxBlnernvhNvXxEM5sLAK+hcdss84ypSEfjHwVKZmbub33CIDcBc28bFDEDPJTjwHkXl
 rF8z3AUc3PfzD0bG4xJa7As0eCHVgkdH52XUP5v5rZpcEgjzww2bdSWIHRYXNYApu003JiBAkA/
 RNgNmN3FlgtDc5wY9jeyfj/f9PXsf8arXaw9zrU+9bOvejpvEwiHm6FGNGm8V4Hq4GJKmZvK2DI
 7X0HmRJXTyP7Xdy+w2Q3PP4OPQBCZan2zmq16foBab9Ph/rAg7WeaykOwKjDFvh2+tQMRc/V7Z0
 oM4HlXu/HKipUjqrLef5vwSz1P5aY8II4ni8CneXT5nIOwcDTGB1Sn8ur5PwMv49bQ2QjWC2Opq
 +vyqq0ZyTFTSSvjVpZA==
X-Proofpoint-GUID: oAfmtM6YMjciNW_NNFZ5TqsdkMdrciTU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1MyBTYWx0ZWRfX9uZeg4XGofAy
 2xlBfRrN6Y1tXWW9Fftkjf8P+SPT9qBoYNX0e5Ck/++EsPjY86Mg2tPsEHs/mw5b12UZYytaV8+
 BLYNHoGkTgiUHFUiNuj0gMIs/EQYfZ4=
X-Proofpoint-ORIG-GUID: oAfmtM6YMjciNW_NNFZ5TqsdkMdrciTU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090053

On 11/8/2026 12:20 PM, Hex Lindqvist wrote:
> struct qhci_vse_memdump declares segdata as a zero-length array in a
> union. Zero-length arrays are deprecated [1], so use DECLARE_FLEX_ARRAY()
> instead.
> 
> No functional change: segdata is only used with offsetof(). With debug
> info stripped, btusb.o is byte-for-byte identical before and after,
> built with GCC 16 and Clang 21 on x86_64 and GCC 16 on arm64, with
> UBSAN_BOUNDS and FORTIFY_SOURCE enabled.
> 
> An AI assistant helped find and check this change and drafted this
> message.
> 
> Link: https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Signed-off-by: Hex Lindqvist <hex@freenixos.com>
> ---
>  drivers/bluetooth/btusb_qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb_qcom.c b/drivers/bluetooth/btusb_qcom.c
> index cc4cfcde2afa..97be9078e045 100644
> --- a/drivers/bluetooth/btusb_qcom.c
> +++ b/drivers/bluetooth/btusb_qcom.c
> @@ -533,7 +533,7 @@ struct qhci_vse_memdump {
>  	__le16 seqno;
>  	u8     subsys;
>  	union {
> -		u8 segdata[0];
> +		DECLARE_FLEX_ARRAY(u8, segdata);
>  		struct {
>  			__le32 dump_size;
>  			u8 first_segdata[];

NAK. Please keep this as-is. since:

1) segdata[0] is a familiar GNU C idiom and, since it is only used as an offsetof() anchor, is more straightforward than the
  DECLARE_FLEX_ARRAY() expansion.

2) I guess this kind of isolated cleanup may not be welcome.As noted in Documentation/process/maintainer-netdev.rst, simple cleanups outside
   the context of other work are discouraged
