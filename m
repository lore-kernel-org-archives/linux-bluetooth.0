Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4946A1D90DF
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 22:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901419; cv=none; b=EyuCq42yOgmZ+XffIdyNB1YaFrhvOvwOdq9jYvEg1JN+t/J6NF6Lp3oSj/OIOyq4GLIoVQ4QD6AJtaKHJDPYAb7NZCk2MhUFhmmF/FGpfd4GwROq/JjobQSNIN3Z54uetonFZdfsur63eiscLfJe+8dj2xkhy5hYqoQpGiKJoak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901419; c=relaxed/simple;
	bh=HJSPVcAENMKV/ASkhOjOjR7RWXKN0rpWySMC3Kb4orc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ePsgmqrXQm2OEPrFVcjQDFXFTQhBGIOCmXtU9ogss5JFoxOkQl0zFtRXd9WAMnhXv9J8fV9NG1FIF1KMNQ/QvU1QzdeGokVVEjaU3IVyX2urPNFUr2J+mYvVUfz9nCZ0RNKswztwSfu5/VYT/Z4LI27yT6AzXLuBVjRx7f24eZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYEuR7Lb; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYEuR7Lb"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-433261f2045so830125ab.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 14:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762901417; x=1763506217; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bnGtf912MfofrP5/TBJ6O2EBSKn7UafLvcMjK0CylhQ=;
        b=EYEuR7LbvVHvTe8XvOF/Gz1G0w/v81ILrOCh+JxDa7KTv1wBzYka47y85OQ1qDy+HX
         Ax0zdhdQMqDkdjqC+5696okkOVsSx/p6+PB44fH3RT/RVJogmdtFyHyV0ITjSVwt1KSs
         l6TBzOvqaExYQWsA5uTWXaQbsBZ0oZGtPAeA9qP/8JDUpHQ9pdRbsv/su36LF60xDEdV
         cGo/4vsWSp+shHupaeS7tdmxnhwBrt65g1r+IiTKhkqe4Yosg3XX7elTQcQ9vcbvYzd8
         kyYzgpjGF91bYPFF7AyiqmT9W5EMrnB+YqpGPxCKUvQIeaZbXcu6HXWn0qgqAW2NZ38Y
         neWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762901417; x=1763506217;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnGtf912MfofrP5/TBJ6O2EBSKn7UafLvcMjK0CylhQ=;
        b=brKdPK11T2FRoOkfDe+ZB4L5SVqA3EO4aGLQUvmjVMlKPsg8h+ubjHdHAwq6MLcl9n
         3q8Xi1ssP+T7Yzrh/gG+3CRdv3ocZn+MCaMaeKe0WPwmEpS8/Ad2cFuUiodMocPJM2G4
         B0NyFkHzBdOP26mHQHk7FLpZhpchv4NtsacGNNu3oMx9oKvaHiMNWpGGM2lX1zefuq/U
         6Z1DyAMiamuKsxhEh+5+PbR78vl7AHWTAmqL0jQQnGF8PdnZ1zAKyBO6Hy7lIo/olpxd
         NlZreNdxeiwvKapmFkzHHBMi69RQY2qm1Nw9016rM2NkVUdsIH2klUEkBdNrBREbLGka
         7dig==
X-Gm-Message-State: AOJu0YyuQVaY7Te2Vwyyfgum43cKBgHBHJ4Q55B1ECYoXgkQug69eSqm
	hCq8NiIXekp74DoQDDtaEn8qlylwu9hJjpS+JE6W8PwlX7rLUnmo4c5tfoYLNQ==
X-Gm-Gg: ASbGncsmsKf6WKE30X/+NVr8QkpfsyDpZmFWp8EcTddJedZeCiop1T+0PAxBk0h8RGy
	qwNn0W53W0nXJxZQ/R08vW3QV0T9J0kdm2Rt4U3Y5h73R+DuOxJRlpRClL9N7iCjEeqVA4psF8s
	bq3rSPahQUyiaQ57VdAlF9QFi0xB9cHXUWRG8ojIBWYx2KkWzFfikXTE2LunKhJOBadqv8V0lA5
	eXqgnqN8X2z2NOw6DAMu+rMe7T4T29xgzcGja4VJbmHAQZhPJvuO2xCYET7oILrHCpQyL5YY60u
	lzO0VVkD+ChRyPMXdr9q/ySGldNqlJxmz5Nt1HhT3sXcMdzPnX9jEcHzDczbkq/jDAMVPW47ds/
	cUYNoffXf6vRW3ZJBh1t9Q7acZMkdvfiQV40QUgqD4ak0kgIiVZ6dR7tLM1/0TGDruLU3E5A+ml
	nlRoHNE6Z3
X-Google-Smtp-Source: AGHT+IFP1PIwtWGL9blgQW0iuqmhX3U/FKnLCDZqGkFdDUGo6xCpnWshsY7LgSZ1YZIwZyLivJc/KA==
X-Received: by 2002:a05:6e02:3b83:b0:433:4ac7:13bb with SMTP id e9e14a558f8ab-43473d3d0b5mr13825105ab.11.1762901417043;
        Tue, 11 Nov 2025 14:50:17 -0800 (PST)
Received: from [172.17.0.2] ([135.232.176.161])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-948c03c9c1asm48256539f.14.2025.11.11.14.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 14:50:16 -0800 (PST)
Message-ID: <6913bda8.050a0220.cee36.1147@mx.google.com>
Date: Tue, 11 Nov 2025 14:50:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0583719447940138096=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andrew.smirnov@gmail.com
Subject: RE: [BlueZ] device: Limit the number of retries on auth failures
In-Reply-To: <20251111212201.1130-1-andrew.smirnov@gmail.com>
References: <20251111212201.1130-1-andrew.smirnov@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0583719447940138096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1022224

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.71 seconds
BluezMake                     PASS      2792.93 seconds
MakeCheck                     PASS      19.90 seconds
MakeDistcheck                 PASS      187.75 seconds
CheckValgrind                 PASS      239.11 seconds
CheckSmatch                   PASS      313.06 seconds
bluezmakeextell               PASS      129.94 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      949.01 seconds

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


--===============0583719447940138096==--
