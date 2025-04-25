Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86AD26B941
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745595299; cv=none; b=sMfjtnBautrUML9cmQ7Vt9oJkVn5HXkhzhcSucMO641apaJJmThiP1vDjHyc0fHJedJXFz6AkVuPEzx56YcgrIw/zSv2cYsAHFOCrWaaBvWExOk9t3xTHmiZot3Wuf1QF+xIVbGq7T9JL1Nr1vEdbuCF5R5RYdD1rAKiZB2r9IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745595299; c=relaxed/simple;
	bh=XSt2qlUlRHgJa9FxNp7SymMGfXNEggqMpvOs/FezRCM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=O3nwYjNsL51AfbQlF0ENiBNU2621mtdYghsG0hn3Sb0HozgUYuHrPai2EJm+L7FsPRtQ6dqpD8Fjg2QXRR+G37mkL1PnjpuNirrED1IVw4udJyzCjaJ1xYwkAbncUCMmSyUnrEyzq5+SJs9mJZtiRt5AaYu6w5940z76qhZGhtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfhzI7pf; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfhzI7pf"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4774ce422easo27995991cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 08:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745595296; x=1746200096; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9j3cT1x/0JDpOIXA2oe+Tw8+hvRQ3plHhWo4dnlAE8U=;
        b=NfhzI7pfHSyxgd5kjaQDHNNqLC3urPS/k+HZ26k685HDxk06h+r8D4BBhBHvWSGrtn
         +Y3g67r5hhVRAYJP+C6w8VpDvG/J6QQ+eg7jnycyAkByAm+wLF/fFTN9JkmyJl6Ul9A4
         bqWLPCaZlmqpClxF9gWaz2ISdaIBzI0C7Sr6J0NxFSL3/3V53aTLBoP2LgdxIr26YVXH
         IxLw0h2vWhldMByovAODaJDu6V3jLLBga7hJLQaGz2ehyqK0scLto6w6F5Qm0YrNMQS9
         WYX05/XeBVG+PiPbhkPAvfnNaPn3i7zS7R84ykftRGd/E6wqA+rNShKXl+VR+YPas3Bg
         tzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745595296; x=1746200096;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9j3cT1x/0JDpOIXA2oe+Tw8+hvRQ3plHhWo4dnlAE8U=;
        b=YIOUpS0rLEKywzydOVKmwxqNlXp8V8FtK3Skyy6fOYcurwIwmaGUfHhArl5ZawoBsm
         vWfcnf7UhInqrjzX3HLKQUcjVXvFnWUAv/OUm/HXRcbO8jCTohVxrfkYg71v4SPU3/uh
         KisQj2+ELh6xb2A6vcFmcE/vLqV4sr3udEwN8HaZjbrp47T0RFdMQF6Fi7EXRD0DbCRT
         T5uHoJfDsaE8aCYv/PwpdNHO5/j81uyjuPlQkMOIR/l5Bybi/nahqQFuuP+i8PyBPyZQ
         eKer3S+zOGylHfDIQRYKbeuBOnKbFlshWZUdPDmD7teBtUzXG0RHJe04bzLKQadZZ8t8
         fKxA==
X-Gm-Message-State: AOJu0Yx3E/GJO+skyRittBlw9YSWy52n3KLjlFuiPy5POQo+VYL5LqRI
	WJ1QVqV+IoJ49j/QiFGC6qbyJFgV9ac62I+cjq9lErb3RT/14qqxSc0T4A==
X-Gm-Gg: ASbGncu5zhBMuPlBaNl7mO4MLWXXCOJ+3Kr1oSwTShJIaz436Aent1L6rsg9QB9OKQ/
	MRNFmgUE5kTTJUT1ep05DrVVxdWaDV8IPUn+At+wHKey759pmLTtuiKlnnLVDvHubXOQu/QcjmN
	XwRJtbTJ3FAVo89kYIu7xaPkge7CrEkaZtQv6U0ZDGnDOE4/SUmOe7/I8B5KKB87wCMPGlSJq1F
	Jm/oJ0jHxC22i8J7CyrAAOKs4F7+cwt7ug9h3uo/Yh1Vfzv7DdwoJc1JwArWgINxrFzqgJUCMS5
	Tn6lCXRGjHbmzsprJ9D0XZAJ76rdjL1+WHCumGMopX3vOA==
X-Google-Smtp-Source: AGHT+IHOZiVDBuN93AS2C55UsOvkpb9rvGPAIaR8g5lAdYuukfoQH5ejFaEf5siMxTeyWom/xqSTuQ==
X-Received: by 2002:a05:622a:654:b0:477:41fa:1120 with SMTP id d75a77b69052e-4801c69e625mr41090811cf.12.1745595296440;
        Fri, 25 Apr 2025 08:34:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.246.78.24])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9eaf4d46sm26760521cf.14.2025.04.25.08.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 08:34:56 -0700 (PDT)
Message-ID: <680baba0.050a0220.1ed63e.f83a@mx.google.com>
Date: Fri, 25 Apr 2025 08:34:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4468437371029852567=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arun@asymptotic.io
Subject: RE: [BlueZ] shared/asha: Only update device set after start succeeds
In-Reply-To: <20250425140447.615075-1-arun@asymptotic.io>
References: <20250425140447.615075-1-arun@asymptotic.io>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4468437371029852567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=957057

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.34 seconds
BluezMake                     PASS      2631.47 seconds
MakeCheck                     PASS      20.23 seconds
MakeDistcheck                 PASS      197.03 seconds
CheckValgrind                 PASS      273.68 seconds
CheckSmatch                   PASS      301.68 seconds
bluezmakeextell               PASS      127.80 seconds
IncrementalBuild              PENDING   0.22 seconds
ScanBuild                     PASS      895.10 seconds

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


--===============4468437371029852567==--
