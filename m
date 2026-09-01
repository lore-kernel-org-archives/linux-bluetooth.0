Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2742A282F13
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788302297; cv=none; b=YI2XL/t+rA7dUHMHeADGeLZCby1EVIzXb4MCc+QxrEKFrRLmu2fz0M+AtabAdd4iDqT4YE2azrAZ+DVZhOqiEBl7CbyvXhzfKAGq9/VxSXJFjhhfURq7H3MENRV0ONJOchOpwnzAu/Rvh4wUqgWnUl+tMmHxhZn6Je2vD39ph7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788302297; c=relaxed/simple;
	bh=pYKwWYDrt65wfBNdd6mU9j/lzo6wuyziNfHoat7HaEs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rp/cltVezf9dVSCROS6z6CCUDwvt8gtBZsbGlhIduFGZ2cj8Ve6d/5DyaGbOeDS0RmW0Y4yzUUPBPMiJB1zpbRdu1XP4AOfBTPPco0sVfQ0ifeKHFYmLUnHwREPWB4ilx6MGwvp6ngaMj0yxmtVmOtI9Hr97ofoImxF2INiT7mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DU8VPOUD; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DU8VPOUD"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-90e7c71f86eso3112336d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 15:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788302292; x=1788907092; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MQVNwB3rJUuE38Q1BfmedsES2p/XJ5d/c7FWVJE1mxs=;
        b=DU8VPOUDRSJQMtII3jKpJgQCDBqw+ig1eSRG2tNrh8XWRgRPG/bDlcMXYNwsxdiP0Q
         gJXlnrLFyRJC5JmW7HPfzRv4iuCB7NP+LsSmwuzmE0Xa74gldtcQRhD9u1MloIlEH31j
         SK6Alz6u2FqiPXTccc7D/+65eN5aMWz2Q6Md0iRSzh7u8X1w7vToYghpBoZO5pytRmV4
         kV7kPRYezf0LcEPsLVOpbpr9lkQ4G08bxWhNfyuMQ30hgkbHS5swDE5YKO0a/KvMseB+
         SD1XmUEn9Bf1HVhxITcxUODHJ276GrhrAv1AA+r50eavsGsSbgb54fXU/FNm4k7yqKHv
         QQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788302292; x=1788907092;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MQVNwB3rJUuE38Q1BfmedsES2p/XJ5d/c7FWVJE1mxs=;
        b=smWGqDHr1miazdFddLLhrLLLFC6VGcLaGrnwCSkfc3V995NaVcN0TsIKnYT6TN2DcD
         4Uqb4MzBSQumO3ntrXOckBoECCFx5jBO90cFfbX9wWytja4/0X4gstK+CPC0a1stcDPA
         NdiK1R/Drpr1MrpgTDFaZ8qoSACLbhLFf0DrZIdtj7AdHesJc0Hmwb6YYjxP6L1Ftxoj
         1ItsY7XsJyEr28eLch7IOPpScNu/hlC64mI2FJ+34OHGNrU1avL3sZdr2viGnI8fCKv4
         cubt1+1CmKFR9rSPhvoqdZhdFmN3QhoUaKKUitmKgvwfh7+gMnrMAb+gJ1T5SKzKniHA
         68ZA==
X-Gm-Message-State: AFuF++nPD1xUa9ClLZvn7jzdX+aOXNC6AkUfg0lUZhUBGDoOSfX3JuKX
	OtNh+6rHZq14XsyBks/+xH8MqMEnCTwWsZi7Jl66C5w44H3Gj3lxtDsQALbzyw==
X-Gm-Gg: AYBFou2roUDfrSUvMk2Kvjnl60jntSPq5Px5oG5PLZTKrnycKXPLEXtjIFzghIHm2RJ
	6IQpYQzg/1FYQ1lQxZGAkSejQonkfi+zE3NH697+yXB80TtfzByELEtReUWurKoW2alhCzE2frV
	A4KKgyNefIyBLK/kz/ALyGY08BbPNjpku15l8f91qE29QVfcvmjJmuuGNCeMgeP2Zz1sOetNDQQ
	h6mmvcDm0qGHn6iqk1uM6PyZXMPXPKNpLmFN7Fr0Tlc9TiC6wFllp0jHgqasqZNweJ2nP030E4H
	MhICoXuO7XAgjGFE3H0QUsG+9KyvPt5Z82UToEGVvxZYMGnovnl+SPvoht2W/IAaP4X1/60AsUq
	uYop0tleF1v1fC4vcxnrfPTm8lfol/P1740GVnm5KOrk7xGiqOi303Scf4Fj8gYBKfc7xO83xOW
	BKsbxaM5JFmgoFmmGS7IcjaWXJdjrdN4EsBAO4MInTBQ+iS+L96PPPANs+kv40cxT36g==
X-Received: by 2002:a05:6214:2b0a:b0:90e:8dcc:4e5 with SMTP id 6a1803df08f44-90ebafb8fefmr15709396d6.28.1788302291673;
        Tue, 01 Sep 2026 15:38:11 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.151.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee07c00sm4499476d6.5.2026.09.01.15.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 15:38:11 -0700 (PDT)
Message-ID: <6a9753d3.c2d14791.e5542.1e8f@mx.google.com>
Date: Tue, 01 Sep 2026 15:38:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8213306415481980347=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: L2CAP: part 2 of l2cap_conn::chan_l locking fixes
In-Reply-To: <24ff07854c80a2813fe7050d1dbb40586391b162.1788296635.git.pav@iki.fi>
References: <24ff07854c80a2813fe7050d1dbb40586391b162.1788296635.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8213306415481980347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1155667

---Test result---

Test Summary:
CheckPatch                    FAIL      4.93 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      1.38 seconds
SubjectPrefix                 PASS      0.52 seconds
BuildKernel                   PASS      26.12 seconds
CheckAllWarning               PASS      28.68 seconds
CheckSparse                   PASS      27.83 seconds
BuildKernel32                 PASS      25.41 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      465.23 seconds
TestRunner_l2cap-tester       PASS      65.20 seconds
TestRunner_6lowpan-tester     PASS      23.15 seconds
IncrementalBuild              PASS      40.54 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[2/4] Bluetooth: L2CAP: annotate locking for l2cap_chan_del()
ERROR: "foo * bar" should be "foo *bar"
#154: FILE: include/net/bluetooth/l2cap.h:657:
+	int			(*recv) (struct l2cap_chan * chan,

WARNING: Unnecessary space before function pointer arguments
#154: FILE: include/net/bluetooth/l2cap.h:657:
+	int			(*recv) (struct l2cap_chan * chan,

WARNING: Unnecessary space before function pointer arguments
#156: FILE: include/net/bluetooth/l2cap.h:659:
+	void			(*teardown) (struct l2cap_chan *chan, int err)

WARNING: Unnecessary space before function pointer arguments
#158: FILE: include/net/bluetooth/l2cap.h:661:
+	void			(*close) (struct l2cap_chan *chan);

WARNING: Unnecessary space before function pointer arguments
#159: FILE: include/net/bluetooth/l2cap.h:662:
+	void			(*state_change) (struct l2cap_chan *chan,

WARNING: Unnecessary space before function pointer arguments
#161: FILE: include/net/bluetooth/l2cap.h:664:
+	void			(*ready) (struct l2cap_chan *chan)

WARNING: Unnecessary space before function pointer arguments
#164: FILE: include/net/bluetooth/l2cap.h:667:
+	void			(*defer) (struct l2cap_chan *chan);

WARNING: Unnecessary space before function pointer arguments
#165: FILE: include/net/bluetooth/l2cap.h:668:
+	void			(*resume) (struct l2cap_chan *chan);

WARNING: Unnecessary space before function pointer arguments
#166: FILE: include/net/bluetooth/l2cap.h:669:
+	void			(*suspend) (struct l2cap_chan *chan);

WARNING: Unnecessary space before function pointer arguments
#167: FILE: include/net/bluetooth/l2cap.h:670:
+	void			(*set_shutdown) (struct l2cap_chan *chan);

WARNING: Unnecessary space before function pointer arguments
#168: FILE: include/net/bluetooth/l2cap.h:671:
+	long			(*get_sndtimeo) (struct l2cap_chan *chan);

WARNING: Unnecessary space before function pointer arguments
#169: FILE: include/net/bluetooth/l2cap.h:672:
+	struct pid		*(*get_peer_pid) (struct l2cap_chan *chan);

WARNING: Unnecessary space before function pointer arguments
#170: FILE: include/net/bluetooth/l2cap.h:673:
+	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,

ERROR: "foo * bar" should be "foo *bar"
#173: FILE: include/net/bluetooth/l2cap.h:676:
+	int			(*filter) (struct l2cap_chan * chan,

WARNING: Unnecessary space before function pointer arguments
#173: FILE: include/net/bluetooth/l2cap.h:676:
+	int			(*filter) (struct l2cap_chan * chan,

total: 2 errors, 13 warnings, 0 checks, 272 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14782632.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[3/4] Bluetooth: L2CAP: annotate locking for l2cap_ops callbacks
WARNING: Unnecessary space before function pointer arguments
#116: FILE: include/net/bluetooth/l2cap.h:663:
+	void			(*close) (struct l2cap_chan *chan)

WARNING: Unnecessary space before function pointer arguments
#125: FILE: include/net/bluetooth/l2cap.h:671:
+	void			(*resume) (struct l2cap_chan *chan)

WARNING: Unnecessary space before function pointer arguments
#129: FILE: include/net/bluetooth/l2cap.h:674:
+	void			(*set_shutdown) (struct l2cap_chan *chan)

total: 0 errors, 3 warnings, 0 checks, 37 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14782634.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[4/4] Bluetooth: L2CAP: refuse __l2cap_chan_add if chan already has conn
WARNING: Assisted-by expects 'AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]' format
#119: 
Assisted-by: deepseek-4-flash # finding the race condition

total: 0 errors, 1 warnings, 0 checks, 33 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14782635.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/684

---
Regards,
Linux Bluetooth


--===============8213306415481980347==--
