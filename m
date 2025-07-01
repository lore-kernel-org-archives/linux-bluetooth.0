Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD852737F0
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370083; cv=none; b=LY32uO1zoqzTZ9xs32B6zOuIWHRLUeQ4Q9XWfjgpwwPmR8ExXJExELIXqPMtvg0LULaGjd70bGd06b9x5mA7hh7Sh+X+BH9VOoxF+uXqM8xo9fT35HOaoLmCqQOygM41uKwFscfiCY58jK/YMABOMr6BjSl0LBVGs7K16pVUk3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370083; c=relaxed/simple;
	bh=MFPL2JXpLGNBgmmnk8LaL6DGsfVGx44LdZaqnrvl14Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Y1FJ9eaDwpGDlMZwC+ubCyLiQ8p8jv/4auIrfp+AfTXbUHfBZSRU/C99eLatzLw7bnhqrRea6MbWL8+WHNS6CHhsDZslmahMHv0zfc8H6tPeVknpvjyJTXKSWvjbWSbW3rp2qAeGzSGH1jc58RKpDHGjSNEcjouh+DLj5cqOhsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJlGwMQj; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJlGwMQj"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so2820925a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jul 2025 04:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751370081; x=1751974881; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CcRtX+xc76fV168A/5zFLwgqyq+5aJ4pIaMi5yhp2XE=;
        b=NJlGwMQjViuZRpP60rW5LiwuaYUcG85lkO9JjdtgWaKSX5SsCrjHWPDHtqYyvw0RJk
         +QPuEP2XWk+MY68V8DqyJSpeNLavQ1P9TpntjYTu2ZsLES0GMVXtjiEslwKc0lbqCcjf
         dFmzlepGkafIqk9I07OyfINNuHP4Per7PZryAjV/ScbNzSAXdg8fcokDlU8wA0cVWpbG
         6TPtxP/3u7+KR3t5JrPH7slWtYAk66o9cWBs0XI9UBk6XmW4ZGdGYcLvx4HW5yWD9guO
         pyBLpasfOZOXK5PeR1aQK3a4P7Swifj6auAAWNCXLPk/wZKX37XKSWuRlhJaQATgPfta
         2Irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751370081; x=1751974881;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CcRtX+xc76fV168A/5zFLwgqyq+5aJ4pIaMi5yhp2XE=;
        b=nIeTQMAY0GECKycVkUptuFVvkF/0uNPFpuu8OXkyXQ6GDBLFG5Mo1DW/Yxg8azjryY
         gY5+lTWzFQLPm3evDOTP84vBeQQGsCJuKxaaNs7Iz+ou4i6osmfiIZUTeCI04buPdNzQ
         Ob1RrVvbKqUXcz4uMF+WwkFZiDVqdNz6Y72n1I8snKMu/TuiTxnii76nOr/VREKqeaoK
         ks4EA70Fqn7fm86jnUmNgFeJIIP0+q71I1nIqRp625BrBtGDNf3i226BbypIUe2AvFKH
         5fICIlm+Knl2uccgHWJRBSDAYG26a22F5WOfUzasKWblVajfKYBwjulciJtwe5fOF5uj
         srQg==
X-Gm-Message-State: AOJu0YyYovoDWLAvrofqY3mxznbv2x3zu0uRCvkMaEIvcQ3/jxf8Se1E
	FTjX7EQJKMEUwRrsqf5QC4bZrk5jjKlqJRKS9HcyDNx8NHXVTsG7k/5qbfImHO9v
X-Gm-Gg: ASbGncvNz84erkY/9rT3G5i8y/TvID4FEs06GIDlwUq1tKxuXBSTzJJWyfpF/Tw57LZ
	ZfnLZAYOH4YFTl0sq3NHIsQxsYBheRpaFpLWOzib3TXcCRZwoX/hkWgYdjq7YWX8prsSSkp5apL
	ktDUGHOxE6SMdT0nREWxMrsXFn4m16suNTKxQ3LRRJTkV2QyH/mlgwulRhGmtgLzt6hVwGaJHKg
	NU6WOzAfCeR7c7mn2UOXzHyP1ebRNT6ao+peGyknE4SrIir2jF+MMYPQxD2wLJjW0fxiHvi8BmW
	Vo2FAujOgxy5d7jToPQfCGQi3WPjrQ1GIph83CT46PtJlPbdrW/Nyirwaz7UghNbpQ==
X-Google-Smtp-Source: AGHT+IGMBiPi7kwlDdwz9lg3Am1FMRra2RGd4E6W8cUIq+iux41fX79Agk6Ng3Ef2TpPQm/Uud2k1w==
X-Received: by 2002:a17:90b:3e84:b0:313:1a8c:c2d3 with SMTP id 98e67ed59e1d1-318c923baacmr20689787a91.22.1751370080969;
        Tue, 01 Jul 2025 04:41:20 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.52.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c13a3a26sm11923722a91.19.2025.07.01.04.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:41:20 -0700 (PDT)
Message-ID: <6863c960.170a0220.1f1e5.1bde@mx.google.com>
Date: Tue, 01 Jul 2025 04:41:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5035389765620595884=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Better connect debug and error reporting
In-Reply-To: <20250701101520.459452-2-hadess@hadess.net>
References: <20250701101520.459452-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5035389765620595884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=977659

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.36 seconds
BuildEll                      PASS      22.05 seconds
BluezMake                     PASS      2777.64 seconds
MakeCheck                     PASS      20.08 seconds
MakeDistcheck                 PASS      216.08 seconds
CheckValgrind                 PASS      284.01 seconds
CheckSmatch                   PASS      310.02 seconds
bluezmakeextell               PASS      133.02 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      961.27 seconds

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


--===============5035389765620595884==--
