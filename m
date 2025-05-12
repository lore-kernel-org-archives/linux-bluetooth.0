Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EA91E571A
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747065493; cv=none; b=VLHVR3mtPca4OJT2RI0XDSEhMOj84pLt+tKLkski21ATVzZKIjlxcIBdii7EB3iCxJHhqm6sOfwJgwdAQsWRD8/EXbvtOGZSsbUu0JSND04XGtE9U2R/RzhCKo/zGCwYCl8mX+mTlGNY9nmM4Z8D+et/yrEnEHMcQN3ofuRFGEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747065493; c=relaxed/simple;
	bh=cmumGZH9EpgPvhfFyPFpWEF5q/QcX1BnvptrOkKs+Ns=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GIpCTa0Xa37C67p7nC9vgVi6Cvoqxaf2YdAFjVU7TcmmayCD1kzE2mShIm8kjY/FjiEe2EGtN451FR3+nWzWgjimSU1TVnXH1MeOk0IYWDOscyAkkCfpJBMvWJcNfXXceZ7ssBplMn4f1saqmlbNNlIequnzbm33rTcjmAYATao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0AQbZ83; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0AQbZ83"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f0ad74483fso53104626d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747065490; x=1747670290; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QtEUyfYTOWsA3I66SbMJjJdfrHHk86+w6kP9Dp4zi98=;
        b=i0AQbZ83218HL1qHoyxNvCEgVQVI3ImIWAoJbsafBle8p07+3mon2Ub3Q93v0vpiPN
         MKgRr0Yc+vGonrRmuApqBdRQ0ZOgumEkXkCRnUZZHs0rZt8I87lV/xENzqyaHwGFD77X
         2KwASKjdqbx7FA0ukRKeryxn69DWNYg2Dn8f8yWZl/GGdlx9w8tRkMwVVrQoXuHM5acG
         Tkd6mgL0zyhWWDMX0XcIokoBxDHHtRN8HE8hK6FswAwHByzhAMDqK1q5U9mZChoWqs5y
         ED9XaK8TV33e3BYTMtWrEVSzZqsgRQaBkLE5G/9P7+FI72moz2Jh83yeG4FLIyo3ODDf
         PFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747065490; x=1747670290;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QtEUyfYTOWsA3I66SbMJjJdfrHHk86+w6kP9Dp4zi98=;
        b=SzNaLfBfvcW3/SxbDSskmCQQDvD6+Bsreg5TxJk0b1cCNjeN8AkCw7WeWpdEaYjhCF
         GepESnK53CsSltHXTerdnhfbntNF2WZta6aFTLXjVKY90axBFdNPd1x50AFdMlID5dHs
         VcX4nu5Fp2mQyaNQ5xz6Prt81LCKlq7ShSkcOuc1jIu4i94SloseDhxKz3vtzTFYtuVW
         cPag/dXE0Lfes6Fec5lheu5lyouOzhjPLO+psoodkJ2ixwsWENep/k7Hl9Hc8OJvEwwu
         T9nsSrzopO7G+H9bvSQqjZh9HTYhvaPhRinhkGWQktgwW3VvAXShJ05gfWwUPoXu/+2M
         pT0Q==
X-Gm-Message-State: AOJu0Yyp3I2DUFCtuZ13Ner4CUuGnbjffvmOA/KgX+fZzIEyPvkJG5Yq
	oHOnW/eJuU3IhHSeH688q7Rr0MeZ/QzUQKOGOSnyor8ovCLWcagugn74Rw==
X-Gm-Gg: ASbGncvWX9hZp2j9vNkLU4WUo2JxYHBvFAvowZT1LF4OwijUJ42iTxkC+O4fOJXvhhJ
	0Rj4jR77yi2aiBxg271zCtQ0QAc7rk3MrJVOxhPXHIAgCns0yoi1NWKjwpTjTK/VZBaH5baEwrT
	L5nlsNfLWKRfiq+gWGGK8VXkSbnXlCj4VJRY8UGw2Uq85WRWfslVGPd6KldNKJ82JQ5xm9qErIo
	665UIPSjn20+kP3BDHQhnLUEUj7EecQcayLp/Ux7Tf3oSgFInUeCVrOp88NfztknT7s4K1nLdRK
	BQKque3hPBxGrWmNCQNNAdn0b8A02Yq78+91PL/covX8zXb3EqLslxrQ
X-Google-Smtp-Source: AGHT+IHnimvlzoHksoYdziFlYytiG4af4Q8OKgm+mjQBSF/tTkm/fx4298AcDMc6aDNJVT08B8mL1g==
X-Received: by 2002:a05:6214:5197:b0:6e4:4331:aae0 with SMTP id 6a1803df08f44-6f6e47bc67amr191997216d6.1.1747065489807;
        Mon, 12 May 2025 08:58:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.15.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e7aa0bf3sm45675166d6.65.2025.05.12.08.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 08:58:09 -0700 (PDT)
Message-ID: <68221a91.0c0a0220.2cbe25.77a5@mx.google.com>
Date: Mon, 12 May 2025 08:58:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2625515513873173459=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sanchayan@asymptotic.io
Subject: RE: ASHA stop handling updates
In-Reply-To: <20250512143408.283938-2-sanchayan@asymptotic.io>
References: <20250512143408.283938-2-sanchayan@asymptotic.io>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2625515513873173459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=962080

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.49 seconds
BluezMake                     PASS      2692.76 seconds
MakeCheck                     PASS      20.72 seconds
MakeDistcheck                 PASS      199.22 seconds
CheckValgrind                 PASS      276.84 seconds
CheckSmatch                   PASS      303.31 seconds
bluezmakeextell               PASS      128.79 seconds
IncrementalBuild              PENDING   0.22 seconds
ScanBuild                     PASS      911.53 seconds

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


--===============2625515513873173459==--
