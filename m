Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B19922425B
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 May 2026 04:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778387897; cv=none; b=Op9dAM3OnrFZneRH/8+KIfsWXjmkPvra3XrUlJgjujPwnBzlhCndO9EcUgg4eCRjIlk0BTt3MC9ivbIo5UXv3lwFWqC2rjPW7kFVKybwR/650gmBrF8kfzjzaZMsxPFKP7vgEFJLeR2CIq8i3YgpHknwVBrumnoHQVFO4n1TpFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778387897; c=relaxed/simple;
	bh=+BWbVON1YBgrcvtBdBrW3UEe+ZTPhzpQsaikVA+RgI0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OnkANCMgYrMrARbsqphOU9G/alSeBn62DZBAamcFaPQyV0YEF9vZGnTkfxMhLlVLkCmwaPv+BHKiaRz84Ayiad2TLIrvTy95Iv33GM1akF7+Id5yKqGjL8Wwj/Wdiice6W6PB6j29bd3B+dGhMPxJoFuB/jblRer0CYmEQ091MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0QAh1xM; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0QAh1xM"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8b4298d271fso57495976d6.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 May 2026 21:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778387895; x=1778992695; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6aibz6JHs8YBRaVp3zd0fRqtlLsnCoiIUhtTJOGe9ZE=;
        b=M0QAh1xMkppqFLO7qWcs3qHNdMoAiN5WtooswQmVDEFDtqpgkGubXDjKd14/8evMdj
         lYOGNofTPe9CtDCASCm1s+BkvxcGxEeP99b8q9UiIW27fbl/ZMO6aZ3sQmBMNIdb/yWg
         +GF6DB8G4eQtWU1IXFjTyvfndleKT7Y8gwOzO8+v/U5qaei+c+INIY89qo5eUeIi1yc0
         kJqXICQlRiJ6DWpIbJBPreyPP1nd+etMyUV3e6iwQpOvba0uw2qffc5Tkqjyf10PtqPq
         fxNOAFT9x0t9dVbeTU2NS/3xIwswuqcKJJ94seRQaFMJAmPP8DXHUAbu+JZFH0B7jYwr
         QVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778387895; x=1778992695;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aibz6JHs8YBRaVp3zd0fRqtlLsnCoiIUhtTJOGe9ZE=;
        b=Dcx2QW0e3QtuEXFWB8BnXkWAvBi79RL7GI55l5KJk29ZFBkaEtnOKwa4+K+T3qXoT3
         uncBgLDShJFGmVD4llAdY2vv7igF0vIqKQsUs8Z/A58iWFQuhG9k8zyYDvQxSezzyCb5
         0V7ZRwJWUdLd+3YFRc45nW7lv03AJqT+W2Xr1cXwqTDuI+aX2ZI0FTn1p3vKbpkaXk6V
         wu+vzP+qZ7GwKUN+H0Cbrz8q7h0rGgPvK/Iguaem6g1+WuneNLFGg1Adl7fSHEbr7LzK
         kC0kDPU3Z1fKn14vRODatpnFW30AnmP/aPei+WNwva2durQyqRzIdPi2MNbMeY2Zm1ST
         Ts+g==
X-Gm-Message-State: AOJu0YxM5fv8yjjE2oYZ/u+q+0BbBAgVThh0OW5Mr5+nisKfjYAZR+Eq
	RA9baVcJTGjuF6++0WcVrw86Oin2jWlYMHj7ahvDN6DttoZRFav4p5FJyOlIvA==
X-Gm-Gg: Acq92OGEC2zS2O5l0CL/n6gaE8KLhjIQtt1Vgney/XgT/gEcm7jZWpO62yDzx+ZxkHW
	isvTf6OuttJHCPt+F7G34LiWBgzREmt9wBajAY2V6MKnSy6I4fIdAJ9ooyUbZ3rdJmY5PKKPRxb
	330lw1f8Iohq+yca7yGfmW9gxArjzXO8Ru2bFziLE67JrstS5k7sIPTJ8dLqmuALQT2Xw6Wf74t
	Q+Xim8eN9Y0EfD3CI4VQ6V0btdPg4Bks5pLZxI9RUPn3g1rG429DnqGa1Ehyct7xIoHjehCQzDn
	aZ+cV4iliFpkOpShV8fvDOowcE/vjovF4hqqX7EPiqeygvJ8+YgpE/qqlmu2IAEHt5WiEE6iCJd
	MzwOeIfiqRlrwZtqTZj8biXtASol9jHoGPlaWD+Qa3MDKNQtLxb2V0rrzRAnXyctVBwHX3mM8WN
	SMbYVLPZKUZbSSmYlmIYaDA57EwTBLaP+JLvu1r2s=
X-Received: by 2002:a05:6214:2b06:b0:8b1:f5da:f811 with SMTP id 6a1803df08f44-8bc45c2c2b5mr283956076d6.48.1778387895070;
        Sat, 09 May 2026 21:38:15 -0700 (PDT)
Received: from [172.17.0.2] ([48.214.54.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d450dcbsm278915996d6.45.2026.05.09.21.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 21:38:14 -0700 (PDT)
Message-ID: <6a000bb6.050a0220.6094.0ded@mx.google.com>
Date: Sat, 09 May 2026 21:38:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6072283147523118253=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rollkingzzc@gmail.com
Subject: RE: [v2] Bluetooth: 6lowpan: Fix peer and channel lifetime during teardown
In-Reply-To: <20260510040424.2054614-1-rollkingzzc@gmail.com>
References: <20260510040424.2054614-1-rollkingzzc@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6072283147523118253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1092168

---Test result---

Test Summary:
CheckPatch                    FAIL      0.81 seconds
GitLint                       FAIL      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.24 seconds
CheckAllWarning               PASS      29.84 seconds
CheckSparse                   PASS      28.98 seconds
BuildKernel32                 PASS      26.59 seconds
TestRunnerSetup               PASS      571.72 seconds
TestRunner_6lowpan-tester     PASS      58.20 seconds
IncrementalBuild              PASS      28.09 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: 6lowpan: Fix peer and channel lifetime during teardown
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#126: 
The buggy scenario involves two paths, with each column showing the order within that path:

total: 0 errors, 1 warnings, 0 checks, 239 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14563451.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: 6lowpan: Fix peer and channel lifetime during teardown

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
24: B1 Line exceeds max length (91>80): "The buggy scenario involves two paths, with each column showing the order within that path:"


https://github.com/bluez/bluetooth-next/pull/162

---
Regards,
Linux Bluetooth


--===============6072283147523118253==--
