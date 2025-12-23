Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C161C28E
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766500838; cv=pass; b=r9tsbh5+2FXahPJQyxc3rDudyz93Q3iw6Gik+b5nD+OY5FA9sGDBEC3tumA39BEJx97C4k1quWFvWKhTYJ4fy7/1VIFOrX42BaUPVyd2FruMYm5/sovljtXfGQA8ptL+A8qckWpkgZ+2hj+IuURbfm2miZs81+3PH2P3jhYwbUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766500838; c=relaxed/simple;
	bh=RW09XMRUYAkb2HVX5BsTVuzN/hoMwQ7igtKVjkSsB9Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gyhywoD1UTHT3IqH41O1LHy9B361X0O/uhimE9ELifoBOb8+Ni9rbUxjfbSLYGT/0SkFYQ4pdaGVaBxAogZIGwqOeFrGGCbTvD97uWkQ22m5dM+DwM6sKEnFLYha5CYnyx6wuC2qrOKkqDyIhuqQtJe8QUK9Yml33/Z3LJkVX/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=OecpkRUZ; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="OecpkRUZ"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4dbHjn0RGjz49PyD;
	Tue, 23 Dec 2025 16:40:29 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1766500829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xS6fWLWNpnEPjqJngBpmhxkq5j1ADF4SDD5WlHnFrnY=;
	b=OecpkRUZIQkRvPOICz/B4Vau/288MUeXMq6GbPlBLDwcva4np74z/APgQ/XGn6+XYUd/ht
	zrydVMkplfnrzKCboev2m0lOUUfdakg1S3Aa076CWelkfmqpTAz4W6hr1ZXA1uMnCoHr+/
	pKtd4FB3Jdu3sgzgFbsQkpxfcj06Vwgs79YVLSpKM6A9B8kzJGqpq22mTIyYfYyx8w4Tye
	blWXsq7YQDU7YgXbXUbfRQzJQvyAYKfB6wG6VFLnUy322N4I9PvJxDdTaMRQIM2qoqOflh
	82Xu1XZLdkwuBpXiHyl7qRq7X4PFavBICnpLfgz4/OR3SIpa1wrRtishXO978A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1766500829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xS6fWLWNpnEPjqJngBpmhxkq5j1ADF4SDD5WlHnFrnY=;
	b=NtR0xJthryGIHIzk1Uwrfyar/zbdcS/WV4rlf0vd/kna7VRpJKmfOyMCw1js6W8VrTcYVE
	U7BluQl+jYhr3xOHcJlGmNA+dLZjCCRRjs4h73lvkRxuI+q7LO8FskiIUOL9+uyb2UmpIM
	hIeo8Kn/3GRy3DgcPsv5ZKu2rnwWCOt2OnhzueO7hYr4O0Q5tx9rg8LF01287xzE5GM4+a
	eqqc/OcI5YD/Lhd7j8V2ShX7BfJBPWnFG37Ec1jpBFLOAmZSFoJT1cZwbWb7Mcty6SCGqB
	FcUqoV73bP2oRYZP1NS8YIgl2sZ8Xx1ahkRjTwnvhXuLUi9wqBnEiNxyHRePLA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1766500829;
	b=GhG/ERq5H39Czz2reNWp7trTmHjskAVxm3XOFm9dqJpdD+VMGctWid4XoPFRQ7AMYdgsPv
	0qIk9s1zxVY5STDqYsvqUAVigU1sCkNxNFAiFwQoA7S+wAzVAfbEZxw+pt2mvbRlbriUAN
	uEtTDm48ovQKvIPLk66Tj/QC0JrAtrsgyzVDznpTrqxvTD2i9QS/KrkAZ0wZ4uu2FufRsb
	l/3R+bI9bs7GmmJps5QMm/10jMILZIvKdH3X2PrGXiX6mBVlqG7u9FFvGwb72IWVOnJU5t
	R3rvHjSgcU9f7exn15XZqNO4/WcKzt0edJHHpZEjfsU2TSJ1b2kSQ1RuxJvVEQ==
Message-ID: <411953d7da5ddcc712887ae3703d6d3b49792581.camel@iki.fi>
Subject: Re: [PATCH BlueZ v1 1/1] profiles/audio/bap.c: Fix
 heap-use-after-free in setup_free()
From: Pauli Virtanen <pav@iki.fi>
To: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>, 
	linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, vinit.mehta@nxp.com, mahesh.talewad@nxp.com, 
	devyani.godbole@nxp.com
Date: Tue, 23 Dec 2025 16:40:27 +0200
In-Reply-To: <dacbbaa37ff78ef55ced6d7e9a58a6cc025b52fb.camel@iki.fi>
References: <20251223135134.706-1-sarveshwar.bajaj@nxp.com>
		 <20251223135134.706-2-sarveshwar.bajaj@nxp.com>
	 <dacbbaa37ff78ef55ced6d7e9a58a6cc025b52fb.camel@iki.fi>
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

ti, 2025-12-23 kello 16:22 +0200, Pauli Virtanen kirjoitti:
> Hi,
>=20
> ti, 2025-12-23 kello 19:21 +0530, Sarveshwar Bajaj kirjoitti:
> > Fix crash when removing or disconnecting a device with active broadcast
> > streams. AddressSanitizer reports a heap-use-after-free in
> > bt_bap_stream_get_state() called from release_stream() during
> > setup_free().
> >=20
> > Detach frees BIS streams during teardown, but setup_free() still
> > unlocks and releases setup->stream afterwards, leaving a stale pointer
> > and triggering UAF. This can happen with multiple BIS streams since
> > each setup holds its own invalid reference.
> >=20
> > Fix by skipping unlock/release in setup_free() and clearing
> > setup->stream to prevent further access.
> >=20
> > Log:
> > ERROR: AddressSanitizer: heap-use-after-free on address
> > 0x7c43a43e3458 at pc 0x572415a8603d bp 0x7ffcdef9b870 sp 0x7ffcdef9b860
> > READ of size 8 at 0x7c43a43e3458 thread T0
> >     #0 0x572415a8603c in bt_bap_stream_get_state src/shared/bap.c:6386
> >     #1 0x5724158f9d0a in release_stream profiles/audio/bap.c:951
> >     #2 0x5724158fa10e in setup_free profiles/audio/bap.c:1121
> >     #3 0x572415a293c1 in queue_remove_all src/shared/queue.c:341
> >     #4 0x572415a29440 in queue_destroy src/shared/queue.c:60
> >     #5 0x5724158f9464 in bap_data_free profiles/audio/bap.c:192
> >     #6 0x5724158f9464 in bap_data_remove profiles/audio/bap.c:211
> >     #7 0x5724159040e4 in bap_bcast_remove profiles/audio/bap.c:3821
> >     #8 0x5724159a7eb9 in service_remove src/service.c:239
> >     #9 0x5724159cfa49 in device_remove src/device.c:5489
> >     #10 0x572415999889 in btd_adapter_remove_device src/adapter.c:1458
> >     #11 0x5724159b99c7 in device_disappeared src/device.c:3854
> >     #12 0x572415abcea5 in timeout_callback src/shared/timeout-glib.c:25
> >     #13 0x7f63a58f9329 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x68329)
> >     #14 0x7f63a58f7de1 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x66de1)
> >     #15 0x7f63a59691f7 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xd81f7)
> >     #16 0x7f63a58f9156 in g_main_loop_run
> >         (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x68156)
> >     #17 0x572415abd18d in mainloop_run src/shared/mainloop-glib.c:65
> >     #18 0x572415abd9c4 in mainloop_run_with_signal
> >         src/shared/mainloop-notify.c:196
> >     #19 0x5724159ea378 in main src/main.c:1550
> >     #20 0x7f63a562a577 in __libc_start_call_main
> >         ../sysdeps/nptl/libc_start_call_main.h:58
> >     #21 0x7f63a562a63a in __libc_start_main_impl ../csu/libc-start.c:36=
0
> >     #22 0x57241587d464 in _start
> >         (/home/workspace/bluez/src/bluetoothd+0x106464)
> > 0x7c43a43e3458 is located 120 bytes inside of 160-byte region
> > [0x7c43a43e33e0,0x7c43a43e3480)
> > freed by thread T0 here:
> >     #0 0x7f63a5b212ab in free
> >         ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
> >     #1 0x572415a710f4 in bap_stream_free src/shared/bap.c:1254
> >     #2 0x572415a710f4 in bt_bap_stream_unref src/shared/bap.c:1337
> > ---
> >  profiles/audio/bap.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >=20
> > diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> > index cda10a643..f30262987 100644
> > --- a/profiles/audio/bap.c
> > +++ b/profiles/audio/bap.c
> > @@ -1113,12 +1113,7 @@ static void setup_free(void *data)
> >  	if (setup->destroy)
> >  		setup->destroy(setup);
> > =20
> > -	bt_bap_stream_unlock(setup->stream);
> > -
> > -	if (!closing) {
> > -		/* Release if not already done */
> > -		release_stream(setup->stream);
> > -	}
> > +	setup->stream =3D NULL;
>=20
> This breaks various aspects of unicast, so it doesn't look correct.
>=20
> Possibly, the problem is that state transition to IDLE is not correctly
> emitted from src/shared/bap.c for BIS when it is detached.
>=20
> Or, setup->stream should be set to NULL at the point where it is
> invalidated.

Looks setups are not removed from data->bcast_snk when they are freed,
so probably something like the following fixes it:

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index cda10a643..b6eb91ab3 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -174,6 +174,8 @@ static void setup_free(void *data);
=20
 static void bap_data_free(struct bap_data *data)
 {
+       struct queue *bcast_snks =3D data->bcast_snks;
+
        if (data->listen_io) {
                g_io_channel_shutdown(data->listen_io, TRUE, NULL);
                g_io_channel_unref(data->listen_io);
@@ -189,7 +191,9 @@ static void bap_data_free(struct bap_data *data)
        queue_destroy(data->srcs, ep_unregister);
        queue_destroy(data->bcast, ep_unregister);
        queue_destroy(data->server_streams, NULL);
-       queue_destroy(data->bcast_snks, setup_free);
+       data->bcast_snks =3D NULL;
+       queue_destroy(bcast_snks, setup_free);
+
        bt_bap_ready_unregister(data->bap, data->ready_id);
        bt_bap_state_unregister(data->bap, data->state_id);
        bt_bap_pac_unregister(data->bap, data->pac_id);
@@ -1104,6 +1108,9 @@ static void setup_free(void *data)
        if (setup->ep)
                queue_remove(setup->ep->setups, setup);
=20
+       if (setup->data)
+               queue_remove(setup->data->bcast_snks, setup);
+
        setup_io_close(setup, NULL);
=20
        util_iov_free(setup->caps, 1);

--=20
Pauli Virtanen
