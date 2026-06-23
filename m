Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0679636EABE
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209370; cv=none; b=pEXBqfIYesopZC+kloKPfh1tZXHXbPBjpqzfSZUtW89BD2jHImeF6Oj2QXN606rn+huyHrbrp5iTvvSOIe2D2HVElUY8Utg9+8zbZ1Ia/O9fCuvt1WL9Ma1WJzk+HbixZFllBMQ3kAETWCEnNKCF29/3gbFYdlg0JLFaD2t9Eto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209370; c=relaxed/simple;
	bh=X9DXsCXcUguRFcOH02yhbRkuiA4xQ2ZmmuhftcgWaI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRh8bl4ugv+8TwXJ5FcL5uMYkmi5cA63hhLb03lkCFriaiT8RBTS0f1N34mch7QMSkB8YTvtvY2Y7H1C7q4uVCFO1RYa5gJBwbXHRb96BhU4LN1k46LyJMXPC8VBJHPHMIBYd7c66Q2vYUHABTFhB0Jg23u3lU3Q65RVZ5ih30g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kzN5Bekh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c2Ek287N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kzN5Bekh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c2Ek287N"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N9KQeh3918855
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 10:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X9DXsCXcUguRFcOH02yhbRkuiA4xQ2ZmmuhftcgWaI0=; b=kzN5BekhgGjAn8ET
	WsiycQsJwo6YyEJJR8hoMHYYu2W+mFQQq7+gJ94yQrMCIHDn/zIqSALJu2hodo4F
	rCFpFc4mb8xSMijRZxAjW8JcyXSg3PriOLr6K8owObFrcCck37bRZPoM6HrjT6vi
	0SRM2Pg1bvdehbEDI96XtAgPtPw+QV2MktYNz8jnp9YDrXLrOGjMkBX9rZ54Fn2H
	lPd6IPYAqsW/4W77flM7RiSTleVVjagLPYweX9B7PnTBZGFNuI4ltcjzhBxEcBUo
	ZSArF+j6U2fKB3kjR8P/MgK7KIgyqFn3rP1HR0LRHil1clkPB+8P/Rhc4g8FOVTE
	lWDzww==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyqe688en-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 10:09:28 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8423ef9d3d0so1460722b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 03:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782209367; x=1782814167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9DXsCXcUguRFcOH02yhbRkuiA4xQ2ZmmuhftcgWaI0=;
        b=c2Ek287ND/30CrXF2hJuY9rQL5vKihZLDrW0S2O08quLqOk/bQfOx1isPkuQgyfZLh
         K/7z6+9aoO4nSpD5EwJjAtAe6fHPiR/yAtNf1DckAKjuDB8DDtYFXjswfzJ3mPWHinMg
         +Vqvtqa8/VEfLxuehN/ZrnKERgVlnxVxbzDDDMR4Mm++BRJLnxQB+VPxiAAJeqYrS9WG
         TWkQl/PR/T3fP89KrqTVSPVcjXiHlaMbX6KgxP8exOS4XuIiRkglcURJxRNSd1odmC0i
         hllzCQZDy04m7yb+aUAgURSYelaAiNJ46YwMbHYZ2mDTwk7xPmZ7kPv3dd3UKG9+452L
         sOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782209367; x=1782814167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9DXsCXcUguRFcOH02yhbRkuiA4xQ2ZmmuhftcgWaI0=;
        b=AW+Qi1i2bcC0w7bx7QWweGvsa5O3cNrxDEPwgU0ztN2R5oeL5d5MfZjdaQm3YGAQJq
         W2xQWC7ctF4HzIIgnvRTAY7v+v0TDCzmHw6aRpbwKQeUR0OZETAVu3kJDgffMdOORvvE
         D/NVHDRDjvg+j34TLoEy6L7ATAS3qly6mwQhkpumFHI0eb5OwGaag1aesTLDqGJGBDSR
         4K/X31RMfiEG7iUUdewGfC9+DE+ETH109gDNGEVe+owMHY1nEUSgeihP+GtSu7cTYL1z
         RQZqBLQ8bBhPEQiR5SL44wese1wE1r+9JbH2i6b4LfE8WMjJetvc46UznNOP4OdB3WR7
         O10Q==
X-Forwarded-Encrypted: i=1; AFNElJ+XzSilmZvYlmCXiwy5/0k488zbWN5xYQWhuYv/vSab9QAzz24ed0Y+VDHoU7IFwDJKoiGLMGhNNh41xAZCBqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPKrZHIBs9TVcbiRxNfssDs/hW0kj3LT4ijQOcs3Gdz0MLNrTU
	OyIpLtB7QlQQ7dFo/lDtpfi5WusA55hojTQPI/yl8stHwSRcZu3J+4Dp8a2o4pxAOcrsoudZ47J
	77xl0Q9EvsWzezgXQSMFCbHhLT69K3BtXxlWonux4P8javaBIcSf04MckeGNxS92zl/o8VU0=
X-Gm-Gg: AfdE7ckm+sPbYf8k0MBzn8GC3FA60Vuh72hiygx+kglJnkoK7xAk8BKthhZ6Q4Xptja
	AMCNk2AgdUd8oSoD0TCQpheG7+Csggu9A4nTCwg+GdZFSRv5hTPDgcGYC0GX+ILsJ+X0dwqNb6M
	+7w9qlRiUtmSXIB+qEBz/eINxZIOMlqxxsg8lxUBIYRKehSCmeMNtKzO6yW/D8e298WyvxPwhEG
	ysD/C4ZGCNQUHRF8lgtSEasoUAjtI34ltu3lK6jw2z45Teuyj7QUq7MZvtie0bwHcy6Uj+XtMdN
	yhbtVJp5Auf2rzSCGo6DKzH0hiBAXGk0h6Csnw427QIr5cAN7tyOatzypMJ+ZrTKb+KAEquUJ0d
	2WzBw4HloXJ6fzqrWhoLtW4Lv6AT03mnX/hcRtAPK+/HwoVngfbuaBfYDBkJa+H+d545jxivviU
	esXQ==
X-Received: by 2002:a05:6a00:2349:b0:842:3be7:4d56 with SMTP id d2e1a72fcca58-8458f1da7ddmr2344673b3a.2.1782209366852;
        Tue, 23 Jun 2026 03:09:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:2349:b0:842:3be7:4d56 with SMTP id d2e1a72fcca58-8458f1da7ddmr2344647b3a.2.1782209366278;
        Tue, 23 Jun 2026 03:09:26 -0700 (PDT)
Received: from [10.133.33.161] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d68edasm9701039b3a.1.2026.06.23.03.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 03:09:25 -0700 (PDT)
Message-ID: <b0da0e72-e0b8-43c3-b925-9a1b6deb924b@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 18:09:21 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] Bluetooth: btusb: Move struct btusb_data and macros
 into btusb.h
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
 <20260622-bt_bugfix-v1-11-11f936d84e72@oss.qualcomm.com>
 <CAMRc=McmkN=Oho2A+XWgvrRG3QfF61HaPkeCperSaiCzqOc1Dw@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CAMRc=McmkN=Oho2A+XWgvrRG3QfF61HaPkeCperSaiCzqOc1Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: l8eqzzZZTpYPf9QOikXHGLInp_uT9_9V
X-Proofpoint-ORIG-GUID: l8eqzzZZTpYPf9QOikXHGLInp_uT9_9V
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA4MiBTYWx0ZWRfX4Xoim9QRjcEC
 HOx8G9blKKVOQTIcOYpSH6M6+qQ2aMshotzX6Zer+8zLXBDaZSr5Iu0Uq1lGyq8nMYmjpGZ028b
 8eCtcWp3YNj4VagPLvsdhiuRNuDjuFo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA4MiBTYWx0ZWRfXy8OGRMGwapBh
 /AoQQyklTcFt37nz6rvRX3AiyAgUZA7u6YTUjLqiAOVLpb0PUDuf3JiMnmyxTTVDa6u/jf57orc
 noHvtLI9tASGGk1wzKGQosS7iYPifBmVCV/cJ0qiMsydkhsB7wN0G/+EjujWjERgYXBJU+UNtEi
 hdhKlb0uZ8ej6ejxeVkHreJUMPxjUo6j+hONJREpTuartKmVXX1IHhVOcGset9O9UgjHu8WSglK
 Pn2aEbJ1OE876Mj0PjFAWWD4bGO1tZhQ67ouJxONyA86gFQBgcwQ7qSVitwEL9hDwMY1Ue0In0E
 aNQ1HF/RnKYP0PFdfpOXKLozubUSdcxE3CrfOb2dbzX7zon4298pLU8w1I7pkCuRmtHGjQrGRWT
 WHWZEblhNuDiBZW64z+NO9PeYC2uXrdhldbqmzVAfewrQsjrzx0GzrNbVDx5rxCqdTtNhyAWfh2
 VklYrFPXQtA+bWA0UPQ==
X-Authority-Analysis: v=2.4 cv=OeKoyBTY c=1 sm=1 tr=0 ts=6a3a5b58 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=7d7NGZtOMGS5_dLLPmkA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230082

On 6/23/2026 5:02 PM, Bartosz Golaszewski wrote:
> On Mon, 22 Jun 2026 16:52:24 +0200, Zijun Hu <zijun.hu@oss.qualcomm.com> said:
>> btusb.c is growing large as vendor-specific code accumulates. Ideally,
>> btusb.c contains only the default implementation while vendor-specific
>> code lives in separate files for easier maintenance.
>>
>> The newly added btusb.h also reduces unnecessary data copies in hooks
>> like btusb_mtk_setup().
>>
>> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
>> ---
> I would be ok with this if you added a user of this new header in the subsequent
> patches but I don't see these so I'll hold off my R-b until you can show the
> need for one.

Right. Will drop this patch in v2 and bring it back together with its user
when necessary.

