Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870245;
	b=OoF2MIRiQyywJvUZGvvF7IECB7rRlzj0Mhwxrwu9+lx9Km+YzDzunK7iL5J9vjw45WWj
	 Rpv6aAZky1cT8GMbws4l3plLpAjdidmoTfloXi1tBl/qOwZiDLmNpgS6iv8G1d57wSXRt
	 XIVOm7wG+abMOBUaT1vx38lI2a45mLbza1uzY+1UldBCc+39fcfF+x6FXnIOzcgwdYbv4
	 lEezp5YOtm305f2lKJVRdOd1H7YxOTMiG1Hpi4QNusyKoOKlqKfXY6Ttk+d33q3Tzml2v
	 k5xBszkPYaYJIZQe54PA3Ma8tAXWqaXs2D8bHEI9hvZuH5hPZzaOHeOYoaoCOqkuO6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=wrkpRmb2VG/o7ZJfRhjnWsOLEmUYjop4DC36TiUN7BM=;
	b=jyxl4/JUeyzzg3wRAzywWqY2aRTfVbEO5ttsDtjGFP1pDYteecbWhnzNh5uVVi2QHzTj
	 UHsLCkG9q/YMxUjmAIbk5SF9ri2Ya0h/lDYAUVgy9CzFz60MxRDd7NfOh/KuO0MAIsgQK
	 9PK26Q3uhNVRk2+REM1z7yRElAMBaEtfDGXr3FagBH52UODOF5VcMsRsa6SghL8/BLXsO
	 E7fdWLOJYaXGzlftFIyOnMzWj8OVsarIcY5Bcm8hsosLzUMFfEd1eqLLf0MD+CwPo8IIr
	 VxQ12sBKHboM4I1/nH4uWilb/cgzRJuwZXGgbuNTKdd730M4D/k87bs/ObxfsFD48EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mu4+3o8A;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F0C606A31B
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 09:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55F0C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mu4+3o8A
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f259cdc86so163269885a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 01:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793870244; x=1794475044; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wrkpRmb2VG/o7ZJfRhjnWsOLEmUYjop4DC36TiUN7BM=;
        b=Mu4+3o8AdAsnvQPv/6q1WIKE9BslYlnjCVheDHPgrcZxBFSoGJz6diwFKu3yoAUlYI
         /RtHMaXShaJ+by+y6/YXKAUL0Z6rm9u1uzIaYFOh3BjY0y1LjhZGSrlP7NGlpcQ3YNoK
         Z9Co0/h6en7DqV2t22QwZQXdr6h+DT8HF0SOh7KPuhboy6ihOr75h3gvexphsJlBunNV
         tsPSbjdYEyXu8BB166Kjtbo0B94dZZLF54+ec0zo0DOe5hPw7bmQ7WLYZNcnKq8k9txe
         c+pXDMTjPdctecuRyg+ZrwWrBh1uMTrUn9jYB0jJk4PiG/Ha9dlEsf+ZMJ6Ywx1TwiUw
         YOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793870244; x=1794475044;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wrkpRmb2VG/o7ZJfRhjnWsOLEmUYjop4DC36TiUN7BM=;
        b=YwYAksRd0kXOKCuR8/hkMCRHs82AC/PKJILjTIf2YTDsK045zHOscp6/ZSivPgelyN
         8oA/Hd7Y1XKjFORg7QX8e3cSHWhGxURLLaO8tXQdM4QAu0mDqsd8xx4HJT35J82NEeHa
         G3Xmadh9garPMjHlEPvabq5m4si14M0cXGRJMKPVE+BuFMqn+z1SSCuC9LYJ5lRN7vn5
         4ka4vV1z8ZWh9UHKwr2KuqDIFt3uJ/qHj84AHFcw0338JbEdMHp02vINmmZcz1OvqKRQ
         W8X8xEZynGE1AZu0Zm8/6rOTGGzIDNFUzbzwAB8VqfVjjdvZ5HJRMZWi+Q4AKauQqgU8
         y9zQ==
X-Gm-Message-State: APuU4Z/xTe4/DtinFu1LQU872Kn40jbrq4htmXO6nY8pudL3IBG/6xAh
	LftS/FmULR+6xrBn7YzIgdQLizKKHN2iboKRzDYu+GE0a5XU+Ky5ZvRhY+/elh+n
X-Gm-Gg: AYBFou30rcqrfwHXZXQyk1iPy4zO9b8s5u8EPdf4He/i+UajTXyDtj/EJTUd0F5fNKZ
	MSDvVczmoxb9BGAQxRCzXS4lxPxQH72z9f/kWQbc+Xbi3B2SinTgLqlRD9QZECvbZ810HzWGano
	Wq3f6X0c+6TqSeEguL70jhhpeVIgNPK9YMGhKnvC6JohWKLDjvVhqHh6SF0LHsaNpNxf4MGmajB
	vQXORHxX7qrHE1bughLPwcWmjhSN0QjzVCc9Tk9wCzm1TXoa5FvvKwpaxXHUEcPG2XRjiyeAB1O
	BwLXSyEfgneMx5EyYmyYrdmX/Df5S5WK07y05cUmIFb7BqaXzkDKeWcX1275scqzOsxrwFGoj8H
	iyU7leUTYnL0bB8hcGGm/LcKr8odimLw2bWTMcHpxkcVhv0idjitlx7ENmDOMShcOPkEjzzicY2
	XBCK4F42xC6f6s16wG4BIoFHvq6NojImSUkG9xzTnWl5Rvsb++neuAu94vDZuKockxiYdl8/Qrb
	o427tiUnAKVFlOrilBfE1NtBs34BwVZcHEvp2g9JGRqPuEHaiNq8CZgKj2cb4q2yiSGYbuTZh8u
	Vw4XCXyMef8ieUdHf+G05N6+v2Xg+NE=
X-Received: by 2002:a05:620a:17a4:b0:93a:2d15:f84 with SMTP id af79cd13be357-9442179c0bemr3262687285a.33.1793870244271;
        Thu, 05 Nov 2026 01:17:24 -0800 (PST)
Received: from [172.17.0.2] (ec2-98-89-53-239.compute-1.amazonaws.com. [98.89.53.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e0139ccsm43159016d6.28.2026.11.05.01.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 01:17:23 -0800 (PST)
Message-ID: <6aec49a3.b322084d.1f1a64.4af7@mx.google.com>
Date: Thu, 05 Nov 2026 01:17:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1519038229620950677=="
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
To: linux-bluetooth@vger.kernel.org, 25031212351@stu.xidian.edu.cn
Subject: RE: [v3] Bluetooth: btusb: fix use-after-free in force_poll_sync
In-Reply-To: <20261105055639.12824-1-25031212351@stu.xidian.edu.cn>
References: <20261105055639.12824-1-25031212351@stu.xidian.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1519038229620950677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1202754/

---Test result---

Test Summary:
CheckPatch                    PASS      12.14 seconds
VerifyFixes                   PASS      0.20 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.56 seconds
CheckAllWarning               PASS      22.95 seconds
CheckSparse                   PASS      24.46 seconds
BuildKernel32                 PASS      20.30 seconds
CheckKernelLLVM               PASS      20.38 seconds
TestRunnerSetup               PASS      493.90 seconds
IncrementalBuild              PASS      75.69 seconds



https://github.com/bluez/bluetooth-next/pull/1069

---
Regards,
Linux Bluetooth


--===============1519038229620950677==--
