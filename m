Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CF953CA61
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890827; cv=none; b=tSR7/acqFGI2PYOLOPQxhP8cUtggpNcAd5h67NGwiXp8YzqVHwW8O9KdDMhni+6GN09lqrxMd/Ri/VVFpoh0Snxg7h/xQ3OMcI/LTEeQcawNDClzcckCOQfCw8i29rjINtLgwd84y7/M0M99T05MZynp3XSkMl3+bsMBSUcyDxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890827; c=relaxed/simple;
	bh=nqvofmQ7wc3UjrMVTVvtaIasZwRN++fksoT34eQIrrM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YAvIQ8Jg0EJsWS/MQ1Is7RgRYk/2NJcBSD2gXkJxLsV26NCo4rTNqk+to7TOooS0Q/CHO4gz9knhnkhG1lP1IiyAkA6j/lgafL140blHDdVZxUforpeVOWLAMStL3a4cDj7vrDy73RR+cUPxcdOWmYpgg4trqY1dmZwNVQlGEi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1hmYtRW; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1hmYtRW"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfbd148aso2442656d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 11:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788890825; x=1789495625; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y2OE6kdeCsbX+wROW8ykBwfDSLc47hLInSexbiohdNw=;
        b=M1hmYtRW1Mo5LbB3ziJANF/4UbXj6wINRK8iRXof3uITttVytR2L3f22rwVR8kDtxH
         FIhF04V7AuRXlR1MHLDDtnnBdCxj7GeGE3X4ldGdV5TK1QIYN2IWqD0V8XPIPoF+38kf
         uXDgagp1FDUhdliiwb+rD3ZVstf4aChtYI2Y3IqNd/2aXpjx34OTe9oJ53NdMxKuLVsP
         wRJFmD3/OtD1/Ub87C5BC+XpkbaqJVGMG46Dxa0MryEfS9XLmnpHJj1zmxbePLY9zO0L
         n3Een1DrSTwAxkSI4OONxKYKU6RST5RNaqJJ0GALsEghC5KNHYcA4QWhNoSDZZyyl237
         nmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788890825; x=1789495625;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y2OE6kdeCsbX+wROW8ykBwfDSLc47hLInSexbiohdNw=;
        b=WY+KG3+bkmqQ+wZnC0YBzfHSPFzptsfuiJsp9Gy9/wh0YYyg4ucv7PobBnf26zFZuj
         KXQe36ROSTe0u9cRBYjZH6wsQ3+GnJOGqvTx4sCYOYaXrMmL2/8wvvBCHRJNKtl8cgdH
         Pxt6h4V7gxY+dFccAiV+mEPjT9r9zUY7aL2m6y702Xc5AQ0np8i/KTC8j2PXKQgLluz8
         H7txIWXWTUuAv1pT7T5h5bCEpeDWVMwtn4YO5DulQ1w/CvpQ5sebsklE+hNSNyQLRVwt
         WPLV9zgQNmUh8xkIuZu79HuKuod4Dl2BTBM46YdU5ItJNkZTfvFEjRIiDx+Vpl4DEt1x
         y6/A==
X-Gm-Message-State: AFuF++lbiVK1aLvaFuHiziT7udWAdeQJUkz+YFod3LgDY7kQcjUxt7fI
	gMSzbEFJZkhTzvOy4GUlxu2xCUz8rWQIpuhWHGwxsAYVlBXS4DVloB3UlWLvJA==
X-Gm-Gg: AYBFou3FHhj79GY4gxMahviGkXRJs1mxH8sye0mrTAJXg+y4phYPrEDIpO60rvQlBH4
	CvHFDvBm7N+Kf03mMXNDnEHWgox8dtbjARz1iGO5sJ2dQp+b7lnEvkO+2NNhrJgr2fOe61N+c/e
	67lCeU9+D7fEY8HF1ZnQDkf677aF8SquhaARXZ6Hgp9V1x/wRl4z6CQfOPq1yFOa3a1NXTM79+8
	C0z5JLLQTDyivmh69klUayRx8xvVBL7TkpZsk8LoJ2LRHb5+awYqlabU100ZkOfnMY4/Mykl8y3
	s4BaMzkudwqZidy1GysJrg3eXJGUawubPaSpEMgpG1da5mwSdamUKYHjWRSC0rta9Dj2dVmQ6rP
	RRdrJCDDZNN/kefPPsV8PpzFn5+59Lo2jbuNW5xCZk0phdwVuc9De2yOUyDxb7Iv4bnFaECHF9k
	/vRrtVULjXGQTNw4o/a03Q+Uj29nC4Xw1u5lF1bvYFJj/+KlrDAmuz5m/pzO7tnXC+YGCqcg==
X-Received: by 2002:a05:620a:6887:b0:939:b482:d474 with SMTP id af79cd13be357-939c94d1567mr187381485a.35.1788890824665;
        Tue, 08 Sep 2026 11:07:04 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.208.181])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fb90d6csm1198506285a.33.2026.09.08.11.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 11:07:03 -0700 (PDT)
Message-ID: <6aa04ec7.85560941.12ea94.84a4@mx.google.com>
Date: Tue, 08 Sep 2026 11:07:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2172259372005599749=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jan.brummer@tabos.org
Subject: RE: [v3,BlueZ] Add cover art support
In-Reply-To: <20260907193404.124504-2-jan.brummer@tabos.org>
References: <20260907193404.124504-2-jan.brummer@tabos.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2172259372005599749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1159982/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.09 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      20.33 seconds
BluezMake                     PASS      566.36 seconds
MakeCheck                     PASS      19.77 seconds
MakeDistcheck                 PASS      155.21 seconds
CheckValgrind                 PASS      224.36 seconds
CheckSmatch                   PASS      300.56 seconds
bluezmakeextell               PASS      98.88 seconds
IncrementalBuild              PASS      573.47 seconds
ScanBuild                     PASS      921.94 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,BlueZ] Add cover art support
ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#1107: FILE: src/profile.c:1509:
+static GSList *psm_watches = NULL;

ERROR:INITIALISED_STATIC: do not initialise statics to 0
#1108: FILE: src/profile.c:1510:
+static unsigned int psm_watch_id = 0;

/github/workspace/src/patch/14797210.patch total: 2 errors, 0 warnings, 1042 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14797210.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2500

---
Regards,
Linux Bluetooth


--===============2172259372005599749==--
