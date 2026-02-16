Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8542D2488
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771264432; cv=none; b=Vfvz+Joa9vv9rZG3NOx0kmIK5EdEU5SyJnRku5aTOk19tZRG73nBNxPe2aT/U/lssa6b6A4o87LDxkQQ53iw6vbaAHJBbHvOx34/pCw/x89fNxau/dCV1jjcK5mpWX2pk8TDKXVuKjTJv9p8TSYnfXcEGWJGMFr4GdFvzqOvmYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771264432; c=relaxed/simple;
	bh=ZSYxJF40eqx04YAIkpb4eEfRyf0xTeB+PkQJ5ZjqKhg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oVxA2xayefvxXO62Xr4SvfL+4dFZoSsznSOj38E4WY+sCuWZTx3AkCzBBPfOIa2eBxXiaV9opqWQci3jtelGhtci8xNxJOdH12iabilKOdRItbta7QDPM22yYZO1tuC1T98+8dmuP+vXkg0BiKOh9sPuLFvurpaX0XmaLb7yLes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqXlklJg; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqXlklJg"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2baab3137bcso2995219eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 09:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771264431; x=1771869231; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PKmjesHgGKcsiuEg/nmvp+obo3j5LtWcxyebud5fjkQ=;
        b=RqXlklJgh8+ucel6A6xEE0AEms0cFpB+FuZFGMM8C6wKjKgkQiH7XHgmu+h6Tk0V71
         1WDzDkaAyyQbRwkmGkMdvMvjDq57dtBihxuEz7OT+xwbHbJHw88RG2R+Y9q1JGC0z/Mq
         KiGgfpA1oCD0PGsaaCvqvShtRhLpLpDbrbYdolMV1RSxUErnWEJ79htXfu8Gtz/JHLhf
         ulELksQjKDx5kGnK9j7R6vWq1UFShgKKysPMVDF0hoxf2NA/aOVuPGDSlgUc5fANJlL/
         A4je4GSqNk9vLeXVJ+MyGuI9yhB8B4hBKlriFkRzJuUsq5dsafw6pIjzEZwYmrBvoSNV
         5KaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771264431; x=1771869231;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKmjesHgGKcsiuEg/nmvp+obo3j5LtWcxyebud5fjkQ=;
        b=BA10LHYDRzb1qFn0ywokNoqrPGpibePC+4qBsXFUMkmhGCH1K97dRFHPT9UQHw5a7c
         ggFuOWJU4kFfwXN2HY5eGInnzrhwctdtWiza39J7PJCS9LscEWyNZlJl1OxuQkGiso7h
         L/5TCiXVbRY4SVAXtXBXWzBF/BR4CNjpvckKtdl6uRXn3wvFYmAQktbAop3miqs/nJ96
         Oz2OMokeXKl0csiHqKJwj/GnsftCqTBbIWfTDY5zy++NzjWb4GnPiRuIdWN8NeAewArL
         oL2YBbE4ulr6nkUALjK8B7LeaMr/O9mnYvc25FEga1IEONEg53L7s/ouDPNSZM/wzkwn
         g0gQ==
X-Gm-Message-State: AOJu0Yzi8/c1LBhyakKzTneRsu+cADHKZkzFFKo3ePmtjfCcqszO5Bk2
	5HHmY1WjfomtqSsToOMdGFpVXxlM2n9g+3wllYpLp2QhP8SSiWV7E4h4QNFKeGHd
X-Gm-Gg: AZuq6aICQnTv+CVjfHXI3sQIF05tOvfAGpuUAxtO//CR2wTN1AUY/NQvPdLYYxXvHu9
	OA/zlW0ACzVuks7nH7ypUqOzIX3S7Dv5uzqGN7s5EjVfErofKMwNNoBfV2IlpTaYbb1waIoye/W
	MtW+wOM5YAWY7hmrmuulAlUlO8cemfRv0ZofWU5YHuROH14ielDhsfTCHM73vWj6HHmGzqV7sDK
	2ej9Rl2euztZYbsQgErTXLShB1jDgLKNyHrD7RxwTOKtcddk3FFuQe5PzmbG08+TdgIoJpyMMUF
	0ZsLB9xOHt1sd7xrjfrZCkZxY+ZECBUwUtjm8LPJ2NAk31INGuZRTolJ9v2i4plpaOKyZ2zdy/v
	tRMWKT1gJk4Zem4M5YIV0a3leJrQKHQHvVDcKuRF/CURaWrKuPHr60gopaLNujRCe6Gqenvnbjk
	L79PDIEGbhjVGFLfQ+l/DQVIwonDpu
X-Received: by 2002:a05:7300:df09:b0:2ba:8aa8:9c04 with SMTP id 5a478bee46e88-2bac933badfmr4005947eec.2.1771264430603;
        Mon, 16 Feb 2026 09:53:50 -0800 (PST)
Received: from [172.17.0.2] ([68.220.62.155])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb658fc4sm12080325eec.22.2026.02.16.09.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 09:53:50 -0800 (PST)
Message-ID: <699359ae.050a0220.b0b47.0198@mx.google.com>
Date: Mon, 16 Feb 2026 09:53:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2079807786610373356=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/3] tools/btpclient: Move btpclient to client/btpclient directory
In-Reply-To: <20260216165127.110686-1-frederic.danis@collabora.com>
References: <20260216165127.110686-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2079807786610373356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1054634

---Test result---

Test Summary:
CheckPatch                    PENDING   0.44 seconds
GitLint                       PENDING   0.39 seconds
BuildEll                      PASS      20.97 seconds
BluezMake                     PASS      670.34 seconds
MakeCheck                     PASS      19.24 seconds
MakeDistcheck                 FAIL      43.54 seconds
CheckValgrind                 PASS      297.77 seconds
CheckSmatch                   PASS      363.94 seconds
bluezmakeextell               PASS      188.31 seconds
IncrementalBuild              PENDING   0.36 seconds
ScanBuild                     PASS      1059.02 seconds

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
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

../../client/btpclient/core.c:14:10: fatal error: btpclient.h: No such file or directory
   14 | #include "btpclient.h"
      |          ^~~~~~~~~~~~~
compilation terminated.
make[2]: *** [Makefile:7170: client/btpclient/core.o] Error 1
make[2]: *** Waiting for unfinished jobs....
../../client/btpclient/gap.c:20:10: fatal error: btpclient.h: No such file or directory
   20 | #include "btpclient.h"
      |          ^~~~~~~~~~~~~
compilation terminated.
make[2]: *** [Makefile:7170: client/btpclient/gap.o] Error 1
make[1]: *** [Makefile:4218: all] Error 2
make: *** [Makefile:10818: distcheck] Error 1
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2079807786610373356==--
