Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF49F16D4E1
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659597; cv=none; b=b7dTgWzkuERab++uMu+ESQ+ds2376zpNxwQWDl5G6/c4z0jfqzVtrIdvgB8LRhDe32LYasmaIm+VOPav3Gz3Zm+DNdcVq5QptO66mzbemRo6dZEvpPYpjaiETi7bNMCKHQfaymSq9kF0AjmW34we6z27I5o8uFH0CaSFg4aAJFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659597; c=relaxed/simple;
	bh=sSHFJaTuJ+UPDME02bNwAQkR99aAbvESXYt6kirYNy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sF0guY1b87Yt9YbQhCWwDDoEJ6MF5BI/KtJ/GBdmeUVVUF8eRx7EpPXbR45mTJpOHh9aLEu0M1wSIL7jIk1umym8TGQ8FC035bR2/CjteM5YOGtUxa1JZgwYrg9QtXOtnqHy/0x/jOhiJY9+jMUV6spE2PM7a7UcM7iwak+Qj58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPy2bgDQ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPy2bgDQ"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef1c12ae23so21959441fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 07:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721659593; x=1722264393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FoRuf7nVirss1OZ5R6gl9bJnRF23LC2lAGIwLmdaco=;
        b=WPy2bgDQOtI/7uMIcv9pN8kzPWoj1WmmJJLtOzMMBi29LNgIzVWL03CtxfPu07chbe
         OGhnGhD8ZZvwzJVvQWp4LWWHsGfl//WO6T92195WvcEEZJcLKmgG2cVzaNKYawhrF5Ac
         8aJ1EF9VVW2O456+cPVCoH2v+z+WrioPwJNgfnMdom8xmMVG1lNrksD9PbAYrqQusP/L
         77ZgGU49nwNXce30p2gyoivLzwicku2FcCCsIlrGPE1pGx+vyLxmur13LbCR+7xpgTfE
         hysNpUeVaZUfLyivMTtuCsyu94llvuD7spkmGbDjJROOJjJrmY7qSisG8WWI3Ucl/4iI
         V0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721659593; x=1722264393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FoRuf7nVirss1OZ5R6gl9bJnRF23LC2lAGIwLmdaco=;
        b=eTfaim3x6neVPFppE/Q5D/o6BDYVCfZnjTSEjjwrkHdioZgiaZL05rc9zbsOEYCgfZ
         t480ViQ+MYLfm4KtQINMK1EMOTb7C1JdGN3SVPKetk/uTOiGQMyBdoG48CyZhmI4GYrm
         B35wwezi1z8hKHuobyXKjFbVbuTI9BZ0pzLCq+4ABHyJpQ2dssLs5ofIJ/FUUkXEpKpH
         Sz2TJEQYxN/z5uqFcNCAMvmXclOeB975bU+29EffsXfj2vhsuyJIFydRIM66O54JzQBq
         2YfutXwgNTRXqoQAqy7B8xuWWIMBCO+O+2iH028Hs2yaOIhk67KpcAsDX98wtN0jQdto
         zNvQ==
X-Gm-Message-State: AOJu0YwoQIJ3P+P2y7tKdtm5aXwKcY1+607GpDpO6TnlLft44Paj3zUi
	2zxmG+iJtDYQmkr1VCsBPAQ6Ruq06rqR0DFOA/Qkg6Nre0s0WAtlYNVmEo3VQf7B52VJnchej9c
	cSBIKOuPZlAYNH6AwXumf91F2jsxLfnwy
X-Google-Smtp-Source: AGHT+IFX/f/HKK/UGxVknb0TrxXrNI5uD+E9t5EAnML9rYKG9yNEXiAzPfjvx9QGVWaVxigMuGy9Wj8mvWdoC5eIhiY=
X-Received: by 2002:a2e:91d2:0:b0:2ef:1d79:cae7 with SMTP id
 38308e7fff4ca-2f01ea5569emr324521fa.14.1721659592671; Mon, 22 Jul 2024
 07:46:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722062216.16090-1-chris.lu@mediatek.com> <669e0451.050a0220.405fe.97b0@mx.google.com>
In-Reply-To: <669e0451.050a0220.405fe.97b0@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Jul 2024 10:46:19 -0400
Message-ID: <CABBYNZ+b2A-fbxD7enzchjDjEnR6-5pkhEGCck=O_OaGEi1OaA@mail.gmail.com>
Subject: Re: Bluetooth: btmtk: Fix function-declaration build error
To: linux-bluetooth@vger.kernel.org
Cc: chris.lu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Mon, Jul 22, 2024 at 3:03=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D872=
838

We may have to do this instead:

https://patchwork.kernel.org/project/bluetooth/list/?series=3D872895

> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.71 seconds
> GitLint                       FAIL      0.55 seconds
> SubjectPrefix                 PASS      0.14 seconds
> BuildKernel                   PASS      29.78 seconds
> CheckAllWarning               PASS      32.02 seconds
> CheckSparse                   PASS      37.51 seconds
> CheckSmatch                   PASS      102.58 seconds
> BuildKernel32                 PASS      28.60 seconds
> TestRunnerSetup               PASS      524.54 seconds
> TestRunner_l2cap-tester       PASS      22.18 seconds
> TestRunner_iso-tester         FAIL      41.19 seconds
> TestRunner_bnep-tester        PASS      5.28 seconds
> TestRunner_mgmt-tester        PASS      114.13 seconds
> TestRunner_rfcomm-tester      PASS      7.50 seconds
> TestRunner_sco-tester         PASS      15.10 seconds
> TestRunner_ioctl-tester       PASS      8.04 seconds
> TestRunner_mesh-tester        PASS      6.10 seconds
> TestRunner_smp-tester         PASS      7.00 seconds
> TestRunner_userchan-tester    PASS      5.03 seconds
> IncrementalBuild              PASS      27.61 seconds
>
> Details
> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint
> Output:
> Bluetooth: btmtk: Fix function-declaration build error
>
> WARNING: I3 - ignore-body-lines: gitlint will be switching from using Pyt=
hon regex 'match' (match beginning) to 'search' (match anywhere) semantics.=
 Please review your ignore-body-lines.regex option accordingly. To remove t=
his warning, set general.regex-style-search=3DTrue. More details: https://j=
orisroovers.github.io/gitlint/configuration/#regex-style-search
> 21: B1 Line exceeds max length (82>80): "Closes: https://lore.kernel.org/=
oe-kbuild-all/202407200904.hRqT3JKD-lkp@intel.com/"
> ##############################
> Test: TestRunner_iso-tester - FAIL
> Desc: Run iso-tester with test-runner
> Output:
> Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4
>
> Failed Test Cases
> ISO Connect Suspend - Success                        Failed       6.215 s=
econds
>
>
> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
