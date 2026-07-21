Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEEA42FCD0
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784661367; cv=pass; b=Y0cD3ksqDd7FfAjrwWPMwm758HEG+Vkr6lm0ECpd1YVXgm2kJMdu5WqMNQJtFxoeK6xHTcdu5rnkl+LYKLPvk4C40TyNAk+BWW24qcNY6l4KNtTE8qvJmIieZAvSofwMYO5jbT99PrxkAb0aEijmX1fzJixSrlMaRauzahkvgGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784661367; c=relaxed/simple;
	bh=oE7NkFlVQJiZAb0UGAlJqBhj9/c/YYeknPs7LYpndlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QzaBA7scqNx2dt2p7x99Fcr+Pgk194AiuFxfdIMcPesmWrAw2NWHrFrEPL0cnBJ2LCRsQHyK98P18HNqs5czt1+oqf1kdjyUb2EXi/fDP4f3YhFJ+g0SRsWgC3E8M2RUaBQchwOTdC3wZ7DEBRLIndTJGk/UAYnxjQ58LGswbF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShFBakTF; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShFBakTF"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-80a123ef90aso74582917b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 12:16:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784661365; cv=none;
        d=google.com; s=arc-20260327;
        b=nPrhwdLlMW35zYYnruYP6QuMcCeqqpEq8lNAgcJsQeAOIfrFwZmc6Rrv+maF3X4l6O
         HP1b4Wj+YwJPeOKL+/xwaTuUiqT4MrJylGFX77GqG3V5vP7W8SfjO1pVwbjZAUZji8Eh
         LHJf+NJyUhen/0bDaJPzcPzI9eVUlpXowC70NfnTQ9tUGSf42LFePVQNdnGc3m82jTRL
         x9s2X8zyo03OFuCEkwH+twtcPa8xKvv9TyTYQPFni7S2C/G5/Ty3pBdU2Gpr8cWQEqec
         7PUqW7c9qOW25Pawnp/4T9g/Usb+umfgIDjwmAAjJjSEyImQDXSNtFe1i4K2hGF2Bvwr
         IMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QtSe/vW58FbIWK3ACXFJtHuzNfwTnuL6BTwEpXKLaBo=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=bVX68U50PjTVa8Z+LwV9dFB880ok3cOA5u+Dsd21065wggnYiaWMRBx+b3dcDMZyLV
         9P5XCzrOlfbRPvDH2qqXkvD9HnRiK5XUI2eSkDjjcIEZQauz3cvkP3dc5YIWkYdZx50W
         pfzsJS42wQa0CtgCY4Oxo4xxNwkgC9JJNjd2rhBdIjwrxuzewSKHRK19tvKngODreqfd
         4xhInAByb/AZ7TN29qxmld1xAeu3sduLRScU9wIzifq0bRvMJn74T6O6TFH79viXGAfx
         v+W+II6MOSyNeNQiyq66Tys9e/YWkaRQu/chks7TIPEcXD9bcIPfTTwzNXErz8PInmqT
         llIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784661365; x=1785266165; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QtSe/vW58FbIWK3ACXFJtHuzNfwTnuL6BTwEpXKLaBo=;
        b=ShFBakTFTKCutE+MlGSbLpB5PCqVDBmgp2CkSHJC8VFvR70eI9nVMlX51mdcCmwkQj
         roBI2Mm5Ok4HzeoCPN5SOH/xasuI83Whh6DU0VtFXNd6qv6ouYkN5iAfhnl6IDaohU3h
         uU9QnUdJyVrD7oUadg3fAP9Fmw+22AwCqBpIM6xG8GSvsEN7h/FEKz/4uvV1fkFwg4un
         OY/Swm0x9NP9FyPoMvWGhIzsmFqsMvdxjQ4RvEtZKA14t8tgakppxiihXeiQUUlesGfN
         qgFji2mj9sFfLnYlJq6K/YcgOaUb0XOQ31Fl2upwmYBTooP7Vldvy0CfgJ/kAnVoRHAi
         p0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784661365; x=1785266165;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QtSe/vW58FbIWK3ACXFJtHuzNfwTnuL6BTwEpXKLaBo=;
        b=lF76AaVGOOhZoA5ct1huyBPa/pVLPBbhPASYLiZpqRRliZnHB+dPC4nciU4VZXdJxt
         MiZxAo3K0tMBSqEetq+YXz2HUKv8+77zzT5GP7/p1TDYhD4ZxmGmj4VqtiXu+VC8N62O
         hDJRUEqxnW0AUnwvQlfVahALeO54EsQ5JgqS8aDsFbhTtGJiq7sb9uxmi/X9mfxlIOTC
         LBF7lyKva0VylfjIPiuqw+6MvIWb/Tlshen6RW6YtLxTfidJJM2VZJZrzzJTUuVBHpGc
         2w3/+vqHDPvZt1XvVefev5EmygIwtSVsI8en+vBZb8XArHmSArl4r5u5BLu+QZEws8Zr
         sHag==
X-Gm-Message-State: AOJu0YzrjufHJGr3QVfOb2Z610w+wZb66HX5N8387smFfxDRrIxN/alO
	UvcOOeMqkS9qO5fUiHjrrOrBeNWv1qddb4PipRBep8Sx3PpNlpiVd4ka4hxC/p9+jh43g7BSozI
	XiUmIS/KfmviOfEJSC1iKI98hokq56iqCwMvNbaQ=
X-Gm-Gg: AR+sD108ObAhQxzy3K9oMw1RA40+rK813fXEn1ecVlDk2I2BJCoScr+IN+KR+dBgZJH
	uCoPscwo7MusoKoA0rWPjI9NlexRFw1jhGgR7C8UpPE4g+CCfJOzo8EFSzm8KXExjVszo9uqjOq
	nAe2ugnxNqRMbYEDYt3aCnKlgw/urkp/A/WoKUMJa51SpEKt9v2OCKDJ9neGMPckEZZKiAYfNhg
	gIE/SDCVbShGELqp7KxEP4pONVzzvtr3isfru5HBLsVgz/5tkJlU9RWLmw3guP2wGWxIs75cL8v
	nsfYa7ktwPDc1O/bu0nQY1PiIMMhxGLu33TP0R9LBOB4kCIn
X-Received: by 2002:a05:690c:368d:b0:81e:6563:72ee with SMTP id
 00721157ae682-81f33c16aecmr3377097b3.14.1784661364935; Tue, 21 Jul 2026
 12:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f81384d367ad95cbe74338eba688daa46b379feb.1784624911.git.pav@iki.fi>
In-Reply-To: <f81384d367ad95cbe74338eba688daa46b379feb.1784624911.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 21 Jul 2026 15:15:53 -0400
X-Gm-Features: AUfX_mxSXGQhCjdXo0G_4W-tkVM1tNpU_jf-VFjBHHah1mgUluwGJyPKFCsefxs
Message-ID: <CABBYNZLyajk6bry4Wnr5DScz+KMVBQZ5wpOX51AnxYir6h5bYw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] tools/iso-tester: add tests for socket shutdown
 with linger enabled
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Jul 21, 2026 at 5:20=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add tests with SO_LINGER enabled, to test kernel sock transitions
> properly to BT_CLOSED on shutdown.
>
> Unlike L2CAP, ISO sockets don't have a feature to send POLLHUP only
> after HCI Disconnect is received, so only SO_LINGER can be used to test
> the sequence is shutdown -> Disconnect, HUP -> release, and not
> shutdown -> HUP -> release -> Disconnect.
>
> Add tests:
>
> ISO Defer Linger - Success
> ISO Connect Linger - Success
> ---
>  tools/iso-tester.c | 68 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 67 insertions(+), 1 deletion(-)
>
> diff --git a/tools/iso-tester.c b/tools/iso-tester.c
> index fe27eaaf3..a792a804b 100644
> --- a/tools/iso-tester.c
> +++ b/tools/iso-tester.c
> @@ -478,6 +478,7 @@ struct test_data {
>         bool suspending;
>         struct tx_tstamp_data tx_ts;
>         int seqnum;
> +       GThread *thread;

I don't think this is a good idea, most of our userspace code isn't
thread-safe, so I'd prefer we keep it that way and perhaps handle this
with some async I/O or something else.

>  };
>
>  struct iso_client_data {
> @@ -522,6 +523,9 @@ struct iso_client_data {
>          * Used for testing TX timestamping OPT_ID.
>          */
>         unsigned int repeat_send;
> +
> +       /* Whether to enable SO_LINGER (for test_connect_wait_close) */
> +       bool so_linger;
>  };
>
>  typedef bool (*iso_defer_accept_t)(struct test_data *data, GIOChannel *i=
o,
> @@ -717,6 +721,11 @@ static void test_post_teardown(const void *test_data=
)
>
>         hciemu_unref(data->hciemu);
>         data->hciemu =3D NULL;
> +
> +       if (data->thread) {
> +               g_thread_unref(data->thread);
> +               data->thread =3D NULL;
> +       }
>  }
>
>  static void test_data_free(void *test_data)
> @@ -1352,6 +1361,19 @@ static const struct iso_client_data connect_ac_1_2=
_cig_1_2 =3D {
>         .mconn =3D true,
>  };
>
> +static const struct iso_client_data linger_16_2_1 =3D {
> +       .qos =3D QOS_16_2_1,
> +       .expect_err =3D 0,
> +       .so_linger =3D true,
> +};
> +
> +static const struct iso_client_data linger_defer_16_2_1 =3D {
> +       .qos =3D QOS_16_2_1,
> +       .expect_err =3D 0,
> +       .defer =3D true,
> +       .so_linger =3D true,
> +};
> +
>  static const struct iso_client_data bcast_48_1_g =3D {
>         .qos =3D QOS_OUT_48_1_g,
>         .expect_err =3D 0,
> @@ -3679,6 +3701,19 @@ static void test_connect2_busy(const void *test_da=
ta)
>         setup_connect(data, 0, iso_connect_cb_busy);
>  }
>
> +static gpointer shutdown_sk_thread_cb(gpointer data)
> +{
> +       int sk =3D PTR_TO_UINT(data);
> +       struct timespec start, end;
> +
> +       clock_gettime(CLOCK_MONOTONIC, &start);
> +       shutdown(sk, SHUT_RDWR);
> +       clock_gettime(CLOCK_MONOTONIC, &end);
> +
> +       /* Completed before linger timeout? */
> +       return UINT_TO_PTR(TS_NSEC(&end) - TS_NSEC(&start) < SEC_NSEC(2))=
;
> +}
> +
>  static gboolean iso_connect_close_cb(GIOChannel *io, GIOCondition cond,
>                                                         gpointer user_dat=
a)
>  {
> @@ -3688,6 +3723,13 @@ static gboolean iso_connect_close_cb(GIOChannel *i=
o, GIOCondition cond,
>
>         tester_print("Disconnected");
>
> +       if (data->thread) {
> +               /* Wait for shutdown() to complete, for linger enabled */
> +               if (!g_thread_join(data->thread))
> +                       tester_test_failed();
> +               data->thread =3D NULL;
> +       }
> +
>         --data->step;
>         if (!data->step)
>                 tester_test_passed();
> @@ -3737,16 +3779,34 @@ static gboolean iso_connect_wait_close_cb(GIOChan=
nel *io, GIOCondition cond,
>                                                         gpointer user_dat=
a)
>  {
>         struct test_data *data =3D tester_get_data();
> +       const struct iso_client_data *isodata =3D data->test_data;
>         int sk;
>
>         tester_print("Connected");
>
>         sk =3D g_io_channel_unix_get_fd(io);
>
> +       if (isodata->so_linger) {
> +               struct linger val =3D { .l_onoff =3D 1, .l_linger =3D 2 }=
;
> +
> +               if (setsockopt(sk, SOL_SOCKET, SO_LINGER, &val, sizeof(va=
l))) {
> +                       tester_warn("Can't set socket option : %s (%d)",
> +                                                       strerror(errno), =
errno);
> +                       tester_test_failed();
> +                       return FALSE;
> +               }
> +       }
> +
>         data->io_id[0] =3D g_io_add_watch(io, G_IO_HUP, iso_connect_close=
_cb,
>                                                                         d=
ata);
>
> -       shutdown(sk, SHUT_RDWR);
> +       if (!isodata->so_linger)
> +               shutdown(sk, SHUT_RDWR);
> +       else {
> +               /* With linger shutdown() blocks, so run in separate thre=
ad */
> +               data->thread =3D g_thread_new("close_sk", shutdown_sk_thr=
ead_cb,
> +                                                       UINT_TO_PTR(sk));
> +       }
>
>         return FALSE;
>  }
> @@ -4160,6 +4220,12 @@ int main(int argc, char *argv[])
>         test_iso("ISO Connect Wait Close - Success", &connect_16_2_1,
>                                         setup_powered, test_connect_wait_=
close);
>
> +       test_iso("ISO Defer Linger - Success", &linger_16_2_1,
> +                                       setup_powered, test_connect_wait_=
close);
> +
> +       test_iso("ISO Connect Linger - Success", &linger_defer_16_2_1,
> +                                       setup_powered, test_connect_wait_=
close);
> +
>         test_iso("ISO Connect Suspend - Success", &connect_suspend,
>                                                         setup_powered,
>                                                         test_connect_susp=
end);
> --
> 2.55.0
>
>


--=20
Luiz Augusto von Dentz
