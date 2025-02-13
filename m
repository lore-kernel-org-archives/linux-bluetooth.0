Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0011E28A2BF
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485895; cv=none; b=JEhkIRNeG7Bz3I1vebQn43a5KlENFns7p90znjZ/HxYmBWdBKPAjj8sJCbwAQbIxE3PKomn1SWK9iXe4BFSZQBgOyU5ti/9Cxi9Xbpg27Bjc7Drl1EVfT7075chlNi+gqtlXFmJPrrr+h0SdYMSW++5lUlSwNwC02YnVGLJOql8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485895; c=relaxed/simple;
	bh=Q8BWjdgy3jesawzy5u5z0zAY0Fhl6BCaBgpYT/6aZUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+iTW+4irTbp6+Wv4ZhH6oOVeFfPy7xKtFnYek5PNoc5FteW6SxxspJs/cJDi7o7aoqY1rLV+2nY/pWlKYCH2+/Aa9cYugA1Qh0aol7hASUJRZeCmrMnqKgF9hZW6K9C0C8Y2T37TwSRAQ0sShrjqGvqh9cdRdlQGgahF6AHz/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mApq9Y2o; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mApq9Y2o"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-308f71d5efcso14511491fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 14:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739485891; x=1740090691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYL1AEJJa6/uANRPAg9qqNoysv0Ev1giPf3b5E0unlo=;
        b=mApq9Y2o9vZVYbQQ4YAL4yeI9yGt986SGcK0DoWwZ9JQCylJA8VzNy/hlWXtJPWQ53
         q/4/P7aCdlKz3ri/XA9G6rPeHcQ2RgrfcGBzu0CceCufF88+987KZItY8U4DI0T9cCx7
         aRZk2lS9SKmWVq3C1SD+WcS8OjAKjcjZZFgjqSdykZTAlpkpsfqvac+amGOgLZRGFlK/
         UiZRlxSq9pZvN9WneXzhJ60Uo9PybhR5vFNYuKLLeIvm1gjwHznnSI6gmqJhTRWiCm0o
         rnd1WKm78yZBphWf58t3z7kABW7m5LgG0yH+h6q5w/m+ykw0XZu5zIyoBCfFIXUAtZy1
         Ro4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739485891; x=1740090691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYL1AEJJa6/uANRPAg9qqNoysv0Ev1giPf3b5E0unlo=;
        b=GaDX13hiFRdzrVE0FHoGQVhBKAuu7y3Ra9cI4QyL+dSBqemIJdkmv2xx8I4NQae0Ma
         CVPegmJpCHMI6CD4N+JB5A0qtZhM7vO+c/PLh5gqJ5UN9r6TxHTnCh+4JQFdf18CdKRu
         fHR85TmoiR4i0ArTWWDkfVO8NCwy1kY0QB7Yc1jHGslTLMn1An5o2AgIiPrlWOINDYNC
         KyBpXYfMb0uQ8fruJHqhv2hMuKhXGhDm25XYB1Uh8gT6SmkMmr4UY5xA5LM7/09/4hgr
         wB9V85QgnmyABTqaXl5g1pjDFSzxNpuFuLXvNnNoagdc0Aq/OMOB/1CgcpoT/BMHnlvG
         dumw==
X-Gm-Message-State: AOJu0Yxe92itygSgRkeGLsXVCmjy9YES9s8hLGc0Quslly0+BXbXLPmA
	cMur2iXUbr+LxUO1vTwKa2M0uBiqqz9Ew07J+xlu91RhJHdir+jqntU6COkh774Y4gjglhLBgMy
	hSKmoFnRmG7v3HI2r+w3JabAmqn4W7bZV
X-Gm-Gg: ASbGncuLKegMshtkbtjZfe25jIzUylmFi+o3TiyTZr/edS25OVeWB/ahWsZ4vrd8MYw
	M0D8kd8xd9YMDHxF2qINtC+/kTAvdDowa27nDeMH16JDnW8zgZvFmb4Vp6YR51VmF1OhZ
X-Google-Smtp-Source: AGHT+IF6ByRxA1lAXDFsVal9m0f3HcNgHy7hKxAxJhYY+AoGXEjUjEWyRasZ06/3CLpJiFFpIh18b05m2FYE06UyNfM=
X-Received: by 2002:a05:651c:b20:b0:302:175e:5abb with SMTP id
 38308e7fff4ca-3090379d697mr31363461fa.3.1739485890304; Thu, 13 Feb 2025
 14:31:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123134908.805346-1-arnd@kernel.org> <67ae71e1.170a0220.69f3b.9ade@mx.google.com>
In-Reply-To: <67ae71e1.170a0220.69f3b.9ade@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 13 Feb 2025 17:31:18 -0500
X-Gm-Features: AWEUYZnqPzXZIu-lsm8ozqNO3tec4LCe0sV8uqAsRCeoSYW65H0xr02o8J5IE4M
Message-ID: <CABBYNZJz0yFAyphL-wRPWJHhqUBX_s5r1U91bZo+U7V46c7yMw@mail.gmail.com>
Subject: Re: hid: intel-thc: fix CONFIG_HID dependency
To: linux-bluetooth@vger.kernel.org, 
	Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: arnd@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arkadiusz,

On Thu, Feb 13, 2025 at 5:27=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D927=
825
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PENDING   0.38 seconds
> GitLint                       PENDING   0.22 seconds
> SubjectPrefix                 FAIL      0.36 seconds
> BuildKernel                   PASS      23.92 seconds
> CheckAllWarning               PASS      26.68 seconds
> CheckSparse                   PASS      30.26 seconds
> BuildKernel32                 PASS      23.83 seconds
> TestRunnerSetup               PASS      428.49 seconds
> TestRunner_l2cap-tester       FAIL      0.09 seconds
> TestRunner_iso-tester         FAIL      0.09 seconds
> TestRunner_bnep-tester        FAIL      0.14 seconds
> TestRunner_mgmt-tester        FAIL      0.18 seconds
> TestRunner_rfcomm-tester      FAIL      0.16 seconds
> TestRunner_sco-tester         FAIL      0.09 seconds
> TestRunner_ioctl-tester       FAIL      0.08 seconds
> TestRunner_mesh-tester        FAIL      0.09 seconds
> TestRunner_smp-tester         FAIL      0.09 seconds
> TestRunner_userchan-tester    FAIL      0.08 seconds
> IncrementalBuild              PENDING   0.48 seconds
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
> Test: SubjectPrefix - FAIL
> Desc: Check subject contains "Bluetooth" prefix
> Output:
> "Bluetooth: " prefix is not specified in the subject
> ##############################
> Test: TestRunner_l2cap-tester - FAIL
> Desc: Run l2cap-tester with test-runner
> Output:
>
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> qemu-system-x86_64: CPU model 'host' requires KVM
> ##############################
> Test: TestRunner_iso-tester - FAIL
> Desc: Run iso-tester with test-runner
> Output:
>
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> qemu-system-x86_64: CPU model 'host' requires KVM
> ##############################
> Test: TestRunner_bnep-tester - FAIL
> Desc: Run bnep-tester with test-runner
> Output:
>
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> qemu-system-x86_64: CPU model 'host' requires KVM
> ##############################
> Test: TestRunner_mgmt-tester - FAIL
> Desc: Run mgmt-tester with test-runner
> Output:
>
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> qemu-system-x86_64: CPU model 'host' requires KVM
> ##############################
> Test: TestRunner_rfcomm-tester - FAIL
> Desc: Run rfcomm-tester with test-runner
> Output:
>
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> qemu-system-x86_64: CPU model 'host' requires KVM
> ##############################
> Test: TestRunner_sco-tester - FAIL
> Desc: Run sco-tester with test-runner
> Output:
>
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> qemu-system-x86_64: CPU model 'host' requires KVM
> ##############################
> Test: TestRunner_ioctl-tester - FAIL
> Desc: Run ioctl-tester with test-runner
> Output:
>
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> qemu-system-x86_64: CPU model 'host' requires KVM
> ##############################
> Test: TestRunner_mesh-tester - FAIL
> Desc: Run mesh-tester with test-runner
> Output:
>
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> qemu-system-x86_64: CPU model 'host' requires KVM
> ##############################
> Test: TestRunner_smp-tester - FAIL
> Desc: Run smp-tester with test-runner
> Output:
>
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> qemu-system-x86_64: CPU model 'host' requires KVM
> ##############################
> Test: TestRunner_userchan-tester - FAIL
> Desc: Run userchan-tester with test-runner
> Output:
>
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> qemu-system-x86_64: CPU model 'host' requires KVM

I guess these errors are related to the last change aren't they? Most
likely github hosts don't have KVM enabled or something like that.

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
