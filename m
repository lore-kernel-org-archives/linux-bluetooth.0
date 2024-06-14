Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE03015AD93
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2024 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377228; cv=none; b=lmK1+un9Xjkyn6SW2iX1xx2JsP9Hk4dDMzFfpXuHn8VLP+AypOMZrBrMVA0d+B5AIuMYPGQYQxVWRecgPdEN3LsBVdQG6zMwU5HsOhpUTnG3rHv4LyBJXfmB6dd2Na6yyMHv2jy5hPUj5223zmM5loqAYO5WjCEPKH2RNKqddJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377228; c=relaxed/simple;
	bh=sMraXrlH1NWWD2PxU64IaIFXnZM/LJfOWDTe/t8nRfQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Uu2+22ElIZSXvLp+190IJ2hxrkXjiGonSbG5pN+Evhg6M7CRhYsqbtCijGBKX57FEy7fNhgBvd5cNiuznAM1fw/FMmgt23iIJODf3Tk4Crtueqd1+oDFs5EvL7ItVm3G9n1hs5oUu3Lw6ewkw/JVRfQ6xKEmaKuOnPcjoIPz/ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxD10PYD; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxD10PYD"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-441567d352bso14358821cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2024 08:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718377225; x=1718982025; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sXdoTzdHiGRlptewY1PZ3cW3aLY8QGDNWMsRssH3c04=;
        b=dxD10PYDY537HggZXNYPztI1cfGlUzwPzVLFwIExsRs2H4+eTVJFfAJA/Cm1Q8SgKU
         MuqCetOa/0qLaUy92EVbxft3Ng7lZZ+2hIUaSBdNCzGmt5XfDUGE0nNjVJTcMRdakyrB
         Py5q0II55YxNGPiCmzcT99hhFjH6lYalX6V7nFqnXOoFq1Y/Qf7y/xBsZVGeFeszFgd2
         CiDBswqv7jvQNAmGrWta4aD40b1Dl6ihkheuE2lv0ekxnkuvL5y0I8X0mcRaRzv9480v
         djcApFaCD/wlkCsoJztkHFpWt+ikrh9USoDWHqvS9Ehmc3HVnd5MjPhi3mX2eWwca5SQ
         So5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718377225; x=1718982025;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXdoTzdHiGRlptewY1PZ3cW3aLY8QGDNWMsRssH3c04=;
        b=R0Nj11FWIHgz9q3oj6T/2P8IxcJJ8Ub3LVZ8JWngAuib2OeDn0H0d1Y8UODpv7fJ6j
         rKBCWdPJOC32ktrhiQwN6WxeCO33TCcsJp6xXazbauwzzUOACliTGUvSH0juMxCcXgVX
         6sKjXCjbbUkkmA1idVAkQo/CUnN6v6I1s+qMJ4LRNZBPGTf0u+GLCAB8oZL2AnvdC+zq
         uB1hHmWYgmlSzKt26sqeMNwk/2Ha7OLu57GbOfx4zUr2PZDQXGU3mpKRu1kwT6ujYOKq
         TyoMhItW/X/uMwGgpPV8fUPi3Bdp8VLdfNZxHLgxLGESMCUKr2rJ1VIWyIyAKy6r4pGx
         guCg==
X-Gm-Message-State: AOJu0YxhDZ4tLFVfubg6meIh4P1OvCYkJspv5Q92R+ynEKXKZ6AKJzU2
	HxbstXgvknGl7GMBgaK2In2Y0PSF/6YzwErBLVUKZiPOS/xJ3XHHZF033A==
X-Google-Smtp-Source: AGHT+IGiPZbooy6eaYhBos/N8fweOHT8qyfRdPb3tq9F1WQLyy9O5c6+aZDEmmkTaoNl583EAtcAAA==
X-Received: by 2002:ac8:5d0c:0:b0:440:607a:dcb with SMTP id d75a77b69052e-44216b27b1amr37414741cf.29.1718377225431;
        Fri, 14 Jun 2024 08:00:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.14.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f2fce20bsm16559181cf.68.2024.06.14.08.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 08:00:25 -0700 (PDT)
Message-ID: <666c5b09.050a0220.c572f.62bb@mx.google.com>
Date: Fri, 14 Jun 2024 08:00:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1667108841578165623=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ] shared/util: Update SDO defined UUIDs
In-Reply-To: <20240614133024.1299311-1-arkadiusz.bokowy@gmail.com>
References: <20240614133024.1299311-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1667108841578165623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=862085

---Test result---

Test Summary:
CheckPatch                    FAIL      0.65 seconds
GitLint                       FAIL      0.51 seconds
BuildEll                      PASS      24.55 seconds
BluezMake                     PASS      1660.46 seconds
MakeCheck                     PASS      13.52 seconds
MakeDistcheck                 PASS      176.12 seconds
CheckValgrind                 PASS      251.96 seconds
CheckSmatch                   PASS      354.20 seconds
bluezmakeextell               PASS      119.26 seconds
IncrementalBuild              PASS      1417.18 seconds
ScanBuild                     PASS      990.64 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] shared/util: Update SDO defined UUIDs
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#91: 
https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Assigned_Numbers/out/en/Assigned_Numbers.pdf

/github/workspace/src/src/13698701.patch total: 0 errors, 1 warnings, 26 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13698701.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] shared/util: Update SDO defined UUIDs

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B1 Line exceeds max length (114>80): "https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Assigned_Numbers/out/en/Assigned_Numbers.pdf"


---
Regards,
Linux Bluetooth


--===============1667108841578165623==--
