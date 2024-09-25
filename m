Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B0F5C603
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 20:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727295040; cv=none; b=bzWtRuifyi33UgNDYbWoLsrghlqmjJyPXa/fI16CZT8u2gb3nVbLIJWIG5j3sPlpvjRzpQZtltqDGD3FvPUYRoMUn15gfxgb1YXmaZfXR6kmDZCsUfKaS74yQO3wr/tI51cLlZCxqeKjVOHsGGRSjdPtkoeGY2RN+3XoYooyucY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727295040; c=relaxed/simple;
	bh=ZenQRvBskqKxkFuJ5Qd5ohKo8hs2ja3sQkv4qDu2+SE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DA6xv111uLtBLtR8KNgJUNkFoQ4BNtezXh1M9WcttkaxxyPraOFZa8l8jkF+L/5tSJ8HwVns+NYxtzl/yKeyTSX9TCYVGIQq6i9iUTb08tOl7yLcK8X/JcPbBKHwoa5ZeE+/zKQ9xVNuP7AOhQw4pLEWjO87LSFPov7C/VTgwIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcLBjF1T; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcLBjF1T"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a99fdf2e1aso20270385a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 13:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727295037; x=1727899837; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jAhdSsLX7/SOi4gqtAp+C+QCO9RyyfKIdutIDgtV9Xg=;
        b=lcLBjF1TOf9ZmKHRPcg8f9Nqrx7CXBLAokbrYcBcLi9K98QOmRanFGzEANZKZWenJZ
         ISTXJniIzhfT5RmkfvQrKkyM9ZxeCLA7ka5enGq9Q5oKsuXtT1X0+8QjkjG8xN71t/YR
         aEfPtqX4kMtxuGDg7qF2Lmh6j9IniIShbzLS4pkBji18fW9LPDCllExtg7UHPNQaGiXS
         L6C+dOJiOg6sa7OFm6jozF8RXGRPR29Fe86xFUfAJHhXPkRq77S/8WhUYyEm92N1if4W
         l9/GtiVTPoYHj/Hqs+dHUQJz+LfytKEVdRZGjTsMCvTZKbvDMIRz890UIWPWVD8xxKd3
         nNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727295037; x=1727899837;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAhdSsLX7/SOi4gqtAp+C+QCO9RyyfKIdutIDgtV9Xg=;
        b=oYZHgRKrDBLDMkuYYP82CwYV1da9RZN/MeZ8pPWLhDrQ3rHzgmDle44zNHynwVTmKb
         rrgSoJhKuNcAC2Zf/d3z/zZCIapAVTBRjU2YTNrXDuHvNlKLscG2Iu8yRgavRyyXMyvf
         jXvFZC+YOQKqGE+lOGLNLzjKjG6LM0mx4msfaxK1XjsuHkQPRplfVZ1FALWelKrcBAay
         s+A3BQWxkX9tc75cWCId0vBDVWn5Abx/cme2iQlivJOaWzZxx2hVytSgIGQWB8P3RxJT
         IiHtH6703ueeLY+HdzJqy5S9cdj1nuMfmOyQ+hpK6SaeirA3D//OwRtKSn/dT+iCyrFA
         oJUA==
X-Gm-Message-State: AOJu0YyWl+n+TxUD9TO7iaRIPjZPXubx+493K6pWZrMs2e3OJwox1sl7
	1JVlzNeGDVc/U0fL4GuHVNrQwLaQmBpJbxHdG/H1hd9ciLQ1h9isl5Xg+g==
X-Google-Smtp-Source: AGHT+IFAd3ObgljRokCXLACV9F+8Z0wM6W6S328yP9ksyuCRjjSywIDJm6CpiRmK1+Mn++CpczV9cg==
X-Received: by 2002:a05:620a:1913:b0:79f:41b:aaa8 with SMTP id af79cd13be357-7ace740f8b8mr626336285a.29.1727295037337;
        Wed, 25 Sep 2024 13:10:37 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.111.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde5fead7sm204676285a.107.2024.09.25.13.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 13:10:36 -0700 (PDT)
Message-ID: <66f46e3c.050a0220.331d63.9a7f@mx.google.com>
Date: Wed, 25 Sep 2024 13:10:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1356963006423030572=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/shell: Allow script command to be used within scripts
In-Reply-To: <20240925182730.2035299-1-luiz.dentz@gmail.com>
References: <20240925182730.2035299-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1356963006423030572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=892874

---Test result---

Test Summary:
CheckPatch                    FAIL      0.70 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      24.50 seconds
BluezMake                     PASS      1661.18 seconds
MakeCheck                     PASS      12.87 seconds
MakeDistcheck                 PASS      179.47 seconds
CheckValgrind                 PASS      252.10 seconds
CheckSmatch                   WARNING   355.16 seconds
bluezmakeextell               PASS      118.97 seconds
IncrementalBuild              PASS      1505.57 seconds
ScanBuild                     PASS      1041.24 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1] shared/shell: Allow script command to be used within scripts
ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#153: FILE: src/shared/shell.c:390:
+	while (bt_shell_input_line(input));

/github/workspace/src/src/13812385.patch total: 1 errors, 0 warnings, 68 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13812385.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):


---
Regards,
Linux Bluetooth


--===============1356963006423030572==--
