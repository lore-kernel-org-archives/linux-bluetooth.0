Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D81B303A35
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770837490; cv=pass; b=tKttB51QUaWGH6Fcv1a48YxI7MjDfxOBTbl1XRCJwM0a2TH5OIi4ZEanNwuMPg9mbbq+0+1J0C+JxlXd2ZHUhCetL6lfMBFS1hfUgnBPVKFw3w42a9PTt10pha3V22mpSCBs6ubKeeDHLUp9LhzOBGo3RYeFB6X5JSxGI0X46qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770837490; c=relaxed/simple;
	bh=mSUvsOLBPzc6vhzvvkJOSwtWNsln4TW6SyRgPtEfQys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUtGgsydIBFSk8rvgvBOMXMtQ55rzTJNhFNTcZehL8kFTTgyEM9T4Y1Ob4QhCjxM3F2oSf8ZJMTmfTF7N5mUwl4+WgxdW64SM5l3egWqZS10fN1hgFwow4rKR5hbrgwJUj0mMY/e7ag4eCQ+1yqYpNqYVFe4bIFLjoyinq9520c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+kXBFti; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+kXBFti"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7962119ff2bso58882837b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 11:18:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770837488; cv=none;
        d=google.com; s=arc-20240605;
        b=OTHKYerUVYGn2EGQHdTun25irNhV6aG4SX0QXHndotFvsSRQb0UrfRqU04WklZuUoJ
         rGRcpGj83zyuR6elc7X/mBTuayxt0Mc3TwFwrEDZ7L6MnyyMJ0XWcJtgCSDUu/XUQT/a
         iPVIbXnnZnE8or9gxgaTSwp1NckoGcB90bZLj7ZFtH4KOkcGr0OTfE9iHt9ECsJ3yXyS
         VKYqdeSmv94pia1w8qDIIFuZ/whd02c3wBCcaXuWrYYfUUac33ZO7ntaYXqk/Zca1sRH
         DZUgmmaWZYA2dXDr8Vouc8hthHvAT86l8Yv79nT6WYlVdN9uYbLIsAd9KVVFcxWG39kX
         R1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eJ8Hinkldj37UmV8RWHdFic0EX/FtpoR0f3LWqXQqrk=;
        fh=U2B+5sy4pFXGYD3XDig+JA2B++u1ehmY+dMTp/+RCj8=;
        b=PvX/M8/w9wSwODTCQgzS7CaH3UabO57MmS2XCqNRrDuEHbSvKWOJhBZdPUPMOIaN1Z
         fuf/3OR9a/5lw3/t+Zwgd5cnFEJSkaLjjzJKPFaRkPPMiOYvpNwmnQ5/jpOtCJAxK34q
         Uv6/xRfPHVomgbKtpqu81RTsWM8rOFfXhT9eaR80a3ax7mM5o0OYnsL99eEJcnsFIe91
         1FJr2w2SnB3gkO0FjBPgVRq1noUIBwVJ7CP2dq1B5rPBDHZE0FyOji2qF85exuogk0ix
         UlNw5zInS5ut95383FqmEPzGrefl2O0Y7bt8e1RF4UxQB7GAXI1XiYTH+dXaEiHMI+Rj
         JyFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770837488; x=1771442288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJ8Hinkldj37UmV8RWHdFic0EX/FtpoR0f3LWqXQqrk=;
        b=L+kXBFtiWWVjO6eTjKKvs9xHpW0y/cj//xdSkA2qcjWH/DHOfNSbtl26jsnn0FypCg
         ZHNcEfnfcUphXEeZNBE6OFeyT4un13DMGfHkvJHSWpCMeZX5x0gM6Wcm5H03zHuFJRl1
         kxJ4iIM807m7mApchjSzYENA1VnfWHVyqqNu7CnZMdK/c52rf7fztnVvl8MGxLJJPcyc
         4Eb0hzYOeI8+y7lQ7pOw/scqB3DBjI6wUdTOWYukt5CWG+lGBKo6DNzunEwBSuDnCRQ+
         dsL/vfQ0AghgdBhGyDa3hhKbhk3FB8O+f0MJtyvw95Fv3g1FKwwQCp6Jhbr/aq7cgyXe
         JYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770837488; x=1771442288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eJ8Hinkldj37UmV8RWHdFic0EX/FtpoR0f3LWqXQqrk=;
        b=Mt160hnCdL1eaRrJSx4D2TdgRB77to3YXc1TTECszWuTJdzzmGACCdcCzLv2JRZXbF
         bN52vxL3FS8oYvoGC2GhsHFUxuqjDwM6aHlizJ4vB44YjCKNr6Xi0JXqhndC/QLHx6dA
         A4sVX35mMRlgplO8Q2UdGwsKvgSSJlhG49wUmCjaQrv/tdPGHrdujjCf1DvcPcYHLYGq
         R23HoZR8a1BCDYAxoEA/8FzQF3nLqWxIPtIrqSSwnLSdPy0CVhYIWPs4ROuh+pBozMvP
         yVYGjS+qzQ1mNXsiNnLXSl+kBdw/f+xGdqVWoAOr47PGkHjjZrq6wDD1JEVrmxR3Ib7e
         dqbw==
X-Forwarded-Encrypted: i=1; AJvYcCWCqoOpN0mI6XzXKj7H0k5q74e9oIJou0vI4FlTVn5xsn6LNqGBxEDXs8sGhAht/8WxQpoTHISr0mC3H9BpBCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/9Hoe4C54VV6zC9JDKnT4rhDRmf5V1oNzRgv+AJALnzscMJnM
	27WfPuHVlyVXDqzPKG1Ssuqbe3nVia2AZpMPUT1+hDj2qYbRdD7nR5CAjrrSedsXawrOSefDx/R
	KagcbwcWnoYs2qKO7IW2r8PdB/4tRfxk=
X-Gm-Gg: AZuq6aKZO1rhhZun6JWQmrBOyRJtBVKErq/DfPSEUmtu+2FvI+3MBndxF4RZQSfmAkE
	xfc+vyP8WxD0EFVf0NWkjzyruaef8iMzTHqkcWDCNCdSL4k/3pQvjQrIHWApYFMzR1wpH5sDh1e
	LPE5Gq0Byu3vJfzxYUqynipXx2sdehyPMAdd1BT8VZbnYRHDtnUapEvN+dVLFkxHZL+MVmfYdSv
	31naJSd6Y4OcIrAqXOIcv0hC/ZQQcDqIU5uZM63G3m7BIfSu1HsV8f4PlcdDCdP2tUVzu0+cJ8F
	PHkJMllPOqy174a5aolbrKnCkfklEkbQX8+VdAnW4CEVFems7eaT1nez2T+qXBPtP69J6g==
X-Received: by 2002:a05:690c:660e:b0:796:6d82:10a9 with SMTP id
 00721157ae682-7972f0f7367mr6079417b3.15.1770837488040; Wed, 11 Feb 2026
 11:18:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211082246.41148-1-enelsonmoore@gmail.com> <aYxTsxNj2NLj8I6y@scops.dominikbrodowski.net>
In-Reply-To: <aYxTsxNj2NLj8I6y@scops.dominikbrodowski.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 11 Feb 2026 14:17:56 -0500
X-Gm-Features: AZwV_QirAT5dqvJFY2hc-_mrpgE0afxGOOhkyR09o0xEmrMTj7yegs3jJM3WVxA
Message-ID: <CABBYNZ+j4u3G4RcMxH7uswKGRpZpHbnAhG7=HRwqNsAQvVr8_Q@mail.gmail.com>
Subject: Re: [RFC PATCH] bluetooth: remove all PCMCIA drivers
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-mips@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, Ondrej Zary <linux@rainbow-software.org>, 
	Russell King <linux@armlinux.org.uk>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Eric Biggers <ebiggers@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Jakub Kicinski <kuba@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Simon Horman <horms@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dominik,

On Wed, Feb 11, 2026 at 6:56=E2=80=AFAM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
>
> Am Wed, Feb 11, 2026 at 12:22:04AM -0800 schrieb Ethan Nelson-Moore:
> > PCMCIA is almost completely obsolete (the last computers supporting it
> > natively were from ~2009), and the general consensus [1] seems to be
> > that support for it should be gradually removed from the kernel.
> >
> > In 2023, an initial step of removing all the PCMCIA char drivers was
> > taken in commit 9b12f050c76f ("char: pcmcia: remove all the drivers"),
> > and that has not been reverted, so it seems logical to continue this
> > process by removing more low-hanging fruit.
> >
> > These three Bluetooth drivers have had no meaningful changes since
> > their status was discussed in 2022 [2], and are unlikely to have any
> > remaining users. The latest functional change to any of them was a
> > patch to bluecard_cs to fix LED blinking behavior in 2017. The other
> > two drivers have not had any meaningful changes made since 2007. Remove
> > them.
> >
> > Note that even with these drivers removed, it is still possible to use
> > other PCMCIA Bluetooth cards that present themselves as a standard
> > serial port via serial_cs and hciattach while the serial_cs driver is
> > still present.
> >
> > [1] https://lore.kernel.org/all/c5b39544-a4fb-4796-a046-0b9be9853787@ap=
p.fastmail.com/
> > [2] https://lore.kernel.org/all/Y07d7rMvd5++85BJ@owl.dominikbrodowski.n=
et/
> >
> > Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
>
> Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
>
> Which tree will this go through?

Bluetooth driver changes can probably go into bluetooth-next, not sure
about the arch changes if that would break some configuration perhaps
I can take all of them to avoid creating interdependencies between
different trees which would likely cause build failures in CI/CD
testing bots.

> Thanks,
>         Dominik



--=20
Luiz Augusto von Dentz
