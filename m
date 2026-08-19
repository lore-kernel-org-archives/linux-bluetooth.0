Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBE32F5337
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 06:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787120903; cv=none; b=LUYPpVwz0JmlmVKlgw/Ni+VXFQHloPwIvYlY1Qu3EiHNWnP795N/9rf9YjSnRu+CDjuSci3WUcfF72gQ+N4R1Um3dg58AhB5ahSy+TaWcQogz2FzEW63oNOx/K0YsYE9dLvOQQV9lGBYk0tYuCpVn34z8e+nWyIUV4f1xR2/Gcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787120903; c=relaxed/simple;
	bh=0XPIAzkpUtlnbAnorNp7lXdIRvRTqLMNIw318ZzNVwQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OJQG1fx+KZn8voHrVd3xHrSuSxsek9tSgkJy9Q6OapUbUIRY0GJ+aVRcpPyLvroC8yoTKGahUZ+FNoKeRc5pvCHCr9SUk8ueALbzq+POnwfPoAXfT71PQxIj1Sp4C7p17zQ7hnWnqG7U3I1D52qPJ6Gv+5lnhiBDcFQD/xc1QkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pCtEYA77; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCtEYA77"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-934956bee57so72337685a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 23:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787120901; x=1787725701; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BTnrhpBBQMxEqTLeJhZAMnx0LcFuKTTictLTJU7ktok=;
        b=pCtEYA77Z6NkpVhyQnN30oXpooBM/odCTCGvcSt7Kv9yGX7+IrcTyr2CMSGPyrO9/Z
         6fLFhxVo66bog6IJuhzfXXB2V28hQFqO/gduCaNyQj06CVWQF0u4GPzTI3Dh1wxs3/71
         JgOGkAejK39Q5PU0gTjL+qOuN32tOl2mIfsu8frx/XiNgYp6TksqPVNPCG5JC+NcnGBh
         BldxPGuUzbxrEdcm3Rxe+E91/tShbyVb8gxad9zA3XA/fJMveFMrhYXVapO/+W7taAiq
         Ao2WuIGN0vTVlsQg6Jv8d5wlE/K/dUIHQpcnVdzveb1BQ7CMTZA/G9Bl+Ii3/BbyzPHb
         aNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787120901; x=1787725701;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BTnrhpBBQMxEqTLeJhZAMnx0LcFuKTTictLTJU7ktok=;
        b=eMVN3OYgWqWioy2PFr8R/fEIrrVvGL0qBWbVb6t7aFXUoYMvGUqmj7Ekvw8exxAoCn
         A5427PkNlRI4R0bJUmomUylR2gqKg0suKeB06TDNHHPhnoB6bUDAKrsF2YKTz5OQN1dL
         +pVgYiu4w5OcmMofeELJeaSJ4PPcxcnE8OmkywyDw4IemUXoNxrFBODb50L+ou2RrDvH
         m52JgxnJPSPUkEeCsCSegBLFMyafd15vmU6x+V9HC79IRCrjmXDDMBqFe6iJ/OoPbIet
         vVkHrVN1QFS2dDzFg7z2ugoB6C2FZSjle4MDdw77zpadjGzI1kZ6ZDGMz76CSzhHpLYj
         cSGQ==
X-Gm-Message-State: AOJu0YwyuVKy44flcmjjAjtcZHHx/AqdI/F7rB6uVfD568xPt7BFQE9D
	h3FJ+IzJTE1KUcdQHU6S7johc3uDguihgkYBPSCyTC0QM4cTGw6xrGpa+At1Jw==
X-Gm-Gg: AR+sD12HehDBmNMQcBZU5G9gHT0thE1sJz8pxvA73M0U6SZfo+tLquIIUgWS26amEPb
	VDr3z6uKJU1iimb0S0L3xG9+6YKYN+654FzEFyOeCzrW5ozqjHbq/tBHspyS8GsF/xewkBFhjle
	RNn8AJowvQ4BMBTWLgMU0F75DIDMlO/Ok+ZcK+3Er936424WrOHmA9WIMjP0UO7QMkGmohvEB9H
	bs/xNnln9kGHETEIpV8ppo0SdO3cSpG35ONDOrTiIQlBJ1GgZPPtVAjf4vHjsoQ4QNZn5acZTuT
	311KnW3x4MbqfrBVf34/Ww7NmrIPiAscMOyKndPOjrI4yfJSGh6zuMhmm+bpu22eD47eHBSTfd4
	Yz6VSJvfMkl5VnhuYt4nGWhe/1lYmuBHF8KvZ8BxEKthSYimXoZEf+u+bTjy7KKvShKwXVZC7nN
	PwuIPZUyRoM3Ao8/OgOZwR3AW93N7+G+J1op00+KVTwRNuajBiIljBFparLcXmLXOIN1KJKaz3F
	QgD
X-Received: by 2002:a05:620a:178c:b0:934:7ffc:7f90 with SMTP id af79cd13be357-9371e30af4emr220927385a.36.1787120900783;
        Tue, 18 Aug 2026 23:28:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.39.49])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9372056b781sm69257685a.24.2026.08.18.23.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 23:28:18 -0700 (PDT)
Message-ID: <6a854d02.4567b959.3aeb8e.0378@mx.google.com>
Date: Tue, 18 Aug 2026 23:28:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2072814500412716570=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lijun01@kylinos.cn
Subject: RE: bluetooth: pm: use SIMPLE_DEV_OPS for pm struct
In-Reply-To: <20260819054525.2325031-1-lijun01@kylinos.cn>
References: <20260819054525.2325031-1-lijun01@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2072814500412716570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1148208

---Test result---

Test Summary:
CheckPatch                    PASS      5.20 seconds
VerifyFixes                   PASS      1.09 seconds
VerifySignedoff               PASS      0.48 seconds
GitLint                       PASS      0.87 seconds
SubjectPrefix                 FAIL      0.12 seconds
BuildKernel                   PASS      28.77 seconds
CheckAllWarning               PASS      29.71 seconds
CheckSparse                   PASS      27.87 seconds
BuildKernel32                 PASS      25.82 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      482.56 seconds
IncrementalBuild              PASS      25.20 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/612

---
Regards,
Linux Bluetooth


--===============2072814500412716570==--
