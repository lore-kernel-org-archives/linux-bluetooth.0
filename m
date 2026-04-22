Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D841A3164
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776870699; cv=pass; b=CSCwpvOjwOTamROsqRgFE01kh102gqtzegSCr6LWUCAoV398B3ItJUufBnJFDk3CK5x8cCu25GH5mi1qfS9YuuR1f+RetcdBL4mZ5uU7OjvgMtqR4A48ySyWKJZeas09jLyAZJ+O7MbUPtAVFXjgMf+erQ6dSdy6qKyrqfsHNwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776870699; c=relaxed/simple;
	bh=R8L5Znl0VHmzHcPug4YLYwBu54WrIn8AZrO2I1IuSdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGE+gvwkooX6tHNVn8NHT9FCDdgGzbvrGczJSzg9FLz5X4l7EtwA92CWSc0TSUk0YD9OKtUhexKYjoOOpLjEQ31m/CA7/0IKrhwJHuQi+ghw1v/0Y3p5+qlMqdKoGTSdmbpcpfK6toRgxY7YcYC4BTWPD+215EvkEe9cY6Id5Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpMA10NY; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpMA10NY"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-651bf4a4140so5553386d50.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 08:11:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776870697; cv=none;
        d=google.com; s=arc-20240605;
        b=Umurjc8hW6KkIWRbX7ytnRgvFbspw+PR4hQQ4JMXVNHxECr2W7FMFp2YJxOgUbh9bu
         ePcbpjMUSXWIyzvrlp7dsa58YthJKtL1/17O5eoxT6zB+1y8gIYEuE5UOpUSmINxv9N2
         2HCAhhrrUntQPAK/UF9pS95ho6IqiM7Lp0XTaG9vfjdSh2C4GQMPG5J+Ks/xv5WUY8KI
         H5Izuc7K+zI60l9TApnDOGCB5O8BuUTrdyx9ddXaxcEFyd1PZ9MJR9x88r0tnopAbHE4
         sXost5HLbDTjyJV9+JhENt6ODKzbNZwriX9lUFR5Ffw86HC78pec8Bt8c8br3PFwDt3Y
         w74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v5roQw9bBfz3acyQeLL6o0KXARqFxvtys+V7Rz4AhwU=;
        fh=GPgP2laXmqKj+Fv6BeoPvDdPrha2sR8EWU0/S09TOq4=;
        b=XGGwHAEVhC46Qmam3O7lxXvsndjzRaBF8fzJFf/BW5ny5t7QBlm7zNLdXS+uRSDTAT
         Ko+u2B173dpuvWfte9tiiugI6ehr9625y1VDxJeOfeVCxmJ1ewO+FbymhR47mfUn9/yQ
         qu3lO6X6fZGezoKIPRoTKZZH9m77WPJ+e5v2n1QaHV79ox13/bVLDoQinXu7j7e2hFlf
         K4N3PmigVFNu2nc+6QkvjuYQ7kKo6QH5u2Z8AGW32uJZdn0zGwvjGr+7yBK7v/FgVVor
         mGmuuLgRGE/RT5/7v09BmuwWJejdrTqzHsBuWjhkklAcfDUt65btCDiIeRh+hYdOMu2u
         Ccjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776870697; x=1777475497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5roQw9bBfz3acyQeLL6o0KXARqFxvtys+V7Rz4AhwU=;
        b=SpMA10NYZhOeNatNB+gPfsPNOJdnhEWyrNjwupvHEHUJxePLZcx/d6/y0rqpyzPjJ+
         JvWFQFg+CVGXgl1j8W3pMThas4trrionC6e45YsHDK+R+CzCNCb04vvDk60PBdba+Vyb
         necUiZLevtkynTRr8fMbyes13Xj3cHlKlOtYBMjVulQ0n8oWApiCM616a4+YAO0TiWvU
         XC1mJCXOztqCSlJ6DBirsgxWzLJ/CMhS+5qFquGoqeAFuF6KXpzKHYDvwOFr0l75xdLD
         QXH553dOwgf0tX3B+EBm0BjAhp7WPynBfzxcUeGfO8AJ+x1L5luVs3tKOq/hP/XnooyJ
         CM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776870697; x=1777475497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v5roQw9bBfz3acyQeLL6o0KXARqFxvtys+V7Rz4AhwU=;
        b=mGm/SckSV6RXzJYlGXMAIfPsIvEcIXkL3t/90Y0VDT47LSoG9pXerKtL+/yxEABHMA
         e3+vIa5y3Rxx5UZFawhB3alU23p3lLrFIbuxXkLiemEGFBpeJzj9QSub/rpfL8/oZR84
         9ZtiZw3wtg6zB1klAUWv8xwT1/e/Mv2xeRaMYlORovZde7SJW1D4FvY6eqdBWBucw6nw
         3dVO0ui5L9juIOverz3/WrC4qNErubQHO91kjppSjwX1uYg6Wsc1gpxVeXQQck1KHNHc
         t4FeCiwpRKhpudAzri7zCL4K1mnlRwr9yHGXUUwNMe+YvN0NgPf9oqh9xjWPdKHz1eZF
         Lx4Q==
X-Gm-Message-State: AOJu0YyB+085oivthjEI6KSF0Y9fIClQV69FR0HeZaePdj6mtnBEn7+R
	9X7o5KnP6zYy4dtgZxU6TIcYNWaUKD3tXceeS3SkyEfTD7uO8H9dW3BZQumTiTrO1cr8B3PdybU
	tUfoS4qdgqJUAt3UDII3Q/u2RZRXssXCdR+7B
X-Gm-Gg: AeBDieu2BMSVupdrsboOJPFugh3jWhu4aHO8R6NdNPmzBZuK2hl9wWE/J1wCdoLo5Ya
	eABRq/QGtqOiDBFFMRNerm6AjG8J52oc0DNp/APsU73NsSjXkue+k5MVak1+UicvimSr+XrSKdv
	KwsSjhQYbHv/b8/XsyhysRAwzOyQCyI1T0KyMyHBs04FyVKlMHxdrfHfiIp3qvPqVLWYbPeeWxB
	AKjDBDXJd9GTDGU5WIJhTzN61itDTMq6EvVeaFV4l5pCJA+tLK/sSliVw9lCgTnRmYha2MMORmQ
	KBARyABYBWgzgzcWZZq7Fit7jHb/SKmP1xibck0RMKX42kvDkegyMcPRdIxCg7o1UOXR9GUwj5y
	zNju/
X-Received: by 2002:a05:690e:419a:b0:64e:e82e:8413 with SMTP id
 956f58d0204a3-653107c8bd9mr17873054d50.1.1776870697308; Wed, 22 Apr 2026
 08:11:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421230917.7057-2-ebiggers@kernel.org> <69e81184.050a0220.343b8b.d048@mx.google.com>
In-Reply-To: <69e81184.050a0220.343b8b.d048@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 Apr 2026 11:11:25 -0400
X-Gm-Features: AQROBzDcZNDdEMYq4t3LrUR8K7sgSq3c90RB2qcSJxoDeJKFIUp2L7B-JlsEpUk
Message-ID: <CABBYNZJHdfByt_Tg7WV2S-fZ9xxJYVH4MyBxT3MGTNkbX5f4rA@mail.gmail.com>
Subject: Re: Bluetooth: Use AES-CMAC library API
To: linux-bluetooth@vger.kernel.org
Cc: ebiggers@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, Apr 21, 2026 at 8:10=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D108=
4071
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.56 seconds
> GitLint                       PASS      0.49 seconds
> SubjectPrefix                 PASS      0.17 seconds
> BuildKernel                   FAIL      20.93 seconds
> CheckAllWarning               FAIL      23.01 seconds
> CheckSparse                   FAIL      22.09 seconds
> BuildKernel32                 FAIL      20.31 seconds
> TestRunnerSetup               FAIL      488.99 seconds
> TestRunner_l2cap-tester       FAIL      0.11 seconds
> TestRunner_iso-tester         FAIL      0.11 seconds
> TestRunner_bnep-tester        FAIL      0.53 seconds
> TestRunner_mgmt-tester        FAIL      0.11 seconds
> TestRunner_rfcomm-tester      FAIL      0.11 seconds
> TestRunner_sco-tester         FAIL      0.11 seconds
> TestRunner_ioctl-tester       FAIL      0.11 seconds
> TestRunner_mesh-tester        FAIL      0.11 seconds
> TestRunner_smp-tester         FAIL      0.10 seconds
> TestRunner_userchan-tester    FAIL      0.10 seconds
> TestRunner_6lowpan-tester     FAIL      0.11 seconds
> IncrementalBuild              FAIL      26.35 seconds
>
> Details
> ##############################
> Test: BuildKernel - FAIL
> Desc: Build Kernel for Bluetooth
> Output:
>
> net/bluetooth/smp.c:25:10: fatal error: crypto/aes-cbc-macs.h: No such fi=
le or directory
>    25 | #include <crypto/aes-cbc-macs.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~

I guess this is expected since rc1 wasn't tagged yet, right? In that
case we will probably need to rebase once rc1 is tagged to integrate
these changes.
