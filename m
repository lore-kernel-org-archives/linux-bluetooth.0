Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF821CA03
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 01:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776477402; cv=none; b=L4MGgR31vgws9DLZmlgxeK9RtihPmbqpH8fidSYHU4WKNcXLIJCO6kk3XzO9FIiO15kNciZmR/mai7uKWqt2AZXLger5zyt2HJBDRc0HEiIPAQowm8dIzTd8AB7Y46XxKRKv+lPtSnuQDqSv9awYfCAy12iejYN7O/FBPGjb7Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776477402; c=relaxed/simple;
	bh=jbwSxL8ELSsGaO5X7MbH4VhFlQ8mr722bAbMxTyeLVo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lnw9nXc6A9tvWliE84Ll0pDTrAdPo/sutwSksiXNr3DwBSF5hyZbpM5mYg9BJQ3LUqzxMEqxEAE29eYlAr5YuPX77AqlkNttBVK8GRx0WSFXtphMp5mQU213vQzeBY39E8440Fibal/mIyJ/SaMt8xTAkVHpoO+9gwhNCKqUUEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU770itu; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU770itu"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb3bae8d3eso111157685a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 18:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776477400; x=1777082200; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0Yp1b788IMB3NzSM9gE2eO528uXX/bWi3Edz9sU6M0=;
        b=UU770itu7dEi6uwfD+8F3JxO6JvlhgfucTxe9Ln37Y8Mt6JgYZTAqf7TGY1RSp7PNV
         fYowYijXW2NasWm58zyuPlk6xnMjY4mM+yOBcGTh/Algzv08g4dJQwp49NfFR41utEQB
         BOQaupH+3XmBIjFL1dN/H97ZbLLEacOj5pJr1+HeLmSPxu+wErj9DXxahbZxg9RCY5S6
         J7f5wX5X6qITDiFle+tkZxSp5YYeZv6Auwo9e+HGxKCx/a0MNYdJV9P40DaiXR3+Q9TD
         uRUdsKeKF9UO3OXxH50XgFu0HQ9lpyBULje0T4z/BcORWCsWGl1Hh0IIWUJ9LXoSwLU5
         lvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776477400; x=1777082200;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0Yp1b788IMB3NzSM9gE2eO528uXX/bWi3Edz9sU6M0=;
        b=p8DwOun9Skw+Qn4Bq5aFBTGy2otbwrsTNry6uzek+iH+cfF/A1BRo3F/FO6j0P3ID5
         JjwZ6kEQzGZIyVjphPQxR4xuAxBYYASZUn0EACpg9O6J77bJAZ/TKkdn2vU0uNEiR61d
         KXC0f6Hq5nAPdnqXijBA7Xq/2jtxlWmNqQ/u/9ojfOYAu75TdNt+ABxRjRhsU/CHGNaR
         bbCKQ6z3EmA+xAj1FhE9vjIyYCl9LjjjoVYJfHCo+bQNJbq1C639F06gea6HrkZ0ehbz
         FstNA+YpxRfPdLT91Qc6uueEQuro/l2sk5AJheisA1/px8MPcvBA5Ps+OnGLFsTE+EoU
         8fgg==
X-Gm-Message-State: AOJu0Yy3PH5j4kyTW0ub0Gz6WYT3tyDuJS7YxDFW2Q5+BB5LP5tHccBv
	K49yHfK7TDf0Tbowyz+1mV5Djmlz/E/IAkjaFoFBT4J2m541MrvonI1oFqjxZw==
X-Gm-Gg: AeBDieufmXyb99aLInNkSSMhcvt10Kj1NH8SXlmax1DZAsZnh3R8gRmZSZ7Lzph9Tsk
	ZUaE2C4kCtjpBLcVq+S6OXEYlWwrLqkBId0P0xjGpfuvFBAYJ2IxFCB2HNJ6cD1aheD5GqSV602
	874zfoAIOdANNQgdJrQ5NEL6AlX8zemp7DjqWfHWDcc7hUMbeESLZnO3NpBEHLFp2VUY7QnysKQ
	KF8sStJ+lm3bUE/g/QBGxkRLW/+pkJrsdbj9jDiS9Onia7MbwkLdheZYmglJ6p7/9rxxl/Ls/7X
	CscGkBu3QCcLwl8H0GBbVpSfy7oOXso8/27alwNKVI1Fq6AptKn4EQvXwXHl07W3Wvh2mR8v74i
	i9hsb9vc5NUmflLdBWwpVkG7+IFmKl+KTbhWBYeO2U7jcTTG/vQMyezubi7TCXx3n21t4+Z24Zo
	E2ZyKVx0b7IMfaZkpmxvHn/DOOtggbrMo1P9SexPg=
X-Received: by 2002:a05:620a:40d2:b0:8c3:7f27:a65d with SMTP id af79cd13be357-8e791b94267mr758290485a.28.1776477399778;
        Fri, 17 Apr 2026 18:56:39 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.37.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5fec81bsm265819085a.10.2026.04.17.18.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 18:56:39 -0700 (PDT)
Message-ID: <69e2e4d7.050a0220.364926.2a59@mx.google.com>
Date: Fri, 17 Apr 2026 18:56:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3673645623403073511=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michael.bommarito@gmail.com
Subject: RE: Bluetooth: virtio_bt: clamp rx length before skb_put
In-Reply-To: <20260418000138.1848813-1-michael.bommarito@gmail.com>
References: <20260418000138.1848813-1-michael.bommarito@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3673645623403073511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1082712

---Test result---

Test Summary:
CheckPatch                    FAIL      0.73 seconds
GitLint                       FAIL      0.32 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.04 seconds
CheckAllWarning               PASS      28.12 seconds
CheckSparse                   PASS      27.11 seconds
BuildKernel32                 PASS      25.25 seconds
TestRunnerSetup               PASS      561.56 seconds
IncrementalBuild              PASS      23.96 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: virtio_bt: clamp rx length before skb_put
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#133: 
Same class of bug as commit c04db81cd028 ("net/9p: Fix buffer overflow in USB transport layer"),

WARNING: Non-standard signature: Assisted-by:
#140: 
Assisted-by: Claude:claude-opus-4-7

ERROR: Unrecognized email address: 'Claude:claude-opus-4-7'
#140: 
Assisted-by: Claude:claude-opus-4-7

total: 1 errors, 2 warnings, 17 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14529066.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: virtio_bt: clamp rx length before skb_put

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
33: B1 Line exceeds max length (96>80): "Same class of bug as commit c04db81cd028 ("net/9p: Fix buffer overflow in USB transport layer"),"


https://github.com/bluez/bluetooth-next/pull/101

---
Regards,
Linux Bluetooth


--===============3673645623403073511==--
