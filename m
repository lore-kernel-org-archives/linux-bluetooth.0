Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0404A2F28F1
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936897; cv=none; b=nqgcJa14cdyZffWzf9P/tA/wbQiAIcwqFtgM6BfbwSs2N5JCqnFG21eDPCldaJsskV+D7cNKNcTbSO+6RCz2ObuG6TO4HXbimpvHwZbIacDvGLGapO0c5rNOqa/8/p0oAiFTRxQZB/xH+zAmUTKwvSVyNLQnlwRZZnYDWtA3nns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936897; c=relaxed/simple;
	bh=3Hvn6zDgY+cCjErQCzxsbkoZUfzwrSWlLZKhtwQVg98=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fg5Mk9OvcX/xDhp0KvdPa5OhBAMGie/dzdmgYNowjJCuCvcaXFaveEGFUyAFNorBxNB3egxzAL9v/zfuD+MQ9a/WF1J2kMIu5Dqm+a0BMnUDbHkMFMPPphnfVM8F9N1ATiE8j+iDTtB+/7JFp0GScbgIyoQUyByp7VJ7cBFJ6Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAljYmts; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAljYmts"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-948614ceac0so24253139f.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 00:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762936895; x=1763541695; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V+jLTD6TUGtp7nepwYNj8ZFNZxAVtbzTJja/urz0xpQ=;
        b=LAljYmtsyqlWlrnJyUFrOiPkmueov86ea3A7790aLsdZmeaOll+2s6wtkKLO+LqRhW
         4gdw1x0on6OrWAErsW1bFRutfRIHoTi5KvYGFm71tUv+7OvVx98Rt8BX+g6kEsLfPazJ
         vzzbpQ39D5/dl0wVNaN5TmsoV3tPGqenDP3d9znIRco8nnd+J0WnKSHsWXmqdx16R6eX
         8dwLcchq8mPRFlN+9qVsW7qwjcLJg+AF+/ijFJerPtbhsj43V3VGBkwVSgSoFH49COb2
         op0/rUvEMHWwOLku26kMtsO74w80JuL/CwWwqg7fZNlakp+89QoCtmMd80+TPGTkWwmO
         2Aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762936895; x=1763541695;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+jLTD6TUGtp7nepwYNj8ZFNZxAVtbzTJja/urz0xpQ=;
        b=Mk8YajCtpKpolm9YkR5hizVKzF42IGW3LWJfNKvD1ITIid6RyIVHP0rCslYhsnWqZG
         4+77VozcEu6AT87lMja9r+BEbolSgJpzvTf1BDAR2DE+86pPd4XDZh9W1iSn4iTsfAU+
         sJH6erFOEYNufygXV76o+VO8iTMIYOvJXZcZUnLqYL9PqWK4kSe7i5zeKzNxPfEpaMef
         uokrl8P4SYu+vhD2w+Hv82/aRLtUTV0XnyBvIKPfVDHszAi69272SZQdIE9EC7pE7wuI
         uUXw27OIz1Dag9gSzYqduGoTiRnpzKRS2CplnR/tlyLjxxiX/ay5QX9m1kh6eREI2r+m
         b8Uw==
X-Gm-Message-State: AOJu0YxLfGFHXuIvwAcroloAum8UuFiosee74InbvhYq1Mi0M4c1DaPn
	+DwIGG4w7jb9P5cG9D5ZKAC2kNbBdcPZBqTBYUe78MKLCOtjDBHT9qpEHGaCwg==
X-Gm-Gg: ASbGncvBNRcQQnthO8kYGeLD0pvJ83AzhKZEYi/On4NPlkJhYFCrbXynsyHmHby5nEz
	UMwSmf13NkQddl1V0diPW3JFHVET+bGwMHguYIrlBz9vUfNUsIBvuYtJclRTmIP9MUJC+/Osu0e
	R6T5vc0tK4j6uO0uu0lN2uwDDJy+ARzt7GDgq7JwJWpvwNaR6PV/3i763E02j997DrTdLVECM/b
	Sf0HEJhmyYfGGvK69eXUxL0LmY7CiRChLVFX2AehD/b2K0ucY2G7hSFEzY2kDiyMvEL4OdasS+y
	n8g+2dRPt2LXWnr/zG8bbc71wU7+nLrElF1Argn/Nn/MRbXQakv6AFGMy+Idz8EZk/ahryjODUv
	9M1wW6hBwlZvsYQhI1Q1XWWN15Op5oFGsqUjey6oswrLhy3IEGMJgz3YTFVomCaAvvRNMe0U2S/
	xOEnqLTMI=
X-Google-Smtp-Source: AGHT+IHA8St+u9KkxpVzQjG5sTvbZSSWmStRxz+AhWeS/11+oXaCYLzT7SEEC7uxUJDOYLzzM8g+Sg==
X-Received: by 2002:a05:6602:6089:b0:887:638a:29b5 with SMTP id ca18e2360f4ac-948c4634b98mr285470239f.9.1762936894838;
        Wed, 12 Nov 2025 00:41:34 -0800 (PST)
Received: from [172.17.0.2] ([52.154.132.180])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94888dac337sm531011539f.21.2025.11.12.00.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 00:41:34 -0800 (PST)
Message-ID: <6914483e.6b0a0220.397617.8bf3@mx.google.com>
Date: Wed, 12 Nov 2025 00:41:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0634561423975508584=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v1] Bluetooth: btusb: mediatek: Fix kernel crash when releasing mtk iso interface
In-Reply-To: <20251112075334.1162328-1-chris.lu@mediatek.com>
References: <20251112075334.1162328-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0634561423975508584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1022367

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      25.37 seconds
CheckAllWarning               PASS      27.45 seconds
CheckSparse                   PASS      38.22 seconds
BuildKernel32                 PASS      24.81 seconds
TestRunnerSetup               PASS      496.28 seconds
TestRunner_l2cap-tester       PASS      23.57 seconds
TestRunner_iso-tester         PASS      74.48 seconds
TestRunner_bnep-tester        PASS      6.05 seconds
TestRunner_mgmt-tester        FAIL      111.49 seconds
TestRunner_rfcomm-tester      PASS      9.06 seconds
TestRunner_sco-tester         PASS      14.20 seconds
TestRunner_ioctl-tester       PASS      9.75 seconds
TestRunner_mesh-tester        FAIL      11.50 seconds
TestRunner_smp-tester         PASS      8.45 seconds
TestRunner_userchan-tester    PASS      6.40 seconds
IncrementalBuild              PENDING   0.83 seconds

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
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.068 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0634561423975508584==--
