Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D92E181307
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715714162; cv=none; b=tfpxDPhbzVdqMQq/nOE+LVAXPL5tgLCd1/vYk6GYEZjmpOn3t0dqXyRzZqKXr+nkLJbV0tKu3lahni2R/aEofK+g1wtASCvEXzFYU1ez6cYRaOI2hWesxdcbGnP6BQOm2hcarStsmo3RvH0Fef3G+S1BrRo08GsSzrW+RJQk3dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715714162; c=relaxed/simple;
	bh=F9HjXH2JVkHP1GWDBOem6Mc4JQtXCmYlfs8jjvsM8d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbWrqYuOw1smQlY51izjukVlHaW9+BZURoSC4Fbj4EO8rJhT0Wd4xwWHMYeDrDbHLUSaY5N3HtMdOZ3I2RFLHOmOQESoXCjGGRG7Wjfg+Pj2cHRlgd/rCZLOEBU266MV7Nw9Z0MroffAbqLThUWU5rrnHGKrw07pvXRoSjNipwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivGOfGh8; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivGOfGh8"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e576057c2bso56186201fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 12:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715714158; x=1716318958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnuP+cbcOrFYFhp2g+dFZfQ7dBkjtyRnq6GmgofbsEs=;
        b=ivGOfGh8TGwHQpD3VrW21F8Z2FHW8vDXFSDoFWiu1R29hIhNdb/vbbIQduyt1SK6cd
         FKU6UQVDKNtJMLFzABvIxS+XfmfY0mxWjZ0ciOO6gpvB5CrAskmplWuX7tLshHe9dEVc
         Ttgg5kye0vN3sO4Bckfyb1iY/OaplpRwNsHkv0AQsUCRcoUeRkspjtH9O6KUTibJw2YY
         +9Dzok/woIeAGuc/u/8vQac4AuDnTBeRb0aFrLVPOoUiuikEtQ8szzgBS+UPBJMclNCc
         Mo697TsZiBQO8soecBEsGTKCUVZJ5wTKlDH+motD9km3H/LmPonWk9pO6W3hyG5DX8GI
         744A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715714158; x=1716318958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnuP+cbcOrFYFhp2g+dFZfQ7dBkjtyRnq6GmgofbsEs=;
        b=EVO4Ra2nFmyjescKTpzo8keEnQ8z6Pl5A74gj6WXX75GMjHksN4M7YOvgqbNpF9Ilg
         nv8Kl2ka+y8qmQuHN1c7t18tFtBQbuthhKgTGd0k1FQGV5Drejc7yAHJxeCMyeAm+Fv+
         otLkiDzDiUlARvAsAD6UN5k9Mvg76oqLcUVWpmkN63Kt4UE6uvJvnAy2WvFQ7Fuy8bxb
         X6Vao6swe5FUvZ0no4wX1vazWG+dd0/8pSMaL0kP/qgGk9ydcG+z36oTUBZVhKoEokz1
         Iot8ZxqyDQvqhsXKFT+L9Q+9QOCNsQhte/aQRzjyouph724acfavWRmP7lhALpadcJEA
         cW0w==
X-Gm-Message-State: AOJu0YxXySXVA/bPWfmR40Zvcm0nT2ffGHLESd42QfCWXPnruHx6+Ezh
	ELsK1iQRB8HfJeIOQgLjTO1THwgcrAcDRGeJCKqZ+7Hej7M2fWhuu11r2DUV2Tkvz+pmdmVJ0gZ
	c9K6TtzCDL7LI3/e0UAr7jprg0GsdBw==
X-Google-Smtp-Source: AGHT+IGsTCg0Y7LI8Whl+Nb1CHwz/wbEzzIm0BGK+v5EzXCAbSqA8SA5SjFAFlqWpa83QC/3OnpMcn8ovH6iqZXpOSI=
X-Received: by 2002:a05:651c:a0f:b0:2e2:812:4c4 with SMTP id
 38308e7fff4ca-2e51fe57d49mr130319901fa.29.1715714157632; Tue, 14 May 2024
 12:15:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514174755.750764-1-luiz.dentz@gmail.com> <6643af59.0c0a0220.8776f.2984@mx.google.com>
In-Reply-To: <6643af59.0c0a0220.8776f.2984@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 14 May 2024 15:15:45 -0400
Message-ID: <CABBYNZK50b1hbiRbxx23V7y_cHW1nXGOBOq1QnLoqKp3dG98=Q@mail.gmail.com>
Subject: Re: [RFC,v4] Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update
 existing connection
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, May 14, 2024 at 2:37=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D853=
196
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      16.53 seconds
> GitLint                       FAIL      3.37 seconds
> SubjectPrefix                 PASS      0.14 seconds
> BuildKernel                   PASS      30.15 seconds
> CheckAllWarning               PASS      32.80 seconds
> CheckSparse                   PASS      38.06 seconds
> CheckSmatch                   FAIL      35.29 seconds
> BuildKernel32                 PASS      29.14 seconds
> TestRunnerSetup               PASS      524.29 seconds
> TestRunner_l2cap-tester       FAIL      23.05 seconds
> TestRunner_iso-tester         FAIL      37.23 seconds
> TestRunner_bnep-tester        PASS      4.75 seconds
> TestRunner_mgmt-tester        FAIL      122.87 seconds
> TestRunner_rfcomm-tester      PASS      7.38 seconds
> TestRunner_sco-tester         FAIL      17.42 seconds
> TestRunner_ioctl-tester       PASS      7.67 seconds
> TestRunner_mesh-tester        FAIL      6.02 seconds
> TestRunner_smp-tester         PASS      6.82 seconds
> TestRunner_userchan-tester    PASS      4.96 seconds
> IncrementalBuild              PASS      36.21 seconds
>
> Details
> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint
> Output:
> [RFC,v4] Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing co=
nnection
>
> WARNING: I3 - ignore-body-lines: gitlint will be switching from using Pyt=
hon regex 'match' (match beginning) to 'search' (match anywhere) semantics.=
 Please review your ignore-body-lines.regex option accordingly. To remove t=
his warning, set general.regex-style-search=3DTrue. More details: https://j=
orisroovers.github.io/gitlint/configuration/#regex-style-search
> 1: T1 Title exceeds max length (81>80): "[RFC,v4] Bluetooth: MGMT: Make M=
GMT_OP_LOAD_CONN_PARAM update existing connection"
> ##############################
> Test: CheckSmatch - FAIL
> Desc: Run smatch tool with source
> Output:
>
> Segmentation fault (core dumped)
> make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error=
 139
> make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
> make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
> make[2]: *** [scripts/Makefile.build:485: net] Error 2
> make[2]: *** Waiting for unfinished jobs....
> Segmentation fault (core dumped)
> make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Er=
ror 139
> make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
> make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
> make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
> make: *** [Makefile:240: __sub-make] Error 2
> ##############################
> Test: TestRunner_l2cap-tester - FAIL
> Desc: Run l2cap-tester with test-runner
> Output:
> Total: 55, Passed: 53 (96.4%), Failed: 2, Not Run: 0
>
> Failed Test Cases
> L2CAP BR/EDR Client - TX Timestamping                Timed out    2.313 s=
econds
> L2CAP LE Client - TX Timestamping                    Timed out    2.208 s=
econds
> ##############################
> Test: TestRunner_iso-tester - FAIL
> Desc: Run iso-tester with test-runner
> Output:
> Total: 122, Passed: 118 (96.7%), Failed: 4, Not Run: 0
>
> Failed Test Cases
> ISO Send - TX Timestamping                           Timed out    2.741 s=
econds
> ISO Send - TX Sched Timestamping                     Timed out    1.990 s=
econds
> ISO Send - TX CMSG Timestamping                      Timed out    2.002 s=
econds
> ISO Send - TX No Poll Timestamping                   Failed       0.162 s=
econds

I guess we should disable (not run) these tests that requires
SO_TIMESTAMP for now.

> ##############################
> Test: TestRunner_mgmt-tester - FAIL
> Desc: Run mgmt-tester with test-runner
> Output:
> Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2
>
> Failed Test Cases
> Read Exp Feature - Success (Index None)              Failed       0.080 s=
econds
> ##############################
> Test: TestRunner_sco-tester - FAIL
> Desc: Run sco-tester with test-runner
> Output:
> Total: 15, Passed: 14 (93.3%), Failed: 1, Not Run: 0
>
> Failed Test Cases
> SCO CVSD Send - TX Timestamping                      Timed out    2.245 s=
econds
> ##############################

Ditto.

> Test: TestRunner_mesh-tester - FAIL
> Desc: Run mesh-tester with test-runner
> Output:
> Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0
>
> Failed Test Cases
> Mesh - Send cancel - 1                               Failed       0.104 s=
econds
>
>
> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
