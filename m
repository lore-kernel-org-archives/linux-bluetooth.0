Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210227;
	b=msT3jjxf1S5HoXD17yO8AS8wJRa7OhQDmTW3JWODqBoOx+6q6FBDVDvwUK9IiKL66BUP
	 C/gM1ptexjpuHS53ca6iEvMZ8ZDR6sPncQHspJHKJ6XXwg39PcZ9NUHr8dIA1J601OcKF
	 NQjLuq9Zwgj+Xm6JUKayu0quyyjCLyxKC1d+2ol1000cxkAWBpljSlrtBlhKhqHShFzrM
	 GcnA5a9Z5MiyoldX5DdO+rx2WVL255MDcNupFLBGmVCr0YoqtdYf7XntVClDbJ5CuXDpl
	 kB3v92ij+ndMrejHxXhbpm78Hc0HdExkgNd17h9wo5C5/rDZRYZaVD0RRYfTxhBqVDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=9qdz1VtaybZGUSRyPaetGKniFVdgqjj2h6x02Woeu3w=;
	b=DbbGTeo8yokNp126iQBJ/ufK8L/L52DtqBqWwq3dthm2brV5Emrko+D3VFNBKU4HBgSs
	 H/TBx2bhCqu8o4/dZaGOjgmn6k2Tj9r3BWaskZoOuxjIU5AU0ZCl3c9dzCvYmiN/lISCK
	 /dOjBhqSYMQP3mhvcOOwwoS/umLZP9sxIv4UaE2hRr6r5muj/9fnX5Yk7Y3Ujqh450wKY
	 3OSOFboD0uYSRoWYL6Ya4yWDQjFwWi+pBUWIyQUH1lYTT5dU0igVyToTj8mO1YRe4wefI
	 vvPlR2MspgAFElqrrPVqP2kD9V5OoP01xpdE6r5ARJjT2OJy7XYSisKSdKz1WFSMA4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bAOoOv8q;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2BC606A6BD
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 21:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C2BC606A6BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bAOoOv8q
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2f02ee04378so10989085ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 13:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795210215; x=1795815015; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9qdz1VtaybZGUSRyPaetGKniFVdgqjj2h6x02Woeu3w=;
        b=bAOoOv8q4o1uJ4LdbtiaUud5GGQmiaWuLJPxUbW+fbhVuPKfDDVSxARe8f/fFEnW+1
         ED1P6b5gVcHmx9MPDtzoNEgEEDfmbnrWgPMFUTBv/PLzz8iDwaz7GKgfOfyrfXP3WXVD
         KMx+nneO6r0DGHszVNEbuiRXSZ/mlotMT/JjK2w+hR/rHeVuEyxphMFMezvU72UmI2Wj
         41H9X5d6oRayuoRyhXb+glgY7eGyzb3eJyd+RHGf6HXLS9Uu/Ap0S4qW823yXdh5mITW
         8eYqlxpC4XwWSHtDcUAovCOD4zUI83LCt33/J8NZRQf4CopOwPcNyRFUc29ckm45WRNo
         Xv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795210215; x=1795815015;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9qdz1VtaybZGUSRyPaetGKniFVdgqjj2h6x02Woeu3w=;
        b=NZ/gqpj0A33K1Dq1Qe6kKi4ipSkeB/1ztX7ScN4COaGIAj3pCFrWtTESQQ5BsxWC6D
         eyjg3t2A5tU7kDWs/ei3sT1PEkmX0Gb2LxCRiKAm2LP4jxzxM2u2++p3tC9S+f2JUXXt
         TOYFKt64rqiJLEKRxMCw/5ZwPpiNYpei+JtNKAJkuyTsMo7PNQ9sxzHmS/c2i1ayFXUD
         scES3nffxC6XTlghApangE6hsS6VijIZXZRmy4xBPIwM62EicxW/Btd18n4DhR3QsRcR
         1EID1R5LUc0rNCBIIydYN+xQvYdW9a9guUW+tUPKovR64yPXO4rC0PAwVNUFNf9G97aV
         gvbA==
X-Gm-Message-State: APuU4Z8KdRYdUgNefEPEv1uo33nnCIZOSyjBy0+KhpN2ILBRMfCMGO2k
	Izie3NqsnF99KnSP491ilLafCDJpmA2hsnmsAQjohSTVY7jfUGncO0Y+SKPXOA==
X-Gm-Gg: AZFdTZclPKNuZ+gYXnkLm2IidW/kX+RaDcXxxad6iPAfka685lMe3LoInwuf98ZIyAL
	3LUFeZ4n8SfsE86ZKN6hu7MYyf7P/jlCrCzO+3SemllIIi+uszZ/gky0ORO2oIPQdZ1tK2GkatF
	yXvjyZR+B4Wkhsup1ywkWmosq2JGoTGqmqwOH+Uu2K6LXT/Da86HOuz4ZdLIVV/eF1j6iPrFe1p
	G4TXPPRvwU3z8wJvVXdchvN0QJx+GYGBnNaMzlb1Xn95k61WBjkAr5igLVwTpb+yedlZzPJ+zxW
	Dy6NTI3XOnVUWP3ZNLjQMibfYv84BgsHXz7TgT6POfo7+e2AY3IazmJ6au0JSrCLeY9hD4vgyGX
	U4hPWScO/j2lDUdmI+VLnCpjS15g4F2Ts7KipYFjhVk8d9XDv975e/netlcSbSSe5sbfEeDl6/u
	bVQ2YXs9T3G0ej18ZeqG5mlFs+RtvWj5tN3WuCT0zR2eyWsLEzXZ2VmWzW6OHCPaPf0r56UX8Cs
	tVMdMiaPS8WWJUub1KpAGAOZW2WVK+nSVcFu9d5d1+5E1Ak4GfrRK/NkCzjGBg=
X-Received: by 2002:a17:90a:d2cf:b0:3b4:1714:5bfc with SMTP id 98e67ed59e1d1-3b41c9b9dc1mr3901937a91.61.1795210215385;
        Fri, 20 Nov 2026 13:30:15 -0800 (PST)
Received: from [172.17.0.2] ([4.149.245.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b6fc28asm436305a91.1.2026.11.20.13.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 13:30:14 -0800 (PST)
Message-ID: <6b00bbe6.a20bb0e4.a3670.0222@mx.google.com>
Date: Fri, 20 Nov 2026 13:30:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6330952026910309398=="
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
To: linux-bluetooth@vger.kernel.org, 2122295973@qq.com
Subject: RE: [v4] Bluetooth: RFCOMM: hold the listener across child teardown
In-Reply-To: <tencent_F776F667C4504F55486A5FFFE91A655E1708@qq.com>
References: <tencent_F776F667C4504F55486A5FFFE91A655E1708@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6330952026910309398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1217473/

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.19 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      23.20 seconds
CheckAllWarning               PASS      27.38 seconds
CheckSparse                   PASS      29.28 seconds
BuildKernel32                 PASS      23.44 seconds
CheckKernelLLVM               PASS      23.88 seconds
TestRunnerSetup               PASS      550.85 seconds
TestRunner_rfcomm-tester      PASS      6.88 seconds
IncrementalBuild              PASS      22.55 seconds



https://github.com/bluez/bluetooth-next/pull/1169

---
Regards,
Linux Bluetooth


--===============6330952026910309398==--
