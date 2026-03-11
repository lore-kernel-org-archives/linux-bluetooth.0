Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B5F30EF8F
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773249781; cv=none; b=VIkWtDyCZ+DTGe4sqX+CCmT1HVvPD+olcNR9u2un9OdbMumzyJyuiHRaxmhkjbr9DBdZvIz2AXojeFG2u28TpH1C76JhlI4ABkeuYr0iLJx/dqivjvPIDBK7ACyahHqO+1Jm2sMuJOYiU0v+Ty1qp9qoVydbcEEq03LyWCy7INA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773249781; c=relaxed/simple;
	bh=M5uwNUAf2khhD1Ey3R7oNMo3xtYUyZI6lbiEsgM5Lh4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WZmLxiUOg9nUcVxxVimVB8u4izvjccpN9SES4Xp2jTacTZ5cJman3P2aJ+orhMbJlv+NCw5Y0E8F8JJ3NGTAyoXsNkxqIQjx8tisKaBgm9+t7yFbBII/jugT5zS0SIkLi8HJ6AUwj9ZLybQTqerb21z2zW/mxJHvYHhiJta9l5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADPr92ej; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADPr92ej"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cd71fb9f06so4539585a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 10:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773249779; x=1773854579; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6QbIolgzW5Dlof54mN5QLfKohyrVPmACidhBT1g9qds=;
        b=ADPr92ejSGzrtx31Q3puuPshOkdZNctuOFAI0XTn/Q0rlbiGM1ASLXbWfYvfQDTZzi
         FIn8vn3d1q+P3E+iag31ZA4zyZZSbmAmVsGhfng3MEtPp5pG6oYn0cVGkMY3i/rnieSA
         WtK2miiEEISuKgxA7xYYrYE0lPvnln5XL6F9YbC18l7PQr+vIGBO07pSADPLt9lmKVPD
         jSGRrMohUxERhSB+YjyLZcD3v+MTv8plknt+TnMKtLoLTTsWr+6S74sdLj4Dm/qkRhbL
         2Q502pAOLdhe3kOnNMcAZT04b9Gn9ylSrc9dKUJjBJcEAi7BUtInTvA6tT5/yJw7qDmw
         Dedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773249779; x=1773854579;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QbIolgzW5Dlof54mN5QLfKohyrVPmACidhBT1g9qds=;
        b=utuZJC4a1J6ZeCUmDsGhfFhf1WzA8ZbwCUaMfda+ZnacQbhCM18vtfGLiyr8WQ0UJl
         5tvJ7y8CGtNoqyXPnTcRP/OpZc9w/xjFqS5+/4PeISIanmJAbbJplIiQCUk41xT9XNA7
         3gVXv9PhtAxgHMYS4bf9KABuzUvV8oy8K5q2gTQI65naTPhECHtS8cT8ViPf2MmksEJ5
         AyX5dxmprCS0yPD4cYs60KWXyuTsmg9Y7nDnC4UDWd1aBQRbt5CXFeXghvji4q0W9R1B
         qBM7Of5PAgfkcsq/P9HRjdfwgsnUHgZDQ18maRLifS++YL0M4Gzx/TZxKbmUHWsKbcbM
         7nWg==
X-Gm-Message-State: AOJu0YzkcAoN9XMLjNUYEfqVAmbGqb1E9lJ3PrsYJP/gB70FGxDdPF8I
	iG8KQDXvNn12LNdsjDFCWEQJuxpeMTup9fLOh/GftU2ztqjpGAanl8GHANhivA==
X-Gm-Gg: ATEYQzwm3rLrfkX4MvH6mYWzunluOp9sGR0Y70l9imfTpC1TJNEP4GAneSOzOA6EfsK
	4uglCItOgSRymBX7Tm6ySUt165WfCdfyktY5oWs9MmpkixN5T9+UhbRmiH1Os8v3+fTMXnKO4Tb
	3+BOdYWlebdLjHyhlPaouQ7r4+KlLB6TdcsID+FaoE0XfkVX4j6ZevFCI0K4ERpsJ2JbIcnkNox
	6r4rkbRWZrvWyRgt272bSncBOk3URf7gZ3RgaBh9Ruz7NEVeYgGhtqOZivCbnJSIgDhkLRBHdXk
	XJYsWpBSOlw3JuYBjxck53APmd+QUBJg8RYaKFDhPKbawW/dNx1WwyR/0PWyLihXb1rd8CvTXAy
	N5uUniXT8J1Q5xx84v4/33KeWZ3TtdmOdgcyAGyCVHua7YxoHiAWvjMXoVspTfnuIY9gDL1TG2S
	PA2snkvG3LvLyBWsfYYcSWiYCNETo=
X-Received: by 2002:a05:620a:470f:b0:8cd:9938:9809 with SMTP id af79cd13be357-8cda195695amr419655285a.26.1773249779290;
        Wed, 11 Mar 2026 10:22:59 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.169.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fc2725sm175609785a.8.2026.03.11.10.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 10:22:58 -0700 (PDT)
Message-ID: <69b1a4f2.050a0220.3b4a0f.8ae3@mx.google.com>
Date: Wed, 11 Mar 2026 10:22:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5263083495225487986=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: iso-tester: add tests for set & receive ISO HW timestamps
In-Reply-To: <3c9b3d899d6e4b042e532abdb99048d1e04ff99b.1773245672.git.pav@iki.fi>
References: <3c9b3d899d6e4b042e532abdb99048d1e04ff99b.1773245672.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5263083495225487986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1065141

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.45 seconds
BuildEll                      PASS      20.88 seconds
BluezMake                     PASS      655.27 seconds
MakeCheck                     PASS      18.55 seconds
MakeDistcheck                 PASS      246.14 seconds
CheckValgrind                 PASS      295.94 seconds
CheckSmatch                   WARNING   360.92 seconds
bluezmakeextell               PASS      183.99 seconds
IncrementalBuild              PENDING   0.36 seconds
ScanBuild                     PASS      1034.66 seconds

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
emulator/bthost.c:710:28: warning: Variable length array is used.emulator/bthost.c:711:32: warning: Variable length array is used.emulator/bthost.c:952:28: warning: Variable length array is used.emulator/bthost.c:986:28: warning: Variable length array is used.emulator/bthost.c:987:32: warning: Variable length array is used.emulator/btdev.c:482:29: warning: Variable length array is used.tools/sco-tester.c: note: in included file:./lib/bluetooth/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth/bluetooth.h:237:31: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/1956/checks

---
Regards,
Linux Bluetooth


--===============5263083495225487986==--
