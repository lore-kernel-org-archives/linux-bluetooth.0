Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CD81FC7C5
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781442758; cv=none; b=I8/hQLcH4PW1jAbnQdHU3o773UDSWGeqVZrUkJl66//9kq2/QP75m8cEXJJnpneH90G45+IJPCrEpX36520XDe4AS/05S3EkAujv+UqavQLbt2RTisW3jo0HX0gnMUcMpirtSPofoaO92Dis/igWusYF7xKMqTd/19gq5er3rPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781442758; c=relaxed/simple;
	bh=1f38RG9/sZr0Wrf0EbZgYD/NnaUaFH5nm1BolufFGGQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lV1E9e9sbZJ4GIv9sdz9FE9JUJpH6X9zslLqAjOe8oB/mCTIi22rPkxLCQVx66CAoN67yNJ029bJl/JWhL14WKZCa3d6cA94Or7cLPdE88lzS85BfKmna8zdnNl79OwmwMJyVM+C42dFXXKpXnTL010iBjJ1nboZQGKNZPvY8kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0o6aik3; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0o6aik3"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5176096116fso30177521cf.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 06:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781442757; x=1782047557; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eP/qZI9A9c5EWUlVkRnFd+Nms8TDxZQtMDw2kP/iYIY=;
        b=k0o6aik3lvBGFzPB7AuAXz91/cOiXqaKW/opLhSfCcF8kmMt8cddsvWuqrvJnVOzkI
         lpHj+RqJL3fAq6kQPiI3gKMALKlmOogVAwAc7pi84pCvIJ6JutweWujycyX9MabR2CzS
         JzdREzWTr0x0PQ2FZM81WYZbwj4Ai44J/wsxy7kmiD8raTl0I5uJcAmWb9YflYfr7wJy
         Te6vSVD8d1R+hUM6ZT3wL5JYim9L/HEqlKmUiR0CBgHotIFJ0CZjPsvGguGbUWijMGm+
         JgNPwZA9T6MKb+36oeL8C6Qrh5RYiDyrgF2wn5ZczhGuxrEXFS35iCMYIN3sGnu+NpUb
         06EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781442757; x=1782047557;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eP/qZI9A9c5EWUlVkRnFd+Nms8TDxZQtMDw2kP/iYIY=;
        b=IZaQY21B0NE02FuUHETGJjkcluyxEP/vedcVwDLfRCySxboNsXqMD6Ncgjwy7EIL0U
         IAZ7+tlrpVQE6CrXkRqVwKGWNXnzHAMrxIGPmlIcRctgXyn1fJ3ZpooGOSKxnzkkCgrX
         UjDNyMTUa3fAQdp+XOCfW/8byyIp8LMFcDUGeDEcOT+wbn6DxYXfeL/kjyaJsAon+iLK
         JDEJ9s9LXHQQzSIOdz7yKajemgfsa231KPnbEGEa4d9r5cBXWUSrC2E1RGHJWNKk7RBk
         8nOR/33vHuJq1aJLqC8b/uNcTAvqfHYgxdqsMqrU4AIW9iCvZnRmgxWWB3vbs2fBv613
         kQxw==
X-Gm-Message-State: AOJu0Yy7M/dJ/DmstxHaDgsx/0KxZbytX7nVd6ekSxvniTVHQHNuSRjF
	WdOZcsmtgHr7sdngqNqT19XUgWMvk6iSwRG6CMA98KO/wZcAHkI6C3N2Eec3HA==
X-Gm-Gg: Acq92OFiZKnPuP3OnimU6GueMnN+YcOYCYRB4VrrTj90PO3vMLxVbiaUoKRrlkFIDrN
	/w4jSNUnDiduHSGqCtPVrpuJqCuxW7coJ9NEoRNf9AFZZmsF5p6cEx0t9WMxp41ogjr4CEMbfB3
	ugd1rk7nzPI0Ytl5gZun3EhBPTNh7rA27JIi719MPiAY7O1PQKYEI58lLVT8ABUWbtlUK1IJjtb
	6iZ2r3/D4sOy4cWKRKXJrPBC68+KisIz32/SMU0XARzLkxIA1OHiY4L7VJrnLhGbyXtAnEET9ZN
	Iwz3/26aWh+T4Wx0rlD/056JKY+aIXm2+VH2K1pxffPzXWrH26th+jt+lNrqagLdxefBAOJMMDn
	a2McCTxYtUjctn6PBjC817f/J/D8rEl8UzVoFSouUK+sq8AD2Wlhf2Pkz9/MNVs8ztq6xi2SD07
	bHjxls3/2YeHmhoXcqhMMSizyFvbwUb2h7
X-Received: by 2002:a05:622a:894a:b0:517:8aa7:4aaa with SMTP id d75a77b69052e-51953552d55mr81316801cf.39.1781442756547;
        Sun, 14 Jun 2026 06:12:36 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.157.181])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7a2227sm72106741cf.16.2026.06.14.06.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:12:36 -0700 (PDT)
Message-ID: <6a2ea8c4.b5fdfa5d.1ef276.2c3a@mx.google.com>
Date: Sun, 14 Jun 2026 06:12:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7577376937018351204=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ,v2,1/2] shared/bap: Transition ASE to QoS Configured on CIS loss
In-Reply-To: <20260614100208.1091560-1-simon.mikuda@streamunlimited.com>
References: <20260614100208.1091560-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7577376937018351204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1111249

---Test result---

Test Summary:
CheckPatch                    FAIL      0.85 seconds
GitLint                       PASS      0.58 seconds
BuildEll                      PASS      20.31 seconds
BluezMake                     PASS      653.75 seconds
MakeCheck                     PASS      19.29 seconds
MakeDistcheck                 PASS      248.27 seconds
CheckValgrind                 PASS      296.98 seconds
CheckSmatch                   WARNING   353.24 seconds
bluezmakeextell               PASS      184.97 seconds
IncrementalBuild              PASS      975.52 seconds
ScanBuild                     PASS      1043.13 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,2/2] unit/bap: Add CIS loss test
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#102: 
Assisted-by: ClaudeCode:claude-opus-4.8

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'ClaudeCode:claude-opus-4.8'
#102: 
Assisted-by: ClaudeCode:claude-opus-4.8

/github/workspace/src/patch/14628094.patch total: 1 errors, 1 warnings, 92 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14628094.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2230

---
Regards,
Linux Bluetooth


--===============7577376937018351204==--
