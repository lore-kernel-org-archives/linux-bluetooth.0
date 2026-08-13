Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20EA36196E
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786617004; cv=none; b=fDpx1yYlzR40GtYZWOdxFDDIKuNBYjEYNpcCbFSwF1oGA6w0B9BAT7+zeKXesbwYFnGBA+NSZwNPC7H0E9uMgwIjK9HcHhYvZHxDQM4DpagnMq9sYWKIbtycwihMuDumGg2SriUWAcR3ZKwF9b189/9ODYuN3Ius9U/3Qc28vJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786617004; c=relaxed/simple;
	bh=sgk8b2sm7mGHkt84H2hPWLZup+Me5lkss4NUXE07jiI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ze3OHAbRwmCDRu17fV0dUhdM56pTb4YyP8+GCzeRXqB4YetQCdtm0VJsTUzJWNpRPjbWUumM6/+REZ8T3MDL3YoZZdZhvGznl9eCZc2QL6uEPv6/+1CRflRXMQg/z0JzHNQfWWoiagTBe1lLYnho30c4uAm0nFRj+seLmG3LpAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyISZdV1; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyISZdV1"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cedda2ce6fso12982455ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 03:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786617002; x=1787221802; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qABy3NzKtZZ4FQ9RKBwgV3JJvRT5jXMGJXsdqijvpl0=;
        b=DyISZdV1/iLlbWn6hXn6W40G1gNe2MDFJUnlJ7/FCy/lfP+Idh2W3r8ZVod2NsZB6D
         AcjKQLIJJrihiOEZMYH84OxDCktgHHRDHuBDXf2b5T5wUMop209dd9DkNZyCRGu8cvix
         NvOUDbvuEJaXo1Hy1CFwGdRAiiNr8TcV0dMr5D5EAfkYKj9OJVho3S9PmFp021uFmDfh
         D+O5zKjrwdUPLMmWd2t62QBmJamKDHlBPpL4/SINGE5Jsgx2WmuTBxWbpC6N/zIDN1Fi
         85f5hNVyRPgAu4dfpamk/cH4Z0qEkRakmjwzfDIEqQmsSupQVYPOzH6siIT38l6Q0uhz
         oYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786617002; x=1787221802;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qABy3NzKtZZ4FQ9RKBwgV3JJvRT5jXMGJXsdqijvpl0=;
        b=Lgo19iBq9mPbv/VFYOiQ9HIP8J6F5fcvdztpmAxr1aHC7c50LH2zwc7YDJ0ggQwe75
         qcpSu9+xQieG5v3QxjDpRdUUVW/tXO9OeiiJ+Ny3uOXVgdmHkHlAyE1clyZlT5rTMOte
         edBpe+5xOnBmkJwNeHVHC+A/5JijP4D2AWAdaPUzUou20vep+d8W8fv8iDWC8bDwtIcr
         0Q7/RH5OGT4fbSOraZnXO/5bjbWqouEfFUAStUnS/KjPoVMFbCfh60svNoXJ4+20s+6w
         yxk2KuQEPg4drqx6kIEcCmIJuc0crczc7uGW+3ttS5/DImKuIYwo/J27jDqFjbTxWPq9
         aY3A==
X-Gm-Message-State: AOJu0YxNlZO/LqpCCYmebqIC3UOV3dqz7jQWlJo9INmQOSjtx1K2UFuM
	9EyBJBZIYt8vhIGeOySJW7Kxj6GJRdlU/Vd4IbAXiqfwixsMIBbPF/gA1he2jw==
X-Gm-Gg: AR+sD11pL3sVrnMTEkrJNm6MiEu9g7+EkqVmMtwNM4rj0euWfniGE2C3oTBlK/khSe2
	wBt65dSBIV3TvHzZfQEkITdHNU5KZ56lgtE0Vr3UZskvRazwxrUeJtjoAb4Sdapfvo7M4XtkCI1
	3KjJ47l6esdtDH+yTekvdihX/BIB6no07FHeAc730zkAcQV09M3Cyrt54/iIfG4E0R6mkstvWZI
	AuBYLyqDAAwQdgl7F5yEFzFu44B18QXzK2fqzUOK+VIsUWpEZilBTGnZ7n8plfx0iNm/zmejjIQ
	hF6zIZNfb+tlMtJ8MxFgYVpSbDvYvwLxdd1OloTVmq2FQ5ahpRyPtzUCWJuNr5ujV6n/stZATEN
	4fM+z93GTly65AcYK7UvZ3yi29KMR3GvO/ZEJnAeba2WXLyj4o1DWHiTJWfFXRnFDeAx1Mi1eUt
	0ch2NIRZ4h9Q3RJUtGc9muxhsoB4eruZvYWDhok2KDziddQSCvaXK9+nEMZdPDG2nptYJLZw==
X-Received: by 2002:a17:902:db0a:b0:2ca:53e9:1277 with SMTP id d9443c01a7336-2d37d57ca88mr47628475ad.1.1786617002004;
        Thu, 13 Aug 2026 03:30:02 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.210.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c4e8098sm7239785ad.84.2026.08.13.03.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 03:30:01 -0700 (PDT)
Message-ID: <6a7d9ca9.b7b4cce5.26c54a.2b76@mx.google.com>
Date: Thu, 13 Aug 2026 03:30:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7449095623589692808=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: adv_monitor: Fix buffer overflow caused by integer overflow
In-Reply-To: <20260813091937.2600061-2-hadess@hadess.net>
References: <20260813091937.2600061-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7449095623589692808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1145281

---Test result---

Test Summary:
CheckPatch                    FAIL      0.85 seconds
GitLint                       PASS      0.45 seconds
BuildEll                      PASS      20.54 seconds
BluezMake                     PASS      601.93 seconds
CheckSmatch                   WARNING   325.33 seconds
bluezmakeextell               PASS      102.25 seconds
IncrementalBuild              PASS      609.37 seconds
ScanBuild                     PASS      989.74 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/2] adv_monitor: Fix buffer overflow caused by integer overflow
ERROR:BAD_SIGN_OFF: Unrecognized email address: '@ax-nnlabs (for merged_pattern_send_add_pattern())'
#76: 
Reported-by: @ax-nnlabs (for merged_pattern_send_add_pattern())

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Aisle Research (for merged_pattern_send_add_pattern_rssi())'
#77: 
Reported-by: Aisle Research (for merged_pattern_send_add_pattern_rssi())

/github/workspace/src/patch/14747617.patch total: 2 errors, 0 warnings, 54 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14747617.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,2/2] adv_monitor: Ignore additional patterns past what's supported
ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Aisle Research'
#56: 
Suggested-by: Aisle Research

/github/workspace/src/patch/14747616.patch total: 1 errors, 0 warnings, 17 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14747616.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/adv_monitor.c: note: in included file:./src/shared/mgmt.h:95:25: error: redefinition of unsigned int enum mgmt_io_capabilitysrc/adv_monitor.c: note: in included file:./src/shared/mgmt.h:95:25: error: redefinition of unsigned int enum mgmt_io_capabilitysrc/adv_monitor.c: note: in included file:./src/shared/mgmt.h:95:25: error: redefinition of unsigned int enum mgmt_io_capabilitysrc/adv_monitor.c: note: in included file:./src/shared/mgmt.h:95:25: error: redefinition of unsigned int enum mgmt_io_capability


https://github.com/bluez/bluez/pull/2398

---
Regards,
Linux Bluetooth


--===============7449095623589692808==--
