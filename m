Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283243D3CF2
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 23:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790551630; cv=none; b=V2T6IvgNAvPhs717CxDvtOIoMUd0+/w1Is/8U/mJY9JFUhBeOO2nsQfZMkKWofSzmynVh7Cg0YxfAX0oXV5KSghF7EJyJvnjFxBEomGwGxafI6uRvLIuXI1uzM636MMjodAvGus5a1xLprZPhy4RJM/eiz66oT0ZO0c9C5wcAVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790551630; c=relaxed/simple;
	bh=IVajIfBm99ImcxfYjj1hWdjR7TxGI7By8VUPphskZwg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nxriwDKF0usgIhbSkcs6XwbxzX6kxyp0V/pM9lL4uwmXWmcLzsueHEjMdCnSxr3mXa7d9LcHUZ7W7TUSGDBzUgek48XRkPoqdO6viZzznhBvxZw8t8YMSi4Yxkzlk5LVJY6nlvUiTWioLTA1CRtXB6T/mS+rNJ0bFgSYTZ7Xjb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n9liyj0f; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9liyj0f"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d0522b4dso3872449eec.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 16:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790551628; x=1791156428; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d39i6xKgo7LNwg3hm8rksuHJlZ911kEBad3imiIFxtE=;
        b=n9liyj0f3VWKumpB1kZ4Bt08r6S4k+DmWALBRGOMVBowmMZTWRSLwkd4t15Sg4fPeE
         tdAy564PWmgrBpmQRnmQ8B++4pUkvc7AykAvfuUa92JrJ02HQ/aPZl7lK2ibggzQ0GvA
         PuN+bDa7Jx3fzcHKA/qGJ6frrld9/okTUuA11v9S2KL1YKMVLk+dhS04pEIG3OeWc2yh
         FHeslwqKVuSpyZnQn2cM+qJri8us3EMW+JhvQDtfCAUi3/VHXSp1QvaEAjXu4MlF2Xu7
         H+UhA7t7HtZa+bGugJ3PR1zEmH87RLoTzt2I39xzk4FM+VF+We+dIeVx7zxfaUXn9k7v
         Qsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790551628; x=1791156428;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d39i6xKgo7LNwg3hm8rksuHJlZ911kEBad3imiIFxtE=;
        b=IC3HcMoNI+33fSaDOewkbgx97Oh5i0WlYzh4HEKMhV79kutfNn8kdqH4qrxthmsl2O
         NwU3AjjO6bJkdMzWrV1RmrNqW84foC5jLbFS6hMfyaauFnaBtkTDAmEE4JG1JX65LDAI
         sGM8VOJ+7wQAL6ldkkEEGu26Nr7ou8XWwBEPkObIg9BfEVBTeDze3tTEM/4ZsMmIRgSn
         0hJ0+SsNkzX5kHJSrLJ/kiUDpJo9ogeZbPi5TGYWt0CU/K1QuVocV3NxRzeVkAW+E9W1
         5PfH/Jk1Ihp6OJMk++DuyP8FAIX+bUyeW7XGIMt9LEeeleOhe+FEhHGUtk7gMUuGfTcH
         KP4g==
X-Gm-Message-State: AFq9FYIovqZFM2ntoS2L+F/fuMdXxee3E+D/oE29GCm3TXWnAj9vR7mn
	6eLL31o7FVRlk3yWH2NpnXPb3gee0yD6DUTOo7GHolfYWB6/D7SzKaHVTdKCuA==
X-Gm-Gg: AYBFou39EZ8j1In/k2xnuPvlQ2+tQ6ZKCQ5oqs7OqRj7qqS48a4nQFA0+mmF1ak3BY6
	5r3zzJdAFdNDx3VBC/QgD4bgU3PLma/iOTfymWvnhKEj+kD+iYfZfFNFcxwqV7eN/lnDmfdpoOt
	XY3TCa857CA0WwlXVvlbjzpNIKyfnN4pdgLZgF5z8g7MS3rBnt9bnuj13t8iCAjeRXTJfuzg/9k
	Mz13dweJeQtSYTTCh6NkyO+6E4pkE/9ThiZQPtIAM3KsR72DIUUTvQ9lsq2lM1mgufQm8r4/RPu
	Co2Oz2YEoN2mMpuOK7FVKBeYHAAg7Kv/8F4dWSCoJiz6+fsy0rSCJYn9YtQvhER/psykQTj6Iz/
	FUE4pIpGL+sJZqvRQdO3t2Rh3XfdWy9aZtSghgjFPGN/gBo8KEwwoFPcOxPTTZ2Hl7Wx9jqY1Nu
	aYFHHiip7E8M25QRxOx2J5S3ODfgSurGAtgAS7NhCPQ6clqECzFqN04/TerTNowf1jm/JpmH0MQ
	37UaMY=
X-Received: by 2002:a05:7301:1c19:b0:33c:130b:457 with SMTP id 5a478bee46e88-3427384926dmr7720725eec.38.1790551628044;
        Sun, 27 Sep 2026 16:27:08 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.140.140])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-343580930e2sm14500474eec.16.2026.09.27.16.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 16:27:07 -0700 (PDT)
Message-ID: <6ab9a64b.be2e0958.3071b8.64b1@mx.google.com>
Date: Sun, 27 Sep 2026 16:27:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3135165553324664549=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: Bluetooth: Serialize TX scheduling with teardown
In-Reply-To: <68cec17b5d5b42639671fbfdc8761940d6c9476b.1790407061.git.nicoyip.dev@gmail.com>
References: <68cec17b5d5b42639671fbfdc8761940d6c9476b.1790407061.git.nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3135165553324664549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1174569/

---Test result---

Test Summary:
CheckPatch                    PASS      1.17 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.47 seconds
SubjectPrefix                 PASS      0.89 seconds
BuildKernel                   PASS      29.82 seconds
CheckAllWarning               PASS      34.19 seconds
CheckSparse                   PASS      36.80 seconds
BuildKernel32                 PASS      29.72 seconds
CheckKernelLLVM               PASS      33.97 seconds
TestRunnerSetup               PASS      793.36 seconds
TestRunner_l2cap-tester       PASS      16.58 seconds
TestRunner_iso-tester         PASS      26.90 seconds
TestRunner_bnep-tester        PASS      3.07 seconds
TestRunner_mgmt-tester        PASS      61.18 seconds
TestRunner_rfcomm-tester      PASS      4.40 seconds
TestRunner_sco-tester         PASS      7.56 seconds
TestRunner_ioctl-tester       PASS      4.55 seconds
TestRunner_mesh-tester        FAIL      7.76 seconds
TestRunner_smp-tester         PASS      4.27 seconds
TestRunner_userchan-tester    PASS      3.12 seconds
TestRunner_6lowpan-tester     PASS      4.37 seconds
IncrementalBuild              PASS      37.19 seconds

Details
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.419 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/823

---
Regards,
Linux Bluetooth


--===============3135165553324664549==--
