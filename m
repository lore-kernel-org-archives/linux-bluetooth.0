Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E104EBADA
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 11:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892501; cv=none; b=LG+yn21pe4sWB83V9OpU2HOx2Ep4r1r//9ClJDqSkdqdULj4KSiyHkuUIbDmXck945rA2+hIBXTVLQQmmxqwbzQkI73/tX6nAeq6J9qaEktse8BIFnv8U3sJGxjqEpdPjRzawN0KE9I9LyYkchtU85ZwfAb7RxBSABbCOT7/kB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892501; c=relaxed/simple;
	bh=L8Gm2wkYJ7sDsOQ1upb173CwwFWRF4b6LXSFQZRANpk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oHfRpcday7D56e7sZBsw5f9KKD+JbMCNvfaUZ/dF1oT6l+/mRsZ6MT9znpW8z2Chf0Onpo+PybEuZuyjhxY8Tytv/hp80ZWcyU7JYNQJLB/PLXoDuBAB0qKNqVBOI/ZoO199yVOlSIjFCkq0lF/HV/8I3eptTgNfrbOGqXEdH6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYzygb4T; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYzygb4T"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91b813ac020so27714386d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 04:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791892499; x=1792497299; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vVhKQ09153F7FwuWgu+u8UhXgWM+cIi9CbGQiA83Bck=;
        b=KYzygb4TMkkmtSCUJJa7eW3U3dcV2d+ahhJA/XHdCkHwGJUXCaB56ykTYE79c6qgGs
         FwP9zqU8sg+j7gn77XBj6dK/BkDLl9a3GxqG7mpBweA9P6cUtqhsUJVZYna1k9noo1Yz
         Ks++xypFs7fg/zcMfzoTVI4OAMiJxu/dgV6tl6ot7fnpu4TZUqJ+cT+XaD07ZeswmT/8
         vc95855T47WpV0SksmMXepW2cq4sWmglyLbp4U2pHSZmyj229quyfAQ0ixjmw/gAiwNv
         FZxLLg6vvmq0kYq1GXRIvdi3Yu8ArrBiZrgubDrbt0l2JClfdLzCpLf+9Y7cIhKN6kfs
         9mCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791892499; x=1792497299;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vVhKQ09153F7FwuWgu+u8UhXgWM+cIi9CbGQiA83Bck=;
        b=GSEHj102LbwFX0luRn/LalHO4r6+ybkgkPOIAOk1dUuxpkgg//I9N8+ui1aAm6UPrh
         FUjzIYYe9jwxP3NqTRYrwTA9CrQYEqZZhCj+twbnTr4cAGTJJzx123CDzkDDTCPuW9hj
         LXjjYwwuhFxs5FuvVTnUmun0zvkrmTH2/Pr2l7I2bIv9MtarpQI5Ucv/JH9jgZ7rCD3X
         K9JGGopVEvV+Oyon5I8v0oGfZpcgBXnJ4CWxLYhYuhuVWcSQS2fwrrQ8KOeOAMHvu3SU
         cOaXotq9/XUjytsX05e/r/OMm37zg/ES4ZmFXtxazhHOZS1X+lvmqbZPcRgeZJPN62i5
         JkCQ==
X-Gm-Message-State: AFq9FYKAf/Bc6UlcZTKkdh8FpL71tBuDrmwi/wIBR1oO3X4yNgULqRBh
	YmKVvHHq8id+1MUA/ibfn2hw7xq2NWglKAqIs+MMZLZj4J4bR729iXSwwR19rw==
X-Gm-Gg: AYBFou1p/Ji0gLy2vVOyjlsUCSZIymCQkPH6rH7hFrmvZuFB4nZSlAMxSwZ4oZ/eBNq
	TtHoYg/iMWMET6iOMGDrqX9xlAgHXUMoNuNq/GSn2QTBbA+/dvNwUjz/pQqqJi8g5qwyFSh0oE3
	IOR1GiKzfZgULdCajz6MK8VCKLp090VDO90QF/c2KcMyHr6SIQmlC7kb9Gt/cdFoBJFegG6MIIv
	yrZiCubbYASxR8d7o1ZGVR5X2+UCFIol9skHwwmgP9mFBqHgwLsN9TI4aGCLC9Ixe1zkD8fGmxC
	oWurnQrRQIIEtIx23xE0dX69FxQTvzHYdo3o3kFhNvplxLryZ5FJvT1h/vjlXVkLdLymRdinRXr
	lgdV1LA6Ptsu3wMp2j9EHSDx7ahDOPG1gYnePjx+GMtuQ4OeAOZ+ova8RsNg/dpMGBuR8LaeCM6
	ag9zu8O2IsnbuGDOprsYYEHLXL3yuu3+QnjAoCmC4xQT/4JHEtJ+bmJkQ24xpHXvhyRVigljVY5
	4ISfg==
X-Received: by 2002:a05:622a:4c89:b0:535:1a4b:a65c with SMTP id d75a77b69052e-5359fb432b3mr196793161cf.34.1791892498941;
        Tue, 13 Oct 2026 04:54:58 -0700 (PDT)
Received: from [172.17.0.2] ([172.200.23.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b3581fsm23402156d6.9.2026.10.13.04.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:54:58 -0700 (PDT)
Message-ID: <6ace1c12.3db648f7.3ec6e.8089@mx.google.com>
Date: Tue, 13 Oct 2026 04:54:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0155199313053308370=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ajay.k.v@intel.com
Subject: RE: [v1,1/3] Bluetooth: btintel_pcie: Add initial YoYo debug support
In-Reply-To: <20261013104416.26143-1-ajay.k.v@intel.com>
References: <20261013104416.26143-1-ajay.k.v@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0155199313053308370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184643/

---Test result---

Test Summary:
CheckPatch                    FAIL      4.58 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       FAIL      0.97 seconds
SubjectPrefix                 PASS      0.35 seconds
BuildKernel                   PASS      35.68 seconds
CheckAllWarning               PASS      33.04 seconds
CheckSparse                   PASS      35.76 seconds
BuildKernel32                 PASS      30.16 seconds
CheckKernelLLVM               PASS      36.47 seconds
TestRunnerSetup               PASS      697.94 seconds
IncrementalBuild              PASS      30.68 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1,1/3] Bluetooth: btintel_pcie: Add initial YoYo debug support
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#310: 
new file mode 100644

total: 0 errors, 1 warnings, 341 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14884820.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1,1/3] Bluetooth: btintel_pcie: Add initial YoYo debug support

22: B1 Line exceeds max length (92>80): "[    3.360857] Bluetooth: DBGC allocation 1: fragments=16 fragment_size=262144 total=4194304"
23: B1 Line exceeds max length (92>80): "[    3.361298] Bluetooth: DBGC allocation 2: fragments=16 fragment_size=262144 total=4194304"
24: B1 Line exceeds max length (92>80): "[    3.361712] Bluetooth: DBGC allocation 3: fragments=16 fragment_size=262144 total=4194304"
25: B1 Line exceeds max length (90>80): "[    3.361715] Bluetooth: MDBGC fragments: DBGC1=16/262144 DBGC2=16/262144 DBGC3=16/262144"


https://github.com/bluez/bluetooth-next/pull/916

---
Regards,
Linux Bluetooth


--===============0155199313053308370==--
