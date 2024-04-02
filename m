Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A42117BD4
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076463; cv=none; b=FzQ5cbaFP9Rw9Rzu/l/q1v36jVMATTRD7Vi4Dh1xyiK3fuSo2FHV0YpvL4gpqC7nXVfyNnMuk0lJ6riOeoIOj6qXxuuPXHXAv5gK6TsuD3ZE9n3kxRbHIrZ7908vd1yFFiLqZqSaMFg76tK+iTjR5eDHLGKunezXqYQwQlzaDUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076463; c=relaxed/simple;
	bh=LVJnMoKEoYR5Y+8R0hJQAIUTUjJ41dWt4BMXCLHAwCU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AgpD4ESwNkjEXN8gLPb6NcYycYnodNc2qY/R0LhUt111W/ARVBMaLbfSd5PI1FLapzGdMbfdfpfbjv04DLq+AxoigF0rhWSfKPYyO1/azH53nrkPoIqckUAVO8kqh3WPP7j184xpPAkbASMzgdNOLOSu5o/I/CJX//I/1GEzzRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGI0BOyN; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGI0BOyN"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e6b01c3dc3so3310526a34.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Apr 2024 09:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712076461; x=1712681261; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WjQ+rrvZWUCLodwvpDrlYpNcqKP5JdGPry0rkqNlm1A=;
        b=CGI0BOyNpXQDMfuyaUuZe1xIPZ62VH2KUyp64WiDpuh9fDXGv87mr/74fjoiVzIWN4
         FwqcDF/eRN3wU0W/4Z4ZXrjMO/KPANj0sxn4lk0/SjyNP+iUWdHu7HTzThKnkHtEX5O2
         lFSN2sSUFPeTtH/nC2mXIomWYhIF2EyXloazhuDXeQpOBl4cIrhS8T3YM1paf/JsoQzb
         jt3+06G3czZRBlHfCMpeFm7BPKIOMnwb1vTpIRLQx39puMcPQmWziQlsxQXHQ/RvSKaK
         WMM5le0BiokXYe8S/erA2ZMIFn0yncZwMI+KQLUCt0vP6Y/frrxwspKbApR4JCYkxZYr
         XcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076461; x=1712681261;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WjQ+rrvZWUCLodwvpDrlYpNcqKP5JdGPry0rkqNlm1A=;
        b=bhuNZxkkmvTD6kAbtuKQIXqZdtOi5ltM/MxwUOFvdrzYIOTvQvuayrN1CR/H27ac1g
         imTOFXIgevVZ48sNYJKQvhyJTtx69YwahzLbgHkgPCADFD8QgLBp1Fvg8aWAxM5FWtwi
         CijHrW0bVI1LLKp9j7ebOvXKKkssS8VOZgI0bbkk6sh+wFzO80LagevlPXRU4el/ZtMN
         S9LhEc4WEsxwwGoo/0j6HP/ooJBzN+hzJ+w+jhh140dU45KxJZkc3VkG+kHVW/bAJG4T
         s4fry0evb0F8iEQJrva6WkYYY4OASjSh1dxqr4AVMqpUBEMWsf0FOY3O7LBJ3OLgMbr9
         umLA==
X-Gm-Message-State: AOJu0YxVBGw/5kHkfwIqDBEz7WwTka0UE74aMPlXidxkH6dpUkUKLtVP
	EnyaDwtPEd6MMX9z1N2acwdMOB+ATje/x19UdLyjKBo+ngk8hVuFg6MAfP8s
X-Google-Smtp-Source: AGHT+IF55nEV/31/Rq9SLYLOnQsrntzy1kIdr8U5OIm7s980B+wjZOca8r2TT+XIEHrMDNx7M50vVg==
X-Received: by 2002:a9d:63cb:0:b0:6e6:9914:87b6 with SMTP id e11-20020a9d63cb000000b006e6991487b6mr253139otl.17.1712076461283;
        Tue, 02 Apr 2024 09:47:41 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.5.182])
        by smtp.gmail.com with ESMTPSA id ma4-20020a0562145b0400b0069905863252sm2497855qvb.84.2024.04.02.09.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:47:41 -0700 (PDT)
Message-ID: <660c36ad.050a0220.5958.ba69@mx.google.com>
Date: Tue, 02 Apr 2024 09:47:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5944445280819521025=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, me@wantyapps.xyz
Subject: RE: Bluetooth: hci_intel: Fix multiple issues reported by checkpatch.pl
In-Reply-To: <20240402155543.36856-1-me@wantyapps.xyz>
References: <20240402155543.36856-1-me@wantyapps.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5944445280819521025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=840707

---Test result---

Test Summary:
CheckPatch                    FAIL      0.91 seconds
GitLint                       FAIL      0.50 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      30.80 seconds
CheckAllWarning               PASS      32.96 seconds
CheckSparse                   PASS      38.67 seconds
CheckSmatch                   FAIL      34.98 seconds
BuildKernel32                 PASS      28.99 seconds
TestRunnerSetup               PASS      520.42 seconds
TestRunner_l2cap-tester       PASS      17.89 seconds
TestRunner_iso-tester         PASS      29.76 seconds
TestRunner_bnep-tester        PASS      4.70 seconds
TestRunner_mgmt-tester        PASS      118.19 seconds
TestRunner_rfcomm-tester      PASS      7.27 seconds
TestRunner_sco-tester         PASS      14.94 seconds
TestRunner_ioctl-tester       PASS      7.55 seconds
TestRunner_mesh-tester        PASS      5.82 seconds
TestRunner_smp-tester         PASS      6.73 seconds
TestRunner_userchan-tester    PASS      4.92 seconds
IncrementalBuild              PASS      27.80 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_intel: Fix multiple issues reported by checkpatch.pl
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
#120: FILE: drivers/bluetooth/hci_intel.c:540:
+	bt_dev_dbg(hdev, "start %s", __func__);

total: 0 errors, 1 warnings, 49 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13614367.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_intel: Fix multiple issues reported by checkpatch.pl

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
12: B1 Line exceeds max length (99>80): "WARNING: Prefer using '"%s...", __func__' to using 'intel_setup', this function's name, in a string"
13: B3 Line contains hard tab characters (\t): "+	bt_dev_dbg(hdev, "start intel_setup");"
34: B3 Line contains hard tab characters (\t): "+	duration = (unsigned long long) ktime_to_ns(delta) >> 10;"
37: B3 Line contains hard tab characters (\t): "+	duration = (unsigned long long) ktime_to_ns(delta) >> 10;"
40: B3 Line contains hard tab characters (\t): "+		int err = PTR_ERR(intel->rx_skb);"
41: B3 Line contains hard tab characters (\t): "+		bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);"
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


---
Regards,
Linux Bluetooth


--===============5944445280819521025==--
