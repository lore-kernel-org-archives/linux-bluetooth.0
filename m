Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FF34156E8
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787221621; cv=none; b=YKxbAf4sK9go/TxgJRBiW+21UID5LkIXeXd/Rc9jE702GPoB1HWHBjukq98UgDNXb3XFXO8EpvYIkfjvE49uSUkG8Mti3KEerl6pl96a4TGWgCrgTqJKXWNnsjhXuQs0xbFFtgLBnCaCHtbHfLhyR39ajW34Xoph5qvU0TUGT8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787221621; c=relaxed/simple;
	bh=bNyYGhR+wnOyHEBYdPTqqvrByGmVg0nlMSXkhWVQDLc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MacV3nCN54vcGHzTA73z2+Wn9f7mvvi3sr5jHsx2kJBW2FoWvnGWRjyPyuzl5Tqvdd+Lo7uILdNGsjXQtVYSKU0OX+Pn/QpoizwXl97WFuKrh+xBQ6PR3Y41O4Tdimgbba2sn1nsbKNL7jyRieNjQbUZg51k0PhkZZ3ZPIgxOlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o1Uw8FgX; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1Uw8FgX"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4a46a53abc9so1438852b6e.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 03:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787221615; x=1787826415; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ePxA3ogHifGGrVfnMKJIQaucOpGsgrBS6CoJRy//US8=;
        b=o1Uw8FgXWnNcQ0M2EKHI8ID4j4N/odP784t5JrHBm2C4xRaUfOkDPgihqgbigl6hMu
         D+rFWUcwpJ8N5OLQsHI/Rgm2jZTUoCz+Xab1t0iVlJL89RlSAKWnR5wsXmstW7/Skzh4
         lIj0389BtNVczS1la5ohGw4AfbcK8oLlYyMhp+9H+fs8GfCIJsn0qN+A3fvf11SM2DDa
         gPLY7aRVX+l8XrUbLehf79CbiIjgp7xPXw3UjK/lJw0TESqUs8fBgBgvdAmsIf1buM2G
         MaZJl8dHuEQnsqVFGvYVrVpdNcPrxMbObrvAQArcAiY5Ze9vPx+VqlA537rNLxtxbNxV
         Z/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787221615; x=1787826415;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ePxA3ogHifGGrVfnMKJIQaucOpGsgrBS6CoJRy//US8=;
        b=EJspACYYR3D3B5pG2aqMWRQfbojJlVi6Quw4qVwyPtEtB2RkftpjcCLYYmOH+cXEg+
         x6S0BGDehDx40ayb88XG2Do0fq/JvNgtBP6gtK6LJ//cdT7tj8Vh3GPq20JsZaadeZZQ
         kxbFtQ0k8c+hLw7IWTQgTGbodKF4iWsm9zWYkTPcJwyST3rO/Y/w2PWHf7GP/A6B8vI6
         0V7dBGEq+LNj2QE2V1TnNcLoUB9ASERsOHKvXziDW+a4Va94Snk2yBXShS7vjT97Poyq
         pQRW3fZHvWTjd1CJpizBf5hbUmS5KdiLihiNOQOqtigVUtfsWow+7SembxOW0X3bVSi/
         Yy7g==
X-Gm-Message-State: AOJu0Yxd9lRdcX61xKFZIQGGxQ+kF1YPBhBNMR186Vk6eYrfm/ZXT86z
	OwDPaEsLr2uBh+HwWsmKq2mziGeG3vUxKjYpQhTw60uc08uDQKw/OVE34XEl1kaz
X-Gm-Gg: AR+sD10JMCONLtI3hrrJwj149w0VZ5jOy2jqE6lHsnPwdaicAA+Pzc3d58ojFE447Ii
	SAQchsRlutQ51ncC1NDpJSafN5ST11f6JHwn9mz4NCRXsLq40FsGNoVGIjRJdDdq0Bcb/kBw25k
	sLxEM38y0PDrAj4uklBFOzFrFK5buxcWdsnwSh4v6lfV+JohlY8tHLqXspWktU/vS0Fq0iCGWkk
	INZ7/ye1jvZmFwbjhD7v/muLbP5T+ktFSfxuOvGwI5XYRiz0eSNEjN2AH5Q8WXF4KRgOgLLAhIL
	AIkOSdi/EaQ9vrjLxsys+2WMyBWWsI455qgKBXAfAbIshH+ajzRmchgmeNlwmUAiD+LS6dQ8o47
	G4eHS1/eVPQ85GEzcKja746udialL1izyZPxgtQ+1TPrWtXwJDkd76TfczoMENQ2sfsCk+oFtzs
	8o5OBL8u7om0JpWvMFPvydTlsREMCYl5Q00BhV8o+AYV36G7nj6luQyos1v7Az9bEOVjIS+DlEN
	cURRA==
X-Received: by 2002:a4a:ee0b:0:b0:6b0:5bd1:4722 with SMTP id 006d021491bc7-6b13c37ec75mr10497280eaf.13.1787221614801;
        Thu, 20 Aug 2026 03:26:54 -0700 (PDT)
Received: from [172.17.0.2] ([172.171.7.122])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f43fe7029dsm4215155a34.2.2026.08.20.03.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 03:26:54 -0700 (PDT)
Message-ID: <6a86d66e.b3d68efa.f5164.e4a3@mx.google.com>
Date: Thu, 20 Aug 2026 03:26:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1652337916274982614=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] bluetooth.service: Fix ConfigurationDirectory warning
In-Reply-To: <20260820094503.1779779-1-hadess@hadess.net>
References: <20260820094503.1779779-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1652337916274982614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1148981

---Test result---

Test Summary:
CheckPatch                    FAIL      0.35 seconds
GitLint                       FAIL      0.23 seconds
BuildEll                      PASS      13.40 seconds
BluezMake                     PASS      486.30 seconds
CheckSmatch                   PASS      175.43 seconds
bluezmakeextell               PASS      61.93 seconds
IncrementalBuild              PASS      467.76 seconds
ScanBuild                     PASS      546.90 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] bluetooth.service: Fix ConfigurationDirectory warning
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#52: 
systemd[8067]: ConfigurationDirectory 'bluetooth' already exists but the mode is different. (File system: 755 ConfigurationDirectoryMode: 555)

/github/workspace/src/patch/14758855.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14758855.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] bluetooth.service: Fix ConfigurationDirectory warning

5: B1 Line exceeds max length (142>80): "systemd[8067]: ConfigurationDirectory 'bluetooth' already exists but the mode is different. (File system: 755 ConfigurationDirectoryMode: 555)"


https://github.com/bluez/bluez/pull/2417

---
Regards,
Linux Bluetooth


--===============1652337916274982614==--
