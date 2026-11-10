Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354989;
	b=pka2ero1qY0vzoPWEstmEcKs1WRwizE9DjDv4yfioWfIpq2k/fSJ1FlwsNf7yIloauqM
	 sDvFcntd2RkxYIrdP6tYjmFRED7u5vWBeGqTg3o6SdVLrmM7utGZo8Vdo1ti24j/4bAbZ
	 AXOWj3SA+VD5q30z5wE332HcCBZ62uc2pyBBatkd/iuf93a+l7HX7d+a09UwMjJyTuiIF
	 QNxMfhwvWkCmXnM1JGUSQi9GO3OZmCGLf4TRYhcUar9wSmD7aNPJJ8doV2tWdrhwY/7id
	 5W0n0xlcW2egBJceaqyqia2agTw1TlKkKwg7QyZ2kUX8AZcqbUg7cD1X8HtzWPlBSYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=5iDb3QfCxQpf1VLILG4jPUIpbHG5ame0athqMATF33s=;
	b=hS10jBNhGXYmshxl7lt1yGTdvP99f+6Iudm4fxR1JP1UE3zTHCCtsxH6bKOB7GsQr17e
	 q1IDEnw3btizJ23ocmHNmBy7GvV8ZyVyTTgB/ggFjYWKU+PkZIMjE3939v6SeyjaPagPS
	 DbEyjRKHU9xzrlq4Xmm4K4SolVE5fwSoqfULjohwKeztQsWNO8hf8LC7DNIp2UtgaHNCX
	 WVssdL6MliEIvTbrqteNQfzvGU/nc7PrTxgXIcJ4avYfs/gQboOiRwePUBQzMLnHKzQMa
	 Ia2Q8rdWwMXJuLxJfmq3Otxzo8IMVlycMqWJTSUTgN7BzSRvufQO4s8cPdBjbhf3q8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wiXOaG9b;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981A3606A326
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 23:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 981A3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wiXOaG9b
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso1369143a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 15:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794354988; x=1794959788; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5iDb3QfCxQpf1VLILG4jPUIpbHG5ame0athqMATF33s=;
        b=wiXOaG9bn0bP6AvAZ/fI1362VmVklL6hmSjP1T7Ge/dfSvIdZdr2fI0sHTMMyfGJvv
         TdjZHtg3KWLF18Zp0W3Cu6fy5lBhKTSRiuT3f/AhCLvr/JDWsKbAuoMTBLlJKatbzc4t
         xdx1Dso+oKEQFm6XlfTNsPtu81PF4rKRmYQ5TE1whJKnIiwQhaCWt8w6UF1mbIcYTWxn
         dQSPTiQESmuNbn8zS9OzVRwn+PtA/xpdoRy8plsv7wmOGWbAfwyEU57ZJPBECbCTnVyz
         Yyr6QEzr8BixN1UmAWx7F86Y8edovKT7zUISFotRmVpqbaF5X6z/2qHdu6YMgp1xM9Xd
         yevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794354988; x=1794959788;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5iDb3QfCxQpf1VLILG4jPUIpbHG5ame0athqMATF33s=;
        b=lIvJeTkUUM4szuGqpbBZl3h6Bv8MhInpEltVPF/BO6K5Bmrs6t/ArIot28p4Nn1F35
         grxVuMpmx48AjPLkxiJVHgrJ8i6lBr2eSjM6Ot+0jRSdMaPLI2V0FjJEVdodMJ+++Zs4
         S7EKmsCa6hKICBVHWYYjuVLCvKV0jDppxGxs5Lmj+efWqIViqsa1Z+lrdE8gGT6YVn+B
         sR1eNU3THHpkOvh3waFnKTGL9zyl5JDId8o+RdvdMdj+gJe+FuFr33V5ot3NCPHNH8+K
         QoheecE/dtsv7VkqmfxrtZSdK/3HrtUv7glqK3G9nzl5Itkt0M4PNerac2PXDELAZ8PH
         gwow==
X-Gm-Message-State: APuU4Z/MaDAPAc0SwKEIYD/egoSw5NTfxdp5ztrwX/m099MZoLxAuVtA
	nvti6IKutpPiJ/gdLk5ys1KN3EkgsG4/rT173fPYUwmK76qRamslDBrT9xaGeQ==
X-Gm-Gg: AYBFou0Yr4ZLQiBOhdNmiPZFlxih8WcBPvSyZLuTlyEnoDRHofQe8uLMLOnzAUD291V
	TrtTedkGCP36s0xUPQEuiagdmcv0MRuG+LiNyqQUiKrGttBLzcEPT8GU/MQm0kosIQOL/yhtB+7
	GLlHTjCxRsFKpE65OrHWErUKzbxba2MzxyYPPZScdoLwBpP/LxdWGWqtvIQ2ccvS3CEYonZ1Y16
	0TSlDC57/mP0tca9Fj9Q1t8gPofJe8LCv/P5BGIt4c4wV6d1JBVOUn7LSHeCcMF9n2xzL97beXV
	JfRi0War33M0yXCnGtFdhQk1z+Y2hEBukou3jqkH3TJAoO0ghzZIe6C0uJY+gsWw0RQDfGwBgN/
	lxaQbVmCv9tuudCs3zA5CK7l0Rk5qLlWf3VMUhI+9A/gA04BfaN0jgRCyGs4+97lFUQNKC9/iNN
	rfMs+DHbUvI3/3mFjK8e92PCsInSJAyI8HIbmZVO6f29tTuKuhePGMYMRsL9+E8SBq0hKvo/S9w
	PUa4z2+fzQusKURjX4KtMQIWFLhdwIZL8HpUmiQ7fseK7dcctc6th4FtIEyySI=
X-Received: by 2002:a17:90b:2fce:b0:3a4:acde:1e3b with SMTP id 98e67ed59e1d1-3b182f6606fmr575713a91.13.1794354987834;
        Tue, 10 Nov 2026 15:56:27 -0800 (PST)
Received: from [172.17.0.2] ([20.98.117.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b182dff97fsm296141a91.3.2026.11.10.15.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:56:27 -0800 (PST)
Message-ID: <6af3af2b.ed50f7f0.33bccb.409e@mx.google.com>
Date: Tue, 10 Nov 2026 15:56:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5602090280040565634=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, amirabudubai@gmail.com
Subject: RE: Bluetooth: L2CAP: Increase default socket buffer to hold large SDUs
In-Reply-To: <20261110214230.3646539-1-amirabudubai@gmail.com>
References: <20261110214230.3646539-1-amirabudubai@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5602090280040565634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1207660/

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      23.46 seconds
CheckAllWarning               PASS      28.77 seconds
CheckSparse                   PASS      31.59 seconds
BuildKernel32                 PASS      24.75 seconds
CheckKernelLLVM               PASS      26.53 seconds
TestRunnerSetup               PASS      574.85 seconds
TestRunner_l2cap-tester       PASS      13.55 seconds
IncrementalBuild              PASS      24.59 seconds



https://github.com/bluez/bluetooth-next/pull/1106

---
Regards,
Linux Bluetooth


--===============5602090280040565634==--
