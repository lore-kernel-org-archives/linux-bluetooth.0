Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638551BDCF
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715363666; cv=none; b=D3/H2ZoqKnNQzV7CnEyZOI9dc4WfIecxf1ll7PIzo1iFDKIgrcsi/f1gDIAUM+hB84OosClYX55CLzPhu/eiNo0V4Hpc+81/xKI/0gI7sy1Kvc1ZrYzh1pmvva0RtaEhQItP/LLaGZsemqVBNWP7KMiYhgf+H1uoFvP38yvfAzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715363666; c=relaxed/simple;
	bh=hGoEWgindiRT6Vk+XOyt9W31yHai/vqtmBqLrgsoFQ4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ip7A51Riu0voPOgdsU7982ZgwxvNDzidtlWthkpcB/tF2vuabK1Exnpjo3JX2ItWjqqYfF5v6ltAiohQkRqv9rBhi2yfX54Qcy+ipKB/N+AM7cqoB7akvLVwQH6sdpdr3isxMjptVo/Idtxugb90hO++7xi8fKhI2BVmucOb7TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ak22BdMx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak22BdMx"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so21051675ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 10:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715363664; x=1715968464; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RdVY0gqRJfaMIeaqbCIEEne8xg0SWFlSVtqfye7T4yg=;
        b=ak22BdMxjSzisg9Y9R7NRqdJQlkb4mFc7I2yRu45ul7xYof84mBYFzSQH2vfQbIFqG
         vwqRJYcdW+f0xqMOT4myIOv8PxwXK3WvqT5UdQnxxoj2Tew1g78pR5LWMWkv5GCjZ2En
         uL5SAiVB1lfWMV9ZqHH/rAphRX8MHsiESQWWYOinxiMPuejrj3g/WjbZ7FdVkmu9C9Xa
         7s8qBymRAaHVDTJcYMaV29Xmt8Ixw4QYNd04VAZZg7O1alXcDtT5eHqduC7Ho/gT+dhT
         kvQMWDIaRvXxW1Nl4AXVtFPfirsYTbQYZOUQacR0gjr1dZCLtUrclRRmurjGa8f2xQra
         ZvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715363664; x=1715968464;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdVY0gqRJfaMIeaqbCIEEne8xg0SWFlSVtqfye7T4yg=;
        b=I9M5p+gRkrK+bah6mHYR85BPshMyXgVP8z0IJD1wzS9UYcXoebYbiKbNZOcTshz7QT
         VSFHFg6j//XgfQC1jRXka/VbbfIl1Vg6fUT+X7pnbQ6bCf2+QLHh7A8jVRpoPEzAulE+
         3jOLPC8fM5pF08PJGhzPkFIc/1EAV/5uNuJm8xQas5dG/wDJR0p6fxuJTueLnbkruNGY
         kNPYBmrqeuGtUgxK1W3Y6dTpD14RWB6JSUnHfOXs6B5cjm1dtckMR2OmhIhXtqs8drmA
         usJikoB5v0BTmy3HvCT5WNyJsVlBnUA21nOpkZTegTHPZDkY2Pc/fj91u8be0OTtOP8R
         JKMw==
X-Gm-Message-State: AOJu0YxaR6L5q6vcFCflkvHkdfcu1bLtLJ1C3Cqa8Hxf0+HNAT00mspy
	FTAHzoS6+HkNLB1gYnnNu0GiuQRg2FFX1Jq+siNsKLngPghsJhcxnOzmrw==
X-Google-Smtp-Source: AGHT+IFxnZFEkSeQwKCyi30u19TOQHnKOObqyJdgDaanhGBAnp7smjoz41yyOQypX1q0OlFyi8smCA==
X-Received: by 2002:a17:902:e5c1:b0:1e7:d482:9e07 with SMTP id d9443c01a7336-1ef43d0ac96mr42922155ad.12.1715363664428;
        Fri, 10 May 2024 10:54:24 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.137.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136a12sm35098105ad.251.2024.05.10.10.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 10:54:24 -0700 (PDT)
Message-ID: <663e5f50.170a0220.b5100.9e06@mx.google.com>
Date: Fri, 10 May 2024 10:54:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4242753600340686389=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/4] profiles/gap: Some code cleanup
In-Reply-To: <20240510150938.1492169-1-luiz.dentz@gmail.com>
References: <20240510150938.1492169-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4242753600340686389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=852343

---Test result---

Test Summary:
CheckPatch                    FAIL      1.57 seconds
GitLint                       PASS      0.81 seconds
BuildEll                      PASS      24.18 seconds
BluezMake                     PASS      1646.05 seconds
MakeCheck                     PASS      13.67 seconds
MakeDistcheck                 PASS      173.75 seconds
CheckValgrind                 PASS      244.10 seconds
CheckSmatch                   PASS      346.75 seconds
bluezmakeextell               PASS      117.90 seconds
IncrementalBuild              PASS      6038.21 seconds
ScanBuild                     PASS      966.73 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,1/4] profiles/gap: Some code cleanup
WARNING:TYPO_SPELLING: 'unecessary' may be misspelled - perhaps 'unnecessary'?
#91: 
Just removing unecessary function and code duplication.
              ^^^^^^^^^^

/github/workspace/src/src/13661723.patch total: 0 errors, 1 warnings, 89 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13661723.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4242753600340686389==--
