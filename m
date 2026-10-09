Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2001B4CEE73
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554420; cv=pass; b=SU7+y5CCp25aBjFN4vG1qityWD7qUeiUwT/8GsDsP71EGDUm3koDL/8DOBINlJaodDXhx8epu/jbSReXeYLcNmIPJZUk0YMNZ33GNlLHkioShJb11SQeBKMAbPyTjHWLye58/qE20aPqYs3++tlkeW6Kv9ulU1ZBMSdHmX+lhGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554420; c=relaxed/simple;
	bh=DYb8YNAcNU39lWOHIJvmIbkvahd3gCmxvfUUXP9mY5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkGdMNdqANnQSIzzBy8PG/Tt7djNNqNznbY1kMS5cBCZtUrj/hbE+l6cgd15Lns98PWYJNJj7L3NK6OywrqkJ3bF13gJ2Aa0CvMcWRnXfD3tNYh5kIfZu7vvZJBrZNQyDZhMRafNycQj9twl4/06Ehqgtg9l/eT9a9usudU7fMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3eLyQIh; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3eLyQIh"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67921b515a6so1876514d50.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 07:00:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791554416; cv=none;
        d=google.com; s=arc-20260327;
        b=NCl7ff3J0zpihvKoTpTwwQxnfAhQKW4VrH2YylLjf7nPLz+qFB1rhpG8HayFNwQ4/9
         8BmKs+nwdtuY2EqXxwnQINgCvgYLXyJ3RzOGUn6pYV/MblJ/IjOXLuwmSX3AtdtqDPUd
         w7zJbSvaVEnwMsqjvOiTpBA61diJSSrX6ZAwSStV1XRF0iE9uulnJqNAEaLlcO+5inko
         uZ+VeKteybfmN5FmLeySUiwunBBbMD+/Q8VyfMe4v1KoZRDijtyMp+Wo2bVNnEYUn7il
         tXWPz0BiklC+Fcoh4ZyHnvMXeO9zu1KtVelDDcSMv92DkM/F2gCxGvmtEJnZlyPZ/nkv
         /i/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vNadeDwbCrgcp1nGeq2T9VweKMP96S0h2HKd+xQxqZ8=;
        fh=beV6bn1BK86Y6EVmCr3+D792Gj31uqEJJ4YGKsgRA/c=;
        b=QuSYbNm9/RF8NDbQt9cC8LJxOUlHgFBqqJrMf6lsGhkSporwkJBoFZxB0TABYxTKgj
         U5gROrdL8xaEv4eRlkH2e3Ce/6SH3GuBVGDNUcynxbjkX9MldQD8+789KGUnSWY/rr7l
         4fWwnwGbcHko2kR2PQqdTuonC+MDpzYE03CdFc5A4X4US14WFqdwb0gRST3ba1QuP1JC
         2NM+t4KYGM/C/L4V60PCO4lRwnbfUMjLKj0pWcULnWmIJlO7zxX95aT5pw7igopYbDfP
         s6iEYCt9XkS5QeXi1bAHIu2tQp6ISoyghgdvlRCKmAvytWsTeZ8ON4WPU26Vr5Gao1tN
         tcdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791554416; x=1792159216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vNadeDwbCrgcp1nGeq2T9VweKMP96S0h2HKd+xQxqZ8=;
        b=g3eLyQIh14P1ke3vy05Bj4SZgt30lVmOGNuJhxzDkoyxJnM+B6LmRhfSX0JV81r5B1
         WnSdvbJHbGGlw9iqHmUr9LGrasU9LxMIdOikhm0f7lO7a21JUoOVqodPUTRa7S8x93ri
         O214xBZtoeN1ir5/BJxcI8ECh3zh/isQxxjFn3suU0OD/c5yYY3uzw4fCY9sy3XxVL6k
         g4D69B5jEU5BdO+Zy5tyOeorVmxm14dR/ZbDJfcbR6bd+jhzu6ZqJ7LJ5QCa5eTy5XQ7
         lPPFduUrUxCItF0F7gG+D1+5aapD4Nr8LoZQ69ewEaUhXZ4LfB+PUApt2Y3+l6Xx6ZBw
         vOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791554416; x=1792159216;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vNadeDwbCrgcp1nGeq2T9VweKMP96S0h2HKd+xQxqZ8=;
        b=A8n9opYP3q8Q3SbOxgz/SJwuGU6a5lcmwcflWbw+cwiuQP2oIeaxK6wZPnVa/nUgxR
         hAah8W+HfcGEx5MjYhx/IkkMFki7ACE9MSJYiNPMIOpxnUy2ra7bEh5cZ273QBWtN7Yy
         2Q2yQ2JbnTRxK60NWH6SZZEio522llQhdz1N/lX6o7tXQFnSwYDoLSe8Y1Rh9ERuEZEW
         9BqD6LyPzA6E7PyXf8bQS+nX4K6v5YVwPxnwsHFDLv1GsBDz5qpPkxUSEedQOh22ghla
         fsIpJ+6GRcEY0ZUM4xIn7VfDfqjVW/iH6JAxnUL4BG6ITTCqxZhQW8Ydvg9iMnlpPUWZ
         neyA==
X-Gm-Message-State: AFq9FYJHDc6nLpb9TE/F4rVd3+XuHt1iSpQvMbITlkywTcOdw6rO9zL8
	srmy9aGqZOPoDqZhSyTyi+SRtBGknp4uNZEcAaEEK9KptJ90nWp+iGPPrnHMcIKAACqKbMCCSrl
	AnMJKmRp+CVqNyDgvDd29Y8kbSEfakVODIW60
X-Gm-Gg: AYBFou3wHY5h2NV5xBtVyjudvp1M24pZ4rBg8MojmMCp/7ml4A7ii5pojRP8frzdwm1
	xeH3LokRxB2HtzUbAHGECmNbuKY9r6MrJ2qx4e79P6LxAykTZA7cyrKZbitm9m2yVDM6u+DlTjg
	Shu44aqdPsRDlQRxXdX2YWosECh3On0pyjQKyCml5A+CCObJtS8TFpKVIVn3YMio1E5yxiY0n7f
	Br+cA/Q/IvjPBqr7BJ6MCpcFvfZglHlulPAZcUUNFDMyw1tLeEDEy26KsUZBYisv+GWkqbX4LPq
	65lBr8KCTAuvOIG+fU6HXxMn7LRBjKHaADKQVTSEC/+2lT4qRjWYco+FELur81znXOeuDARz8A3
	B9ow2yAvbht10jnzmoibM77J8JDxZ0r6Hefikxkw6QQ==
X-Received: by 2002:a05:690c:87:b0:8a9:d5f2:f5a6 with SMTP id
 00721157ae682-8b07eda2faemr6276027b3.67.1791554415798; Fri, 09 Oct 2026
 07:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008140602.2623464-1-kiran.k@intel.com> <6ac7b63f.33ea1a9e.e076a.cedd@mx.google.com>
In-Reply-To: <6ac7b63f.33ea1a9e.e076a.cedd@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 9 Oct 2026 10:00:04 -0400
X-Gm-Features: AclHuK_jg8LrXRI-oO9qOZ0gkvn1HzUBze8w8Y0tdCbssTRwQCiXPPOlAS1XQeA
Message-ID: <CABBYNZLELJqB_+-Src7QBMCi8TQkgxepJfXh2d3Xct9cjTy42w@mail.gmail.com>
Subject: Re: [v4,1/2] Bluetooth: btintel: Zero version data before parsing TLVs
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Thu, Oct 8, 2026 at 11:36=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/series/1181659/
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.76 seconds
> VerifyFixes                   PASS      0.13 seconds
> VerifySignedoff               PASS      0.12 seconds
> GitLint                       FAIL      0.67 seconds
> SubjectPrefix                 PASS      0.24 seconds
> BuildKernel                   PASS      30.00 seconds
> CheckAllWarning               PASS      34.53 seconds
> CheckSparse                   PASS      37.04 seconds
> BuildKernel32                 PASS      29.78 seconds
> CheckKernelLLVM               PASS      35.80 seconds
> TestRunnerSetup               PASS      785.35 seconds
> IncrementalBuild              PASS      31.58 seconds
>
> Details
> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint
> Output:
> [v4,2/2] Bluetooth: btintel: load unlocker.sfi to allow unsigned firmware
>
> 35: B1 Line exceeds max length (82>80): "[  414.150089] Bluetooth: hci0: =
Firmware timestamp 2026.39 buildtype 3 build 86921"
>
>
> https://github.com/bluez/bluetooth-next/pull/888
>
> ---
> Regards,
> Linux Bluetooth

Sashiko is flagging the following problems:

https://sashiko.dev/#/patchset/20261008140602.2623464-1-kiran.k%40intel.com

--=20
Luiz Augusto von Dentz
