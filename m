Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A99F266EE4
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553067; cv=none; b=MJccKG1QtoY+Wu+xs2po7ojZ2pSELY0iCQh+mIP99n9M3FMc+w482TRtFr7cmml5AO3AQELHO1oH1tuXtfSW4V2nOIvB6rjMgO8uWWSNYiTNRSwOJqt1B2zR/uHBrlZH/DdLe09kqHiQD39/XN6LLcSIUqOhu44Fgqv2Cn8jLZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553067; c=relaxed/simple;
	bh=wl2YB6wC3J7faB4rN3S7HORQOcp4W3kEkjx4N9crWAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=HT/C4pg8b3iKNjPna/WSsfn03Ah8wTVvrcHYAMZ+wCAUMUeQxfqzv2z8pq7iNTiF5DLR2JVT38vS44IyBpZZ5NU2OaGHmxcB7bPxnnrUVDXr8JC/p2ZL/EYzfSOfCHCtqPHtaVSh5SR2A62ZMS2UBoAIrVc0OLhsM9qpkUEk9ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLceQiep; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLceQiep"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-308f71d5efcso22650331fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 09:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739553063; x=1740157863; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kZ9uRkWTa8biLelD7Cvk1MXi+QCj0upbNlFv10xk2w=;
        b=MLceQiepjXtRty1noWBX0YhA5t+zDKnIigkH4mKRZwKVtdDP8o/uCRZhFga1CF6RB/
         VK6VYQPd5rXQCZ3VUhz+Ec6a9nfpxPGNxeoJwDfwYJrvtrsYioouNO8cUo6fF7sO+1KK
         RalhZ56CnGfg/01vbDljjrZYdXIHUV5QNFMCHrMcbwVoPpt32U4aX24AbrlUNLAWF9tq
         DQJUvBzl5Ip+dmvV2jEnNc9ik2E6psmO03aHH+Nrq22sfPhfYeHg7OVlnkjkhbyT5OM5
         shBeUgxFN5x5IKvqiejCrAYmhONrJ6qqreps33MxAuIgNi4+q+MwazpVoxO9QlYfAPmF
         jqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739553063; x=1740157863;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kZ9uRkWTa8biLelD7Cvk1MXi+QCj0upbNlFv10xk2w=;
        b=urEpnZCeZLZ9C/41ZGjRu0tVebXdkerzi5nmOD8fPvdHHLTk3s6Dyw9qqVSGgH52LQ
         aItfXTb+RdrIOFCmcGNiA1z52x3kckAuVE5ely/2+Y4d6cUPK7/aw73W6kzLICuJ64EZ
         c9/rdPLs3mJI00J+CaHs2C+aG5PCMH6BMkGgiy1tXWWHrnpfbSI9GET4SGEoSmCcgsas
         SYRgiBbg86BS704s0BggFDRQJYu3QWmVe1y6eKMzDN3OtMFYABK8iexKeOMUDn5eydDd
         RUa7IN5rvi68DJZRw7ZNvnZhfhB3yY3K2argstSNCxdBDNx2OMLJUgrJZugRWN2Kg1QQ
         nWgw==
X-Gm-Message-State: AOJu0YxlN3WhKGEhPr3aiY8/ugc1zu9X0kpWyw8xWqtgjXz1YgTYBbHu
	XZNnHXNTmyFPY7CQ9bDm9hnMh7VZ5pljCsoO2Gbr4KV84mOH7j/FwmhObDzmsauUWOzCDWEe+as
	WcMIAG4VgoyHKYpKGpd2eH5+9uVCDfwUr8rE=
X-Gm-Gg: ASbGncvKHNhGizWkoBI3rl22Ecpajp6clPIEbLPfq69EbsY/Kvr7UyS5k8GlEnUvQNN
	cFJBciXWB1mSGVqqnew82BrI9lyYz62oTOr3noyR22Qs8c3lXaAygvVH9zc67sjUWSdL+s10=
X-Google-Smtp-Source: AGHT+IEwXfSZ+z1qqmfWAx1pu6a58M9KnL6Ma1TVv/B/rrDsVilu6sXIEjdjNt1srrdLrF5i06oKcO/f0Iz1nzLXy3E=
X-Received: by 2002:a2e:8757:0:b0:308:e803:118e with SMTP id
 38308e7fff4ca-3092795574cmr1598411fa.0.1739553062581; Fri, 14 Feb 2025
 09:11:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214153711.887794-1-luiz.dentz@gmail.com> <67af70df.630a0220.120429.66a7@mx.google.com>
In-Reply-To: <67af70df.630a0220.120429.66a7@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 14 Feb 2025 12:10:50 -0500
X-Gm-Features: AWEUYZlMD11yw30K-dscWhlpw2yMhameyy_KXAG2ypgy0_jymx8vmrw8p_IiVHg
Message-ID: <CABBYNZJqkSkG+1oNhn4_Gff_YzCLDbF-Qbo-UBvu_pYpqMEaWw@mail.gmail.com>
Subject: Re: [v1] Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response
To: linux-bluetooth@vger.kernel.org, 
	Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arkadiusz,

On Fri, Feb 14, 2025 at 11:35=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D934=
075
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PENDING   0.40 seconds
> GitLint                       PENDING   0.32 seconds
> SubjectPrefix                 PASS      0.41 seconds
> BuildKernel                   PASS      23.77 seconds
> CheckAllWarning               PASS      26.41 seconds
> CheckSparse                   PASS      29.88 seconds
> BuildKernel32                 PASS      23.75 seconds
> TestRunnerSetup               PASS      430.58 seconds
> TestRunner_l2cap-tester       PASS      20.96 seconds
> TestRunner_iso-tester         FAIL      146.20 seconds
> TestRunner_bnep-tester        PASS      4.90 seconds
> TestRunner_mgmt-tester        FAIL      128.43 seconds
> TestRunner_rfcomm-tester      PASS      8.10 seconds
> TestRunner_sco-tester         PASS      9.56 seconds
> TestRunner_ioctl-tester       PASS      8.34 seconds
> TestRunner_mesh-tester        FAIL      6.32 seconds
> TestRunner_smp-tester         PASS      7.23 seconds
> TestRunner_userchan-tester    PASS      4.99 seconds
> IncrementalBuild              PENDING   0.77 seconds
>
> Details
> ##############################
> Test: CheckPatch - PENDING
> Desc: Run checkpatch.pl script
> Output:
>
> ##############################
> Test: GitLint - PENDING
> Desc: Run gitlint
> Output:
>
> ##############################
> Test: TestRunner_iso-tester - FAIL
> Desc: Run iso-tester with test-runner
> Output:
> Total: 125, Passed: 109 (87.2%), Failed: 12, Not Run: 4
>
> Failed Test Cases
> ISO Connect2 CIG 0x01 - Success                      Timed out    2.745 s=
econds
> ISO Defer Connect2 CIG 0x01 - Success                Timed out    2.263 s=
econds
> ISO Connected2 Suspend - Success                     Timed out    4.786 s=
econds
> ISO AC 6(ii) - Success                               Timed out    1.888 s=
econds
> ISO AC 7(ii) - Success                               Timed out    2.508 s=
econds
> ISO AC 8(ii) - Success                               Timed out    2.503 s=
econds
> ISO AC 9(ii) - Success                               Timed out    2.536 s=
econds
> ISO AC 11(ii) - Success                              Timed out    2.501 s=
econds
> ISO AC 1 + 2 - Success                               Timed out    1.980 s=
econds
> ISO AC 1 + 2 CIG 0x01/0x02 - Success                 Timed out    1.998 s=
econds
> ISO Reconnect AC 6(i) - Success                      Timed out    2.017 s=
econds
> ISO Reconnect AC 6(ii) - Success                     Timed out    1.999 s=
econds
> ##############################
> Test: TestRunner_mgmt-tester - FAIL
> Desc: Run mgmt-tester with test-runner
> Output:
> Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Looks like these errors are due to fa4d477ab535 ("btdev: Broadcast
EXT_ADV packets based on its interval"), if I revert it passes all
tests, so something is not quite right with it or we need to fix
iso-tester. It seems you remove scan_ext_adv from
cmd_set_ext_scan_enable_complete, I suspect that is the reason since
it probably no longer pickup things immediately which makes a lot of
tests very slow.

> Failed Test Cases
> LL Privacy - Add Device 3 (AL is full)               Failed       0.194 s=
econds
> LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.134 s=
econds
> ##############################
> Test: TestRunner_mesh-tester - FAIL
> Desc: Run mesh-tester with test-runner
> Output:
> Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0
>
> Failed Test Cases
> Mesh - Send cancel - 2                               Failed       0.119 s=
econds
> ##############################
> Test: IncrementalBuild - PENDING
> Desc: Incremental build with the patches in the series
> Output:
>
>
>
> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
