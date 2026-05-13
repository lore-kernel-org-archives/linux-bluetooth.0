Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2305D3921D0
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696608; cv=none; b=r19ONU+uElWEniuRC0rx3io4U0wTHVwhS8w2qpYMI5Q0Wu1S9MjNCY4nDXJDzE7tZ0rymQSnQa2SZdU+fPeMUaGB/lluIe2+2kIMfgMfxvxlmQGJjXNWqtR45cXLFMNbghAWVZdBBPUucE4dk3mFGPzDyD9Wh0kmdAXEDzYOQiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696608; c=relaxed/simple;
	bh=GklOsGQVF0xW5ZaMlw9eAqkVIU/X2pNYE80cOeRBGNc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qwRRcmdCPuFg+mQkIGMYv2pAnEy1KXXxHWcfdQIrAsUHd2ulhCbxzYdFVttesJ9+Jvqy9otRpvhJ1kEQi6CEyvCZHzGH2ZieEVTbxlAESoDso7/mucDauiOhNhxA7CuxkJFr5DPTHQYuUoKE/hHZitylOW1XQgUgZ503ZJA27MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbgXeU6/; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbgXeU6/"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7dbccf6a23dso5787826a34.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 11:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778696606; x=1779301406; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7oTf06/6i6ASx4OpJ1KKqYQ0P5CX/I+1PHfgATXG9LE=;
        b=lbgXeU6/LYHd6EiKBSptnKAuPFNXrOexSy+pv3XMVSCYbNnxwhCLFo9Jq0X6EjHOPj
         l3qoR5vuTGaLWMwkXY347UOd68nqKt6Gs5G7rVFnIlHmDM/YNpyNNU9hobPzLdgOZrpk
         UvymnLoD8QEvMluDwomERWCL3hObM5/OPOYdyfLoGsmgXYPAQtJwA9hSW7we5+dQO8X+
         ySR4sd/gmkfdpXpmBN4z+onwQ20i4jrpbZkHhRCikO/IWbY87JkMixVlGLU+vD+1burW
         WtKLs4r8ktmkej35ziUzSVkbRAQHx9ezNZB2VQq9Ljq/ROkgesIT0VC/+3gYOZGHIq8T
         1LDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778696606; x=1779301406;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oTf06/6i6ASx4OpJ1KKqYQ0P5CX/I+1PHfgATXG9LE=;
        b=gYwLfzcQWrTYoOC5Pz3NajmkDsTleRwZYp1VA3apZnXr6K3Z+WHwvbj9wbmmb0Nv3I
         wGg8qMfFdkLrnziey5JJ/B+e1MCSZFFB9JwfoHJhSDwsIV8Uak3V6t+TeHegi2jRjGDY
         PYakbY9XcU0G4Sf2z3TcvLP8b/KCWj+0OCrvfLWqbIkzOQNXUcTaNQxFLPTIotl1r7/u
         PCHXqkKwj9HjliM6MqLNyKKtN6C0cQZaMKWwdytZKlumhpvlVtPA8g5NLlWmcHWfDCQ0
         bUuQ1mjhmYzTeJr3NevRg+PDfQZu7lSWP+CulNYG49veBEC97C3rNtRalP96eW6ypUiw
         BBWg==
X-Gm-Message-State: AOJu0YymEPuLK2rkTpTYs8dme4G/wUCYLGOKRCFjdNM7YkntRkplWaOF
	TxQhl/s2L8CRhz2GRPrBsy5oVr1VGFBLKTpNQ3Af2nBLIZ5T7y5qDT8H5inDmA==
X-Gm-Gg: Acq92OG6OKcHvQR7p/B0BMO+0deTBd9/iV/XFeUcKKvS0rbBRKdfNbjisqrgylr5Sqm
	aw54V2xAaS28R1CwcAgA6hPonqhUafYZriPPcDXC3/8xEG1qeUJiHqbg9cwzDImIwrxzOJIa6Qn
	0m+PKL2hH2GfyBJ9S0ACtrMTB6eQkYdY4hVqqOXOYiLqBWfQd1N39SZfCzfOALU1CZnFovaP6Sn
	pmM8OHgFnbIhl+/BtkM3H98S6fKZ07XIAMNLQ554H7JUxtudy6BDNkkoyW2XSg0tQI5K6jZWP+H
	S668iOKazQA5hMuhKYBEzxWPNBdj1CAXYmFDJA8McTfMNyQgyYOd4tLbH9jr8AAYJ8ev76fiVjV
	ZlTZBqey5Y4xleTpPLPW4BPHqCXTagelbSN779Xx5A0H3Fo5NxYzOoyBW5s1+AEToF4zk11KZ4X
	HoITkZ+gmO1nF2ItLAIVEOKo9a+GUgOMs=
X-Received: by 2002:a05:6830:4708:b0:7dc:1615:7b52 with SMTP id 46e09a7af769-7e3da7daf94mr2695778a34.26.1778696605727;
        Wed, 13 May 2026 11:23:25 -0700 (PDT)
Received: from [172.17.0.2] ([52.154.132.160])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e3f38189e9sm139648a34.5.2026.05.13.11.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:23:25 -0700 (PDT)
Message-ID: <6a04c19d.333ba9e6.bef41.f5a8@mx.google.com>
Date: Wed, 13 May 2026 11:23:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1683010279707722237=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Functional/integration testing
In-Reply-To: <685f40f012bc71f7313e2dc19a21d6597d29cf91.1778688966.git.pav@iki.fi>
References: <685f40f012bc71f7313e2dc19a21d6597d29cf91.1778688966.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1683010279707722237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1094320

---Test result---

Test Summary:
CheckPatch                    FAIL      6.03 seconds
GitLint                       FAIL      4.35 seconds
BuildEll                      PASS      20.01 seconds
BluezMake                     PASS      608.25 seconds
MakeCheck                     PASS      19.22 seconds
MakeDistcheck                 PASS      232.69 seconds
CheckValgrind                 PASS      272.79 seconds
CheckSmatch                   WARNING   322.12 seconds
bluezmakeextell               PASS      165.37 seconds
IncrementalBuild              PASS      658.64 seconds
ScanBuild                     PASS      916.62 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v5,12/16] test: add functional/integration testing framework
ERROR:EXECUTE_PERMISSIONS: do not set execute permissions for source files
#422: FILE: test/test-functional

ERROR:EXECUTE_PERMISSIONS: do not set execute permissions for source files
#449: FILE: test/test-functional-attach

/github/workspace/src/patch/14571682.patch total: 2 errors, 0 warnings, 279 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14571682.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v5,01/16] emulator: btvirt: check pkt lengths, don't get stuck on malformed

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[BlueZ,v5,01/16] emulator: btvirt: check pkt lengths, don't get stuck on malformed"
[BlueZ,v5,02/16] emulator: btvirt: allow specifying where server unix sockets are made

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (86>80): "[BlueZ,v5,02/16] emulator: btvirt: allow specifying where server unix sockets are made"
[BlueZ,v5,08/16] test-runner: use virtio-serial for implementing -u device forwarding

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (85>80): "[BlueZ,v5,08/16] test-runner: use virtio-serial for implementing -u device forwarding"
[BlueZ,v5,10/16] doc: enable KVM paravirtualization & clock support in tester kernel config

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (91>80): "[BlueZ,v5,10/16] doc: enable KVM paravirtualization & clock support in tester kernel config"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:478:29: warning: Variable length array is used.


https://github.com/bluez/bluez/pull/2123

---
Regards,
Linux Bluetooth


--===============1683010279707722237==--
