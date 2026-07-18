Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE46355814
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784409747; cv=none; b=IgsQuCRYU3ZXb9ThwuumvmZkpmA5ii0BBc1DNEC/n5pLDPOZ8IE46MFEgLvqtT45NAPdsPxA5kWQCE9/X5gEBDbuuYSrVplvjteQnUDKFVTBR8Apqk96YYCyUZ2DJOMH2MAEAxZiykIBuNN1dlMPLJasvN8OwWrZM7mI+KMEQE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784409747; c=relaxed/simple;
	bh=07YEsE1yCrOL3T/ECiSr6U9if3xBaGVJg2x9B2pkh2s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pFJL2QJqPhcOEnqBjKfMbQMhB/3B8t6Ii6VMWCVBEbg7DmU8On/5sWklcVVu1WpFrneCZ+ghhnpojwyN7axUaB2YsSpthtV6PqDmzKCN48o1oWpvOkc/65Ob7D1PTYLkEuT8Z/WYP7BZ0IZ3pOz1lE7TlnXLn0TDEYmgZLxZGqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyxUTnD3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyxUTnD3"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caed617615so100271375ad.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 14:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784409745; x=1785014545; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=465b9uPlI8s7pLgOr2Be6xZu4fkwL18a5m3ntdZ2SL0=;
        b=ZyxUTnD3eTRECWF1E9S3/Uddu1oGwvdJSWRayZuzrFbrc81Fq6092sszcBZCiF/R8/
         eX0Rbdr56QxHJvP3qNopxM8ga7Qpiw/3tAkwxtu8bEs+qQN/NsC39t8NYh3YEBdL+1D6
         LZelj7OZdsTmG4FzRJ2iEEPMYPpXtrWFNrihI3hk7z6aT61oV0qRS+9w3B6j1Fu9edcW
         1F2qaCeXYEKVgBrOhFPHweYdvMcQJ3wyXz9nlOum+Wa2jQZhOmSQucF5FVGGEeVti67i
         HOQHKuwYQUepujBL6KPAb+htDYzB1rFtILqOABKQ9bDeTiS/ylVZ6MaZFvAmcwKIkofC
         kDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784409745; x=1785014545;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=465b9uPlI8s7pLgOr2Be6xZu4fkwL18a5m3ntdZ2SL0=;
        b=AmFBV7cTjhJJTzRqMbuwiARYbN3Dm+BITTj329wBjci25xVQnKST/Ru7k91heEYT7T
         aSuJay/8eZdaqHWSeScxYOKXu+oU/8teJTBoF2p8QSga74HOe2w1440cKN9HaF4/wk1u
         tREil09Z3wYTPmSBLqXqbhX+1NukcIPNr1XDK72vOnqFiXcejjHJhtgp2CuowWDfKlpv
         s6h/TgknXZ2TtfMTYxiZ6fcItUXBq+rUqT/HnVcQywyadwLNhQPJiLoLpCm9SPEE+bJn
         5yZFDqzTwk/cyqiZwIBveP48hgmDyYkcOINCJH4E/A1UFz8npD8rABQeIssSKjosHAXu
         Wx2Q==
X-Gm-Message-State: AOJu0YwWTR3pt0pX5wz/K4fIegH+JIreaYXo11RkGdY9sEZl+BoVxDTH
	qQTmA3zd89pqaTSpMSDcy18qUFwo9NtKNMAJvHo97DE6C8LufzdTYRUokOUXVAB8
X-Gm-Gg: AfdE7cnXMK2KIUh8PWVXM4u20EL03Ny/LUkxX4r4Jkej+SP4/whlMy64twqc99AmAT1
	W75vw8P9O54ixcpeft+vbfTAqUk9hQqagIaOfxzco1nk2UC5fUgk+FChECtkDKCtf93R/fpD4Z4
	byO7HxiCAVP6be0G7AtO30wO3JyGCeYAVt/dWkvcbW85riYTnh70Q/4HTKunTG9vB9ouWTl+iKy
	lkot0DiYjmNJZj2XwiqcSjVBQRSP5J4bY6HPFfiN++aBENPq39V3MSQTNfi2YU5zLmCxfP5yTa7
	iqw7+IPQVEnSxKYx/8KGOppnXQ1eQInCB19hZ0BWc0GG6VRdNzQlsuYSJBSctx6TzNhj5xAnBSr
	hUW9YyiJaUMDY2xH61Rs8LZvLqei8Mv/GOBFjc7oJ60iOOxwXY98qkFyAoIDDmjgb4GBwY3pzou
	UPv/M89If86A==
X-Received: by 2002:a17:903:15cf:b0:2ca:c68:c554 with SMTP id d9443c01a7336-2cf34a22678mr87347245ad.38.1784409744868;
        Sat, 18 Jul 2026 14:22:24 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.244.86])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cbb69bsm15121066c88.11.2026.07.18.14.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 14:22:24 -0700 (PDT)
Message-ID: <6a5bee90.92ea0e2a.4a9a5.5b46@mx.google.com>
Date: Sat, 18 Jul 2026 14:22:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1398172612663929361=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pip@pipobscure.com
Subject: RE: Don't auto-bond on reactive GATT security elevation
In-Reply-To: <20260718194230.35959-2-pip@pipobscure.com>
References: <20260718194230.35959-2-pip@pipobscure.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1398172612663929361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1130150

---Test result---

Test Summary:
CheckPatch                    FAIL      0.71 seconds
GitLint                       PASS      0.46 seconds
BuildEll                      PASS      18.36 seconds
BluezMake                     PASS      653.95 seconds
MakeCheck                     PASS      18.62 seconds
MakeDistcheck                 PASS      147.18 seconds
CheckValgrind                 PASS      211.82 seconds
CheckSmatch                   PASS      248.24 seconds
bluezmakeextell               PASS      91.53 seconds
IncrementalBuild              PASS      1156.64 seconds
ScanBuild                     PASS      818.66 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/2] shared/att: don't auto-bond on reactive elevation
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#107: 
Assisted-by: Claude:Opus-4.8

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:Opus-4.8'
#107: 
Assisted-by: Claude:Opus-4.8

/github/workspace/src/patch/14695485.patch total: 1 errors, 1 warnings, 73 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14695485.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,2/2] unit/test-gatt: cover no-auto-sec on auth error
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#81: 
Assisted-by: Claude:Opus-4.8

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:Opus-4.8'
#81: 
Assisted-by: Claude:Opus-4.8

/github/workspace/src/patch/14695486.patch total: 1 errors, 1 warnings, 46 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14695486.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2330

---
Regards,
Linux Bluetooth


--===============1398172612663929361==--
