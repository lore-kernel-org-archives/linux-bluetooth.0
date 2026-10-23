Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778092;
	b=XhZxOTtnwjPHUUYcplGfP4OZasGdFhG+qloa8Uoy79lwrSUEd86tyM4e2xo9yRK5wjfA
	 7oLYOzOrQUwuPMedkZsas2GBOoEBtiM+wbmcRnbF2N6Elg42meAqLXdAqFdxOIc7aRJDv
	 wIMiUOc7+svsI7NaTnxJH1cOp1Ug7QwsbHBNMJPBWFlH3Ax43l7qPeDajcO0HzELhQH4p
	 MFNqrJ/lNP8tndb0/fzj6cpwUj6il5vMyRFCpzc5O/91iKxUbPr03m4fXnLPopNjst7yY
	 WIQL/VuQZM74lpohXeAkxOyT0LBz9f3CSEOhov78kBXeRsVC8c3MZ5b/MY8cYhdIwdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=tz1l+vhiYncppU6l5cVZcphcy75OznR+QdK0ma7eoUI=;
	b=UWET6oHp9g+rNdAwa/63MZhNFGxMU0Y3Z5zCJDR4w+0bbujYxdI+wpA9V+lpmxdCOosD
	 KHioNgL9LHjmkrR0ZL0N0Ox+MHyH3NGeVZUNoQDbz85I7zn4WOEQKoNUUS36zOCOg6puM
	 GuCT7vr7NcgPu7UFJUJWLpV6zMJ4sdE0cL2XiR/65pFor+jKRIVwOAtsX8gmgTkAAoi02
	 xsvZbudDIHP95oCpTMpYDQB2HasGDV55m+lW4ZkzinyDAqySoT68NMDWB+ZaKaBV3UPT0
	 RM97+WheEHMryBVZcWfc7DUSfDtbSDfen+Imsg9AxwOYJi2jvbqreKAAmYiLwblMoFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rUsDi9N5;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ECE606A31B
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 17:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13ECE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rUsDi9N5
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-930c0f9c1b1so107255485a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 10:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792778091; x=1793382891; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tz1l+vhiYncppU6l5cVZcphcy75OznR+QdK0ma7eoUI=;
        b=rUsDi9N5yYMl4t94hClcYA0FrvsPvjKv06eW/d+GqycRRyA2FKZ0qAHJuPBfj6v8vp
         DA03wZBkBl6msn/3uNVy3aJ0Fqk63idBKzOIVI7SbQfjc016HF8i5rr1z7YyeNgbGIwf
         GYXiC2BQ/EgDOK/owJYC9S199uWUuCYAP74YDA6K1rdzb1XUKYtS53sZ5X4dfp1w4bet
         uLS57zKN9Rz7OTm1+05bLOv/WJtnDSJDjcPbNMIMXDuVaTrwE4BhyQ9BFfY8xItSqZUM
         pu9dEKUNtwarxQk4Ju7ciOkQlifVyam54Qw2KftHJuTA/8FGXiIHPObQecHQV4Xct/xh
         YeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778091; x=1793382891;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tz1l+vhiYncppU6l5cVZcphcy75OznR+QdK0ma7eoUI=;
        b=EZ8M71LZiSWlZ7WFYrB7KrocnD7e2BvT0dBjjYRHTTJ+gJc1PdyLRojyfUcTyxldHW
         gSh7ew30m3Wwi9ZiAT0xv+MccKM/0NI19MLoowaD1iXULBAH1eJjcPsSdrP+JEc9kDIa
         5XtKrHUrg5C0Aw6ENpXafHXBM8sS2qKz5tIRPSwcTzMllOxTwQu30ftJq741F/QKtf4M
         4unDUYP2pV9hsg99SA1A45KSRPGd5US/XaxYQnq3ZT0ViB+3SDX7mid9EJuOFIMc7Clh
         5HtYITaNkODFgVJr+MqYNNQ/3vBNePwJENj/ULeh8aXWI/OOivl1CwD1G5x8BGw+D+m+
         blTg==
X-Gm-Message-State: AFq9FYL0ygZpeTjMS2BqhP0NNw+6kP6oBvil7eCR8573s5DMuurrt9m6
	2mV/FYZJzJqV5gV08IZRm3tkPcBmrbGgfz+0iosY8wue8XoTFF+2ixLf7N9xdA==
X-Gm-Gg: AYBFou34/uwe38XGvsVeG9UgB7XnJoeogSD7YdTPy2GmLlbtonwbWR51swDgzK3+J/I
	+eGQQDz8fw85NEsr357p2y/59E5AGkTMg0+m+AvheGavuQU3gbmiGfpI5OiUY8owVuv8FjqsamJ
	DrkDa6rFEFIArbkexXMw3D8HiCCTuGn3tk1eyjrxvk5/33vU1n81xpHH31SONCNEhWjVrrgcidD
	Fu1u+/A2C6/pbQGi1Nx6ZbA7MW0Iikj7eLyuwOOsKkMBAYENEQNhmAgDFPzYKG0kBP0qWz2yClw
	7wll1OVPIhdgGmZ1Pau2piwjMgp583C44OQI7H6ohlJmjYDlUEdluic97YmZrHD4HKLq4oLV/jx
	f0jjq0B/w99jm5y45LeuOLlWcwBd95+nuZFmZ74sqMFXskuTwksz/B2cy5/Gt6+aQtHJXvSYKuO
	SYiV2Qn3UCNMqkcppLX8GCYOZ3k1yIJOLWxbcVY95gaSLlVIyxSCgHbFLi0lGYACTThchRkClAb
	0RVoV59BGBYivRWtjWvizHHUBS2OpIo5LwF4CeJ+T6nU3pWdwbTRPD/6cZ6EriGQgIot3LGlgYW
	dBMO9wUVGg==
X-Received: by 2002:a05:620a:6f05:b0:93b:c58c:d3be with SMTP id af79cd13be357-93f6f7e6570mr529443985a.37.1792778090887;
        Fri, 23 Oct 2026 10:54:50 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.177.229])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94047af4e31sm78872785a.22.2026.10.23.10.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:54:50 -0700 (PDT)
Message-ID: <6adb9f6a.9c4c6676.3886bd.710d@mx.google.com>
Date: Fri, 23 Oct 2026 10:54:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7192656347289748763=="
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
To: linux-bluetooth@vger.kernel.org, 847807867@qq.com
Subject: RE: Bluetooth: hci_core: Fix queuing rx_work after workqueue is drained
In-Reply-To: <tencent_311037416C6C02CC1D493A83255C1EBD8905@qq.com>
References: <tencent_311037416C6C02CC1D493A83255C1EBD8905@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7192656347289748763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1192220/

---Test result---

Test Summary:
CheckPatch                    PASS      0.79 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      29.76 seconds
CheckAllWarning               PASS      34.03 seconds
CheckSparse                   PASS      36.64 seconds
BuildKernel32                 PASS      29.87 seconds
CheckKernelLLVM               PASS      33.89 seconds
TestRunnerSetup               PASS      708.61 seconds
TestRunner_l2cap-tester       PASS      12.78 seconds
TestRunner_iso-tester         PASS      10.75 seconds
TestRunner_bnep-tester        PASS      3.16 seconds
TestRunner_mgmt-tester        PASS      87.80 seconds
TestRunner_rfcomm-tester      PASS      4.53 seconds
TestRunner_sco-tester         PASS      5.68 seconds
TestRunner_ioctl-tester       PASS      4.69 seconds
TestRunner_mesh-tester        PASS      5.59 seconds
TestRunner_smp-tester         PASS      4.44 seconds
TestRunner_userchan-tester    PASS      3.28 seconds
TestRunner_6lowpan-tester     PASS      11.92 seconds
IncrementalBuild              PASS      28.71 seconds



https://github.com/bluez/bluetooth-next/pull/989

---
Regards,
Linux Bluetooth


--===============7192656347289748763==--
