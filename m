Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7B0547044
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 00:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789863745; cv=none; b=a7/H3l6h/Fq/xIQKHVxUF8FXWk/iobIhOu+lVz+qk2RrjALI21GqsjbigHFJzJTAf2dc+1iV8kyHrpFZoCm/n30uB7fWqQI1yKbu0Xv+e/mqabUd6KDotbqWTG74JkijArVH56PKJ6hQ1zmerztLvCPwDMDuByTFY6onX4k+qzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789863745; c=relaxed/simple;
	bh=mG6ugsciG+QyDjJNdoxTWQTOTixAmA3QROieOMdMh84=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SktfRXhBBdnbj18oMSL5/KOQ/p8r3ldivLaB4i54B0sFO4/3TrCgCBHjOCzjDmp005hVXpfhuTJk8kHTrYdhmLobKksWo9p2ERnw9kjCLyscanl+SE2H5uVhWUsHXTue93+F+5eHa70FaqzAf9Ztzmm/YvHHSzPL3VGjb3xXDeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2wiAw46; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2wiAw46"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4c6d6660191so1297599b6e.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 17:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789863743; x=1790468543; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZBYakY0Su0916ZmDMXlMCW0Iag+IICli9avP7TeF3No=;
        b=T2wiAw46ELUjBtm4L6+/DIOKhf/YQJC0Y6iVNG2D3H9mA88xEaNHwvdSqxPVlocrOl
         IGaA58d3TWE7EDnp/cetJzb4II/lYYn3xKd+sEwcUKOjr9Dk6GoyosXa5U30V1NgZ0hy
         SDeaLd6bqqp4vpgr98nGaueeNzTnwjqQQu+h+yt2UcBY0I6v8WPYCKk0fkEclpOrymr8
         jh6vQW9NGZIWiM8Svx3nSK5Cd+L4H+5xxIyIHCWzQHgjs/Zps/wqXRRmq2/RqYu+dPeV
         id2qTmcoVZYPB1NacZV+mOHlbQVi811WsJYODgwLtpMnr6P63Cak8sYr5Y1H/rhxEKWM
         n9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789863743; x=1790468543;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZBYakY0Su0916ZmDMXlMCW0Iag+IICli9avP7TeF3No=;
        b=arYxidrY6gLliQ16IuxL1MPGQN9b25e4qp9Qmkt12hwYy2mE/Issi0KPyNBjEXz1mK
         zUMPDx5FJXEPz4D04ngHY3KWR8KoBrjy2bSFgE30CCP21MFze6r+YJiz7cu3VwCwlL86
         myo3034OaN3+ahu4WGgV/0qhv7rh5jluw2Xk9o5QouZ12h6kVLfyNTzzpWUB7/6QOTwx
         90hJ6L4yz16r9LH5FfK5npArWppKuEAf28Op4zbTpLvKbhLiw0ym04ppRNx9d3S/pjTb
         fjfBCfsYoBn99+MtvOetd1zoIjF4Ekq1WfeE9Xt1jCTJUey5slfQn6y2if1YV5VsawVA
         FFjw==
X-Gm-Message-State: AFuF++mrLkZ6GzTzi7DnnrHgz6yo301pL9vFiFCYPsKs822BXVyjJuIt
	B7UOXa5kCHp7bogGwPP+TazJZ7Vrp1FGEcrwyeub1HPNiXPNGnXnL8Uql/J/tq2q
X-Gm-Gg: AYBFou1CIZAa18QXh/7NS+mc2S3EVMNhG4uyn7EVgQAYWCwUex+klz7A/heMVJA5O+g
	TlswbUgdLm+FTwr8eDv56yZUs30i7WahG+Ejsk2vD6no6Ma21DR5jMbZkrzX3oiyxNiVKBRM0vg
	vyvplhSwjWccKG0OPsBVMvkAZZJV+G0KprTZZURKaYaShsglZbBDI24ihJADjzw7TlmTD7kylZx
	VZsLGsKlmgyZKYudOoslctd4sekMeh0U6SY7QXAg0y4g/Q+Gq/vVRhP/pLzGcsmMtzazPh5hmEi
	Im9h8rzKqMHGjh3Oid/oe1kPgGhOBswhxeqEiDWkkxedSNz0ikAw2qUrxpfkFW5Z2Vwm/l1hGQr
	/cdXN4zvaIQMjMalE8gz6NqBmGdGwVvCSJDD45tq5kF3huUjgANBx51NMSnsevRM4cFxq+z1d9X
	3t3wC3QarvCYckhZixdMmwLoLPHkasTW9lBsB43O9sMhhq+qKqWo2GGk/cVQPMONXmINFLDLaFB
	PfIkmYjBRnrp8w=
X-Received: by 2002:a05:6808:1587:b0:4b3:7da2:f393 with SMTP id 5614622812f47-4ccf59c95a3mr6510472b6e.15.1789863743127;
        Sat, 19 Sep 2026 17:22:23 -0700 (PDT)
Received: from [172.17.0.2] ([52.154.21.48])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4cf3e323e81sm3035786b6e.6.2026.09.19.17.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 17:22:22 -0700 (PDT)
Message-ID: <6aaf273e.6852c33c.209095.deeb@mx.google.com>
Date: Sat, 19 Sep 2026 17:22:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0709131670660459865=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, benquike@gmail.com
Subject: RE: Bluetooth: hidp: fix out-of-bounds reads on short frames and report_return skb leak
In-Reply-To: <20260919221741.3709254-1-benquike@gmail.com>
References: <20260919221741.3709254-1-benquike@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0709131670660459865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1169458/

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      0.30 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      27.92 seconds
CheckAllWarning               PASS      31.77 seconds
CheckSparse                   PASS      34.62 seconds
BuildKernel32                 PASS      27.96 seconds
CheckKernelLLVM               PASS      35.24 seconds
TestRunnerSetup               PASS      733.57 seconds
TestRunner_l2cap-tester       PASS      16.26 seconds
TestRunner_iso-tester         PASS      28.58 seconds
TestRunner_bnep-tester        PASS      9.31 seconds
TestRunner_mgmt-tester        FAIL      60.21 seconds
TestRunner_rfcomm-tester      PASS      4.82 seconds
TestRunner_sco-tester         PASS      7.56 seconds
TestRunner_ioctl-tester       PASS      4.65 seconds
TestRunner_mesh-tester        FAIL      7.83 seconds
TestRunner_smp-tester         PASS      4.33 seconds
TestRunner_userchan-tester    PASS      3.29 seconds
TestRunner_6lowpan-tester     PASS      4.39 seconds
IncrementalBuild              PASS      26.62 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hidp: fix out-of-bounds reads on short frames and report_return skb leak

1: T1 Title exceeds max length (83>80): "Bluetooth: hidp: fix out-of-bounds reads on short frames and report_return skb leak"
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.019 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.441 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds


https://github.com/bluez/bluetooth-next/pull/801

---
Regards,
Linux Bluetooth


--===============0709131670660459865==--
