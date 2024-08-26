Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C0878C93
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724701816; cv=none; b=HS9skfr/BtTEjnWOCT7J0EDQaY7uAaJjsmT1/G4MDuLc4IlF6CdB+EyTw7XErTJk6k3wNsrnbgpbRpKOAasghrQTjNglqgCB+W4lWcshRMWaXAhj2XPZc30VvGyXA7UT6evedpE6nRZ+5ZkgQ4ANQKiyT1wjFudDsc5YXaSYs+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724701816; c=relaxed/simple;
	bh=AZiGW5zvrONeMH2brhsE/pLHkucTa9zaqCldEgmDxTg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LXqUXl7uLkk+I3ZWADjzOncd7CHNX6TFNES0kgRWr86QfQPI9grbOTJ/68zhZztAFYUsSo9dFR2qjSRmfFrr2AsSJYVACSrxQKzHd6ZOg6cUlxjPaSLmqBva2ta6JjgqGZKviH8XKMu2CB+PNhm3aKfTIX/HFaFzhvHjdnpxxQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjbPLL7c; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjbPLL7c"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-454b3d89a18so26149841cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 12:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724701813; x=1725306613; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K2OzcWbNSZvjv8Jy4wyHaw6ZnL1/hQUkb7RRvCloISQ=;
        b=CjbPLL7c3BiJyCvz824IzBsGleifH+aomkKjixoATNCg9cNOm93eGvxLW5ysmWnS/N
         P94LZek/lR1/hY36fNCe2JR8TBalItgBFT3sOJpZiqmtEYChkivax+D526O2LbFYT8sl
         EK3Yi4No70JlCYUeyL7jc1d7I4WQSLubKSo4yo2rDg0QcFgVX/bcNk/pQn4pnBInpjE8
         NFhZwAg0jUrl4qI7kmU1eXIk2Z6jpaF7Etv3SNaTuxv02MPhyA8y4TIrRZWv+vqQR22Y
         Ehyd0QTFgDQy60kEbmJHuPuS5abAZ9johjs1bWmxTGPLcKITLMkfplIGFn1A8aJvJaXO
         j9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724701813; x=1725306613;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2OzcWbNSZvjv8Jy4wyHaw6ZnL1/hQUkb7RRvCloISQ=;
        b=aLHkYDIsm7P0trARFvH3T7fv3VPxW8yX8aYsD12L05oCWrrM8kNofkSslXml8ZM76Z
         FB9bBxbSdDu/BYo6+n6aY3GVCbykeKGuXKYZnwDkeq5Epjv0/0mNky1NNt4iUwdA0/q4
         16v1UfM5BYnKG6LJdnFczTaAUKrJ99YzhMU9F5DogK/kUNy+32zRr3ybKmiwu/ZcUb8k
         a7y5MlUxrFzh6SgPiLyGgiXHGLlXVE65QvVVJ+KKoTb+MshV+SkE6eKjPqhv2ylrbkjT
         lJxl1mcRA6B09BMikZfMuDJJXPFjaQo7gioV76T//0lbWbnUQ3SB2Odc+H8l3Gp5qbk0
         53ug==
X-Gm-Message-State: AOJu0YzJ5gbVlgjJxXOkGlcUnN1q8X+ppsiJCVC+2f0v1fWpRs91fCE1
	5a6Z1es2ubC10eLSB1TiVZDhfYxB0a+J7Kei4qn844lH7G1x0OhXrXFPbg==
X-Google-Smtp-Source: AGHT+IGuvG0Pd0m2dvg+MhFg2kzaSIP/aLsSdiB3Fc1VV9ytuNsiSDR0VwEQboIy//cXxyV7tJWleQ==
X-Received: by 2002:a05:622a:5c8a:b0:44f:e905:e606 with SMTP id d75a77b69052e-45509686180mr136175211cf.25.1724701813276;
        Mon, 26 Aug 2024 12:50:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.191.97])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe0df7besm46401181cf.36.2024.08.26.12.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 12:50:12 -0700 (PDT)
Message-ID: <66ccdc74.c80a0220.28bdce.0c6a@mx.google.com>
Date: Mon, 26 Aug 2024 12:50:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1611509074095089533=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raj.khem@gmail.com
Subject: RE: [BlueZ] Provide GNU basename compatible implementation
In-Reply-To: <20240826173844.2918630-1-raj.khem@gmail.com>
References: <20240826173844.2918630-1-raj.khem@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1611509074095089533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=883477

---Test result---

Test Summary:
CheckPatch                    FAIL      0.70 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      26.71 seconds
BluezMake                     PASS      1798.43 seconds
MakeCheck                     PASS      13.94 seconds
MakeDistcheck                 PASS      181.55 seconds
CheckValgrind                 PASS      254.32 seconds
CheckSmatch                   WARNING   361.88 seconds
bluezmakeextell               PASS      126.18 seconds
IncrementalBuild              PASS      1520.24 seconds
ScanBuild                     PASS      1079.55 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] Provide GNU basename compatible implementation
WARNING:LINE_SPACING: Missing a blank line after declarations
#194: FILE: src/shared/util.h:303:
+	const char *base = strrchr(path, '/');
+	return base ? base + 1 : path;

/github/workspace/src/src/13778304.patch total: 0 errors, 1 warnings, 79 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13778304.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/hex2hcd.c:136:26: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============1611509074095089533==--
