Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD21B306776
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065677; cv=none; b=a6cfFJiVUJVeaz03/4CcvsefR8aouLxfT+1UO6GBq018JbFMp8uUB2q9VDJ5R5IXQtEghKAG5werZXSKg+TAY0CG8jyA/Swjtu2Vai4pBHpZJHmeEZvIMDyMdQd5J1/UwPT8QTRxTzggrtMvbNiiUapj2P3o9fWW0GJAVKUvnaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065677; c=relaxed/simple;
	bh=Xls8KmdEz8mq16MTqiDrBgsSpfgDNbB1MiG90CQLGD0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=m5O3ly/ZKhsCH+9OFQO47UdIPlpmIJE8OqGcDp+NUiP9GpnWj5AcyJL32CzerLmJIsoH3zGtGYvIMCK4WgvzLMBBvMW1urlDr7KNmu1nA27GRE+PsU9dev8p/2IN/cYW2BYE1yJsmWQL/pQ204G1A9O7wkjuIHMv02hSgGm//Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sno42K66; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sno42K66"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2dd020a2e44so21015775ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789065673; x=1789670473; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cmPJPm/PVw3+6zzXby2FkV89fclPz6jL5IJKNMaMryg=;
        b=sno42K66JAiCFSroN+2F4aA476RBD9/BLrYF0fUt3vfLyLgh50MLPhUxc3plhDCDGm
         Sofwwk4VK2DwxHfam3PVwmGfvR0RYsmA830Zkrn/+AqEDkV0+fIwHH90TbCdjPUsESqe
         h5tq55KBwgV3xKIZ52lDoT/CLHwvWMGnxKcJt7ugnTolOzZ7BtS1g0oqELfGVGwNTFt/
         uQicsiJGK3MY21oXRKbytuTRMAnQQmBfPhbDHjtMyKKJ/g19D8laX+iV4wwZPXiR2Wpp
         sshUd1mMkhA5bvbngwfbCZTFqbC9PDkXySBEIuotP8K30zA/HLijEWm8/7wyTznId3NW
         5VYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065673; x=1789670473;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cmPJPm/PVw3+6zzXby2FkV89fclPz6jL5IJKNMaMryg=;
        b=ZP3KbBxpai6/CEU3+3G4j0dxeN8KKLzsz0XHpN9uxtwO8J2FpmGC7t8e74WiQ0hcCJ
         vK1UbwfbojPJEZ/K0SYcWSsEYi8CFioqLm+shwNxutGP94ipknjEE8UPvt9imUMwraWO
         Y09BcM4MF/v3u95aiziZt+ZPnHLz2Npzx5RJIFiG/UkAUZpFnSxQhMGO9LokAb1jSf0O
         ulZjPOXa458vSN1fX4/Q0lPg9OGXlXLVMOsXr28XRWImK20lf2S2glN6wNlYIDhAQWlL
         6EuD7BEFD1kjcE7zxrekjQQ+BezT/FIsbpbi3TPvdirP7VW9tymUt1gQNmFD2S2GQvY4
         lbow==
X-Gm-Message-State: AFuF++kPDaNZtbIybC/4cQGsQT5LczCQ48/6Dt6hKU+ZJFPz4oXcO3DU
	jysNhvz8oTqiRhni54SlGlZc2SUPuCKPgnIdoMc1jvY4YOUDMqtHV6RgPGCFdg==
X-Gm-Gg: AYBFou3p2PHh8ns5V3/gjixV53wOQgmuWfuoz+VvXF7LQbehHgHX8N/k/0pm/Bwr9X4
	zKsdbkSJuKDaXKtFFevXIQvaSzz1FdQUlUjt/qq7JKN5awebVr2oKMj/RfdR/KQQzmxRl3C6hUr
	Lg6BMP+vSijHV+JqDIOEBCPsJs4rIaO3BFPFdQCIcYm9i2OhN9fq9EnI76jtqpxP8nNXX/yV9sD
	VqGKrYBWBeJmpW5oG8PtgWf6hBcnlWQ0Wv8lHqoz46uXdJj86bm+BDfM99Y2y2OVvMdq3lvs6Fk
	aa7k2tdDoDL6JFPDKfFanhzBRqs0NN92qOmR168EWazFfwbYyANo2jDg2WznCLJwjWkOg6gmmyG
	/s7IwOVRJy3OLz2Qqi7RTLVZIk/2M1LoW91U6haZgYbzOnU2tE6HZQrtJVWy5WnXCCLlk1AzHJc
	FcZ0+Yk2GkNQzI4dQ8xSe3qj94HKV8YpXjQExxJ/fz08CQpEkGekzg925MMwGAkfYRNTt0ol+/4
	n8x/XI=
X-Received: by 2002:a17:902:ce09:b0:2da:f8a5:afd8 with SMTP id d9443c01a7336-2dd29ffa786mr15330915ad.0.1789065672893;
        Thu, 10 Sep 2026 11:41:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.120.164.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2d0006d6sm634715ad.82.2026.09.10.11.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:41:11 -0700 (PDT)
Message-ID: <6aa2f9c7.c04a1874.2ac2be.e221@mx.google.com>
Date: Thu, 10 Sep 2026 11:41:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6192509773697642347=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ali@iusegentoo.com
Subject: RE: Bluetooth: btintel: Bound exception info print to the received length
In-Reply-To: <20260814080123.902388-1-ali@iusegentoo.com>
References: <20260814080123.902388-1-ali@iusegentoo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6192509773697642347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1145926/

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
VerifyFixes                   PASS      0.05 seconds
VerifySignedoff               PASS      0.05 seconds
GitLint                       PASS      0.19 seconds
SubjectPrefix                 PASS      8.27 seconds
BuildKernel                   PASS      28.71 seconds
CheckAllWarning               PASS      33.78 seconds
CheckSparse                   PASS      36.75 seconds
BuildKernel32                 PASS      28.66 seconds
CheckKernelLLVM               PASS      34.77 seconds
TestRunnerSetup               PASS      770.00 seconds
IncrementalBuild              PASS      26.97 seconds



https://github.com/bluez/bluetooth-next/pull/730

---
Regards,
Linux Bluetooth


--===============6192509773697642347==--
