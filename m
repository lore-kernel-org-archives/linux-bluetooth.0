Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795799458;
	b=wNw6StgNuEw8TKXoAGfbac3I5A/lT8P/8K6lW0vkH8LL9WNA7gV+Ny4gborEEyESVPoY
	 J1APw0dCIIOaeemVH6VMgeVS/v47wFKRl4KLAxV33SxlM919pY+CGOln7HYv7wJ9gghgB
	 QETdNAt9frPMRWt8fKksw8DuCPfmhN4ms0OKyXX/Xm6GjSbdSstMZg0znS4rtBq6kmo2T
	 +7VIhZXi/TnLJVuvjGfPUPUZ54OjHduMw+ntj2mozn3Sw3+w7/QR/BYkfmzysuUk08IAy
	 I02Onnf0ZdQecVnnHSOwErofyB5F1lVmNWgAcltNHAuRN9ce7Soyer0PGMYnspfcPpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=J801ocWR+PWgCF7Q8X3DvWQxxQbFrrtxfSJW3RWQ/R4=;
	b=1CNH9CkuCVPCOIgiU3lj5aBoxdCEpoM2LWHBxgrolLh6uISBEPE431ayJKIxm0EkLM+o
	 OHhCwy2/TnUIqJzMAstoOPfhiAzAeLU97fwusVzITnemGqW9pBDMKwMzMm49vZGZO4i1P
	 eW/8Yirh+hRXb6VUhI7Ssg8jwqc82Zqh+wS9LU1RGoZPwjLmi2tOeACYQC+Y/0Rm0yzcT
	 lkTC5d6dyrwEeNotr4Scgk+UCopLrvGcUJE0D3uctwaILnJ9jnWgM2dP5AHsL/u0SM5pi
	 dTvqkb3N8o5JGGK2g0s9H1bQcDT50GCP+pFDUoUmElFqINME1KFPH3/T8tp7BC1tC7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aa+0saGX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A50F606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 17:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A50F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aa+0saGX
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67db5e13b0cso7487010d50.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 09:10:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795799457; cv=none;
        d=google.com; s=arc-20260327;
        b=ahE2y/MvhUh2nDCyAnpRyp/BqMRDHNBc6ozjLesNjavF12Da5zRdVGvtdEB+zA1jtC
         dTtgZy2MRrNEnxQ6oFJKNWoUXZgLFLD8E2sB+ZLTUNQZNrPKxlcjb5UtoWqkMzwBZUWO
         flx5DPdDUpRdKtppL4nP36zIMGwbDRCR+D43mj2s5g/bBsXJAeg1aJtJJTizpuRfPuWC
         r1GN8qU8zmRqawEwsF5TphJ7PRKrlFKUGQoIzbKwur7ByIh999N6v2bKOL1+L1tIc2et
         9IWHL4wCGi55tT49s8e3e3DaNUV5MhuYZFLHuf42GcWDxDmvqIy7tiigdKNVwtQpSfiI
         ipwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J801ocWR+PWgCF7Q8X3DvWQxxQbFrrtxfSJW3RWQ/R4=;
        fh=vIx0i739ZTR5XYuHCJoPRyUUyhS/CGB3cVdSCh8oQ+E=;
        b=JH/wkfMvDCppZnRWIyuBk9SOXJOkGRnjhta9e6OO2ziLerYZWe5xuDnRXOE7FRBCON
         SfTa/HvXCjibQcQVfDHmbKXYGfL9G0lOnokOORX+HJu+uU/YfnUvPOJa0ghiLLJ+A8Bo
         pKgpHf4pdPIAVSyf3cOKfmWj3haFc6uPXhMp8PHIIXSCyYe+0o8nu/UO2UqTVkBPyYxk
         ZUGIdk3fjdgTRGoOAh7o3fpC3k7n8Tu9dk5Xrl7HPVHeeh42emX4ehNDdNrlY7K8wWQP
         k9hPVo6UCwBvke0Kfc8nzInTwpQvnRGQqCsIC0IaSBFAxifIB6o+i36fOU4ZWcy1un84
         Q7Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795799457; x=1796404257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J801ocWR+PWgCF7Q8X3DvWQxxQbFrrtxfSJW3RWQ/R4=;
        b=aa+0saGXJMgfRe/ogRH4iTZbCMGz3LzUTTkaH7126PBuNyWgBDBBfOf18ud7bRcFq9
         IpTdBLp2OS0z8rjxeNfy8pspix3uq/UGd+EMCvoQez97kMdin+NWdhFfnZouQElGD7sS
         KTihXIfbmZhhpRgxnRSZbxvzTWouLe05CZC98XIhDvhfCOjxLNhpsHHHOh2VHp1s0AhW
         hCiog2q0aSv1RYev3xVBRbUNii9V7FV3KHsG9anv3vk1ZfLrGF0GPWXOfeiF9F+oL7Su
         EtYducY14Ng6lkjFntRKYPt4L9OEaSJ2cknDP2hhNg20T5b+PXZGDtK9VDRVNbhneyIw
         P2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795799457; x=1796404257;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J801ocWR+PWgCF7Q8X3DvWQxxQbFrrtxfSJW3RWQ/R4=;
        b=nYC/mvN3IvpaBOxTQgonLv82K0IV/ELlPvCSTJ6P6io6PTwfeOTu8V3RVlYHiMoRAk
         I79CREyuAFw7RTOOQ3GsXX2aT2iDHOjCAaMVU61h9i6AgFrKyQvZ+SyL91aybVEAbAum
         n83reS8VMzPcVHGHDwi9bz6Hg5K0B2rORjEi0RRTnjP0FZG8gbYm62Uxr2stVKqhvKJa
         AbLg42Vpn7Kv7Mo04EOsRtAbk7zZmMeZXEVbEn1bKA4Kd/IBU+UgDvAr3CyZeNkGsTpS
         q1t/Rt40qSr29gy9yrV8bKMrEpMCJfUeL1+Nnvz9kKYmI7L89uj10XzLkH5o5QjNtm/G
         cM/g==
X-Gm-Message-State: APuU4Z89XUHLtyz4EkqT6sJNKs6u0/u8dfjyZ1v1JqWBE8O2iRyTpRZY
	nH/L9OxYSIDSB5y/ONcqLvMYIzb8IJMvSRcTnCDF4ivA1MtxkTHCHGsidi5X92ZTblwTvXZCTv6
	eDxYNNl5CL9B3KfRZJrNa/+FFkcQ4f2s=
X-Gm-Gg: AZFdTZdcRwOHGy2tdoRghptN7cNEwmpq41c3ilz91ce4l2isupc79d90laH581xVQcS
	8ntqjRXJ9Lp4kGPRIAhC4qEwGMej69HCf4j7ZGPlF1CkM2nN4EqVuDOQ2DK3JR1e95pbfeDYRTo
	9E8YV0tdBjKQr4mclVx1NI/Jv3RND2JQSM7KvgD5cUxQiClUSplqZvloo2KTaUwZp7xL2tlcAkU
	kBEfTud+Imfqpkh1ISyvUuu1R2nTYTBuW5QMIRHyNRwQ4KDT9Ra70oedbJ/vzlkrufpbV0NPNQz
	ITk92945fmklkPE8jwExYxeA+BWuYhojeESSZeUCM/AsS6Eob0BGRwnA3s+LskVm8r4VVjFkJsl
	pi9YbNt1fK75yTXYazjIfk5TTSYX+u/K5OoE60uJfxVZTRwm0xHIG50MhHAYW3HKAlRuuMcxoTI
	RlGaktCNTJKiFihWm0HKyxehSw8MzkIlE4ChxnqxndiesuEMNXSW5ktNp6rDDEIJ9FJ/i4gX6sY
	xv6npai
X-Received: by 2002:a05:690e:4842:b0:67c:bd6:73ce with SMTP id
 956f58d0204a3-67df44fb4e9mr5776548d50.89.1795799456965; Fri, 27 Nov 2026
 09:10:56 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261127054519.3146135-1-weihong.guan@gmail.com> <20261127164657.3505415-1-weihong.guan@gmail.com>
In-Reply-To: <20261127164657.3505415-1-weihong.guan@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 27 Nov 2026 12:10:42 -0500
X-Gm-Features: Aa3M54r51FxvXKD_1KPpS4UmZvVBUu9JOPPjtSMzFSgGxcRr6H8wqmLqJ_AkbkE
Message-ID: <CABBYNZLOCfG449tJUnAGjN=PvLVFy4Vj=bgvSCMeFEQbnudA_g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Unfiltered scan for peers outside
 resolving list
To: Weihong Guan <weihong.guan@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Kyle Pepper <cochcoder@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 27, 2026 at 11:47=E2=80=AFAM Weihong Guan <weihong.guan@gmail.c=
om> wrote:
>
> Hi Luiz,
>
> The CI's mgmt-tester fails four LL Privacy cases with this patch:
>
>   LL Privacy - Scan RPA - Auto-connect with IRK
>   LL Privacy - Scan RPA - Background report with IRK
>   LL Privacy - Add Device 2 (2 Devices to AL)
>   LL Privacy - Add Device 3 (AL is full)
>
> They fail as designed, not by accident. Your BlueZ commit fa6ba55020
> ("mgmt-tester: Add LL Privacy host-resolved RPA scan checks") expects a
> peer with an IRK, added without HCI_CONN_FLAG_ADDRESS_RESOLUTION, to stay
> in the accept list with filter policy 0x01, "since the controller
> resolves RPAs". The patch changes exactly that case, so I would like to
> ask which way you prefer before sending a v2.
>
> What I see on hardware: without the flag, hci_le_add_resolve_list_sync()
> returns early, so the peer's IRK never reaches the controller's resolving
> list. The controller then cannot resolve the peer's RPA, and the accept
> list holds only its identity address, so every advertisement from the RPA
> is filtered out. A connect by identity to a bonded private peer never
> completes (no connection in 15 s, resolv_list empty), on an nRF52840
> (Zephyr hci_usb) and on a WCH CH583 running our open controller, as in
> the patch's notes. With the flag set, the resolving list path works.
>
> Two ways I can see:
>
> 1. Keep this patch (an unflagged peer with an IRK is scanned unfiltered
>    and resolved by the host, as on a controller without LL privacy), and
>    I send a BlueZ patch updating the four cases to expect that.
>
> 2. Leave the scan filtered, and instead put a peer with an IRK into the
>    resolving list on an LL privacy controller even without the flag, so
>    the accept list matches its resolved identity. That keeps these tests
>    as they are, but changes what the flag means, and the Set Device
>    Flags cases may need a look.
>
> Is either of these what you had in mind, or is the flag meant to always
> be set by userspace for such peers, making the unflagged case unsupported=
?

Something is off here, afaik that flag shall always be set if LL
Privacy is supported. If it is not then the resolving list shall not
be used at all so the controller shouldn't be attempting to resolve
anything.

--=20
Luiz Augusto von Dentz
