Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5852F5474
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122858; cv=pass; b=HkoK5O/wDczuT7vch6wuwvaaQ4b3pCvfM2IfwyK69McWu2b6G1ii7wEAGLfD4HFVx2n94kZ0zmaAQP1tmtsz2oc/yUuziYwqLb+nqas9IZWxeczojIXpBBn5EzRCkrZ7I7DJGuZaWWQvMKEea6EaiNRSCcZVUtrPC5802Keoaos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122858; c=relaxed/simple;
	bh=b9DlH5x17foeJ9lCPJptettE+qVS7hscGILObkv3e/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXONIuA2k1op13jxw1SjvZmMNu0CWB4ACL4zZ8XRos8gsxPRf5HmyCEnMuSB/bfQ/FfXalTL+1fBaTXrPNztNz86/uMo9mFISzPPqVbkLQITBxFiMTlHR+AATE6n7CE5lxU9xQbT1vK+ZwvcU6cboyRjbAlGHsUUlF7gqG76Fdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qoanwTXc; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoanwTXc"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81ed2a06b9eso5192557b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 06:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784122853; cv=none;
        d=google.com; s=arc-20260327;
        b=BqTC0GYIJGbCudBMNkHd4vFaNqlGT44m+9lgM9jmNTlBV5L0Z+kT/3uePb8u5dBa2p
         xWolbProM2lKdC85QLrm/4BWmf8K26drBUMLSasdLdabdACf79d1Xzte3AhFYgFSWvGm
         b98UD4hIau37j9ACKj8LZ1PJ7Khm+VsnCCWP6c1nkllrHXAqiIEOg9FpaLU+oppSrt61
         FirLxCTiXAk7ckgULKyu1XarcekvNoV1vijwtwg3WKxd4HaqQOtwrepzMBTEZn+i5JSS
         jjRXJwLe3WcD+5tC2GAp3D+RBNZWP4YBVoQziU1/ly0qvDPvjX8M6+Af7IbcaA+yO1rl
         H8fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m2eBO4g8D6SKg/jSVKZOmlJbCfbKTobKzRN5XoaymlI=;
        fh=ImHaVp9LKIGjD0tRyxgUyPXd5WNSYdKgZ1TGxuDzvzM=;
        b=WkR5Uzp4sDazfaarQAtJJRqyXPmCaLkfiZyf5xGB/ew2fYay6UShU4Xiz4F6zsFPCT
         UnQ50fsbz7Uugtv7jraasod02kwMlHJmiBvsIbY1t/TSVUoubMbB2mXL57R93qVFX0nr
         LkkmhmRlZjk2bXz499MEf0qkKohMCRWuCzqNzh3ltvGqkrH06sw8JdrAYGUGc1gimIVS
         NXQVG6cZx5brRPvkiZfws2543ImaART5amROjzWvXB4qTcOAPqAJlbBxIhRnd1fPjaWX
         xdXKSEp/YIbGsAWlnnybBmhefO1Qyo2VSlprRk2Iaib/URrq7pfRrsxoejm/QWg/NYI6
         IcPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784122853; x=1784727653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m2eBO4g8D6SKg/jSVKZOmlJbCfbKTobKzRN5XoaymlI=;
        b=qoanwTXcVoNbx1FNXPb7HdrbzjRnLN/rZTlGrq1mfsYzBDy48x1pNeCBrUKq1SnAox
         jsZdAb+FDdPyCu3GOFAadqlgVFZj4mOlRIqsoEKvQrgacrMkNL9gumshvbCrO2AAHZCP
         GY2Y3dHGCWMItNM79dZIEFv0mMxPklst6nubA2bXyDBekP3YvkdZdDrpg7NvkFJCOBiJ
         +BJhSNSDVnoyLXO/8iytki7o8HXdxnqILIW9lqRbbq6h3jKyABgKaWvfB5/2D34bzPqw
         MLyVtnfIEiJhXxZHyE+E3k9KbY3c3hSKtbdVjNOfMbZiSjgwGlJkBVNthQgCqA2w9t1v
         9p1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784122853; x=1784727653;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2eBO4g8D6SKg/jSVKZOmlJbCfbKTobKzRN5XoaymlI=;
        b=r4pLKOCik28Dyd9/fPZpnXJc7lffMu/bDhC1FHVadQuyjukctDXN89N4AvVIvUngDV
         W3NUyPtiFln1gKNi/dIWrIVV7qS6w/fMfW1ho8ukxmXre12dqcR0tj6hmBawODt9mN63
         gIj54I/Fp8Z9wLEQ+PFcUVXY+eru7e4BgIygCfpSjd2ncAUyWt+5HhXlkIGt7Q+uxRY1
         kurH1NKwp99poy3xXyd+q2qsw6UuAcnmZdGSNP4BBDMTnfLoNoMNHiUDPmlQ0d1JfXAe
         ASctr3VPy8RFpv1UH6jdsJKu5Z+L5BVVe30gu1vKLIA9Bs6PPCj3dCTMaL79ouor/U8d
         oC+w==
X-Gm-Message-State: AOJu0YzsqsVQp4KwFIW/8LI+4Qdc2Ybcgcs7A8ZeZD/1csg3IXivREdz
	CAGonxlWG3a7yG+I+TTCtdRPExntv9BNQQ+f4vIUxqAmecNkV3DUtj7upfoes2/yvF2mhAoWx2M
	GaBSSAwcSxuJxuECjJAYYyYiZg80K5UXdv30lclw=
X-Gm-Gg: AfdE7cky+cINQW5c5NLuWjEfUHzuEBZmJ5saAgAyneAhxVYxw+WsDKmk3r+p2teQwlN
	i0meLg+DAP1jhJ/yEZEwWPsxEDkLaZAqaZyZbXXavCGyj1u+6BQ0CHJlWG4Mf1unLnePEqAdtc1
	RvbcHj0yeJ1AWFuPTjd0ESURY04ZOI5w7OrAs7CriDRbji8ONCghqVuNKg8xvBfgh/A+jT2PnQG
	sMu1W+I1uXkSQTEiL7+BsFYCWwUE6DyFoLC4UXl8QC/o6FKWbRTzUbFMAM3h2DcQC8/ZP26UzFy
	UTDVa8RpPO2HufueCdUOOGzki376RmdHdSYHLlA4yBrIJPWb07Q8Hbsf
X-Received: by 2002:a05:690c:c6c2:b0:81e:abe2:e01b with SMTP id
 00721157ae682-81eabe2e207mr66987437b3.26.1784122853322; Wed, 15 Jul 2026
 06:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715090206.212130-1-frederic.danis@collabora.com> <20260715090206.212130-4-frederic.danis@collabora.com>
In-Reply-To: <20260715090206.212130-4-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 15 Jul 2026 09:40:42 -0400
X-Gm-Features: AUfX_mw3WC0SE7paJbtnKVyE-sjqN_NAHR8sspA5_F6oSZdGZ1B4v3belf22MaM
Message-ID: <CABBYNZ+vttWK-2f8gJSATZ9pXBeg2Ncy-OreH+63ppiuQ0ricg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 3/8] doc: document admin.allow optional
 controller argument
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Wed, Jul 15, 2026 at 5:03=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> Update bluetoothctl usage to 'admin.allow [ctrl] [clear/uuid1 uuid2 ...]'
> and add explicit controller examples.
>
> Refresh AdminPolicySet examples to include the controller-qualified
> admin.allow form.
>
> Assisted-by: GPT:GPT-5.3-Codex
> ---
>  doc/bluetoothctl-admin.rst       | 13 +++++++++++--
>  doc/org.bluez.AdminPolicySet.rst |  1 +
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/doc/bluetoothctl-admin.rst b/doc/bluetoothctl-admin.rst
> index d4446ce95..ce15b8728 100644
> --- a/doc/bluetoothctl-admin.rst
> +++ b/doc/bluetoothctl-admin.rst
> @@ -9,7 +9,7 @@ Admin Policy Submenu
>  :Version: BlueZ
>  :Copyright: Free use of this software is granted under the terms of the =
GNU
>              Lesser General Public Licenses (LGPL).
> -:Date: November 2022
> +:Date: June 2026
>  :Manual section: 1
>  :Manual group: Linux System Administration
>
> @@ -30,15 +30,22 @@ allow
>
>  Allow service UUIDs and block rest of them.
>
> -:Usage: **> allow [clear/uuid1 uuid2 ...]**
> +:Usage: **> allow [ctrl] [clear/uuid1 uuid2 ...]**
> +:[ctrl]: Bluetooth controller address (optional; defaults to the selecte=
d controller)
>  :Uses: **org.bluez.AdminPolicySet(5)** property **ServiceAllowList**
>  :[clear/uuid1 uuid2 ...]: List of service UUIDs to allow, or "clear" to =
remove all restrictions
>  :Example Get current allowed UUIDs list:
>         | **> allow**
> +:Example Get current allowed UUIDs list for a specific controller:
> +       | **> allow 00:11:22:33:44:55**
>  :Example Allow Serial Port Profile only:
>         | **> allow 0x1101**
> +:Example Allow Serial Port Profile on a specific controller:
> +       | **> allow 00:11:22:33:44:55 0x1101**
>  :Example Allow Serial Port Profile and LAN Access Profile:
>         | **> allow 0x1101 0x1102**
> +:Example Allow Serial Port Profile and LAN Access Profile on a specific =
controller:
> +       | **> allow 00:11:22:33:44:55 0x1101 0x1102**
>  :Example Allow Serial Port Profile, LAN Access Profile, and Dialup Netwo=
rking Profile:
>         | **> allow 0x1101 0x1102 0x1103**
>  :Example Allow Advanced Audio Distribution Profile only:
> @@ -51,6 +58,8 @@ Allow service UUIDs and block rest of them.
>         | **> allow 00001101-0000-1000-8000-00805f9b34fb 00001102-0000-10=
00-8000-00805f9b34fb**
>  :Example Remove all UUID restrictions:
>         | **> allow clear**
> +:Example Remove all UUID restrictions on a specific controller:
> +       | **> allow 00:11:22:33:44:55 clear**
>  :Example Allow SPP, LAP, and DUN using mixed UUID formats:
>         | **> allow 0x1101 00001102-0000-1000-8000-00805f9b34fb 0x1103**
>
> diff --git a/doc/org.bluez.AdminPolicySet.rst b/doc/org.bluez.AdminPolicy=
Set.rst
> index db132b7de..29fe3bdf7 100644
> --- a/doc/org.bluez.AdminPolicySet.rst
> +++ b/doc/org.bluez.AdminPolicySet.rst
> @@ -55,3 +55,4 @@ Possible errors:
>  Examples:
>
>  :bluetoothctl: > admin.allow [clear/uuid1 uuid2 ...]
> +:bluetoothctl: > admin.allow [ctrl] [clear/uuid1 uuid2 ...]

Normally, the command should use the controller main menu aka.
bluetoothctl> select so we probably need a environment variable to
pass adapter currently in use.

> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
