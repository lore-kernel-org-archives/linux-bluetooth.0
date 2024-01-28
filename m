Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB0433CC2
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jan 2024 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706466795; cv=none; b=UAYtgVB2Yi2Vq1lvKMx8AYjVMhLFt7QpfifPj2L8DUyKVquT0mGK2LcX6ADlruvdfwykIuOW/W5xMqXiW0+mmHjag0rVWCGpeX4QytNc/OUQddGpMTUWktPd9BUojZ1FDVedIJ6W8yV5Y56xsuKTG8Qa0HZSlkyhzXUdHv3ERQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706466795; c=relaxed/simple;
	bh=ULUybsQvs/Pnm9H64VbYTg+SqmWlZwakd0QzwlNJJVw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=P0Qu0ffiT8SNhdG0qQVEpU/jOOkmeqvIFU1ZkFNosCjtPaZdItcxhw5mz+6fMAm3Zz2OSv57zBMde10rvBO+NV1Tgcihq2l5wBeXMfaZewaJTiNodXAD3wIMmZrJdnDtV+AZsxRFsUnmQH8cc92YJswYTBumwsIfZwRHXRz1yKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iY7oVSlB; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iY7oVSlB"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-68c427136b0so8071536d6.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jan 2024 10:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706466792; x=1707071592; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JAl+ZURuxPoX058wSu0boU3cP23VspqeOSumVgVQO/s=;
        b=iY7oVSlByLWpfyVl32UFuIXYuupIE2Ih6Mbn2vJkM5VH0EwSg6+oPUI/PjVD7LovJl
         OL9j9cAEn7mtJSMHIwWKLjX95KPjG/9gVciGB+CS3iiJwqAxGCAXnoVgYjXgdSLl+ZP/
         bJOizrRbLhR36ESlaptm4zbinMdRhuvg+++YdTQmx8IGspfUUR6GiMI2/gcLLKm/y97x
         MkTEZOrl0ENWV4NLQYzoBLNyC4gr6JG1oErrIqRolZa5MPYWzceOTOWqTMaKwhjlxI6t
         bjg/UiV5P6OkkApyO9Xv/WnYM8JUueO4HQAL81f9FVfspStVbqF4ZkMZHF6TEj1vPrVe
         dZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706466792; x=1707071592;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JAl+ZURuxPoX058wSu0boU3cP23VspqeOSumVgVQO/s=;
        b=rj0KUl1gHd8mDtyn1vnBjO58oVJ7UW87QotTUvXv0SmIbnrJXXt1+7X6Y1ingpa6mv
         HM0ZASwHfHAxlTEGbhVkJG0Ocp6EKDgENE6hMTElRCYMM+gOjNlPWj4mG61YrpnRWYqW
         ttYCBo+bcEy/zIy3/SdFsbA0YPuz4daj9nkP0g4n8GT37xHeBEBrYu0nWCu0crq9Bh+C
         mDR3pOgjgFXiumHzE5sanei9LjPYI/+op8lVFD0IVbHKJcBlRpIuN/h1Yo2EE6dbaZF9
         tjsF6wOJUhXyGywU0YLdWil8axhv2DgtRzEDi9zdcuBJC27ReK2q+5uqr9fg4J9oePTt
         dNJg==
X-Gm-Message-State: AOJu0YzhjgWJ74xBwYYLhCjdng/UB+veSWkAJuEpDT2XDpaIo1oFjwhB
	fDdW7RhIkyNEXBIkwd0HV1xnuH0Gqx28AFrPnJ2f3/lZaE4sCbzLh3Yr6h1M
X-Google-Smtp-Source: AGHT+IGsFCTCPDzZGVB/Xg3NuebVXjwpeNtztzCjIczIB99q7j1Mcgb73jaBt/VjYlUBU+kQ7iu/yQ==
X-Received: by 2002:a05:6214:acb:b0:686:9663:ae32 with SMTP id g11-20020a0562140acb00b006869663ae32mr7516540qvi.63.1706466792095;
        Sun, 28 Jan 2024 10:33:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV4Rr0/02PUBfJDTOyuG0uH44GV8XO4JYb8U0NDDeDhwlGyfw5++XodQpNJB6M+HqHMbV4+984W2MiIOtmfy/yg7xJKHg==
Received: from [172.17.0.2] ([20.109.39.146])
        by smtp.gmail.com with ESMTPSA id na1-20020a0562142d4100b00686aa6dbcbfsm2629185qvb.81.2024.01.28.10.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 10:33:11 -0800 (PST)
Message-ID: <65b69de7.050a0220.83910.9ebc@mx.google.com>
Date: Sun, 28 Jan 2024 10:33:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7420415270357293611=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andreas@kemnade.info
Subject: RE: bluetooth/gnss: GNSS support for TiWi chips
In-Reply-To: <20240128173352.2714442-2-andreas@kemnade.info>
References: <20240128173352.2714442-2-andreas@kemnade.info>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7420415270357293611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=820664

---Test result---

Test Summary:
CheckPatch                    FAIL      3.09 seconds
GitLint                       FAIL      1.20 seconds
SubjectPrefix                 FAIL      0.82 seconds
BuildKernel                   PASS      28.15 seconds
CheckAllWarning               PASS      30.57 seconds
CheckSparse                   PASS      36.49 seconds
CheckSmatch                   PASS      99.37 seconds
BuildKernel32                 PASS      27.31 seconds
TestRunnerSetup               PASS      436.50 seconds
TestRunner_l2cap-tester       PASS      22.88 seconds
TestRunner_iso-tester         PASS      45.29 seconds
TestRunner_bnep-tester        PASS      6.89 seconds
TestRunner_mgmt-tester        PASS      157.82 seconds
TestRunner_rfcomm-tester      PASS      10.83 seconds
TestRunner_sco-tester         PASS      14.24 seconds
TestRunner_ioctl-tester       PASS      12.03 seconds
TestRunner_mesh-tester        PASS      9.11 seconds
TestRunner_smp-tester         PASS      9.70 seconds
TestRunner_userchan-tester    PASS      7.20 seconds
IncrementalBuild              PASS      35.02 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,v2,3/3] gnss: Add driver for AI2 protocol
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#128: 
new file mode 100644

total: 0 errors, 1 warnings, 546 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13534589.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RFC,v2,1/3] gnss: Add AI2 protocol used by some TI combo chips.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "[RFC,v2,1/3] gnss: Add AI2 protocol used by some TI combo chips."
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============7420415270357293611==--
