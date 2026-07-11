Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AF623BCF7
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jul 2026 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783768099; cv=none; b=jfw2V18IaaXYLlrV0iWCuhbGLlVwv69pZGSXptg0PIav0OK5dIKcFAneabxv4sKZpQ01rUCjSTdX/l4mwEyD3GTO7ipFOBkhtb6S46+1QfiGCTUxReRs41uQH+vB8XP5DYcw0q1iZIt8APosoXUGZI7USFVZ+WXqzsxA0sI5QWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783768099; c=relaxed/simple;
	bh=AuAIBORo9wFVHDj/CDYww77N21xFLbhMU45ZZiOkg5E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RyysqzTqeLzZZXV5vwUieVAqSekxGjbjw5h+KnGbSvLkUMOxitqpdpt05QyFe1/DeFBVJK7obT7mapIURRhNI1UgPyyxsNcAhBKa6EdTSxrGIrSjy8E0seEEAODcE9aqFqpw1l/n1OPhqs4GTDD/UAOe5VMe+T1oVUQMWJ9EC0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qpn86EDS; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qpn86EDS"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8ff88549786so17842356d6.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jul 2026 04:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783768097; x=1784372897; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BQkkvwxt6o+Z/3DyBTBlCKo5TrjkU5St4dz4OsU6WL0=;
        b=Qpn86EDSmxPkandFyNoxLDcn7XNm2LQ+lLraqj28jiEsGDe+JrKx+47PUj9B4mXY9B
         TmCgRlo2zloYwZH5fXSxZg6ln8vBag4b2/K4rWzW8ANkrFM2+6QFMtqVjcRxP2wCDD8D
         P8rkZ+b+MvsR6fNwHA4yq3jQGN73shejbbBppX5KDv96naYVAx6T3osgiunKDHX1d2XK
         /h5NRMEfEAlqhER0Dmy3CLk7QU2+lmY7U6HT9oLIhjHVwHSvWJ80PUoEbtxQnL00VOiD
         aNNh/cg3nckp31z9Nn5lvGXKk93tBStzInl0vdjbANgghWZlcxP/XTDq6bPGRBdEcDuk
         MZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783768097; x=1784372897;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BQkkvwxt6o+Z/3DyBTBlCKo5TrjkU5St4dz4OsU6WL0=;
        b=jqhJ0SWf+BU7QaIT4LrsZ245CpmlP0GmYRBB6XeEnL0bKljjgMiqlcptxAhpsjFxHq
         6GmOJUH3nKJjcV4zldWfY0Api+EAYGeLe/RBIWdL0k2nC7SZlhlOJbR6b2QftPo9u9F/
         kzYBwrUjiH+0Ov/6dmWLHcgS5q71P/iCP+y+YSD/4DyuTabnMk63Qc18j80AfhqrGYiJ
         QEsXAEngJkKYQZnUGg9miGCCEOoHQLCLGmECb6qkDQsoeU/BXmMI2dTuQciqPgeXx2sm
         458z/4q9C16EBPXqFTNaDIYRfG5KPuFZ02TBogo+gMA149CvrtiCUfeRQVulHZ3Ki4Nm
         7ZBw==
X-Gm-Message-State: AOJu0YxPae7T8TlVP/9nyM4hxKiurIKSOwF458PL8q99Jlk+HHq6p/ud
	ciYzy1eiAF/L7NAWj0MGzRahNfRScfqiMuftm9rf5Ct1Fi1ny0JEK1Kk96rwJA==
X-Gm-Gg: AfdE7cmsGLe1GWRYWtO5f7xhyUB6FED/qOSr1/LIvW0fmbunQQsYVDept/z+2kRHuMh
	9TkuB+i3dtBlJwdhulkENG2B09GqRYbaMT2Tewns7lbwJN058DPRnVf+bJUjwriYu8YR5FVCU9M
	I+b8a10o7B0WvWQ1Yr5blGr6E7AT6mcCG6AeWHapK0qcfMQBNzj+NpRKcXjyPxny239tShnU+0V
	n9qHhbDj4GRsP/5yD3yAOXvJu7dZq8D4tJsdLi4dhKg+z0BUrsond++MUfh5yc82ZTtfUJeZwFm
	3ho7HZ6KUl3demC8Av7CDuPzBvzUByQMf7Pz7pWRaLPzlaUTj651wKzag0+1qM4NS2CTJh1fAGQ
	s9RmrJ1e//AWUGqEQrJSDDsWYcMKrKAy6Y7qykguFYYUlASMlrud+uO+1gb2EVN8/63T1RmEGvr
	nx+ytdXmEAl3CoD0TiBQ==
X-Received: by 2002:a05:6214:2f93:b0:8fd:6e22:c7ec with SMTP id 6a1803df08f44-90402e5d7b2mr30509536d6.61.1783768097229;
        Sat, 11 Jul 2026 04:08:17 -0700 (PDT)
Received: from [172.17.0.2] ([48.214.55.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd80fd492sm68153006d6.34.2026.07.11.04.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 04:08:16 -0700 (PDT)
Message-ID: <6a522420.d0999061.631ba.7239@mx.google.com>
Date: Sat, 11 Jul 2026 04:08:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7318325280285514914=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v3,1/2] lib: add iso_data_* macros to hci.h
In-Reply-To: <e2b3c5425a653eb198700cb28c453607e2d82840.1783761325.git.pav@iki.fi>
References: <e2b3c5425a653eb198700cb28c453607e2d82840.1783761325.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7318325280285514914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1125775

---Test result---

Test Summary:
CheckPatch                    FAIL      0.97 seconds
GitLint                       PASS      0.66 seconds
BuildEll                      PASS      20.05 seconds
BluezMake                     PASS      498.38 seconds
MakeCheck                     PASS      1.05 seconds
MakeDistcheck                 PASS      151.33 seconds
CheckValgrind                 PASS      144.07 seconds
CheckSmatch                   WARNING   291.38 seconds
bluezmakeextell               PASS      93.78 seconds
IncrementalBuild              PASS      528.94 seconds
ScanBuild                     PASS      856.17 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,2/2] monitor: fix parsing of ISO packet data header and slen check
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#104: 
Assisted-by: GLM-5.2

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'GLM-5.2'
#104: 
Assisted-by: GLM-5.2

/github/workspace/src/patch/14680481.patch total: 1 errors, 1 warnings, 115 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14680481.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2002:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2299

---
Regards,
Linux Bluetooth


--===============7318325280285514914==--
