Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF80A1F4CAB
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 May 2025 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746380201; cv=none; b=ew3SIMT/GAeMHwwRHR/2tf08FDtMXaD1FvB2bfBUmzLKWFkuhsa3U+VGiQImSzmHYPX9jNvWRaccc91nobNWpF1BnXC7jGluOK2OdppYDN4F71HWHxcQwE0mk+WaUxldvVVjURdfJ5DF1YgHz9KJGI0cmx0yNf5uYORLf2K41WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746380201; c=relaxed/simple;
	bh=8sBG8Lpw2gP9B2U/wlHVJNQ8Kcbp3LsPORgohn0iHx0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DrhLhnhtQIlAsDxIpPg++VAmhw8PDipaVIbNRUyfYIvFZGi7VXufJNFLANfvWMgvTk72C0I6Y9S4s0igAiAJWampSMc/LQxc2qXG1WvVz/ePbHplYlIzKugTxjMLHjcXGki5dPlLLvvtN2jTjx6rv8nk6E9O0jb5zoaiGngTlwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhMzH2YE; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhMzH2YE"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4766cb762b6so43656721cf.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 04 May 2025 10:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746380198; x=1746984998; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yhLE2JnfdlIf3EZ1GaGGWmgRZsSQmOk9gQVuih7bA5Y=;
        b=DhMzH2YEVJZcUlf0iGX2zHAcJYsvgH9E343N8eO1FMPJMqYQfkiNQV2Jg/FZnlCHjW
         H38dAyp3itR2D48fVmLdJkgTpmMR7DhV8tCX9mXX7OL/eoJx3oYdlGmHE20paiG1MJSN
         b3dfRPY/R7ZiLpoZPMCU8F1J+lj0s9RTxxq3YJXshoBxVQmFTjxQQCJRKzv6ENmNKPKf
         FYra+cj211FAwPu+Ologhj9CXrg60fZo1/c+lviT1SYeKMOCtp9PtzAZutipwIisjRkB
         MbA+pNSndTl6yvmsYdVakh2uqsyre21D5gzqETIR6ZU68bby4cjHxnd28P49kTpmy2vv
         N5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746380198; x=1746984998;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yhLE2JnfdlIf3EZ1GaGGWmgRZsSQmOk9gQVuih7bA5Y=;
        b=Gt+6AXtOouP/gjfhPTAgUkMTPlouXYBdP+gOAOVZl+d8k5DzmBXStM2A5EWUW+af1X
         XQnAOs9Cv0pJPmdS0y3H7/usvnl4yNb4E7Mqp5fRi5vOqe5UbA+/WJL0VjjMuS21EBM5
         9pDKM1WA2e16FHAp2+T3fiBzycon+fUTINF7p2nSsNWgop5C4zIdE4fcEMYE8GwJaMxj
         tS4e8OkCv2xFuqBjNe0S6Elr7Pjl0xoD+XUTLhYRLoav/G7ZsQaXOOirZ2PhQ5omAhW2
         hUey3/fwT4/Us44NIZcS428GkY2greF9rjeZsQZooGAwxVE6ANcwTm2IC46URPVyQ9CX
         hvRw==
X-Gm-Message-State: AOJu0YxHQUwzPdRuA5XH6OUNsXqEPNybT/Sd2ez1ajEXsmOfwQzliLf4
	VT4aBgdYDxfrFM/FMkYrVYQZOZ41HVbuIPxeAMvQXu2ry+c18QVQJOJUhg==
X-Gm-Gg: ASbGncsCIkiWZ10n1P6vuGsadG88uhhYFVZIjU0RUkabwst/FDLyEWtk1CkB33mmhHA
	sJT+r6dyYhmT5dY6x8dH5z5Xd28KAjAVA27mguMLKmFccy+B1V5mKFWmnUegio4E3ZGt7J7fUn5
	p3bhG8+B5zPr8rM0O6+lJO9whmsrOr8VZeQ64GhCcd76ofc3yXbm8IzT4aMmbTyrP63mCD/6IAx
	TtrttjiPE0lLXWD2fX2vjJD3PscO8nvnMXmp/4gbOm6Fmf+fL0ZO5heCIcKAOQolTkfle3JrAGR
	OKv/pQHjO1UMfpEk8zWOHB1fvu0QtsMyduYlTiCDHwISpOljNQ==
X-Google-Smtp-Source: AGHT+IF/xN8S12lv3w0agPq67T39krHflVycfHtTEEVgatSQK4dBOznNd2mqd84u49qZ4+R7lm8Vmg==
X-Received: by 2002:a05:622a:a1b:b0:478:db63:6f51 with SMTP id d75a77b69052e-48b1c2eb0ddmr192629001cf.25.1746380198484;
        Sun, 04 May 2025 10:36:38 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.133.167])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-48ecd0405a1sm8372171cf.14.2025.05.04.10.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 10:36:37 -0700 (PDT)
Message-ID: <6817a5a5.050a0220.2072d6.540c@mx.google.com>
Date: Sun, 04 May 2025 10:36:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7366907296225883962=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [RFC,BlueZ,v2,01/11] org.bluez.MediaEndpoint: removing BAP streams with ClearConfiguration
In-Reply-To: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
References: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7366907296225883962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=959452

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.62 seconds
BluezMake                     PASS      2621.64 seconds
MakeCheck                     PASS      20.06 seconds
MakeDistcheck                 PASS      197.84 seconds
CheckValgrind                 PASS      274.37 seconds
CheckSmatch                   WARNING   303.13 seconds
bluezmakeextell               PASS      127.66 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      898.75 seconds

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
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7366907296225883962==--
