Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795536414;
	b=OKc21zhdit3S3j1qWd9G+2iTcd8bAoZHr4dSVRo12k1xxzv30EAwxujxBnNlzZ4dgCuY
	 6L7gkU5+DcUhINCR0GC4e1glDoURSVTA5/T6PJKNFxFOyH6rvOv7mV9E9kb6fFBBLl6O6
	 OiRg84hSQ8j29nT77wu7Ij7Vt6wh2akZvb4baNqoP3aQGMd6x3knKx62+CZZf33El6aT0
	 Br+XU2h7r64TtE8/fg1nATRpBp+gXXlIwf7SBsppEUK8zd17ZE7SlIwS0tiN6qhGkDsRy
	 FNlXw0fogbtlu7U5YpDtjt0S+HcrdtI0L1jBzm0w0aStWTpKT7actP2dnWWfgKt0JgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=mqhyR5P3CcCcnLzK5Z7ThujOw1dcTZgll7UggE2+Alo=;
	b=GvhJvo7FJJVtUZxI9GSMSKd1j5egbob6eXiiuemzbsBHUpPA+FQwwWCJlJTcmDfq4pPd
	 Pi4duSqbBBVe1trvKcwtvYQoGfF0NvgLh8SuCA+tR5a/gvKM8mrzJxwheEC2lrILykIJt
	 zaDANPVWldbeqbQJfpr25Ny3061aLFBMMlxMfhkStQ60SfQRK4s12B33W6JYbEoRmaxZR
	 CmS4GR2l+mxnPxFS02+hldhxOqzwhTkygB0W5ZJOfvgO2AT4CFdPA4Lm9vxjzTC7Ak/hs
	 4fH5PWpswlslhtYITiL2olh6KcK1k3ZhZ55OAQ6UAa+3Q+ZY2EfvtFlH5I0GqqDsOOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="E6NVA/Hs";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB56606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 16:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CB56606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E6NVA/Hs
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67c246c0c60so4227346d50.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 08:06:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795536413; cv=none;
        d=google.com; s=arc-20260327;
        b=QRgK43DIsSmRf60xyVJUNILQhMmU4sb07O/KRHe1IdjsiFtavjsuVcvl1Id33zeopJ
         X2gwQBuPCQncSb9qKBB32Lv6lh4WaZWiLG6gitSYUJUkX0FTfhnkxygcjBiNW/tNpQnT
         Mu1VO+W0p8wiQolVofKrJPvCoEgGwwsIyxp2KDVpkyQw7TAQfySsq5b94QacotxHdW+e
         iPw0IMrOwOJGxrBW2NiOuwCOUYYYv7oPzWT9Le/L8M0vSiz0FBPZ1lY9sUMor65sax2F
         PKcOmMXxCc5OSjFD2bmkec0UjoaXdpwms71DMiJvhItM5oXs7AfsMpAQluuL/i2UHr/T
         7qVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mqhyR5P3CcCcnLzK5Z7ThujOw1dcTZgll7UggE2+Alo=;
        fh=tyq0gYhA4cMcqn+bWakZSAdnDDyh/si+tlAcgOGyoy0=;
        b=U5mr6d4m1H9Kg4Qm+csPsK3P5Gd8Kxo9pDL+pFKuox8o2dEgb8o4vWzhroFkWXK+m+
         lp75gvI3H0iDZGyrGfD5lTNq4x9QN89hjEokEKUyXs5nvzpKz7FHcjymcTQe3DY+0d2h
         i/uY+rA3rEpIInaRYVIvm0hYJa9G5VfFfiYLzyDKU8/Ztug+cUOWR5S4b/Q+PGcO5W4a
         tIr6spRZLCaBDiuDBhQsv83fauGRHllfbT04gHHvfoiY+39rgzW8d+JK2IoGf6CNdAjN
         L9QCva31LEf4/qR3Su2WdTVy2qfNy/py6M/pej0v/VO6/w/pBGBpLtBFzI09dW+2C3+j
         cZRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795536413; x=1796141213; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mqhyR5P3CcCcnLzK5Z7ThujOw1dcTZgll7UggE2+Alo=;
        b=E6NVA/HsG4PsL3cyP+K0JvuFSLH3yk+6WLZeTeQMwX2NhxS6vBVGRxbYo7tWwh95Hl
         KHEWwn7Q88hnxLeMWQ0iMcFRx3k5JVzMNvGDpsuz0QNes0fBxA8GZerKei7wRSGHegeR
         394UVKPolSdDPpHxSvnVqU2CBdsBDnaLYyswvY4swy+3YojrjZULv/guM4FL5J+6evv9
         rIxsb30WVCKA/ejVa/jTcVX1zuG9eXkmuFpjnnVUX/AQl2rrv2i4SW/aIUCWx+mgXv52
         Zgp7iP9P8mpTKoGzNQ7jj/gUEywMWtuo8NcJHi4QBCJnMdehLpkDojjlkClW2/4OKmGI
         dN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795536413; x=1796141213;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mqhyR5P3CcCcnLzK5Z7ThujOw1dcTZgll7UggE2+Alo=;
        b=FE5ef55uEAHA2YhwpNVL/f+26QWkO1N49ALBNWTK4wj1bxzM4Arw3BgI+BtsweLIZp
         svzTGoYLC5u5vXDF25cdHxr9n7DSrWDjOKEc5FQXy4HeoFH9KRjasVSL6jm59xVK78IK
         CmgIlMhiUjgDW0n08ec5eIJSBKVcN8Na8qgqTBawuBs1e7N1emnEHX2qv0TsfTbBpWzV
         e0L/iu2Q7RLALxEoHZ9nTbW5jgUZgEvov8YDDQ0fmW7oovl95qdLuwpd1QAFiDmxZ9ME
         MVMcR+KJVHqJoFbcuS6yqaV8r51gqMc+wi/SfPxcgawBP05137VszDG/gCWL7gnCNW0C
         979A==
X-Gm-Message-State: APuU4Z/eyxdfId8R7Oi7ruk0x4AlN0cu2bSniq8SfF0n0KYDZi42En1h
	hp6W+hKLNWzdwPnR+Hu/CzDQulrG2k/UWNWT3w4g4SPHQbg+2uhsjg8JTAa9if+JE/gg8Qn/fjC
	sRXKPcMpHQYpREu/35+e47XCv36fjXnGQBw==
X-Gm-Gg: AZFdTZd3wGUWFMGO/w+0dN3S4gL7leTWS8uIhVqfMbPQ9B2Ny2WjjGTXloX/SbS7cE2
	cpLiLvGGAraXijX5SeCZ4a+ljqQ2hHCUvsddllOQigUD8ApranuyvZbjH1lySSzWHsgojzS0a/p
	vpFb/D68RfS6souP69PmAZZXet/7du5EEYq6b+94SccJ7rCy5fG/8XfIkkQDjprHym7CzaflIjh
	A/+RPT5v49JLVzWU0RBUwJ6CWYlhuW//Np19Xd2zSUZi2M46lsrTqXLM+nLfDA3eN2QDt1WbFNT
	yzB1n2zIdEGa4xDFelmPZB4PLoSSLJKoLlvThYShxoHi5lB2jyOB7a1VAJrsgN9Dijr8A573sPd
	eMxrFOfEcqNnCrElIb15RCwby0609hESmygs5Ng8j7mpbvGcWZLnXnEgWuNTixlL1NZtH0uyctV
	6TWSeMDAz8a/nWj7s5ZYty8e9bha/giOZ1NFLWa2SrB6qe5uS8joWKGYgY
X-Received: by 2002:a05:690e:1c0b:b0:67d:bf51:700f with SMTP id
 956f58d0204a3-67dec450158mr6830133d50.23.1795536413246; Tue, 24 Nov 2026
 08:06:53 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124131823.3848364-1-simon.mikuda@streamunlimited.com> <20261124131823.3848364-2-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261124131823.3848364-2-simon.mikuda@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Nov 2026 11:06:40 -0500
X-Gm-Features: Aa3M54p4A3CvwJFOGF7gPkq8S_cQZBgaeyaDfW12z0oFUXry75dZVw_9eDhCEmw
Message-ID: <CABBYNZLxMmL0T6rTiMi+B+oJGTE_=2BqORgAqCUw1VW7+h7gtA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] main.conf: Add 'paired' to ReverseServiceDiscovery
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Tue, Nov 24, 2026 at 8:18=E2=80=AFAM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> Reverse GATT discovery on a device that connected to us but is not
> paired reads characteristics that may need encryption. The remote
> answers those with ATT error Insufficient Authentication (0x05) or
> Insufficient Encryption (0x0f), and bt_att then raises the link's
> security level to retry the read, which sends a pairing request to the
> device although nobody asked for pairing.
>
> Add 'paired' in addition to true and false to reverse discovery conf
> it waits until the device is paired, and the GATT client of an LE link
> that connected without one is started once it is.

Hmm, actually it is not the reverse discovery isn't what triggers the
read, etc.; it's the accept callback which causes the profiles to
start the 'attach' procedures.

> Set the default ReverseServiceDiscovery to new 'paired' option.
>
> Assisted-by: Claude:claude-opus-5-5
> ---
>  src/btd.h     |  8 +++++++-
>  src/device.c  | 26 +++++++++++++++++++++++---
>  src/main.c    | 29 ++++++++++++++++++++++++++---
>  src/main.conf |  7 +++++--
>  4 files changed, 61 insertions(+), 9 deletions(-)
>
> diff --git a/src/btd.h b/src/btd.h
> index 9bf310271..2c897756c 100644
> --- a/src/btd.h
> +++ b/src/btd.h
> @@ -48,6 +48,12 @@ enum bt_gatt_export_t {
>         BT_GATT_EXPORT_READ_WRITE,
>  };
>
> +enum reverse_discovery_t {
> +       REVERSE_DISCOVERY_NEVER,
> +       REVERSE_DISCOVERY_ALWAYS,
> +       REVERSE_DISCOVERY_PAIRED,
> +};
> +
>  struct btd_br_defaults {
>         uint16_t        page_scan_type;
>         uint16_t        page_scan_interval;
> @@ -144,7 +150,7 @@ struct btd_opts {
>
>         struct btd_defaults defaults;
>
> -       bool            reverse_discovery;
> +       uint8_t         reverse_discovery;
>         bool            name_resolv;
>         bool            debug_keys;
>         bool            fast_conn;
> diff --git a/src/device.c b/src/device.c
> index 40d17bae4..3ece82c8d 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -350,6 +350,18 @@ bool btd_device_is_initiator(struct btd_device *dev)
>         return dev->att_io ? true : false;
>  }
>
> +static bool reverse_discovery(struct btd_device *dev, uint8_t bdaddr_typ=
e)
> +{
> +       switch (btd_opts.reverse_discovery) {
> +       case REVERSE_DISCOVERY_ALWAYS:
> +               return true;
> +       case REVERSE_DISCOVERY_PAIRED:
> +               return device_is_paired(dev, bdaddr_type);
> +       default:
> +               return false;
> +       }
> +}
> +
>  static GSList *find_service_with_profile(GSList *list, struct btd_profil=
e *p)
>  {
>         GSList *l;
> @@ -6471,7 +6483,8 @@ static void gatt_client_init(struct btd_device *dev=
ice)
>
>         gatt_client_cleanup(device);
>
> -       if (!btd_device_is_initiator(device) && !btd_opts.reverse_discove=
ry) {
> +       if (!btd_device_is_initiator(device) &&
> +                       !reverse_discovery(device, device->bdaddr_type)) =
{
>                 DBG("Reverse service discovery disabled: skipping GATT cl=
ient");
>                 return;
>         }
> @@ -6970,6 +6983,12 @@ static int device_browse_gatt(struct btd_device *d=
evice, DBusMessage *msg)
>         if (!req)
>                 return -EBUSY;
>
> +       /* Connected without a client, as reverse discovery waited for th=
e
> +        * device to be paired: start it on the existing link.
> +        */
> +       if (!device->client && device->att)
> +               gatt_client_init(device);
> +
>         if (device->client) {
>                 /*
>                  * If discovery has not yet completed, then wait for gatt=
-client
> @@ -7627,7 +7646,8 @@ void device_bonding_complete(struct btd_device *dev=
ice, uint8_t bdaddr_type,
>                 }
>                 bonding_request_free(bonding);
>         } else if (!state->svc_resolved && !state->browse &&
> -                       !state->discov_timer && btd_opts.reverse_discover=
y) {
> +                       !state->discov_timer &&
> +                       reverse_discovery(device, bdaddr_type)) {
>                 /* If we are not initiators and there is no currently
>                  * active discovery or discovery timer, set discovery
>                  * timer on the bearer that was bonded.
> @@ -7672,7 +7692,7 @@ unsigned int device_wait_for_svc_complete(struct bt=
d_device *dev,
>
>         dev->svc_callbacks =3D g_slist_prepend(dev->svc_callbacks, cb);
>
> -       if (state->svc_resolved || !btd_opts.reverse_discovery)
> +       if (state->svc_resolved || !reverse_discovery(dev, BDADDR_BREDR))
>                 cb->idle_id =3D g_idle_add(svc_idle_cb, cb);
>         else {
>                 if (dev->bredr_state.discov_timer > 0)
> diff --git a/src/main.c b/src/main.c
> index 3a051c5a4..4003a9627 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -924,6 +924,30 @@ static bool parse_config_bool(GKeyFile *config, cons=
t char *group,
>         return true;
>  }
>
> +static void parse_reverse_discovery(GKeyFile *config)
> +{
> +       char *str =3D NULL;
> +       bool val;
> +
> +       if (parse_config_bool(config, "General", "ReverseServiceDiscovery=
",
> +                                                               &val)) {
> +               btd_opts.reverse_discovery =3D val ? REVERSE_DISCOVERY_AL=
WAYS :
> +                                               REVERSE_DISCOVERY_NEVER;
> +               return;
> +       }
> +
> +       if (!parse_config_string(config, "General", "ReverseServiceDiscov=
ery",
> +                                                               &str))
> +               return;
> +
> +       if (!strcmp(str, "paired"))
> +               btd_opts.reverse_discovery =3D REVERSE_DISCOVERY_PAIRED;
> +       else
> +               warn("Invalid value for ReverseServiceDiscovery: %s", str=
);
> +
> +       g_free(str);
> +}
> +
>  static void parse_privacy(GKeyFile *config)
>  {
>         char *str =3D NULL;
> @@ -1096,8 +1120,7 @@ static void parse_general(GKeyFile *config)
>                                                 &btd_opts.pairto,
>                                                 0, UINT32_MAX);
>         parse_device_id(config);
> -       parse_config_bool(config, "General", "ReverseServiceDiscovery",
> -                                               &btd_opts.reverse_discove=
ry);
> +       parse_reverse_discovery(config);
>         parse_config_bool(config, "General", "NameResolving",
>                                                 &btd_opts.name_resolv);
>         parse_config_bool(config, "General", "DebugKeys",
> @@ -1473,7 +1496,7 @@ static void init_defaults(void)
>         btd_opts.pairto =3D DEFAULT_PAIRABLE_TIMEOUT;
>         btd_opts.discovto =3D DEFAULT_DISCOVERABLE_TIMEOUT;
>         btd_opts.tmpto =3D DEFAULT_TEMPORARY_TIMEOUT;
> -       btd_opts.reverse_discovery =3D TRUE;
> +       btd_opts.reverse_discovery =3D REVERSE_DISCOVERY_PAIRED;
>         btd_opts.name_resolv =3D TRUE;
>         btd_opts.debug_keys =3D FALSE;
>         btd_opts.refresh_discovery =3D TRUE;
> diff --git a/src/main.conf b/src/main.conf
> index c9906148d..b2c834244 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -34,8 +34,11 @@
>  # BITE tester doesn't like us doing reverse SDP for some test cases, for=
 LE
>  # this disables the GATT client functionally so it can be used in system=
 which
>  # can only operate as peripheral (see also GATT Client option).
> -# Defaults to 'true'.
> -#ReverseServiceDiscovery =3D true
> +# Possible values: 'true', 'false' or 'paired'. With 'paired' it is done=
 only
> +# once the device is paired, so that reading the services of a device th=
at
> +# connected to us does not start pairing when they need encryption.
> +# Defaults to 'paired'.
> +#ReverseServiceDiscovery =3D paired

I can leave with it being an optional argument, but not the default,
that said this may overlap with the [GATT] client support, although
this maybe cleaner, but we can't really anticipate if any profile,
etc, is not depending on the auto pairing logic.

>  # Enable name resolving after inquiry. Set it to 'false' if you don't ne=
ed
>  # remote devices name and want shorter discovery cycle. Defaults to 'tru=
e'.
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
