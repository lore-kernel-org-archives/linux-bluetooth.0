Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1145225D9
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 May 2024 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715197260; cv=none; b=Y6VGXUqTZ08cWv8R5jDEUVKkcNs+2KKBrOzOu5CjIj7dRb/0NIHMx9m5wrvF5ZegY05JfnOxkuVJiUvhzHUzF43awv6RUptZx5aD55Bh/Yj0SYDrOv0+Np8CRIXcFzbiKiNliVL6m1PFJWoAUkF3z4NbNbeT6ghQZoOHHW0iiAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715197260; c=relaxed/simple;
	bh=6u0C/UxwFPx4C25soK9by+W7EJ6i1vrq1P8IZtZccQQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=R3LJ/wS2QSiYL753KDO9aqtBnrUchBAGkwLZX//B4dKK7aEnsfMYWgoVjw4J6dYWe9zfD8MzBQd2VxBDOh0nuwaXSUWIiKR3WwYQUwa/lIynmAZwQAUX+uYCc75R3cFhDy8+MtHeH3p9RPgYAwChBQ3oTW6AyNWGwYZKKxPPbPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVa0ygD3; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVa0ygD3"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b1ffd24c58so69308eaf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2024 12:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715197257; x=1715802057; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XxdecGu/UY12E9jIXquuFCs6dGuEdHAAiHKvyzjCLEc=;
        b=AVa0ygD3diQDkwSYdZJn878zWoE5QvXyIfPVN87333mNsNtjSMmyqhtbTmk94o4wcd
         RRkdgwNOe/9piWclrW6YuM7pwc9WGAwlLMtXH9X0Ljfw/3QSqlexjeZuRCPY36NJCtGX
         WkaoAiCPyGsADt15XLRajjhNg6wOhBNW9TaHCfQaI/VDTJf83vo+u7mamI6pbxK2BOB0
         YfqK11UuzhKHj75+cJIxBAE5fksjMhlVokNS5ZcmHXp+MfEApwGHxDhlwLaobluWAoqj
         K6X2KTBJXYnxGMVDPtJpfSR9VXKzUPLNYI2BOGETIFu/t73hquyiP1EkNgc1UgzijMXm
         DD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715197257; x=1715802057;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XxdecGu/UY12E9jIXquuFCs6dGuEdHAAiHKvyzjCLEc=;
        b=t7DjVBO2x7u0Q9p3h65GDZWVV1l2Ap+4shqv+gY3UTq8XM7kRoTw0gSkwo9maSzHHf
         H8GSXzicwmt0y6PlLulVmAaX0tEO39gvE5tpKxzct4Ey+ugAHRxIGizrvVJOQ/PxI9Ad
         dLYd++yzYXBUMArlkFs9CUvD4kU+saTf6Pvnre4D6AZwjrHW50HeGhPjdg9RlzM+Z6FG
         ilnb6pA9eGMOrCSlzViceWzyqQD+j9jd5eFWEJVGEGJqWW3eVIEpasQ12SW7d0n+aVR5
         ceRXZJwO5NBJe5YOwLIZzFulw58fVcnJD496QEeWz9+4ycwrdEmVZ6arvh/9jrW+fl5Q
         eFZg==
X-Gm-Message-State: AOJu0YxsXz+GbTztoFF4e7MNmOb1FkYKHV16JTjV+l+jE2X/RQMZy1Qv
	lSfuvPlhlRh2nYpztZDNZ0pagFvMX9fuUM98KszhPW0k1TrPCJWkVD1Udg==
X-Google-Smtp-Source: AGHT+IHTqBZliD5Ial/lZ8hOYHyv9kVC3pjsF7oDE24ZXaGjT8JGxHoPlpRIj63QLBHCuP5igw5OiQ==
X-Received: by 2002:a05:6358:5207:b0:18a:634a:6cfc with SMTP id e5c5f4694b2df-192d377c7c7mr378941855d.22.1715197257424;
        Wed, 08 May 2024 12:40:57 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.25.48])
        by smtp.gmail.com with ESMTPSA id m185-20020a633fc2000000b006202bc134f3sm8637170pga.77.2024.05.08.12.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 12:40:56 -0700 (PDT)
Message-ID: <663bd548.630a0220.5de08.8297@mx.google.com>
Date: Wed, 08 May 2024 12:40:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1822303524947584273=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, fontaine.fabrice@gmail.com
Subject: RE: configure.ac: fix sixaxis build without tools
In-Reply-To: <20240508175416.635797-1-fontaine.fabrice@gmail.com>
References: <20240508175416.635797-1-fontaine.fabrice@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1822303524947584273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=851667

---Test result---

Test Summary:
CheckPatch                    FAIL      0.73 seconds
GitLint                       FAIL      0.53 seconds
BuildEll                      PASS      24.68 seconds
BluezMake                     PASS      1616.78 seconds
MakeCheck                     PASS      12.92 seconds
MakeDistcheck                 PASS      181.91 seconds
CheckValgrind                 PASS      252.33 seconds
CheckSmatch                   PASS      357.71 seconds
bluezmakeextell               PASS      121.94 seconds
IncrementalBuild              PASS      1365.10 seconds
ScanBuild                     PASS      972.12 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
configure.ac: fix sixaxis build without tools
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#92: 
https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=9f71892b63f6b65dab874a633d88ae2dcad93a16:

/github/workspace/src/src/13659022.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13659022.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
configure.ac: fix sixaxis build without tools

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
5: B1 Line exceeds max length (103>80): "https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=9f71892b63f6b65dab874a633d88ae2dcad93a16:"
7: B1 Line exceeds max length (199>80): "/home/autobuild/autobuild/instance-2/output-1/host/lib/gcc/x86_64-buildroot-linux-musl/12.3.0/../../../../x86_64-buildroot-linux-musl/bin/ld: plugins/bluetoothd-sixaxis.o: in function `sixaxis_init':"
10: B1 Line exceeds max length (82>80): " - http://autobuild.buildroot.org/results/c337d0f473c5fbb3e6cda1317ba06f5e2b16a43e"


---
Regards,
Linux Bluetooth


--===============1822303524947584273==--
