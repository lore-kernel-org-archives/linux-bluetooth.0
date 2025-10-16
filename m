Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2240FC0A
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 04:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760588854; cv=none; b=Gcz6OxAYjuKu7q9/efvcowuFu52wxR4BzGHE1FW5rDS4D4Gk4CcEWbketTMZNqGGU5Hl4zvdLJlgeomYIDMjAA4AZe2oUGk1ot7DoYcjLCF1z/gEJW4Bhu6xmVRJ+Lkcptc8MZKrOIlCpGVU3kg9wgm0soXKMRBPyb8L/r2ExEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760588854; c=relaxed/simple;
	bh=VcEA3JTW2PU4og8Kd6PWVlrUujNs8t72aHEQYU6xI5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMwv5KSyZ2Aq3M8/pJwzUd+1gvTrGF80UB4g/TKVp4qNaaBo5D4HLGpp2hXSgfPiEWUVKwXozm3Zc1ZPTsZVguVXBF62TPdmEXiuo9K+upynuX7Zzr2/CmbG0mQWDgMsHmPErWghSnmVzaPyzrjYYZ2qNYv/yYygVHLB/w5ZLTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUBH1Hmo; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUBH1Hmo"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-579d7104c37so410220e87.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 21:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760588851; x=1761193651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcEA3JTW2PU4og8Kd6PWVlrUujNs8t72aHEQYU6xI5g=;
        b=BUBH1Hmoq4i+wXetg4G4SYiAH940h8cZjZoWb/YRsaYyIAupb9h74QsNCB046PfV8H
         AaNotHwTuMgIfJ0d38wvYQr9OFMb6J3gErpu2wrfEyDEFVshkdHZ4tQaHZSC2sHfWJDH
         3CvRmKCpzaSWdeFQFibqd0bDioCJfZ6O62GY40qq4x/qgwqmTgpCJxG/XBUa8T6kRbja
         rPh0fJ3lHFe8y0GRn/OCKyLJzOQaGTwMutgLOKaScLlIbkqqmZU/sZOR0HqcvptAGWmA
         w/UgKJJRZooWnuClOaxRgz9f/Q1uyo/HxtKRvBqMofIK87Iyc8MCdoUWX8dDiuiwG0ya
         HWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760588851; x=1761193651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcEA3JTW2PU4og8Kd6PWVlrUujNs8t72aHEQYU6xI5g=;
        b=HqTGMWGc3FMZFzJRbLFXXJ3xbJpobJi3MPQtjeZDTBQ9qDNjOX3qMqA/GJwJxwFcna
         P9XT/tWgdK6Fy56FTAs6Q/RwEkaboAUT8GDWGwXvRnIXQtBFLw/TxEFYFXjSEdSsrMef
         kpkHIIubvBE7u9GrqdtK8gM6fq/jam3KNq8uGtJnfwzJ9DoUlHM5HIPJR/RZT5U2g/QK
         I3SwMn73sJAdfWC17+C8qqwmgFq7clxH1oRYYZ41lCIeuMPXyZzUknP+YaVfWoLnPTYV
         FQuGcz3UIpmU1jKyoZzSznTUesxc42R0HhtWHSpewkGP3AeVx2X2EyvFfp7pfuPAxiC3
         OIhg==
X-Forwarded-Encrypted: i=1; AJvYcCWbWgiOeJcxK4i+AKwfjpofLPdcOYALHG0/eFbhKJMi9GFxPezo04H0K87RdI/x9amFCGM8aYeSkD251v27nwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhCpGImfEkzN2tKZUXaykb7DHpMOiIYU2lOkg7iJqRp5X+ZYTO
	a//syURsCz/OBds+Fpv715f1ofN/ar8WtvZ4E9arxuFyEFdHcNBctOwGSI0tmbWy09eNzPkTg85
	88RBL27BXYxqcFagTCWKDYHw+SRt6uPY=
X-Gm-Gg: ASbGncvX73i/X3m2TOvThs5ccpM9bdjs5qq1wBPCWBAfn1ReD57snH6xHIDrXNE7w2+
	YwpnpuHu3hhST4MGpYu9gjR1A7bc3PUboaRfZcHntsQnt3cc+RIYD8r3puWF6EFTZaHxuaXMPk4
	k4b6q2c6ymg97h2cbz9MA/kWPYEPA0sYhR+Z3VLEsbrrekWjmxUb8/XvaVBx34JvXT+x6bzgCVg
	QMgZpuZyGSPxMiohlTOw8nrJIaH0lUA+QgHo81hX2GNApccCnuEkYrteqQELVmRQP+Nyh14GfAU
	g9u/L7M0AVNLZoOW
X-Google-Smtp-Source: AGHT+IEmiCm6V+zDZfq6m+fFo1xPnGkZ6X3idLM/Bo0azkjO0iqON4da5sAwaLTKcSW5F85LfXsXaCRjTanX7YydC7g=
X-Received: by 2002:a05:6512:33c6:b0:584:2ad8:7ce3 with SMTP id
 2adb3069b0e04-5906d8a2cbbmr8036900e87.22.1760588850633; Wed, 15 Oct 2025
 21:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5AQj25sJi6nHX+FO7D3eFPLi7_7LpBQfHW9qXQHH2nQsw@mail.gmail.com>
 <CABBYNZLfGVoTVcNTyVd2snYdebK0_S2Y3fdW0bNfNnYtz9JqaA@mail.gmail.com>
In-Reply-To: <CABBYNZLfGVoTVcNTyVd2snYdebK0_S2Y3fdW0bNfNnYtz9JqaA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 16 Oct 2025 01:27:19 -0300
X-Gm-Features: AS18NWAxPE6AFiY3pPtHlauJwbpbigdWW0PwWv2AZFvnseMDX_gDqt1uKEfXOAU
Message-ID: <CAOMZO5A6Dp14VRH=sEEdK65nja05gnK=gZc7qjaQZm3BSVLhhw@mail.gmail.com>
Subject: Re: Crash at hci_conn_cleanup() when bluetooth service is restarted
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Wed, Oct 15, 2025 at 4:50=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:

> Kernel version is a bit old, could you try to reproduce it with
> something more recent?

I appreciate your suggestion.

I tested it with kernel 6.12.53, and the problem did not happen.

Do you have any ideas on potential fixes that need to be backported to 6.1?

Thanks,

Fabio Estevam
