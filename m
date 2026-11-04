Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761683;
	b=OfYsBqLSv6VWzDW1M0tuj92yzx4Vei0ZDQFmQvV9tDtLN7I9MIcEL6j/gw6Dzw3tpvJE
	 B1aA8eM081uOmpmmJkJK8evfsGgHmHuGWljp8wHkTMZBFW1EqGG9d7kX4BoNwGz3/ZA+G
	 SlnyFDHzdcXUHX4xvtmGln9mDratVEVPnIgTjSCDNEBYDwyD0+PrN6l0N4BW3wMLdzxfg
	 1wjDkTVf6UhZOr9py3jTNstSLuyXD4kodR46Zbd4hBFwSd61LtKFtKejBCqPqh6yg/0b/
	 zgR5442Fxs+78K2dvCAg3evfBXDnIKkzjUlceG/BR3I7k2qNA/kcfIJbAjg9LlMa17A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761683;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NdFGx1cg56uP8N9JfojdS8RxbaW62h7qG71ckN6wbDY=;
	b=m5MWeqJ4zGRI7f99jlhDOLTGfMT3F3pvPQCihZn77RPXuPyylL/3Mq33p16gKSufAffP
	 1JCqoOp5uxxaySIstyRXdJnizQ1Zu7hdN8rsrxM91clEqKmhnPR0Or08C9owrb3ZNCK2f
	 bggwTfqi99rm0ptZm/OupoSGtjKmFXAhXSXFCUCZ/LbCWTLJt+rVnvyAcbn00lmlxIvTH
	 RP0p8UP57kFVQwA5p8RyBhUbngUXMalsLXm9nliyOm0pzb/sZIrVh2BuPk3HfQnsh9Zvm
	 iNgAt8rQRCAdbk5HO6vaNGD9lMAio829mW1ibdgL4g+xHDQLWOoan+l/leRTgHeGFHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=joEHA0lV;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GUaHPuYR;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F78606A329
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 03:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4F78606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=joEHA0lV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GUaHPuYR
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A40R2RF1191104
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 03:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NdFGx1cg56uP8N9JfojdS8RxbaW62h7qG71ckN6wbDY=; b=joEHA0lVZAwW85GY
	XZYvj9h/bxyUyyJcgi4OLgD6M2xParTfuvUO09GSaiNXMbnQrhN4hYwacdmIyeUA
	hx3YJZPzmbJTW6LzCVYKhKCseyn06Oqn407B7Hreh6/vwRQh87zWRCRIFfhsc+Un
	60QcEQZPS3gFjHT16eRWQBtiS/6fx27CQrzTJNJOeC+DuyPfBeE+HSKah7tx4iZW
	2Oitq8qCNeeqXrV90tp+pwzQGRkru8soEs67e3jyXMtbNT3PMn2x5GFHXrWX5o+h
	eIKbhRr2wduo2BXOMQEK7wEeIYk7pglaAM5ABDAFvJu2p71PbKBRz3xCTZgqVPSm
	n0nyPA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqm2phywq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 03:08:01 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd633da24f8so347966a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 19:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793761681; x=1794366481; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NdFGx1cg56uP8N9JfojdS8RxbaW62h7qG71ckN6wbDY=;
        b=GUaHPuYRezyzPf9dAEGJKiGGeI4kTArdbst1KRhL7VfGJXdoE0Iz9NhqoB0Qb1Nq00
         tl66IJF/vxtZeSiYrtBCf9tQZTYpFo1RqgiQCymMYybAxJX/7dPSBPXU5GMaz3O+RZiN
         TvDp53BHxM2LR7a+r7fVzPcJFmxy8uP0jgy8WES4fCts8b/bB0gsVfNCv98/7D/tco7V
         v/L3G2x7r8ReVyhfwdXsBkEd5+gZWNI6aVuPiAQ9MYnqbDpFI53r+gvMwgYn/W6g7JYc
         gMgjJLxAnrs6pTagQ1t+61ZLQMvyNGGltgCR8imem9YUqX6upDEr7uIj8AA2m26u6wet
         9v3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793761681; x=1794366481;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NdFGx1cg56uP8N9JfojdS8RxbaW62h7qG71ckN6wbDY=;
        b=Nswsor+pKpFzDOXxIDMtPojUOu2A6GWI492hTFPV4RxT0Dz10VTSEFNKVub4AI/vDK
         gu21Z7bZ3Hc/FBmeI4x0uAPaZD/EVxR3ZVDEfVKUZeRmyjVUks/Gt7C/DvXWtZ5VvOrI
         8nGZnDKLMUtvVgSj/sk/m7gHPK1LZYqatWHn3Akz3dKxLmmD/4lC6CsdXsHDq+zh4KAy
         mpSR2SzqOehmIDaeF9pY0uSiTY6Lc8LRSaB2a5sFbue4DlSH8EE9Ux1y7ES276ExGYKe
         q22ricJcT12WlNtq64SduvvLZCkmd+awyRtKWzgfCK6MIwxb0NzIccVWL3qk0/2ScNZd
         bYkg==
X-Gm-Message-State: APuU4Z+IdmstYnL41sp0TT/EG/2pp+DlG8UI/JxEenJC6oyO89hO69tK
	IDfjOXq9XJkL1NOYlASoE5Q7DypHVhn+8k/zhGQrrhCp5BL8C7+bXsvEQ520G6Syncf0Hhww8qZ
	HRM9o6/HIXUAFNL+MJ3b1mM+c1bpaCEMXVd+PgFrmpOiCL3E1Bs/yGviDi8XEd+L9PvzSn3s=
X-Gm-Gg: AYBFou3sFVJ6QDf2oUykbO2/PdLV3SRPk+JuhO8j8l49PF7oMLG+L+Ma4lW5KZmttx5
	lCBsEu5ZtPmnXhZPr23ZYf/90t4WFcBeJYHi8cr3irzMmUf3f5EL5MZdbTDrHV2VHP5gj+6RhA5
	0P0PtOvAL/oG+EUoInoE7f9OVmJRlQQ11DoZDVvzaitCQ/WrFVLf+fTkRjjvPpkLgadgdG0NCNa
	3F+n5pjUg92YJ7MEwokkajRPwSoFtfRIAdMtkI6wkJhgBN7trrte2ylPUBhzAuXw/Jyuja4HoXf
	6gS7fsdOtHVvvVLFthM5y40lFwAp9CCzVEDlPkmWEGwKV+lKGUTq89q8e4XscgwiZjnOINQMbQk
	cWbFyeF8QxBuUIAzRhQKCRz49651bLAkEYgf0vBtpJMoAEo2/DXyUL6MdyYMPcVAS5i6nJ1dLxt
	/Z
X-Received: by 2002:a05:6a20:9c17:b0:3e2:8114:12e3 with SMTP id adf61e73a8af0-3e928d447demr14080702637.41.1793761681175;
        Tue, 03 Nov 2026 19:08:01 -0800 (PST)
X-Received: by 2002:a05:6a20:9c17:b0:3e2:8114:12e3 with SMTP id adf61e73a8af0-3e928d447demr14080645637.41.1793761679885;
        Tue, 03 Nov 2026 19:07:59 -0800 (PST)
Received: from [10.231.217.127] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46326f8bsm373380a12.0.2026.11.03.19.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 19:07:56 -0800 (PST)
Message-ID: <7b62eff7-5e56-4c19-aa7d-4ddf57440886@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 11:07:52 +0800
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
Subject: Re: [RFC] ranging: starting a Channel Sounding session for a peer
 without a Ranging Service
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com,
        wei.deng@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com
References: <6c3c4d0e-58b2-4f4f-9bff-62c43ff8891b@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6c3c4d0e-58b2-4f4f-9bff-62c43ff8891b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAxMSBTYWx0ZWRfX/tNXbVn0RMK+
 UlwBxRCCXNbY8Y5bsrgKgxs4E4BRMOyzU7D4EjwN8Hzr64VS/MD3daTVe4rG9YK44fzgM9zLJzT
 AJPBPDwpyAlyHWGxJ8NVY0QI9QPNzJtZyCItmRl0iXB0Rk1BUQHhPKom8jrlYsdVTZxVdIuJI5X
 1OHcRapBBKBPl7uwiYnVGbkbhoVSdyIQCfKJ6wv2wmXT6edwQca7wgX2CLACOIENmgXBZwdNrpq
 KtHsBPGEW4EBnbTbNXj611PD4ccRGhYJQkyvyhzusWAi405zVXUvizGw2EPc1L7+v+Sx1X4I2ZJ
 s8KVm2btoeYHoBzid9pLz6P6A0jAK5woAWtqfNbAOUOO1F+ksTFPUiNwn5mhUo/kLE3rI5XpviE
 xltDe98PoBFK+3Owttoxz08GSArukWkhMOjhrJLzekfvrFgH0TOW5bY2p9+edOprYh+lwjGGPF8
 NVLOeDVxY6p8a3TrY7w==
X-Proofpoint-GUID: BBt9aJP0PRWQKW7Kp5gQ0X6-btbdhZDZ
X-Proofpoint-ORIG-GUID: BBt9aJP0PRWQKW7Kp5gQ0X6-btbdhZDZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAxMSBTYWx0ZWRfX7gQborG1zB2d
 7eI6lUWjVAzX+aMAqsYXYK8tnF9szoSGz0VsPojNZuTyMr5QvmU/UQLOqAsRzsuDPwbGxOc5a0z
 02r2eCrEs65kKsV3zlIoTZrAqYlaR1U=
X-Authority-Analysis: v=2.4 cv=c64+0h9l c=1 sm=1 tr=0 ts=6aeaa191 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=d4-s11j-0clWSTUQ:21 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pvE0Ei2ug7jDF6PU-nQA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040011

Hi Luiz,

Could you please help to review this proposal? Thank you!

On 10/29/2026 6:23 PM, Cheng Jiang wrote:
> Hi Luiz,
> 
> I would like to ask about the intended design before sending any code.
> 
> Background
> ==========
> 
> profiles/ranging/rap.c creates the CS session (rap_data, the HCI state
> machine and the org.bluez.ChannelSounding1 object) from the RAP profile
> probe, i.e. only for a peer that exposes the Ranging Service (0x185B).
> 
> Channel Sounding itself is a Link Layer feature and does not depend on a
> GATT service. GAP.TS 4.7.11 (GAP/CS/BV-01-C) only requires that the
> Lower Tester has the CS feature bit and that the link is encrypted. The
> Lower Tester in that test exposes GAP/GATT only, so no RAP probe ever
> runs, no ChannelSounding1 object appears for the device, and bluetoothctl
> "cs" has nothing to call "start" on.
> 
> What a CS start needs from the host, besides the RAS path:
> 
>   - a peer whose Controller supports CS (LE feature bit 46, Core 6.2
>     Vol 6 Part B 4.6);
>   - the ACL connection handle;
>   - for LE CS Security Enable (Vol 4 Part E 7.8.133): an encrypted link
>     (otherwise 0x2F), the local Controller being Central (otherwise
>     0x0C, since the Central's Link Layer starts the Security Start
>     procedure, Vol 6 Part B 5.1.23), and the local Channel Sounding
>     (Host Support) bit 47 being set (otherwise 0x0C).
> 
> Question 1: where should this live?
> ===================================
> 
> The session is tied to a btd_service today, and is torn down by
> rap_remove(). A session that has no RAP service is not owned by any
> btd_service, so it needs its own teardown (e.g. on device removal) and
> its own lookup of the connection handle. That works against the usual
> profile model.
> 
> Is profiles/ranging the right home for a use that is independent of any
> GATT service, or should the "peer supports CS" knowledge and the session
> creation sit at adapter/device level, with the profile only consuming it?
> 
> Question 2: what should trigger the session?
> ============================================
> 
> I see three options and would like your preference:
> 
>   a) Automatically, when the peer's LE features show the CS bit.
>      No user action, but a ChannelSounding1 object appears for every
>      CS-capable peer whether or not anybody wants to range, and it relies
>      on observing the remote-features completion event.
> 
>   b) No new API. org.bluez.ChannelSounding1 is registered on the device
>      object automatically whenever the device is connected and the local
>      Controller supports CS, no longer only after a RAP probe. This is
>      only a D-Bus object: it sends no HCI command and does not read the
>      peer's features. The CS state (HCI state machine, connection handle)
>      is created lazily when StartMeasurement() is called, and that call
>      fails if the link is gone. The link does not have to be encrypted
>      yet: as today, LE CS Security Enable is deferred until the
>      Encryption Change event. The cost is that the interface shows up on
>      every connected device of a CS-capable adapter, without checking
>      the peer.
> 
>   c) A new method that creates the session on demand, e.g.
>      Adapter1.StartChannelSounding(object device), as RemoveDevice()
>      already takes a device path. Nothing is registered on the device
>      before the call; afterwards ChannelSounding1 appears on the device
>      object and is used as today. It fails with NotConnected if the
>      device has no ACL connection. A client such as bluetoothctl can
>      hide the two steps behind its existing "start" command. I found no
>      existing call that could carry this without a new entry point, so
>      true on-demand costs one new D-Bus method.
> 
> GAP.TS 4.7.11 has the Upper Tester order the IUT to start the CS
> procedure after connection and encryption, so an explicit trigger from
> the user (b or c) fits that test.
> 
> I lean towards (b) because it adds no new API and no hidden state beyond
> the interface itself. If an interface on every connected device is not
> acceptable, (c) is my fallback. Which would you prefer?
> 
> What I am not proposing
> =======================
> 
> No change to the RAS-triggered path, and no behaviour change for existing
> users. Defaults such as the CS PHY are out of scope here.
> 
> I have a working implementation of (a) as part of certification work, but
> I do not think it is what you would want upstream, so I am holding it
> back until the direction is agreed.
> 
> Thanks,
> Cheng Jiang

