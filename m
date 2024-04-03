Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD7B1D54B
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712170897; cv=none; b=LUby1fUgzqY1OfkXgmXf8a3BkudIoXmNp0fzGBB144vgEx7z933KCiqJBhSbW2kFNO15yIzQPK+NaA257U+kGGWHewzb1DbYGa3aXEIwlorcWlcSHZA1riYvywYf9jjKcotbjiauhQqgzIruQCLu5W05Uj+C9GePvsPY5PgQGj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712170897; c=relaxed/simple;
	bh=kzkszAY3zXOTVsG16X/Y3CsTQ6840RVebqn5bsP1/NI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RNgkADmvZJoOsZhNVYvEZ9kVa6emKrWqwNbayDUqFwP2aoTK8STLarLjWdP4JF0i9ZBbeAkMq7BW6H5XDBIxQd/r3rYwxw3wmT2c6KOXCGGNP8B2JSBeEYSTsBtQLR/4CnuRcfdDYllZyQ+Il+puWfoIr2/Qv+D6afmhFiPFPPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItKaiiVY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItKaiiVY"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e2232e30f4so1008935ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2024 12:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712170895; x=1712775695; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tg/oL1yX4Sb9LI5hQBDrDNw1utuFeprHdoZW8jkr2Bo=;
        b=ItKaiiVYdhMre4FDomsH958PwZOqKHSY3545vp2tEHUJ9bwfytlWPan0jpHnNJqCTE
         wariA+nLRdzqpzjgyvrSLAKgWrXmhsWjmVNMElIVBJm1k9Q8O89Jgsjoymj3oGaDZwSH
         vTzsry6gd8rhje1I70RhUpSHNVwISVcsq4Oqc04g/I2q2V8JKwCAuHmZhqPWmqGdJEYp
         PnRwjCAnwf1vjU/Fj1L4dmgnl+ZAuOcVT1ldPaxFG0nBGSH8Q1O7+gIYxQNmN+OZjrVl
         dlklZS1Jc69EEqQJgE9FYaO3WQyhNZ8FMMonGIf/UWuqJY8OH0A5ENt3qE2OAedqXbfR
         /C7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712170895; x=1712775695;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tg/oL1yX4Sb9LI5hQBDrDNw1utuFeprHdoZW8jkr2Bo=;
        b=R2V1TOFVCusMauADDjtBycZfLUY5LLh9c7lo98a37eo3iAWwr6eA1tM55nH2TtbHKo
         bV31Ts4DNtY+oYVr/iCq3uOYcW3Qq/LE0hCBWj7QRvEZI8F3hCDL9Gv7M/ZDhMZICWFt
         OalFaQ6YeVd9mXduxjJkiUs75OXgCJMp6i1rtK/0yGwQ7rkv7RLnt6NIKM3ymwSx/or/
         QiePPIs/d8l4PcfOwXKLTM4O21SZd0mzbwp7RDAWewRz8msUcSf1GCoUYdAHXi6n+yUz
         EZCHvCen4OXzKIGV4ALHY+CdYFkyrH6ZzGH9YDtjeivqTQFUi/lERVB92RFCzu1KIJpX
         rQoQ==
X-Gm-Message-State: AOJu0YwMgu3YrqI1XXAegmI4hjWZKveyxLIKDOIoKXAo7JHCwI4plezh
	3x7Zid6mBpRXN9816UMQ73+XvKH4bIpWC9peYLPPfX5VS+PG+aJ3Yw7mcBhE
X-Google-Smtp-Source: AGHT+IEaV8/eHQOjBVJcCyTt1Ih6o6MySMdcIz6B2fWrDgwD+v3aJaVa4NSUQwzYFYajA0YYE5Hk/w==
X-Received: by 2002:a17:903:2656:b0:1e1:1d5:f857 with SMTP id je22-20020a170903265600b001e101d5f857mr162835plb.34.1712170894953;
        Wed, 03 Apr 2024 12:01:34 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.123.179])
        by smtp.gmail.com with ESMTPSA id a21-20020a170902ee9500b001e268c9e38asm4426387pld.43.2024.04.03.12.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 12:01:34 -0700 (PDT)
Message-ID: <660da78e.170a0220.12930.eabe@mx.google.com>
Date: Wed, 03 Apr 2024 12:01:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5189527878594222690=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ] advertising: Do not crash in case of adv update failure
In-Reply-To: <20240403171236.853491-1-arkadiusz.bokowy@gmail.com>
References: <20240403171236.853491-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5189527878594222690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841166

---Test result---

Test Summary:
CheckPatch                    FAIL      0.52 seconds
GitLint                       FAIL      0.49 seconds
BuildEll                      PASS      24.47 seconds
BluezMake                     PASS      1677.49 seconds
MakeCheck                     PASS      13.13 seconds
MakeDistcheck                 PASS      176.03 seconds
CheckValgrind                 PASS      244.92 seconds
CheckSmatch                   PASS      348.86 seconds
bluezmakeextell               PASS      118.37 seconds
IncrementalBuild              PASS      1443.51 seconds
ScanBuild                     PASS      982.29 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] advertising: Do not crash in case of adv update failure
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#96: 
bluetoothd: ../src/advertising.c:add_client_complete() Failed to add advertisement: Busy (0x0a)

/github/workspace/src/src/13616515.patch total: 0 errors, 1 warnings, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13616515.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] advertising: Do not crash in case of adv update failure

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
9: B1 Line exceeds max length (95>80): "bluetoothd: ../src/advertising.c:add_client_complete() Failed to add advertisement: Busy (0x0a)"
10: B1 Line exceeds max length (145>80): "dbus: arguments to dbus_message_get_no_reply() were incorrect, assertion "message != NULL" failed in file ../../../dbus/dbus-message.c line 3235."


---
Regards,
Linux Bluetooth


--===============5189527878594222690==--
