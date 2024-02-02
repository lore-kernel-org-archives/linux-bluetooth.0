Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E477839F2
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 21:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706910163; cv=none; b=rAtNdTXU27RzIGWfsYnYxb6Yg1fHNfgQAZp0yMlo0hwyHi1+6/5ZffqHt5gzQMkbSqXQoP2knzr4Wh6beiEUhVypbmGtgH2EwKxFQf0OKviKy58YEHRLWAEztDCLrqsa84RqtRoChMCFTiF00EYTepiIQq8qgSVZ+FnOu68RVjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706910163; c=relaxed/simple;
	bh=uwHqjDYIiProYmOgne8yrIVpwBOVA6M13e/Bv50xVQI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bP8whOw/zK8Ldrtfpt2/h7HpkqLfBDNl7WQRWdWYmisIN7anIi2iBgb51CD6UGa5AXrO5hDlWrN8+fr97NPrJ5AcPmMiAIqlcog/9FSACoVMjx8NmmfZkaLqiLAMFVfsDDIESZrVKuZXWp9r1k94M0NGBuv+uEwi22xffD8A4CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLvT0Lab; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLvT0Lab"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6818f3cf006so12496346d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Feb 2024 13:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706910161; x=1707514961; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zUJGUvSi8KN6i/8NNz9wgQa72XU1mYl8NIv0nz20tf0=;
        b=cLvT0Labo1ilKMdT6DM4lj3W3Ykp9UH2blH/hPe387+4Ltfa11g0+/SEmghCf+tRFN
         S/VTYMOuBnDNzL+V7QoJDy5Y95/VCiNDMTzSab1/ZsGXIiR6I6MLxLXckSObOfvBZOOo
         Xdb05OV60HfuU/VN5v2qabuwfkQEdN9Ew/6jlOCfzKYQqlKLGb8hqzo6Bllo0y5ySjYS
         MArizVmZ9rsh9g7n3UNicbJep/vKQ2TmDgWl1CjZp6N2EEV9qsVlilh3wuks2Eryn8NZ
         6pWjlJxxpjGsGC53EsX3GvTNY23YMVJ8f6R9qkcrIaJlbOi4F9/16o1nOqJaR4qk5Pj+
         m/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706910161; x=1707514961;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUJGUvSi8KN6i/8NNz9wgQa72XU1mYl8NIv0nz20tf0=;
        b=ND/UgD/AZA4txMQK5pD2+TDB7RC7gFgT4T3TOm2s48Eo/RmpQZhrLY8nz4WMqTM2C6
         KXO62m8a1iM0gFv7V+zasVhti8bgmsSQLZU5SbHqrcUgy3n/e17z5hM1DlJox1Yw4RCn
         8Pl3M5J4/I5oUwc96f99HsH7Bl1RLOtjO3TiUhbQvmyBB4arX8WuwSY3YFAlpnqrKreS
         MTqRxWhVB/DhojO/+F/LZIpHnO//I2HsJ5SCyqa6B1xnmb53oq+ZCYzBgXqoKWVxlVxg
         QUbeILfA1bGhF8PC6fLfiVq+JpE/UCfZszEB60IarO3dS4e2bQtA/hd1LsS8+RqMCE8P
         ZajA==
X-Gm-Message-State: AOJu0Yzx+y8YYG2yldsTHZFppFhHgwdyltbBhR9H03mipW+lpunJS1dv
	cCjWEK3q5Khd7Tb59wBAu+Ea9EE3g3a6SenevZIVDDN531G+BQ6TETxa4EI8
X-Google-Smtp-Source: AGHT+IFsuitg7xVgY6ftM8zHfrblA38m+OjeXOwxqrYMbOK4zFilxPJ4XF+MIiBVD9VtZ9paMzkRhw==
X-Received: by 2002:a0c:f2d2:0:b0:68c:40d2:2031 with SMTP id c18-20020a0cf2d2000000b0068c40d22031mr6441913qvm.19.1706910160885;
        Fri, 02 Feb 2024 13:42:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVfKcECc30uDxZLwJ1BShBo01PBXlBoIfh6GM9yjDTb1S24PYSbEFEps2L/1B0437tKFQvuz9S31v93
Received: from [172.17.0.2] ([172.183.130.193])
        by smtp.gmail.com with ESMTPSA id qj22-20020a056214321600b00686a080092bsm1169002qvb.1.2024.02.02.13.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 13:42:40 -0800 (PST)
Message-ID: <65bd61d0.050a0220.7bdb2.7cef@mx.google.com>
Date: Fri, 02 Feb 2024 13:42:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0818751812400371184=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/2] monitor: parse Google's Opus A2DP vendor codec capabilities
In-Reply-To: <b02d20dd168627b35016dfd0b56beb4a3a8755bd.1706904250.git.pav@iki.fi>
References: <b02d20dd168627b35016dfd0b56beb4a3a8755bd.1706904250.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0818751812400371184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=822659

---Test result---

Test Summary:
CheckPatch                    FAIL      1.95 seconds
GitLint                       PASS      0.57 seconds
BuildEll                      PASS      23.97 seconds
BluezMake                     PASS      722.72 seconds
MakeCheck                     PASS      11.75 seconds
MakeDistcheck                 PASS      161.55 seconds
CheckValgrind                 PASS      224.79 seconds
CheckSmatch                   PASS      326.14 seconds
bluezmakeextell               PASS      106.22 seconds
IncrementalBuild              PASS      1328.51 seconds
ScanBuild                     PASS      976.90 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,2/2] client/player: parse Google's Opus A2DP vendor codec capabilities
WARNING:NEW_TYPEDEFS: do not add new typedefs
#180: FILE: profiles/audio/a2dp-codecs.h:436:
+typedef struct {

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#183: FILE: profiles/audio/a2dp-codecs.h:439:
+} __attribute__ ((packed)) a2dp_opus_g_t;

/github/workspace/src/src/13543351.patch total: 0 errors, 2 warnings, 70 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13543351.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0818751812400371184==--
