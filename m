Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5F21799F
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 05:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724823814; cv=none; b=t0D/8XRgQrrovrPfXpeKxt/Rb4Dg6pJwDltjG1CbIMPAfvpWd0W2hh3H818fDm/t86huZwYAHLmcaHTKoVmaNJmeNJIuzwXHyHIfGIv/peG9AA43BSE4c/37wXZg1+42e8An0jMCuB3DvwBb9X7UlDi10XHiXNW5defDKgsIcLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724823814; c=relaxed/simple;
	bh=orQ3/R7nzggV2wUCF1v/JuQ6TJe8ELzjEJjRY0Mm3/k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DyQ54l8MAuDH/iiGZprAGIlVVBHU/svkA/SBstW0Of630cQ5vCQiWCvy41kmQ5QekZWtzVjoBHDnUrt1Y4llp8qTiABsZcP5lfz3NGMf1HGa8qpdPK95GvEOD6bOX7akV4doFbWRuuPwLQfJHwB4Jf50+lJTB+FZPALsJMGSMr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRPpp6kP; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRPpp6kP"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44ff6dd158cso35184571cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 22:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724823811; x=1725428611; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EJF3MBsKWdv3uwiwzhCH8dRYHNUze2Wn9EQlV+vzu6s=;
        b=cRPpp6kP+9vp+2kC9GnxFkYOjEet8OjsOnkh2QjHdh5E/rP6CS081C5Qr8qCuc0GR9
         NvFbOxrNOYyujVXKl18imQqiqWkn0YAQbMwMwY05pgC9aeHcD5zgI2SEeyOAFOLMpLoX
         hTXVin0WOqontCw3BsLqf1z9/QKugMJPQqa2Np4aizxDNeM+BSR6DHTSDUgexA/a+lBd
         uVqAbZXUVIvjcW2Z8HZvzLEdopTyMS0avPUxMJw2yg3+P2Kyipi1oAmj4/W4M8HvNfMJ
         bzAeoypczg9rrcwPsJvPaOKLBGW3MY55MWeewYmitExaabIRSyoS6rIebzr01/UlqSx3
         NJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724823811; x=1725428611;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJF3MBsKWdv3uwiwzhCH8dRYHNUze2Wn9EQlV+vzu6s=;
        b=ioKs/TYfR5jZWkIqCDbO/qILRzZG1nSG30y8hFiPU6Q952Lfuwi8XvVFwGT/yv5pZy
         JZnx79QsjiJ3pA46Es59Jak1kMWVGfAZW3C/nMzYA4yqS14KR8Sy8Ml8i+xQA5KZo0tq
         kyS0W6ZwbEYxIYGtKmo7XW2p5xzr1WNGpefaMWMx5irrocQRdHYrPpmTiYGdW9Hsw96Z
         SpwjIgUpIk8L4vW9R25rngt2gsrRrWHvsaw9P4VkghxyldWXC1W4PkKKx6sS1eyszyNh
         uNACgj+zn2orfb5vY0ugQMkz3+mJSRYroOHpGnTTH8Usz8s3/cAV+5MBaVw0t+jp9XPg
         K9Dg==
X-Gm-Message-State: AOJu0YzFdMSqB2cXZSon6mZNcYDJej5wCb1wGVVnCaKG1bNLYslYZmkU
	V3UPLGKXsPuTpaVjSqDdmtDhSjiIRhZHSciw9z/5hXwRN2YkkNHSpU18Fg==
X-Google-Smtp-Source: AGHT+IHAvL10zQ0XB/ljLoJu/bGvL+v8oVTNp//X1oPQEiDNiOx/9xGTsvRMo5VyHMNiCp88NqNLRQ==
X-Received: by 2002:a05:622a:488f:b0:44f:a251:2c05 with SMTP id d75a77b69052e-45509d59828mr210041831cf.59.1724823810925;
        Tue, 27 Aug 2024 22:43:30 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.132.30])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fdfbfa29sm58893481cf.17.2024.08.27.22.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 22:43:30 -0700 (PDT)
Message-ID: <66ceb902.c80a0220.23dfb0.68b6@mx.google.com>
Date: Tue, 27 Aug 2024 22:43:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4379404739759053893=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raj.khem@gmail.com
Subject: RE: [v5,BlueZ] Provide GNU basename compatible implementation
In-Reply-To: <20240828041644.3331363-1-raj.khem@gmail.com>
References: <20240828041644.3331363-1-raj.khem@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4379404739759053893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=884060

---Test result---

Test Summary:
CheckPatch                    FAIL      0.63 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      24.68 seconds
BluezMake                     PASS      1683.62 seconds
MakeCheck                     PASS      13.42 seconds
MakeDistcheck                 FAIL      68.17 seconds
CheckValgrind                 PASS      253.06 seconds
CheckSmatch                   WARNING   357.07 seconds
bluezmakeextell               PASS      122.25 seconds
IncrementalBuild              PASS      1465.75 seconds
ScanBuild                     PASS      1043.98 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v5,BlueZ] Provide GNU basename compatible implementation
ERROR:POINTER_LOCATION: "foo* bar" should be "foo *bar"
#151: FILE: mesh/mesh-config-json.c:2699:
+	const char* node_name;

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#177: FILE: mesh/missing.h:17:
+  const char *base = strrchr(path, '/');$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#179: FILE: mesh/missing.h:19:
+  return base ? base + 1 : path;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#228: FILE: tools/missing.h:17:
+  const char *base = strrchr(path, '/');$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#230: FILE: tools/missing.h:19:
+  return base ? base + 1 : path;$

/github/workspace/src/src/13780500.patch total: 1 errors, 4 warnings, 89 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13780500.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

Package cups was not found in the pkg-config search path.
Perhaps you should add the directory containing `cups.pc'
to the PKG_CONFIG_PATH environment variable
No package 'cups' found
../../mesh/mesh-config-json.c:31:10: fatal error: mesh/missing.h: No such file or directory
   31 | #include "mesh/missing.h"
      |          ^~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [Makefile:7850: mesh/mesh-config-json.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:4676: all] Error 2
make: *** [Makefile:12226: distcheck] Error 1
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/hex2hcd.c:136:26: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============4379404739759053893==--
