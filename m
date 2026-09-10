Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E0F4FB9C9
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064013; cv=none; b=TeVphv/HFCKOGT19YACPDDqODkrJA6YyHKGrY76xLhTFfM7PRNoBo2XxYLPAI7W4OQlG7ts46yCI6BqWQQIWWTdHeGt4ElRFHGH82wNuUZnXpPfrq+g7BXgb/pQiTe2bXNT5uBMcUMLecOXciDbJQnHhnavkSicwyebyerSIAh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064013; c=relaxed/simple;
	bh=uPc0503gMvNZS9g5PLr6fSJCXegbJCJQzhv29GQnyPU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=C6WFHTQB7tT9A92IrmAzf3UFE0ifSPiIReWu5uZdmUgIOGBcS2RMax/kOFlxj0qUD7JU/GEw8F4irn5cayA96Jkr7EaXAp9kLh5Q7UzA351G5hBZg8bwO+aH5Sl5nSvbgOJz1XFUqGURtKMFv2tGigVK6UtFLmVV1eWPh+ChtSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABOVelDG; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABOVelDG"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4c0cd10d56fso770171b6e.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789064009; x=1789668809; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zf0sFFHeYm8dzGwQ0IJAh2NaIVYOxTAxyp2x5A3MPFE=;
        b=ABOVelDG9xLFOy9AM4Q1xtE7sEZOpEGy3mhje8zl380FdtuzApG6VriMh8B2CV+xxk
         r0HrI4Hni5SrYFr8ty4H13OYcCdpbya48MbrUQTD4VoeTJcGma00yEDRWgJjo6hE+TLI
         NCP/kE6XQnOa/2PXeF27NsopS5GM4MAZq6YcffkZ1Qf/Zi+RX4fYP8HkrCCAdf7CB9aQ
         uSNHX0J0nW+7ovkQZIkhx5VSCyiQkSTvcQOaOYQA/fRjhwuFulP8D5qxGKhoW3Y08cR8
         zvjI44On6NRUFH9DbZbINt43glcSs1UQneLNpt1OKWrTqBHExmPgbmNAKC00xgamQVv/
         2dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789064009; x=1789668809;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zf0sFFHeYm8dzGwQ0IJAh2NaIVYOxTAxyp2x5A3MPFE=;
        b=FXPkM+aUZ/MYMmF9WdzPyRPQrmSR9zx6mk8JJioOdJEjNktv337dzEoAUs/rOuEZXh
         fnN3cOm1IeX+b94NVY2yJwIxDZOHrWkqnRtKkEkdepl9YSnO0Ld0w+Hz/qy7jhJwRAMm
         7JJvNvarpQwFM+LK5SWXf/iOQTMmbmau+DYJIJ8Y5qnXOUfNQqAT5stmzQo8tfaISE//
         4f3bpZ0neGEJlmGAm43vSA4BKMZge9y41OGvfNB3bfiqBb7aaS8gbskQxxL+8mjXKzyl
         TEfGfdspbnQFxaZkHZD6lE+GjZ4um1aFcDM0bLe1Mjah8oHbOmvVmeiIZM7VLUbFq/Ci
         BlWw==
X-Gm-Message-State: AFuF++nGQPudJqX45H2dsgfphq/YTYxXKmbaWRRyKEUbk4+yI2TyAT5V
	q3EMg/3pN2EnpNw9iacD5rtig1GIj/JFt77EMnCS2bJyL6wKgHR7Yg2VsvhzLN3S
X-Gm-Gg: AYBFou3gQrN5vSa5t//N7zn9z+FbUimqEjjE/vP72iffVEcD5j93Ft+WhsuRwoD9HhV
	v1sEXnKZYkLJt/sdyw+5O3N/d4/56xf+6HS1BfruPC3dunSm/YWwwcGQdaMA1/9pgogpLwXRDc3
	PbVlTY5C+O6ueOvH7hT1GkY5ahjxRkYtmvOD9laarHKAclk7jtgYokYyt6kfw0ye+OxQ648Mgug
	LMAjCsgYwgNOdxA6vnjLMKJuhBI/67asKFXQr+93MW+zzn+oX/y6dyecmXfDSFwXA9WtypUqcAF
	kacNsFpcl+JkuHZY+vtjtLEitSJ2O10hkIjb19a1+O3amlk9qxRg4Q26KvrXBA0jLkMMIs11Fam
	FovrierSofy7B7UZRqf2/ZTbkadXJRmrY6YQxaRGi41Rd+wGbBKjMs1JJIWcYW/Hnc/4j+a/DB6
	nCC5dPxiMzuBxdj4KWeO9yc0veowmsgOJCKzyAKXdLHOyiB0uw3rYpAc/4CSk/lVs1ANEOd6aG1
	BjbuA==
X-Received: by 2002:a05:6808:d4e:b0:4b8:4703:db94 with SMTP id 5614622812f47-4c1a8aefbabmr2905837b6e.29.1789064009409;
        Thu, 10 Sep 2026 11:13:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.118.29.121])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b970d1ff95sm17068189b6e.6.2026.09.10.11.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:13:28 -0700 (PDT)
Message-ID: <6aa2f348.6852c33c.2f604b.7486@mx.google.com>
Date: Thu, 10 Sep 2026 11:13:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1733253732007525614=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: plugin/admin: Make allowlist adapter-scoped and enforce at runtime
In-Reply-To: <20260819144337.889893-2-frederic.danis@collabora.com>
References: <20260819144337.889893-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1733253732007525614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1148530/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.74 seconds
GitLint                       PASS      1.68 seconds
BuildEll                      PASS      16.95 seconds
BluezMake                     PASS      227.61 seconds
MakeCheck                     PASS      12.94 seconds
MakeDistcheck                 PASS      98.19 seconds
CheckValgrind                 PASS      153.35 seconds
CheckSmatch                   PASS      164.82 seconds
bluezmakeextell               PASS      63.10 seconds
IncrementalBuild              PASS      267.75 seconds
ScanBuild                     PASS      621.91 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,7/7] profiles/audio: make A2DP admin allowlist enforcement role-safe
WARNING:COMMIT_LOG_LONG_LINE: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#80: 
  blocked roles to remain visible during capability negotiation, which caused

WARNING:LONG_LINE_STRING: line length of 87 exceeds 80 columns
#227: FILE: profiles/audio/media.c:3179:
+			info("Skipping endpoint %s:%s (%s) blocked by admin allowlist",

/github/workspace/src/patch/14757537.patch total: 0 errors, 2 warnings, 112 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14757537.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2510

---
Regards,
Linux Bluetooth


--===============1733253732007525614==--
