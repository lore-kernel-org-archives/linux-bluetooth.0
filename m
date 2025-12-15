Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771C8336EDA
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765812810; cv=none; b=pXJE+VJWSp9B94ehtzIzs2jCbYJ6PMFFTZC8HXfWRb8l5huLpB2V9xvqm31FwO/BbL75QOMgMls3GyU9XLwh2n/LCAYciEDdmHdcO13qcnv43onNpk3UmANAb3o5uDHWKBSBeUWRfS3EBnO5qfPOPklTmS4jUMr8qiDrqLB4F9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765812810; c=relaxed/simple;
	bh=BtIGEQlD6h5cO3a+NrhSgUbypV+6YeK0OanYCc0uajk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQKfwXkHQA5uMl6h7iS4HyvdT+7UgRvUd9asO9UULKWvRkx7b7lj2ZLlV4nnDnvMSKk3f7b/ZArQkOnBWJ1XcO6luWvEgx4sUUm/vTUlxgd31yBOvjKuvG8dc0cjjAIM9pGPWW4zazCQQA1Wvr/1LHGSPpsq26ncG+Ew3nNSWIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eu6y4NSR; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eu6y4NSR"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64467071f9fso2893557d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 07:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765812806; x=1766417606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KuyZxRzyeow3xL6WWxBCqcfsPJNCAAyl3j9FjILwerQ=;
        b=Eu6y4NSRHcrJ6g4T9nysu85JrnSUwTP0uH2fBlKAIWslgre+q8wtafp9Gnbqb2qHoh
         ff77WgpvqGROVDXkL6S7ZKcv7eDLvhP+fcliaVVaLgE1sNnRLCKfsnIZmfBmmKlSYea+
         xYv857cqWy1FoWx9iIGE+W/kvPGSOISnvH6eveVUZA6V2VtT1dfOYn/qnxv95kyrMBZW
         hABTiYQ06BckfXfkYDD2htFgeBjBudqjIlzFqz5ofu9XWGl7LeDL4i5jAqoR4KW0C/Q1
         6I5U4Am/UvLs31Q5sD7R1X0iWAMx5PG4FRcTPDarFwd9AyttdJXNZQkPBUIg7e3a6RiR
         z8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765812806; x=1766417606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuyZxRzyeow3xL6WWxBCqcfsPJNCAAyl3j9FjILwerQ=;
        b=ATgkJFxR68dPiWmpSc+QTLf366uS67Pz+y820KFH3ajDWogWlJ8/bR7F2tjmytjlo4
         T3BCwRUf0ceot60KFV2BVDWx4OZCGdXTCTpDLJ4KDcdQlnCwVeQHmgYErYk7jJdyXOST
         81VSzg75Nc3/MMfmCRVoqLX5n4lTV43iy6Ag6ecnnOqEhGbmRrJUHnmkEYtub9zLktNo
         EQCwR/iTja1sv7PNV7jM7dhBlZSvSSX0uF3X7+5vDhLsw5+FF5+KOUD9+rLi+4O2DLx/
         lrZaaHt4XXZNa8MTTHQKmoRUcmAgFL597Lz9xBJhlF09u71Rtygwua2XLfcKXVNA4uiw
         iwGg==
X-Gm-Message-State: AOJu0YxLV7nJbTUPGoh7xn0/7c3izpYQTJ0H3XnDRUU+9rQIsNrSMch0
	Leztidq1xvIgl0jaon5PY3j58nz4vFDhVg4oB0xcmhprSr6M2YM9WzFkIC1W+IqpLdBZoD/4vyP
	czITz8eikPRZAMPz+N/yHw/ILDWnG81NqBtuP//I=
X-Gm-Gg: AY/fxX5+hxLutWy1WSzBVMpBHRYvXzj38CwjOqD3PVKzz14dia1OSreYbkJe/ZVUfR/
	iGIt21ucNNOKoYRZ2ByjYMfgsxmL5l0A43RYKuoQHnkOC72KFW/UYaXpmU2yL+j15kQz26r39wN
	gS8yJ1tV42BcxaketIy86S27f20i/Tj+NRFVLa9LsP1HumHJb3tZuuz2hBUCDBdv2KCy4hXKQ77
	fJJgW92VjwhxP338zBbzbd0iMb9/TLM7IohlitcLRNa/hheRT49FR3USFwYEcvmL9VVPrWoWwHq
	bZEY4w==
X-Google-Smtp-Source: AGHT+IHngdJQzCRSVCpbM4yH6We6god54VlRS5jdRzdXk5nIrBjdoDWTCFaMiQQs1H/NXFywf0r5Z3Z8yB4K7u3mkTM=
X-Received: by 2002:a05:690c:4a13:b0:783:7143:d825 with SMTP id
 00721157ae682-78e66b5bbf3mr92599087b3.25.1765812805517; Mon, 15 Dec 2025
 07:33:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215140203.638669-1-arkadiusz.bokowy@gmail.com> <CABBYNZ+bgaa4znWcjW_n_3n3_oKbPsptg0K80eZU8iQwR81kVA@mail.gmail.com>
In-Reply-To: <CABBYNZ+bgaa4znWcjW_n_3n3_oKbPsptg0K80eZU8iQwR81kVA@mail.gmail.com>
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Date: Mon, 15 Dec 2025 16:33:14 +0100
X-Gm-Features: AQt7F2rwRK4shyQw-INNEv7ObwZv4h2k7j21ELWUEHoOKrmv0eNoNlUPX96xi5M
Message-ID: <CAGFh0265yqFi=Jm2VOSxG4pdy+FKxvnFr5F_+wesB1dwW1nDLA@mail.gmail.com>
Subject: Re: [PATCH] client/player: Refcount registered endpoints
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Do you have a backtrace or something? We don't reference struct
> endpoint across different adapters afaik so this might be a different
> bug or something.

> [bluetoothctl]> endpoint.register 0000110a-0000-1000-8000-00805f9b34fb 0x00 '0xFF 0xFF 0x02 0x40'
> [/local/endpoint/ep0] Enter Metadata (value/no): no
> [/local/endpoint/ep0] Auto Accept (yes/no): no
> [/local/endpoint/ep0] Max Transports (auto/value): auto
> [/local/endpoint/ep0] Locations: 0
> [/local/endpoint/ep0] Supported Context (value): 0
> [/local/endpoint/ep0] Context (value): 0
> [/local/endpoint/ep0] CIG (auto/value): auto
> [/local/endpoint/ep0] CIS (auto/value): auto
> Capabilities:
>   ff ff 02 40                                      ...@
> Capabilities:
>   ff ff 02 40                                      ...@
> Endpoint /local/endpoint/ep0 registered
> Endpoint /local/endpoint/ep0 registered
> [bluetoothctl]> endpoint.unregister /local/endpoint/ep0
> Endpoint /local/endpoint/ep0 unregistered
> [bluetoothctl]>
> Program received signal SIGSEGV, Segmentation fault.
> Download failed: Invalid argument.  Continuing without source file ./string/../sysdeps/x86_64/multiarch/strlen-avx2.S.
> __strlen_avx2 () at ../sysdeps/x86_64/multiarch/strlen-avx2.S:76
> warning: 76     ../sysdeps/x86_64/multiarch/strlen-avx2.S: No such file or directory
> (gdb) bt
> #0  __strlen_avx2 () at ../sysdeps/x86_64/multiarch/strlen-avx2.S:76
> #1  0x00007ffff7a6f980 in __printf_buffer (buf=buf@entry=0x7fffffffc7a0, format=format@entry=0x5555555afbd3 "Endpoint %s unregistered\n", ap=ap@entry=0x7fffffffc8b0, mode_f
>     at ./stdio-common/vfprintf-process-arg.c:443
> #2  0x00007ffff7a70788 in __vfprintf_internal (s=0x7ffff7c355c0 <_IO_2_1_stdout_>, format=format@entry=0x5555555afbd3 "Endpoint %s unregistered\n", ap=ap@entry=0x7fffffffc8
>     at ./stdio-common/vfprintf-internal.c:1543
> #3  0x00007ffff7b45489 in ___vfprintf_chk (fp=<optimized out>, flag=flag@entry=2, format=format@entry=0x5555555afbd3 "Endpoint %s unregistered\n", ap=ap@entry=0x7fffffffc8b
> #4  0x00005555555a90bf in vprintf (__fmt=0x5555555afbd3 "Endpoint %s unregistered\n", __ap=0x7fffffffc8b0) at /usr/include/x86_64-linux-gnu/bits/stdio2.h:156
> #5  bt_shell_printf (fmt=fmt@entry=0x5555555afbd3 "Endpoint %s unregistered\n") at ../src/shared/shell.c:741
> #6  0x0000555555587739 in unregister_endpoint_reply (message=0x5555562c2990, user_data=0x5555562b9c00) at ../client/player.c:3738
> #7  unregister_endpoint_reply (message=0x5555562c2990, user_data=0x5555562b9c00) at ../client/player.c:3724
> #8  0x00005555555a1516 in method_call_reply (call=<optimized out>, user_data=0x5555562c2270) at ../gdbus/client.c:1075
> #9  0x00007ffff7e037c2 in ?? () from /lib/x86_64-linux-gnu/libdbus-1.so.3
> #10 0x00007ffff7e07dfe in dbus_connection_dispatch () from /lib/x86_64-linux-gnu/libdbus-1.so.3
> #11 0x000055555559c828 in message_dispatch (data=0x5555562a8890) at ../gdbus/mainloop.c:59
> #12 0x00007ffff7e9fbfb in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #13 0x00007ffff7ea1237 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #14 0x00007ffff7ea15d7 in g_main_loop_run () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #15 0x00005555555ab7f9 in mainloop_run () at ../src/shared/mainloop-glib.c:65
> #16 0x00005555555abbfa in mainloop_run_with_signal (func=func@entry=0x5555555a8880 <signal_callback>, user_data=user_data@entry=0x0) at ../src/shared/mainloop-notify.c:196
> #17 0x00005555555aa655 in bt_shell_run () at ../src/shared/shell.c:1476
> #18 0x000055555556f418 in main (argc=<optimized out>, argv=0x7fffffffcef8) at ../client/main.c:3960

The bug is caused by freeing the endpoint on the first reply from
deregistration. When the second one (or another if you have 3, 4, 5..
etc. adapters) arrieves you have access after free. Simple refcount
should fix that, but of course there might be other approaches.
