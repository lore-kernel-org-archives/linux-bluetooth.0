Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E1241139
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766499765; cv=pass; b=J8QYNC9cSVhJJU+gD8OZ2NlNQ9dtTbi0HrKBGvIybxaRpK2Yb8ZlBiEahjzKEJ+iDpJLBLNSdqKpFw2KBbLK35ei/7rEczeqki1G2fOuj3eRGdIFovSmJWJ1CerIBS/mumPLWcb7dexYyF/wKJSdhO2J8lo3g7sI0fJ0PLc3GjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766499765; c=relaxed/simple;
	bh=LssF7P+QQb/f9WJwlGRrIqvMeIKCgPARJkLKoOIegYY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FChLyfP4aNJjwyw5Meq1OwGPfeSmi/CIeamPytULFxuKxicnpkssX+kuX0C9BJ3LKHY1nMjtNRw9+nLxLG8d9LJOmur6qYtOexExcWOYmY6e1gGEzwtCXdYoq3RRyO7JiUvcmkqNKjUWtrjBMEazAGsV5IWKVjuzNbOTAa8+G6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ZNGuiO+E; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ZNGuiO+E"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4dbHK80ZVlz49PyD;
	Tue, 23 Dec 2025 16:22:35 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1766499756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gAhzw/UoYuvhwsCkRq3J9/LdMH4iUDxW2y7Oy8Vd4Eg=;
	b=ZNGuiO+EPziJyttwcYSVYlosCG/kDTeAwQbS+6UT8AnCzGXPYlq3mjpw9Tq95xa06o+9y0
	xoxKFbQnbMJUH3xpTm+dIuceINaDVDpQuCSJZT4DaJGI8P9RiOFJKG9aL6B+qm0YN7Kyd5
	tn+sOS/WWHfKJrEof4rW/pONY+ngyuQ5iQ0f0DvQWzjcWVNrcqkdLc6lhXaWnugOOAYcCH
	S4ptJqdZx8IvITT8SuGS51tyA0qrd6lPmBL7jSbcfMmd3CEtT+8HKI8lmOH7s1dl6CUjVH
	13XvT6BVkeUUCoHiAgztJP0ISBh/aSiDiSweaweXNhFDp7XKSHn6CvYoZD+g1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1766499756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gAhzw/UoYuvhwsCkRq3J9/LdMH4iUDxW2y7Oy8Vd4Eg=;
	b=BHcy31pHLk6Or96KdosnGA/OnVQuygcUg8aPsEOB0vE6/NtzJpHuGJVWbfqzHf13VBKdy8
	OCKr8zodlTIVU5qsX57UVE1cdrXowPaBjTrBrKkwmN21GjEXoE0eVA/BalYnAB4eNInOl4
	eNpCOhdjNQLh7EJqCOSxAljSO9lZgruofxc0h8BvoR1mPoIf2gQ6/9ncuqx+Th8bsStWxe
	uyrHGt+PpZ0tdpfoOhRbLDbzE++YFi9UtI6Ww9Hx3wXKBF5XH/TzgJ3Hd6jtLXKzvPLC+O
	pmr1A5F86AkDIjwQqQ70ZaPBoA+4S0iIUx8JDvRLYNFFwII1E1f0fetKqWD1+A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1766499756;
	b=LwFbJGQt2H+KNLbiPgiYLaBvZ1S0Y3Zf92vF0ZVRAhXgYSe+AquwU2jVEIi6kCX91p14T/
	vkBvaW4s5OvCSiPBL/GgrcN4fikYjmSY/nksezA6bEJDLKxDaVrecwmLMKfYZXgSoUYGE0
	g14v1wnTOkF89O7D3zd1azmw4djagUftiTsHV1/bG4ibFbGhr5/u8ncC+A8CAi7hatWmfU
	bwM23AsqwL2Sp5OJodV+seWOlxgx7AEfUn+1MY3OKsbtxWKujTzQVHKsJ0ttnh/rSlZYYQ
	0ckFWwdjOosUT0RNaEX/OSz0eTNObHx/YlUfETCDMPZeMnXjlqUC57TFQTr1Ow==
Message-ID: <dacbbaa37ff78ef55ced6d7e9a58a6cc025b52fb.camel@iki.fi>
Subject: Re: [PATCH BlueZ v1 1/1] profiles/audio/bap.c: Fix
 heap-use-after-free in setup_free()
From: Pauli Virtanen <pav@iki.fi>
To: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>, 
	linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, vinit.mehta@nxp.com, mahesh.talewad@nxp.com, 
	devyani.godbole@nxp.com
Date: Tue, 23 Dec 2025 16:22:35 +0200
In-Reply-To: <20251223135134.706-2-sarveshwar.bajaj@nxp.com>
References: <20251223135134.706-1-sarveshwar.bajaj@nxp.com>
	 <20251223135134.706-2-sarveshwar.bajaj@nxp.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ti, 2025-12-23 kello 19:21 +0530, Sarveshwar Bajaj kirjoitti:
> Fix crash when removing or disconnecting a device with active broadcast
> streams. AddressSanitizer reports a heap-use-after-free in
> bt_bap_stream_get_state() called from release_stream() during
> setup_free().
>=20
> Detach frees BIS streams during teardown, but setup_free() still
> unlocks and releases setup->stream afterwards, leaving a stale pointer
> and triggering UAF. This can happen with multiple BIS streams since
> each setup holds its own invalid reference.
>=20
> Fix by skipping unlock/release in setup_free() and clearing
> setup->stream to prevent further access.
>=20
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
>=20
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index cda10a643..f30262987 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -1113,12 +1113,7 @@ static void setup_free(void *data)
>  	if (setup->destroy)
>  		setup->destroy(setup);
> =20
> -	bt_bap_stream_unlock(setup->stream);
> -
> -	if (!closing) {
> -		/* Release if not already done */
> -		release_stream(setup->stream);
> -	}
> +	setup->stream =3D NULL;

This breaks various aspects of unicast, so it doesn't look correct.

Possibly, the problem is that state transition to IDLE is not correctly
emitted from src/shared/bap.c for BIS when it is detached.

Or, setup->stream should be set to NULL at the point where it is
invalidated.

> =20
>  	if (setup->ep)
>  		bap_update_cigs(setup->ep->data);

--=20
Pauli Virtanen
