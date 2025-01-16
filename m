Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5A7155756
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2025 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737065450; cv=none; b=UULmg+rGi/JdpMfP7v0KjkJcv8qs5lsRkuTqxHMF7/UNCHz8q1xc+FbraOlmdNm3W6DTtdlfO8mJKqZlf6cet9mrav/tCyLpULHbA6o4LSnz6nf6KXiziXs/KaJWwoqN9EVarBUgOfTl9y3X+cvfIZbhuZ58cTl93wxMpFZNDMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737065450; c=relaxed/simple;
	bh=X6WvnW54JlfpI+SClAVLS2smC2BMmmjJSrvPNCsCwV8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PcWSGvEEiIZCfyNxpj2rpJupHV6BHQEZCM3bcncjA+ugevinnn+nO3JY5JnjoHDBiBku1owaozrhF+xVsCoXp/G4cd87L81n5Ivr14ENBwsommKYXCo93W/e3iCJX6sn4Nq+Daph066khKmiq6VQ42JtiGqPkTkNmBl/8TimqDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZT9M9ROD; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT9M9ROD"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7be3d681e74so120126785a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2025 14:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737065447; x=1737670247; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zOdkrk1KXIyTaCibgrl1CZBbVhSD0X9PEbOIAckWTA4=;
        b=ZT9M9RODWd906ApZOrF7TeWFLJ5809+evuXcCgPfc0mzFvfShsJKToA1rgKOnDA9KL
         Z2jwUuvWnnltuzwYVhKy4HilQhIHQoEZX/FChUFoXmC+zFHhLeHDwn3oJhfUWFdI61Js
         nAMDX36a3FRs+cAy26cnwa7SLfhe6nr1dy5j8Kjs2KgwSY4xQa91ULgzsmFQAWUQ7qoj
         +4+JKUjvT9ZcyioKNudG1yKfFscSBA2jajEF6+oJDTKM0SOj133CIGLOs63CF2ZqwpjI
         SGRwn0capf3hD7p3aqG8th+3oLi1O+oQaQ7rZFrxAWG+AxjOWKbr1/FZURo10ASJ37P1
         nbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737065447; x=1737670247;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOdkrk1KXIyTaCibgrl1CZBbVhSD0X9PEbOIAckWTA4=;
        b=dCKvOSz/yYAZEk2aoq+pck+oA0nAn/4K8wgTHNUachSE6503MAj3wqzSeAuLVNTlLZ
         yMIsdTpitK/c0pxg4VK38v2y0acD0Jd/9ntzZoz9mI3HGCmtPG7JQJC31suCL9c6Kpwd
         DWmEEKrpftQkmDNyOY3fhfgO7mC+uOmhGpG2Ms0y7vQJdenORSB921r6TXEaMlUuoxrd
         PyOXXaRvuhRHnkWGUqnfI5cCHFvvQ97flDzTQNIXkZqdyqvwL3b2BhokLr8kOo3N/R73
         Hk+1d6EEfhQBoegWmOj/rrs6zcYLRhtcjIm6eTO6lfLN1nQyly1K3UBX+2c7+vpWWOCb
         j1yg==
X-Gm-Message-State: AOJu0YxNdTwDu9z63v+igdL6nZ6fq/kVgXsC64r5Kp/N5BAioBiLAxmQ
	zk3tqWMrV1uWYSjYRCh/uyDuzYoVr/bqJoP4ey7ewVtICl7+UGqRA6PNPA==
X-Gm-Gg: ASbGncsb+o4FEkkCqi70A5HCADYUluikPCy4BMfHLwH2XDIKuLbkYCXQqPfGcpFBsd8
	f40ikPHswxbaoMW1IaFKtqGm6RgxbgN7HxCyP/3/Zvc4IhJR0bd/Pg3OMecvpbgFqEWktAnCnwZ
	lcYhbZ3DDGJ51HsBeXk4/g3eJSGSAB3C5T2OOR2xTmxi8jd+sQZxBjjdhcn62qByDYXy2jtlPLe
	8zZyKJgFod5kHm4mj5hEFS9DEw3HRkmUOCdmIhNfTvL0Vh/YoSyJl6G5/bf8MQ=
X-Google-Smtp-Source: AGHT+IEv5BoYbajg1HKwvPm+QM3EQnwXcEVXN8nqwtfMq+76HY04rVKA4XZ5/ksEVtO/NQ/bG+3ISA==
X-Received: by 2002:a05:620a:17aa:b0:7b6:c92e:2e6d with SMTP id af79cd13be357-7be63288b8dmr70708185a.52.1737065447254;
        Thu, 16 Jan 2025 14:10:47 -0800 (PST)
Received: from [172.17.0.2] ([20.25.192.106])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afc22e9fsm4700116d6.51.2025.01.16.14.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 14:10:46 -0800 (PST)
Message-ID: <678983e6.050a0220.cb25b.36d5@mx.google.com>
Date: Thu, 16 Jan 2025 14:10:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8998915110973789728=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/shell: Always set stdout to be line buffered
In-Reply-To: <20250116203900.3722253-1-luiz.dentz@gmail.com>
References: <20250116203900.3722253-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8998915110973789728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=926226

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      21.43 seconds
BluezMake                     PASS      1612.86 seconds
MakeCheck                     PASS      13.21 seconds
MakeDistcheck                 PASS      164.85 seconds
CheckValgrind                 PASS      226.76 seconds
CheckSmatch                   WARNING   287.83 seconds
bluezmakeextell               PASS      101.21 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      900.68 seconds

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
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8998915110973789728==--
