Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A923CC7C5
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 06:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779086173; cv=none; b=Nm7TVVteDiK/reIMqfG8lsDjZlhYkwEADS3RaH8DUVZS8PhYSrTA9xF45s+KR/OPDA9cUaUabJxAOBMEqZX+4iyrEkFWsRn2mcJappwpjMTNxEmuZ3D4/qZXDQHABnCOLjldWlG/3cHr9v1fZwnIxNUMzeRzaqeoSKKwjF+6pU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779086173; c=relaxed/simple;
	bh=lO6byPn8rVKDWrPvQrXj/QoNKOUm4pvIdLh8SJFeGBY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gGaKoJV7cW/fJo/hDgWBzPH0B1fAoD90uoaNaIRGkqXDrFs2c9oX3ZrXap6tUb8H0KFRAslgkl7kp0ibrEuacV6OIXd2SXYZZjxbGYArbTeL8uDobZ+lje8dOTEX8mVwCYH/QvJWUsW5I4uNDpvW+kZqlBT8SBbiF3jkcGypqL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGLr2DLh; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGLr2DLh"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-90cbb2b50ccso155016885a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 23:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779086167; x=1779690967; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l1rvBBEpbQ06jTsYZKBaRFiFWxLvSm3dDYkTpS+9/z8=;
        b=XGLr2DLhPYGrmaqYdUPOyloMK4s5zakXS7NBwantMRGdpV/LPKbWar5+g/vc8FH8RG
         vc95m59kKT2MBIqeXRs7sKNkHxolRbadsrPm1NnTz/you/+I9qJCPRLc5h9okpNTgEEy
         PGAuPFJOFwsGv9ua1Fg+ye+brGGXa1Air5uNpnKuTeFRQCihHf5csY6G74Oe6125GtfB
         tXHKLDr7zBhA3dY32JCVWd5I+2cLzG3c9+UsLPyN+5Dg/rDBk/8BrUnQLpMtbA7iikMf
         B/7mv6j1PPvvkgG5bWGo/pOfJe/KzqOXM4ajRUDg/4AtcCnd6kC8YcvxPkHTcdvY+D/u
         +LbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779086167; x=1779690967;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1rvBBEpbQ06jTsYZKBaRFiFWxLvSm3dDYkTpS+9/z8=;
        b=UBATjPX5OT3jxPBwrPCbg/z4wiTlhWfYP01RGmaJY70Wr4Hql7zcMzMpbYjbT1JdU2
         8X1mr0pKSqFrw6kOAupE95ncncPvT0njgYuRn8hICmPuEHh0DtWLa9cUwnY+FfGI3g7W
         iH/6WPSn/OLls0erzW0hwPT1O8rCNfxRG7Sv/oRj1BpLxzStxhP8/yQZsvRpcGvthPCB
         2mRWK1s3I7pdv8q7JmpR9WBR3c2B3oTpOYvTc/XaVLPjBLSXO6H/qYzKtKIwROyB3V6m
         IRzuQUggRjC4UAN7eAu02Rz8KaSgIwP7aonILGX8ZRSz6meqnAfdwokx699X1CP0o6pl
         8iMQ==
X-Gm-Message-State: AOJu0YzWhTmKvoJ2BdRikCCmX7YOdcpQNjRGnoDThuj6nA8UeJYvf+Sf
	Qk+QWZ7vv96YkK6WKEqSNdFrgA7x6uGZ9hos+FiCUwroGVk3KMFWADuKdqjvgA==
X-Gm-Gg: Acq92OHDYh2hMGsDVFpHZE8nWEnMPphzkm9pGe4crauoIuTk1Y5BXw+5W+poOEfklhK
	1sbDiKZc1n74XtIWCA9bd7cdzOYsV+nnescEoHudz5/qtiNjzvT5Gw7ihLmzS3fqlo3pBkRUIx2
	+NnYLxZdRJY57SMhTVUuhlNG5TeIEy0LfU8aWPsJvdIVTamOEdoGa5HYua5mUiZmdBV1jn3yXu+
	ie203UYj9qOGAzoDj/8/Kyw8iEY/KKi2cxbVFE8d5kHHIolzBsvJLokON4q142bLas8Y4n+NNse
	1QVJ5nOGDz6viiOvZNBuYNNkBqWspDVvjmpBzyLgPLCBlFhHoKOOYEKglJBQXHxz4i+4AbW3e78
	+sSuyqnpkRCWOPfgnAOrMXUjzO+of5amKwrik0sUlHWbObesck8bYu1rSsoOBEeBBs1oCGTAt6D
	16doiJJSk7AWyNzkd/h8SvBYWjDJR9+FU=
X-Received: by 2002:a05:620a:c4d:b0:90d:29f0:93c8 with SMTP id af79cd13be357-911cef0c60dmr2013994185a.48.1779086166978;
        Sun, 17 May 2026 23:36:06 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.131.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9114edfd3ebsm1265885685a.23.2026.05.17.23.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 23:36:06 -0700 (PDT)
Message-ID: <6a0ab356.27addf4e.1fbd86.57b3@mx.google.com>
Date: Sun, 17 May 2026 23:36:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9166236271449941750=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, winter91@foxmail.com
Subject: RE: [BlueZ] device: fix inverted NULL check in gatt_db clone
In-Reply-To: <tencent_9B9A0B74FBCC9D4EF1CA4D8EE89DFB444606@qq.com>
References: <tencent_9B9A0B74FBCC9D4EF1CA4D8EE89DFB444606@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9166236271449941750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1096236

---Test result---

Test Summary:
CheckPatch                    FAIL      0.40 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      17.72 seconds
BluezMake                     PASS      605.54 seconds
CheckSmatch                   PASS      311.42 seconds
bluezmakeextell               PASS      167.26 seconds
IncrementalBuild              PASS      592.92 seconds
ScanBuild                     PASS      915.40 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] device: fix inverted NULL check in gatt_db clone
WARNING:BAD_FIXES_TAG: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: cbe4144dea6f ("set: Attempt to use existing set gatt-db")'
#87: 
Fixes: cbe4144 ("set: Attempt to use existing set gatt-db")

/github/workspace/src/patch/14577840.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14577840.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2132

---
Regards,
Linux Bluetooth


--===============9166236271449941750==--
