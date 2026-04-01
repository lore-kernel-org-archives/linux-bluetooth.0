Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3309317159
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775081176; cv=none; b=ARez4jRzEcKv+vrll5IcZUTZn+3RUkAQ4JdgtrI8nvKcswGfMG9GAeac82F8Dicrv6/p+LaYme24aOR3seENRwl9898EEwfMybn7hKzd9jVP6BKs6PIV+cXl9UWgmuSlb9MBamTXn971MYta/C4k50mdBLtnwOpghWrM/HvQDBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775081176; c=relaxed/simple;
	bh=kEE5DQSH3fKoQUpxzCJpH7MwjGKPOcmOyFvfchcUkrk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=R7YiiGL5zy1gmAU5PuhcCy+LtD2LLvoUCMkWsErLYBaSme6EUvqCD9E+K47bY9sjksyjf4CdmZwkOz/KHY5yTzl3ChLAVtzhULF0cidy/q9qVPfoTvJirwE7muh3Js+VJtYsZysTsKXrrW4ExkX79LGbePCq7wr1Xq4nPdcY54w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nD0joAN3; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nD0joAN3"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-464bba3a9easo152167b6e.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2026 15:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775081174; x=1775685974; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BJ3yu1GQ0KQj6X81spma4Fazaf36yvuhGckZEz++xbc=;
        b=nD0joAN3rBrUjQxlEGZbYXERxfvyZwh59o+eg76sOXyoJaegLNAJX8PCX8sIARRhLO
         ILfzyCqkhvZOVnptH8gKWyG771ozIIHmOrtz/HET+VtExh00sLVDI7iyYiWS+zjeXhEh
         tsl+LO0STwNuv3+WZnx6bBUKnnP2Qo4gdIGs67Wmyz4be/W+7wMbp3tzW/XZ/9/gx0ZR
         DDV2l6hX67fEDkT//q1XBeafx8gcajtGnkuAPTAn0hVIBPmhBdPpwYri9Wk8bR5a8XRw
         5BY3IE091M46958d9PvqPhdu5fst//+abzMA3NYtA8jigtuIAxqjc37+h2NFzlDJ8u8z
         zCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775081174; x=1775685974;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJ3yu1GQ0KQj6X81spma4Fazaf36yvuhGckZEz++xbc=;
        b=fvlbaKe3IEK5fwEGvrAEINJP2b/KhBAEwOkP6+ypU+i/8Ch6vQEkXyNijZQ2lPIjur
         ELKYTBIS0P8n4I+S04+z9/66LfrdMz+x0fsIwXBDXeGxfoJOwfry9PJROZT+cyGV22Oe
         nHqk9sNyamkjbbL/IfH+/7iQb/2+a5P9PUrkNfhBFKRsi0nOnw3CqRjOBtGBkOftHL7+
         4n53J8yqRLJETwLFmYYXriZlR7YH0Alb8gp3gn+cGab+Y3tZFUG7dz00X+bEoHMrI2gk
         Se+pkuOf1D2tuMA6im7DtONflA4aurcgVFOHb6pZgIMcMx1S/ab/v9a283OAvE8vxgjb
         ZoMQ==
X-Gm-Message-State: AOJu0Ywy2U4KxvKk4cVZsmM8oZKNBwXp7hjELQb4LKgwmhtMXDBPwKxu
	Gh9rwANwglm+RpN7v5LBpdSJx4X7jlGREXSkJGHFCigMwx9P6tHOyFPS1qvXRQ==
X-Gm-Gg: ATEYQzyqkFepKb4Ig4tCn/0jsvQAdwIszX3lyvlWqD4JO1kIPqgkp/xR0i1NwRSAaLs
	w7xihUMxSeHD91Da8qpoZfYVW2D0O+6qwQAKTGc3m5H8syp02+aZT2FRlz0qes6Xz9yGQiht82c
	nT+JNPucV2vjdgARqH1DaS0nfwyWD47neHyI6EQ0GfwTbQFdGzm5sKV28mFqM72BBBxWtADLPBd
	GfYxHlEmE3kuT4gHfASJVYaBb3z/DUryLiIhDTosT4pYp/nMlzgzRU/3tCeKR5q/r9RvSRt+Q7k
	c8h8Z9nukNtCg+/b0S9J6pVO6EldHGmf8zJdPVEJQC0IOaD2FDIOtpTLlBrPW2hLOBv9+OmG8Pw
	s6FkF8v70IwkPsPNVvwgyrJ+hnek8CWKMeiaLzHnzKkiL0EhBqTz4LLlrk5KowX7EMxdXGj/9tR
	EuOg3eqkbuQqiEZ3tLfD5YzqNV95g=
X-Received: by 2002:a05:6808:c143:b0:467:58e:5d6e with SMTP id 5614622812f47-46d8914b7a7mr763320b6e.30.1775081173779;
        Wed, 01 Apr 2026 15:06:13 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.59.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46d92a53169sm515922b6e.10.2026.04.01.15.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 15:06:13 -0700 (PDT)
Message-ID: <69cd96d5.050a0220.2939ce.0895@mx.google.com>
Date: Wed, 01 Apr 2026 15:06:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0756952797427084165=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,1/2] unit: Add unit test for new MIN/MAX macros
In-Reply-To: <20260401204527.148077-1-hadess@hadess.net>
References: <20260401204527.148077-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0756952797427084165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1076045

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      19.71 seconds
BluezMake                     PASS      587.57 seconds
MakeCheck                     PASS      18.57 seconds
MakeDistcheck                 PASS      230.57 seconds
CheckValgrind                 PASS      270.86 seconds
CheckSmatch                   WARNING   316.57 seconds
bluezmakeextell               PASS      163.21 seconds
IncrementalBuild              PENDING   0.40 seconds
ScanBuild                     PASS      894.90 seconds

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
src/shared/gatt-helpers.c:764:31: warning: Variable length array is used.src/shared/gatt-helpers.c:842:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1335:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1366:23: warning: Variable length array is used.src/shared/gatt-helpers.c:764:31: warning: Variable length array is used.src/shared/gatt-helpers.c:842:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1335:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1366:23: warning: Variable length array is used.src/shared/gatt-helpers.c:764:31: warning: Variable length array is used.src/shared/gatt-helpers.c:842:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1335:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1366:23: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/2003/checks

---
Regards,
Linux Bluetooth


--===============0756952797427084165==--
