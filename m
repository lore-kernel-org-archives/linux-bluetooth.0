Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E7748F006
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869178; cv=pass; b=Vc5A5y8GSrQRz/R53HoJ/8FacrFN/DlhgZHcsJwia+So4eXEKM64JGtIZibUMiFiLeQK1dtiTAC73eOl2CsLBgkfqr4/eOVAZ84BlHdjpaVV+lH3bK6RQnx3DcATs2CY8Lfpbsd8tGFY3VMaWJ+gsro2VVLMwT4KILnLUSqnjgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869178; c=relaxed/simple;
	bh=3HNhYijAWIlonc/Qrg3d2NoX+DbQEmI0MRjqv6tLuX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpsCOt5jT4h73qTW0ouPUvuiimsUBSCnS/SvePLp7Se5SmRDahFaHkQhnCtnX+vAyOGuFO/EoBMK6VHKunk4SnZ7WUtEWBZIEPVyNtB5ml6Y1KlqCBQ2262cpHj0etObyJuGmZ6peEGhHquBQYRmiO60n8uJn9iDrsUS8VTVI+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T73Wvnot; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T73Wvnot"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8ab445ac183so39832297b3.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 08:39:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790869176; cv=none;
        d=google.com; s=arc-20260327;
        b=OYV9fktNtID+kE5vTU66GciPPztr4RuRNroeRjpTYG/WESDSlzFFYxBM/dqctkTBlu
         RC9xiMlfX5gkv6zcPG218qg9gjJhktclObA5SgvyiTXtstTrWsxw2NoevVmDaNnWvOc5
         VU2oq4tT2mTMCb1oYUHRuT+OuMphQVj7kqkor6L3FC09w0ns/XjjpqLe/48EwTgWhOvj
         S/jX4M5hO1Db0JRg6FEJSYZMvnSrJnkDK/YGdbiOh26IzJtDRpXjr1qFQvUshxxD0fUy
         8TYOiJlQ4D4midyyUwRtL6t7FEgrO/gKtGi3siaUlZY1xpUr8dVAXRf4lxGFfdAIglKF
         UIWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=II8FYW7RK5kOmuU9k9Uvo94DcYSc8GNd3BqlOw6i45g=;
        fh=dss+mvtVWWcCKjYBBjtoOwyfdbc8Dj1NBkicxxfSm3A=;
        b=Wq0VHpXFqNIzTk1dIEUS4sZCzjavtOW4IUBWc+oqr9X+AleaMc6Z3DrbilK25v2b9A
         fKNHa+DwObgjpCb2tNJ2BMDeB6mWKJDL/PM+/itn67yyN4j/MiPW7tJfpw200OjwDTbX
         Blf0V5iHoWZ+dspORXRsyvlRqrhGgKBA20MfHo520rGP1bTPTHjDNLgz4D2Gqrw2uSOL
         orkxMUUcIfdzZIu/mfful/oYmvdxrBeg/Av7pNKNpo1DEVWk2QTCxdkrd+lPZ+C+UTOL
         eT9c0zdY5ZIijqkLknF1iLU4EdPcOezFDKVKVEWBb0w9RbcneukdIpFiqNceOtAKIt/G
         Wzeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790869176; x=1791473976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=II8FYW7RK5kOmuU9k9Uvo94DcYSc8GNd3BqlOw6i45g=;
        b=T73Wvnot2IARfIXFXHFIIReyD1t1Uyr06jfxZrgjsQLjYsUiHLIUVL0dvUi+0Dpd6K
         MUMiMUFngewvkux8kXMtLWl210nTrABTabXvyno0w9Zahffm8jIBtqw0b+nBLuoUr6gp
         fWMO0krpbS7v+NPdfYiB/kL6f2PFR4ZGo5UhjpLqFjs4j9xdKkow/FPmmx31Fn14EV+B
         hDUtc9ibRImJYM4q+d4oJKWrFfwN0C2hVIqLPTRTpfDXYbQLqhXkZs9aoIOcB7G8UHya
         mMIDrpZOVfmqcx+dvozOGSDywxW6MAbEeSlGimXYiCfVmOuNIgYgA/USAzGW9yBMJMHL
         WLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790869176; x=1791473976;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=II8FYW7RK5kOmuU9k9Uvo94DcYSc8GNd3BqlOw6i45g=;
        b=vU6s3JaK+BXFG43RJB2mr/rChNMJFBFqwOE4Cd9QWL5+yyBdbiM9g+XeFhNRR4vYD5
         SLEIx41jn2koa7h/l+q+FmG+/Pc17fRaLtWgDCacCbbM1P9nzBjm+7TB1++q3UB+PG2g
         RHzsAtgr0z5ii8B2ijBbSOXolJKOztfbcAIcwYvFqR4bnur2pI2kxecVISSqbikeDnuJ
         TffWXkrkzrrzDkSrA0yfyEasSXvQLGSLxNHzFxTOXHDGNCuUSyEMlXhlfFqcmiKvf4Jh
         nASUJn0HK2tqhQ2i4aZMse9nguckZ3O+D9d66UGXEQ2v+4zRY+PFhkeN4FF6X+UkWHFh
         BE1A==
X-Gm-Message-State: AFq9FYIUDhQSCNv5r4p3KDC7RW757Kx1r92RTKkLHdyuRluqhN03sjXU
	V+GbQQxiOEf0wAhX9rwuw+Y0Nopd8mDEgDQolLxI1Z4CWlVaw7mn2yqx/Cvu1edQjbtvBPMrK8O
	wezndUlWQWVulzYx5Qj9Lphvcqh/P8pVlqIGLe9mNsg5w
X-Gm-Gg: AYBFou0xRGiKzQ6H2WnaPizTcRiilapQHpZQPGE0upDULyYAkYAeiba2tDaBODYesyp
	69IFcAKaODQikDnWrC+iDv6hV/dYuZN5/+g56H6wVEYhAviYoFTGg7iIP8mUY1PWZ81u4GvRpyd
	hhgpARnoQDyLlClEAh7e9bz2iGA3Es8K6fb8HG1f4DqCnOJlFuOFhBFvsRdFVGFgvwnz80LYCDE
	R3TnMpCG4t1nvpa17Mq4pnUkuPccxJvRbpd9DgEFb9t5uofjpbEe+a2sPrAY0Og5/oEe2xTRydb
	m7wvDD3vifDuCHBwKC3Y+ebQptE9dIoXsFZZjdDZlO46p5iGV0agmKVlpdWbWgQPmHYXSR/2T56
	VFJ6sphzS4K/nIKw13+wLGTiGGVEk69eAeZpM8ruhHA==
X-Received: by 2002:a05:690c:c4fa:b0:89a:63da:cbe7 with SMTP id
 00721157ae682-8ac9342358amr29063617b3.45.1790869176143; Thu, 01 Oct 2026
 08:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZKebai0bQZ4Z_0+P6LwWN=-jniRMN0vctYTD0TC=y36cw@mail.gmail.com>
 <20260930203031.89180-1-kevin@simpleble.org>
In-Reply-To: <20260930203031.89180-1-kevin@simpleble.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 1 Oct 2026 11:39:24 -0400
X-Gm-Features: AclHuK-TKKFgsa2OCjM1H8Qinnjr-wIelCS95wiu0-kwvls6JvCBNcyA3wx0yQQ
Message-ID: <CABBYNZ+mRWjBayWL_t5mmQZT3ccZvR-UZ9O=SBLQnXTo9FpJnQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/3] Add Connectable property to org.bluez.Device
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

On Wed, Sep 30, 2026 at 4:30=E2=80=AFPM Kevin Dewald <kevin@simpleble.org> =
wrote:
>
> Hi Luiz,
>
> On Wed, Sep 30, 2026, Luiz Augusto von Dentz wrote:
> > This is already exposed via AdvertisingFlags:
> >
> > https://github.com/bluez/bluez/blob/master/doc/org.bluez.Device.rst#arr=
aybyte-advertisingflags-readonly
> >
> > bluetoothctl does already gray the devices that are not considered
> > discoverable, see:
> >
> > commit 815f779aa8e477e399b78f03c0ea0e75f0270c4a
>
> AdvertisingFlags is the Flags AD type, which tells whether a device is
> discoverable, not whether it accepts connections. GAP defines the two
> modes separately: connectability comes from the advertising PDU type,
> which the kernel reports on its own as MGMT_DEV_FOUND_NOT_CONNECTABLE.
> bluetoothd already relies on that flag, to skip non-connectable reports
> when auto-connecting and to drop temporary non-connectable devices when
> discovery stops, but doesn't expose it.
>
> The two often disagree. Beacons commonly send ADV_NONCONN_IND with
> Flags 0x06 (e.g. the 02 01 06 prefix of iBeacon), so bluetoothctl shows
> them as discoverable although they can't be connected to. A device that
> is connectable but not discoverable can send ADV_IND with Flags 0x04
> and is grayed out although it accepts connections.

/* BLUETOOTH SPECIFICATION Version 5.0 | Vol 3, Part C
* page 2042:
* A device in the broadcast mode -> shall <- not set the
* =E2=80=98LE General Discoverable Mode=E2=80=99 flag or the
* =E2=80=98LE Limited Discoverable Mode=E2=80=99 flag in the Flags AD Type
* as defined in [Core Specification Supplement], Part A,
* Section 1.3.
*/
Still there on 6.3:
https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core_=
v6.3/out/en/host/generic-access-profile.html#UUID-e4fb40c0-af64-b2b3-d141-5=
2cc77603ffd

So the iBeacon is not following the spec when it comes to setting
discoverable flags then.

> I checked this on an nRF52840 that keeps the same advertising data,
> starting with 02 01 06, and only changes the PDU type:
>
>   PDU               AdvertisingFlags  Device Found flags  Connectable
>   ADV_IND           0x06              0x00000000          true
>   ADV_SCAN_IND      0x06              0x00000004          false
>   ADV_NONCONN_IND   0x06              0x00000004          false

ADV_NONCONN_IND (Broadcast mode) so setting any discoverable bits
shall not be allowed, Im surprised stacks even allow such combination
since this may confuse UIs that may show the device even though it is
not connectable.

> The use case is cross-platform code: Android (ScanResult.isConnectable),
> Core Bluetooth (CBAdvertisementDataIsConnectable) and Windows
> (BluetoothLEAdvertisementReceivedEventArgs.IsConnectable) all report
> this, and exposing it would let applications rely on it on Linux too.

That makes sense now, I jumped to the conclusion you were talking
about the discoverable flag rather than whether it is connectable.

> I'm happy to mark it experimental, or rework it if you'd prefer a
> different shape.

I'm not against it since some stacks allow the combination
ADV_NONCONN_IND with =E2=80=98LE General Discoverable Mode=E2=80=99 flag or=
 the =E2=80=98LE
Limited Discoverable Mode=E2=80=99 flag, when it is clearly not allowed as =
per
spec, that said in case it is a dual-mode device then we need the
Connectable also in a per bearer interface to reflect what bearer
would be connectable, or at least on LE bearer since classic is always
connectable, an I would print in red in bluetoothctl to warn user it
is a discoverable broadcaster.

--=20
Luiz Augusto von Dentz
