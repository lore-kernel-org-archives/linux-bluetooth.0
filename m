Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4969923EAAF
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777915609; cv=none; b=lnBWyLOkDCcXhKQILGf2JF3/1hFjNF3XpIMXFgUICPZ+CQFoT73b9lMilAlGOkeFoFEu0PFFiibeq9g4dv/5VPCUNXqdvTdATKhJg8b8Jsphxy48K3UrTThSiRMCzbGfrCIKX7nqqG4rBBGLZX9aN1z1EVZ4fGc3tR9K0rXSNP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777915609; c=relaxed/simple;
	bh=rCwxyLDHxq+kY4/ypnpM67QRNaOM4/alPzOSBQJJdZk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fXtIjPFG5zSbi0TE7ZaNjlzJYO7nA2VhVCGTQ0NCCFQhqKMbJ5cExZS7ISDfU8l0iq4ufUlOotXBjORVnueIQY/A/qORILnPdmOEoYNxqJkegAXtQ7CU79EBi6vSGk5J3qSUkJDz+sTlJwyXOfNFuFRywon3JiMPWQpetPeoz48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhWh+8Xg; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhWh+8Xg"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c19d23b19so6223720c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2026 10:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777915607; x=1778520407; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fdFKrsHJp6Fzh3m2QiP7v2OVGgK9dvMjWtWRZcJvLw4=;
        b=dhWh+8Xga/Yk8SItWz2R7sNB235z9qEjkQ2lYR084Dsb5PU016tl74xurUnSAMCt0t
         cYn22QiBXRpKuAK79NZXlmfzlO1jYfklL/jGENugwyOabJqFRmuBY0qxcE4w3J3GBN+i
         /ZLuPqemeQgEmcvG6gR6VvZtU7jKxdNoxjR9sfE3etHNPa1U9dJg6Ln/EyzLIJyVnFdE
         fpqrkn2swk1WxI38P4wBzHRqtu2r2bPpahemXgaeZRm8Lu/bA7FXGg6vnVmUrR8iZ8+g
         mcw07ISNHG4iibZ1nY84zVUjOHFlfB2CQmfBUBbKq7DoHk6iccxKY1NWr3CxcHM1VKnO
         cWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777915607; x=1778520407;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdFKrsHJp6Fzh3m2QiP7v2OVGgK9dvMjWtWRZcJvLw4=;
        b=WsBONJ/1vhnxaz15pA1zZoJBd+cDORvyKFyolwD6ti3ST63wya0mItju47KdOxT59r
         tsbLIhC/LIHtylhTV1MSRyIKcck51WtD4yeaJPjV8nWefctgoYmCRxjUZSkSoegimhX+
         54p06UwFbNe76cNoeU/bIJhg3VJfT2J1YjyCzj+LgyOH3Hl5fUvOwfLUGrPb4Bz7wOub
         tjOF/A9vvNhFCS2CHmmk4esuubNUoXekmezWolYsm8bZJrKa7/lbK5euHGEdBpz0u5QD
         XZfOWH4UyNG1Vm1qNLlu8eSKBMWB/06+1G7kkgwuAREwd4zy1rc81Hdt5UpUuKzvH/2I
         C0Dw==
X-Gm-Message-State: AOJu0YwSBjcEn/iSJ2E3ScXqNs43Gk7Qmlid47Si2R5b0agVfzgX/9+W
	kjaAYpSJMooHBRU/5I/Rl6n1K1n2dVriBGwEHwzGiVpggUfezaPgqIVdjYutlQ==
X-Gm-Gg: AeBDievvHdaUzDlnsdDMoweZwGDs04AeUqoqWpJQTS+pwLaM54Ahmp0NS5VteblMXcj
	iazAHMC7ThD12utKPzWeY2FCbQneWHIIRD6zA6Dovz2KEeSETUz+mxEH1Mk0cLmqjpIY9Xpm+Ni
	rI7FHRVvs2mHFvszKS741tLQOTWacCYD6iFa2nwHws5K3+LedVsz/5+Dhi4EzuD9tfjhs4d4h7E
	AYl4Xd4PPfqXUOvAOjoGC+UP0FxrUPTBSeepoQ3lWuc9bQ7v6AxBrLeq+oSWBEKYk9/0gaO7MB1
	xEvdpGjkvGbIoimyBxiY07iVmqhaDchxq/WvgFrlUSMitidISjRew9olpD5N2XNFJWQiUapvwrI
	3pwV9laAi7guYYFp/P7Ry3wQor0bmZdRgfVGTmR/NBJepDO/xTMH2y+1pEsaUqwFNxFtvLv+iqW
	67SIz2ETGx3M0BPjtLRKU447NgCOAoU1+HFPIyeTnshQ==
X-Received: by 2002:a05:7022:6624:b0:12a:6b3c:de54 with SMTP id a92af1059eb24-12dfd82c2a1mr4895049c88.29.1777915607065;
        Mon, 04 May 2026 10:26:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.125.136])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df8431037sm16842603c88.12.2026.05.04.10.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:26:46 -0700 (PDT)
Message-ID: <69f8d6d6.050a0220.3955e8.f5f1@mx.google.com>
Date: Mon, 04 May 2026 10:26:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7892121030898705424=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, admin@fluentlogic.org
Subject: RE: [BlueZ] sdp: fix overflow in sdp_extract_seqtype()
In-Reply-To: <20260504160118.26675-1-admin@fluentlogic.org>
References: <20260504160118.26675-1-admin@fluentlogic.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7892121030898705424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1089386

---Test result---

Test Summary:
CheckPatch                    FAIL      0.34 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      20.37 seconds
BluezMake                     PASS      669.02 seconds
MakeCheck                     PASS      0.90 seconds
MakeDistcheck                 PASS      247.28 seconds
CheckValgrind                 PASS      222.09 seconds
CheckSmatch                   PASS      354.69 seconds
bluezmakeextell               PASS      189.55 seconds
IncrementalBuild              PASS      643.57 seconds
ScanBuild                     PASS      1054.69 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] sdp: fix overflow in sdp_extract_seqtype()
ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 31e4fb1498f4 ("monitor: Add decoding support for HIDS 1.1 flags and attributes")'
#68: 
covered by commit 31e4fb1.

/github/workspace/src/patch/14553286.patch total: 1 errors, 0 warnings, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14553286.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2092

---
Regards,
Linux Bluetooth


--===============7892121030898705424==--
