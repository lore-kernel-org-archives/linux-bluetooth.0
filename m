Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D36C247291
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747134232; cv=none; b=BCyoMGV1PzGpMOLP3EXepiJT0GkCVYwvCDf6frIHW8WWqT7nGUoUxcF/47D4fV7A9iiINx/Op3bdR1P2C8I+a3rxD1KZMXEHVFsMa+4jN13IUyJUYuEasNd1/ZE2chVH4NfNuwKV2Zih+wyWYGAbzvmSV29bBXFHQaj2NSq/mhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747134232; c=relaxed/simple;
	bh=3285dxhlqXpULBoywNoJeJ0OsSax8gstISJ6g1j0fVU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XRBrtzKdcKEEEqhj2BLSKYtiEhxYfdFJfPjS0SCbWc7+8xhT4lBly6nPTMrY9dgv7E/wuvNvbpXtBj7+Y2fgsG6Y5kV7KdfckuY0+re9BKIo1T9QaUY6RpxyGz5Rk+qe6ZdWxZj1iW/KMZIscVwUqJA4M5ppxo55XtGbVCGKCBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJh2wybK; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJh2wybK"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b24f986674fso3376598a12.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 04:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747134229; x=1747739029; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8Zx0b0kqgLpideppnqDmiytM3wOkeCXDrkKlhhjIqyM=;
        b=IJh2wybK8VhVQlBJUi9RY79FyZCzMn8xQINDuKFNVflaMFkFP4Ps1RXqSCqkuAAd8w
         bwBbpgkohDT9N0LQo8/SIQOjwHft/sjpYZRXBl8Dv0KPQLW2957eWBZ4noUUJKUScA5B
         1nSOtkuRtJo+bYM9XYFgLbnJo29i3qTmMcpXKskgbhCYvEsJeh7AmEtWWgbOe+9p+vRQ
         r2wIKeE9J39HuqJP4FWnNpqgfIaYmBjr4aSCnZNLDzF9tOdQlAuT4Eii5Ytgn3qon7vW
         ohTQpabMECk6EhtW4BTWBEFZH0ZCaea/kqlCs5qv+PHxGAl6v0rhAIczkqVXIenH7vcR
         y29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747134229; x=1747739029;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Zx0b0kqgLpideppnqDmiytM3wOkeCXDrkKlhhjIqyM=;
        b=szg9ClrBUQ4DdI4bKVTT7HIaG++7kf+mv3FdSi0PFm+6fd5DJTWarfgIfkc6outxq/
         iKE24a2PztTH+wglKGlm6SDea8o2pf1hWK6hZxwAwb7FFX082XphdTdQfcdszTnegvJQ
         8KVDv9qVSfcc1ZLJoizIgH0dT9LqyzE8Ch99C6XKcU0S/S4pHdnWkzvzTRtk+CIKp8x/
         81DmghKkVtsduAfQMcrbLpveX0YnjaU02g7lPT5rz8ec2+/qMmIOi6ToWmqDBaNoanFL
         SVLUv3FoN82UATxQV5cAfvdwfQplRHr5CuU0mCqWhP+NLzI2h0jB+y/C+TOEbPLZzU10
         Sm4Q==
X-Gm-Message-State: AOJu0Yzs+l8haGVRWLiB4xrE9j42TZsqPRn/Y/ox0nPspmK1M7hMDPAy
	RrNFynJuIBqx7RJGA+4QPNkCq3c/SXKK8oaDSWxYs3on+lo95BFS+JYQ0A==
X-Gm-Gg: ASbGncuyzFGHqXUgmYQWjb0oxCN1lW+ZC+0JFgovp4Gw87Zrj0J1PdEIIt5ZaPOJ/f/
	RgX+9WZ6EkfazxCgU1FfvzSGvI5sBdQcks55cCaG/iAgBrqeAY9P2FWAh0uHNia8JGqRWx9Vzxy
	f35cmRojViUvyGoZLN+cXlvIQotapvx5Zye4xXmCSVgLeLpct6lHymsTYPwxqPcRuMVOyHH5UEM
	yyg7iAb+WDSNZ6c+QgzrxgKcBUV3GbVbNeBG5VEljk+jbHxDh56b7kp7rqywcP3qo+dYJY4MYQ+
	gAjr5xpsJ4ymM+/3d7kUWKeFNQBlyHqPP7zJScbkB6gGXNyyj6i38hri
X-Google-Smtp-Source: AGHT+IF4/hatsvS3etYT4JOeBLUAMMs8MPXNcwkRgJYXzQso0FJQ2aIBtJa5NDjFfCBMT2iRPpvfvQ==
X-Received: by 2002:a17:902:c94e:b0:21f:2e:4e4e with SMTP id d9443c01a7336-2317cac8dd4mr43661895ad.5.1747134229433;
        Tue, 13 May 2025 04:03:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.14.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc82a0b4csm78477165ad.223.2025.05.13.04.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 04:03:48 -0700 (PDT)
Message-ID: <68232714.170a0220.11c97c.e53c@mx.google.com>
Date: Tue, 13 May 2025 04:03:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4056293935608998191=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Fix bluetoothctl --help hanging if daemon isn't running
In-Reply-To: <20250513093913.396876-2-hadess@hadess.net>
References: <20250513093913.396876-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4056293935608998191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=962345

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.52 seconds
BluezMake                     PASS      2734.32 seconds
MakeCheck                     PASS      19.90 seconds
MakeDistcheck                 PASS      199.61 seconds
CheckValgrind                 PASS      277.78 seconds
CheckSmatch                   WARNING   305.92 seconds
bluezmakeextell               PASS      129.21 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      913.02 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4056293935608998191==--
