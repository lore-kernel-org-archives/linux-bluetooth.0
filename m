Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9963B9619
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776422430; cv=none; b=cswZwi/qHaRkow2bjyoNUD73W+fO9kenIMG839v6M4LSzMV2+egfeStsAlOUen2jNVCI2+uyKp4zp1irZRyH9fWoyf5KAr4PI3WrjlO8VVlZTIfe6+VzAXfOe9LFI5a24PuGShZvnogRaPuGAhr+yUB2A0g7ayVqgS2Lj/Hr/KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776422430; c=relaxed/simple;
	bh=C7uWVOAUEu/QgTsfjXgPlSBPec9xQyBCdh1cvI3KvWg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=k6P0biaMJ0c3OXcfCfBn6djZ1Epn7kUP9Kr64kGkbgbnxPZT5gYdmtwlsMbEexnao4hOn0FQ51JMJolVp6vFKOlUy9Pm3n+Rd/5Qh4OZAZyDLAIHQQHKz/fS8ueYopm6B081WaxIWc1IXrwmw5jyaxx7msddHpQGdRrrnYCObsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnG8hPur; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnG8hPur"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-47018d34159so340700b6e.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 03:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776422424; x=1777027224; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ACqXUz6Z1cg9EP2YiYnCynZPMiBFpSkdmsOUbq3bBVQ=;
        b=DnG8hPurQsY0s/DZ6aoGVyP4ZUxzibGINqJKDOf8tGGLupOxv8SNTCelZQ83K7XinQ
         a7mG+LvO+r7IbvuEsRepB1F73ZbjHpVvcEZLpFDt+Elw7iaWHQCpNgbdRuhgdYyhwPV7
         5QqFa7290azUp/UI9fQDElLTFV6vTJ8zLVgE3R9xH2A9+3ue0GjyGS6qNHjsahTiFk0c
         2Wb7GArp+jQ3W4QILPAEqUcDo442wFowoCb3AP9z3XEyNZaQAnfP6kDwxXM4rV0n1INZ
         3c2SVf7lx4Nphs7CXT82GAMBbgGqXxqJOlQNPSiHhkOy1ZLj/7P7+tk1nMZhjJoGuIRW
         xA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776422424; x=1777027224;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACqXUz6Z1cg9EP2YiYnCynZPMiBFpSkdmsOUbq3bBVQ=;
        b=BEhbMd1NwZ6GCHBh+8xHyzLiedlzgALc8kBTXnKEMqDsLXCsg1ZZ4fChOtNDGEwIBL
         A2tjpjODSy1a92IJh/YJbq9gUTt0+XtXKrwpQfkKDFbP8IjPyrTiwAUVpf4Ku+aYEalZ
         kHANMfydRDK4Ao7t/3jQhoIcmUUmdj2pBmPiiGt1sgHqpjf49slKyMgW/DaEGG+lnI7/
         ycNZqO6HGNJaTXFZWGPcYqEnfRJk5gDm+X/WBDeftRuCZzcyfdNKZ4g74pIW/hdL1BNa
         uPHcMZPheORtQwZVr/BDey122I5knMFu5haTFUEEScHLNKL0Ba6bhL7l5lrDsY7F1rPk
         lDMg==
X-Gm-Message-State: AOJu0YwycXcsng0W7HCv8tmWAthp+twVT43bAJDc/gCFAn/Q9Fj+LBzf
	BB/4udUDKt1SYPQ6WA098NsK2tzBPesWxzrz+gQ9Rx8xCXSQtALVeI1yDDzb8A==
X-Gm-Gg: AeBDies6NHqfg58kfxWumwHWlkFR03CHUugD9YAdA9diO4fIVD+p+YzqJEjDyr1lhj3
	A+OFGC8owNrH/XEN1WDRBUZr2M3IeIAhv8FN1i6soE9XgqYotAfu7mZXSB90OnHxdp9tbRIm6w8
	nzD4y9yfv9iq9JS7D/TNJPR/KoEzvs41epdTWXQOLYs00k9hVouOsnFj1msIofmBumL3tuPZe/6
	bYPg5WPL1e5s3vEq0yFH4igdQGRCpZPSaDiRo72jEUXrMv/clenEy8Sy8gGWcLs8qx4uyDbVI1B
	nuUDiFJ3ro+XNZVD/rOv6bw5AwRqCSXWrB/X3duJU1St8eGMOgy6k9wMJUysZQOaUwcb5Z9opk2
	wLoD0Fs5ZKcgh3asEcKDg1dBlLLsHh/WclT7aSxQvovhJTmXuvQLUol2A2/Xj3g9ye1FtkrChu8
	jzHRCxJUwnLwM9l+67VBnPkhqb+S6GkX7NrEL5tWT5bQ==
X-Received: by 2002:a05:6808:1b11:b0:467:cda:f189 with SMTP id 5614622812f47-4799ca4a422mr937448b6e.32.1776422423561;
        Fri, 17 Apr 2026 03:40:23 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.138.178])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4799ff451d9sm660518b6e.8.2026.04.17.03.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 03:40:23 -0700 (PDT)
Message-ID: <69e20e17.050a0220.39a7ba.deaa@mx.google.com>
Date: Fri, 17 Apr 2026 03:40:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6580872941027101957=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michal.dzik@streamunlimited.com
Subject: RE: BAP broadcast fixes
In-Reply-To: <20260417084809.3633687-3-michal.dzik@streamunlimited.com>
References: <20260417084809.3633687-3-michal.dzik@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6580872941027101957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1082418

---Test result---

Test Summary:
CheckPatch                    FAIL      1.53 seconds
GitLint                       PASS      1.08 seconds
BuildEll                      PASS      20.08 seconds
BluezMake                     PASS      644.28 seconds
MakeCheck                     PASS      18.64 seconds
MakeDistcheck                 PASS      243.92 seconds
CheckValgrind                 PASS      289.61 seconds
CheckSmatch                   WARNING   345.58 seconds
bluezmakeextell               PASS      180.77 seconds
IncrementalBuild              PASS      664.51 seconds
ScanBuild                     PASS      1005.91 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,3/4] audio/bap: fill BIG and BIS for receiver
WARNING:TYPO_SPELLING: 'explicitely' may be misspelled - perhaps 'explicitly'?
#104: 
explicitely in BASE, but we can use subgroup index with success.
^^^^^^^^^^^

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#138: FILE: profiles/audio/bap.c:1556:
+	create_stream_for_bis(data, lpac, sid, bis, sgrp, qos, caps, meta, path);

/github/workspace/src/patch/14528085.patch total: 0 errors, 2 warnings, 23 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14528085.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2051

---
Regards,
Linux Bluetooth


--===============6580872941027101957==--
