Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8E153504
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851818; cv=none; b=oP3Uk0zISe1XH+hQxa7Zlb3Q3NMkxZwSoEfKuQzq2huOQP4u2efWGpkxXGmMUk67oxd2DZunDp7qY0kbsR30Sth5zLkma/QjxiG1RoN+A8yPAm2yk8zZCSfhZAwivIBxxMZZLkgyZAIIlUTXDpYA96tQfHtGj/AMTXASzQ5HpAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851818; c=relaxed/simple;
	bh=Q/Lv51Vzze2nUKHJhnooxpamAXmLnbUCbJ7kzLULJr4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PXQ3tkG3vRSHdHVJwrN9Gfz8sitW4kiQksy4nAIQzn2IwX2xlf0DFShHmE2K5SbdmagHCgIsb9+cPZvpX5SHfHCQlJ4xPuCXrMFdaAGa6ML8vMJbLv2eIfK4SEJvTvpoe2HymsIAzjdKllTLrLFHT1olIwoYysAscMlnRuH5ktg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHf9tq8B; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHf9tq8B"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78d5751901bso369415085a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 09:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712851816; x=1713456616; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oRBMolux02kzalJse8O97MQ+c0cTcqvzwJvMG6VL260=;
        b=kHf9tq8BmmT8gKNgFS1Vbe4ZDUlTHuZLKhDFFSS09lIHtEy2d49lp7YybwVRS4Nxxy
         uRgeMOB7L5yI9uJ8ctznZ0V+OA2Dh5yIRZXfQSI54Hca5FMB2WdT9fgHuJtEY4MOWXm7
         K/9wPnz5+eFPa9CUrqCTBfpmjZoky29ztPJrfEO8pKrnuyNRvcuvDr4WwtQ0F271oPnd
         1lgpPn+VlBhIDrnx4TmJXFxTpPMmt8yu3gB2KorTMXQ77OGGs50cASJSEHhJoItO3px3
         PKHdAm65CfWc1orlhLLxIyw+nl5V+9oJDuJbb4A+D66A8+8WFEquGaGFKQpepakjEEC0
         +W5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712851816; x=1713456616;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRBMolux02kzalJse8O97MQ+c0cTcqvzwJvMG6VL260=;
        b=BWK3Ux6BGeRfAbC29tZfwfisbEZWwvmaoh69MbtkjfcdsdiB8Os+V2IAbw0rvrIFZk
         D3rFFNG4LVhmM6gXQ69qTmsbu9Cah6vOwH8q59TC0pJEp2q7mKFvS+TtR6aEPFyA+6M5
         ddB7Z09xBCVAzrm3GCdSUJPZwVxZ/jP8WaC2++8CKCWZaWay/C2ZXNd9JbPpW90cxnrw
         ZH3gu9806vUMasiX6tKNUi4WtotnRs7G2kkS8VTuZSiUArw0tQGOkrtC2TCnMdWo89oU
         qUMScCBguhYB6f7Sj0FA7/ItbK0rpwOMl47yYZLk+ROir+L6D/d2ac7XdfKwGAfE3Sm1
         Q1Tg==
X-Gm-Message-State: AOJu0Yz1YyXQQgoRAf/FGC/GJaViS+/sCjLawx9nYGvJ6JCoGWOhO1Ey
	PXTQnpbOiPm8e+ur64JCpmzFmpMCQ3jLNzPKgoW7W3lZ8Lbds+Ud51JOuQ==
X-Google-Smtp-Source: AGHT+IF7S3yH9gm2pgjWvXLFaVSjE2BkSv+z5JWqcLwcIKs1YENR3Q11+VJgHAIwMn5Kip11b2CLFw==
X-Received: by 2002:a05:620a:2198:b0:78d:6fe3:cadb with SMTP id g24-20020a05620a219800b0078d6fe3cadbmr110759qka.8.1712851815704;
        Thu, 11 Apr 2024 09:10:15 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.107.23])
        by smtp.gmail.com with ESMTPSA id cz31-20020a05620a36df00b0078d66c78d43sm1194787qkb.44.2024.04.11.09.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 09:10:15 -0700 (PDT)
Message-ID: <66180b67.050a0220.42109.2860@mx.google.com>
Date: Thu, 11 Apr 2024 09:10:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6503418094214650779=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] shared/bap: Fix not updating location
In-Reply-To: <20240411133930.96265-1-luiz.dentz@gmail.com>
References: <20240411133930.96265-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6503418094214650779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=843632

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       FAIL      0.75 seconds
BuildEll                      PASS      24.77 seconds
BluezMake                     PASS      1773.25 seconds
MakeCheck                     PASS      13.22 seconds
MakeDistcheck                 PASS      178.84 seconds
CheckValgrind                 PASS      251.96 seconds
CheckSmatch                   WARNING   366.36 seconds
bluezmakeextell               PASS      124.40 seconds
IncrementalBuild              PASS      3195.88 seconds
ScanBuild                     PASS      1055.92 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,2/2] shared/bap: Make bt_bap_select fallback in case of no channel allocation

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (87>80): "[BlueZ,v1,2/2] shared/bap: Make bt_bap_select fallback in case of no channel allocation"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============6503418094214650779==--
