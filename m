Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73781B86F6
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jul 2024 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722088306; cv=none; b=Fntq2jPMun1PSJy40KkJ7oj8f1+cfVMcH5WJBCau1uKXI3Ip1C0gUIs+TB7fqFWUunSaKUh+0veuc9/vYgf6ea0MMLhMtoqpwOSNMMgWEK75aKi41crBFdxfkbP+EM2WeeNTtA+wGgGg4V03LANl4i4Tb8xdkZNAa8g0AdshJ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722088306; c=relaxed/simple;
	bh=ac/9dZHzWJajhldaMv4SPiBP61sDLusscpfgYV1fadw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IIsURe9DMoc0N1YWboIk8AutZjoKIR434Xsr1eaj4/XyT6Dz6c65gyX3uVj8M8+TAhyWKCbYBP29B75gcA5wXth+awf3ekoW/HpxVwrBY3RmFn1WRe/pKhbzvy276ArCYftAsKDFsypWeNDSFWu3q6Bi6ewbMh4s+5PcZX2/siM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgiGjplV; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgiGjplV"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1dcba8142so119920185a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jul 2024 06:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722088303; x=1722693103; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=prRU0gYiTo8W1JNz1NyCp031kw7ZSnlTB4Ql8c43RT0=;
        b=MgiGjplV/xJzFJkSvPhTdR1jlichKZ9Mz4QN8SOYHYFwLDkBL0LrPVClXxvaugBhEx
         27e0jx3htPE5LZeQcJ6GPZcfvstT+TF2uKoLTfIO9JC8MtXawrtuOPC2dcTBaMQYF49A
         VBXHuyVPW145Po69WqNDApT6tesM9UjPy/UlCjIuolpz5u8CfMI9r88yBugjVBMUr4NM
         4A21XlaySYz/Sbvw7JhLymKJl6yzYcaSILSoF5eh+emW6zX62Zt/zkAveqvkLemlmZfv
         w69GksoTIcNJthUcQaaSimE53K/lgMx4mMtmEY1hZJT8Q6CXWTYD7wOgfIRj8n7OOUWq
         okRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722088303; x=1722693103;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=prRU0gYiTo8W1JNz1NyCp031kw7ZSnlTB4Ql8c43RT0=;
        b=LzZusZbLtgoJQsXjzy47RrG5EH/yW99ANZ7wssOEZMp1tAyKEMww3JGrNs7/PeW/g9
         z3XDpSs3gIG12NQ8CShCb3FndWLzlCibRbnFZPMv2mVAugJv43uszGfLt1RhpI4nCk3m
         DdN6Rsc0FTNf2ykZBHo2xSB3LAxzMesjNCheMnMLQzE/kYnfQwHR2QESxQhn+YcCbhcu
         gDC9G4iANMU/c8i1Uhku23FCJ5vtKZqiOnt/XYNjgOOpbsJkSxuRlAkFm79EOiJm0RUj
         ee4wYUhP38jD8oAZ+ljIeodSCKEOMuR69nM0oC+SGf229aU1KC7OsE0hvY4geStSRfi4
         DEnQ==
X-Gm-Message-State: AOJu0YxbZj+0gtgo8Kkla6ZkO6/QMSvXADZofHYobfW2ijfkT+QM2TRI
	884YZKXjqMUYkJ2FnsHupNiEDbdOtopFVxvVmjLnNo72hxarJ8oj+NHXmw==
X-Google-Smtp-Source: AGHT+IGCBAYpxLtiieRrndjR30wafoRta5OKegaRVkfg53OHyPj9r47rL5tDP2xZQ1cEDjcklOEIpQ==
X-Received: by 2002:a05:620a:2454:b0:79f:4c8:d873 with SMTP id af79cd13be357-7a1e569f983mr539369985a.28.1722088303356;
        Sat, 27 Jul 2024 06:51:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.78.58])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73955e2sm303083885a.9.2024.07.27.06.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 06:51:43 -0700 (PDT)
Message-ID: <66a4fb6f.050a0220.7d9f0.a366@mx.google.com>
Date: Sat, 27 Jul 2024 06:51:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2497659720538877208=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] shared/bap: improve channel allocation logic in bt_bap_select()
In-Reply-To: <81bcbcb669a6f329b7900fb0f6ff0c469ec7201f.1722082241.git.pav@iki.fi>
References: <81bcbcb669a6f329b7900fb0f6ff0c469ec7201f.1722082241.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2497659720538877208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=874247

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       FAIL      0.55 seconds
BuildEll                      PASS      24.57 seconds
BluezMake                     PASS      1648.54 seconds
MakeCheck                     PASS      13.33 seconds
MakeDistcheck                 PASS      178.24 seconds
CheckValgrind                 PASS      252.49 seconds
CheckSmatch                   WARNING   355.20 seconds
bluezmakeextell               PASS      119.94 seconds
IncrementalBuild              PASS      1421.31 seconds
ScanBuild                     PASS      1003.41 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] shared/bap: improve channel allocation logic in bt_bap_select()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B1 Line exceeds max length (83>80): "    src/shared/bap.c:foreach_pacs_char() PAC Supported Context found: handle 0x0053"
71: B2 Line has trailing whitespace: "    "
77: B2 Line has trailing whitespace: "    "
83: B2 Line has trailing whitespace: "    "
87: B2 Line has trailing whitespace: "    "
90: B2 Line has trailing whitespace: "    "
93: B2 Line has trailing whitespace: "    "
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:283:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:283:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:283:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============2497659720538877208==--
