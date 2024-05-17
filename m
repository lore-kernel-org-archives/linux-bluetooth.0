Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2C613DDD7
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715968566; cv=none; b=SXa1Dvcc9zrFurFnKI/JLSGsKnUJp7KCunucuWuW4VXtr69qtgRz9UThOhQEEo8As/N0sJuwBLi6NeVn8RSLfRa2V+hoUIjbMw02BX/y0dPVnTe+o5qfW31xpVTgTacMgZzrtGMKzH7jWDc+rPtjNdS6g9pvQaW09kNBqVfFSyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715968566; c=relaxed/simple;
	bh=hnThPtyTGBEuPCLhYKbi16H5V5an+OkZ5Z/39YphDt8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lakn2Q03cbB5SwDmFnmxwfyUG5upb9gx+U8wktHcItNKhjKDzc6kmYlYeTYMOJifwrBDE/5637xCVGysRznR99dMgfaJlqDVPGVcsOVkgtuH7f+qP5pmh4yAbLL3QLBhd0A4Zb+JGQc22xaGPwIUBxrn3iYrvKcuzfMVYFgYH3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fODYfOyn; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fODYfOyn"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-48072da2f81so75804137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 10:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715968564; x=1716573364; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NC50EJykBIeIvfuIidZracGGGplzRcf+XBtZz4mDDgE=;
        b=fODYfOynHkcbEG3BYy8NXLbD7+0INYxZ812w5Ck79K9g61T/Oe4DZ/iSJPJWlpGqxp
         XikAv6qpucLTHB5oHb5TzIk7lDpFtHSDTrB8OVwYm1hCMZqfefzYUIKahy7gaDBTcO0f
         G8vkXm3CNdVI/stwaTiGlEwAuc0TPDl8yBPbNyV+UiHJ/L9/CCN+S7/gcMpsQtS39idT
         idJXD2JyawrKDE6iLfvRWZHqoXmR7/BK9HYKEsGTowpRpawImFjgI6yD2yopT8AQm/rh
         17u+bJ6sjj3RC8ho0C2n7chyr43Wc0NctSeqvoBItLssjAc81Jxw3qUqrpS6eCFypACk
         gTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715968564; x=1716573364;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NC50EJykBIeIvfuIidZracGGGplzRcf+XBtZz4mDDgE=;
        b=Eh6bIjnpd+4Wbe+2WYTqPyszEsv5JmN/fXuNxC9WsDbnDoGq4pwv6OOSeWLhhoNaA/
         a6i5CTrVLRDsKgsgEdJOAzIBXoOQxwz1P86n3DdkYG0vVBPJafcaPjYfHZJ75TCR5LUq
         bgIx2SGpWojZFyHEmo37tVZsHAqWVRGIqSRBIZfFuOE7m0QhE/DXj0R+XFOzgGmY+Cqh
         CiMV0HzkQABBcQNUHKeWe4HiIww47MnlpnAUwwqZ7Cdpmfw9E6abW4Ac2BF0IT/8SKFH
         ph7f5hvrv5efpkw7zCkQ3XPGFUtcB6tfSxE8TKSDNdQv9h2BLQQihopEAUJTC8p4dUpK
         d7QQ==
X-Gm-Message-State: AOJu0YxxhDK45hg2rQgyeu3leTIy+aFOTH+1RY364fgiZqLMbdNeULwf
	hDVbwm/I/ZnyX26FIenApnHhaAHfZITmj5tcZn8T7NEyOcbXBIa6mIyRdg==
X-Google-Smtp-Source: AGHT+IE6rcErViEwpWNk/IA+kUGFI/Nh48suSlb1jAUxlQOszFYxfAjXOWCP3YOW4dsJ3KXHaox+9A==
X-Received: by 2002:a05:6102:d87:b0:47b:e9ce:42ac with SMTP id ada2fe7eead31-48077ddcebfmr24976981137.4.1715968563900;
        Fri, 17 May 2024 10:56:03 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.119.0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a340d25a18sm48422576d6.40.2024.05.17.10.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 10:56:03 -0700 (PDT)
Message-ID: <66479a33.d40a0220.bbbbb.1f26@mx.google.com>
Date: Fri, 17 May 2024 10:56:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0740471723447972939=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, erick.archer@outlook.com
Subject: RE: tty: rfcomm: refactor rfcomm_get_dev_list() function
In-Reply-To: <AS8PR02MB72375B833F3EBFF72A0CF1628BEE2@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB72375B833F3EBFF72A0CF1628BEE2@AS8PR02MB7237.eurprd02.prod.outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0740471723447972939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=854073

---Test result---

Test Summary:
CheckPatch                    PASS      1.56 seconds
GitLint                       FAIL      0.88 seconds
SubjectPrefix                 FAIL      0.48 seconds
BuildKernel                   PASS      30.02 seconds
CheckAllWarning               PASS      32.89 seconds
CheckSparse                   PASS      38.94 seconds
CheckSmatch                   FAIL      35.28 seconds
BuildKernel32                 PASS      29.46 seconds
TestRunnerSetup               PASS      521.79 seconds
TestRunner_l2cap-tester       PASS      18.30 seconds
TestRunner_iso-tester         PASS      30.53 seconds
TestRunner_bnep-tester        PASS      4.75 seconds
TestRunner_mgmt-tester        PASS      114.54 seconds
TestRunner_rfcomm-tester      PASS      7.29 seconds
TestRunner_sco-tester         PASS      14.97 seconds
TestRunner_ioctl-tester       PASS      7.74 seconds
TestRunner_mesh-tester        PASS      5.84 seconds
TestRunner_smp-tester         PASS      6.80 seconds
TestRunner_userchan-tester    PASS      4.93 seconds
IncrementalBuild              PASS      33.23 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,1/2] tty: rfcomm: prefer struct_size over open coded arithmetic

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B3 Line contains hard tab characters (\t): "	[...]"
11: B3 Line contains hard tab characters (\t): "	struct   rfcomm_dev_info dev_info[];"
36: B1 Line exceeds max length (117>80): "Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
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


--===============0740471723447972939==--
