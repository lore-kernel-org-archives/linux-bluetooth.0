Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6B9477292
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 07:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961753; cv=none; b=A6suK+NWPYmvgRUwyQrf5iiXXgV5UN9uvag/pLuuylqYLuQdxNEVDTB/bxuZ3b9hvsfjTN3aqDXkbepvrHN0+X6HWpk0Sq0m2mXCkXVxOSwDFZAYJFlPPldn3bDlI3hNcSAn0xW1CRyB+Az47g8uknkOLw6oz9xmF6jTEhvNphI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961753; c=relaxed/simple;
	bh=xzJpKnr4646j+ZzwPpA7APNYTd+7lWsgikUQiA8HJAk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oCRLEccI0bl5WbL9guZBfPPs0b/RFkntSukzWinolSj0nOUelTfzWkLshov9xmlTTDmDInt+sWcTQ/dma517b2n43lOgs5Bsq5bqwPvGsatenDYvJRweI0PTgkYKEUNYZBtEuPSgJEylSR7mmST0fgcxQsFKCI1HNTvQ00bv+rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUgMCYny; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUgMCYny"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91b8306b9f8so41055736d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 00:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791961745; x=1792566545; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o0FbIyk4ou38Cn3VRa1IydXwohIfX3/zUCpvGNNBkhA=;
        b=AUgMCYnyzoRnLiXhC23ch2RVrGVxRzndtm045wWj7xTQz50/FeNx5uPTimCzLogwF3
         QisqfH442YimRfR6+/rUiKyVKaL/Je5sJD/nabmeY391vv6i1oU1Q6StAB1JsOTm0FX2
         z1wMfSkW54fc1IlrjoZhjByo54zXd/PvxEXYN3+bQj2clvRnFzOt8kG16P2F6HmaKZZY
         Q3DfXeeVyeuayDDlWzS7m+AqPKBNrw6w9bgUcTM6gVvKlmdaVlwv+vWaIkwtKqgLbSwi
         EZ/D4ZlLak7u2utL+CQsG8W5Ne3rB/q4CB2t7ZHLTQUuLSf3S+Qvuo0N73XS9aUpjHfE
         xmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791961745; x=1792566545;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o0FbIyk4ou38Cn3VRa1IydXwohIfX3/zUCpvGNNBkhA=;
        b=TlablbJdlGh/HDYwUPW5Gvi40x2UqOQGyGdd+/2I9zGyGxe+ktZ7Pjx5xbY6uAa95d
         PMgyB/8VmyYIcpi/sTnTMj1rzS7v+qiEMk+oCzCUbw1e/rnvjONxvd7FxsMt45sMPUQZ
         fUP9QxJuNbfPlGlHs1R18SKKW8moF/o5zA9/hTvCzWzi5eil2LnggUPi2LCouytOmEZb
         DLe9ft+sdX1J1XqYLUj6HDN2nRbW2O7rNRujIlw2qtfTp4MgboL/7TcCsVfDiDWoaRG1
         GJpidalEsf0VstYMWGWc0hovPDCqvtoqxpl7A7leVLgn/7PMFJOUH0OKeb2gwjwq07vf
         Q2QA==
X-Gm-Message-State: AFq9FYLfKYr6k2sLuzF+o9400834Y/bhrLb0f6Gu0puCwP3Y/yg3BeuY
	SfFQ7K6P0q9riVbXuoxKm+qy3Hz0UDkfGQxJNtFXhvGtQxJziwmI86oIYOJ+0Q==
X-Gm-Gg: AYBFou3wUOgAkdyv/DELaz/t4F+OiakYh20sZnZseb3zM8Hls+Nf+ds5SfhNhGPmq8t
	x45JSWWF6lnc3O0Gmyi2ks43Sp+Ve9xq6G8L2u0zqVjvcAXCYyYh5osNGbFLLhqZo/DV2NECUWc
	DCNH1b6dPhTHN1Hvkl4xdz6XchZq9HLZ0E/MNUVbx9X86YBaOIroxDI1P/20Yx6K7ZEcezrNyoI
	5kqIYS1M2iWZZSQC3yCarThBsV6EwM9FR1ACrzUojEwVWIdBfgZDkw8CX+H16VmzXk/FJQRJNiF
	F7cvmP9HyqV2PIPtfFpE3a4IIaNzWtb72wn7AI+AoqXQv1OKVmS+prhPEkAqwzse1M5rHuauUvk
	qMoVAzYN/nc8cUm6I5qXT8DgHXhWAW7y5DxErgqWGusHCXqxANOp61/x/D2n8zKL40GwOyyM/a1
	nvXDCaoFV22WvL8rgEn4+6zJG+o+EP/HH/qavztV5m/eRyTaO4o+fqgBkEnDcridyvOq0mxxhT6
	xpz2A==
X-Received: by 2002:a05:6214:ca6:b0:914:7df6:ca80 with SMTP id 6a1803df08f44-91b554c3d31mr272384276d6.20.1791961744763;
        Wed, 14 Oct 2026 00:09:04 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.238.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b3bca7sm45396756d6.10.2026.10.14.00.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:09:04 -0700 (PDT)
Message-ID: <6acf2a90.4fa28f9c.26a03c.c795@mx.google.com>
Date: Wed, 14 Oct 2026 00:09:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4251960895347061405=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, liu.yun@linux.dev
Subject: RE: Bluetooth: hci_conn: Fix default RX PHY initialization
In-Reply-To: <20261014020131.45467-1-liu.yun@linux.dev>
References: <20261014020131.45467-1-liu.yun@linux.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4251960895347061405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1185171/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.75 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.85 seconds
CheckAllWarning               PASS      35.17 seconds
CheckSparse                   PASS      37.19 seconds
BuildKernel32                 PASS      30.54 seconds
CheckKernelLLVM               PASS      37.42 seconds
TestRunnerSetup               PASS      723.66 seconds
TestRunner_l2cap-tester       PASS      12.66 seconds
TestRunner_iso-tester         PASS      11.00 seconds
TestRunner_bnep-tester        PASS      3.14 seconds
TestRunner_mgmt-tester        PASS      87.60 seconds
TestRunner_rfcomm-tester      PASS      4.50 seconds
TestRunner_sco-tester         PASS      5.64 seconds
TestRunner_ioctl-tester       PASS      4.60 seconds
TestRunner_mesh-tester        PASS      5.53 seconds
TestRunner_smp-tester         PASS      4.35 seconds
TestRunner_userchan-tester    PASS      8.12 seconds
TestRunner_6lowpan-tester     PASS      4.56 seconds
IncrementalBuild              PASS      28.22 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_conn: Fix default RX PHY initialization
WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#69: 
Reported-by: k2ci <kernel-bot@kylinos.cn>
Cc: stable@vger.kernel.org

total: 0 errors, 1 warnings, 0 checks, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14887278.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/926

---
Regards,
Linux Bluetooth


--===============4251960895347061405==--
