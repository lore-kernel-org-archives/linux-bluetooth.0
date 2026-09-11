Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DAE55D875
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 19:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156026; cv=pass; b=Frg2TcoNcyc6KsASi/5937uXALu41FJL/g0aDDjnCola1Ugp2SnjAgr2edIB1qMpf+51Z0GprCtn259GC0b7k1/l+YnTjsI7MmCYA3duaMpdf1iUQULXqVWpz7qcZTS+DyNOrsjatBbuhZSZca+n+CGOGQFlFD5SCpNdnZLSqp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156026; c=relaxed/simple;
	bh=4Pgq/kKZ1fIZC/UxU29VuN7OwdaNT49Enb+1FZshsLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDY7Y72E8nJXCg6KkG0Is/vwOkhRmCMW6DnBSswF8Qdiy2VSY/ogWNN5Etd6V5LkHLfHCSBaVFmNaSV0Thsmw3J7jtxYeu3TAPCYQFBzuI7hLr7DuC3E/WALxpcEke1a+9ZoVJ+M7bJESeuBHTby89U4ikbrpKpbdzUC/4M41ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8/kbSM/; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8/kbSM/"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-85a50f6a7f7so16718657b3.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 12:47:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789156019; cv=none;
        d=google.com; s=arc-20260327;
        b=kvqwf0y73F6T1EdeARxo/hZkjgzK9Lzup6J5qXxpg19y4v7ydQDbneXZuD/GB85Gvd
         zwU7H0MiWVOTXypvzid43sDu1l9tvPlT+CoK75v7Iih9kzUKuUE5gS6YseQoBRbAG8Si
         TmdOOiDhGt3Opi168M3n26CGB2CCMMxZqBYLjkurlqhE2aEksZfBWGdWmD6bL0ycfmNa
         sLqMeZaHRKjucc2BiNWdSTMF+yuIJ5Iqf21dMS0ACOzYIyauFGkJ1E4lFAXtx3/by+6P
         OuaraYrrDJ1C0+6yBsGmQHUYvmZF0OPamB3WgCzQA1ctuiGX8Cm0KXO6vp9V8APgSNZc
         DtZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vEFK8So0/pZqx68P/OtJ4GhuYFvhNn4CI49Oqkonlgo=;
        fh=wljju4BJ1TLs2hFG/KqOLK2j9MG8c/Ttf+SGHPQfrgU=;
        b=Rk35gKPkpzNemUBA7EyrdQqLe/8hKUCJPl15bU7rNzDl21cunjU35eCwzHbfIjItK+
         8pbhN4spjAn8I2Mjv4mxq4BQAKqd/MaJq1evrpK624DbQcoh2DzRyoUmdf07mFTCNRz/
         LKVpT+VQAv/YQK86mQmJ6igRJbrbx1F8L70o82kJeVwopY8rCfZefVRecRPqfU6JwFuy
         XchtA3aXGCgS4J0sgQl/4QcUbSyJ7sapidL6GchmZqdub+1t2m0/eHS21t2Cikryklr7
         8mPP10HHoIBhLkKC3N9VcMjcmqO2ZyOGgEKD/t/kuMuDIqzgrmxJ35rdogIhQp1hWmu+
         GeGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789156019; x=1789760819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vEFK8So0/pZqx68P/OtJ4GhuYFvhNn4CI49Oqkonlgo=;
        b=C8/kbSM/n1uC53MyHe5YJ1txoHvwzlR++afZQuNPzbm9OzpW0e9LxPXXlfysRY4rv0
         OSlFbYd7F4tgJ+r6tPbas49KBy7rmS5uscwgSUVA40GyOkYpdF6lOMsaVd8WNQ6HektJ
         756bc7eYzM/GsHEr/E5I/pc1zt8aC0XndgnrzmYJuEyKOAsLzCP1s917U/BZWdVO+INM
         7JqqrFBkUs3Hh9neO98MKlvUq9ro2cmdy56+IIiy3HTDUlBCrGeoSXGkyFI8VqB5cJaa
         w4H+LjQZsRw9RQmYlWNDMj3Tz63t3UG6AnYBJbwMuT06/PaNa79qjl+Uhtd6KpR/XO1q
         XXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789156019; x=1789760819;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vEFK8So0/pZqx68P/OtJ4GhuYFvhNn4CI49Oqkonlgo=;
        b=JqBZfHqZRvbI6GHe6I8q2TCU/zlRdX7T5UhU/+Mp4ExTp9TSyeR4JbDYn8lucXWVUg
         7kb/WTHp8uYRS3faUyP0Ar1qvlJ+CJb95HpZCPpB06Mi6OZWKUCtjFkyGYoS3umL8Ma5
         Q+Lr/UnRhRrrRWxwOs4k7BVq2SB4SDTTWevksZNfBIGelacO9XTAbIQw2Kt5CrfKMKD1
         6+bCP79rXnUnNZJqlAehsrddcyWVvBAeInjisRLIfXmvqNM1k/55QDXxNvJBi4uy/8hk
         jrjxgTfj8XpRw8FIRVxkbkpR5LQ+pdOG4TDIbrqJkKpO9NsG7Pn1DOrLP5IfRuHkpgWn
         AC8Q==
X-Gm-Message-State: AFuF++msaoLjbGLfawClUhVa/+E4NHKPO+lBx7AEDMdyCF9S6bFvNE05
	6m8HHsoB5DJdQLsi1d7XHOOEuxFYgMfhOnG2+45NLQCq/DmzY7oEkzTlfETt2de89oSp2ZdPt6A
	sLDMAvyW/2LQaSiK/KJj247fKHJ0BIs3tq2Yl
X-Gm-Gg: AYBFou0ItDPk2g9h5AGl/ghcjjQPjWuxwQrDM6yIYD1NNngZkYkQQkR7Db+5/tM/32K
	mT+OU2OGaKWKtdCvMeMXTFaxpiURhnEytVd9I5CaJPi91JYuzlV+gu2m6hV4+TxPbBfxVceYmig
	Rd9YMZ3gcQHuEP7kjlnxeY0dQQZDtgz58AOv53EejsLiwmQOzkV7111fK2j3q+vgDtJOEM7VSUe
	MuIwu7NU2DpkN8eTIMHSl7cXQ5nkRXQP8U5VlAAU0H6HUgY1+Rgg8D8/CkyFK8bqdRdcEoMM7GH
	dfNghRo1VXLZytoGC0z5ZKIRp2CuaH7CD2mwIvLMzT9aLUi2tYRFqaQIYlA4Z3MACWGtc72wix6
	0OPsVnIRUQ1quAJU6rfAVP/Ps9zC6PqNY0i86Xoc=
X-Received: by 2002:a05:690e:4386:b0:66e:587a:5ce2 with SMTP id
 956f58d0204a3-6712456b8fdmr1535595d50.27.1789156019308; Fri, 11 Sep 2026
 12:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DLCQ0KQND9EO.2NFOQQ5PCPL9B@pm.me>
In-Reply-To: <DLCQ0KQND9EO.2NFOQQ5PCPL9B@pm.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 11 Sep 2026 15:46:47 -0400
X-Gm-Features: AcwNN1VlbQijeWY-EBEOKVI7W_STTxJH8pD4ko-LDVQtCnXbY_jkEGJC5IDrkJM
Message-ID: <CABBYNZ+dzfCRyrLNBFnkaGVs2nkz+y_Eqav6Q_2XN3Axxf59Kg@mail.gmail.com>
Subject: Re: Bluetooth: eSCO re-setup after HFP profile switch gets no
 Sync_Conn_Complete (Intel AX201/AX211, handle 257)
To: Caleb White <cdwhite3@pm.me>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Caleb,

On Fri, Sep 11, 2026 at 3:12=E2=80=AFPM Caleb White <cdwhite3@pm.me> wrote:
>
> Hello!
>
> After updating to both WirePlumber 0.5.17 and Linux 7.2.3, I started
> experiencing a weird issue with my Bose headset. I could reproduce the
> problem on two different laptops, so I had Grok dig into it and the
> following is the result:
>
> # Analysis
>
> After A2DP =E2=86=94 HFP profile switching, the controller keeps using eS=
CO handle
> 257 without sending HCI_Synchronous_Connection_Complete on the 2nd+ setup=
.
> The host then logs "SCO packet for unknown connection handle 257" and
> HFP capture dies after ~0.5s.
>
> This is not the sco_conn lifetime UAF. Patch "Bluetooth: SCO: serialise
> sco_conn lifetime against sco_recv_scodata()" does not fix it.
>
> ## Hardware
>
> Two System76 laptops, same Bose headset:
>
> 1. Intel AX201 USB 8087:0026, firmware intel/ibt-0040-4150.sfi 202-5.26
> 2. Intel AX211 USB 8087:0033, firmware intel/ibt-0180-0041.sfi 42-20.25
>
> Headset: Bose QC Ultra 2 HP, modalias bluetooth:v009Ep4082d082F, address =
68:F2:1F:03:3F:C9
>
> ## Software
>
> - Linux 7.1.9.arch1-2: good
> - Linux 7.2.3.arch1-3: bad when combined with WirePlumber 0.5.17
> - BlueZ 5.87-2 (unchanged)
> - PipeWire 1:1.6.8-1 (unchanged)
> - WirePlumber 0.5.15: good on both kernels
> - WirePlumber 0.5.17: good on 7.1.9, bad on 7.2.3
>
> Same-machine matrix (AX201):
>
> | kernel | WirePlumber | 12=C3=97 A2DP=E2=86=92HFP 4s pw-record    |
> |--------|-------------|------------------------------|
> | 7.1.9  | 0.5.15      | 12/12 pass                   |
> | 7.1.9  | 0.5.17      | 12/12 pass                   |
> | 7.2.3  | 0.5.15      | 12/12 pass                   |
> | 7.2.3  | 0.5.17      | 1/12 pass (first cycle only) |
>
> Failure only reproduces after a cold boot (or equivalent). Reloading
> btusb/bluetooth without reboot often "heals" it until the next reboot.
> Parked on HFP with no profile switch: capture is fine.
>
> Userspace trigger: WirePlumber 0.5.17 BlueZ monitor rewrite (cb92ef98 /
> issue #1013). Autoswitch Lua timeouts are unchanged vs 0.5.15.
>
> ## Reproducer
>
>     card=3Dbluez_card.<addr>
>     src=3Dbluez_input.<addr>
>
>     for i in $(seq 1 12); do
>       pactl set-card-profile "$card" a2dp-sink
>       sleep 1
>       pactl set-card-profile "$card" headset-head-unit
>       sleep 1
>       timeout 4 pw-record --target "$src" /tmp/cap$i.wav
>       ffprobe -v error -show_entries format=3Dduration -of csv=3Dp=3D0 /t=
mp/cap$i.wav
>     done
>
> Pass: duration =E2=89=A5 3s. Fail: ~0.04=E2=80=930.6s, then spa.bluez5 tr=
ansport error.
>
> ## HCI (btmon)
>
> First HFP open:
>
> - Enhanced Setup Synchronous Connection =E2=86=92 Command Status Success
> - Synchronous Connect Complete handle 257, eSCO, transparent, 60-byte pac=
kets
> - Capture succeeds (~4s)
>
> Tear-down (back to A2DP):
>
> - RFCOMM AT+CIEV: 2,0
> - HCI Disconnect handle 257 (reason 0x13)
> - Disconnect Complete (reason 0x16 Terminated By Local Host)
> - Kernel: hci_disconn_complete_evt =E2=86=92 hci_conn_del
>   deleting SCO type 2 (ESCO) state 9 (BT_CLOSED) handle 257
>
> Later HFP opens:
>
> - Enhanced Setup Synchronous Connection =E2=86=92 Command Status Success
> - **No Synchronous Connect Complete**
> - BR-ESCO data still arrives on handle 257
> - Kernel: "SCO packet for unknown connection handle 257"
> - Host still issues Disconnect 257 when switching back to A2DP
>
> One failing trace: 5 Enhanced Setup commands, 1 Sync_Conn_Complete.

This looks like a firmware bug, in my opinion. Even if the firmware
believes the connection is still active, it should have refused the
new connection attempt, so something is definitely off here. Btw, is
the same firmware being used across the different setups? It would be
really weird if it were some timing issue related to WirePlumber.

> Debug dump at miss time (conn hash): only ACL handle 256 (Bose) and LE
> handle 2048. **No SCO/eSCO hci_conn.** Firmware is still transmitting 257
> after the host deleted the object.
>
> ## What we tried
>
> - Binding unknown-handle SCO data to a pending BT_CONNECT SCO conn: never
>   fired; there is no pending SCO object when the packets arrive.
> - sco_conn lifetime serialisation patch: no change.

You tested the same version working with one version of WirePlumber
but failing with another which suggests the kernel shouldn't be the
culprit.

> ## Ask
>
> After Disconnect Complete on eSCO 257, the Intel controller reuses 257
> without Sync_Conn_Complete. Should the host:
>
> 1. refuse a new Enhanced Setup until 257 is really gone, or
> 2. treat incoming eSCO 257 as completing the pending setup even without t=
he event?
>
> I can attach the .btsnoop and reproduce on either laptop.
>
> WirePlumber report (userspace trigger):
> https://gitlab.freedesktop.org/pipewire/wireplumber/-/work_items/1013



--=20
Luiz Augusto von Dentz
