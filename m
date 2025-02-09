Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B7E243392
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Feb 2025 12:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739102708; cv=none; b=BgJAlOHT0QRmb26KRWKKoikLDE9uadaG6GrostFKmkvN0tDG12OSkaYLSJfOT52rJPkuRnRE19Tbg4iCXPQ5fZg7NR49M0/+qUFjepEua1VBi61wGNl5SQZ7JW+lqsc8OZgACPN6LNd7LxZLhe5pgelfwbIn0okNU4hTldGanec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739102708; c=relaxed/simple;
	bh=TGVPjWmobRzGOHmH0aDgpQ1GQJEX66kIxp69BJJbf7A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NXSYDd3amMDZJuGL4fAC4CmDGwfRBjS4IwmQGqEhe93dacsd8yXIp/8JVI6nPKmGi6I10cn7vDDSfKMDSatNHiBuwmDavGfkFjNQNSnbl01XyGuqlLrQpfjT+hIPnxJKs/kuTDT/92LW0q0mPUcaqwevBiELJSAlG+tYWdt0tWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgPqdt5Y; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgPqdt5Y"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c05b91245fso13334185a.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Feb 2025 04:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739102706; x=1739707506; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rmNoF7FIWjUsUE9iUpf/QUZyBrBkAll5viKi4FWhLKE=;
        b=ZgPqdt5YuqyRr0MF7JHf8aufpSeGobtjNAaFY+TCJ6zLAEyELtg1iyoDF84csL8rAQ
         XBCZnveM7I2T/07eL7WhgjuZeK4EikvN8POPuF/9tZte4xyLMT0HX2WtI5GwUoR2ts+I
         wegsUobOmEpXCSe2UFvxVzoTTz7zwEe6TKexf03Z0DLsh6IGxKH9h0h1TgBWANGWT+Dq
         FTXQCKAqrbajmGJCYPJm0ceHANEqak/spO7L2wrpjw2psB5uAey7UjbTadsSudzwLYe4
         uI4UlsEbOo71vemYiHPxulb83+lgfu+CMTJGHPcqy04zPtGLpizxqzAA7MQ0azRx3rNS
         xAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739102706; x=1739707506;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmNoF7FIWjUsUE9iUpf/QUZyBrBkAll5viKi4FWhLKE=;
        b=KEKxBcR7/T73FQkhJ3cqez+jgWjmTQMEWRnWcjfIen/9oEh/6CZPLFZPepL+hzwkl+
         PFRYSWolM1oO8Ur8AxUirYeZO50WRRyGEct5pnFWPpVr5Sf5zmMA59g0fY4T6F8UB5RT
         zNfiT3OyWmUbPx2P2p38jr/E81goUDT2eShtHgSq74QRRl0x7G62TdS1o8QzDeUyGdBZ
         MklOPbUmt4EtMXJXbPy9CXau8WvqTq+0pMgSIO7XrQ0NMlSFWNs5+9LDJa2CA170MHHg
         bV/JveNZNWhJPju6OWXZofI9CtxyMBxLmicnQWy2dMxl/uz6oy7mFln5ZVQA4PBN1vNg
         vORw==
X-Gm-Message-State: AOJu0Yw4Eh+vJDTfXqBigqE2xU1HCM6I+G5P87DXMQ9A60IfjhsRMWmG
	Q0CurcuAyiUW8Ab2TYVwWL0Rw+y4a6sWCxXFGLuktv2EzWDr5AsLI+Edxw==
X-Gm-Gg: ASbGncsBWKThY5gF3rQIxzmOZSqGRsvNvyYQ0Bo6tP2R5rU/fA7Gk8ISvW8FBrjnQz5
	GpMS5OTLi8AEfBOB/BX7CgsuH2XL13aP2KXQvu/mI7SKm6pvijk4rh9YKnegp0fXMO59++3q0i3
	o+5Pbk5q1426J67BDVgX/VWU2g9+G4IPnwO7HZrDNHRfYZ2AF3iAr+SytWhMZhKmEhQNVz6+bUc
	hjc3wy4Tdq12cIDDjQ+06+c/Y1gDtWy0yFL9ZBEIaL0af2dLnLgfbMEVD/hkmHnT/6h4kY3N9pN
	cg9Q+zMSdY3ZBJu+JCrbpA==
X-Google-Smtp-Source: AGHT+IGqou8qlkbrLxP779dwia2LCNaUOFw9eXXbZQStWGy3FUvdSekQkW4qsaDzGr7teV4H8ViWmA==
X-Received: by 2002:a05:620a:319c:b0:7b1:543d:c99 with SMTP id af79cd13be357-7c047bbc966mr1386064685a.24.1739102705747;
        Sun, 09 Feb 2025 04:05:05 -0800 (PST)
Received: from [172.17.0.2] ([20.25.205.245])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041ded11esm399981385a.19.2025.02.09.04.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 04:05:05 -0800 (PST)
Message-ID: <67a899f1.050a0220.79452.f123@mx.google.com>
Date: Sun, 09 Feb 2025 04:05:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0802097213026698798=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: tools/tester: update TX timestamping tests for COMPLETION
In-Reply-To: <4449644d9883f313fc6ad883f56fe07420815bf1.1739026302.git.pav@iki.fi>
References: <4449644d9883f313fc6ad883f56fe07420815bf1.1739026302.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0802097213026698798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=931990

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      20.89 seconds
BluezMake                     PASS      1465.37 seconds
MakeCheck                     PASS      13.16 seconds
MakeDistcheck                 PASS      159.50 seconds
CheckValgrind                 PASS      214.74 seconds
CheckSmatch                   WARNING   285.83 seconds
bluezmakeextell               PASS      98.78 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      878.47 seconds

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
tools/sco-tester.c: note: in included file:./lib/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth.h:237:31: warning: array of flexible structurestools/sco-tester.c: note: in included file:./lib/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth.h:237:31: warning: array of flexible structurestools/sco-tester.c: note: in included file:./lib/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth.h:237:31: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0802097213026698798==--
