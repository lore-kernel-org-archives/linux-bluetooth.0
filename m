Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8556B33FE27
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 04:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773894289; cv=none; b=UFax+/NNPB7lGGqO2qs1Wez4gYVLVRYbTlp7ftgFALlJzhJLihhKdC/wecAGZVxlgCKrpE6SZXJGnxs/Lrrk+ZL6O2k3YAP/7uIKbPEGmUWXEX/0F2vFO2MSEBJZc9/qv0qUFhcaij5mf6Ac2cpmZMQTlenD/vw2UFILxhw6ERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773894289; c=relaxed/simple;
	bh=vpcnlwdu1DnLot0N58wAczZxP9OiM6QEp77fSxzTwBA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ecuX1cVQNES+dBWhiztpKw/kp/V3mIOucWuXnGJPvvCJ+bPaSGWYGgDJOULtoqWRu1z02U9Y2R0SC+1a+E/D0bFUjfJPg3WUHvzpUtITkOn90VAHXjsDp+Vjw43nl8BFV88JR3oMrZKx8Wh1kh3zof7qtxa+tDUWr1PvW/Vr6sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtCFCztm; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtCFCztm"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c0d36f3888so773321eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 21:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773894286; x=1774499086; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dbkIyzPlKnI9YxacBnUt40yRx7ZmjEk3u+M/cFC7Nys=;
        b=PtCFCztmb2K9yP4+hbUV2h4hU4BkjFzUkDLA6boOEHYLG628SV0aSaUkD0y0n7gcUl
         Ip8Oz39RsM7TkMzHhLXV08eMLUbcSj7+vR6jcTsOYAcmR0BBhzFI7A+WbtMNACnWlYML
         +FTi47eoIRHbUoza+YAHr1lNJ7b7qnP3+FN+EPQ6HrTw/JmSqfkbn3lBEmdXOF8yCj4C
         VNZ2DupaCL0GEsMiCe8vwJnHASOWVOUr2BT10+WfXJVvl8ecsSrGiSm7tfTUHOUZMhLh
         g/515oXVXEIVLZ+ne9KxXWpjCr9MZuK3AX8CnXYLvw8DU12zsADxK/xrfpQQ9uNH0ugv
         kOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773894286; x=1774499086;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbkIyzPlKnI9YxacBnUt40yRx7ZmjEk3u+M/cFC7Nys=;
        b=YRfv5qaC9DVM21Lgx2ClCjAUXfKT+ZEII9I4OpV48QOw1Lw5L3tYEZ7bV/Tfu9sq7q
         5jxY7dXqxZwfWSYPqHgi9rCxxmakPqUmtH/rQ8aUM/RsvN66wtou50Z/OFG5M6JhTGXA
         alZW9gcrbTj3ywP9ts1otXrKicoufF9rKES9nppJ++Iaeo8gdQKicohZT8shY/tpQHAX
         xx8TtQXM/q9R/Bhjm5NtpliZR6MiM5qxx56I/H6GvM88NNK5RiKymO96PAMOC0w31WlK
         9oU4UnAAW93oqY7o3b3dO/7tH2zAVfi/40wSYtXU0T6eM6DMQqVEAC+kpIJ2koA+jYkT
         LsSg==
X-Gm-Message-State: AOJu0YxLrW2tlJMZ48RUCoGDLxROs0RBgkIzwD3qDFIWgwP7Unwtquqd
	chygpJ/jsWl1WkLDgQpRMWYTyePu3ehBxJFpLztSZ+7xwswCI1sx3jTMEWNurQ==
X-Gm-Gg: ATEYQzwvSZAazP2r7hkESIZiAhNxnWJbhg0iveevxbwYoleb8srAr+5KBsEJz6tHyHN
	K/tGOpG1Y2Ayof2J7SZRSp92wJxjyG5Z76mRpXJdcmMwNAna0amEn8cWQKK0LJ412sNWJyWunvs
	YV3Rwa2SgrFLqb1L0c7o7izZ0pCh1mgZgi5zQ3/n+AsnCsIJY+eeejtCKP6xCfwfLTzlngpw/bc
	b56sUlBCGYLyqznutH0/8sVDdVEu2yT2pLV4a8WLOq1L+hTrSlLcS4WJanI+aAOa9dERO3/mr3u
	WN1oEOsCXwez3ZrgNYGgMvR+uSnBFKoRnUDunfixsQhxiUGAdYiDIhqveNwI2DafJL1xvvQme2q
	r0DJxFUZIRHdlBHigTlRwX+C458SBK0pIv/jU5tB5IcS4smfFqba64DRWW06N8JA+NrleeCFadt
	dpH4c3OrFz4SpJmwxFlavjAiT6RYVUeys=
X-Received: by 2002:a05:7300:a890:b0:2c0:fb94:525b with SMTP id 5a478bee46e88-2c0fb9459e3mr303299eec.19.1773894286305;
        Wed, 18 Mar 2026 21:24:46 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.200.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e5368a7fsm9639106eec.1.2026.03.18.21.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 21:24:45 -0700 (PDT)
Message-ID: <69bb7a8d.050a0220.31bcff.da59@mx.google.com>
Date: Wed, 18 Mar 2026 21:24:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2517939171539427554=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wouter@xesxen.nl
Subject: RE: shared/shell: Fix SIGSEGV on invalid input
In-Reply-To: <20260319021645.2137513-2-wouter@xesxen.nl>
References: <20260319021645.2137513-2-wouter@xesxen.nl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2517939171539427554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1068955

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.36 seconds
BuildEll                      PASS      21.23 seconds
BluezMake                     PASS      633.50 seconds
MakeCheck                     PASS      18.51 seconds
MakeDistcheck                 PASS      244.32 seconds
CheckValgrind                 PASS      291.23 seconds
CheckSmatch                   WARNING   352.53 seconds
bluezmakeextell               PASS      181.41 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      1008.74 seconds

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



https://github.com/bluez/bluez/pull/1970/checks

---
Regards,
Linux Bluetooth


--===============2517939171539427554==--
