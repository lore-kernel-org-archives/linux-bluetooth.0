Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1080E3DDB13
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783456879; cv=pass; b=IRviZlC5iniZYZep28Q4Q21jhxbikBDjRAdaZgRaAazN6+cihCoGQQqFCHdMDR18SKT0z5+ij1emHvEOlx7zmSUOzO2T2QoEh7o2n/jFGa6sjTrmbRp0DtAGI5Fp5gRtkTdaqW+xJKAXV16WkGmept6HqQkyltKcUxg8sh4U0kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783456879; c=relaxed/simple;
	bh=OEYNj48jbbYUNNwqE/IA6tVRUOzUdQg5q6XxDV7m+f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=L0QgrWu8Bp3QtArxKYeGbMbmBem03dThSGN26/ah5oHnihh4ptDMWx5AFoWIbgLzSFBrEOtH8GQfgswWge9vMGDpIa9Buxe5HtWm9r1sBEUe5A2XwO60nWl/5QnmRxq77ec78FC+x7BOEtAQH+T7Qg+wEamuFBGxmEwB7rn9AAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=SQA1U3Cg; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="SQA1U3Cg"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ca1328b8584so3698723a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 13:41:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783456877; cv=none;
        d=google.com; s=arc-20260327;
        b=QpKSZ1HZvtoNjeWUGNXxYrxVa7rDbS+TDTYoqO39FTQ8+9OIWlfQY89E4AZUo25FBa
         gZ5N3U8uetK0emEtJLou/45uS1RkBGh6SgjP2e511pUeSKK/B9DEwRTtUvqi5LgZ5QlV
         9RXwwpcI/LIqcp4WLGjFR3ViyCWYLkkh90g9F3jO7YdXaEpXreJa/K8W0LTiC9L37SYx
         sQrtiAx9+qdMIHFEhAjS3vqGqb+2Y/4qP8Mz/Www3Bzbqa2PXj8yTnNu/jEm+f4ErV20
         f1RcfzaiDxzTjzQK8LsvySn9Z/s2y1IzSwr+8ZSJYeriki+fnhYbmWwR8N2hAVlsc+8d
         C+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5wbPWsZnDnpqoiSoLYCBY1igTIMljfIrUYx80dWHJgM=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=HKGsPEcgEJfDkDtS2Mbjbr6qHWKunwxKmhumh80A8IODC1/gzKW4Senk9j7l/2KeSN
         alXgtxNRFNzkl6O71TzIwXCibsKVik1TSIDWEPtL1k6cJZP0UTR7X8x6O38uAMg/aAVP
         Fz4YsdzByuVem71g5yGginMn4LQtd3qwtgcLd2CtLm5RCDLHZG7D5siNAyHhSSCEFb4l
         XA+BvnnWQzOYaz9WVin3KsL1hl1lzbMXFz9Yc2szxy+czcAKiVo9ImswKRj5r9EBHixu
         QHZvjYu5Zmj0qxBJyYq45lByV/wrse4HUUVwy1i6Rd8kp9mCGrCR23fMfoDY+7aCWbCe
         hosQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783456877; x=1784061677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5wbPWsZnDnpqoiSoLYCBY1igTIMljfIrUYx80dWHJgM=;
        b=SQA1U3CgbvyQ4AWVIRqyNPXoAEEn6uohxYZiLFYLm6iRGRLitXRspZeC2qM4FRayd9
         xUIOo1ILhViS7MqWmTGo9dsqzXlDjPs7A63pDEWR4+kE6K1wfWcZ4GbzC5EDJKukXbbh
         aY3GvEFoB6CL3i70LKOS42y1RXt3Gx7ZqtMG9UEXYXteQGLNfKQQ6Cbg8iyQj5Y2LIem
         a3AW7Es4saq9hF5v+E+Op7cgMKHWC5KC0M9+8ES4aW6rFexSxecthHXR8A2xPSnWxApN
         Wy+cnNyZzhJbBU7R0dwwcnYZ5RVOJ+1VfRJfnO+6yElQ8pbb0FiRHZSr53ki22ROfLeN
         BoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783456877; x=1784061677;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5wbPWsZnDnpqoiSoLYCBY1igTIMljfIrUYx80dWHJgM=;
        b=MvENu6okhMHHhTZNH9xLYvSY6292kEhD4kFvTb0Zmhk+xireyRo7/CpnONfaomAiKc
         QVJSjKWZ8XaXLPNIkHFp/Mz+YHeZiy1lYY5jXPQB4PCTs3UFqL8W3rTw7DvZsxCiZdLJ
         lrZnTP4cJ5mpSE7wR7Hkegn7sv46c2hENzv+lm3MU5fc+RyL7S7RsMsRWtSDixqMsC20
         sdK8aNfgijlBTD5r3tPX6aZPo466CW6K06WEXW14sZ5SZIvXqwIrfiU0yjBAqg9Pgxo0
         egmn7icFhStiGrPfAv009mo2B91x48C7vJ6s/LE0AJzhmeaHy9gMmrdsQN0q/ZyB8A8P
         OOYw==
X-Gm-Message-State: AOJu0Yy9fNHQR+Qkg3u6ZPht0XSxnM6fSYiVI0FlLAtHo//PHYSWnDfY
	zTn1gGZwJwGTtwdWtT6m0gcNSd9BAjnqstUIQNNFcbSsycW4X2k5FWsLVXwIn7zSkok+B7yesKz
	IT+AsWG51g5f02NqzaO6WEnljcqcbnWCzc/lz6NFFNCM1O4pg88eP1MN5tRk=
X-Gm-Gg: AfdE7clLlxxgDOoXXRm0bLbGo1W+zXC81guktmKeh7MfJLQLr5TzYiQtYfA1a0D05y7
	6c4GPEihBcqrz6iPCoPF97YCsLq2mQrls0SfeQEMZyPnMh3bzc1wBnKC9pkddHLd/Fyp3ggJiyV
	X/MPB9JFuZDyy03qPgyAazmoAxpma9OD7WHJwOICEgOlGcUgEwnWCFo9UPDqlnKSrVE2wdANsP8
	VHTzHqL6BRwvAM5AVZRggrQwnS8VV7ogW7dJNWZQJYgdxuRhYMrqMMwX/8FFbbsiPkJ+bjRd/YS
	ZbkjB/VJQ6b7J9vjRN5IBaYmdZpr
X-Received: by 2002:a05:6a21:69a:b0:3a0:b781:4c78 with SMTP id
 adf61e73a8af0-3c08ecaff36mr8005203637.15.1783456877266; Tue, 07 Jul 2026
 13:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703234350.225221-1-xmei5@asu.edu> <6a4855c6.33897c89.13d8ff.b540@mx.google.com>
In-Reply-To: <6a4855c6.33897c89.13d8ff.b540@mx.google.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 7 Jul 2026 13:41:06 -0700
X-Gm-Features: AVVi8CdAaDnmsi2Bce9gNvlqC1GyqQv7JTHsbNUTP6op9DrVGcKA0OOK9AOI0U8
Message-ID: <CAPpSM+RjdqipV=aDNdCWMeFBVueGsNMjxj9rfA_Yich-kr35SA@mail.gmail.com>
Subject: Re: Bluetooth: hci_sync: take hci_dev_lock in hci_clear_adv_instance_sync
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 5:37=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D112=
1363
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      0.72 seconds
> VerifyFixes                   PASS      0.13 seconds
> VerifySignedoff               PASS      0.13 seconds
> GitLint                       PASS      0.32 seconds
> SubjectPrefix                 PASS      0.12 seconds
> BuildKernel                   PASS      27.14 seconds
> CheckAllWarning               PASS      29.13 seconds
> CheckSparse                   PASS      27.88 seconds
> BuildKernel32                 PASS      25.90 seconds
> CheckKernelLLVM               SKIP      0.00 seconds
> TestRunnerSetup               PASS      492.72 seconds
> TestRunner_l2cap-tester       FAIL      58.77 seconds
> TestRunner_iso-tester         PASS      88.28 seconds
> TestRunner_bnep-tester        PASS      18.79 seconds
> TestRunner_mgmt-tester        FAIL      210.08 seconds
> TestRunner_rfcomm-tester      PASS      25.03 seconds
> TestRunner_sco-tester         PASS      34.71 seconds
> TestRunner_ioctl-tester       PASS      25.82 seconds
> TestRunner_mesh-tester        FAIL      25.88 seconds
> TestRunner_smp-tester         PASS      23.31 seconds
> TestRunner_userchan-tester    PASS      19.42 seconds
> TestRunner_6lowpan-tester     PASS      22.11 seconds
> IncrementalBuild              PASS      25.85 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script
> Output:
> Bluetooth: hci_sync: take hci_dev_lock in hci_clear_adv_instance_sync
> WARNING: Reported-by: should be immediately followed by Closes: with a UR=
L to the report
> #129:
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
>
> total: 0 errors, 1 warnings, 0 checks, 16 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inpl=
ace.
>
> /github/workspace/src/patch/14663493.patch has style problems, please rev=
iew.
>
> NOTE: Ignored message types: UNKNOWN_COMMIT_ID
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: CheckKernelLLVM - SKIP
> Desc: Build kernel with LLVM + context analysis
> Output:
> Clang not found
> ##############################
> Test: TestRunner_l2cap-tester - FAIL
> Desc: Run l2cap-tester with test-runner
> Output:
> Total: 96, Passed: 94 (97.9%), Failed: 2, Not Run: 0
>
> Failed Test Cases
> L2CAP BR/EDR Server - Set PHY 1M                     Failed       0.264 s=
econds
> L2CAP BR/EDR Server - Set PHY 2M                     Failed       0.265 s=
econds
> ##############################
> Test: TestRunner_mgmt-tester - FAIL
> Desc: Run mgmt-tester with test-runner
> Output:
> Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4
>
> Failed Test Cases
> Read Exp Feature - Success                           Failed       0.238 s=
econds
> ##############################
> Test: TestRunner_mesh-tester - FAIL
> Desc: Run mesh-tester with test-runner
> Output:
> Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0
>
> Failed Test Cases
> Mesh - Send cancel - 1                               Timed out    2.669 s=
econds
> Mesh - Send cancel - 2                               Timed out    1.987 s=
econds
>
>
> https://github.com/bluez/bluetooth-next/pull/395
>
> ---
> Regards,
> Linux Bluetooth
>

Thanks for the CI results; the failures are not related to this patch.

Xiang
