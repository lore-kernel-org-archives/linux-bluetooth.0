Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430E23D4115
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772196050; cv=none; b=nnwI5uqMkODXdaaBMl+L16eoiCqgGjYCydz54PqgOuNbLUZi3c81hZyue2/DF67esrmCYuFw1EIKE1cWXVPbFMVERYwggbxTuvAE/sAkb4IimEdLzo1wz0C3JXzSZ/10dAfxkPD7mWSLGQln0hXTdDfhZ70vlvKrmQfTRWyLmeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772196050; c=relaxed/simple;
	bh=eXJ6DbULWi1bdmjL/6mjcIEN5aJ8H2FtGFUaWweWZrw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HiawS66vNQUCF01DXvNEFytwze2R0cN0RKrBItUn3alsKAqhU5IDdPkco3Y25XTeiJ0o6lTkOttiJFnRbdRtRu0/KUeqFNxKuuN9KG6AV8i4anmc2aQwf9p6zZ7hiRLxMTl/bmJbaVDNL6YlOWj9aq75D3lqdgGDF0R0e6qYLn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiFiUtvC; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiFiUtvC"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506a93ba42dso22908791cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 04:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772196048; x=1772800848; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4kQ/10s40jwCAcXGNyHRu/PTYGpG2eUxNMqg3ZeJCXE=;
        b=HiFiUtvCMKehOaWNPJkwZAAvZdj78gNHacrKhf08yzNvO1VOWwtS/3r2GDr1Xy0leD
         bOr8I9+uaK+uxeNZjL64qOMhQyGYOJnSx7Ss/mKToAP2TbSnmFkrj16V63KCE/AEeKcY
         F4pOgUt2CmT1ui6IQNxevhw//0l1ifhvPEqDKdK5Zq18vWDU1vbLYi2URWLuIQNpi7qy
         9QA+Tkf6n4z8JPxFv0Rahm+7nNCQNa7s9QjCU7Vt3a1U+hZpawpbl+hVVGVqeQtRHWSc
         LllFNCR8xLveMdqfHVAJxNEK4yMt8f+50VaeBuMiLmhwfKEnsxzNo7Mh3K//lbL4W+4f
         g+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772196048; x=1772800848;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kQ/10s40jwCAcXGNyHRu/PTYGpG2eUxNMqg3ZeJCXE=;
        b=PXzAE8W1I4ngM868YaeNhbDYiPKsFqzzzWzY5j8eev2w8DBmL6zAZ2PrDFcL0FEfDR
         sRqlrK6FzjDYIDHT8hvNW8s9iL/S54yfVb6fy9yB55QaaLBWZESe/9Y1v5X+fFCTL1y0
         ip1puNY4XmD+3JbwDfNxvqClxu7jrje9a+gelSb81nQ+k4beAWhoxqO341IgKAVs11yE
         Bc1JQyc6s5UF0PDW0vyLtFYvA5bLifYGWE9yfRJ+x8gd1YHjeB/4O7ntnZ63zTUx/9ok
         HeB/OQik4EHzTV/nT55MoSg9CcgPbZvRUZnLb4I8oJ4kyllANTS9V8da3DcBFVZO0DEU
         861Q==
X-Gm-Message-State: AOJu0YzMvCb691IFLTgzM9BnstDURmPtjDsjhlKEA/M3CFZRbUMO/Nr9
	6aRjReJq1kXDMMkoZ/23YKdlSBw+QQqX+k/DzJe56BXYxmhEmdeAncnX9IYiVA==
X-Gm-Gg: ATEYQzxjkelJK7VW1I7yO4P9/BWvekKJA0N96eNP11HWTVQcQrQBPnSxe9tep18NGTT
	Fr1685n9woh75CbWHmgIWpNMP34yMFZUCOgiloso11BF82XetsbHJyRxhiHujtPbpbn3pVIvoiZ
	7JwfITJCRcfFDAOWE5URsnay9cKrh8qyRAI3uGT/qIUv1A8IvysufVmiSk6wg2CHb6OT+kDoiwN
	hUeFj5c7OLVDFE7LAXfkwwv1tbqM/TcuY6tXnJcGx40GPPVgOERw/9b2OUCWmHIuh6wcxsbtiyV
	Rr4rrYZa5HxRWPabgoqKXrDVG1d7rQQZYrYAEmZFoecUbg0jmYnXYU4StJsHnJcQxOrbKbtUgjm
	wHENh36+UeuUJXY35m/i+YuEjh/buV2ht7GR6IrgdxVf79TvS9kZ5BcKwp7nzg8fE9W4SJjsTss
	VTqZs9rvTRbirjmUtFK2zJ+cBs8UV+2t3+N2TUjfpf
X-Received: by 2002:ac8:5acb:0:b0:4f4:df23:ab5d with SMTP id d75a77b69052e-507528fb099mr29301891cf.75.1772196047716;
        Fri, 27 Feb 2026 04:40:47 -0800 (PST)
Received: from [172.17.0.2] ([172.174.167.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c715ae92sm44625286d6.5.2026.02.27.04.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 04:40:47 -0800 (PST)
Message-ID: <69a190cf.d40a0220.2453af.407a@mx.google.com>
Date: Fri, 27 Feb 2026 04:40:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7719537009583789930=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Fix bluetoothctl no output
In-Reply-To: <20260227112900.1946851-2-hadess@hadess.net>
References: <20260227112900.1946851-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7719537009583789930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1058931

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.35 seconds
BuildEll                      PASS      22.00 seconds
BluezMake                     PASS      738.49 seconds
MakeCheck                     PASS      19.00 seconds
MakeDistcheck                 PASS      264.31 seconds
CheckValgrind                 PASS      309.83 seconds
CheckSmatch                   WARNING   374.42 seconds
bluezmakeextell               PASS      194.64 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      1120.04 seconds

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


--===============7719537009583789930==--
