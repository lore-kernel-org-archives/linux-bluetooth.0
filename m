Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269405;
	b=Pcli1xmXwGb8KvLUKgMmQ8CBB2e8F/QsBKumi3sgHe1cl0600WhoiLLNqKp04lggt7Kg
	 bzO35UM4o3TUp2t6OS4GA6zcuU7BOk/S2MClt0X7utd0g+vSwUycocFzQs8VFuUsr1OrG
	 U16MNEIrPp2HZ9E2Hf4uc4gqCE/tVsssAQtm5sSIlhk6ZfUa0d2qeDA8fN8XS43jDLIb/
	 KvBlVr2y54xgTunEwjrsO0gffFLB5w3IxNHTDF4x1AS032vEN28tMvBUg7NN5z+p2IZzJ
	 UR+v82X42El5zpCZj1oqiya88TxxfQ0LiKqNGGkOvJxDv88pt12r10cbrjqRYSaLL/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269405;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Content-Language:To:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=62lATBzCYWewKLUWmTeGUqQOKkjfCqDZcB31FuYnKcw=;
	b=cR5guX2FpF9orGTccV8c359dP9exD5OrGcypDNstFSNk/2AQU5mXGCmD/znyEbuUCq2e
	 q3fpIeWhEJVg+DiI0jKJ9foZZfRHLtZQXdwct4i559yU2XLTnf22EBqb92Ii69TZEU2AM
	 rc00vN8Rx2uKnZZ8rBbbx/xg3GOxz8oWs5Dhp4DP1is7H385HhUFulKwCg4hLU4YPr7Rk
	 d7Ovj+loI44imVeG8DZE2FJKkp2fn8c246KwYrRijoa8iw30Ibm0+AdvoYo1q9dp58pUH
	 +nOAvK6GfZbA/yGWmQ0X4wNh0a36+jvPxTJUTOyCHEkqBpCrxzHCtp2+QPukIx3tSUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Vgajkj56;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jLXTsk+E;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9A5606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 10:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F9A5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Vgajkj56;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jLXTsk+E
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T8vD7R2912456
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 10:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=62lATBzCYWewKLUWmTeGUq
	QOKkjfCqDZcB31FuYnKcw=; b=Vgajkj560NWYQzZjHgVYGuNO6kVTG1brpofQlw
	vzVq79Uxc6O586XlQErrxi8KmDL6xdzKxps0K/NGID7qdskRPTdH3mclX+VjCqRr
	n19ERUHrEucyj4qANwLabL5uSUO6NPcVdK0Zjq1M9K3Lr2yOsnnbtoKTKbuCmW8D
	g/EpY3pONpWM4JP3J2a9oVJihrmOJQfGYrEv6DJ4HWanZtOIK9xLr8yv+hFAufxd
	KP/VbTMFdc+qI1AzNK7RC6ugNy2my7XvQ5HuUwMXsjGhNucfA423tSGRv6pz3MX6
	+inf2mbILW32oUla28EE1wGCQTuRS0wpHihDalfghsNeOrKQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknb2bgfc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 10:23:23 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd65070d3feso448110a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 03:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793269403; x=1793874203; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=62lATBzCYWewKLUWmTeGUqQOKkjfCqDZcB31FuYnKcw=;
        b=jLXTsk+ERD3dAKzFm0CuDTVdW6ozV5rY1V3hWdisC2VP9D4ewDblAc/tijgglyoxPd
         ImbDjXLNQnOkh7pGvg5/cSkS33dd7R0bY1PXxDUlygHwZ2ZfRRdrxR05pcsi/qLvWFaY
         21M4mQZkEByuE8ZCxH2tQJFQzQ/zUuVu/zqiEcy5FNh58gJF1GZYnlSnnxYA1LBhaHbe
         zgZtCrtpI9HmTQvvt9cKxhWuF5cTn7r6ZUlkbTeOifYRaLpyO65DqJO/hy2gVk43FgcC
         /negi3oX82SgN4yTv8xeOVMy58G/pAgtv4Bo9HUICNh0XBFEq50O86EJ5LUAeAzN1PIV
         KMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793269403; x=1793874203;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=62lATBzCYWewKLUWmTeGUqQOKkjfCqDZcB31FuYnKcw=;
        b=tJ8a7yRFGPAxnuVVLAeUFv0VPyKgQTOYBmSQ2nn+FHl7T3IeVraMmEeW9ugqUS0VVH
         lKEqk0vYyQA+CdHi4RRgEqBJ20fB5pqCQxkPuj6heUpExVmvzbVack5XZCPu3teAoAtT
         MJlrSzVEFhAvWzaCFOHuQRPfCYrGm7zzfoj38YWHIIVFX/5PE4VXC/JEOILk5jLEswu2
         cPBvX5f+nj+CLW+5/OLIEEbXVXtcn7vsEIqZkWP8KSIT/dpyhLZEHj28+zEEbPEotqIl
         aBDQavqZgbVpRLB5a2OVTx8cASHykJOQqNyvJ1alQ/clFheoX36WUzGyhI4Nx+IVEKN6
         CBEA==
X-Gm-Message-State: AFq9FYJZuQDitUKZWfHLAJPCdctxVYtjaDX8hu6S8CvmxJ00p31TbbP1
	h2OrruAYNIZ4UY6mBd8fcT40BumXAyFnklOv8Jq6P68lXgSRH8vSlxumC6Zw8A/MPItya9GAs/U
	QMKULTRUfWYZRgiGw5aU3JDn8jgBC2fPzPqfWFIjr+4V08uC17aTZbNxL6V0GLnpVCtksmpk=
X-Gm-Gg: AYBFou0obIwLi7Y3g+U2PrPbiVCpQirtotnczJ8Qg1ESn+zjjr4azcEeXDq2iFnLR+3
	IXRJXXR/ZywHsqR32pzspBcTIX6YstOcOyw3PmITukgpw1fWklkII1OMbRzPl4FzosxqDtKVuEl
	UjbMNCaMHRRygvw2cJJNcNH5qkZQDLv4oH2d9roL7gzfareCOZlOX2tdBMzra6VLbx75dnKE93K
	BibwuB087Qv9Gy+EkRw4oCRdQi9zocQuZfUaz6JoQWQI+4AYjvYbx1J3TqmD3XVurbOa1ZgQP9j
	hyIySa43XkfdKjKE7un6+p4v40BGrmoHIrHzsMxJHpJ+ZEQqnYPe0sgMUVNAkxQTtncbGCiX3IS
	GYhuNhJG2TC2N1jQgAjxtWLiXjnEkXSNqmuUlC/aRvvDDMo4J1q/ItAuf/EhS8s5zitjqBLnSA4
	a0OQ==
X-Received: by 2002:a05:6a21:a81:b0:3e2:4e6e:6ca3 with SMTP id adf61e73a8af0-3e913a85fa6mr1550726637.34.1793269402934;
        Thu, 29 Oct 2026 03:23:22 -0700 (PDT)
X-Received: by 2002:a05:6a21:a81:b0:3e2:4e6e:6ca3 with SMTP id adf61e73a8af0-3e913a85fa6mr1550711637.34.1793269402375;
        Thu, 29 Oct 2026 03:23:22 -0700 (PDT)
Received: from [10.231.217.127] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a3d5bd47sm2192926b3a.2.2026.10.29.03.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 03:23:22 -0700 (PDT)
Message-ID: <6c3c4d0e-58b2-4f4f-9bff-62c43ff8891b@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 18:23:03 +0800
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
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com,
        wei.deng@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [RFC] ranging: starting a Channel Sounding session for a peer without
 a Ranging Service
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Yu2a1IYX c=1 sm=1 tr=0 ts=6ae31e9b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=d4-s11j-0clWSTUQ:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=BJkEapU9jbbHW-aHprIA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: tXBMlAMn1Pyar87zjI6ULAK-UhRvS4vq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MCBTYWx0ZWRfX2ZTmyUaUIrkN
 mruJdU2OoALLwiLq1D+3Y6MYWZa8U/tNaTYb5Wf8RxXQ3eFcCLPKzKEEHpQwokZH8rQYDxFhG7/
 pfkM+o1qQsfKYhJmZC+2w7veWgtK9rA=
X-Proofpoint-GUID: tXBMlAMn1Pyar87zjI6ULAK-UhRvS4vq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MCBTYWx0ZWRfX1/BoW8DcaSmt
 qK96SM5+z8l7DHwLUa2jksjKAbaxk5cSAmGPg/tSggAXozLlltn7h2SRWfTMATadVASbas0rUwA
 onlBdWGozp9rVvmS0r1Uqj5Y54e2xIwFy/zLBNtOhOrI+dCKsNiq26Bfhst68iYErgZRP1DkSUm
 fCBg/A4g4Rzub7iSTuaXr5Ch+YqDdhiiL67KUiFIy1sWBJhhV6Eys7FgXcKbqy4A7i8/iTGFY7P
 oHdScLwWqUQa6XGq5ksvlO7L6hs2HktdjQlduW9CmJR/CUBTXCkRG4hA+5AVAzVUURSM68a/KEb
 jk3o1Ruv89XygxZrxjJLwrlyfOwS47poAUZEgJcTpSQ0XhYLKcgCZEf3LaS/pn7fNFFQepoFpWe
 cokOV0IHPeCzkejkWtdZuHiKj2T+wUK40gQYiZfanUoBxv9CUUgfKyTYiA3pq7tvfaot5aaUvrk
 PDcrerwAA0E8YsEtCNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290040

Hi Luiz,

I would like to ask about the intended design before sending any code.

Background
==========

profiles/ranging/rap.c creates the CS session (rap_data, the HCI state
machine and the org.bluez.ChannelSounding1 object) from the RAP profile
probe, i.e. only for a peer that exposes the Ranging Service (0x185B).

Channel Sounding itself is a Link Layer feature and does not depend on a
GATT service. GAP.TS 4.7.11 (GAP/CS/BV-01-C) only requires that the
Lower Tester has the CS feature bit and that the link is encrypted. The
Lower Tester in that test exposes GAP/GATT only, so no RAP probe ever
runs, no ChannelSounding1 object appears for the device, and bluetoothctl
"cs" has nothing to call "start" on.

What a CS start needs from the host, besides the RAS path:

  - a peer whose Controller supports CS (LE feature bit 46, Core 6.2
    Vol 6 Part B 4.6);
  - the ACL connection handle;
  - for LE CS Security Enable (Vol 4 Part E 7.8.133): an encrypted link
    (otherwise 0x2F), the local Controller being Central (otherwise
    0x0C, since the Central's Link Layer starts the Security Start
    procedure, Vol 6 Part B 5.1.23), and the local Channel Sounding
    (Host Support) bit 47 being set (otherwise 0x0C).

Question 1: where should this live?
===================================

The session is tied to a btd_service today, and is torn down by
rap_remove(). A session that has no RAP service is not owned by any
btd_service, so it needs its own teardown (e.g. on device removal) and
its own lookup of the connection handle. That works against the usual
profile model.

Is profiles/ranging the right home for a use that is independent of any
GATT service, or should the "peer supports CS" knowledge and the session
creation sit at adapter/device level, with the profile only consuming it?

Question 2: what should trigger the session?
============================================

I see three options and would like your preference:

  a) Automatically, when the peer's LE features show the CS bit.
     No user action, but a ChannelSounding1 object appears for every
     CS-capable peer whether or not anybody wants to range, and it relies
     on observing the remote-features completion event.

  b) No new API. org.bluez.ChannelSounding1 is registered on the device
     object automatically whenever the device is connected and the local
     Controller supports CS, no longer only after a RAP probe. This is
     only a D-Bus object: it sends no HCI command and does not read the
     peer's features. The CS state (HCI state machine, connection handle)
     is created lazily when StartMeasurement() is called, and that call
     fails if the link is gone. The link does not have to be encrypted
     yet: as today, LE CS Security Enable is deferred until the
     Encryption Change event. The cost is that the interface shows up on
     every connected device of a CS-capable adapter, without checking
     the peer.

  c) A new method that creates the session on demand, e.g.
     Adapter1.StartChannelSounding(object device), as RemoveDevice()
     already takes a device path. Nothing is registered on the device
     before the call; afterwards ChannelSounding1 appears on the device
     object and is used as today. It fails with NotConnected if the
     device has no ACL connection. A client such as bluetoothctl can
     hide the two steps behind its existing "start" command. I found no
     existing call that could carry this without a new entry point, so
     true on-demand costs one new D-Bus method.

GAP.TS 4.7.11 has the Upper Tester order the IUT to start the CS
procedure after connection and encryption, so an explicit trigger from
the user (b or c) fits that test.

I lean towards (b) because it adds no new API and no hidden state beyond
the interface itself. If an interface on every connected device is not
acceptable, (c) is my fallback. Which would you prefer?

What I am not proposing
=======================

No change to the RAS-triggered path, and no behaviour change for existing
users. Defaults such as the CS PHY are out of scope here.

I have a working implementation of (a) as part of certification work, but
I do not think it is what you would want upstream, so I am holding it
back until the direction is agreed.

Thanks,
Cheng Jiang
