Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E320D2E832
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jan 2024 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yd2YCRSI"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-781df3bc08fso109590785a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jan 2024 08:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704471551; x=1705076351; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nyxUk21RAv1HHd3os+UppugJ0c/PBwr3zOPieFyVm5E=;
        b=Yd2YCRSIkI7qSGqweawKZSm0e548v0u3R3RA1MegtsUL7eDQzfB8BYwVrub2WWWpRz
         usRONOR5aI9K8kBx2Fun50HtMXLpXqcpowTFsQaSLr7EOWP2EnxahOxWTxnyHSJJbQ1l
         C0w34PfIVv80vimLuiMtsycyYSbrvpeFOGWwDp8Z9HuxSkJOitfO0DgfPw0BXgw4C9U6
         QtB2RpvlssgKKPnhsDZhFty6U6xO29DyjXECj0Nrr6OgXR0l/U3BNHFefHPercJUZ7MR
         0D46P4omxQ5rS4Q+WiPXgj2V//XFojoXvs6iwt+jIz2esu2U6F5y+9LJud2CmfFkBxTh
         HszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704471551; x=1705076351;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyxUk21RAv1HHd3os+UppugJ0c/PBwr3zOPieFyVm5E=;
        b=w+7/XnRg3iiwQDEkij+NS9pX8Rk6T6IXzYjFwA7HbXUw5FKRuzvfzveaxlFe3MkVkP
         BS9Fo1d3mx+icbwrAkrBfaxUkKEIlfoodhmhMGriub10g093s99V/shIHVI/aYXQiSnC
         zN4cUJh5nTD2glO/PnIxflzf21zfmYvgHAY587GaXpIKO/438+85wnKDVUlOUJ1KW5Ev
         asZwQ+n6FdEa3KrejxZ943umZCTCQ7f45LINoDB300irYsBmbZPVqmK8V2krKOa5G/ve
         e5ETtR9Vgqf7Du0V9eoIKW1Vok578c+AzHbFq+mHw9MkuXFE00sIOVCaotOKo7hOnkug
         sMzw==
X-Gm-Message-State: AOJu0Yz01gchc/eaGzuSiSN5qt0sfc5sjjoKnejJxytPNsqh2gkKlXty
	UCcoR8kKGHdksIWsQBya9K3ol/TBoNA=
X-Google-Smtp-Source: AGHT+IHZT7Vu1xkf/zwkWY2WC/1hKN5cuNRb/Un5j1Pj3NnD/05dw4ld/UYe72xxmdTPhGASwtvsQQ==
X-Received: by 2002:a05:620a:60dd:b0:781:10da:5b59 with SMTP id dy29-20020a05620a60dd00b0078110da5b59mr2180712qkb.122.1704471551631;
        Fri, 05 Jan 2024 08:19:11 -0800 (PST)
Received: from [172.17.0.2] ([20.97.191.51])
        by smtp.gmail.com with ESMTPSA id x5-20020ae9e905000000b007815a50e509sm683054qkf.103.2024.01.05.08.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 08:19:11 -0800 (PST)
Message-ID: <65982bff.e90a0220.4c93d.20f0@mx.google.com>
Date: Fri, 05 Jan 2024 08:19:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0898000399949280392=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add support for multiple BISes
In-Reply-To: <20240105143334.7248-2-silviu.barbulescu@nxp.com>
References: <20240105143334.7248-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0898000399949280392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=814685

---Test result---

Test Summary:
CheckPatch                    FAIL      2.75 seconds
GitLint                       PASS      0.75 seconds
BuildEll                      PASS      24.69 seconds
BluezMake                     PASS      726.12 seconds
MakeCheck                     PASS      11.98 seconds
MakeDistcheck                 PASS      161.48 seconds
CheckValgrind                 PASS      225.86 seconds
CheckSmatch                   PASS      328.67 seconds
bluezmakeextell               PASS      106.42 seconds
IncrementalBuild              PASS      1355.43 seconds
ScanBuild                     PASS      957.46 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/2] client/player.c: Add support for multiple BISes
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#96: 
Remove BIG, BIS, and context from the register endpoint command for Broadcast.

/github/workspace/src/src/13512234.patch total: 0 errors, 1 warnings, 438 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13512234.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0898000399949280392==--
