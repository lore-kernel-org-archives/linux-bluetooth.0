Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8859256C61
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746208598; cv=none; b=BdfW7vURdnLf8kZ58aeby/hr2frCNiedUrUbaeTEFYRHzIWKKypz8hI6YmZYS8VgWjBGQBftKEApt+DYvQpQJooLfUtuum5UAPNHhqnlJVaQuYcj+B+yGqN2sAIUvlk9KPE1uuNzghWig/8VgeYQJZsQ4/LgTxwirj1puIjPJlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746208598; c=relaxed/simple;
	bh=a/7JhD4nWxrAhDrbwe9Pen5QLZoLm8Ht7GUQ49DD5fk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=U6iBRNvLrnxiftU7ir4UPLwHmPBB7m3J08sPckpwL4L4gjKtrdGpNZdzj3RYFJ7GbPCV3J1jUMUWRS9DvO+DBb89AKnUzARVC2RXj/yTP54t2yigHerZ5N57BjKL1trko/zPLvH3hIlt8LHijOH5rftBYIn8J/PwbU1s0wH5Bls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVwkkJvk; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVwkkJvk"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736b0c68092so2288564b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 May 2025 10:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746208596; x=1746813396; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FapOVcAf0g4Bjs+NCsHwZWeAPEK/nFcBBMwqJp9EZgc=;
        b=BVwkkJvkAC/uPEHgQlwKwFL8PbrYGn+tWPXZj80ekFDRgNgsfpSz1me2tiQ7q7yz95
         VHk8SS6Zx9J3X+AauVYgFnKc9TPi+MkgKHBK65j7gDByE+f9mcEGj/KbdRAMnal5rAJb
         ZDq8gw/Xb4XpDWB+ZmrJaUV1daWoiS/mtnzmqS/lDkCTUETiL1/yqKDtgZia6NXPpjB4
         sZCwqRhtRRiTegrn9FAe9cwQv4V+Q489kuJlw4HUM0Zr3uvKWUfw7US5384nWJK887WH
         7Sl1xaq5NaWeRVG5c2mOStELzAIJ2AfMxYgVsFdXBHxx5g/BC7tWpm4IWKAzBdnWzC5C
         WdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746208596; x=1746813396;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FapOVcAf0g4Bjs+NCsHwZWeAPEK/nFcBBMwqJp9EZgc=;
        b=m4OTvncDRuMjH4HwFq7/J7f0fFNqqpbOxjF1vGqboDpLhtg+UtcejJiQjMcZTBYL5S
         3RXfNMCeEW/vQEyUeTBDEuRGfsc2f53NBBBT6gwl1A9QQwevM+tTLnumztTUm1WT6VbG
         dhSzU519DW+YuzA4NTXzvTwv6mDwSuDlhr6GIA1d7QL6sMoYvTN1v9WBtQCC3DDNmX6Y
         kO4P5xW3bpeUCOSmHxnxz3ghX7vkByeXOGD81wWOrqqyA2REaZLXgdyqEpMxQa3982z5
         CBmRFXlxSp3RbkWsnscOKKgW0Ry0V9EHkcEZt4R0DPaD/QTBB9OGCMoEjdFdoHXQMcLN
         /XOA==
X-Gm-Message-State: AOJu0YxX1PSY1stHs+cM0zXCYB42T40ZNdJslnEhBqE1lxCfN1oSdZbb
	C7yI3qP0nBoliL4KnA5BJcw040o4HmNEoaFaStwBBsrsZ9gbpS4A4Nwtgg==
X-Gm-Gg: ASbGncuEoCzPczoTHH2he9pyMt5u7LpiimX4z8OUzPEOKIjiverrJLyIO04vZQHByEo
	xbhFqejIZFnqYYjWgLWuxY+sit/EI+Q93NlCMR7Nv6xf5zGjE2Ytwpy4p3SISmtbEc4s9hpDq36
	Am/efZ+dRowdgjVeJ4ZmLPf63bzmP7aBLv44kdTCbQeaD26DMhFtV607PgqSm2APyXZO+StoFkw
	k4OE3ZLF9RIE2TRtYNMQ1p1Cmd0AMJdcjHBuMAgSlQ/2b5szVNfXZDnoA/fzNbaOU4mTcNEjZML
	wPERLrFQ+9kuuQKDzVEfN1e1E+hTjqLbbF9mo61g6E/4Sl4Jp2R869ON
X-Google-Smtp-Source: AGHT+IFkDavK6SBvvmIY0f3LLXScQqyjeCpwsQQmfdmNJm5Vx3eSeaEl11QeP2EwYNuhBzG+0CMk0A==
X-Received: by 2002:a05:6a21:900e:b0:1f5:6a1a:329b with SMTP id adf61e73a8af0-20cdfee9a76mr6603218637.32.1746208595761;
        Fri, 02 May 2025 10:56:35 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.1.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb391f915sm1092499a12.16.2025.05.02.10.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 10:56:35 -0700 (PDT)
Message-ID: <68150753.630a0220.c82ea.5bb7@mx.google.com>
Date: Fri, 02 May 2025 10:56:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6160565417359688642=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] mainloop: Only connect to NOTIFY_SOCKET if STATUS=Starting up
In-Reply-To: <20250502161243.2745492-1-luiz.dentz@gmail.com>
References: <20250502161243.2745492-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6160565417359688642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=959149

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.65 seconds
BluezMake                     PASS      2664.76 seconds
MakeCheck                     PASS      19.84 seconds
MakeDistcheck                 PASS      198.66 seconds
CheckValgrind                 PASS      275.00 seconds
CheckSmatch                   PASS      303.06 seconds
bluezmakeextell               PASS      128.52 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      905.76 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6160565417359688642==--
