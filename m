Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792789762;
	b=YEDZ9YunWvuoqTd/6+gBVHtT2Ir3yvkGBTHkxUFQK/o6tk0HNY31jiVvo0w+tNN53mxO
	 Ok3Z8NplR7wDX8itICGrEhs3A2UdCqXZqftRE5GonhzRfsBcEGyskoLJEL+dsTegZTe6e
	 1CByE4gWEbhjUnc01CkDERrB56GnkCzUv+nFS9J4ua2hNY8rpwn35o2teJfrquh+Qld9W
	 70WNmQNCZB/75u9dkj8q3RktwZfj4UaoBczmlTGuKb8tbiy8Ke9/hwdFdTkW0ogxAm8Ux
	 tyxedS1BOWykZsoHiRhv37T0eAqDiSz5GbbsWnHO06Mvnkexlqc7GASPW1h4nCqkPtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=tfRj2HOSDUxsosEUuXPa/sY8W4SvN/bY3FQGkV6mGuE=;
	b=yiawC4EfvuttneIpZPyfleHHuXbo+1ho6F2tEZKPGo2LPTH1Tej58q/i2NFnzbO4jjbY
	 x1p59EseG9icp3MMXFRHdPiJTk8QVFqu7RoXL2cBxnZ355IrlangGLR/07pliaHKEBCmN
	 99v1a48DG/nIRfVwwLZZo+4bOLJ6dqDUPheZzvtNQIX3gHskr90DwiWILY/FMHxWMLF9C
	 DzkJS5T+Eu0BNJ8TCibcnPsxPIn31EVFWWNpunS5w5AcMY6ki2ltDGHxunwfZLyJA+ygE
	 3ibfmJLUPaC5xGF9sImxLFekThCZflOk0HWlp1MV+OvhhNrm4CYLtuidqc0l0Uh79aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="HN/cRuoO";
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB59606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 21:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCB59606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HN/cRuoO
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so953699a91.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 14:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792789761; x=1793394561; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tfRj2HOSDUxsosEUuXPa/sY8W4SvN/bY3FQGkV6mGuE=;
        b=HN/cRuoOzS8fSdgDUqbTPbTrk+sN7Is3zLnbXnGeAfbRI7dxXkONQwUUrjPMj3aHqz
         SzgeCYpnlp8FnoLwLp2EcCe/1PN8ufYwzRk0Fz1kKPRUveL2uX6P2LWDotlEyZn1ZAad
         Isol9Y/aoXVgeVnVww7ET7gRVgCKHW6hBYcabYeWLko2evy9GEG0K9BFP35MQsEocZNF
         KZ29ROS73uAVQE2otWcTiSx1CCAjKNSqafUOZXGABuIn695ZJqe86hicUD14Is76IYkv
         4TK+EvztfTERquomQ7R2DFZCXuk73z2W8h7Gk68PbPExqWH4UDpobts6muDZzQ5jDxhT
         /Yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792789761; x=1793394561;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tfRj2HOSDUxsosEUuXPa/sY8W4SvN/bY3FQGkV6mGuE=;
        b=V5dBu/wuSfcxhcUlobAH9/YMSKB3AxieVXofYwVxdpdccpSJM8OmBwFoYNzsP8xitZ
         hzFEbyiw3VSOaSnwpUqnBDphd52dl924u7Rncnp9wOkBny9P2iET1aZoAMpjwzCS4Ngv
         vDQz6CQkqTPlYHirgarrnrSmsHNcBr3du4vma4Wi9HggprvDeBqgHLuehmoL1VEYNq6D
         auvaYowuD7nJVhQmKXvd+n5cB90QssL3lEY/ZgfpfIqf/slXTjdKNkipM4N+a8eKu/TK
         uaVvQ2elXP2UxkjR1pZb0j97yBmmkKOLxVD8NX3ZQrn7Si++b1lGz8yt/jAXLKUfgsBf
         sQoA==
X-Gm-Message-State: AFq9FYIH5lthUBt2n8ToVoRzRe2CusOXiyblMP1sSYOfELdSq3sOS/hJ
	6KMN+Aw9nd8qmkc1SAc6S5IEWs/2mmcZIHpJSu55GwKCTAX9ld4pEs7VRK8ZUQ==
X-Gm-Gg: AYBFou1x0aTGk3j18mLpvtP0LumpmDpUaXkrWIKvA/x870m/+6Oq+I/gCR2E1olri2O
	Mp8ORIlK+qywalLHxIvUPx3vZ3W15lmuPp9JFlA6GR8+gz/Nm8xhT6VbqmGD7e8xARuAyRQH8EP
	E+cOQj+9wGRBLZOCOquQqRnOcs44sigDWjRk5s2t2D+usOZyQki1ntNzQ1xfhcHSPAwESVdNyWb
	1b2DuX5bcPNbNqXfKor8pnwX7hgAZEJ6B6n1X0NmGbjYRKdnjol1kxUjisaJLB6+pwiyC7aMzce
	F8AGv03VWvkjU/m7GIenNjSFNBQ8cZvx4ypLVjCDlMOZPatOhBjZ3TnP72exWtf0TQMjIqevh/u
	T2HnEX6NBaibWbA+XJK0oCSck6cEOTnnBJfQ4OSOcP9eWGU3H8gE+oTN6FlW4JnTSiOJPv8ZPhQ
	jmnHIqZZ64iMRfFyeNvSB17sITMs6fQLtGsk1VfzH3c/L4e5ukvhD6Rm7DxutFGBPGHTv70Dh0w
	8q8wXJ0Yk9CkuTuIGOa5b9ta8LsYVTAmNV6QerDbgPYI5k134f93hJAuMvsNxI=
X-Received: by 2002:a17:90b:280c:b0:3ad:870d:1bfa with SMTP id 98e67ed59e1d1-3adead57cbfmr335479a91.23.1792789760998;
        Fri, 23 Oct 2026 14:09:20 -0700 (PDT)
Received: from [172.17.0.2] ([128.85.44.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebacc885sm417339a91.5.2026.10.23.14.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 14:09:20 -0700 (PDT)
Message-ID: <6adbcd00.488c8742.323f60.c00a@mx.google.com>
Date: Fri, 23 Oct 2026 14:09:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2610458959543488928=="
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
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: [v2] Bluetooth: hci_event: Clear explicit connect state on LE connection
In-Reply-To: <20261023191437.87024-1-kevin@simpleble.org>
References: <20261023191437.87024-1-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2610458959543488928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1192371/

---Test result---

Test Summary:
CheckPatch                    PASS      0.83 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      30.53 seconds
CheckAllWarning               PASS      38.20 seconds
CheckSparse                   WARNING   37.42 seconds
BuildKernel32                 PASS      30.58 seconds
CheckKernelLLVM               PASS      34.56 seconds
TestRunnerSetup               PASS      725.40 seconds
TestRunner_l2cap-tester       PASS      12.88 seconds
TestRunner_iso-tester         PASS      10.87 seconds
TestRunner_bnep-tester        PASS      3.10 seconds
TestRunner_mgmt-tester        PASS      88.06 seconds
TestRunner_rfcomm-tester      PASS      4.49 seconds
TestRunner_sco-tester         PASS      5.68 seconds
TestRunner_ioctl-tester       PASS      4.70 seconds
TestRunner_mesh-tester        PASS      5.56 seconds
TestRunner_smp-tester         PASS      4.38 seconds
TestRunner_userchan-tester    PASS      3.23 seconds
TestRunner_6lowpan-tester     PASS      4.46 seconds
IncrementalBuild              PASS      30.83 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/991

---
Regards,
Linux Bluetooth


--===============2610458959543488928==--
