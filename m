Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E541AC45F
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728931116; cv=none; b=tye8ttyWqm6l8J6FaGYaJQsZo/qmMRFUCJ5OD4KFJ7WMdc3CF6dfiq8b+Hab2/tiys4p9BoGmd2Fhb9xNY2wOpqvABam2FraNgTPqJgXRWVzwFdapgd3I0d7YGAeG52qKJ3C4i1LDoJL30uKcYoiTYZ41CA37FOpKKrZjCPZFEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728931116; c=relaxed/simple;
	bh=vPZADj3C+RN5aLkmgx/5u2rzO5D54ZeqTgP4xCGQMnM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gy9OuZxGulduyd02z5wuzlmQQ182PqhoCT6NlzyJ4Z6sQjQCOyBxq4U3BOO6Ly5BxxdVnpYDpwULvFdxlL5hZzq4n4afHF5q1+lnuaXJqKFGjODUKMEyKIc6kOMIji6s8Vr1U9aYoDTyjk8Vy6LCNPYxlGVcXlIA22oiHGx3g/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNsxN4Km; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNsxN4Km"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b5affde14so26706965ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 11:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728931114; x=1729535914; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fn0e1qHcia84mbrAMMwfWmByjKTMmBPewnig9UVIAsE=;
        b=kNsxN4Km5/FA3mrG2CIvFuv6jAEM199gCuN/d06mgUhU/8HvrCsg4gSJawOvIenb1c
         3QkzylmwDbr+J4cXZ21qGmPjDo+bP9HN32gIeqZibIdmP5oknpiL8QNeiHKuAtJKBilW
         EP7M/sNey39bNH8/SMQ/rdBOQ284xlgXe3d7hKgn9A9n2cg9B9GMr1xpYax0bdSel9qf
         L6goiG5PXrPBfd8H2AQWJaMaQ1/wuE2zrCpjVuL4bD/VTWNlVwXEfkEFWx1cujbqZ6wb
         sKwqhE7Y/POS5ATV6yrxPINkO9vq9WnCMzVaRGRkBFAq+4XNujwftSs6sB8t8ggF12cL
         AWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728931114; x=1729535914;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fn0e1qHcia84mbrAMMwfWmByjKTMmBPewnig9UVIAsE=;
        b=Y51p1KLhaj6tNKsdjepBMcrqc8TEj0dfdAK5pINhIIk2uxnQp7MZp32rt5sDcPxgi5
         WozPrpFwbWlyGWhgsDAkEh/8yD4HPo3OVAoiNhoCohGee1H8ZqQP20+D9HZfHZh8auo+
         FljzT0lmnoAKfzgWkUD1fDX9RWx80mJrtDNjwtgGZyHKEGJRut3XrXicRmjxVq6M9RUF
         DmcIMnSUaOi9U/W9BRZbSDY0QXn9+//m1aBfVaeXYDaLmQNxowzE17j19XxRPca67Esq
         h4myv9XuReZ6ozrVXiSBAGuEC2tt+ZKibb063EQiTSusJ+94W4lnkNYd4WAkDLiA4eZ+
         hfoQ==
X-Gm-Message-State: AOJu0YzL7lhQI1Pql8ezf0bSFQUQ3OzQQ87eIVNA7f2vWwe6yeL0rIYC
	UO/QjJ4H8V78eClYolm6oES/LFc9SwQhDdjCSpIOzLdS5zOpSCx8HA01Ig==
X-Google-Smtp-Source: AGHT+IEDn+XEwWw6TmpdEZ2jLMS1h55G13CjJWo+JpxGUstn2UTbrsgFfcxiYKucPQYG2NEhN29tTA==
X-Received: by 2002:a17:902:ec91:b0:20c:9821:69a4 with SMTP id d9443c01a7336-20ca1423b4bmr192332645ad.6.1728931114034;
        Mon, 14 Oct 2024 11:38:34 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.26.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0eb470sm69094815ad.126.2024.10.14.11.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 11:38:33 -0700 (PDT)
Message-ID: <670d6529.170a0220.17ab24.3439@mx.google.com>
Date: Mon, 14 Oct 2024 11:38:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4835387026025959291=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v2] tools/obexctl: Add support to connect using PSM port
In-Reply-To: <20241014171058.75235-1-frederic.danis@collabora.com>
References: <20241014171058.75235-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4835387026025959291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=899000

---Test result---

Test Summary:
CheckPatch                    FAIL      0.57 seconds
GitLint                       PASS      0.18 seconds
BuildEll                      PASS      24.55 seconds
BluezMake                     PASS      1596.25 seconds
MakeCheck                     PASS      13.23 seconds
MakeDistcheck                 PASS      178.98 seconds
CheckValgrind                 PASS      254.85 seconds
CheckSmatch                   PASS      357.12 seconds
bluezmakeextell               PASS      120.50 seconds
IncrementalBuild              PASS      1418.40 seconds
ScanBuild                     PASS      1019.71 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2] tools/obexctl: Add support to connect using PSM port
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '5d7d3ac25bd5', maybe rebased or not pulled?
#68: 
Since commit 5d7d3ac25bd5 ("obexd: Add PSM support to session create")

/github/workspace/src/src/13835327.patch total: 0 errors, 1 warnings, 42 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13835327.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4835387026025959291==--
