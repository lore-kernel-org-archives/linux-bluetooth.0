Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A40E2417E1
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Feb 2025 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739012813; cv=none; b=LPH7JOtSIFwMANBFYiOBleze8D9ZNPmiDJwMNlkxLOks6IbE6N+yg6c9OxcZaG6QDeUdfJcTXJhKpRg7oCgJON18AscuKHEgKfHbePQI+CjwtXlqGxUOpnJ8Fgx13h9Ggl8Z7DfLrCe0IDXNW+LL8KaL+oB9PE6iek821NXUPbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739012813; c=relaxed/simple;
	bh=pUfO9r6mCKGmeK1FzGrYXVx1z+z5XWEOdE7JwC0rAec=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MgPZygFT6MUZ260j2mjDlqzgZoHdVNGBuiFXZCV1xFBEpRCW8ZhccbxMtEq0f3k4NFWVxV9DnVnSB3Okv/eYR2K/xQ3wf3Xc48tu1ZjWB7Rl/XY1azYlKISDrc4EtmDOH+6bROD0wAFmSQhyUaKEmEkXveQgtOJDEcddXnvKWp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8i0rvnV; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8i0rvnV"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso4611075a91.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 08 Feb 2025 03:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739012810; x=1739617610; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=afSym2qfldfy1eyOts7qc7DV6DqmKKVglnK9TC+xNUY=;
        b=L8i0rvnVelojpbX73sVaka2lXreJtLKor7EsE60qNX1lgdA8ceegJ2WDTO/g60GY8c
         nxQM0bCdGCMl9BkpupsdLX3i1mMwMwnFycmAGto9YiaNNjRaXEjQ8TnRl9etncpuf7SP
         MYk5pYw8wfiQgWtUn52f75y61O4LMBjiBdKFoRTUG3PMojzpqCnPvwnXwoScTtIhBnQ8
         JAKnDR2hDgbiSvOL/4hnosCZ/tLb36mQr4rT3zS/ZJ6eGTOVpOXkZ5QTYXKIYmBT75C2
         tFYUigBp5UebbpnTemhcqGDtwofLyWPY+Lwci0wVCJmtGLKH1BqVnCtG1KFTc+Psf1Vo
         b/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739012810; x=1739617610;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afSym2qfldfy1eyOts7qc7DV6DqmKKVglnK9TC+xNUY=;
        b=xSJJjf0YZAXgRcF4eNary9an4Dnap0iCouuDF3HYzFOuaRymloS8+OgN/rVPyPg8g4
         UIssKkwvxkxqVJEZ94X95MLbR5gNugqYm31LHVHvYMYL28a2YWp3SGfVz+jRpJoBrlCh
         AsuDvAPOYSl2Fecea7AxQ/b7re3YR9cdMc6l0lNfl3fAb/4VPwL7elDFxCv+ioUQFBQJ
         3xE8kApNCoH+9PD7Lbhn1fhmky9ETKh9u4nzhaaC2m8GZIWW5kyKpdtA+0t3fC5Hh8Go
         epsWNF7PivJfejh1mkrtPDKp2Si3iIpMfdAuba+9THJaAdjiLZ+wOjvtiKiGLiV+3M23
         lVog==
X-Gm-Message-State: AOJu0Yz5ShniNnw5narKV0n4TBRjxWVmERrjN0ZcaeJ8j41GiH1AdEJC
	fAND8jkzq3rPGiUxewdG4F8hiAnfWXLKS2Lf8ne0WBpdMOpuJxrN5vbnUQ==
X-Gm-Gg: ASbGncveHAbHGhKZlZHlpjnjul3CZ/CllooZBLru0fLL5Q027PLkWG0tJXy4+n8WPXS
	svEMYDURbqKyB4rf4Gwhn4L4Kb2YFLK+QIt5aqQxEaskUsEE0xcWHU76l2IQluvKo+Qb8blz/Bn
	b7MJJWoBioTj2stZrXrLOL1zLVcNwQ0Pof0lk8IOWZNzpQWIoSeQ5hMynGd613rWVlQgXJhv1gC
	I4HxDWKvtTjb7ueu3iD9NSIzZLO9F9Kls+ypJtvxHQKV46AVU2LLP43tKSHDOc0LAw3iCrjsSF0
	V3uNZd3455gp57ClhGC3fg==
X-Google-Smtp-Source: AGHT+IE5WlKr3ofM1lp3a6dlTWJjfABXmbJQfbeBvAVN56XVmVgTsH5lzcSPOBABKUZo287+mSyxUg==
X-Received: by 2002:a17:90b:4fc6:b0:2f8:2c47:fb36 with SMTP id 98e67ed59e1d1-2fa243ee3a2mr10867741a91.33.1739012810402;
        Sat, 08 Feb 2025 03:06:50 -0800 (PST)
Received: from [172.17.0.2] ([20.169.15.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09b5c71csm4899957a91.47.2025.02.08.03.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 03:06:49 -0800 (PST)
Message-ID: <67a73ac9.170a0220.30335.20fa@mx.google.com>
Date: Sat, 08 Feb 2025 03:06:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3385171077918390423=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] build: check first before enabling -D_FORTIFY_SOURCE=3
In-Reply-To: <da7a417d9b27d26393d6c9f52f675e7ae0541e8b.1739007137.git.pav@iki.fi>
References: <da7a417d9b27d26393d6c9f52f675e7ae0541e8b.1739007137.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3385171077918390423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=931874

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      20.11 seconds
BluezMake                     PASS      1422.15 seconds
MakeCheck                     PASS      13.93 seconds
MakeDistcheck                 PASS      156.59 seconds
CheckValgrind                 PASS      212.61 seconds
CheckSmatch                   PASS      281.65 seconds
bluezmakeextell               PASS      97.47 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      854.25 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3385171077918390423==--
