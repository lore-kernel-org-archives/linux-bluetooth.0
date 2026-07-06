Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB363DEAD2
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783369260; cv=pass; b=roprSw9+cJCQmrqslTMy4iCgAUM5b8nYxPZvBlBVspwtzjPnH3WVz0StfnQkwQk4YUzGRd6aMtRvYonOpSfS9lIOxSkGfIBSLAuRhM+QFGiub16tonkE1BTMXEWRuZUWIHXVPH3eXuIoANc4NWqwCFH8Z/2xPWKCuLxtiV8kcBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783369260; c=relaxed/simple;
	bh=eS5TkT7qd2I3BCx0MUnneGkbGVAZPGy5EUGW/yI4tzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCiKSqoHgTPHiHG5r5FCVy31rFVwbrZMy+BC9J0tIoU0eYBw8OinRFGBeWA7K7dSpAeUQIC2codboEaPlvF/bpSp5DApSPGI5WLTBtpSQl+ZQ3OOuI9eUaUvj29+Am3IM6CAwaX8l6nifo6pTOhpgNxOUJ3dlS9PaCO+ZB052Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MB8JW6s9; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MB8JW6s9"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-664c4a04081so2929600d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 13:20:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783369257; cv=none;
        d=google.com; s=arc-20260327;
        b=PrOW6iaBP6MmEoJNKbJMWt06R148hSV3PyLHb2m/Jfg/sheSNExJ/H73UfeBdQhSGK
         vZ2Q9z3cBPCF0f0SFx4uZSFyImbw27stwRd9wJDQuEKmQeq4OwM8LEiwviG2ahM+w41Q
         GNB0A4iRH73I2GcUArpPoTl6YBgNabQdk3hmTedBpgVrgC5ligCECg6ZH7so0gVZGlIn
         HJ2r80N7UqhRxH0s5GR0GRElgV8gnssv8ceYoQZMdk0wl8bOudKmRQED8F0fE/YHdQ7H
         akoNo8x5UuCCGsOM6izcbFexFzMt3G8kJrctPNjrrjN84Oe48XB7Gadran6ik5qW5tS2
         qO9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EpTQylrI0HEDEkwiSngg4lcHSD3S7E1Gj/Vv40Rmdd8=;
        fh=bSa/xgECR4CNKFJ5+bHGi5oq35jfjSLjfR59cxCCgjE=;
        b=jA3BayDfkAl6ncKR0+YXCBT+Tk3ptj36y0jxdXMf1qGzyURE51h+tlgaj37Y2fFPQl
         Kg9oPbHW1E50+cHN5Jdy3aIqgVpqG/b3h9eufchRoch8ZpnRrTodZXGYi66rPVcHTbIQ
         JXxHz4czxauGL9U+dZdzkP/W5wmv4KUm+NQxm+rZn+KAmNgegk7Wz+Jt1M0AxhlYxBb8
         LWvlE9U4jZP2H8RmAD2gifxQsjhux/dxoOjTsdUIHUQq4mgtwmIz8QrjqldYj5/sYbkd
         ckg2gJI8G0sJ14HJio7cpZO017AdMwQmqv4qFLkFRGYcbAdc++j+AsZcdCpL3MrnqzTe
         +DWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783369257; x=1783974057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpTQylrI0HEDEkwiSngg4lcHSD3S7E1Gj/Vv40Rmdd8=;
        b=MB8JW6s9Vw91lgS8qh0RvF1i2nBMPDJL8VfsROO8llRuRlF0GUSPcsfo2qBmm8F5oS
         OxUrVgEzgzE8npYry8i+qPRM75QrPsL4dc2S/P7kl2TYipfQGemA3m9RPHdpQg4JDte+
         ADqNx+MD92QCJ7t5/Nci0EvHNn1sB8L07GC6k+JcO+BXGSmHycLVau3qQP8H2wpQ2SnB
         ZGMqtM98afpX7EUJ93LjY0fudNInztuGeIi9RWX6HyMgdayRMbwlnBAi4EuPGcx/7rB3
         Pg3Cc0+nNRit2iClxtM1f6GQZjo73BrRsk9L1nIu0ZOXOdDyX49LD8RkMjm/2HwOQqnz
         2oCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783369257; x=1783974057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EpTQylrI0HEDEkwiSngg4lcHSD3S7E1Gj/Vv40Rmdd8=;
        b=bBH8ZbTN3X1ZD6d0zsI5WoHqmsBM7C6DQSpWDjYuWneZmrl8BWSYU1VfJJ66Ou+T5B
         gW2zipeCARFahbLdmprqTNDQpr8SNyyIK0E73Y7dkXX1ToPJk/cznZAC0WEWIPZVhbxH
         JavlwMBofUM2awt4ypm0/YwpoVmvZQ3bpNc/RdTbaTZIKrR3kmOq4tbMUiTKuOeqJFHk
         +0HrL+3HdrKaDZJjl9HHudMYcl+NhNBKpmO5cCl8gycL9Y6HLjNXRMmNYe1tzuCOp2f5
         2ONWJfB/W5ZvGXlCrKaCz2b+7WsGn9tQrHUTncor/R4KpDLXrY4fEt/VXR9U0+cg29yH
         0trQ==
X-Forwarded-Encrypted: i=1; AHgh+RqyajpVRUq5qopKckeRsb99bCWOJOoDpxIGBbPBUjBYW56i+DjXTX+ZU++pHNUmqvwskjQy7C0SBxzLl4bGJ5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya0LJND9LYo9gom/Ijl1m3sZyDbZqH38yQ6xZJF5yR2YknJsrb
	FWrfzSLjIGejqAmFfz5VhkRQ5eNxRBBa81xXmhE/ja6/cD0166ih3gdMJ1v9KIJSCP5kWlIEafa
	idbu/f7bmhpoexvV/c2xrQZ7lnTpuMPU=
X-Gm-Gg: AfdE7ckxUfgOYCxj77pqW8cNXmkvyIay7/RRRZnulkG3th/lTtuWp5TFr9NeuhFSGEK
	zEmWS8kOVQlecBImFG8/8lx1mxvjRcu028izjrvCQGyr1dlBqbiaVZYNwCHNdQ+3SnmQ+HGnCAj
	/CJpxSgnt0JoS1nx7Z7MBubHToPLpDIIak3EarJt1XQ8rWKWRyamBiEt3BOGKt3kEqM22qF4I4p
	nJimLidCxfPwZs3OtVeStANFlXuHc84UM2/mak6rH63BGTm8iXLeGxS+2gbZiMdL/rQ7pO9NQFl
	7lTSNSRQAH5fbAv5LyBKS5iTN4sZZ6DTVCwH0re+/iGfQR/3lxsB6gWiOOE=
X-Received: by 2002:a05:690e:4806:b0:667:84e0:d9e0 with SMTP id
 956f58d0204a3-66784e0db45mr432516d50.16.1783369256776; Mon, 06 Jul 2026
 13:20:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706-ipq5018-bluetooth-v4-0-350262a30959@outlook.com>
 <20260706-ipq5018-bluetooth-v4-6-350262a30959@outlook.com>
 <CABBYNZ+6BYa-CrC08piL++ysOomiWK2gbYAv3ecWwpE+RpsNOw@mail.gmail.com> <SN7PR19MB67365F06A4CC7405BD68AE139DF12@SN7PR19MB6736.namprd19.prod.outlook.com>
In-Reply-To: <SN7PR19MB67365F06A4CC7405BD68AE139DF12@SN7PR19MB6736.namprd19.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 6 Jul 2026 16:20:45 -0400
X-Gm-Features: AVVi8CcybGfiD02-Luzbn1df7ykWAKEIqVJMVtGzaJ6UGd0Ku3B0xQXNIrsUQbk
Message-ID: <CABBYNZLLDMU1agbQJfL4T4GOTinkRyM76NDqiVHk_4+9KFohQA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] MAINTAINERS: Add entry for Qualcomm IPQ5018
 Bluetooth driver
To: George Moussalem <george.moussalem@outlook.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi George,

On Mon, Jul 6, 2026 at 4:04=E2=80=AFPM George Moussalem
<george.moussalem@outlook.com> wrote:
>
> Hi Luis,
>
> On 7/6/26 22:36, Luiz Augusto von Dentz wrote:
> > Hi George,
> >
> > On Mon, Jul 6, 2026 at 1:27=E2=80=AFPM George Moussalem via B4 Relay
> > <devnull+george.moussalem.outlook.com@kernel.org> wrote:
> >>
> >> From: George Moussalem <george.moussalem@outlook.com>
> >>
> >> Add maintainers entry for Qualcomm IPQ5018 Bluetooth driver.
> >>
> >> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> >> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> >> ---
> >>  MAINTAINERS | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 0b9d7c8276ac..60f7251d1a16 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -22289,6 +22289,13 @@ S:     Maintained
> >>  F:     Documentation/devicetree/bindings/regulator/vqmmc-ipq4019-regu=
lator.yaml
> >>  F:     drivers/regulator/vqmmc-ipq4019-regulator.c
> >>
> >> +QUALCOMM IPQ5018 BLUETOOTH DRIVER
> >> +M:     George Moussalem <george.moussalem@outlook.com>
> >
> > Do you work for Qualcomm or have access to their specs?
>
> No, I don't work for Qualcomm and don't have access to their specs either=
.
>
> I'm purely contributing in the capacity of a volunteer.

I appreciate the initiative, but we still need ACKs from Qualcomm for
code directly related to their hardware design. This is especially
true nowadays, as people seem confident enough to send code changes
done by an AI agent for hardware they don't have so they are never
tested.

> >
> >> +L:     linux-bluetooth@vger.kernel.org
> >> +S:     Maintained
> >> +F:     Documentation/devicetree/bindings/net/bluetooth/qcom,ipq5018-b=
t.yaml
> >> +F:     drivers/bluetooth/btqcomipc.c
> >> +
> >>  QUALCOMM IRIS VIDEO ACCELERATOR DRIVER
> >>  M:     Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> >>  M:     Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> >>
> >> --
> >> 2.53.0
> >>
> >>
> >
> >
> Best regards,
> George
>


--=20
Luiz Augusto von Dentz
