Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6F73C8719
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787685728; cv=pass; b=Qa3B2tUNmf3LmCh+U+ZP1u0VeHm2dXuo63uCwtnOe8c2Enq5mDaSYjBoK6viUjRFd3wNPOt8xRe6w9ZLxCv+WpdiXDFNlm57yv8H2Ae424cvgsm5YK70Ocaq69LfMowVJfxjeCt4qayVj6RaVsxv+y1OXqcmd1CBChRbBgyEC6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787685728; c=relaxed/simple;
	bh=L1X9kmnPKW88APV8KwDoTtyqLFwd84rxEU52MmNhWVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIu5VvERraxzm9y8ZezyxG45k0fxjBRwqrn5RGCrdL+5Rcjgng3law8w42PYRvw/uNcRS5yob461NsCjpT8kIPRSUoAj2iHDaORuCku6Ms7VFAwkpgLBo+ZbpsZpg5tQdTkoZ+qAcnyoR4zL7M/4mv5S9LhBH5LzTCDfAaWdKIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAJ/FazR; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAJ/FazR"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66c4e9769bdso273735d50.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 12:22:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787685726; cv=none;
        d=google.com; s=arc-20260327;
        b=rmUUO0Vv1maJLzD5OXpOdCERBZHXbtqqgeRQDoItsRz182V1z+5ZX5SRvW+ryPYo52
         0w/l0JTEiJkp9wT6JtroJcOgUGuF6S3l1poQfq8Bwh3g0MEbVDwIf+OcH/zLsMPztR6M
         0dVR5980LJLrgbmnLNk410u+io7jws8DNBcthOhH83yNhia0gNYGmVwgtbF7mpf/Tguq
         YIhiZRXU3D7kWkYFMuF0SMWosWp0H6wD8CCWjjwjo8CjaUCkshRNmLJW6kSBIts4FF2M
         RWPOEfmt9BoLugXdW5xUZRhkm14XWRx0T2ltKDd7VL9jEDijfdvmmtSveUU8KE0cqPUf
         BfcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L1X9kmnPKW88APV8KwDoTtyqLFwd84rxEU52MmNhWVI=;
        fh=O1z7egK/OyZCviDSaaBI9trasV5cvHKPh9yJ0XL8Xug=;
        b=FLVELwETNF/pt71ddGVHVAqQrOk4gUKgkuvtfHUtKP4S1p2CJgS2EFcRn5ZNyWkDFq
         fhxD01LbUlqAgDlKdO+FsmV11ZOYZbP7tlo02HRlnvqrRPrXmFWZsJWL4TboSF0neXVt
         4H+P62OzgL7MmO7Kcw0zGEhlRf+q8nLFvlroal8HwT8YRwqfUIPQTc1rjcfRLKiZTojm
         9SfG0tEO75FbI+58YlV064PbnsdxMSAnK8nXo+ZAmdloW1nFo9Wag5dxqhu3g/4Al5xy
         PV587GcC/LcbYdojfwMDg/hNw8xf+B/s7rk/F5yJtC8i1OooQgejid+JpkX66nL9lEDo
         gP5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787685726; x=1788290526; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L1X9kmnPKW88APV8KwDoTtyqLFwd84rxEU52MmNhWVI=;
        b=VAJ/FazR//Xknmuy/MjkyfEZ5iKuiKlhEapMtqSWi+O3s/VWL3Ugstp+zNB6xMx7QR
         fFY0ZzeN9Uxcg+3KcySepPcPB8W78KYC1CzpIvUdKa3cQVFg9XzTA2qy+PGHa0ydUL/o
         0DHRIsIH9K21UiVAKyl6+otjlTOq9LvcaTBcNy0RMIdsKsJGTd5qQkpiaLRZoONtQH7g
         qKqjpJ6L+A1jDgXXsZDvVFKpFoI9L2Z4qaUwICLV/DgR1Cj2Sd9YSrL+hhhvildAnUFN
         8NIkimSYexlzG76HQjpy4CixbO1VhoK2t6KcKPoxDuOsQ5BqUTe00uamwHu5ExiHChuv
         tiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787685726; x=1788290526;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L1X9kmnPKW88APV8KwDoTtyqLFwd84rxEU52MmNhWVI=;
        b=TKm3xdZxNpDhD+6Auc1DwtCXYePxR1T9qN/6SJFU27FyKydLJk6oB+3T/yArYNJdyW
         pjX1E6hAlsrGKWeLp2PlcdYDlqfbuHwNX8UEQMaVSCXeZVkGRqMbLay1iLeibeluKUGc
         9XPK35Fq/3WPufjMVfYEvQOzoUjgKv3eeF8xN+JgllRFfx2s6waNGL0WEnU3T/oAglyn
         tBzgoAuVT3GVfpkvl+b22v2/Voxe0m37yflimisoa8/cwVunyPl8VfOjEM3IsWp0UlyW
         e3ubWTm79IL1yVrGNtbyixpsI4ojEutv3Qvjd+nX9+t5/FsE8t5/eC3Fsq/jIu7XZWE+
         c3zg==
X-Forwarded-Encrypted: i=1; AHgh+Rp3o9/ULSAS/MW8q/NVShfs6VA8hYEwLDBIwS/q6iwDmPW9jtJ15pXfGo+cs5UZLEjHd260Bi1eJteK2kV3NGk=@vger.kernel.org
X-Gm-Message-State: AFuF++mxTEwOwcKUmluRfwMoQ7Z7eEjfGxr46ox6XeO3U4DASO38s0i/
	lG+My/+Lw7P+ihH5uvBmPE9exnFjf89ciXrGPMhRlAreH+DfhRgHXG/9hoD7VxFtkev88bE4DcE
	BAMSZbi6r6MqI7zInfyA54MdvhodG8Z8=
X-Gm-Gg: AR+sD13dtzhFhvh18nLdCYVctQy+eOKjehvLRbdo9HIpbc+QWWsjZ+LO6DsgHmdA8g2
	t2cgflxjmSAnkBrC+oIIMHSxRyjjWFTUGeHslOZHnmnXXABC9wdOuKdg84eWzPIaTQUQpdqUvLK
	JdhUKP94Pv7NWZCL0p5tJA1iuk56iPGI0tkGZj6MXdB83bNufq/arco3ke+t76u2ffG+Me2De+s
	zMwm6+hCsEJFZjxndgieBt5BukixRD7ORfx22fp78wh4J/Dj4UqA+/0VTGW/f18ybIbORjimAZr
	1c83Ei87pfyV/RGYtetubc11dq7HNtpLMXXGQmqFat+GDQ6GU8QmSatOp0q+su/AgPQkYaz9cdn
	FhtM7gh3ZAOWGKe3RhR5YhmTWUiNgwhM=
X-Received: by 2002:a53:d80a:0:b0:66d:c8b:7a3f with SMTP id
 956f58d0204a3-66d256574ddmr273824d50.10.1787685726474; Tue, 25 Aug 2026
 12:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822164341.3750491-1-nicoyip.dev@gmail.com>
 <178759021163.3014491.6954824460297136867.git-patchwork-notify@kernel.org>
 <5e76a95e934e451e7006db28827c2d64af5a88be.camel@iki.fi> <CABBYNZJotKc4k55jEEweD6aP6XEhYyKAgk4BamV5vfp8HHi0Tw@mail.gmail.com>
 <CAAo+4rXEQ7DbjtB4ZTUAm5Yg3-jKRzmWbH+gTfUF510PU5caYQ@mail.gmail.com>
In-Reply-To: <CAAo+4rXEQ7DbjtB4ZTUAm5Yg3-jKRzmWbH+gTfUF510PU5caYQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 25 Aug 2026 15:21:55 -0400
X-Gm-Features: AcwNN1VM6jIc3YqbEmkUSp3YYTDAtgD7Zhgklb7Wnpwu0qVDhFV-hx-0ptxdH3c
Message-ID: <CABBYNZ+0cbKR9ZAxLWK-8saOBR5u6cFEH8ohxP7hXGL2475rKQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: RFCOMM: serialize security confirmation handling
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Pauli Virtanen <pav@iki.fi>, patchwork-bot+bluetooth@kernel.org, marcel@holtmann.org, 
	kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chengfeng,

On Tue, Aug 25, 2026 at 2:46=E2=80=AFPM Chengfeng Ye <nicoyip.dev@gmail.com=
> wrote:
>
> Hi Luiz,
>
> On Tue, Aug 25, 2026 at 4:24=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > Interesting, I though the kernel_connect would actually behave as a
> > syscall and use it own thread so it wouldn't result into
> > l2cap_chan_connect, in that case it is probably useless to use it in
> > place of l2cap_chan_connect directly, so we may take the opportunity
> > and clean this up.
>
> Sorry for the negligence of the possible deadlock cycle. Could we
> avoid the locking cycle by directly moving the session lookup and DLC
> walk onto krfcommd so rfcomm_security_cfm() no longer takes
> rfcomm_mutex from hci_rx_work? If we need a fix like this, should I
> send a follow-up patch or send a v2?

It is a possible solution, that said couldn't we do the walk using
rcu_read_lock/list_for_each_entry_rcu/rcu_read_unlock?

> Best regards,
> Chengfeng



--=20
Luiz Augusto von Dentz
