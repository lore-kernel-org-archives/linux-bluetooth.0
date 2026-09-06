Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C9F259C82
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Sep 2026 02:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788661691; cv=none; b=Ce95qF9+v016t9G63j4CwSPybPpRQEfdg7handzoWDUIYYfIatw6sbQSFz0e/PkTpYmM21hENkuk4uKw35IdzZ7ntKswvOPMmJFCW6upIYJJLC09ZEJo8UmAEXe9YLt5j3HrijWE5cKN+aeoFN24BSYo1YsWYsv5A/aHLIZ58Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788661691; c=relaxed/simple;
	bh=KIX+FMSc4EqvFxwWqDIPCmwQTsKl7G0c2A+48ntvwkM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CFl87tGf3dBmEp2HEJ9ehrSFpRotR9ybh6Vl5MBzqLePa8HJF8ksytEz1sFxW+88FVB74H1FWP2udeH/sChAt2AMDrd4NxLuLfloMQ7wMIFMkyns21x56H1ssFQTtRY3qTY3I4tAxsLE5Cr8U+V6K8LCiC+s//9PRRuqHSg0u3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rag7Hfd8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HVwM6G89; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rag7Hfd8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HVwM6G89"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 685Nxpqx086210
	for <linux-bluetooth@vger.kernel.org>; Sun, 6 Sep 2026 02:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PdGT+/Nqgl235u435n+YuE6aHP9Ali5eDPJS19M1ESo=; b=Rag7Hfd86A7S1P8m
	KotqfwR94B0OkU1JswONS6MajnFw1fiI+rFWdzB50a2AsHCmZtLDZ7rTnjbrYrhl
	fQTNlUmUE3+VopFnhE7YoLloXwqxNym66qA3DzgYcWlZrX/BeWz+nV9Qkto7Fmqj
	KvSouYC01qTJxqj1MbUHLdwS68NIn0021OiVvvx76d1t9qOrMApP3WiMWFQBomc3
	R5yIgbziVJJ2PbBCPohRXcSbyBOD10FZlkvV3nO2/BLSmtqdrcWmQX23WtimkAIs
	MrEfH2LU0MXxKurnpwd0pndHNRVaIjJ7hHkT79dGAVt+kTn48exuPQ6+FubRShk7
	7v/usg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggany2mcb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 06 Sep 2026 02:28:09 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1c1910b2cso402445a12.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 05 Sep 2026 19:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788661688; x=1789266488; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PdGT+/Nqgl235u435n+YuE6aHP9Ali5eDPJS19M1ESo=;
        b=HVwM6G89eklwL7o3o+kRW9GHvT+rTMLYglclQPU/Hp+PIYY/YkNXVRghR4Z+OXJw2v
         2yM7Fikc1fsXIBdZM5iBUY9gKx5GOoMNYrX7j7YCfSx73Je8OQi0L1T76yE3K7PlOXUM
         HudxL9o+0sWzsl3m50CNLlt+9ytJQzOg76pLVgmmipNGKxmP5Mzzj0aBWz3Jbzvg1WV+
         oxvOX84xryIELLBFWytZw3mg1KWzWFIYCwOiNtucNqRKEJTBVtzIOOCfQbHMAufUkcmy
         mr4fjMlw2hGxf8DEQoauDfyY+hGpoAdssxMXR0xFA4qN1KGYST+UZU3o56GLePGvvDZ1
         0W9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788661688; x=1789266488;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PdGT+/Nqgl235u435n+YuE6aHP9Ali5eDPJS19M1ESo=;
        b=Q2SvqwEKSgGeK0WE0HcO0j6LWUXEQH1By+GwIkLB4iqAenUpRogQvz8byQBx6PVebw
         yZM7jjp8Z19NBY5yKAZtpKUwML34VThqOAsBL1mLgoBz7IAqLdfoN7g92U/93loisZBn
         LDB3b0iwVOf+TPXi6JiO8QET8mQXldqDTJdEtMLAwX5eisWeTyw43k9HckEy3s6+3Wl2
         cItkUAbrjGzG7wYtWqBvwSDXbBI4T9lGZe4AX5IR9msz5r/yn/tg0iwzx8zDE1cwb8YO
         EQ95+0xc95wAzo3CR/inwdtW1n2iR5r0IAYWITZ8AXyrA+aa2LdC+kZ+F6kSkmJ4E0JK
         QjJw==
X-Forwarded-Encrypted: i=1; AKwUvBz39CBwowSWzm5SGmvn0gBGt1Iz1X8Eel5bRjXE9DJ1g2Tlxou3qpfoSJHu2CnLJTH7xa2g25OjKzS70RApDv0=@vger.kernel.org
X-Gm-Message-State: AFuF++mRd0m/H0TJitDQcr2xJY8WvssEEKuLFjlKoATkjt87q4sO5wo7
	wOw8uqogJcg8Qv+WG4aPbSjUVZsuiZlb4M2Cg4pazme9ZjkGm5gPlJM853fDcutPSQV+hCPBOVY
	kEW7tT8bD/5kkreuomZco5jS81EKO745kBNIsmsNym8oJc3orsXHTXnOgx5QiCXONUcQu2UM=
X-Gm-Gg: AYBFou2ro1E4xLhwx/i3jeyDO5JxNzBN+XCXh9LrrCcOmmweTfO9ek8Hmh6LL0Y65tE
	Qr7x98x1zAtH9ukdIlDYXRZGBvTzckFuTISfKOq8C6qf3kmUvIyw+3bdtbwHEGgafleo/uQW0pv
	GHE42I3nW8qNcQXVFIQPC2uN2V8fywzioD43/PZKV7Ees88pGrNCPMr5SNxSYOGGsg7Bq97Wuo5
	ZiTAyblP07PQWANvXAWLSoWdWTYS5mz6XF82T8T+3GE2HdhlNE8eYq0qU6yipwDgHVG5G2EJEu+
	8/FsmPy6PHpu5UVFTZRQ1GcwhgPQ1irXtQEeSdG77f9r91eqgX8gPQqkV+62ryvWEhC+LkpDIY3
	ES2XRLLSyT5fBENyUF5pqYZwq1VdUHsg6zfDw+H7J9EebpRQbY0cYnnZJbu2S+2Y3xbc=
X-Received: by 2002:a17:902:d4c9:b0:2d8:d29b:c1e5 with SMTP id d9443c01a7336-2db273b0f96mr75963195ad.0.1788661687596;
        Sat, 05 Sep 2026 19:28:07 -0700 (PDT)
X-Received: by 2002:a17:902:d4c9:b0:2d8:d29b:c1e5 with SMTP id d9443c01a7336-2db273b0f96mr75962955ad.0.1788661687153;
        Sat, 05 Sep 2026 19:28:07 -0700 (PDT)
Received: from [10.249.22.190] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db148451fbsm26773485ad.7.2026.09.05.19.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 19:28:06 -0700 (PDT)
Message-ID: <4df53cf8-b173-423b-bfba-4c5fc539e528@oss.qualcomm.com>
Date: Sun, 6 Sep 2026 10:27:37 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: Re: [PATCH BlueZ v3 3/4] doc/hci-protocol: Add BT_RECV_VENDOR_PKT
 socket option for HCI_CHANNEL_USER
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260903-vendor_hci-v3-0-015d62a57c91@oss.qualcomm.com>
 <20260903-vendor_hci-v3-3-015d62a57c91@oss.qualcomm.com>
 <CABBYNZ+1PqFXSqAPNC3krSaTccv4VT7ERNRWkO-pCg3k+qCH9A@mail.gmail.com>
 <985c44eb-38a2-48f9-96e8-292b0a39e29a@oss.qualcomm.com>
 <CABBYNZLddwpM42-jpbGbi+wpiJgqwU6UB4TKc1KjC9pR=aM95Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABBYNZLddwpM42-jpbGbi+wpiJgqwU6UB4TKc1KjC9pR=aM95Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X45i7mTe c=1 sm=1 tr=0 ts=6a9ccfb9 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=XTxmbAkqevqQ1xLVaKQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: VYTHfu1H4SL7blHCaVcURBctC4JEnnbc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDAyMyBTYWx0ZWRfXw4JSxMp+Kk4g
 8X4FRwEfYau2sGAvu8L31sxaP3XheTK1d/eevypwS0VsFCbfSyW0d2CGLQR1mNBnraWVfOcfqGu
 Ib0RDKLCmNjGFsUCBD9/aNQdko/wY7w28Bg4iT0SErq3Cv0Tnl7XvAXIgYH5Zd6jXZz7ohi4EU1
 2PzdV+icTomLLYngV93/pJm7edcRnwx6lb8xHPMwLXkhfwEeDrjrWS++4mf3nTQJcmhO5qD66Ys
 ncDPRJ6vzdtcKSDvuLI+EOSCLzBhV6RInA6xckM3sPohNON8GTo62n0y7ECS8T8Dfa1DxCZLNPW
 2NFyqQGBt1fohwW9ZG6JwofxkiGywVzZQFVJHXgATVFLa7ZKq845jz6ZLOBly0J6T4PYbizTgUS
 tUhDS6+vx/kivmG/VtjvNOM6760t2EfcKKBt2o8T9ksA69EyqtMXD+uMV80/9t2dj+G5P1dNS0f
 u+2SUkSemOEWle07GfQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDAyMyBTYWx0ZWRfX9Ntx1DtWrLhY
 l1O9vWiVtVuWlG4SPbAVl5ajxl+LlhYi68rcksTsONf4mbTAjqPOn2jrTDD5B3Qar5WnQobch/o
 aQTjH91yvvLcPpW/6tAQRdhoeupGnBI=
X-Proofpoint-GUID: VYTHfu1H4SL7blHCaVcURBctC4JEnnbc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_08,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609060023

On 9/4/2026 10:31 PM, Luiz Augusto von Dentz wrote:
>> Hi Luiz,
>>
>> Good catch — that socket option is introduced by the below kernel patch, which is still under review:
>> https://lore.kernel.org/all/20260830-btusb_qcc2072-v2-2-5c0e0c9dd98b@oss.qualcomm.com
>> I'll drop this userspace patch in v4 temporarily to avoid confusion.
>>
>>> e.g., HCI_CHANNEL_VENDOR which can then allow packet type rather than
>>> just the known ones.
>> For this new proposal:
>>
>> 1) Is my below understanding correct?
>> - H/W wire: BT and vendor packets are serialized together.
>> - Kernel: splits BT and vendor packets to their own channels.
>> - Userspace: merges both channels on RX, sends to the corresponding channel on TX.
> I guess that is up to us to define, HCI_CHANNEL_VENDOR could just
> serialize everything, so it supersed HCI_CHANNEL_USER which only took
> care of known packet types. That said I don't think it would be an API
> break if we decide HCI_CHANNEL_USER carry everything, but since you
> are trying to introduce BT_RECV_VENDOR_PKT there maybe a reason not to
> enable everything to be send over HCI_CHANNEL_USER.
> 
>> 2) How would a HCI_CHANNEL_USER user, e.g. Chromebook, send and receive vendor packets?
> Would have to switch to use HCI_CHANNEL_VENDOR, just as it would have
> to use BT_RECV_VENDOR_PKT, but then again Id rather do it on
> HCI_CHANNEL_USER if we don't consider it an API breakage.

Good point — I'll drop BT_RECV_VENDOR_PKT from both the kernel and userspace patches and let vendor packets flow over HCI_CHANNEL_USER
unconditionally.

Since HCI_CHANNEL_USER owns the controller exclusively, it should see every packet the controller sends.
There's also precedent for this: HCI_DRV_PKT was introduced over HCI_CHANNEL_USER with no equivalent opt-in gate.

The regression BT_RECV_VENDOR_PKT guarded against is mostly hypothetical anyway — it was added defensively in case some proprietary HCI_CHANNEL_USER
application doesn't handle unknown packet types robustly, not because of any regression we've actually observed. If such an application does break on
vendor packets, it should be fixed to tolerate them, rather than have the packet type gated on its behalf.
