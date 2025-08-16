Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DC62264D6
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 Aug 2025 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755340079; cv=none; b=pkYWoejipB/jAprTM+GcOFwO43no1VbpfmpfJZQJf4Uok9Ocn627KRA/bwBr9qZmvcyTW45HsZahJkNfAdEn5BGbaYf2yRMCabbxIexjDkcaKARkHNprHYzyugUEGsq/4dm0lICzEDmeDqVSFAwfkKKd7rYrr/iF76P8N0wLyaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755340079; c=relaxed/simple;
	bh=OQ4PXmoGRrQw5RkrmN241RpqrebXr3EL1ifgyFbFEQ4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YfJE6KA5IlKwOpUS+sab72KOTMte/JaJSjuZ2DyuAVndNaY3DV0Jbm1YoHaZEtIxl+nNS5rSzbrKOpxze4mE8s0jj63BWyta+gXkv31SGRu39OgcaBm630tnfpgRLsOqpaTPwMot1WXCdL5cFF7vgrUn+dOx4ySS/3vkiWyL5bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZ43WmII; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZ43WmII"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70a9f5d4d97so29160536d6.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 16 Aug 2025 03:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755340076; x=1755944876; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XQxabjR+Tvlx0r2fEGrlGu5kZoBeAnyN2xpvBKQMkWg=;
        b=EZ43WmIIQk0PSAWzfxjip7UcgevBYVZWT+AhxRgV33wljhcg19P9sXVacMTnVwYL8c
         Zsk9iRHgLUZP1RfpoSdgY48pMQd6ixQpZdCUGKCQ0yUvsc5UgbGcH1OFzKZ8rNPVHqxc
         xsFDKAjrulpP5RVK/TVc7Z4wbmhAPtsrUmMk6zbFeSVQdQXuD0gYNKm+ABrMg+zc/jd1
         KSB/hJQ66V1DuoYv7AAqotMmOkndi8azF5J018fKERcV9uo8W/7Br6x6E69RB5ZTyJat
         t7qCnwUmXtjnDZo8W2eaiqvzAc+doIYOkORWYVREG5crvx+9S2aT7qxduowd28tS3hmw
         Z/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755340076; x=1755944876;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQxabjR+Tvlx0r2fEGrlGu5kZoBeAnyN2xpvBKQMkWg=;
        b=N66T5MacYpWZPmU9Kkp/j939X6LEbGbxnGE3Bbw58P1AjGCkF5GhBs/w+5L9NPQUmF
         yrtGZBrUc/nQEexFqm9IqgSUlDytvztUJ9mOi1hJs2AEwit8ELOZ9j5xSJg1QG2eDXOk
         CRK8pw4neOzpLhzd/I+4jUNf0anW0e3X7XBX+zDdOMCuHiZlobHJGlchfS1/kIWrY2mF
         p3x1KeLQmE+pV/0MJmciruwnXFjI53lrcM1YQn19hK7qVJ3RFvyCuSUK6EwZJOfHMPq3
         mXXUsQccZuZqinOofFKToqaI0aX2XRoh8LvYJYaEyQT/tG/o8oReeD0LFCM8BEtPNQKJ
         rEwA==
X-Gm-Message-State: AOJu0YxlbxjMrOAh6r+1rFX1VyxDMX9UNKL6oKVwT9lsjJd6ehtaS0W9
	vaTDiXiHhSyjOvYc/LH1I6LT6DbjKl6pl/w+xF8gHlJ0Fi2oYR9ImHqN/TEaHA==
X-Gm-Gg: ASbGncs8DSzKLFv/VHaRe4+IdoaB60CP6dgSV1/OxV4m4LlF0IMQd7dwuSlvvImDidY
	hmY20O3wsmfS3SKgwnBQDqRa2tvNFUKJCWD/LIMd+PpL++s1dWxw/cA/hYNMo/s/dO2OgAhQBc8
	yPSO49yQl2HJqgPtyH71LhyOSOzcXU/QtmTPeLjvh6rvnFI9VTCPuTVDaINdgu6t7hOinjZss7r
	M/cxnosEiiPqIQcQzE1AkqF0vKfWCkyrz4N3piUjjj4owoJkpszVHjxhxeCcyHMl25ZUYC77M+m
	e1oWdGnh9VOC/vtJUmvww6jmItFOVJ0cJhT17Tmoc3BMMvkMy4pHVGJ3A9KSYOHqqP7pyw4OqPh
	HrkvWuwWbd2sxOGkWYI0YT2/D3dhkp4qenJTHIQ==
X-Google-Smtp-Source: AGHT+IFwAwMXbEHjma0pTf5fBHTRoI+zQ3WnR/C5sb55EA3mSSnYu9kdonZ+/bIPdV+OXdro2tWbJg==
X-Received: by 2002:a05:6214:23ca:b0:70b:43c4:21f8 with SMTP id 6a1803df08f44-70bb063ee18mr19735546d6.43.1755340076337;
        Sat, 16 Aug 2025 03:27:56 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.190.80])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9380eaasm21391836d6.62.2025.08.16.03.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 03:27:55 -0700 (PDT)
Message-ID: <68a05d2b.0c0a0220.1a4abd.9dfe@mx.google.com>
Date: Sat, 16 Aug 2025 03:27:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7075929356686963938=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] transport: fix A2DP Delay values missing from DBus
In-Reply-To: <b2fba95d658c75135f0ee7b4bc11e193be126622.1755334561.git.pav@iki.fi>
References: <b2fba95d658c75135f0ee7b4bc11e193be126622.1755334561.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7075929356686963938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=992140

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.23 seconds
BluezMake                     PASS      2654.69 seconds
MakeCheck                     PASS      20.07 seconds
MakeDistcheck                 PASS      183.29 seconds
CheckValgrind                 PASS      233.49 seconds
CheckSmatch                   PASS      303.45 seconds
bluezmakeextell               PASS      126.95 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      902.09 seconds

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


--===============7075929356686963938==--
