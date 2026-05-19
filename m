Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5E023392D
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 12:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779192993; cv=none; b=EYU4nfeYy91M98LBYjZUllCFZmy+Po3PPbrkmyyNCaMCSdrpmwaR+syIWTAWtoHpVF2om71zlJuUwO5+AaSDWRBuUYfKQxorIPB37pGxHr00TS3v8eA9Dl+eYd2369f1klA0u96Fwbkskjla3X6Jc/BD5pW5oSKBdIW7Z+Ox+RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779192993; c=relaxed/simple;
	bh=SxZKfmKIR91fM97Ama3ssCqOxgoVYqRvhD/hcMyIBn4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=i4ezRVPk4jbPdSCgwZ9z/7u8/d7dq5LAI6WGm3ReT6tij4xWg0p0Np/9lU9FCN0hAdHpV2Mq0cwCMYuYBkMugW7jnckSd91dvW0iDY2hlxfU+NHjIGxb6Mi4rksSs06DLTMAIKZGrAdu4uLvWYVfjSY/jHEb+YnGpVwB3tTaYPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWmHJ9NP; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWmHJ9NP"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50d6b9bca48so57161831cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 05:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779192991; x=1779797791; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W5y5lw312n+xz+cLUyp36fLoe7WVOYfI0rCeRqqlaGk=;
        b=nWmHJ9NPSW4UjNefwGCVscVr6tO9qeLaO+wGoKmvjn3DSNmlRhTeYTrOPa1tgG7kWz
         Cq5j/OhdTOtGl+YSoWs/T8V+FUM6otMtnnD6rW7FJRNf+ZO7v32qXHAktWoRBkT75/wQ
         dIHEK1Ur805fbAqf4o2OTGjUdZtFSGacIa/IPw/gzgMiwaq8Giw6TQosP/QG+NAPtOek
         +77gCUmyx6DMBnBeom45OwDg9Tk0S0EwaV7xDhFE8nYe38Muew5xToOmvDePuIXt/8gW
         FP5l1Qo0/H0tekj9Ft9g5HHpJlRoat+3DqQrucgb0X5xPuQFyOtg6+dkwLLTWZoUCEd/
         +SWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779192991; x=1779797791;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5y5lw312n+xz+cLUyp36fLoe7WVOYfI0rCeRqqlaGk=;
        b=nyZch5U7rofTHDy6AxQX4ME1wJwsAj9e/lQxc0Sk3hbhCcPFrJJF0vqlz02axRqMxU
         tsY8+BRHiB76BTqIbJNzVLYswtWBbAU15fKVdbCKwNdxolF3kz5EnsFLi5He/8sDp9Oi
         Mgo43LxmTarSawHl+HGv9J+7Um7GsxT4b7imU3d02fhrQ9N65aamOHv5ij3aP2nNgsq+
         kVe8KDsYJrd9iOejBr5G6Dojbl4itM+wRJVz+l9NXtogAVRJA7Zi48curdR/ynzYYz2s
         26n+u60xc/w1twQzI4b2WTFeIW+V+cpcv/czxDvk4oErhIXlFrWnLE6QjRBptjbWciS5
         ixXA==
X-Gm-Message-State: AOJu0Yw24vkyyQehIb8/s1WstHBzmI92UN/Xqtz02srd1SqGXl0+UvtF
	jimcID17ctxcgBinEMPuXTj9+N2lSpQLN3JlCEmH42hS1xaNe0mntpFsNR8VoQ==
X-Gm-Gg: Acq92OHX3cG4FimKvd6MR6XmuTNixFB+welDLfJTOgratUu7HBpoJsep9Sj7fBnyDtW
	H5YkHBxqjIZ3hbVVVk1wNscd2ZcON2B7sJUaQAWmMKKdBraSOswhAQbAacFh4h/seCP7s8GfaXr
	ra1oSFK33NXbWOx+sgcxsSOyn3rQvp9kNOk+tsUjf64gtmALdGh+WWbQAMo6XSDs5im6LklgUiz
	XdN/y7KE9oMkbNGm4lPqGvaZ5lNuYxL0DDdCXbSQg8onyOdzHFoTtq7JsyVaj+ImmdvvSCwgPFl
	9KrfELNsE8/VyXDA5yRo/JV8UUDAvTjOleog3lNg0QazKhzkbMIAZjcOL6pD9s4t8YMh3Zgr2P5
	WcDvXcPLZ6heK2yCYfCHOfOr+tRVwN6ULZ5xoSJPJMl5/pZ0B9Ilguwp9ykgu9JkHYxgl4HkyRd
	txupXV0sROFVBsLJ9RUmmh0es2Mpo=
X-Received: by 2002:a05:622a:4c11:b0:50f:bb11:df41 with SMTP id d75a77b69052e-5165a25a5c4mr266267661cf.60.1779192991094;
        Tue, 19 May 2026 05:16:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.87.51])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164581aed3sm160486071cf.23.2026.05.19.05.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 05:16:30 -0700 (PDT)
Message-ID: <6a0c549e.04ac118e.7d5ac.34f8@mx.google.com>
Date: Tue, 19 May 2026 05:16:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0603476793013047469=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rollkingzzc@gmail.com
Subject: RE: [v3] Bluetooth: bnep: reject short frames before parsing
In-Reply-To: <20260519113943.3656062-1-rollkingzzc@gmail.com>
References: <20260519113943.3656062-1-rollkingzzc@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0603476793013047469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1097332

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
GitLint                       FAIL      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.40 seconds
CheckAllWarning               PASS      27.62 seconds
CheckSparse                   PASS      26.64 seconds
BuildKernel32                 PASS      24.54 seconds
TestRunnerSetup               PASS      530.16 seconds
TestRunner_bnep-tester        PASS      18.87 seconds
IncrementalBuild              PASS      24.16 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: bnep: reject short frames before parsing

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
42: B1 Line exceeds max length (123>80): "Use skb_pull_data() with NULL checks in bnep_rx_frame() instead of direct skb->len guards before fixed header dereferences."


https://github.com/bluez/bluetooth-next/pull/216

---
Regards,
Linux Bluetooth


--===============0603476793013047469==--
