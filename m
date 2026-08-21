Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5AA3FD129
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787340908; cv=pass; b=e6t+ldpffDdkQnziq+W7Tw6uEebJGN9KP4XVYZ9+F4Tm7bJXNF3ivAs2AB9H2uZYu3o0i5rkiTdxt6vdB3sZTkEbdvQLn7q3NYpJIs2ilHd4BxEcucJ+RMEqCfInZUgmVKCGuc/gPW+MnnGHXuzivTCMXu8Z7v1rzm1+Ee4JXDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787340908; c=relaxed/simple;
	bh=yYcnsJsGAqCsetTL6QbJWlcOcaq7wuNwvI+R59jUMQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNBVRu3Yf7BxmvINUgaxchrjOtJ8dSH5Ht5qETYve539rXHro7Tvv+tPUTamezjEDgyXsjQaiM3SjG+jVXUKN/ak1+RQyNuNKg4mwXRipigzHE8JKIEZnsCLSBvq9ykOCGqZXl8Pui2tvLkfMApR1cZDydandLTXRf+igDJ+CT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OU3uahyG; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OU3uahyG"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8111c0c7561so21790147b3.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 12:35:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787340906; cv=none;
        d=google.com; s=arc-20260327;
        b=duwMSiSXaSqh61scYgQYM/vcXYlHXac39oGJ0Td1qHnx4G9C8qywGyeTl4XdIs/JnB
         CBydEOdkxaYqbBO5TFb2QLs2X5/F83Xnz7V5kpS0pzoErSJICZRIV3ynLMFxGhxHTWQO
         si0g6BtilHvfmQgsn96GxLWn7rPdlbekHmaW72n3bQHVfOAr4X7T1tcGMHDK3x7vYnq8
         /JIBdHC1HE69wlTnWr3QHWO+eHKOM4onWL7ZM2U10z4gAs84QHsJMK+I3W7Rkz1ehM0Y
         T2SIjeXN9MqHRLSjX4xSPamwYg7qzkzP56rEsxpNm6CePnSFu1dPLVluvtaRz/4pb2uO
         2pGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k+ZVSYggzP2D1tRCmEL2/VzMCbQT+7UUQz8pSHir0ks=;
        fh=NLzESUHcpfcfdJsDGcDuL9PU0+kkZ2Kshiz5yjG1aH0=;
        b=WdFhFm3KsJ2W8682BS6HWZmFJVrhhqV3l3CEG/Y5R0PjnFD4JiKIOfUVX123HTn63q
         /yVybYQdblugN+RwjwoI/Na0PKA/k3PPzU8K/LA9j/aElK9evVyPkI2VzALvH1ShqPAb
         AcdqB98QZDCOZRp/iB35WU7Xeg0J1XvhPV7mv/QBPTyep4lVLxEtvHpP1h/ekUqC3/WQ
         EbZv0Pl87wgznFxm8SB9ySmXeFqED0CCrYKv4Kvpk0SnVdMM/wVQpxyPWZW+7gzO29r1
         jTe74OQ37kTvtSuqPks6V3LUodtW26bbFRVlNfNZfg2A5a4vyg2W4iqIzK3UJLXxG7UW
         7iYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787340906; x=1787945706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k+ZVSYggzP2D1tRCmEL2/VzMCbQT+7UUQz8pSHir0ks=;
        b=OU3uahyGcN+oVR1kNHyn6oeoqDzRapG2YjH76OGYv3uyLaEBfZ9VFhcUCVrUBwVJLU
         7CZvT+PrqJlWLn9zVexkz//iuBsKxniGQjVDmrBVKdUYFzfRVKQ96QykM448Jzd1Ecv7
         KeC6wengAIaudSmBKweJLnsX5mLyom0T+m2jAxngLRp+VKl7GKLBb0BkZPmnY2ijJrj5
         kvNjUN/i8w+j/VFMeHwByuAZSZvhzJesdwNsXqC/seFZOMK4tmvBTFD9/VDnppzAw2d4
         x7O/dMtSNcIBWX77CjmSoULluYysz/eWJk7R6ZKoYW/oluJaBFbC86Y8b8O/BLDZHhiB
         38fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787340906; x=1787945706;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k+ZVSYggzP2D1tRCmEL2/VzMCbQT+7UUQz8pSHir0ks=;
        b=FIOjhxBOQyzESXZQDaZfOLsWbau6q5+wOTcEW+sDwkAk5lzImOo19aoInhSsOn24HF
         D9wQOHTTkNAHbWnIAqqgtnaM54rJEztLkh/QKMoCU8OWnLyufTSokmKx/dWPp4ozTE4z
         t7DFy1+sXnYi+YubGHuEhSEB6dGWKqC4NyRTTa7dXbJF9DmcC21zPikcskpE6KKaWmf0
         WY6OVsdfYd5qTx+nEYZHpP5LbAoY5Y5bBAYGCvIyhAysgsoqo1uyiKupbMlKFJ+NzTEC
         b2dQqhYNEDKttbOCnXD/i9q74dX9HM3Fd3eZOgrSntbsiVlrAT/mmuwDJxBmPeBQpQkD
         Qq/w==
X-Gm-Message-State: AFuF++k35KEo0Mxa9C07UbHMw2k+HB9eDih/+yVARltUY4QlVUoGY58v
	O0eiqVl2l9U6RTT8kZQOBGXjRQIuIorUlnZhQF5Xl7FL6Rj+XIgcSEdi/7t/U8/h4vfW//WlECg
	o0DHxhH0pIuHQ2Jn36cktQZovUrYPSOTfDBVd
X-Gm-Gg: AR+sD13d92QfJkLFPFcyOj1K+oVWeV7f0QrTCUDAeW4v4M94E2rI0p+z3phvzaESUze
	M8mgfv7FdlBD2lnSXeq495KrUT5dm+qagasy+SIYi07c1HBGMk1NSYc3R/4EzPcQ4pm9qCGJidN
	l7vgWix3SMEUlIrprO034WO17uvx5dg0YHwIQ1xrEa1Qj6y2ehyYJNBxcFx1YU3Ddvl/fgLHg2A
	oHpZ3Y64WF7XkuE9QxHBzYKXeJWCvUHGbPJrN5h5cy7s7bA2JkCnuBPLM4wM0OSX6nwdLMky/rV
	MVacnFQX0zkKr/tZU081QGRjd+GBodqvjgQMYvgw4UMS6x8eoIze8O5diXCLGpNaoETpLFs7x8U
	qQ482xY/Hro+Q1h8Tyeo6yktJ6ANVzLY=
X-Received: by 2002:a05:690e:1709:b0:668:172a:47a7 with SMTP id
 956f58d0204a3-66ce4ab04eamr2523828d50.25.1787340906275; Fri, 21 Aug 2026
 12:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821172441.3020751-1-nicoyip.dev@gmail.com> <6a8891f1.d07e16d6.329d01.4fbd@mx.google.com>
In-Reply-To: <6a8891f1.d07e16d6.329d01.4fbd@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 21 Aug 2026 15:34:55 -0400
X-Gm-Features: AcwNN1WdcPfgGFSlXrsdua3wRW4kpyU93x2Z9Y1E6D-n6BbXktWp4ikueMhXYEI
Message-ID: <CABBYNZLkzbbbwFoJ9Yf3b2z6MnYsxzHWZw+p4KOKE69Qfw+h2w@mail.gmail.com>
Subject: Re: [v4] Bluetooth: hci_sync: wait for directed advertising completion
To: linux-bluetooth@vger.kernel.org
Cc: nicoyip.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 21, 2026 at 2:00=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D114=
9955
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.08 seconds
> VerifyFixes                   PASS      0.09 seconds
> VerifySignedoff               PASS      0.09 seconds
> GitLint                       PASS      0.22 seconds
> SubjectPrefix                 PASS      0.08 seconds
> BuildKernel                   PASS      20.72 seconds
> CheckAllWarning               PASS      22.44 seconds
> CheckSparse                   PASS      21.36 seconds
> BuildKernel32                 PASS      20.27 seconds
> CheckKernelLLVM               SKIP      0.00 seconds
> TestRunnerSetup               PASS      366.74 seconds
> TestRunner_l2cap-tester       PASS      52.34 seconds
> TestRunner_iso-tester         FAIL      73.59 seconds
> TestRunner_bnep-tester        PASS      14.91 seconds
> TestRunner_mgmt-tester        FAIL      180.28 seconds
> TestRunner_rfcomm-tester      PASS      19.78 seconds
> TestRunner_sco-tester         PASS      25.55 seconds
> TestRunner_ioctl-tester       PASS      21.03 seconds
> TestRunner_mesh-tester        FAIL      21.54 seconds
> TestRunner_smp-tester         PASS      18.33 seconds
> TestRunner_userchan-tester    PASS      15.47 seconds
> TestRunner_6lowpan-tester     PASS      18.20 seconds
> IncrementalBuild              PASS      19.11 seconds
>
> Details
> ##############################
> Test: CheckKernelLLVM - SKIP
> Desc: Build kernel with LLVM + context analysis
> Output:
> Clang not found
> ##############################
> Test: TestRunner_iso-tester - FAIL
> Desc: Run iso-tester with test-runner
> Output:
> Total: 141, Passed: 136 (96.5%), Failed: 5, Not Run: 0
>
> Failed Test Cases
> ISO Broadcaster PAST Info - Success                  Timed out    2.777 s=
econds
> ISO Broadcaster PAST Info RPA - Success              Timed out    2.004 s=
econds
> ISO Broadcaster PAST Sender - Success                Timed out    1.990 s=
econds
> ISO Broadcaster PAST Receiver - Success              Timed out    2.107 s=
econds
> ISO Broadcaster PAST Receiver Sync Lost - Success    Timed out    2.111 s=
econds

Seem like this is causing some regression with PAST.

> ##############################
> Test: TestRunner_mgmt-tester - FAIL
> Desc: Run mgmt-tester with test-runner
> Output:
> Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4
>
> Failed Test Cases
> Read Exp Feature - Success                           Failed       0.196 s=
econds
> ##############################
> Test: TestRunner_mesh-tester - FAIL
> Desc: Run mesh-tester with test-runner
> Output:
> Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0
>
> Failed Test Cases
> Mesh - Send cancel - 1                               Timed out    2.666 s=
econds
> Mesh - Send cancel - 2                               Timed out    1.990 s=
econds
>
>
> https://github.com/bluez/bluetooth-next/pull/629
>
> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
