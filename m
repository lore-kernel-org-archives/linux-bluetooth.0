Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3EE1D7E5C
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750883852; cv=none; b=RwtY3rZh3rxQXznd5M80iHA/LEoa8yr94d0VMk1fwg3snWjEjNnP98Ysk6XuYyp16pOVu5VUIoo2bNrZlwNbcB+Qck1V9Vu+8VH5a17zfVmvV76favYu5BZeHDQR/QCSdU46QanlWz654gVM10uQlFuFccZfAzS3SgJ0uGspCdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750883852; c=relaxed/simple;
	bh=A4Zd9VTHq1mYmYAOiYLVk9RdLZdfO7DM0Hif2i//v0M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pFJMmH09Shk1kIYeNzkSRwM6l9lI6R2YsJvN+FSYtFmI44VYQPbWaDmwOmbyuKfkHJUxkiJXbBBT3RaeYuAMinLru2Qp6AGQq+Bgve+lTd4vq0nlDYe9C+WkhJutg+wxCrDMMz2owSPfSENwr6dc6qKeOLMh8cAhpEiITQmDA9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5WfQC9N; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5WfQC9N"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fad8b4c927so3736336d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 13:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750883850; x=1751488650; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XjaNln+pbmv92jiIwVDpzF84NTvp6qBDM4MSnkHMJcI=;
        b=L5WfQC9NNatlns6+kb7Q4uiggIash1tlIoHzLJ+bYoTWYak4dO8BAO6nmHpOZSkBax
         webRS71NRdPLD84MFCSiJhr7iSwcfZ6Jen8twFg00HU25rVe4PgwWSOcAhLoVp5g4pbd
         TJ1O6uYyDkR86Qe4xof30o3sxYhxRn34aMpDISlz3oyOKhyUTJM7NXkQTKZU3L3q5Ddr
         t4vVl1tdxBvll4mmejL5DDTS7ioS5z/Jg020sxOvmcR5N/14nFGGnGxbYHopYRHasbgR
         3x7T/SWOF7R7o10eKzv68ZF8SLhZx1l8kOgFr0P7fc6CInalr7qT5x/U76HVt0mmhRCM
         MuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750883850; x=1751488650;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XjaNln+pbmv92jiIwVDpzF84NTvp6qBDM4MSnkHMJcI=;
        b=mXpUFk8rgFvTQvUTRuoG+T8fhLaIO5Ni4ChBpYjMOKcMEEWwucfJfJKtQyogP6I0Gu
         UGk8BWTHvNeQRCktafc4iSn/QmlK2FBYq9Hj3So13IP++9q1BTqKxWJ8+aVNVDcTFjAp
         Vl1lOhDvmwpORnoe1qPGAifuzKlfnNTkE3cXCRXSQYHcKnie8fZfREinLsb5qPE2hm5L
         UvXxS+hx0sH4jyng3wy3L3OOj3DviHHVRbEn+lWYwJC/fmEOwPxCTkvVIMj1qC37UigJ
         WnzK7L3UHi1vkAYdeyzkHCfqUsuRXRYu52ExOP5OnzaWzUh7ZQY7Mkz5I3LiSuCWQ63+
         JO0A==
X-Gm-Message-State: AOJu0YyXfI3Zdw5zCcgH8hAPtkTa1a9D1M6CT3K2EfqxIb5PDw2Qkjw0
	IheQON8eD97d1VCjEpEgAQZt5dhpQMSVTggnI65vLQW0OR8WvCWaK26WpOElR1LZ
X-Gm-Gg: ASbGncs9zNY8i0IE9+17vAUqF0+v/8/k0PwjlzxPPV8Y4j39x1kIA1DAd06hSyfIXNv
	d30icR9SJyGPhZ/F9jSszru68RBahetnq1CYXF1VrRjiIFfUnyjj5GfXnEOoFpANQ4bhXQS4TW2
	RxnH6d69zuvZpFEvgrIvj1JiCLJiwkJLZOdIvMg/+xMXxNlmFsQkiaryw/Ghis9N+GFnlmVRTxG
	eSqcQkmdIoEFm21aZc0+27kCf2iid1RwHZ+bWFLxngi5DC2a8YrpCa6o8864Ty9UqR7FCquwd3M
	UyLydfuW9VnQ2262iFrUnj7eWwzbav0UxQ+BY/lQ9/YFW9ATCggioK7vLBP/jCytY2vcqWVDtuX
	07Mw=
X-Google-Smtp-Source: AGHT+IEBzBcp5AA5a0RL5jfsRX6kXMg94EDXdKpSNQG2BnDofM9gjMZtuNUQik0JmJV1x+NoewWAOw==
X-Received: by 2002:a05:6214:20af:b0:6fb:1db:e9e7 with SMTP id 6a1803df08f44-6fd5ef6bb4cmr74003396d6.10.1750883849884;
        Wed, 25 Jun 2025 13:37:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.236.93.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a793ee9151sm47143281cf.9.2025.06.25.13.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 13:37:29 -0700 (PDT)
Message-ID: <685c5e09.050a0220.3260a9.129c@mx.google.com>
Date: Wed, 25 Jun 2025 13:37:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3982964406906872463=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] monitor: Print buffer pool information
In-Reply-To: <20250625191728.44358-1-luiz.dentz@gmail.com>
References: <20250625191728.44358-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3982964406906872463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=975953

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      19.86 seconds
BluezMake                     PASS      2525.73 seconds
MakeCheck                     PASS      20.59 seconds
MakeDistcheck                 PASS      196.09 seconds
CheckValgrind                 PASS      271.36 seconds
CheckSmatch                   WARNING   302.56 seconds
bluezmakeextell               PASS      126.29 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      892.08 seconds

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
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1918:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3822:52: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3982964406906872463==--
