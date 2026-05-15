Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F66B3C13E1
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 02:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778812907; cv=none; b=YcjSAkXB6QMKhLt9fiicmigGw6Vp1o12b0ArEZAl4XIKpyUn1xWLsAbAE4M2VUEvUTsJenyDtRPmNYnLPhdYzCzx2us9IrHvba7Vmky3Q3mPlwi1OcGQaA0O+6BypyQYdbLe+/IkkJDpF6u/zL0nk4UNt4ZB7GZRZtKtgpYsB6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778812907; c=relaxed/simple;
	bh=tQJDvtOKyvN91a7clBigJ7afY+rwLVSxfVNDBpLptDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oqg22CY/qPSETREA06OBS//x0K0unCz+bv8PEku9SiaLKSZqtogNNt6iid+0m3uU7qJIR4NWPV2OuFL+XngFtgzx7Dj904+MiaUjqG2riO5l+Cw1OcKpb0eHwjvde62IZy9cupnMlRxTLt7redY5bFZabppmqhVA2kEKcHGC7f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PXnNbGWJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=El++XoKI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PXnNbGWJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="El++XoKI"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EIpdLA718318
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 02:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T3pzRPBproSAwn3/k3NUAF7Dmxhho6pMAtdyQF0YbrU=; b=PXnNbGWJhiS4yvJ5
	e1MRzsW6unyf0aAhDixClz0/LOKbcapG2uct7MNBNMDAY5pPFAUCIMGOuyNkXBB4
	mWckSLVqs3c98HEXjKu+GsHIkIZ3Dh9H8vDsk2b/CPOIrOVMoiR33k/VTi0zMH5V
	4ABhIgY3jmS2rnuur0YwfdJ9izuXqe7i1n0co4nUQkTRwux+wR/yrloKlEOqNGb1
	ZoGHp12ffyCB3pxj+rIzetOmPbOSX1r9pZPKfnXEV3RYSAxP3gBOQIMnlKWwlV0v
	Ose7oNAjL+S1r6ZrcTKphCkZUZ2bXp3H0o0fNVB9for7TjAobJgdgqBQtLoZOz3M
	cp4IjQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1x16k6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 02:41:45 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-13312be8a31so8445411c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 19:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778812905; x=1779417705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T3pzRPBproSAwn3/k3NUAF7Dmxhho6pMAtdyQF0YbrU=;
        b=El++XoKI0bQY5Q1wszj4jnPeitMIYl5uJBLygwNxzx0dciToGiEvw41sK+TUr2VU3+
         0aS57/mn1twlJOsakmM1TGTw6AP0C8kpLpDPU/mTJKfCGi7Qutbaj6HKb+OMlncm5iB7
         KJj0bpONt82gklE5zdDggyTJNgOPgJJaSBpAT4yfkroQUTg+1F6qKygD7fhbo4DGa0F7
         S9FoFRD2tgxqIGJay7ZCaQ0K5h2rOTargJ2XLTJgtMUJiIfUCi5pXoG8gmBtuEGE7ouD
         DykAzT7EqD+arf0w3J1LVeB5zuHhami17ZM+VvTPgGpCZoFWeCi5TKvfOKaf3X7SkSxE
         vCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778812905; x=1779417705;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3pzRPBproSAwn3/k3NUAF7Dmxhho6pMAtdyQF0YbrU=;
        b=SI29xAjAbaK26hhl+2DHYMlsRwqIZoqDSVRetQZwIws8WngW99QowJDBzjz6Aawx14
         nd6Fr1G+/PUvf8VtWmuQ5Wv8RJVS4Rz2NMIbKD/8tFibBXnVArSCqctlUnYtW8zfR7ZJ
         Xcjy1Jpmt6Yky1ZNq7hmw0sIYIdA3CCXwXcLxYmeBr6J2Vq3RhZw+FWyLwUjvnaN8UXq
         AkzzTAlyQ6tMn3JZNjSzz9MGXifg/25sDrBQ2GUqL0NTpo5N6H/l2kRyClStuYeh6UvH
         8RnmDPsOeulksl0wtwxH/A/bbhZWglnlGF/Ey7TYYLhqdruCePj26l48D1jlJgbn1IUq
         hkhA==
X-Forwarded-Encrypted: i=1; AFNElJ/eVbMUoss2rQ7vow8/Y5uK/LrAoxjsZ+JigaCC3dGtJrh181TftklfWiBo2kqUKnRcXRadi6kMNK0D1mkQbIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmEx3HIbmgTGy8oT4aCOv5YMnKXo4bJmXbI95AjXAp0YhKhLvf
	MQvdgdfUoxX/Wpj/56kk87CCjErapWsD9WQWinvyAwK8gS/d18ScB7TgF95AhHjOlm8TQYgM7MQ
	tWeZQaBYzcvXblMVD+9YbEPq5+HDsBA+9D+REQ8H0c/CoBYlQAbctb5wHDrixRbrwqa/G9fM=
X-Gm-Gg: Acq92OHM975YemypL0Gup5fg6iRmli8/9igQ3DRRSKWJ6UObHnKFL7VSbuNuCjK117z
	KMbLFnGg7KlnOCXUmfGgxgf8EM2ot0ryUIjahwxexQSUskSnjgEIyTbI8r5CcTq4RPfTlCp4h6Z
	btdxLyS4upCN062R1UyqJ2Ksjpnt1fE9yxIvxXvUmjHp2Z4ImvZmk59nTytQIu20ZjCYNaa4s6q
	Zna3WmzyQQe/0f8ZmRBboHCASo7ueKBfoCTVZtjfsqmfIegLh1XunPRYa5IZ5Uu7C/2PjrO6ueB
	uDTIZd7q0UjKO1pbnoDnnhmgV9VvQQSg/DnytjkwOuw5g/ex1ayspEEwDLZZiyrb1x4u2WjNWyv
	RaAuye/GKjNfvlzmue7s2hv5IEe3p6h8jspashxjGC1WJkkXosEOaaIPPGTqqDieoxEnrRYpfiE
	C57Q==
X-Received: by 2002:a05:7022:1a85:b0:12d:d972:b96e with SMTP id a92af1059eb24-1350542e8e5mr834640c88.20.1778812904583;
        Thu, 14 May 2026 19:41:44 -0700 (PDT)
X-Received: by 2002:a05:7022:1a85:b0:12d:d972:b96e with SMTP id a92af1059eb24-1350542e8e5mr834618c88.20.1778812903959;
        Thu, 14 May 2026 19:41:43 -0700 (PDT)
Received: from [10.110.13.193] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cb5b3c20sm7689429c88.0.2026.05.14.19.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 19:41:43 -0700 (PDT)
Message-ID: <51a08590-a662-45b2-ba04-195b020c26cd@oss.qualcomm.com>
Date: Fri, 15 May 2026 10:41:39 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: btusb: Allow firmware re-download when
 version matches
To: makro-kernel <makro-kernel@proton.me>
Cc: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
References: <GCBTvsv1x8qAB3ZmSCpTLo7M63lTTXM2c5n1TJLmQuus0g4gViSSJVRZzl6CzehnMdSHDqtZkQA33RYCVSxdAm7tGEeVYCflhV3QgbLIcfg=@proton.me>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <GCBTvsv1x8qAB3ZmSCpTLo7M63lTTXM2c5n1TJLmQuus0g4gViSSJVRZzl6CzehnMdSHDqtZkQA33RYCVSxdAm7tGEeVYCflhV3QgbLIcfg=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDAyNSBTYWx0ZWRfXxL0UMzG8BDEM
 Vcd0cd/C15glaVJa6u87y+aT05nLXglO8URH2T/QpEnk7SNaau9ZKnAfXTdja0WIRKoTfTpiGCV
 6ZrqPhqtLkvZ6FWvFyxflyThYAqyVsaSR2zq4Ze+S12gkXwGy3Iq+rg7cyMm3ly44DY99FV48Wz
 NASG2jHas435qBei8+OtMAYKMZG6bGNIPlHswdCRHSVw9f6mk6ttDIO1bEH4bnVep4w42J/DZ6t
 ncjYwvXrQTKymOfZjjxtdBMcYj+p9/x15mFeLjLsOitYzcGKBMCGu314uMnTXO6CTvUXgOKh3nh
 Uf7zD1wN2/zYGhSMNwfSWZVv6krKuNK3pjtDbU6HRZwbr0D2+cw9YNVAcy8EPTQh+xfMnD7zT8e
 FaFDSkodP8IVEWZ39OZ+Kj14OeAGvGU5dXTqVEkCG/fwcMb/kv5j/nYfXBzXT8d6wpcyGqx72dn
 QFDLMbd0AD8cKJRwBvQ==
X-Proofpoint-GUID: O0uUr5vsjCHIInZOp8tgBcOTPkPmnjQ6
X-Authority-Analysis: v=2.4 cv=GL441ONK c=1 sm=1 tr=0 ts=6a0687e9 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=C8FaVdaJT2XKlJamlsUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: O0uUr5vsjCHIInZOp8tgBcOTPkPmnjQ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_06,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150025

  Hi Makro,

Thanks for the detailed analysis.

On 5/14/2026 10:44 AM, makro-kernel wrote:
> Hi Shuai, Luiz,
>
> I sent a patch earlier today touching the same function for a related
> but distinct failure mode in the same family of chips, and only just
> saw this thread.
>
>    https://lore.kernel.org/linux-bluetooth/aD_Lix2EVXOHmbZ4L1CunlWiLqfiKlU_1_FcVh4CBuIgud4kmE_544xjW2zFKsmh4pNAo9yIQ7q8_GZ4YcmgAXPp8LgW9rfWKqnu06WSjgk=@proton.me/T/#u
>
> In my case the *outer* check fails first: on Foxconn USB 0489:e10a
> (Qualcomm WCN6855/WCN785x, ROM 0x00190200) the chip reports
> QCA_CHECK_STATUS = 0xe0 (PATCH_UPDATED | SYSCFG_UPDATED) on every
> probe, so btusb_setup_qca() never reaches load_rampatch() or
> load_nvm(), returns 0, and the controller runs unpatched firmware.
>
> AVDTP setup later fails on Acquire and A2DP audio cannot stream. The
> PATCH_UPDATED bit appears to persist across cold boots somewhere on
> chip -- originally set by Windows on dual-boot-then-Linux systems
> we've seen, but the bit sticks even after a successful Linux firmware
> upload, so subsequent boots also see 0xe0 and skip.
>
> The rampatch itself also persists on this silicon at least across
> suspend/hibernate resume cycles and driver reload (whether it
> survives a true cold boot I haven't isolated). Either way, once an
> upload has succeeded the chip reports patch_version equal to the
> file's version on subsequent probes, which is exactly the condition
> your patch addresses. With my outer bypass in place but without your
> inner change, the second and subsequent probes hit the existing
> `rver_patch <= ver_patch` check, return -EINVAL, and controller
> setup aborts entirely:
>
>    Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00190200.bin
>    Bluetooth: hci0: QCA: patch rome 0x190200 build 0x8567, firmware rome 0x190200 build 0x8567
>    Bluetooth: hci0: rampatch file version did not match with firmware
>    (btusb_setup_qca returns -EINVAL, hci0 never finishes registering)
>
> So your fix is doing the right thing here, and on this hardware both
> sides are needed together for the chip to come up cleanly across
> reload / reboot cycles.
>
> In my local tree I skip reuploading on equal versions rather than
> re-uploading on every probe:
>
>    if (rver_rom != ver_rom) {
>            bt_dev_err(hdev, "rampatch file ROM did not match controller");
>            err = -EINVAL;
>            goto done;
>    }
>
>    if (rver_patch <= ver_patch) {
>            bt_dev_info(hdev, "QCA: rampatch already current, skipping download");
>            err = 0;
>            goto done;
>    }
>
>    err = btusb_setup_qca_download_fw(hdev, fw, info->rampatch_hdr);

   I tested on another device with the same ROM version (0x00190200) but
   a different USB ID (0cf3:e700). After a cold reboot the chip reports
   firmware build 0x43fb (ROM state), meaning firmware is reset on power
   cycle and QCA_CHECK_STATUS does not return 0xe0. The rampatch download
   proceeds normally every boot without any bypass.

   This suggests the NVM-persistent status bit behavior you described is
   specific to certain vendor configurations (e.g. Foxconn 0489:e10a)
   rather than a property of the ROM version itself.

   Given that, I wonder if removing the QCA_CHECK_STATUS guard
   unconditionally for all QCA USB chips is the right approach. For chips
   that reset firmware on cold boot, the unconditional re-upload adds
   unnecessary overhead on every probe. A device-specific quirk flag
   (keyed on USB ID) might be a more targeted fix, leaving the existing
   optimization intact for chips that don't exhibit the NVM persistence
   issue.

   My inner patch (changing <= to <) addresses the USB disconnect
   recovery case and is independent of the chip's NVM behavior, so it
   should apply broadly regardless of how the outer check is handled.

   Please correct me if I have misunderstood anything.

  Hi  Luiz, could you take a look at my patch when you get a chance?
https://lore.kernel.org/linux-bluetooth/8f5362ca-5513-4d9a-8922-6603783c9ae7@oss.qualcomm.com


>
> Best,
> Makro


Thanks,
Shuai

