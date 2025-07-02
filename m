Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956122749E5
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751478624; cv=none; b=OeibASTXq6ubsHALFXUS4eQJjMvpJ78l4wOdo22psCy0UDdX8uQMJGPKUMKAp32KkFo7bS04K3F7BQ0yAl7ahE5fVfOiNEQF92i16YLkwQp8PLY6bSMK1ecAtayE94Tv/UYAOd9xWWCof5nhqnheq1vnn00Jvr+rp3kwbc+/Tms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751478624; c=relaxed/simple;
	bh=O100KrnznUaXHfIEao3W6dn9Cm+6YOzIdsGvhzSyHFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFa0ZgRneNksCHC8V5EqfzYvFDKKkKBCwCnUKMOrcsWEYn2y/hkrR+7uilOxHLbi/wd1NrxafoeXUhE3/0LiJPUh98CZVcBIIHZSa9cHDO8SdhQds5Om6nO+hyBVdPgh2o14QheJnrFj6dc0CxvlRhjbpv/3wqUSxuSt29kGBEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPVMhIK/; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPVMhIK/"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32b7fd20f99so2037691fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Jul 2025 10:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751478621; x=1752083421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFbZfVkfL9biQ4u2OZbG8XRfvNiivievAxu0tzPV9m0=;
        b=DPVMhIK/0fWfOVknxsnF9v0ftEO2p3eP2xxllUtJZjjFlVMFL/oi8kaTOttQZtUMpz
         OKa+bnOOyc6V7UvQwjjgShsbuC7MdwyTBkS+Rn25xfCQxmaIWFarB26KUd7XLGXcTXFO
         p8rgNknpjT1cA37Ng+aRQHhAJEBHZK9o2pYuY6HWxeO8ef+mcu+AQmqK2nhS0WGfrKpY
         GDsnvBo4B3qIreRr/xy5siHB/Ow37anZ5D//1QIWG8TXRLpXQAYvmycaxSdKqq+KqbIy
         f5z4NdvsyOilRZnC/Ni7XxDZxLXBYoGhwJpsnpmP+np2pvqguDj6XkOAXtqsK7hHse4d
         39ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751478621; x=1752083421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFbZfVkfL9biQ4u2OZbG8XRfvNiivievAxu0tzPV9m0=;
        b=Ckk9oVKNvOG1B68BLcc2VbinU+2oKRL62qAg1+fEFlYLypcVAku1v94qI1tPyIDejk
         Z78pXpJQx37TORMrCi/rjf7rCTMzpMQMLd2eBq3AkQsov9n/E3w6oI6AoLKiaDdapEdn
         U3OGbxRdsXesOHiGDzPoHJqTjFTcUYM+Xv2RsD1wjAjgyrBUWIbgZz0pBiblR3JYrd7x
         1HDmtHQ4nAJzTfvRm3CGo3cTBsEropWpc+gjhfOzC4PTFyREFbYMUNzoBX0i6TWPO6DO
         okq3mmxgJeQOp2qO3oQ7zocZvMy76/Whn9uuxkjsHU/DyEmFrtTR2mDQ7vlR0ySj/+LJ
         /Jgw==
X-Gm-Message-State: AOJu0YzSuQvTPs6QFWumrKQanEjvUEhI4K4wtrh34odhVbwPO/3SJkck
	ZP1yXJ8150Tsi1s6gCL9Dtfr8ICCSlM/ZWja1AJgQlRgaEA8floY0B58tKtNABTo7poOmOeu9wN
	Fyslv9M8CbPEJSJD9TPKiTFF3C//pIhIvaRX4iMg=
X-Gm-Gg: ASbGnctbfwzfXc10EupqnQR82/mISzmod9pBwuMrZC6I1hWgQqXIqPdkvSDkB3jr1Bn
	A+PM5ZROm+o74CATYyQ3kHOP7vG87ux+5RX0PEhDVf8Qj/myYf9J9TjntT8l0CQBlBV0nm3ApAz
	o3IsM1suoxgyW/Av/HomEFAezNzH+9w5l5KgHQKNUd0Q==
X-Google-Smtp-Source: AGHT+IGEarX+bguEI+DVMbHK6ri/XLOuBTiKlaOTDSZfr7uPCwV3vlLSqRr0uBW1zAoXKottjxQ4xPhmVBHVrWj7u7c=
X-Received: by 2002:a05:651c:1106:b0:32b:7614:5722 with SMTP id
 38308e7fff4ca-32e0d4e6364mr1801511fa.13.1751478620479; Wed, 02 Jul 2025
 10:50:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627145136.421853-1-frederic.danis@collabora.com>
In-Reply-To: <20250627145136.421853-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 2 Jul 2025 13:50:08 -0400
X-Gm-Features: Ac12FXySiNRQfKIsp-8P4kA_isTZMrZRciV1JujzTwZQ6Njbe9J2Lo_mkDzLopU
Message-ID: <CABBYNZ+t+xdrM=__wqBib+QNoT=LecFUTGsdKMRhZB8cYRNS9A@mail.gmail.com>
Subject: Re: [RFC BlueZ v2 00/27] New Telephony interface for HSP, HFP and CCP
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Fri, Jun 27, 2025 at 10:52=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> This will introduce a new Telephony interface wich is intended to be
> shared by the profiles able to control telephony calls.
>
> The idea is to split the call control interface from the audio streaming,
> as it is done for AVRCP and A2DP.
> As for A2DP, the audio part will be delegated to the audio daemon (like
> PipeWire) by the creation of new endpoints for CVSD and mSBC, LC3 endpoin=
t
> already exists.
>
> The interface is mostly based on the one done for PipeWire's native
> backend.
>
> This will simplify the qualification of the telephony related profiles as
> the qualification will no more depend on external projects, and calls can
> be controlled from bluetoothctl.
>
> A first implementation allows to dial or hangup a call using HFP.
>
> v1->v2:
>   - Rename org.bluez.TelephonyCall1 to org.bluez.Call1
>   - Remove reference to profiles in org.bluez.TelephonyAg1 object path
>   - Add profile UUID property to org.bluez.TelephonyAg1
>   - Add OperatorName property to org.bluez.TelephonyAg1
>   - Rename telephony_set_call_state() to telephony_call_set_state()
>   - Use first available index of call for new call
>   - Fix DBus message memory leak in hfp_dial_cb()
>   - Display UUID and OperatorName in bluetoothctl telephony.show command
>   - Add hangup-active and hangup-held support
>   - Add SendTones support
>   - Remove HFP specific comments in documentation
>   - Add HFP HF server and related SDP record
>   - Add OperatorName support to HFP HF
>   - Add call line identification property support to HFP HF
>   - Disable NREC during HFP HF connection phase
>   - Enable Waiting call event to HFP HF
>   - Enable Extended error support in HFP HF
>   - Add telephony_call_set_multiparty() to telephony API
>   - Enable Enhanced call status support in HFP HF, and use it to update
>     calls status if available on both side
>
> Fr=C3=A9d=C3=A9ric Danis (27):
>   doc: Add new telephony related profiles interfaces
>   audio/telephony: Add shared interfaces implementation
>   audio/telephony: Add skeleton for HFP profile
>   audio/hfp-hf: Add HFP SLC connection and event support
>   audio/hfp-hf: Add dial support
>   audio/hfp-hf: Add hangup all calls support
>   audio/hfp-hf: Add answer a specific call support
>   client/telephony: Add new submenu
>   audio/hfp-hf: Remove call interface during profile disconnection
>   audio/hfp-hf: Create existing call during SLC phase
>   audio/telephony: Add hangup_active and hangup_held functions
>   audio/hfp-hf: Add hangup_active and hangup_held support
>   client/telephony: Add hangup_active and hangup_held support
>   audio/hfp-hf: Add SendTones support
>   client/telephony: Add SendTones support
>   doc: Make telephony docs more generic
>   client/telephony: Remove IncomingLine
>   audio/telephony: Remove IncomingLine
>   audio/hfp-hf: Add HFP HF server and SDP record
>   audio/hfp-hf: Add operator name support
>   audio/telephony: Add call line identication property support
>   audio/hfp-hf: Add call line idenfication support
>   audio/hfp-hf: Disable NREC during connection setup
>   audio/hfp-hf: Enable waiting call if supported by remote AG
>   audio/hfp-hf: Enable extended error if supported by remote AG
>   audio/telephony: Add call multiparty property support
>   audio/hfp-hf: Enable enhanced call status if supported by remote AG

This is sort of too big to review all at once, Id start just with
documentation so we can nail down the interfaces first, then we can
proceed to other details, anyway from the brief looking at it some
things already show in the design:

1. The usage of glib function is not recommended on new code, things
like g_new0/g_free, etc, shall be replaced with util helpers or just
plain libc function.
2. There doesn't seem to be anything added to src/shared/hfp.h which
will make it really tricky to do unit testing since a lot of things
seems to be done in plugin, if the idea is to really have something
that is qualifiable Id look into expanding test-hfp to handle HFP
testing spec test cases which should enable us to determine what needs
to be inside shared/hfp and what doesn't.

--=20
Luiz Augusto von Dentz
