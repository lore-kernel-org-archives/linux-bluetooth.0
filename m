Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8657925BEE6
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506980; cv=none; b=BnhEZWwNfm/OQVwA5wMwgtCumzSrNKz1acD7BHPXhJ44NfANKOR8x+uG+KfOBT73dsHqJp/Y41qWetC4zk07yllf98QICqrekzFhCuYFXMLmvSr3jDcOuujEgyldCksccJCQvnQzZPeqareBZcFwvAyW3GEq9py488RNh78SFDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506980; c=relaxed/simple;
	bh=87qBlgZDrNnRzSsDQc028N0SAHMqaE9cRD+Gdibs1yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4IhHQSM/VitXphygTjHhz3BXPLXMeqO4IkPJEYveqfRgPxM+UDT6aS669Opbee8J+MSMyZzjXftkxnrOqVWd2XkO6JT4xOmhphngqhZKKO7vx+4KM63cvWpLRoGW0d8wjHzYVl/h3h7HWCKYH+h1DZh/VGf1NDFb/WD3WPb45o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2HXC3d/; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2HXC3d/"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32e14ce168eso39544991fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 08:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752506977; x=1753111777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZocMqtR3q0AKW5TR31qh3fk2/MGmN3g1Xot+eCX3Pc=;
        b=H2HXC3d/F1jQvqr5WNDZsI/KV0CwYjj/rf9oY4Ide9lo7bmnGL4Hucs5yB9NhsJqk4
         tysA5YwPbPjkQIueDw+rrjZz5HzY6SJ8Zmi2o5o8xlL0kHlNp7sHJedhC56mcNdx0P6l
         7+HWnBVbYG/YacWAd/cID9XrXAmuUWGtZDE5HWVgXJNSPqU2PyR08la2BxD6IAIcPbLe
         FCwV2r0A2Va5QeJggRTOC0oVqQy17VpaUpepyvrQRX1Nz8hRAKXYRWp8r47FjCVY/bRw
         xYsWRDK9A/W9GVVeiXoTK4uMusG+rOyBrQhrBoVkBaZcwHmJscUOBFAcf5BLG6WA7GrZ
         ENVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752506977; x=1753111777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZocMqtR3q0AKW5TR31qh3fk2/MGmN3g1Xot+eCX3Pc=;
        b=D6COQ3O8VSrNH7H0aDGIRByCPywnkhpW5kgiWzDZH+tD31y+O3v9SxWqbcNUmYkZUa
         y4dijFHauEk1nlU1Dy2gCnhVMnHr7/i2TbKeZlzVrgrGW1qfEFsBYSPvO3bdy4q+sABR
         L4PVeMmNd/e/ZtyQ9ZP82aW00Aacq3BvBagC40mWRUQrx68C5WNw5Fq8x4zVbE/3+Ciq
         n/vMo1nLUzB2RYjVqaRpGuo8o6fAWAs2h9t+UAfSUAyzTOxpwWw5UJyO/DAnXCHZuuhF
         zDUJsrDLWCkrghIC5ElGZKyYv9GwOV7+o1GPwRW4JAqcG7vBCLVulDsegLNWxQ/kpt7q
         /kMg==
X-Gm-Message-State: AOJu0YzJ83cjq2SNnUNfzo2ufdV4NhhwZbor3nOV6RrTofGvlBs22Tuz
	1ZwmyxbEIfQjreNkWs2dafL9O7w96kiSnv81ysXrnk5ZwTZe9gSWCVE3mXAuhQSFxUn+KgjOMV4
	GhzT9mD5KEnxP2c7vgKG50zemvpMfHP0=
X-Gm-Gg: ASbGncutCc4Z7VZq3CLGJp5Df2TqvWr7zeUfItitIigxRSAqj8TOJMU29NSKAPExEEq
	ihor2URHBUJLcIwbW3mtd3FZbIPJ8dyeSHzAS4hpmTQryZ8JQFCfVQ0knB+H+ud0Fao2EHLpmOe
	vItNDCdMMvJfpHVVCv8a9r/qRqYiItGvSI654RfbSGr/DdXf4pC8oG8GlvHHstA5XuZ431ME3FS
	9y2lA==
X-Google-Smtp-Source: AGHT+IH/h1PLhAS+5cppQ4kDGv06StKzMTuouTkSDvcB7GO4Lh+BCoqakTRtGDeanzuRN/hvS950PMhNKmJ/pspm0Dc=
X-Received: by 2002:a05:651c:2105:b0:32a:7750:a0e1 with SMTP id
 38308e7fff4ca-330533d8dbcmr42785241fa.26.1752506976082; Mon, 14 Jul 2025
 08:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <474a5321753aba17ec2819ba59adfd157ecfb343.1752501596.git.pav@iki.fi>
 <68751613.170a0220.216844.5d68@mx.google.com> <bedffb635f1d612adb07e1c314176f5f18484652.camel@iki.fi>
In-Reply-To: <bedffb635f1d612adb07e1c314176f5f18484652.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 14 Jul 2025 11:29:23 -0400
X-Gm-Features: Ac12FXy1zFRKdAy_IyjjR0GKgWcoXSwjd4n0_LYoo9eWx8b8onOi8FHAGTazIhs
Message-ID: <CABBYNZ+D7+uNpJarBH5cryB_ismPgy07WESk2mUM9hHhRhjMBQ@mail.gmail.com>
Subject: Re: Bluetooth: ISO: add socket option to report packet seqnum via CMSG
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Jul 14, 2025 at 11:25=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> ma, 2025-07-14 kello 07:37 -0700, bluez.test.bot@gmail.com kirjoitti:
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing lis=
t.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D9=
82088
> >
> > ---Test result---
> >
> > Test Summary:
> > CheckPatch                    PENDING   0.44 seconds
> > GitLint                       PENDING   0.34 seconds
> > SubjectPrefix                 PASS      0.07 seconds
> > BuildKernel                   PASS      24.06 seconds
> > CheckAllWarning               PASS      26.92 seconds
> > CheckSparse                   WARNING   29.90 seconds
> > BuildKernel32                 PASS      24.59 seconds
> > TestRunnerSetup               PASS      482.03 seconds
> > TestRunner_l2cap-tester       PASS      28.08 seconds
> > TestRunner_iso-tester         FAIL      41.16 seconds
> > TestRunner_bnep-tester        PASS      5.95 seconds
> > TestRunner_mgmt-tester        FAIL      134.62 seconds
> > TestRunner_rfcomm-tester      PASS      9.35 seconds
> > TestRunner_sco-tester         PASS      14.66 seconds
> > TestRunner_ioctl-tester       PASS      9.96 seconds
> > TestRunner_mesh-tester        FAIL      11.50 seconds
> > TestRunner_smp-tester         PASS      9.74 seconds
> > TestRunner_userchan-tester    PASS      6.10 seconds
> > IncrementalBuild              PENDING   0.59 seconds
> >
> > Details
> > ##############################
> > Test: CheckPatch - PENDING
> > Desc: Run checkpatch.pl script
> > Output:
> >
> > ##############################
> > Test: GitLint - PENDING
> > Desc: Run gitlint
> > Output:
> >
> > ##############################
> > Test: CheckSparse - WARNING
> > Desc: Run sparse tool with linux kernel
> > Output:
> > net/bluetooth/af_bluetooth.c:248:25: warning: context imbalance in 'bt_=
accept_enqueue' - different lock contexts for basic blocknet/bluetooth/iso.=
c:2322:28: warning: incorrect type in assignment (different base types)net/=
bluetooth/iso.c:2322:28:    expected unsigned short [usertype] snnet/blueto=
oth/iso.c:2322:28:    got restricted __le16 [usertype] snnet/bluetooth/iso.=
c:2333:28: warning: incorrect type in assignment (different base types)net/=
bluetooth/iso.c:2333:28:    expected unsigned short [usertype] snnet/blueto=
oth/iso.c:2333:28:    got restricted __le16 [usertype] sn
> > ##############################
> > Test: TestRunner_iso-tester - FAIL
> > Desc: Run iso-tester with test-runner
> > Output:
> > Total: 130, Passed: 127 (97.7%), Failed: 2, Not Run: 1
> >
> > Failed Test Cases
> > ISO Send - TX Timestamping                           Failed       0.233=
 seconds
> > ISO Send - TX CMSG Timestamping                      Failed       0.236=
 seconds
>
> These are false positives, they fail since the test is trying to use
> BT_POLL_ERRQUEUE socket option which does not exist in kernel, but has
> same value as the new BT_PTK_SEQNUM.
>
> The following patch removes the references to the non-existing kernel
> feature:
>
> https://lore.kernel.org/linux-bluetooth/2ffec6539fe38318c713b48985aaddda9=
671f258.1752501450.git.pav@iki.fi/

Did we end up reusing the same id? In that case I would just skip it
and use the next to avoid such confusion.

> > ##############################
> > Test: TestRunner_mgmt-tester - FAIL
> > Desc: Run mgmt-tester with test-runner
> > Output:
> > Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4
> >
> > Failed Test Cases
> > LL Privacy - Add Device 3 (AL is full)               Failed       0.228=
 seconds
> > ##############################
> > Test: TestRunner_mesh-tester - FAIL
> > Desc: Run mesh-tester with test-runner
> > Output:
> > Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0
> >
> > Failed Test Cases
> > Mesh - Send cancel - 1                               Timed out    2.061=
 seconds
> > Mesh - Send cancel - 2                               Timed out    1.997=
 seconds
> > ##############################
> > Test: IncrementalBuild - PENDING
> > Desc: Incremental build with the patches in the series
> > Output:
> >
> >
> >
> > ---
> > Regards,
> > Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
