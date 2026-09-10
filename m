Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6014C38F92F
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065850; cv=none; b=uXEmLI1NEYqlvV+VNMOK0wOmFkmwFKZw4CrTmw7co8dz+Mm0NFf/wzY9khGo2a6vmOMziszlbj/1gYtnwEbin7p8KVLdKLlZRAuVjAASIPA2PD3Z2p07HvCxusxGgR6Hz4LBJt4znrgaKhAYvZxqn3qrmwaO4my6ZVjZ7d0wS/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065850; c=relaxed/simple;
	bh=9qsvMgN9xCzy0reQQJkOar+BI9pSaUwvsknWtN1ZzZ0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EmlTU5g4X64kCgF8Q+tsL3HdAUwDFEo4GTJC7RMFB5r1V6ByOCRstguWq9OxH4XwevTIMUahL9aNo1HTi+yh9DDcLYYBYcLZJ1NPFhIaF8ipZQzfXrQEzcisV5wLmMS2+krwVjbnA+j91Glk0KlF/PfMnCt4JOoRSmKP1I1ckpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dw7igN60; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dw7igN60"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910ca5aa6so1507185a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789065848; x=1789670648; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tTUUVltG7VMnubxeCdeAUZAxfII3QZKHzWVbyQXxSv0=;
        b=dw7igN604P9niCGyVgxXs/ewGXzaQW5mJmYXonhsE+sVJKxO+x7q5tGLjOPeOSLHIz
         W+g00t5ZgzCha8VlBX9vjug++/z8WFFdLNmQIs2fS8ZHK+sP1IvRuMs87u494pjIgIle
         PAEoJncoMR3h0V8vRuOAaLq3em5ngpNhQ38+PK1w66Zj7YEZV+IxnOIA+sjsqFrKIOV/
         QKiZnbXFprv9Y528YkJfAEEQUTGWop7uwGkIKf05C+TSrYASNTNx0bpcDdett7YuWXnu
         azi/aG1gaPb+O13K3qpKqF/hrahsSPXM2tkpbDXqnXsqx+vWbdJMoEa/ZNYfCzkEzRRI
         +aPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065848; x=1789670648;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tTUUVltG7VMnubxeCdeAUZAxfII3QZKHzWVbyQXxSv0=;
        b=e/NamjnlOllc54ibaBo0muREiy3AB5xjatQ6VsS38aT91CPzVhR7tzt5f9wic0XvTL
         56oERLk+xs338Q8z/LrfiIay9GWCymdMMNRs/UN4rVayzwz3Hhw6ED0Gl68gcWlByx7F
         iaO64A+FzF31UxkXwHWo3TCzESw4YURMQXMuH+0BAc97KLkDwUKpUFWJyFLHhQK8i1Hu
         JENFDa53n2u8G4VIVk1i33G91345v1QOFRRcHOZma65afshQF82UdW+1HuRZWgNTck2R
         pnd3jOIKY3ZPPAjI2Ip5pMgFcScAdP5ioM4HsdARYnbhwfpKBBef1PBuLEwF1CBZquQl
         8nMg==
X-Gm-Message-State: AFuF++m49zfUsLEdz7xOPHxzoWYNDmq3Pj4llNmhx1NxJL+GO40hnidb
	iWudClphTi6d4AsQF+RUAtcbH7dSEkXoXivDQPWIVhqz/KIcJ3MXhhZBcYnBvQ==
X-Gm-Gg: AYBFou15UYALR9vcrQyssyKy6wMy0mjxE5hzolwdZFBNVAo46VG0llmUDeB6QDMXw8t
	O2rEuXfNFn30c0u/KgMX5uTlog0VubSFcaChgca2OMsEfngyyfdJ9E70TCgSEofTj2MOQmOmV1Y
	NB/qj1rJ2rz3xjiaDfBHMZ29UqCeEEwuzN3gF2+vDmvXs/4mC30m7wAKpOeY/fTWd9TJOMchLok
	DGFjilgfe5CiccHGURjO2m/JF52TJnnDw0T9z8LBj7L3efZ7Nc6KazFpALHmJLnxLkz8GOBe4UU
	KN2hPiW+dI+38Plmi7W7CGvw2v+b1bsSHxVYuvo5EzimW+SA/87TkmlMJ1G3HBnZjAjHIqLtnp4
	Sm7f/SYy/ehQsVDtau7KVZRE5eU+zG6s36G/NWx4yXPxYJ+1MsdTHzu7kSoFVbJahRGUEn8vFGm
	GVCj+djGTO/y3F8Tou/Kw6bSJPkTvedNpdaUv9GNh7r5TmiDExkdsKWorv/Kpb8GzTUfOMVEwIy
	mrqjA==
X-Received: by 2002:a05:620a:8014:b0:939:7e6d:2240 with SMTP id af79cd13be357-939ea28e4b3mr14670285a.40.1789065848157;
        Thu, 10 Sep 2026 11:44:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.38.115])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4d389esm2344696d6.42.2026.09.10.11.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:44:07 -0700 (PDT)
Message-ID: <6aa2fa77.4839078e.6e879.2c75@mx.google.com>
Date: Thu, 10 Sep 2026 11:44:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1636876596277950701=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, deaner92@yahoo.com
Subject: RE: [v3] Bluetooth: Fix code style error
In-Reply-To: <20260825122207.101868-1-deaner92@yahoo.com>
References: <20260825122207.101868-1-deaner92@yahoo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1636876596277950701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1151528/

---Test result---

Test Summary:
CheckPatch                    PASS      0.92 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      27.62 seconds
CheckAllWarning               PASS      32.08 seconds
CheckSparse                   PASS      35.24 seconds
BuildKernel32                 PASS      28.23 seconds
CheckKernelLLVM               PASS      43.62 seconds
TestRunnerSetup               PASS      730.95 seconds
IncrementalBuild              PASS      26.45 seconds



https://github.com/bluez/bluetooth-next/pull/746

---
Regards,
Linux Bluetooth


--===============1636876596277950701==--
