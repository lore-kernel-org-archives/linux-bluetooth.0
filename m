Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFF41BD50C
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 18:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866025; cv=none; b=mC2SVl/4QfHnymy0Dtdq8eBPRWhe8LiSacTWxltWJ5r9mPvCMOahRZk83lb7/ELNWYHY31RlM7JgbkstHZdAR4k2PkmSWrZwvG5doZbckkGdzs6tRSln9Hel7vDCreDrJoGZU2Ex5Rv+yA+7fXjeP4ZpOzeh4KaC4s/ixAdo4FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866025; c=relaxed/simple;
	bh=KIgdbgSjK0tZBWIvk+uU73bIQB5C6G/eXeqgno72R6k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LJc8ZfotiHoP4flW0mLoMlCXsezr909n2GF0d/F0NglGgMZZlV8wDUIDennHrNKF5sF8igvx9PzaetEmMR4tDaoVI9gbkjjUC8nHVHuKd6XxVImAmfDPKMILIuh16iWHtlSEF22xdtfQ/x/6YNqDJ5MYK3VaF8pnomM/IrWKWH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/D39X5S; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/D39X5S"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8f4c50a8fso54205326d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 11:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745866022; x=1746470822; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2NuKH0FQ2BSSzkOzLjq0pYiPRe3rXVRgSyjQEmAoy4A=;
        b=Y/D39X5SSB/tSFOl7QQouyztQdBVk4zVtLhw4J0Jpea+zbKV/UCnJh1hIC/Viwx8F5
         3q2MH9ChTM6y8Oth+eTVpXpv5V9yhqn3Tt7y8ef/tBJXku+JTf+wuxfg9YfImJXPOZv6
         Ltu+pa9w3VQLvftYqEob9TLeI9kfb1XEwtS+lVHjXLy8Y68g6yTxnaJaH44W4RLgGOas
         p257Q1o9luwUSMTcmFTMnm5TUnAx2UPHrM8tiYE3oadD7JlTetbAS54DSNB5U1iytBL0
         gE+8E0NeFJRmTsiCQ53cUhc2zqqS9aasCWbXK6bgtrsR8yhPVHbGo8Q/yqhKRrjPWa+8
         16CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745866022; x=1746470822;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2NuKH0FQ2BSSzkOzLjq0pYiPRe3rXVRgSyjQEmAoy4A=;
        b=QYHMsBWgvaSbElrtFmbptE3f/zanwqxEvUxTFS0eTaluzI7lVEeioeXe8vGe+dDQzU
         5I3HVVWHyQwo9vNuA2GpVVviBL5oEpL6dw02z7+agm5Nyjid1BK10YGDv6+LD/CdBfdr
         tgSbfTuvp2nJAhrtlgeJLrL2Ky4bq4gKrz9fEeJUcoh+ZHYu84wCxOp6VoLpHHRZxkYX
         Frit/lfbjBdAF8CAPq6h01t6PiauH6l+q/+FG4oSy6+qEY3BHYqzoFxsM8tYoJQ/f9ee
         PyEFcX30xjffzpIQuGPdETwo87jCS9aXQJXCloEp5KslmLkHmQzXar3vMtVL3kSrk7O1
         VD6g==
X-Gm-Message-State: AOJu0Yy0XPBn3CxNJ+mVpfx4HqLEcjDyiJxY2b61ooQEgd1++n0fg9Nx
	gjhHgNn2G1wBJgf+1eHs6o9D/LRUXAupEI7pcmLucqRIMcsvIOi4LcBfzg==
X-Gm-Gg: ASbGncssDWdARxOH7zVRqtr2Jg6jmRHrLgJ8FzVRdGR3awH+vgnxIn+pU3WYqy7BaKo
	HciUc4x6J8QBObjy03YO/P3afv9NyNfhLBVomMNJe6DPl4h4+QtldFqzVfNZ00lIhhhBMsIXSyu
	88r5CaE0p3bjBdg+Uq3Vqb9qh+AzVCSp3gSCmuuWrknQEY0edLoPJD183JNujO9zCaAsaWdYEOL
	b6CQ3YWXLj6OOdgJ+AJOg0TXY/eCGxrSO2aX/bLlKk97SKtSvj3HuSj83H4IRY6WOVuTaiQpLJy
	Tvk0aU0ZHUeDxjNkVh5aZ/ryKG9VINa4hBIRVt9EfnaxesymLU5LvKFSlR4=
X-Google-Smtp-Source: AGHT+IFUU6irM1e1MbuuP/+OiR0oh0ThTbOEgsSJ73IJ5OWEDcaw2q4eW3MVdSHGMYbpypYOPJpJ1w==
X-Received: by 2002:a05:6214:5018:b0:6eb:26ed:4d87 with SMTP id 6a1803df08f44-6f4f06142a7mr14810536d6.31.1745866022139;
        Mon, 28 Apr 2025 11:47:02 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.110.96])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4d4f3c710sm36004606d6.77.2025.04.28.11.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 11:47:01 -0700 (PDT)
Message-ID: <680fcd25.0c0a0220.2ff884.6ca4@mx.google.com>
Date: Mon, 28 Apr 2025 11:47:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4124236972547772471=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] hciemu: fix accessing wrong/uninitialized variables
In-Reply-To: <1ac4f119e79c10da2da2d41f9458daaf170d466f.1745860619.git.pav@iki.fi>
References: <1ac4f119e79c10da2da2d41f9458daaf170d466f.1745860619.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4124236972547772471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=957795

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.55 seconds
BluezMake                     PASS      2740.41 seconds
MakeCheck                     PASS      20.30 seconds
MakeDistcheck                 PASS      199.19 seconds
CheckValgrind                 PASS      278.47 seconds
CheckSmatch                   WARNING   303.52 seconds
bluezmakeextell               PASS      131.10 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      935.86 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:453:29: warning: Variable length array is used.emulator/bthost.c:668:28: warning: Variable length array is used.emulator/bthost.c:669:32: warning: Variable length array is used.emulator/bthost.c:886:28: warning: Variable length array is used.emulator/bthost.c:920:28: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4124236972547772471==--
