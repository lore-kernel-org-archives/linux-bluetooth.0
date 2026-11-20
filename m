Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181825;
	b=oZV7BRjIoTlWA8wAp0HQFVCPGtV/lWqJzEb064nEo+SfiL03bfMJNHFdssS7p5LsCqb6
	 ITCK1P9ie6iw1YKjpykO8kL3X6u77QmBo6bAmDfzvJjoKCQyzlDD5PbK5YagauwKr8YyQ
	 UutqELDByBpOUnvLnABFN9GnW2JRoTMEfem2JQio5vSVQ0YyV6nFv6pGm4/yhM1BUF9et
	 Jif6KMOCvVYryFB0iMWS8WzXZNetnFqaWAHk+7yUEbKCmHrJeqW7eLiLtd3pp5owaXrL5
	 v2gRq/alrvjV20KmVFS3wIw8fDS3nhLRBfgMkJRFqUTjxPZUNkdf8+klERYlSCAPq0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=NdEfgh7G8zZ6RbWBIGvG1y3LSUyy6+fW2nC5BLeg+Y0=;
	b=EsNzoVx+X2+xNpOTXY2KDQpIhKis9yBja7acM4lscpR4TcwPIK7mi6u2gsrnt8zQGVE6
	 7dyVawma0QgiNs3DGw/bgAYh4n734erUzLo075VZCf8vZWWGQPdmyL7N9M+DSd57ouU5B
	 k7tR/xd4+C22K8xScbeEa1CyGcG9pJbCDauf2Glqh9gBln3sxYFlmx2UpcaXDcIWSsJPC
	 WWf1EeFYO3AMxXwl9e93sHQTughzn8SdGjGgXV0RberCuKpjSvb4A1ejlH71dJD4H5SEQ
	 0vGb1wXq8dhybDZY66vGki9Y+7AJn0wZVq5k4bE8GqsMrWQ6YE2yOZyB8xCFV26nkvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="U/lYSKyb";
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E58606A320
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 13:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78E58606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U/lYSKyb
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-38190551625so1458621eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 05:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795181824; x=1795786624; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NdEfgh7G8zZ6RbWBIGvG1y3LSUyy6+fW2nC5BLeg+Y0=;
        b=U/lYSKybqpB+Pu4yrvatNcZHwuRuYeahFg9ZKfF1LhTmpHhEIzbl9howsF4tKmQV3t
         8SCvAHOhZMryTi+Hel+63rckgRWnMfa5DsHPJsXK0cemk7TDEXMkExx9bKVOWJj2ut0J
         5ZSP1/3BxCpJVIfCHacFvYSwS7/fufVCFE/SBJNXeOI27A7A2oFUuNPaxAA6ZCRSV6BC
         cOgTEAyCHyC+0rnNyZlf6ZW5St5ImWzde7ArdMOL3qU1vxwhQldVoFTciDtVkeDgYaul
         HyCzRLIyNik7S37RXihPUbz+mY+VGlwUl/YqZjQpVIbGMQpaEPahVSO1QHrIO8vos93B
         LkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795181824; x=1795786624;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NdEfgh7G8zZ6RbWBIGvG1y3LSUyy6+fW2nC5BLeg+Y0=;
        b=C5gPXcuChufdpUZ6ClW4HsVNcEslnCghPRHRbtQw+mCriZeUor7jBi8Fj9aHAIIh51
         v9u70qp/p7ApQ2f/bPGHF7V6X8906Yu1s/RpG1bmzoUa1rVCZozhXSMG38/vbjPyR6Ww
         LrcKXP7VkszPSyxcxtul3BE8jb/C74GhgU48vg959P3IlSInRtzRT1KJACMo/PssilWc
         mFytS5VDwyZVQdfKUKGa0GrZzqm8m/o0+eBsr5Jf+D27urGuL04gfxtI0juWZWnR+F48
         x3o8vb4uFsbRjtlwwnH8Ycot2ClW7KuRzZg9LWn6YMt55Hy//0JBn2FSoSAofm+bDHk6
         OLqA==
X-Gm-Message-State: APuU4Z9O30KUiFlVMeDmnNM3uF6kK4BGj4vDml9Vr6TnK3lUU5L34OzD
	o6kgC0lh7tHmAXDrTZTiR/5sl49Ei9u89Y6bkCjyjvdjsPoU2oh5kDJ5z8H0XcY2
X-Gm-Gg: AZFdTZcvUoPJZqMu7CklCmnYDk5dYgANyYuSkvHa3wE0JJPYYH17W4cKhmdcfB2wLfS
	FNjilalW+I7V6hE+8l4WXWZ/7+o6kUlhxhFmfcGCPs9Qd10VHLp6Q32k6AaCKK3qwNDWo2oyVKK
	qn6hWg54y8V/VPT5ATSb1pO25y1tBzDOJlIkXT7kOfIr+EAyJeV2kxJoxZ75QBTslPu2hdpw8Nh
	GGVFn6lQu6KMpdHHi2PRmxrNBFNO8BKpjSARFMIwwg7doxp+Y53Z8E7YDsKSgBJU0aOt4PI1NKu
	YajfD9X0G5VBl8TygrdpI++pOvYIODSZMVlzAbQz2ExvZDg2pLja0yqq/dxfW0TCeSOLx0Lktu4
	u0bFnAv1FDf2pHzBThhO8YXkHtCr8ndTtf4Iukyepiu7VsVFcY5YIONBGXMmfJbcbgcOKORf8xG
	x6BXwLoHQoFlIJKZWtFSA50cYzTPJ7s6M3BFyuOS/xkwCT5J4gTEPpUvZoFHpVKqBhgdnK52RJ7
	wYaVvAY7YC+gjmJkocfUy1xGCer5ZbnZEVaMlOMQy3+UDVqZRHwmeYNVl8FLd8=
X-Received: by 2002:a05:693c:60d4:b0:37e:fac6:7ef1 with SMTP id 5a478bee46e88-38571120627mr2860854eec.39.1795181824296;
        Fri, 20 Nov 2026 05:37:04 -0800 (PST)
Received: from [172.17.0.2] ([13.86.140.148])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm14651427eec.3.2026.11.20.05.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:37:03 -0800 (PST)
Message-ID: <6b004cff.a5690e37.19a5c8.ae7a@mx.google.com>
Date: Fri, 20 Nov 2026 05:37:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1089290825377923328=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bsdhenrymartin@gmail.com
Subject: RE: Bluetooth: RFCOMM: fix race on dlc->session in RFCOMM_CONNINFO getsockopt
In-Reply-To: <20261120063343.3875317-1-bsdhenrymartin@gmail.com>
References: <20261120063343.3875317-1-bsdhenrymartin@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1089290825377923328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1216976/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.12 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       FAIL      0.24 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      32.33 seconds
CheckAllWarning               PASS      37.18 seconds
CheckSparse                   PASS      39.30 seconds
BuildKernel32                 PASS      32.79 seconds
CheckKernelLLVM               FAIL      34.47 seconds
TestRunnerSetup               PASS      763.09 seconds
TestRunner_l2cap-tester       PASS      14.77 seconds
TestRunner_iso-tester         PASS      13.11 seconds
TestRunner_bnep-tester        PASS      3.15 seconds
TestRunner_mgmt-tester        PASS      89.65 seconds
TestRunner_rfcomm-tester      PASS      4.52 seconds
TestRunner_sco-tester         PASS      5.69 seconds
TestRunner_ioctl-tester       PASS      4.68 seconds
TestRunner_mesh-tester        PASS      4.53 seconds
TestRunner_smp-tester         PASS      4.41 seconds
TestRunner_userchan-tester    PASS      3.23 seconds
TestRunner_6lowpan-tester     PASS      4.47 seconds
IncrementalBuild              PASS      30.03 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: RFCOMM: fix race on dlc->session in RFCOMM_CONNINFO getsockopt
WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 1 warnings, 0 checks, 67 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15004442.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: RFCOMM: fix race on dlc->session in RFCOMM_CONNINFO getsockopt

6: B3 Line contains hard tab characters (\t): "	l2cap_sk = rfcomm_pi(sk)->dlc->session->sock->sk;"
##############################
Test: CheckKernelLLVM - FAIL
Desc: Build kernel with LLVM + context analysis
Output:

net/bluetooth/rfcomm/sock.c:771:2: error: mutex 'rfcomm_mutex' is not held on every path through here [-Werror,-Wthread-safety-analysis]
  771 |         lock_sock(sk);
      |         ^
net/bluetooth/rfcomm/sock.c:769:3: note: mutex acquired here
  769 |                 rfcomm_lock();
      |                 ^
./include/net/bluetooth/rfcomm.h:152:23: note: expanded from macro 'rfcomm_lock'
  152 | #define rfcomm_lock()   mutex_lock(&rfcomm_mutex)
      |                         ^
net/bluetooth/rfcomm/sock.c:833:3: error: releasing mutex 'rfcomm_mutex' that was not held [-Werror,-Wthread-safety-analysis]
  833 |                 rfcomm_unlock();
      |                 ^
./include/net/bluetooth/rfcomm.h:153:25: note: expanded from macro 'rfcomm_unlock'
  153 | #define rfcomm_unlock() mutex_unlock(&rfcomm_mutex)
      |                         ^
2 errors generated.
make[5]: *** [scripts/Makefile.build:290: net/bluetooth/rfcomm/sock.o] Error 1
make[4]: *** [scripts/Makefile.build:572: net/bluetooth/rfcomm] Error 2
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:572: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:572: net] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/home/runner/work/bluetooth-next/bluetooth-next/src/src/Makefile:2243: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2


https://github.com/bluez/bluetooth-next/pull/1165

---
Regards,
Linux Bluetooth


--===============1089290825377923328==--
