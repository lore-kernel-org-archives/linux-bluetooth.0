Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8A420D4E9
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794266; cv=none; b=UTCEzV3Ztz0rF8uvTQsIDOX+a75g+uap+lSANk/iARlY37sZdgSv1ph57IouNy4F4NEQH7aWHd3RwJo3h28KHg3+ORoEHwcM6y6O0I60A1PUYbvkQSn7Lvv+Jo7x+yG33V0dBFipIWigd8cfpYhpbORKz2gZ9/68joZ9ngUg4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794266; c=relaxed/simple;
	bh=KT76OeOt1woDiyO6hcTk5hvIqLJPql5s1lB3auVQPpk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=S5D88W9NKFZWmWeg+8REYyIAa7Q+2StXcw4BLTeA76ifXQzqHwD8HeOfnGI44qqFVd6F3ix/TRP+aDtit7lgNn66NhzskAKepklKTuAqU6UtLwE4/E0AHB+9+40nLcgQxcJ93ck/2YbTLw7Bh25JAmP1ZIZLxXdibn3rY6ifVsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3McrgHb; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3McrgHb"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-88432e31bdbso80206639f.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 09:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755794264; x=1756399064; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w8c/TXU9p5sA9HhtfCUgdPSMn0dGC8RucG5IyRL/U+8=;
        b=B3McrgHbSIu8kTVbKUuox4UuKipH/xEApPm87hkLArgvgMIWjxashX9iWcebDAOmWO
         nA+NIKND9LaH6vkORkXCFu6cYBivWvoKe1NyN+MV/laY/U1MUqj7L7aJU+0EsGwnkP18
         ohe9hd32VO/QBp3QWsAtQMJzL4Z7vSNuqvB+Tabyfc6+l+Q1fPkzMHEA0kgE6t/BdngZ
         cHDC6uCmqGc09h3e4jaoiEMe30TDgntZrajVl0MKEIIRwkA61VwSZVqzreNAR5bWngkx
         jX8vlEvV493mv5+FsedTmp2+hlu6rlvwjV/VSjcipqrRMJF30tr/JI66SIdPA60g+rTA
         m+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755794264; x=1756399064;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8c/TXU9p5sA9HhtfCUgdPSMn0dGC8RucG5IyRL/U+8=;
        b=U+XY/9fBago12X8a1HQ0Ls07GDhr0vkDM3JIpQQ5HQeIq8mxIVpIepsyjgsKLCvwqI
         xtHtQ6DXKwOV21vwCJSm+7TcsWozyy+kpLe3NAV6Vw9yqyi5jwzxzyjMMeab0Ho4y+8r
         jjJcYPs8Bdy7l/NnA9i8Ue5ETkUAIZab9xpq32q6NDZAYd50YcuBTTE9KrmeTZxD7/z6
         ZdvcTO54/AY2cyANeUVBmmbNuKvLnHKZ66InmZ4jjnZjTlnIK5foZdANRwfN6kqVWHFm
         ng97/Sv6IKjNqIU7vlqGIVBkR1kT7SISDHdE7S1fQVzkPdUgY3DCtILtl9qWJOHVZQkr
         2xXw==
X-Gm-Message-State: AOJu0YwEbRoOBi68zPtZzNk6eKe963Ul6ql5tvkjNUo+/ZZXHXb+A+kG
	yYdtLI4qSKCCMQL6vx4QqSOwsV+fuhP3pi+JwINzRgE1uOWtBLj3lwz2cvFgKA==
X-Gm-Gg: ASbGncvLfPUztUCFJibitxtKzb79xL1T6g8hSSVS9WMyQVFXRB5ubZSNseLf3AvN/8/
	MlBikBhqjELKegju5EW65mNK/FgOrshxkgiztTGkPoafLzQpHDRPNltH3TCdo3x8InjTEl4hj4f
	1oFQXu4TOjFPqgFoyD4ktCgMvGYbPuvU8Dv6w+8Ag88JFtSYioAfBR6urI+E0u8ejFCjCxaLzGm
	VNfrN9oOoFNQP7ykcZLL2ckJmL0CydNRobhzOug+VpuwqUHOjc6QXsAzks+i/3G0ZWADNOSv3aT
	EWblmGwnUToUCV5as15ScZmLW+X5MqaqRbzKBM5rrji92oF6HxRm3Pi5AScP9eoyPBqzUESXubG
	FQgyslwODZnB6JGVf5U3+M+6ZjszXlUqGCEY+0MKh
X-Google-Smtp-Source: AGHT+IEY1kFz3m+KB1tM9o2ELaej3vjMmp5rfEb1Mp7c4e3N0Y/C4Bduyv30B9B0rJQx/4aW79ZJHw==
X-Received: by 2002:a05:6e02:170f:b0:3e8:906b:1ece with SMTP id e9e14a558f8ab-3e91fb2de2bmr765555ab.3.1755794263845;
        Thu, 21 Aug 2025 09:37:43 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.134.228])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e57e58c1basm75568305ab.5.2025.08.21.09.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 09:37:43 -0700 (PDT)
Message-ID: <68a74b57.050a0220.fe11c.f1f6@mx.google.com>
Date: Thu, 21 Aug 2025 09:37:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0221400007366948881=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pashpakovskii@salutedevices.com
Subject: RE: [v1] Bluetooth: hci_sync: fix set_local_name race condition
In-Reply-To: <20250821160747.1423191-1-pashpakovskii@salutedevices.com>
References: <20250821160747.1423191-1-pashpakovskii@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0221400007366948881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=994144

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.62 seconds
CheckAllWarning               PASS      27.18 seconds
CheckSparse                   PASS      30.55 seconds
BuildKernel32                 PASS      24.49 seconds
TestRunnerSetup               PASS      486.68 seconds
TestRunner_l2cap-tester       PASS      25.61 seconds
TestRunner_iso-tester         PASS      41.49 seconds
TestRunner_bnep-tester        PASS      6.33 seconds
TestRunner_mgmt-tester        FAIL      129.85 seconds
TestRunner_rfcomm-tester      PASS      9.58 seconds
TestRunner_sco-tester         PASS      15.06 seconds
TestRunner_ioctl-tester       PASS      10.38 seconds
TestRunner_mesh-tester        FAIL      11.64 seconds
TestRunner_smp-tester         PASS      8.84 seconds
TestRunner_userchan-tester    PASS      6.51 seconds
IncrementalBuild              PENDING   0.43 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.109 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.027 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0221400007366948881==--
