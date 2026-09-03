Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0382C032C
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788471930; cv=none; b=EBy8lmr+MQgwD3HnL0k9pnz5DxE9t6HArvSNP32rx6F8zHEWcE2FiBQszHzBbroGTHzYo/U6NnYhOVhE6+ujQjk4Ohj5AKCPN5I6ZBmbyUK8HKVEemlvz49iAcU6QzykQD298cUTKvd6bqh/wcSUkRh0Rl3TxlZMxnEzWI8e+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788471930; c=relaxed/simple;
	bh=UR6QXYZR0I1nJB4dL+cdPK87DaRqMQNpKHtTots5PAg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Vy41zpqo8jn8YtLqzMbC0vHwT1AkIiAexRAhCyeg60vOSciKldQ7e8newg72SWDQ3Blukgk8w5SzvGpJM7h8R2Ul0QHWdvlLTIvMSa30zbib/S3rztWQV7Tf6ipk0m2DbyL61f0k62aKXWN9sZcHWLUEzLh0gsktqWQ0dzZfc2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qb0YpAOW; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb0YpAOW"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6b127c88220so242311eaf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 14:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788471928; x=1789076728; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HcvhZnv6iY8r1jDSeiXLabSCZ2A2d7pguyAj+BXRMGo=;
        b=Qb0YpAOW4obIMdFJs8CqKiekCF66zOmxJH1uz2w2k7Tt9+diVcC3cQyN8loAtvNPNA
         flAho/oVg86SRe1SKnZM3a4E+4Tl2UfYIpJwT6FhrcYSRrS+qFRWp/QwtBP0+7z6edyv
         YMYZJkGjsmvjJhGdlm4i0nwFAVQGrbC8M1/vR85sNf08Px3iNkXfMM1yUinwpow9T4u2
         +i1V0jKiLT9vqoSlYefTet8H89+w2BcCPqiKFk8bq9Gzzb3Wk4dc7hdV7QU+26T1S3U7
         oKAbeEwb8Q/8+HJ/0hBIXgVsIq4xSU2w8czIe2CNda8tWGyIxj7usNpcx1+ANas19dTs
         b4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788471928; x=1789076728;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HcvhZnv6iY8r1jDSeiXLabSCZ2A2d7pguyAj+BXRMGo=;
        b=J6ftvPS90UlFF9NvLw3YL3tvMXZUP1ewZVD8WbVKKJ6XzAQwDXguK1WOEn2X0t05iR
         ySDWdc3DbtQwxaSyTDkAE4IYLHCrA+eLcK4KWdPbYU/GCDtNoEKbnyjKqWs+Ip2xitrI
         qn3mCpEQ4KYbYY7kQbSkamBrWeLZYoLX8sOHfw1xD/0n1t8ZHwphiGgX1X7LSOlP8rUw
         sMuWb7pK0YOraxfSMUjnTkdX2TQZ0dFvpsLMQBuYdk0e3j8+xoAGeoGw+B/m0pTpJGbF
         9Tol5t54EAuCH5Smwt2zYJwo1Wx5vRX5ob7sDgrN10ooadzYtUHb1d2xmO/XCWQ2NbdH
         Z4kg==
X-Gm-Message-State: AFuF++mt2DXlTt141RkSJT0fLCptMen4QK6QfIAC7p/4x7AeyOBcva0D
	TkW18rbQ2y1sHmYPtgT/E/VsQ54MlWaWHj7JWLwfR9JqiZPwBTykDEBIGeDAiA==
X-Gm-Gg: AYBFou2U4NLNvio4O4OFvJeSaSN21skiGXN1YlVDdQG/od+bVeAZEj1HxE8ok3Jvcrk
	TQeIOVeBktvzlBGlRD1ZO+ah+t2lMncIKDjGKuLFCd6ni6AamhdohVVYMRTOd3p3CVjwhLCEAyB
	hGsohkCK5x64K+YfJJM66Ym9NhkvHa+nWcx5yLdinoKtLSe10/p3WqviLhaNUAt5F7b4DAM/HMa
	+oxNshMdF+4StlsbdyInD8Ix0unmBmeAkFwSHDmXi+m0ajZD/biwarRNf5ijMUfSlHEOaFZbM73
	QsRTPNN85ejA73H2XVmHvFU7Gy0Cfhn3g64FeNIZXNKEUjShyf+O3mWkC3di6s2pEm319pyvug9
	bqHQ16+5WEwlVVRHp1o/vbaPerxPiCYLJkI/QlJTppEFpnY9U8Iuch6WUejyMKVLjf0YheAkQ89
	fsXUO4TE/YEvgvbv48f45BrMuZH4tYJ/BLHPqUzPC8MSSV9zCn9dslbdyTKHSNTdbnQg==
X-Received: by 2002:a05:6820:f014:b0:6b1:61b8:7ed5 with SMTP id 006d021491bc7-6b6fabe1074mr1428229eaf.1.1788471927491;
        Thu, 03 Sep 2026 14:45:27 -0700 (PDT)
Received: from [172.17.0.2] ([52.154.21.51])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47554d7d787sm673158fac.17.2026.09.03.14.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 14:45:26 -0700 (PDT)
Message-ID: <6a99ea76.bd8478ff.10ff27.6005@mx.google.com>
Date: Thu, 03 Sep 2026 14:45:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2778196455648029286=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] emulator: btdev: fix inquiry_timeout() inquiry destroy
In-Reply-To: <835710b340044363cabea364ab73d98ef409b6bf.1788466641.git.pav@iki.fi>
References: <835710b340044363cabea364ab73d98ef409b6bf.1788466641.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2778196455648029286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1157383

---Test result---

Test Summary:
CheckPatch                    FAIL      0.39 seconds
GitLint                       FAIL      0.28 seconds
BuildEll                      PASS      20.19 seconds
BluezMake                     PASS      539.78 seconds
CheckSmatch                   WARNING   306.79 seconds
bluezmakeextell               PASS      96.33 seconds
IncrementalBuild              PASS      539.92 seconds
ScanBuild                     PASS      881.20 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] emulator: btdev: fix inquiry_timeout() inquiry destroy
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#93: 
    #3 0x0000004a286f in mainloop_run_with_signal src/shared/mainloop-notify.c:196

/github/workspace/src/patch/14788574.patch total: 0 errors, 1 warnings, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14788574.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] emulator: btdev: fix inquiry_timeout() inquiry destroy

15: B1 Line exceeds max length (82>80): "    #3 0x0000004a286f in mainloop_run_with_signal src/shared/mainloop-notify.c:196"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:478:29: warning: Variable length array is used.


https://github.com/bluez/bluez/pull/2488

---
Regards,
Linux Bluetooth


--===============2778196455648029286==--
