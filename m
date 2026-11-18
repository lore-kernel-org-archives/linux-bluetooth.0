Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794964455;
	b=KONQZqKn/vQXH27XPlRvdYJNDFAsNzF08dvIOin3W9jDjgM+VDcjzbCOi9Gm6i49BHUM
	 ncxrC3rlm612PCVFEBmlEBO4yEa5urPFwvd9pJUYNEBe8zWDC595zwcu8HEuPgn9i4PoF
	 6Yqc5YZMCm7Uo9nLyW8OiHikMlJPfGdrlpJ121t++b9rxpJOscZemXdyj5psMxm+oaOzF
	 JiU4BQKxBmiGRj5BqLZgZKtD8xKE+d35MS+wvJcrQUmaAlq7Z/BFxtnRwtkvt6C6/Qqdc
	 5eSfwABTi6ZX4GtxyHEunST9WOHFtisfsIIpPu+ChUAViqfodSpHyUucEwGqcKT4WAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794964455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IRjaToXFJCE4Twj+Hd8fl9U1nDslc5RbTkQ2yvucR8E=;
	b=FwGf2KMQrJNcXSaF7REtI7GowphUfqPAtMlNHyJp4KnOWGhqBgUyiqRV1Sdl+BJ9gFdI
	 XPBZjAHw/PZuEbBDTJN04fO0U+0czmIvCmWsmRNjX4UpiX28yuJq7sc/hX0u33elbMi6w
	 6+KqkE0wNoLgvd6SrVaIyGYakxh+WpUNsmzheCFwGcOenoCfnCwQFNqepcuPhw2XF2lEr
	 dFt5CLCmmrBrRX/LKBS3R8RjVZULByhJOL7EAU5Y9b3LnNh07+kjihjuqHyeK4b1NznyM
	 MO7vlq4dmRsw4EjBMJS9OW1s3mk13MlXUl0DoRKibX7Giw/5wDp4aM+a0puzSun3F1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tFXYHq5V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A141C606A32A
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 01:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A141C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tFXYHq5V
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b2d14968c9so4021987b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 17:14:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794964453; cv=none;
        d=google.com; s=arc-20260327;
        b=Lbo+5mq0dKoFXn8LrrZxDjGnXB/vxmOVwTalwMbzLOSJ/ObjDF64tDWS6mpBvp95GM
         KPQSzvHheduoZnYsTlqg3C6gyucBjAoHLL/T1RAgG9jSoS7MdT/g/MmSEADb1xmyoTHu
         zis+nLf2VL9yJl/qc7Rnlxg4Afl0IKziXtNMieaUfma4rIULcSxUxW4hashmhzI4CppW
         tyCTMn9tzBN9F7/5meG6IWBfaQN74LNGsxo+oJkcpyHIAoYIXMc4OGBZMjiA+oIyNwe3
         6ctN76adjgFBQPNfn4ECFXjv8rpFyHeA+PS+FoI9G+gvgckikXkfFnetfcfu9zWP2tIM
         cEoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IRjaToXFJCE4Twj+Hd8fl9U1nDslc5RbTkQ2yvucR8E=;
        fh=hXC8+iA5eHSnQ5XdjU5+wbw5xhAgV/gHWIsFQsEBXNw=;
        b=o0fmbaaHWA4wtB3X7BECbSL7r1cZrpL0yDYadXL5e2NAw2IOmaLD0pAYVmpQul+Lg8
         xzTW/BPz71mnE9k7tM+huCw/FldN+tmSNxOEL1UNg4mIMDm8GY9vWUFXieRB5WEC9FgT
         AWYOscTQbvCxv74xWqvXY6IXJkQsMRaa/t0/K3dlV3OTBWmRb10nJqz3+VrgVuNE/Z9n
         xWzjbMZWujyE//clJYAw4u4xCv6wfqWYlHZuFiwe2TNLIiSQDlk28cUrxLZyY1BJH1jQ
         w2qhAImrOxCjQ4otkQheStLup9qjqAgq5h3EkazLoty8JqfMODNkcmdKpv3B8Z649WKs
         nLuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794964453; x=1795569253; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IRjaToXFJCE4Twj+Hd8fl9U1nDslc5RbTkQ2yvucR8E=;
        b=tFXYHq5VnRdRY4htvylxnPgemtubvGNEkMBNtc2Fc/dJmm0D6NEfLTUgQSWKgyVBxb
         lIp8yg8zSLDnwbZ1BpLSAjGbPRii72g/M5GYhoqYACvoCALPDvFwSjFSE7ZpKLmDJlvH
         TGHFvylLnO68JS8CmFv7G/2ygtlsUBxdOadhbDlXZpgavpRW2kKF+Fq3d7NV/vJ3zLq9
         248WZhEgXfxmFpRTvcr/Zo29+oTN5JJqMbtqO4Od4QCtjes8cVjlv1uBFwzM7jmt0lth
         wTI5Vvf3WrqbdtmgByM9PZg7ihSvgLAe4JHLFZSupDmQlcLhnJRLE8E16FFoATLdFGIY
         Vu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794964453; x=1795569253;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IRjaToXFJCE4Twj+Hd8fl9U1nDslc5RbTkQ2yvucR8E=;
        b=z3judnpK9fNuWiPKFbtVs9eDcANF5YWcCYtLli+e+39rf5zI15aeFhGWRP8NIjts/2
         kugiybMoLgc6kocnp2EgQ7omYlnDE4l19naqwm3hsut7oAW5EprrRfwz4Q0mytIthKPm
         SLoYMpkl0sfUvdhWZp0UvtjSMWbd0nQr/WlgzGjoSlc4xgCZbsgnbhXpTzwwGvOzLQbx
         bITAUYVzvlhxQCmvmqv86LYNlbIuM+qw2cECj4OCi4Q9fon9q/uw+aj1QjQIA/p6dHWN
         1UsVngLuVYzGfIh/6rREqMWAsjoS4VEO5VGAxG21Qf4DxOoURcVtiVnFj/dNhizjHGBb
         cKWQ==
X-Forwarded-Encrypted: i=1; AL+hErEdvtz7SvcGXh4lZz/huzKJpVnvCCRmyKDVtV/y5itygN/SHWbZtYQGxjIXaADi6sJoueBH1AaobOfEn67DwwY=@vger.kernel.org
X-Gm-Message-State: APuU4Z97eQqH9mh0NvGaTQYyVevum/kMOpb/R0Bp/tOAeNxicfresNKH
	5hGTpusfeFJ96CWafzVNVgpXsN8Wia9VUABmRUSMtdpqAoSpvdL68Wug+I/GJ0IHs160ND21RjL
	r3TU3Vdn2qNoM/HDRDk7GMdFtKm9tggI=
X-Gm-Gg: AZFdTZfVKW0eZtQ6hfsSRWtcu26/x4gMU5xqXDX3feiaZ33hR+HHr+HddS+HUXgEbwd
	smXjXgrxZzRyIYpnMnYkdYVgNmgv5LgSzRdpO6jLmXbGlcuWE1zEP8fFDUuhBbX4vCCAkAJz1nf
	7Mn1B0z6bTVEEzEH96+9H95Ed5eUIbtOJuAZcFBVojFKQy8knDnbQXZQGX9vVnjHhBdKIrrREN7
	I2U9D/QeYnk2kkTkXZuMFVTNWmXo/xPYK2Hefj9CG1HQMe0P0BbzUAKEtFWHL5mCfCST8ciOYhq
	MYf5zMlW7OO7MPlycgi8iSLGaIRiKQz8gPPIIASVVC9qqmxQhdxrjX2H2drs0uZHNJzAcUE/hlO
	26kMOaWU4OvkerqRk4e8rxNkwZ8G4fAteAw==
X-Received: by 2002:a05:690c:650e:b0:8b4:dd2b:10dd with SMTP id
 00721157ae682-8b4fed9b538mr3480997b3.64.1794964453487; Tue, 17 Nov 2026
 17:14:13 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pm-bluetooth-objects-candidate-0184-v9-4094fa28af7bd56a283a-0@gmail.com>
 <CABBYNZ+-DMvdpQPTMfR806ZaBx053kg_00q7kz3WCTucziQDxg@mail.gmail.com>
In-Reply-To: <CABBYNZ+-DMvdpQPTMfR806ZaBx053kg_00q7kz3WCTucziQDxg@mail.gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Wed, 18 Nov 2026 09:14:01 +0800
X-Gm-Features: AclHuK8bDN3YfC9Q2EzKtpzaN_Hcmq_vPscZqBCg3TJ_3iSbhyiD_xdZPyWIrBc
Message-ID: <CAFRLqsV+e_+Mi66BacOSHKj7R-cd27ipTn+TYXUagHJ9BLvV5w@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Bluetooth: SMP: Serialize root channel updates
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz

Luiz Augusto von Dentz <luiz.dentz@gmail.com> =E4=BA=8E2026=E5=B9=B411=E6=
=9C=883=E6=97=A5=E5=91=A8=E4=BA=8C 01:23=E5=86=99=E9=81=93=EF=BC=9A
>
>
> netdev sashiko instance found a couple of problems with this one:
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/pm-bluetooth-objects-=
candidate-0184-v9-4094fa28af7bd56a283a-0%40gmail.com
>
> --
> Luiz Augusto von Dentz

Thanks a lot for the reminder. I didn't know there was a netdev sashiko.
I'll check the report and address the issues in a new version.

Best regards
Cen Zhang
