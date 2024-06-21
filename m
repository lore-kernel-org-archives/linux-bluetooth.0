Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DD216B3B9
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jun 2024 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959347; cv=none; b=kI4ruzaogirG0ACV8gch2hGO+dQipHlsFUnn2kEKqpkXjURMEsGnfL8oVlnM40/14xJroUKXzD1a52njfUjUVB0ZJNT0Cqoil11l542TlpUKFMUhuEwsiLCEGSZS+yuvqc5sKMxZJFdKVx5hWcn4UEpTMUEhcQypfng0eBW4biQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959347; c=relaxed/simple;
	bh=jkh3UqC/6/ogaQwMHNtz5LijkemPgjBO4i1SpBM1ihk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=n1+bVFKH4k5EgdyyfieQs549dypepANFG7zDz/cRA4NvKqS2hXS9l1VMFVddWkgwyzlKakr8s6T95ze4Vi4TpUfk7QzSY3aM8Pk7ygtLl9w/gt/1pr7IAIHs0GQzS7yBZePCar+mx/19vIEXe+n4dqb5+lNKE/98oavDkA3ubjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+Bsl39N; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+Bsl39N"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7061d37dc9bso1527994b3a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jun 2024 01:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718959345; x=1719564145; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9tufYeU4tYmdje5HuaJ4rUGe1Nz2xRV6rPgJ+Pm7Zng=;
        b=U+Bsl39NyTv41rGzRSkUdm16R20IOmbrMdrohgVg+WZmL3kLE5NIXnXdG6U6DOf1+X
         kb3f4PAno73yXHI5pfEUOQ0TedcydrQ8Sw1tn5lccIrz54Kg5jE5MaupzXEi5n7vwOhR
         Ng9qGxQq+sgceZFAyJgLwpfpv/WngLBZFS7l+ld6tBGFHVbIKQSpIQN0oqgRNHr74yO2
         UuE/r2ffoH3oFme0bMK1Bs2JBwDzCeq2sWFnAa/bQm+1JCdBdz2gPOiBMY5SXTNUCA+w
         UFK+9qnYeI9mWdf9liDbbpee1ilHVITTKZ8XJc+3ZzZI/gMi2rpafz2lkeIgG5oZG0zp
         xMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718959345; x=1719564145;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tufYeU4tYmdje5HuaJ4rUGe1Nz2xRV6rPgJ+Pm7Zng=;
        b=SLQVJGSCMh1mWosXDwFkxyXkMMcWavulj+lJndXrv5FqHcS9x96yQDYoQNYRdzMiZI
         EY99x1+v7OKUpeBGyuRMgpTLWZjeaQsLbaHjVjQTxdN6q3BwxeDtcgYvwKGDG+sakTot
         ufvRTulh3aBMUG+hw/7B26CPt6rl/Xug+KMvI3C2RedT7mHfdSEwUFDDGJR+WOEkXKVy
         jEenrgeNsFX4kagHhchIoN8BXloUKFjyMyLXOIHARGQ7PdetFk5qOSnkJSGp3V0zKESi
         ClkTWj69qWl0Gtm1R4OUMwuom5+9Fu2odNq2GZyhArbFreVh8eqPAWjgOJJwzsXudJoi
         XvEg==
X-Gm-Message-State: AOJu0YybQpYIHc17YE8xw4BxEjw1PfNQafQs8oH6qrWHH//0WrmA2Jml
	aROqSlgBts1awjX41TJapl5N9IuOjPFL61YEMwX/s2y7ImYPUS+Q84LtcA==
X-Google-Smtp-Source: AGHT+IGpbbmvcSyLYk03X23PuP2kBgqwYL161a714f1ostL8Y9E3uy8a/8G0yZfr8U97H8tpkB56GA==
X-Received: by 2002:a05:6a20:12d4:b0:1b5:d36a:5d68 with SMTP id adf61e73a8af0-1bcbb41737dmr10041005637.15.1718959344543;
        Fri, 21 Jun 2024 01:42:24 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.123.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb323ac5sm9088795ad.107.2024.06.21.01.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 01:42:04 -0700 (PDT)
Message-ID: <66753cdc.170a0220.b3f2b.2211@mx.google.com>
Date: Fri, 21 Jun 2024 01:42:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7842750499740078592=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sarveshwar.bajaj@nxp.com
Subject: RE: Fix null pointer dereference in util_ltv_foreach
In-Reply-To: <20240621064342.33664-2-sarveshwar.bajaj@nxp.com>
References: <20240621064342.33664-2-sarveshwar.bajaj@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7842750499740078592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=864148

---Test result---

Test Summary:
CheckPatch                    FAIL      0.66 seconds
GitLint                       PASS      2.24 seconds
BuildEll                      PASS      25.04 seconds
BluezMake                     PASS      1707.63 seconds
MakeCheck                     PASS      13.21 seconds
MakeDistcheck                 PASS      180.96 seconds
CheckValgrind                 PASS      253.15 seconds
CheckSmatch                   PASS      353.64 seconds
bluezmakeextell               PASS      120.74 seconds
IncrementalBuild              PASS      1463.62 seconds
ScanBuild                     PASS      1013.43 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,1/1] shared/util: Fix null pointer dereference in util_ltv_foreach()
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#111: 
In the existing code, iov.iov_base is initialized with (void *) data,assuming

/github/workspace/src/src/13706903.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13706903.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7842750499740078592==--
