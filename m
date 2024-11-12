Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AE71EBFFD
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 06:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731393662; cv=none; b=X0gJrBOoitMfwSmiJ8mxXa7zfW+5/lJmDFSxRH1luDRk/vTBDRqraOV8bjEIWUgsI4CTpN/KqW1aQgY7jCF3euZOMGWk5yASrROlgCKwAWA8pLaUz4M36rCxhoxfdJsI47NQcWnltVAx9czMfnn6OjL/vxn1s3KnlmX6+okpL0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731393662; c=relaxed/simple;
	bh=C+iTWFmYFB2/Vt0TvTVTPsDXdhA98NlI10nCz9unxnw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tKq6gEWrQ1mwEirMXI8Ui4La3ptITK/O60LuhMFRBGW2UZdc1Z++/vJVChbrofgDzeHoAKkLLEagaHgzX1f8A5i+mDD+S/pOMXkXNrzygIyL3WmqYHGfSqgd6KORhPHLbz4jKwrB2xxQ+XmGNc5JvrlTIpSFbBMvUpdLvSVEBN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9A4SaM2; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9A4SaM2"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbd550b648so40837446d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 22:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731393659; x=1731998459; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kwF3md95tGWavfQFPe/QOuOKivnbESyiCaWdO7ca5SU=;
        b=N9A4SaM2qfemo1Gm6l/dG6nCccJW9it6Ka3QKgPVTiugiv0JsFrrD3Uztw+7z4jjkk
         qWYOaUXSmOYQ4BIzVzHk9GNAi+/vDbWa67OA93VFycSWhtzd73amFt6B9sFA4a90X8T3
         6RiKEaWJwO2GKQQrFJkseDHDmwq6+SyPqHMjmJpLRuNljqNUy6uGT6OjF0oaMUrZEdgb
         0IzPzMXm99vATzrxReeLpQFSRbgFQe+s6Az6SwXFx2npyGuhiKC9Rihd/V7C6mUkoZtg
         M3FC4AJGrp1sIX4x0FiQwH+vuNtfVXrOXiqmWbHVKbftB9BDaKGDLUeVCnxVM9lru1zJ
         OfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731393659; x=1731998459;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwF3md95tGWavfQFPe/QOuOKivnbESyiCaWdO7ca5SU=;
        b=ru4nOqKdVjd9hWYWKTcZtbWxFGn9Tt3VqWEKXYSzWCGyTHYOlW0p5mjoLryNjEGBTs
         mNvgxeRpUfkW1++CA1mB6dKmmjg7Irm/sJ8+3hiV1FhNn0PtA017xlT+U6kjexLkjLoO
         QIPSFjMxRJPwjOsuc6uMeOXT4Np5wRIo2idDS+vUIPXG9HRRuCWmI0qik1/oOyf8Cuts
         0BfhGcshLBx2mdsqzAb5QHJsEuBvWNeb7AGWof5pBT0K8ireuJGUKXgFr5L1D/t53qBd
         Qv7MXPpY2pmyMPG3XCAJ5FhxOUitqgercc5U3ZGnyYqpYRG6VbiBEtSoOsa35mTTshRO
         dHNw==
X-Gm-Message-State: AOJu0Yw+HodX/KoARxSEdNBjS6SqsVGTGaoW/V9sCYPYaGGoP7Dxk+Hi
	GGxUrENgadSItHWVJlrC3faiU8nvLKZkM0G70uc/nKoOfz7NIxPq6AdF7Q==
X-Google-Smtp-Source: AGHT+IHTDswFQij/UE66Bs4D9OhYFY+eNp+lVe4FmlzJyzZ6tWQX3SyC6fzPDUe4R2fot42kkyCQvg==
X-Received: by 2002:a05:6214:498e:b0:6cc:2cd6:24 with SMTP id 6a1803df08f44-6d39e1a5c68mr232323726d6.36.1731393659421;
        Mon, 11 Nov 2024 22:40:59 -0800 (PST)
Received: from [172.17.0.2] ([20.51.206.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961df2d2sm68353396d6.25.2024.11.11.22.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 22:40:58 -0800 (PST)
Message-ID: <6732f87a.d40a0220.11c383.2ad0@mx.google.com>
Date: Mon, 11 Nov 2024 22:40:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6164480435107100101=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_dgangire@quicinc.com
Subject: RE: [BlueZ,v2] tools/obexctl: Add command line options to support session/system bus
In-Reply-To: <20241112045022.2743723-1-quic_dgangire@quicinc.com>
References: <20241112045022.2743723-1-quic_dgangire@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6164480435107100101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=908663

---Test result---

Test Summary:
CheckPatch                    FAIL      7.37 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      24.44 seconds
BluezMake                     PASS      1687.47 seconds
MakeCheck                     PASS      13.18 seconds
MakeDistcheck                 PASS      178.69 seconds
CheckValgrind                 PASS      253.09 seconds
CheckSmatch                   PASS      356.69 seconds
bluezmakeextell               PASS      120.05 seconds
IncrementalBuild              PASS      1412.88 seconds
ScanBuild                     PASS      1008.18 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2] tools/obexctl: Add command line options to support session/system bus
WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#115: FILE: tools/obexctl.c:2152:
+static const char *help[] = {

/github/workspace/src/src/13871714.patch total: 0 errors, 1 warnings, 44 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13871714.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6164480435107100101==--
