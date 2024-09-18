Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284C414D6E6
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Sep 2024 21:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726693328; cv=none; b=HmnmPPu/pAG5/PM08V36xsH4pO16BsFQxgEScuxHium4wvgNhqnQvgLL0QEuhwnkr/zRJCmewvRZoCdMdjjU3lwyFiOz3SFsVMvLrC+f36llEanhw+0EnC21gw6w+2WA1YgpoppPQL9x92cibWWhT3aMHW3ouOF6fJn1nGa/oa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726693328; c=relaxed/simple;
	bh=F4LjIXsFtLnMaOQShZfpvgE2wtLhdeL5J9S1LrlAxgk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QZG3i+WIOfTJwin0Wv+qGaguqoUwsn0cYbU/8muBZYGa4/Wdypzj7O07L6mM3NmTznXUMUWtPjvuney5hoZtNFEmwn9Y8XkhlNLD56rh8dlIlv2PWytyRsSW5jDKRIujUZXZbPnkSb7K+SHLOOV7wbLTkYJKDGcFa6AAHWz9Ry4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCoXGozx; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCoXGozx"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e1d22ecf2a6so172361276.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Sep 2024 14:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726693326; x=1727298126; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gziJjpLzUhHZ1xt4gX314Ae6w6pytSxSIUNN+ps3KnA=;
        b=nCoXGozxZKmLKWF5Zt0YNrTsku3JQgHhPRPnOZvEyBhxvpmmWPOfkNkf+/oJbbezrJ
         3AnyogT+7sw05gb/NWDQAlhGKRUgx6cJIRBkHYRT/ZNwZfR4/k+FxrFsx4jNMlZwCxRD
         PeY7yzx1K7BGLHK3E+q82u0hn9aoTEXBXxcoE5VkkjKOWglCJLsWUu8RTCKKn2tzf4MJ
         JvJeRW8xiz/w9OiB2vAG3A7odPkbTh/iK0RZiu/n+UxahsubUf/FbBfg5Q5bIHcxDq9K
         9GA/YPgCTLF/KCxdb38/82+637tXWND8kWhVPk2irU80T1AtQqeuIztu9PcyiBQV8A7w
         t5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726693326; x=1727298126;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gziJjpLzUhHZ1xt4gX314Ae6w6pytSxSIUNN+ps3KnA=;
        b=QgpAhwZUX8xPf3mMyOkK0YiIpZU5LoTGJgswSX3kJPw4u7AlSfiDmT7zHdX6JuJggf
         sQp53v2JlwNDmBUwfMJ//ScjJxBXmXwOGzYL5+iRrI+KrqfCM0ek/B9cC1aHBtyV2ekD
         DX106Y3V+qhwGBLCUNAzGFayyV+31Kr4qMoalgYWWyWif4l9jYy571W3ws8tKWmVzL8G
         E6anRIZieS2qbOyfsb5zB7F0qnIJesZFc5m0OJDn8DLxylV2E1DczX6e0bDxstg9nxfo
         Fkb5K/rbclbVCBa0pMRCiq54co7nmu+uAh9sjMYmEmKO09D3dGAQxkfP3oCDBYh8E7rM
         BDYg==
X-Gm-Message-State: AOJu0YzIKwy8IViWzZzzSFYD/WK+rdD8TqH65D89oW8LQu5fDrtabl6B
	mjG6nlYV6iG1rss1M4oG4o5xTJr9Sw+977BouX+mY3ZkCrnA8NJCx7gedg==
X-Google-Smtp-Source: AGHT+IF9pgKdWsQzaOt+d9axi5qlmF2j37rRdfY/19EXdEX2D8i4sa2g4yj6mbJHpdxslbITV6x4fQ==
X-Received: by 2002:a05:6902:843:b0:e1a:aa90:34a with SMTP id 3f1490d57ef6-e1daff7c46emr16692895276.19.1726693325895;
        Wed, 18 Sep 2024 14:02:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.46.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c75e489cfasm999466d6.59.2024.09.18.14.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 14:02:05 -0700 (PDT)
Message-ID: <66eb3fcd.0c0a0220.1f407.08f0@mx.google.com>
Date: Wed, 18 Sep 2024 14:02:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4304793774857751807=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] client/print: Add decoding for UUID properties
In-Reply-To: <20240918192707.686174-1-luiz.dentz@gmail.com>
References: <20240918192707.686174-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4304793774857751807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=891253

---Test result---

Test Summary:
CheckPatch                    FAIL      0.69 seconds
GitLint                       FAIL      0.53 seconds
BuildEll                      PASS      24.06 seconds
BluezMake                     PASS      1598.31 seconds
MakeCheck                     PASS      13.09 seconds
MakeDistcheck                 PASS      176.33 seconds
CheckValgrind                 PASS      247.69 seconds
CheckSmatch                   PASS      349.49 seconds
bluezmakeextell               PASS      118.02 seconds
IncrementalBuild              PASS      1475.52 seconds
ScanBuild                     PASS      1010.27 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1] client/print: Add decoding for UUID properties
WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#182: FILE: client/print.c:124:
+		/* fall through */

/github/workspace/src/src/13807128.patch total: 0 errors, 1 warnings, 103 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13807128.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1] client/print: Add decoding for UUID properties

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B3 Line contains hard tab characters (\t): "	UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)"


---
Regards,
Linux Bluetooth


--===============4304793774857751807==--
