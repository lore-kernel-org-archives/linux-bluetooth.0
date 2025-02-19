Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0596943146
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975557; cv=none; b=naJGPX1rtlkR+Odnxa5XvWTwJj93foNjcQErtrUxmLcEW6TaThw7a762HiLSxADvVviRLKjI26dkEimGrefMMs6YTsvo8sz76QGfDAMNbxsO7cG0rH2h910giPNr7yzisIkqaEBRQKlas4Pxf8BKIi1oYhD5aU7pUT3Y/2LMg/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975557; c=relaxed/simple;
	bh=NK3q3TMCvY25KhJnwl01Z/5LuDLvpwV41XrvngMnJTo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MzwSXt2Z43cB+x6W8NjwvL5HAF7ER8ITT4SyV2kTl6ykTSRBQGGDGXDLW/z9HCrMD/ENS4pgedZm6wgDV2G3LdH542vJYeOUeMDRXyHcgutgB1kJ/jxcLZdAPcEkNJNCtD8d2c9kJIX8Raq/ksUG0c8YmVRd99PiGtlXpT4Jof8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QioP1guK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QioP1guK"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220c8eb195aso138462855ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 06:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739975554; x=1740580354; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UL3t5WpIE+M9LicSy8DbJy+d3Q0odZhkSpODvw9gkZs=;
        b=QioP1guKGz7BEnG+3ftp2kdUPt27V2pK6yptRwbrxzvapwtC59G4xEK2IEz1aBJVat
         w868gs7thx32VxbFMEjqSuH93rwwb1iulzxRgziIQ1NoZ61drtheR92y+HeZ7UapFLtl
         Qf2IIqoLxtoiO4rfwlQmDIdYet6SpegqMByJVNCSyUO4b6CJXIiOpY7Bs+90FcBfcmXJ
         zAYwI/EMkNegUAzQ2E+3a35Bk/MP2tvbrNE0a4D23j+RTgqWkI3qA8Tk2cH1gB6exyF1
         PaMgHZvh8oGvF5Dp/Z2FBSVsa0WAnLS3TJ7/yU7wjaE3rQYUtIMDasvw/AoADTq0nWdg
         ljeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739975554; x=1740580354;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UL3t5WpIE+M9LicSy8DbJy+d3Q0odZhkSpODvw9gkZs=;
        b=rwxEUUpX6LNQpui2I2T1hJxm/+kWNjowHWzK6NBheWDCRsJgSCTFbVmXCcjrsxjyQ9
         pfBXeZxy9pHz9vDqEhLMDcwAJ02p5l9nvYrcjw+W/klDArRjOi/KOQkn8gFpUTFevmOd
         kKZXROwWCUMMrPrIb01GTUktGTX19o4SUVNfHg2eAzavvyWil6tcIqsOeJYKv6lde/Ke
         0r3vTUwDwR9VNQ6wnhSncIqRyv6sZn2zPjI9cVHyJdS3DCdAXAI5iAaXSjXRXbJTRkYv
         8whLNHR2DldUrMG70ZV57ixySUUmS1L5bWjqz1OCm0PWLuaX5flp9WIe2f5XlOIJk5S3
         bfmQ==
X-Gm-Message-State: AOJu0YxyF7mcr+PzCdvFLhgj8fONlRL5yIJBcZ0+NIWNwMa38Jx9UXlJ
	U4MNPzFPgH4dYLwJ48zKqAT/5fh6PygLrsgQ7m7J44QjdQaZYG96nNaO5w==
X-Gm-Gg: ASbGncu2/eu7IY1MxTmlGQGJ0/jy8AhwNpwk/3bZdmPJvT2BTALDkb9rZKMMmy7CiWt
	MOiZBD6V7YmpWMWeLRUQIJ/kjbbmu165nDyGnLqsGvYW8/ZOPnF81DykQBomLnyKyrNPTCS5SXs
	LGgfBdEyTbxUWbiXK1f/6ScaD6QIXVf0w/E8VXj7Be5Yo5I2XryX7oYpl8mFuv1Nz/APVdlgtRA
	s4k8D0vfQOXXO4Ua+K83aQbWzZDttVFXSiCBiWP3O2XFQQ3UbzSpTLNiXSU0Ygb6JxT3ExWwvlm
	FQhhyalfvo/MzN9Reoik
X-Google-Smtp-Source: AGHT+IG4ntQzEGYpfk4W2RfP9ZKJvUzM+7p9lywEeKkHmRJRZM6oH0F9QV/8gvq7zDJROButmXGTVg==
X-Received: by 2002:a17:902:d2c2:b0:215:5625:885b with SMTP id d9443c01a7336-221711c2866mr57439935ad.52.1739975553880;
        Wed, 19 Feb 2025 06:32:33 -0800 (PST)
Received: from [172.17.0.2] ([13.83.222.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534903csm106327725ad.32.2025.02.19.06.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 06:32:33 -0800 (PST)
Message-ID: <67b5eb81.170a0220.34bc18.1288@mx.google.com>
Date: Wed, 19 Feb 2025 06:32:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4608058954046889627=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chharry@google.com
Subject: RE: [v7] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
In-Reply-To: <20250219220255.v7.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
References: <20250219220255.v7.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4608058954046889627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=935602

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.36 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      25.03 seconds
CheckAllWarning               PASS      27.86 seconds
CheckSparse                   PASS      31.48 seconds
BuildKernel32                 PASS      25.26 seconds
TestRunnerSetup               PASS      449.48 seconds
TestRunner_l2cap-tester       PASS      21.59 seconds
TestRunner_iso-tester         PASS      42.47 seconds
TestRunner_bnep-tester        PASS      5.13 seconds
TestRunner_mgmt-tester        PASS      121.91 seconds
TestRunner_rfcomm-tester      PASS      8.08 seconds
TestRunner_sco-tester         PASS      9.82 seconds
TestRunner_ioctl-tester       PASS      8.68 seconds
TestRunner_mesh-tester        PASS      6.55 seconds
TestRunner_smp-tester         PASS      7.46 seconds
TestRunner_userchan-tester    PASS      5.20 seconds
IncrementalBuild              PENDING   0.71 seconds

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


--===============4608058954046889627==--
