Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9DB13D619
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 23:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715729385; cv=none; b=fM2cCw2ukV5zfK8CCvXQGK/iY17B9VY9I3vecTbSMYKT0g/EirdEa1KFldnT5M/sJ8T+xchAcPhbzklLvw2nqt81zKwqiycJIke/GXn6GCm+6zeF//rC1CpUD5RXC9gm/bR9AIDhwkfpVL7Y4ugTvr/aqsa6PXbvcZwOSkQh2s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715729385; c=relaxed/simple;
	bh=KHjYz+972d+UQdpaMIBsn47RO/fF/XYWSJRz4W0/QqE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=D+vCwfhgA8gueBPE0kv3Z9DwEYNR7rIJs6DSsS0Kb0H1zVF+nHY9b9220Z0HZ9agNigyrw0ngUz7Qd2mic9xGG+UTv+CMB0JeRxaXRcZKOrr1EJzdlkeTDEdUY9YzVDlsIBsmo88INgjGPwd1pSBEXe1tfwAdcxs/YltWsQJxEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5ZVFk6t; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5ZVFk6t"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f453d2c5a1so5030382b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 16:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715729383; x=1716334183; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7hYZN0Aryg7DDLaimHBObsZ7DULNqwNTzoW8V2Pz1D0=;
        b=f5ZVFk6t3e42GDaZbOphinnt+Yoj0lKjogb7ERYA40tPjmDuLyrziJCe6K+eAR6ku7
         cjnd3DHS9JrrYacg0b5jT2KkxE56wVzUhK9AGlMQiboTYVb1cEGTDuo2UJoV3htPfud0
         agAnGKHVETPcHufVtH8CGcPjm0+GqkvH+S1kylP91Sjnu3+GNZgVp+LKnLjiun5kHRAY
         RDvjZgey60o0ak3lIWqUXAANvYtwLdTRXIZFkK2XT4Pt98xj2x/2NyrWrobiWrcLuHku
         PR+EZEC1Ur+sZ0E81+nnbnaLPfosv5ms+Y0w7gpPQ1wCNTOBQclhXW3FN57wZq6OUlbw
         igeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715729383; x=1716334183;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hYZN0Aryg7DDLaimHBObsZ7DULNqwNTzoW8V2Pz1D0=;
        b=G1KxEBfikdc40tfd4BR8ZPF5ymeWdmq3aQ/SJK88oOGzmAPR1gmW4f7iNIXVU0wGAT
         2/Qo37DA/RNVAz5ZzNOI9dy1KYSHfF0m+cU0sTOftwu+S6nPdXv4ZQfyeb7LCWa6+zJv
         8/pddmoxbvvTVWu9o/BFvN31EBbswSl/JrHZqvvMpUQCBcXsVaw8VCSdnFteoGSwp7Hb
         /BGOFxDVDYehFMP0dAz/30wFLt3GiJvphIWvPX2Rdw+hlB/MTtMibnyVHy7bcTV16XXD
         6hbduSsqjbQsq7k9GRz92uyBEigKUlPY2RwuV2fOf7QpXjSY1l4ahaRVrsCzajrTmTRH
         EmbA==
X-Gm-Message-State: AOJu0YwaHKIwk6fpupApmZTy3aocYVniV3UvrZC8BC9KqKP4N2YuDjVS
	qgtK+841KreNamvG6KPSLWL1SxEMzirGuOqac2M38DbSmM0VYcXtNKAeNA==
X-Google-Smtp-Source: AGHT+IHAZAwx3NOR5n7hOVgecTFvIwGsfWXMmQLx7MvlJvA0TYEc9mAbFCwNfmyMNKpJr0ZbwviDmw==
X-Received: by 2002:a05:6a00:1307:b0:6ed:1c7:8c5d with SMTP id d2e1a72fcca58-6f4e02837e6mr15192013b3a.12.1715729382620;
        Tue, 14 May 2024 16:29:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.122.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2de1csm10178031b3a.204.2024.05.14.16.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 16:29:42 -0700 (PDT)
Message-ID: <6643f3e6.620a0220.d7c0c.be5e@mx.google.com>
Date: Tue, 14 May 2024 16:29:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6679981657985763238=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/3] shared/tester: add ability to skip tests unless explicitly selected
In-Reply-To: <d832a406db3b7f8509fdc67d0e9f2775c6ea7b6d.1715719254.git.pav@iki.fi>
References: <d832a406db3b7f8509fdc67d0e9f2775c6ea7b6d.1715719254.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6679981657985763238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853223

---Test result---

Test Summary:
CheckPatch                    FAIL      1.22 seconds
GitLint                       FAIL      1.09 seconds
BuildEll                      PASS      24.25 seconds
BluezMake                     PASS      1664.16 seconds
MakeCheck                     PASS      13.01 seconds
MakeDistcheck                 PASS      174.92 seconds
CheckValgrind                 PASS      247.08 seconds
CheckSmatch                   WARNING   348.72 seconds
bluezmakeextell               PASS      118.31 seconds
IncrementalBuild              PASS      4560.27 seconds
ScanBuild                     PASS      999.19 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,3/3] Revert "mgmt-tester: update for Poll Errqueue experimental fature"
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'c777c55ab662db4e9853bb08a6e1e6c77b319e09', maybe rebased or not pulled?
#96: 
This reverts commit c777c55ab662db4e9853bb08a6e1e6c77b319e09.

/github/workspace/src/src/13664420.patch total: 0 errors, 1 warnings, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13664420.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/3] shared/tester: add ability to skip tests unless explicitly selected

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
11: B2 Line has trailing whitespace: "    "
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/sco-tester.c: note: in included file:./lib/bluetooth.h:219:15: warning: array of flexible structures./lib/bluetooth.h:224:31: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============6679981657985763238==--
