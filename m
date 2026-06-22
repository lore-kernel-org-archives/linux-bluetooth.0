Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E414C343885
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782152094; cv=none; b=ZzDFO+ynyLnJBKd+HCVpgwvPU7yKAMut+BdLwLCQ/KkyqL3+kZM4LZPLXafmBEYyAeo4B4JiRe13S1RAwzeQlEssKekaF9Ivb2FkeL7+mLj433oC1RsKK4spEsT3vbfvORyC9kL5zgDZ/Aakvk4k69YtkOy1ghKQHeRgXzvQbEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782152094; c=relaxed/simple;
	bh=ZubnezaJm8rbM92isG+b/HG7jeD5ErYz6vfCCfIJFZM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jgQdXAMhpov5GWjY1jLTIKOvUiBV8yFjOYbnP4yvsNstM0i/XtzHvlwN4h+26i9Z+o46tBbmQFkUSKfM979BWZkXFiKUv2zUUOIlEbGaRYjN7T39BZpzK0jSjJykx19gjJYDMTAlP4bLbSIJfQ8Nq/ODYGxF9iudjUTKLaaWJ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctRPz7zO; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctRPz7zO"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7dbcb505578so50614207b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 11:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782152092; x=1782756892; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iezmPSh+2aCbcn1+FsKDY+Dez9rNlPEMFsBuhZSwjGI=;
        b=ctRPz7zO6o5m5m/UKhOEFDPsN4iAHvD49RTZMjYABRZIUydr8qrUMn7eXwfqDyB3at
         CfaaTSPHjPJjj9safKFCXZ/Cenc9LweBDXEMOBFooTx9d2/S7qL81UZYPzblVNHb46nA
         p05ptH4T1Sy5OKqA0ggrucSsV1y7vFMxreWfaqWejWyqwEKUGDvKRfVRO4ipvq56cGQl
         E32CYks6ij5s8g7dgowvvHD0A4ETRNBU4uVQRcMLvyKImm+LuaP/M0umaA34B/tiPfWY
         kpEX3AHHNWNaQCNXXLbcTa8vTtoVdMfWpYHr3OYuuztMtkzwhAwoBW25MMETFMspemmX
         Bz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782152092; x=1782756892;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iezmPSh+2aCbcn1+FsKDY+Dez9rNlPEMFsBuhZSwjGI=;
        b=ZRZx6Pl9szISp/dr1ZhSd1HPU/1AL1zWWlZxejzagAYYMWVbzgAvYZaG67++dNgi15
         Juv6tv+zpDfRu6u/5cP8QagsWyQWqgtdXqv1iXsxk4zWBM80yIbruwvCqotpGlqTxM2H
         GSdjA4gX06xuqep5/UOx/0FXQZkeWGsu3upKbmP+Td9ZT5XRFMd39jsQWXimo+14apBA
         /3ki1I0atIHpBkd9XbEvC0yM0qkEDifKndBnudjmkYjJXBPdSGJgLxCTm78f2f2VOjxA
         JfZSsMdO4GYMMB5Ek2C2ZlUhnjoc9BDTnFOEt3+LkwdG8lLvc5XeaAISQreAXd5gJhba
         vKsw==
X-Gm-Message-State: AOJu0Yy3QAeEu9PMryU9FG7M5Dz9zMo6bzjRe6gX/F10m04se4AATNQO
	/HyYz62GylZGlQy8gNlNr6x04uf/YkFwkCGhGK3qU2FjalIX4HYNyKYaFQezCQ==
X-Gm-Gg: AfdE7cnJNVPoy4WgcuH8byDngM5lZPscjycKIj8156uCQBnVYOyoEGdoBfnBZDvdWGW
	Ndte0nA73ie4pz2kNCWFV7RRSuHXNAWXQJ9FwF1wVlBAYVxMxK8KgpMYzKHVttg8NejsNuGBlav
	Fx/I5atlmkpOkwcfbPJckqIB7omDrNFvUq0vrF0ryvA98cY5kz9CY+NWrNoSr2LuxBsJ5hQNJjW
	ERHJQ9AwEkHQrzjKjmbB/sWtaGM5zKBgJQx4ZZySwb3jZESG3syW2iNdPOH8EUe61uv9jbcN+O2
	y4rwWK7IjdCvMJ768ELOEcuwCA9Usw2O4GAvd6LrSCUAsOI5hvwUkxm62f6lBWhS9kXSgFhtVfP
	J/BBH7nXrc4doWKMENCA46sTNQg/wJ83BDxqOspcb/XRbDXxhJaYYUBHGfvftA/6gclcrxOwUn1
	Xt60GEUkjy3DGxvyr96bA/
X-Received: by 2002:a05:690c:e346:b0:7bd:882a:43d9 with SMTP id 00721157ae682-8013236fffbmr150722187b3.27.1782152091581;
        Mon, 22 Jun 2026 11:14:51 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.44.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df82692405sm101516366d6.39.2026.06.22.11.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 11:14:51 -0700 (PDT)
Message-ID: <6a397b9b.ce53cff3.1780fc.6273@mx.google.com>
Date: Mon, 22 Jun 2026 11:14:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8133022024944218930=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] a2dp: Fix handling of codec capability storage
In-Reply-To: <20260622155621.675255-1-luiz.dentz@gmail.com>
References: <20260622155621.675255-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8133022024944218930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1114843

---Test result---

Test Summary:
CheckPatch                    FAIL      0.92 seconds
GitLint                       FAIL      0.67 seconds
BuildEll                      PASS      20.21 seconds
BluezMake                     PASS      619.69 seconds
MakeCheck                     PASS      3.14 seconds
MakeDistcheck                 PASS      237.22 seconds
CheckValgrind                 PASS      206.49 seconds
CheckSmatch                   PASS      328.16 seconds
bluezmakeextell               PASS      166.29 seconds
IncrementalBuild              PASS      623.46 seconds
ScanBuild                     PASS      931.40 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2] a2dp: Fix handling of codec capability storage
WARNING:BAD_SIGN_OFF: Use a single space after Reported-by:
#101: 
Reported-by:  p0her (_@p0her_) in TeamH4C working with TrendAI Zero Day Initiative

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'p0her (_@p0her_) in TeamH4C working with TrendAI Zero Day Initiative'
#101: 
Reported-by:  p0her (_@p0her_) in TeamH4C working with TrendAI Zero Day Initiative

/github/workspace/src/patch/14639629.patch total: 1 errors, 1 warnings, 36 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14639629.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2] a2dp: Fix handling of codec capability storage

9: B1 Line exceeds max length (82>80): "Reported-by:  p0her (_@p0her_) in TeamH4C working with TrendAI Zero Day Initiative"


https://github.com/bluez/bluez/pull/2251

---
Regards,
Linux Bluetooth


--===============8133022024944218930==--
