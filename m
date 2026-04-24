Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1703B3FADE5
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777060750; cv=none; b=DOUhA/oOBrhJfBTupwvrKzVESRMRqJ85E4dat1m3/ODLAFNdRVyH0DxEcbjYjma0CIuwj37qTsXd3zt32Dfc7c7cfe7A8eBUkldYiJKruayBdHkwCdTcnEcKY8JkfF0yx0JEfa3A7HydJjH9lmvXEOP0QStZCxG3Or68ssmr0HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777060750; c=relaxed/simple;
	bh=D5wLZjRAPvVmM0muGxfwU1mV51nyZpIIGYwuX/1xcHg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pmQa83RmoRmDmCGoS/fTo+O4mubkJwkOBiLorP5hTYLturwzbGU0ZeN9A1UqjiT1V3qOVRNfMLSXAmEAM2QgajrI6MNkbJ+boyj4OoAYciEOx9slHTwDnzJoucOOcthFm/RBSTFLZtMI97rcnJoYHUQmbl9ugGddLkUZVO9THIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yh4qfH19; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yh4qfH19"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2d832f2f44cso7217204eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 12:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777060748; x=1777665548; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JyoKzBzxltZVS06zMfUY4GUidncn1EmzpouGzQ5eWQw=;
        b=Yh4qfH19plwxXsChxKXUMRiMIqHJyWfeawIVgM5Ridni03FM8g5dCptcoDfevFSvs4
         73NdbQZ1GWfbsWTk4uhesjqaxQ+7eKSCKwP7S++vjKTeeSxKfgRfJoFN+3m0cIfWgh1q
         rdKqgSH44Hj14UYY/ccKBNG150D/n7hCdQiPdDUOTc8YSnsDEZCdeG6h8tLwAeJJ4QOD
         vfNZNQeweLH4A3n0aKbgs5caJ8BQIzwcVx6fr34uLIzIykot1B1qQLegMYCa71M9AAK2
         jxtNhc+YbDNi1960yI1AQpsFpHGvbXCSDO80vNSeBriP9mVfg2Gdg3C+fcSveUtncEM5
         xmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777060748; x=1777665548;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyoKzBzxltZVS06zMfUY4GUidncn1EmzpouGzQ5eWQw=;
        b=UZy1jSr8IxT2tIK7Ztp4p7mWqIxq/NhfGw0Ri2mcORQrVgT4ephuF6NHSoTVRHxTZg
         b650k6Y0NijItra1fve5Bwj6cXRxH76fpmJSkHDIKqI/dmTRf7bjq5KnONy9F3ItjJDL
         fkXL++rhY6h5nhTleYtJclGp5NdyqaAvWl16qv7nlOIdvJJ0O0CCYvHiwTMXcG4zbuIq
         +9xTEvFJOWEcu75EwxdgJu6yNWrdYfql988K6O1+KQ2/rgxj/nEM0sl/cOIeRhswtp6p
         2bSw6tgP7d79T/enXyx1PxshPIxnlsC1EDTzNHs+U5eOW0IoIH+rAP9MmC6Y7DBqcGFy
         SaLQ==
X-Gm-Message-State: AOJu0YzMHfx8QGbUctmVVOk0K9ZEsWYJm55KFVbzEtSqghUvk/PsnwGE
	D2UiCIXykW6UviMJ5Qju2hrAeDa8rHBG9F77byd3xNzCqAVaZyJ5toMpQtU9qQ==
X-Gm-Gg: AeBDietYFMb+mvU493Rf1CeVDMCAiSjlYXGDVhzXUl7WVQy5DxC++U1T+E+glj/2K41
	hStQYwcnnxd6gShL0gp4Sd/1CyIqiyopkJzGtgDh1+K3x4/sQaMdczMR7uHenLmvkaGbrnbmP1t
	1c+gGpdhrOPxB44p82PYK6xqFhFM/1Evahzh5QdAy5OgzD0F+TFn0ZfCgxlpsAdIfz716xvS2xW
	J/tjGP3ssWTlMdGYWFUv/NLJOLspNFoF2kDceghsGKpZuYZQ6SRS9SarEHHPBLuiJjZ0gFSC9ci
	QNKF/t52GCzpl3Bz/GMpqxgAbo+S7oRE/bviTsfWe0CQOSdgCreJMY4fLYtJ/I3wXInsMPOJVgS
	0N6RmucfL2QCP4kkXUwMuq+6tN/xMY48QxGyR26vofqvpyuDVo/KF2nQChaiAa2RWTpXNkfKPjG
	mt2vPFMkJtV1OesEi1ngWyA3KwhAFvFFtsy52kit8l
X-Received: by 2002:a05:7301:d17:b0:2c5:60d0:702e with SMTP id 5a478bee46e88-2e47873bcd5mr17937097eec.18.1777060747761;
        Fri, 24 Apr 2026 12:59:07 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.60.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e536e54562sm33232992eec.0.2026.04.24.12.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:59:07 -0700 (PDT)
Message-ID: <69ebcb8b.050a0220.3adf79.5170@mx.google.com>
Date: Fri, 24 Apr 2026 12:59:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5434488151983128099=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: btmtk: accept too short WMT FUNC_CTRL events
In-Reply-To: <770d36b07311bf88210c187923f243fb9f126f04.1777058551.git.pav@iki.fi>
References: <770d36b07311bf88210c187923f243fb9f126f04.1777058551.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5434488151983128099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1085333

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.71 seconds
CheckAllWarning               PASS      28.17 seconds
CheckSparse                   PASS      26.78 seconds
BuildKernel32                 PASS      25.12 seconds
TestRunnerSetup               PASS      560.60 seconds
IncrementalBuild              PASS      23.89 seconds



https://github.com/bluez/bluetooth-next/pull/121

---
Regards,
Linux Bluetooth


--===============5434488151983128099==--
