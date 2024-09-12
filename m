Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D832C6BB
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726142321; cv=none; b=SLny1J372aP3przCHqOB5Z5emT9hVAh9rcrfeW7Ny6kaennNr1Q0JbmmDjHWEQnkZIZeqmqfiCp004O+NUToi5Yn38KBvhEZnp31t1uwKlojnlh8yOo7EXYt5kGZ90SrLcZIX0OxvOtkmMu1zbXPyKzSAKalKFS7TCvs0H0zKz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726142321; c=relaxed/simple;
	bh=PPOGrmRwmIq3uCCW3SomxdExNz5AxULAAyJAIUzy+U0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dvEoLOcTd2qTi2WRRtA3ayU2rp+ZH6Ra2r5Y9dcDob+OtKXG3Suw1lF2Mr1n5iZC2NjEiumhhoapP0lq8x45US9oidK4BHdjFR3tGNIHxIVZRO6fOPVm2NKmFnbN50MdXASLPJMvG3dy8CX0wjBnHS1HYoA011Zw2w1YSUJIZpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jS1Ul90P; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jS1Ul90P"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a9ab8e5f96so66564285a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 04:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726142318; x=1726747118; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sJxoWMysgUZJcIoMDHeQlbVRz+ZjnINQYbJKKeymPvY=;
        b=jS1Ul90PrHUED0PxW0beIV3TuJgDzw963GdB09e1PqF/7A2eeq2m5DmaHqbP2M/D93
         7j5ToLFk3/f8RVxmMgU2KGrWKMCPaQ6g15gvZwUDhOE1BbOAdfkkS5j3MWqAztsBBuPm
         AZmaNG+/P+3dwwLYPEi1jsd7NLk7Im5CG+H+uf7OKQE13P/r01JfMOfGvvK52r3rZgMQ
         rJ3ZW52rbY1hiQESm2l70Ni/ZeIdJA2th0QyimOYkmu0R8oLWIZj21APG2VmUIdt5NU9
         HmpJ+//51H935k+x9RBMAWgwTXe1NZnck7TKQDTSQ+rEVv8G62xbA1fmIlqLw7SEjcf8
         /yEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726142318; x=1726747118;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sJxoWMysgUZJcIoMDHeQlbVRz+ZjnINQYbJKKeymPvY=;
        b=WxJllK4+e06rR3lGOBsadw6wOF8Vn6vTU8/X4ZS7gxIIgex5cDsfD6g/io23Av2Ap7
         fKaObf5jKbsfydub/Hrc1LCy06s5XcLjogLgLi6wny9Vqnq5hXZYnov3NuBrUVT+5VwQ
         VbYSbnSOvGbSvSj6ktvn93FO3tZMVORf/wmNBLQW6AgTDAl3jiPs4jP/sNrCfn/Qvn6W
         kkjsJFSHpWiXe/A7CK4An+D0NIhlD7diAjtJLYgZZrq3AIBv5GiATM28nsLS96c+udH3
         bviBCA0ZIxPRR0gbw6MexYhcvh7Lmq83Zz/gNT5tdSJDw43WB1GEDQGexTlZQvJ0BKnY
         etRg==
X-Gm-Message-State: AOJu0Yz5VVMYOgBgv0hKFA3hzGQJTuV174/XOqZ7qQW3z1WAztY+ks++
	61aBiJQnS90MgfbUaGA5joTU9lNBk6tqCz5hjzjCZVUth5106qW2ZFh6Eg==
X-Google-Smtp-Source: AGHT+IHQ7ATMGJlracvBwrwGFoQ6D8u65cTxvuhS6OfARsKuXynbnQscv/f/3YmGWXqUE0focrcHKg==
X-Received: by 2002:a05:620a:46a9:b0:7a8:39e:d342 with SMTP id af79cd13be357-7a9e5f1cd9amr288813285a.34.1726142318120;
        Thu, 12 Sep 2024 04:58:38 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.59.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a03606sm530777885a.94.2024.09.12.04.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 04:58:37 -0700 (PDT)
Message-ID: <66e2d76d.050a0220.23947b.3916@mx.google.com>
Date: Thu, 12 Sep 2024 04:58:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8446254715957878325=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Fix bluetoothctl hanging if daemon isn't running
In-Reply-To: <20240912092253.119754-2-hadess@hadess.net>
References: <20240912092253.119754-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8446254715957878325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=889687

---Test result---

Test Summary:
CheckPatch                    FAIL      1.44 seconds
GitLint                       PASS      0.89 seconds
BuildEll                      PASS      25.63 seconds
BluezMake                     PASS      1740.30 seconds
MakeCheck                     PASS      12.91 seconds
MakeDistcheck                 PASS      179.84 seconds
CheckValgrind                 PASS      257.61 seconds
CheckSmatch                   WARNING   360.88 seconds
bluezmakeextell               PASS      121.02 seconds
IncrementalBuild              PASS      4687.59 seconds
ScanBuild                     PASS      1026.96 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,2/3] client: Respect --timeout when bluetoothd isn't running
WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#105: FILE: client/main.c:3237:
+		timeout_id = timeout_add(timeout * 1000, timeout_quit, NULL, NULL);

/github/workspace/src/src/13801792.patch total: 0 errors, 1 warnings, 47 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13801792.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):


---
Regards,
Linux Bluetooth


--===============8446254715957878325==--
