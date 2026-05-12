Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8D025FA29
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614726; cv=pass; b=JjRMUyTnmEERz/vKwhjYonXVdCEg9t/OvXVtbQS1kK7FAwIBL8AFJZvZUq4CXAusLLBmgoKTVTmUnNBWwXYs98JEjMnB7+Eii/incS7N3/h14g58JHxX+SmrgnuYBFTTqMLXq8lmVBd8Tbvaim8F9d6VlA9wTx9SeVrscbjeDWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614726; c=relaxed/simple;
	bh=mJIwUJswnf1lslZebqfJK2jCVXyb2jsmz/QYMQQTM6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yi705QF726+m31LEUEjFmsT3sajvW0CLiLVImaHhBYUZGH7iud6aZAWzQuqUWRHjzXzjZ1mMDWnRCR3pW0HYTzl7eBWfakPjEbmNGxr7Nqk11ISvGkLzFW4V+WymwuHGXD3yVrqSgOPUXzV+Z0eS5iOUi9x6eoYO3wEd9t8b9FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxIwe+Z1; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxIwe+Z1"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7b4ee3a88e1so61205007b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 12:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778614723; cv=none;
        d=google.com; s=arc-20240605;
        b=e8VOkBhEj3VCliaDMBT7UNHvGHvZpFNqCzuvDRi5x5rQdU6LeFtY4h4zvMtNpmQt4x
         jWAI/pS4W2az6s4dnxWQcQebYzY7ItWE+XsbOpym0hkx7bUJiBaUf5798WOKEJmHjj0U
         eyqJR0TIDppiRaaQngUEkY9usoAwjJDAcg/rmkSECfWtwJA2s+yReVfH0lJC73NB7NOO
         gRtB/0V1E6us3B8K7cK4Zo4FbtzQXJ1la/OIjBDdDEfnp88idOzcJV0V3medymj7wXrs
         p4A6Iubh/t+8rxPvfZuEWInr769Unm/hsHiuyssC0ry8bD+bJuRwK/+MpEl0zzdyQ7/N
         cXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=heGiDD6A2JTMp2vlYI4QmiGLJQ6/6IvhE8vucADMTy8=;
        fh=GRtG/n4BdQE7UAqYN4ZZovkAcxFXQCvi60V+kvrIB1E=;
        b=HjiuPWFndWW8H47On7yZH8Aa623CHXKwQ708Ppo8t5qvXXll0IMnQvWsPJAaTt6lBD
         cgBTU8Gys1zBS9lgRBCM97cn9JHbtTYwYHv++In2TyOnHkK34WcFFaunVPaH1Jvly8ua
         /BsG35aycvTqUOVR3qB66UrWpkVAjHcD1tRQIGg8EUg0iir6DMktJcRc/+xhesnC7L7h
         8adEeR11TTvw1IxZUHEoo0tPiZ95pUrs+VjJhdkN6jAlUSWsDsoofPOPUeIe1hopV1sw
         iyglZ+gBkC3/SDQJhmXEBRPBWz8EaHrXMXN154hrYV9AlwAceESOOSvyKFgwNRqCUHvf
         i+Dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778614723; x=1779219523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heGiDD6A2JTMp2vlYI4QmiGLJQ6/6IvhE8vucADMTy8=;
        b=CxIwe+Z1lws1iWtHrTD3XkZM0cq9Btlq9qj/8/traz2g33JX1VYyZ3cocMsrE8NK3I
         3mvVZ5bIuHgD4PH+jYlURMvwFK1e/Y/y0bYlJ9DdcYP9oCBCdV2SS/yYoPkT+NA3tCGD
         BvC0GlQA4hwF+wgrX7k7hEWCKSaxR8q4DeXdmLqQgbAiTOoA/3VrbPN0qGCiR2cbQXu5
         CLHD9Cpn4/6hrx8uZuSDrhHJ5GYS2/86ocQlq8NJc57S8ZwHLO+eI6HrOG2M6sHJBrdm
         UA2yjrxqLkBkgWPMWISZZ1Dsrrq7HuE6oIIG5DMXkPtMcKGw//H4lH45gIggHzyLCKzB
         GWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778614723; x=1779219523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=heGiDD6A2JTMp2vlYI4QmiGLJQ6/6IvhE8vucADMTy8=;
        b=jxH+FlUyqX7g2fTh2I2TYPzpU7VqAln87p+3e6jiXPKueyKCMEjpupIUnWIIcGKv3g
         FNA8nGGntGHEddReCGWip4WGO/f5yeAlllbTbyq/pDFJLXTYw0YgByM3X9n7aCNua4D2
         PvnaI7qDesrmAjJAmeSi7cNjIDYeePV6mTevOJfxkVVdbd5SrC7v+QSAGZ+UTWfWe200
         joeyrC/9t6zG+WZAtN9oVt4+haNyBx481hLU75OZvdGMjj/dJimbYnk7y/1ZXIw7MBAW
         DkJzuT2OJYYjy/uWWr7wNs2do7jOz/SXvkl8LAIOgh2VqackKmqyzeb2MdeXWgdVO9DO
         nhyw==
X-Forwarded-Encrypted: i=1; AFNElJ/lm/WnNau8n/x/2YweObxrz2mIKcv6eZTmQz/LUcZ3K9bA4+gEbQjwrndLemuasbSnksdpNVyIG+McDWigTTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDeGm2j7Eh9G3rGSj0zTOkQmBNYNcV02OLiUy03Z4qEUe9/Lio
	UFzOzN9BZ3Kas3IjodQn4STmsVTpDT+MWTMbZuc9fYe+BxNitR1IcwDDxK024by7UsO/Kq0csyH
	xYYruZg/IUiyO9NNGsbeCFeziPNTzIHyt0w+MYnY60g==
X-Gm-Gg: Acq92OEAUm7Yf0oBNOBaLlwIl/IhYlaWgQrOXYu8/sWyuxbtsWI9BwMlNwT+5FYnbJ3
	eSE6Shtq8By3OtxSahbduFzSGQRBmBJaJc2QfaxAzR3Ixu1bYoKS6xcdxn+l+6risMZdt/N6bOw
	iUYEePHElkzLR3xSI0OTOhAnQKHW0/pd8K6rIo+BoKBgX9Ec/IK3rSm+zGGpHwk+xxWeh+2DhND
	TP0hNHQ3uctXLh2cCE2eejakHRNoTsSo9V+HIAfk3WJymYkXHzoTYMYAeIa8FSl7lzmidOOXexZ
	vIgcUo0NTPuU6GojWboRAeXfuUOPduMq8C4alsuXFtIijSe/mkBGCnqj8r2APnowm69CZw==
X-Received: by 2002:a53:accf:0:10b0:656:30a1:70e2 with SMTP id
 956f58d0204a3-65df621923cmr325657d50.6.1778614723259; Tue, 12 May 2026
 12:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511132131.1283892-1-hadess@hadess.net> <177861361154.3045511.1045324340041670862.git-patchwork-notify@kernel.org>
In-Reply-To: <177861361154.3045511.1045324340041670862.git-patchwork-notify@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 12 May 2026 15:38:30 -0400
X-Gm-Features: AVHnY4LVUbNQwaz19JuXQhWrLj2gtFTnimrrv0scxotBkr_FhXgx24VGiLcOE40
Message-ID: <CABBYNZ+RZH25K0jhRsrTbYOZxQQeV9EvxYK907sgGW0Ot-mR3Q@mail.gmail.com>
Subject: Re: [BlueZ v3 0/6] Add helper for "cleanup" variable attribute
To: patchwork-bot+bluetooth@kernel.org
Cc: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Tue, May 12, 2026 at 3:21=E2=80=AFPM <patchwork-bot+bluetooth@kernel.org=
> wrote:
>
> Hello:
>
> This series was applied to bluetooth/bluez.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Mon, 11 May 2026 15:18:03 +0200 you wrote:
> > As discussed in:
> > https://lore.kernel.org/linux-bluetooth/ed949f2550f79a4bef19bd482bf8b06=
9ad5b7e0c.camel@hadess.net/
> >
> > Implement a cleanup helper.
> >
> > The MIN/MAX fix is here because it touches the same hunk in src/main.c
> > as the other patches. Feel free to pick it up straight away while the
> > rest is discussed.
> >
> > [...]
>
> Here is the summary with links:
>   - [BlueZ,v3,1/6] all: Remove more unneeded MIN/MAX macro definition
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dca2b39b0c08e
>   - [BlueZ,v3,2/6] shared/util: Add helper for "cleanup" variable attribu=
te
>     (no matching commit)
>   - [BlueZ,v3,3/6] doc: Recommend using _cleanup_ and friends
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D9ba6c13df5fb
>   - [BlueZ,v3,4/6] main: Use _cleanup_() to simplify configuration parsin=
g
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D140e3569295c
>   - [BlueZ,v3,5/6] client: Use _cleanup_fd_ to simplify urandom access
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3De33f5027b898
>   - [BlueZ,v3,6/6] btattach: Use _cleanup_fd_ to simplify error paths
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D02aa9a8cfe6a
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html

We will probably need to revert the cleanup changes, they are causing
crashes and other problems when run under Valgrind.

bluetoothd[941151]: src/main.c:parse_config() parsing src/main.conf
=3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
=3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
=3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.0.=
8400.4)
=3D=3D941151=3D=3D    by 0x4003098: parse_config_hex (main.c:961)
=3D=3D941151=3D=3D    by 0x4003098: parse_general (main.c:1058)
=3D=3D941151=3D=3D    by 0x4003098: parse_config (main.c:1341)
=3D=3D941151=3D=3D    by 0x4003098: main (main.c:1616)
=3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
=3D=3D941151=3D=3D  in frame #2, created by main (main.c:1570)
=3D=3D941151=3D=3D
=3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
=3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
=3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.0.=
8400.4)
=3D=3D941151=3D=3D    by 0x40F17EE: parse_config_int (main.c:467)
=3D=3D941151=3D=3D    by 0x40F1ECD: parse_config_u32.constprop.0.isra.0 (ma=
in.c:848)
=3D=3D941151=3D=3D    by 0x40030BD: parse_general (bluetooth.c:4925)
=3D=3D941151=3D=3D    by 0x40030BD: parse_config (main.c:1341)
=3D=3D941151=3D=3D    by 0x40030BD: main (main.c:1616)
=3D=3D941151=3D=3D  Address 0x1fff000050 is on thread 1's stack
=3D=3D941151=3D=3D  in frame #2, created by parse_config_int (main.c:465)
=3D=3D941151=3D=3D
=3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
=3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
=3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.0.=
8400.4)
=3D=3D941151=3D=3D    by 0x4004C89: parse_device_id (main.c:974)
=3D=3D941151=3D=3D    by 0x4004C89: parse_general (main.c:1067)
=3D=3D941151=3D=3D    by 0x4004C89: parse_config (main.c:1341)
=3D=3D941151=3D=3D    by 0x4004C89: main (main.c:1616)
=3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
=3D=3D941151=3D=3D  in frame #2, created by main (main.c:1570)
=3D=3D941151=3D=3D
bluetoothd[941151]: src/main.c:parse_config_string() General.ControllerMode=
 =3D le
bluetoothd[941151]: GLib: g_error_free: assertion 'error !=3D NULL' failed
bluetoothd[941151]: ++++++++ backtrace ++++++++
bluetoothd[941151]: #1  log_handler+0x4e (src/main.c:1418) [0x40f0ffe]
bluetoothd[941151]: #2  g_logv+0x247
(/usr/lib64/libglib-2.0.so.0.8400.4) [0x4cc5477]
bluetoothd[941151]: #3  g_log+0x93
(/usr/lib64/libglib-2.0.so.0.8400.4) [0x4cc5803]
bluetoothd[941151]: #4  parse_config_string+0x60 (src/main.c:208) [0x40f140=
0]
bluetoothd[941151]: #5  main+0x4a2 (src/main.c:988) [0x4003262]
bluetoothd[941151]: #6  __libc_start_call_main+0x75
(/usr/lib64/libc.so.6) [0x4f90575]
bluetoothd[941151]: #7  __libc_start_main@@GLIBC_2.34+0x88
(/usr/lib64/libc.so.6) [0x4f90628]
bluetoothd[941151]: #8  _start+0x25
(/home/vudentz/git/bluez/src/bluetoothd) [0x40054c5]
bluetoothd[941151]: +++++++++++++++++++++++++++
=3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
=3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
=3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.0.=
8400.4)
=3D=3D941151=3D=3D    by 0x4003311: parse_ctrl_mode (bluetooth.c:5033)
=3D=3D941151=3D=3D    by 0x4003311: parse_general (main.c:1074)
=3D=3D941151=3D=3D    by 0x4003311: parse_config (main.c:1341)
=3D=3D941151=3D=3D    by 0x4003311: main (main.c:1616)
=3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
=3D=3D941151=3D=3D  in frame #2, created by main (bluetooth.c:1570)
=3D=3D941151=3D=3D
=3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
=3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
=3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.0.=
8400.4)
=3D=3D941151=3D=3D    by 0x40F17EE: parse_config_int (main.c:467)
=3D=3D941151=3D=3D    by 0x40F20C2: parse_config_u16.isra.0 (main.c:863)
=3D=3D941151=3D=3D    by 0x4003349: parse_general (bluetooth.c:2985)
=3D=3D941151=3D=3D    by 0x4003349: parse_config (main.c:1341)
=3D=3D941151=3D=3D    by 0x4003349: main (main.c:1616)
=3D=3D941151=3D=3D  Address 0x1fff000050 is on thread 1's stack
=3D=3D941151=3D=3D  in frame #2, created by parse_config_int (main.c:465)
=3D=3D941151=3D=3D
=3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
=3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
=3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.0.=
8400.4)
=3D=3D941151=3D=3D    by 0x4004F55: parse_multi_profile (main.c:996)
=3D=3D941151=3D=3D    by 0x4004F55: parse_general (main.c:1078)
=3D=3D941151=3D=3D    by 0x4004F55: parse_config (main.c:1341)
=3D=3D941151=3D=3D    by 0x4004F55: main (main.c:1616)
=3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
=3D=3D941151=3D=3D  in frame #2, created by main (main.c:1570)
=3D=3D941151=3D=3D
=3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
=3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
=3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.0.=
8400.4)
=3D=3D941151=3D=3D    by 0x40F15D4: parse_privacy (main.c:910)
=3D=3D941151=3D=3D    by 0x40033F9: parse_general (main.c:1081)
=3D=3D941151=3D=3D    by 0x40033F9: parse_config (main.c:1341)
=3D=3D941151=3D=3D    by 0x40033F9: main (main.c:1616)
=3D=3D941151=3D=3D  Address 0x1fff000098 is on thread 1's stack
=3D=3D941151=3D=3D  in frame #2, created by parse_privacy (main.c:909)
=3D=3D941151=3D=3D
=3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
=3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
=3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.0.=
8400.4)
=3D=3D941151=3D=3D    by 0x40047B5: parse_repairing (main.c:947)
=3D=3D941151=3D=3D    by 0x40047B5: parse_general (main.c:1082)
=3D=3D941151=3D=3D    by 0x40047B5: parse_config (main.c:1341)
=3D=3D941151=3D=3D    by 0x40047B5: main (main.c:1616)
=3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
=3D=3D941151=3D=3D  in frame #2, created by main (main.c:1570)
=3D=3D941151=3D=3D
=3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
=3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
=3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.0.=
8400.4)
=3D=3D941151=3D=3D    by 0x40049FF: parse_secure_conns (bluetooth.c:1597)
=3D=3D941151=3D=3D    by 0x40049FF: parse_general (main.c:1088)
=3D=3D941151=3D=3D    by 0x40049FF: parse_config (main.c:1341)
=3D=3D941151=3D=3D    by 0x40049FF: main (main.c:1616)
=3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
=3D=3D941151=3D=3D  in frame #2, created by main (bluetooth.c:1570)
=3D=3D941151=3D=3D
bluetoothd[941151]: src/main.c:parse_config_bool() General.Experimental =3D=
 true
bluetoothd[941151]: GLib: g_error_free: assertion 'error !=3D NULL' failed
bluetoothd[941151]: ++++++++ backtrace ++++++++
bluetoothd[941151]: #1  log_handler+0x4e (src/main.c:1418) [0x40f0ffe]
bluetoothd[941151]: #2  g_logv+0x247
(/usr/lib64/libglib-2.0.so.0.8400.4) [0x4cc5477]
bluetoothd[941151]: #3  g_log+0x93
(/usr/lib64/libglib-2.0.so.0.8400.4) [0x4cc5803]
bluetoothd[941151]: #4  parse_config_bool.isra.0+0x64 (src/main.c:208)
[0x40f1f64]
bluetoothd[941151]: #5  main+0x7c0 (src/main.c:1089) [0x4003580]
bluetoothd[941151]: #6  __libc_start_call_main+0x75
(/usr/lib64/libc.so.6) [0x4f90575]
bluetoothd[941151]: #7  __libc_start_main@@GLIBC_2.34+0x88
(/usr/lib64/libc.so.6) [0x4f90628]
bluetoothd[941151]: #8  _start+0x25
(/home/vudentz/git/bluez/src/bluetoothd) [0x40054c5]
bluetoothd[941151]: +++++++++++++++++++++++++++
bluetoothd[941151]: src/main.c:parse_config_string()
General.KernelExperimental =3D 6fbaf188-05e0-496a-9885-d6ddfdb4e03e
bluetoothd[941151]: GLib: g_error_free: assertion 'error !=3D NULL' failed
bluetoothd[941151]: ++++++++ backtrace ++++++++
bluetoothd[941151]: #1  log_handler+0x4e (src/main.c:1418) [0x40f0ffe]
bluetoothd[941151]: #2  g_logv+0x247
(/usr/lib64/libglib-2.0.so.0.8400.4) [0x4cc5477]
bluetoothd[941151]: #3  g_log+0x93
(/usr/lib64/libglib-2.0.so.0.8400.4) [0x4cc5803]
bluetoothd[941151]: #4  parse_config_string+0x60 (src/main.c:208) [0x40f140=
0]
bluetoothd[941151]: #5  main+0x816 (src/main.c:1032) [0x40035d6]
bluetoothd[941151]: #6  __libc_start_call_main+0x75
(/usr/lib64/libc.so.6) [0x4f90575]
bluetoothd[941151]: #7  __libc_start_main@@GLIBC_2.34+0x88
(/usr/lib64/libc.so.6) [0x4f90628]
bluetoothd[941151]: #8  _start+0x25
(/home/vudentz/git/bluez/src/bluetoothd) [0x40054c5]
bluetoothd[941151]: +++++++++++++++++++++++++++
bluetoothd[941151]: src/main.c:btd_parse_kernel_experimental()
6fbaf188-05e0-496a-9885-d6ddfdb4e03e
=3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
=3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
=3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.0.=
8400.4)
=3D=3D941151=3D=3D    by 0x4003607: parse_kernel_exp (main.c:1030)
=3D=3D941151=3D=3D    by 0x4003607: parse_general (main.c:1093)
=3D=3D941151=3D=3D    by 0x4003607: parse_config (main.c:1341)
=3D=3D941151=3D=3D    by 0x4003607: main (main.c:1616)
=3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
=3D=3D941151=3D=3D  in frame #2, created by main (main.c:1570)
=3D=3D941151=3D=3D
=3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
=3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
=3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.0.=
8400.4)
=3D=3D941151=3D=3D    by 0x40F17EE: parse_config_int (main.c:467)
=3D=3D941151=3D=3D    by 0x40F19B8: parse_mode_config (main.c:552)
=3D=3D941151=3D=3D    by 0x40036D5: parse_le_config (bluetooth.c:2879)
=3D=3D941151=3D=3D    by 0x40036D5: parse_config (main.c:1343)
=3D=3D941151=3D=3D    by 0x40036D5: main (main.c:1616)
=3D=3D941151=3D=3D  Address 0x1fff000020 is on thread 1's stack
=3D=3D941151=3D=3D  in frame #2, created by parse_config_int (main.c:465)
=3D=3D941151=3D=3D
=3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
=3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
=3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.0.=
8400.4)
=3D=3D941151=3D=3D    by 0x4004C4B: parse_gatt_cache (main.c:1103)
=3D=3D941151=3D=3D    by 0x4004C4B: parse_gatt (main.c:1171)
=3D=3D941151=3D=3D    by 0x4004C4B: parse_config (main.c:1344)
=3D=3D941151=3D=3D    by 0x4004C4B: main (main.c:1616)
=3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
=3D=3D941151=3D=3D  in frame #2, created by main (main.c:1570)
=3D=3D941151=3D=3D
=3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
=3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
=3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.0.=
8400.4)
=3D=3D941151=3D=3D    by 0x40F17EE: parse_config_int (main.c:467)
=3D=3D941151=3D=3D    by 0x40F2072: parse_config_u8.isra.0 (main.c:878)
=3D=3D941151=3D=3D    by 0x40037E5: parse_gatt (bluetooth.c:2847)
=3D=3D941151=3D=3D    by 0x40037E5: parse_config (main.c:1344)
=3D=3D941151=3D=3D    by 0x40037E5: main (main.c:1616)
=3D=3D941151=3D=3D  Address 0x1fff000050 is on thread 1's stack
=3D=3D941151=3D=3D  in frame #2, created by parse_config_int (main.c:465)
=3D=3D941151=3D=3D
bluetoothd[941151]: src/main.c:parse_config_string()
GATT.ExportClaimedServices =3D read-write
bluetoothd[941151]: GLib: g_error_free: assertion 'error !=3D NULL' failed
bluetoothd[941151]: ++++++++ backtrace ++++++++
bluetoothd[941151]: #1  log_handler+0x4e (src/main.c:1418) [0x40f0ffe]
bluetoothd[941151]: #2  g_logv+0x247
(/usr/lib64/libglib-2.0.so.0.8400.4) [0x4cc5477]
bluetoothd[941151]: #3  g_log+0x93
(/usr/lib64/libglib-2.0.so.0.8400.4) [0x4cc5803]
bluetoothd[941151]: #4  parse_config_string+0x60 (src/main.c:208) [0x40f140=
0]
bluetoothd[941151]: #5  main+0xae3 (src/main.c:1132) [0x40038a3]
bluetoothd[941151]: #6  __libc_start_call_main+0x75
(/usr/lib64/libc.so.6) [0x4f90575]
bluetoothd[941151]: #7  __libc_start_main@@GLIBC_2.34+0x88
(/usr/lib64/libc.so.6) [0x4f90628]
bluetoothd[941151]: #8  _start+0x25
(/home/vudentz/git/bluez/src/bluetoothd) [0x40054c5]
bluetoothd[941151]: +++++++++++++++++++++++++++
=3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
=3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
=3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.0.=
8400.4)
=3D=3D941151=3D=3D    by 0x400395E: parse_gatt_export (main.c:1129)
=3D=3D941151=3D=3D    by 0x400395E: parse_gatt (main.c:1178)
=3D=3D941151=3D=3D    by 0x400395E: parse_config (main.c:1344)
=3D=3D941151=3D=3D    by 0x400395E: main (main.c:1616)
=3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
=3D=3D941151=3D=3D  in frame #2, created by main (main.c:1570)
=3D=3D941151=3D=3D
=3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
=3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
=3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.0.=
8400.4)
=3D=3D941151=3D=3D    by 0x40040AD: parse_gatt_seclevel (main.c:1157)
=3D=3D941151=3D=3D    by 0x40040AD: parse_gatt (main.c:1179)
=3D=3D941151=3D=3D    by 0x40040AD: parse_config (main.c:1344)
=3D=3D941151=3D=3D    by 0x40040AD: main (main.c:1616)
=3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
=3D=3D941151=3D=3D  in frame #2, created by main (main.c:1570)
=3D=3D941151=3D=3D
=3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
=3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
=3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.0.=
8400.4)
=3D=3D941151=3D=3D    by 0x4004A1E: parse_csis_sirk (bluetooth.c:1593)
=3D=3D941151=3D=3D    by 0x4004A1E: parse_csis (main.c:1197)
=3D=3D941151=3D=3D    by 0x4004A1E: parse_config (main.c:1345)
=3D=3D941151=3D=3D    by 0x4004A1E: main (main.c:1616)
=3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
=3D=3D941151=3D=3D  in frame #2, created by main (bluetooth.c:1570)
=3D=3D941151=3D=3D
=3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
=3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
=3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.0.=
8400.4)
=3D=3D941151=3D=3D    by 0x4004A3D: parse_avdtp_session_mode (main.c:1276)
=3D=3D941151=3D=3D    by 0x4004A3D: parse_avdtp (main.c:1310)
=3D=3D941151=3D=3D    by 0x4004A3D: parse_config (main.c:1346)
=3D=3D941151=3D=3D    by 0x4004A3D: main (main.c:1616)
=3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
=3D=3D941151=3D=3D  in frame #2, created by main (main.c:1570)
=3D=3D941151=3D=3D
=3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
=3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
=3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.0.=
8400.4)
=3D=3D941151=3D=3D    by 0x4004A5C: parse_avdtp_stream_mode (main.c:1293)
=3D=3D941151=3D=3D    by 0x4004A5C: parse_avdtp (main.c:1311)
=3D=3D941151=3D=3D    by 0x4004A5C: parse_config (main.c:1346)
=3D=3D941151=3D=3D    by 0x4004A5C: main (main.c:1616)
=3D=3D941151=3D=3D  Address 0x1fff000100 is on thread 1's stack
=3D=3D941151=3D=3D  in frame #2, created by main (main.c:1570)
=3D=3D941151=3D=3D
=3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
=3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
=3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.0.=
8400.4)
=3D=3D941151=3D=3D    by 0x4004417: parse_cs_role (bluetooth.c:943)
=3D=3D941151=3D=3D    by 0x4004417: parse_le_cs_config (main.c:1264)
=3D=3D941151=3D=3D    by 0x4004417: parse_config (main.c:1348)
=3D=3D941151=3D=3D    by 0x4004417: main (main.c:1616)
=3D=3D941151=3D=3D  Address 0x1fff0000f8 is on thread 1's stack
=3D=3D941151=3D=3D  in frame #2, created by main (bluetooth.c:1570)
=3D=3D941151=3D=3D
=3D=3D941151=3D=3D Invalid free() / delete / delete[] / realloc()
=3D=3D941151=3D=3D    at 0x4BADE43: free (vg_replace_malloc.c:990)
=3D=3D941151=3D=3D    by 0x4CC0444: g_free (in /usr/lib64/libglib-2.0.so.0.=
8400.4)
=3D=3D941151=3D=3D    by 0x40044FB: parse_config_signed_int (main.c:501)
=3D=3D941151=3D=3D    by 0x40044FB: parse_le_cs_config (main.c:1269)
=3D=3D941151=3D=3D    by 0x40044FB: parse_config (main.c:1348)
=3D=3D941151=3D=3D    by 0x40044FB: main (main.c:1616)
=3D=3D941151=3D=3D  Address 0x1fff0000f8 is on thread 1's stack
=3D=3D941151=3D=3D  in frame #2, created by main (main.c:1570)
=3D=3D941151=3D=3D
--=20
Luiz Augusto von Dentz
