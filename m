Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270562;
	b=tfI+3PzQ21Ix2TFWeHqudYYfAICS4/+MhN12VXrx8hFJ+o+dyPPGzdBX/KEAXNokfZ+B
	 SbGTlJc+Y/8z3ou9UZo8Lw1xl7QvEs/ybOeN/5AuRQ3ivZUq9Hb2uhtVGxsPB0CN1LDxO
	 mfiAAG0AlIyniI+RJJiJq8tGgc+VBSeqMfy6A4u00VObRAOr+42IXeSGhEF6XFwbPzwWe
	 YfjVS4eVx53+wQnAKDsxELcWWRPIN7EJfFzs7YiJgg3vsVm032611UcxLxz5BDNckgiTV
	 jpC/b9+xdA6D2coTJf5kcREBT+AE9Yh+KCKSoG2qU6X9orozZ0HjYd4U4nhLz6fk1cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270562;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6pmydzSAQdAUDrp+IoEgmNHIbYgTtOkdvyqFFrFvuF8=;
	b=Go7FoR0QoWxfxjyGhfMzqF9OJmRGzmfrhNKhJ/sbVBAexLBW/jdHk4S6frO16TyZoqWi
	 FEq0Pt6/wXNqljMRoqmtupk1KRxUAhdtagV77X4Rc6CdkvXOUZrTjT6mq9yjzN+MNY6Fl
	 4s6zL+nvWRQoJMJwa2bA+dg4djvkxU2f0EoQOgRWhr6qP8UJ4fJVDL1GjwaxQqxpVim2o
	 pswFfz/6JJK/hkMxE3qLkpn7w5wC6oac6gqChr9+uE4hYae/0k3Isc8R2ShTew7NTMWKa
	 xs4RWjbItpsfmSI7+Xz1Fl/+J8Fix3WeuVT840Z6ePDLw7uIJ5XZhZc1Iw6j32R7/Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AZlITL8Q;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="aAc/V+Qf";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81B4606A31F
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 10:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B81B4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AZlITL8Q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aAc/V+Qf
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TAJt3A875497
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 10:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6pmydzSAQdAUDrp+IoEgmNHIbYgTtOkdvyqFFrFvuF8=; b=AZlITL8QAte/LEBd
	eNOHta7XVuJJMuuz6iQ9BlCSMRTchd7p8eWeB9O0pmG/prqbfpjEfDwNEuEai2yt
	4yX6V2VvMo9ct6DAsYl0w5+rscoDCFjl8COSnyF9dUP9YLpGcA+776c4RrKRxO1Y
	8EqDI9HS8vbovHR8fYz6BEKLDbn91KKY50gYSAZ5ssL7MDniTEbsr0fu1r/t0r5S
	tdjEKopbnaqxhkwAx+F7QfnZJsE1y5nNJbW4iNrjT6TWeWYAl3FFLcv0Et6qDlRz
	4fX2BFYlsBzhlIG5W9GU8sIroroLwPqvAyBBZ51+Dqyf/+yrgtbmGZqifHKSLhzA
	e116Uw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm4a202cx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 10:42:40 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad3bf3fe2fso536464a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 03:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793270560; x=1793875360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6pmydzSAQdAUDrp+IoEgmNHIbYgTtOkdvyqFFrFvuF8=;
        b=aAc/V+QfzspUbR/UmIe9mtKMf+nq6L0kmDUDtXQ/8yQZbY8KDuqiiCVj+9QDf+Nl0n
         wq0OyZzMZ7uGV+ZRYzWOqlbur8fSeJ3AMusIFkv8ye/JH5PqVtT48JPRylZtU/3NnfGf
         UbWv12kuBLStfq5LLfRVxsePUgsv39p/R+akWQlPIWpHknW3U8OgQwX0npWY9HpYkq27
         3oaWwRI6Q0EDVPCDvv7mbmk8Rr6nYnV8Tr2oOddis3hyw5lkZgJQ3U50G3G2Q8EUKE8/
         SyanqLOQ9pFwSFZiWS2WHvsg0RKCe4WaUs+e6dsJpjEDadzjMD+dKvUy+1vQdqJuuhD2
         2Wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270560; x=1793875360;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6pmydzSAQdAUDrp+IoEgmNHIbYgTtOkdvyqFFrFvuF8=;
        b=crZqbeLDFjw5T6zPvafMnfxz2sdV8GyMzWfPYTWdmjh4nhQy8otQooSFvx+cI51Hjn
         y6G4S3yZvebYd+1o9Lc8VWBloHDVaDko389bVkBfcMJ6D8x68nZIPg4pGpDvtbxTo6dQ
         E7zU9zFKtxa17QiaMsV0oBaclHevv42EkCONYGEV5C8nl/jd7GvAJ5XvCYqUr4E5HK+z
         sABq3PjTj090yqseyxw0yp6OyXwL7zHI/lJ7REM41OtUCELJAWtqXcz5CwjejbosSPup
         ji0Z5K74TdC0IR4TmFWFASdnNQXuAWa5V3vj2SKJzcb9HsDRLNSQmdssJD2QYn5tNnxt
         gtUw==
X-Forwarded-Encrypted: i=1; AKwUvBws319irmb5R4gdbRRuwX7qTypEs8RNfABDEJJkslJmo3XYkVJrV5zlTRCkb37+sadsZ6STLn2o3bNevhH66as=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgQt4zZbo46cc8rgd+EXaIb8NuSzk474iRc5Pf7n+LUkFY4/bg
	aIfkdEEFnVy6WDzaEkqHc9s09VkGznTe15esgIUSgdB1PWuLQb3Th4GzfE/cVtQR4XkqaANoKaj
	GZj1/xmtDl41rBCSFc1THVQqO2LGapepkkLAenadvg6moknEMxx6nzAPtB2hjCWmIKkrr5Bsrky
	ZiqrfJLg==
X-Gm-Gg: AYBFou20/YICLMq9S9gZKcDFpHXDafl1iKRGrDqnCRSqGsruRWJXObtW4jx4xHZC0yY
	aJvL4qlB7IS9QkRPKvA6HuUJnjdW8hQgt1uRbTlNh1/DYbqz0X84vN8Y6cmRNpurzMVYNEXTTMq
	xtTe+4Kp0IPoebIYa83r7wynhFJ4N7YijxK4SArQIL5xTIKYP77BtmnLgKqb7BBa8rsZAx8o0/d
	0iVN28dHRYNF1sl6nV3l7zW4CXk/J7Ff+++laoQN0sFW0C2BalkFH8YLL5Fa4nD+EDlgtVVdqLV
	sSh5mIuVs4Gx9l8UtuWqOFGJ9TVOaO8Gu7ankqNT/HwjRjDcDnS8F65vshp8IXhCzPlqkCZRpU2
	e7SVjjZh/FMbfdZ9qDhXpyQ02X8eyiWRX2CvBaZbgsA2dD3BPQzcqM2PDGAGm9wafZLjv6QyIoW
	anCB0KUZTIgz5dImtG+hbenqfj3Tb8DC1pIeNZCA==
X-Received: by 2002:a17:90a:ec8c:b0:3ac:a7ee:6785 with SMTP id 98e67ed59e1d1-3ae57e6bb71mr6503514a91.1.1793270560140;
        Thu, 29 Oct 2026 03:42:40 -0700 (PDT)
X-Received: by 2002:a17:90a:ec8c:b0:3ac:a7ee:6785 with SMTP id 98e67ed59e1d1-3ae57e6bb71mr6503486a91.1.1793270559701;
        Thu, 29 Oct 2026 03:42:39 -0700 (PDT)
Received: from [10.249.10.97] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9426ffsm3863361a91.7.2026.10.29.03.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 03:42:39 -0700 (PDT)
Message-ID: <bf27c4e0-31ac-4ee6-b7ba-afc6744e5c0a@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 18:42:36 +0800
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
Subject: Re: [REPORT] btusb: QCA9377 13d3:3503 on ROM firmware: HCI hang
 during mSBC SCO
To: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Tibor Harcsa <silurust@gmail.com>
References: <20261029013350.360574-1-yaroslav.voytovych@gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <20261029013350.360574-1-yaroslav.voytovych@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MSBTYWx0ZWRfX6t2OG1ns+px4
 A3YDXBB+ZosHw2gcGJ6Ulv6JKUht84EYA+tYcieUykbVeMNGjb94t7r9Ay5DoJXqeQrUWp1GIvV
 K51LTOrPcFBuPoSSKbgkNyXSTvmYIrdumNZPr8HrKfSUuwZ38rQBzEkN1nRomvyN6Th5qJRmGMp
 EAeY68gv8HobRBdlim38YZAZvzVYpP/oQJVE0SILrpyF+hGfBy+EhzeFQCBa2YYiV0PYtwksnOo
 EF7PXUlnFzluzY9AJDkWPzOHGAFoUWH5TH1hU5/iS/RrWSVn6Is9sFvyRkgA4einBibzHowjame
 FNgTi5JEfznYBxY3BZeQJNdL9N7XCrWYad/fQbwZ7fsqF3wOeuTgnUNupJt/wrgAjGbLJdLK53B
 G9JaXmbQDiFgBWuUMGhP3/3hvMdoeq1+DmTbsvzjbnupw5Y6sk8DrO0sIzRd91g1VTyKogWay/g
 YfkHhhY5YaT47+QB1yQ==
X-Authority-Analysis: v=2.4 cv=E8tYNqdl c=1 sm=1 tr=0 ts=6ae32320 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=6gusLllSuGZb3pXa4WIA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MSBTYWx0ZWRfX3J/nhHdcPBxT
 v5v6r9ApSgHTFXrqionOCUHXOcBKMC7BPsu23cBSusCzw73ojUHtV739qwAjO03cJeWqSWyqUKu
 Q6Tz+qJmcWb81p88mPR651/vaxm6VAE=
X-Proofpoint-ORIG-GUID: yVxcyEMP1OSmvtffEmRNU5aHdjnL-Cfq
X-Proofpoint-GUID: yVxcyEMP1OSmvtffEmRNU5aHdjnL-Cfq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290041

On 10/29/2026 9:33 AM, Iaroslav Voitovych wrote:
> Questions
> ---------
> 1. Is this known for ROME ROM 0x302 build 0x111? Is there an erratum,
>    an affected ROM range, or a rampatch/NVM revision that addresses
>    it?
> 
> 2. Is there a list of ROME-based USB IDs, or a reliable way to
>    identify such adapters, that could be compared with btusb's table?
>    This year three were added one at a time, each after a user ran
>    into the 0x2005 BLE-scan errors: 13d3:3503 (dc16388d45ec),
>    0b05:1868 (d54601f21faf) and 0b05:1825 (cfa67a1dbfd9). An
>    earlier, unmerged submission for 0b05:1825 (2026-07-21) also
>    reported SCO audio broken on the ROM firmware ("corrupted SCO
>    packet", no HFP microphone).

QCA9377 is not ROME(QCA6174A), btusb driver does not support it,
linux-firmware repo also does not have firmware it.

See table @qca_devices_table for supported controllers from ROME.

