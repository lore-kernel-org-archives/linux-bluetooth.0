Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B65227452
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 18:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738087656; cv=none; b=B/Lv+gvlUpccMr6NbHymgnarSxPwV1UldZTgxiRx//J8EEbc0/uyujSfHfo1vFvvUzdUY1gj7ZrQHQe4ls+U9f8L1vLm8QYP5nFJRBG8LWuxzKqEtWiNhL6xlgu5KZDGaL6zEWk7/0+NsJq+oFoWAGvddhyKvh5bWJB2kkREHp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738087656; c=relaxed/simple;
	bh=hXEvafxr+Fgp62SzLMYqCfjFohl911ZiYMvGvERRYMg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=emHcVFqfjb0kpGibLuHVS8dC5k1TQfMELWLC9tnAVSXde91hEgK5O/6A+FPoeEQOICIk3H7RQo+xFV8eXfdvj63wZwbZl5Pe0ci4ykZwGLsXE9t1vR5atjnVfdL71wLCoCXztxqlxFy7YgN7M9EExMgY1ChhsEpa3W9t+URsI20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+2BfmKq; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+2BfmKq"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b9bc648736so606750285a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 10:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738087653; x=1738692453; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LZHEPVDJRi/ORXoVAzrV10j+6M9SbFWbKcHH0HR+hPw=;
        b=i+2BfmKqVJKACvjjuLzevjXDRbm5w1SFbn164TSGutYWxgmHOlPOCxo7Mmvbu7+RAw
         ygvJrmo8lW5D3Ut3c9dAcBgGYlomUKJRydtfgM6l3HskMP2KeeK776dKvVjghrVUs3GC
         j25eEDM/Mjm07dbLXx4d2CShHyt5Puc7zb5NSKgELwQ0xWO/GF7YtlRA9IGAv3z5eyBQ
         ogx7zXYklHd712Dj7ml97itbH7X94QXMKZv0aYo4pS/VDNTtxenNeBsfWxA0i8/avhwO
         neYmj5IKHZKnz/0LlUcCRme+mp0LfhTP/7BQS+F+X5iVMOVeP0cqCHBHpP+/uk4RQEiB
         11jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738087653; x=1738692453;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZHEPVDJRi/ORXoVAzrV10j+6M9SbFWbKcHH0HR+hPw=;
        b=okQRewZ9/MycgjpCOZWpeJ7LdA4O6edOziWpFZ9YYobQAJf4Dn68axO87L4+CEZILH
         5Cr/NxL30AJb9rLI8NBIE6r9IOlC4vAu70+Ixzmcbc8mPamaLb16PtvL8626hKAKUX9J
         cYQIdQOfIoOrl7sYMtfblNCFYn/MAifqE4EGhLmv5xcyYEMEvzEd8CmcIQErKYCt8dGP
         3RA6dFZ2mLYlnhgQVIS91Ip9nlnpPKj17LCHtsgplWnZJQpeGFtQvylrCK9IP6jq3oUW
         Uq7TtAUXy2VVve2TI4pS7Q7qyUSxGtNIWdMAtKLzx1LW3AAeC9GMCkQ8u6f2oHJdKMxx
         ktRQ==
X-Gm-Message-State: AOJu0Yz1t2VJv5g5sXyUYBvrMMmEP1RUWQOhTk4b1e7hlGXv4NsSanFr
	WlJRznXMpPUKo+hKymdO+mYWuDMXC2ozbQaMc3/3Df4o7AetwXgvP8pE6A==
X-Gm-Gg: ASbGncvDdC2ek9iKLQ857Ubzr8JQdk9r3rBFHBzLvqzgJcqZ8wHpBPkB+k4zDkyIA5k
	8IqwRXoXy+PKqAj8oIuNFJiQtMvmqFNTPRzgnCuH9+KtYHHKJdtcZcm06uRo1BFk+CYdGMp0DGf
	ExKItiMTSJl2rej0M+MnVha+csk/PyzYenUSMVqE7xSyFD7oKidaI5gg1oE6YsOGE11+iJMyOQh
	NRkIYLxa1qIxC61Qbb9l5qB/OMtj8NiW2ldZP/o/CnqUkRdIcEOo4JOaDlNzGrElEGSVFZxTMPT
	1U3Pcy4FyHUjXgcDgHsqMkt1
X-Google-Smtp-Source: AGHT+IGblwH/MygEZBm4ra+k+omb7mYqUuutGKdXQ/lN/pLNBu8fY1qsWzK/yhmcIzFiN0uCjLZJJw==
X-Received: by 2002:a05:620a:1a0f:b0:7be:55f3:32ca with SMTP id af79cd13be357-7be631f3069mr6413049485a.19.1738087653059;
        Tue, 28 Jan 2025 10:07:33 -0800 (PST)
Received: from [172.17.0.2] ([172.190.111.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e68c66420sm51330871cf.3.2025.01.28.10.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 10:07:32 -0800 (PST)
Message-ID: <67991ce4.050a0220.155ff3.486a@mx.google.com>
Date: Tue, 28 Jan 2025 10:07:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5490601353003518683=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] org.bluez.GattCharacteristic: Add confirmation support to AcquireNotify
In-Reply-To: <20250128165424.1044479-1-luiz.dentz@gmail.com>
References: <20250128165424.1044479-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5490601353003518683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928892

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      20.08 seconds
BluezMake                     PASS      1559.01 seconds
MakeCheck                     PASS      13.12 seconds
MakeDistcheck                 PASS      156.65 seconds
CheckValgrind                 PASS      212.54 seconds
CheckSmatch                   PASS      267.63 seconds
bluezmakeextell               PASS      97.26 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      844.59 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5490601353003518683==--
