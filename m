Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBAA1C28E
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766500867; cv=none; b=By7YCqwWwI+/XqTOWoxUJrrA0lCb+4q9xaMnX5kEGRvqVu3M5b19VQX7jbENVvBMb6PRrGJRp5G4gOXtKJJ7Etez2oRTG1x1yZg041Z/ANIX4pJrgcBn6wETwf0phSpXVmzfAnKemLPRt8tH7O4wmnbVf5yGJpqXoVy79mmAdoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766500867; c=relaxed/simple;
	bh=n8t6f5cTFfyrCUABlUpSV1yyG7f0cEHhKr9XScvkM4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BlOmFNpjuaFBKncKVfKEZivshz4VPHpaGvuKR3eRlE66rm5+q0vNpC3nUctdI+TjGDdnMmSX4IfI0An3Hgv94Y8a5N9PfBRDHtkNWMO+vTdiWuksRx5DvuruxduZ5efQPpBSO+1aqX9Wa7ksmxx7PaEcteHknanZp1ch5H/zcL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mM1rJx/0; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mM1rJx/0"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78e7ba9fc29so44887127b3.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 06:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766500865; x=1767105665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29cQ1btd2eeISv+c3HBjevU4tv/nl8Pc5aMDrFDqwFw=;
        b=mM1rJx/0yc4XHmWHxCz+vgz6QLmYfZB/nzgbIQh0Th+xCrnruI1gYsn1A9cnatkkSP
         TY1aLVnC5/jfOfkCjckdwuVhCQI0WzJUUOdEbTSDasXDugWtzG6K8Gdf6//MkzihtvhY
         2Nd+s+ZRc7ULH/SDDZi5TKgxIfyOfAjeCQGHTuBkF2tNIFZVFEfXvRB+36uVGgkkipCd
         yrQX75NmCi/VFRLVlLO/SeOBVP5WygoT3jfGf0JtN5XLdyY/xon97zVf6PNIvObeuEF8
         ftjZxgU5G7bkgrbFyCjhy9mwblUpuuJZtBGTsXJyoaTcGIr/UDaOveVu+oTXbtxkhNYK
         JeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766500865; x=1767105665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=29cQ1btd2eeISv+c3HBjevU4tv/nl8Pc5aMDrFDqwFw=;
        b=XWAVCKeNwuhCllxlq/zuon2lTuuOWtUSAVaaPmfoatTABeR/DDjc3Wbo9plzx+kzW0
         lFrZddQbkrcqguQg9GM9jAtRUMjrodOy1HF9j26kUmG2iQ+jo0/Rdn8THysdna0e/2bS
         k+gjdWaoKKG8nBfZbsbthVg2KVq9A8zIBN0ZUilaIl/CHZOSGdOTg9186NXaFCYHMZPp
         +KyrWoy26Sx3e5JSjwrTQBBP+Y60WemK80F3Ikutbm/X4+MflWVJz65wqRylf58wZlBG
         4b3fJ18GugeWT5044AiOq6VXWvi1zRh3P4iI6WZ5QX4wUZFcMx7jlr7Iqj2ZJmUgjrW+
         z99Q==
X-Gm-Message-State: AOJu0YzRmfRSpnklCHEdPvs+u2RzbhuS7OQyG5OOd5R1VpiUdxsiC3Vb
	ygc0KryjRgEoczpX0TWgHqY1uH41QQyEiS0w2nfb7sRRzI5fsF5eLfb88Xug405Oueu5ZIjVnuK
	oLiU7SbOVArYzck1NPrT9o+br9lEOgz0=
X-Gm-Gg: AY/fxX571l4cMmPIKaFzTY/aW7L6LeDFc8ILVpTxZLPkwlI5HfYJJqDLiEhY2Al4K8N
	1KTvl0iCSVOV0DogH+MTmc+JK+1b5hNlSUYKOz5iIwjjvIPDDtJ+e6SIbKd/QyFk3UKFSqi/ZFj
	h9GYsjW9xDdZSj+OONHQHu+3e+Vgfq5JP/LdUWrhMVV9BGskyJWmFL4B/TBBv3FfIVWxkfBb4Xd
	+w3c5xQFp6EC8sfanYlA7fsndugdxFahS3MhrWwhTtJIFMfBBZf8wZr7N52+JCCwrcph3/S2orx
	Vew9Ka02pCeo2DKmB+cd/jdX93EIAbQUxZP+okC11RwNB4146x5XZl6AvoZYWvbuwA==
X-Google-Smtp-Source: AGHT+IFYZLPLEH3rE4vj0dq+smRtFeRSm2HTJVJaSkGGTx2IkLYQYqw9oVOUrtjk/tAwxsrd9m60ZBcPQeVqnLI4rKc=
X-Received: by 2002:a53:ed4a:0:b0:641:eb21:d6ac with SMTP id
 956f58d0204a3-6466a8afd6cmr10577726d50.44.1766500864365; Tue, 23 Dec 2025
 06:41:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223135134.706-1-sarveshwar.bajaj@nxp.com> <20251223135134.706-2-sarveshwar.bajaj@nxp.com>
In-Reply-To: <20251223135134.706-2-sarveshwar.bajaj@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 23 Dec 2025 09:40:53 -0500
X-Gm-Features: AQt7F2qy6CCapqc7SMISb_7rrT8Dbs94KJr-Y8Wr9UtwUphS5WU3bTtf7N9TkK4
Message-ID: <CABBYNZKGSo5Uza6JoBXyCqQyi82WS4tQTBKOzpQ=HdOKu0Oa-A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 1/1] profiles/audio/bap.c: Fix
 heap-use-after-free in setup_free()
To: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, vinit.mehta@nxp.com, 
	mahesh.talewad@nxp.com, devyani.godbole@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sarveshwar,

On Tue, Dec 23, 2025 at 8:52=E2=80=AFAM Sarveshwar Bajaj
<sarveshwar.bajaj@nxp.com> wrote:
>
> Fix crash when removing or disconnecting a device with active broadcast
> streams. AddressSanitizer reports a heap-use-after-free in
> bt_bap_stream_get_state() called from release_stream() during
> setup_free().
>
> Detach frees BIS streams during teardown, but setup_free() still
> unlocks and releases setup->stream afterwards, leaving a stale pointer
> and triggering UAF. This can happen with multiple BIS streams since
> each setup holds its own invalid reference.
>
> Fix by skipping unlock/release in setup_free() and clearing
> setup->stream to prevent further access.
>
> Log:
> ERROR: AddressSanitizer: heap-use-after-free on address
> 0x7c43a43e3458 at pc 0x572415a8603d bp 0x7ffcdef9b870 sp 0x7ffcdef9b860
> READ of size 8 at 0x7c43a43e3458 thread T0
>     #0 0x572415a8603c in bt_bap_stream_get_state src/shared/bap.c:6386
>     #1 0x5724158f9d0a in release_stream profiles/audio/bap.c:951
>     #2 0x5724158fa10e in setup_free profiles/audio/bap.c:1121
>     #3 0x572415a293c1 in queue_remove_all src/shared/queue.c:341
>     #4 0x572415a29440 in queue_destroy src/shared/queue.c:60
>     #5 0x5724158f9464 in bap_data_free profiles/audio/bap.c:192
>     #6 0x5724158f9464 in bap_data_remove profiles/audio/bap.c:211
>     #7 0x5724159040e4 in bap_bcast_remove profiles/audio/bap.c:3821
>     #8 0x5724159a7eb9 in service_remove src/service.c:239
>     #9 0x5724159cfa49 in device_remove src/device.c:5489
>     #10 0x572415999889 in btd_adapter_remove_device src/adapter.c:1458
>     #11 0x5724159b99c7 in device_disappeared src/device.c:3854

Hmm, I thought we fix the device being temporary with broadcast, if
there is a broadcast stream then the device shall be marked as
connected so it wouldn't trigger the sequence above. Perhaps you
encounter this with an old version? Or maybe it is the kernel that is
old.

>     #12 0x572415abcea5 in timeout_callback src/shared/timeout-glib.c:25
>     #13 0x7f63a58f9329 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x68329)
>     #14 0x7f63a58f7de1 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x66de1)
>     #15 0x7f63a59691f7 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xd81f7)
>     #16 0x7f63a58f9156 in g_main_loop_run
>         (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x68156)
>     #17 0x572415abd18d in mainloop_run src/shared/mainloop-glib.c:65
>     #18 0x572415abd9c4 in mainloop_run_with_signal
>         src/shared/mainloop-notify.c:196
>     #19 0x5724159ea378 in main src/main.c:1550
>     #20 0x7f63a562a577 in __libc_start_call_main
>         ../sysdeps/nptl/libc_start_call_main.h:58
>     #21 0x7f63a562a63a in __libc_start_main_impl ../csu/libc-start.c:360
>     #22 0x57241587d464 in _start
>         (/home/workspace/bluez/src/bluetoothd+0x106464)
> 0x7c43a43e3458 is located 120 bytes inside of 160-byte region
> [0x7c43a43e33e0,0x7c43a43e3480)
> freed by thread T0 here:
>     #0 0x7f63a5b212ab in free
>         ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
>     #1 0x572415a710f4 in bap_stream_free src/shared/bap.c:1254
>     #2 0x572415a710f4 in bt_bap_stream_unref src/shared/bap.c:1337
> ---
>  profiles/audio/bap.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index cda10a643..f30262987 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -1113,12 +1113,7 @@ static void setup_free(void *data)
>         if (setup->destroy)
>                 setup->destroy(setup);
>
> -       bt_bap_stream_unlock(setup->stream);
> -
> -       if (!closing) {
> -               /* Release if not already done */
> -               release_stream(setup->stream);
> -       }
> +       setup->stream =3D NULL;
>
>         if (setup->ep)
>                 bap_update_cigs(setup->ep->data);
> --
> 2.48.1
>


--=20
Luiz Augusto von Dentz
