Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215AE3BBFBB
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 20:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578527; cv=pass; b=hExb6hDAwFMdGkEzwqFsr2XV2/iNi//9pPhCE+mFY8jn5D74p5HQkFiNEQn1M4O1I43qHOKjgldMDev1ZwsyyjiiI7mhvmoML5es1KmgVqCNyGIpUCM/OJAbDXNxW28qJjQWmBBWvf8WvWlncfhEWSC+8kyLgtzCjrKsdgUzzRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578527; c=relaxed/simple;
	bh=AargnbA1hm0MmAMXQ+J/HQTsiaLLYGflJuMAZ3/rB2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Brpt+VxPWNkj09MHP0s2ceS3fq0rffZr3qSCGFMPwhG9nBFfrrATNDUBjF8lIWn48VGV/TGRdinSlycO8kBPexNH2y1QDk/nAdWwDYzwChGi7mIRvqFqUl/Klex9NxbT7gRZ+Zf3Gsj4CqnGh/S98CFnMfxcML9Py5c1BDHdLcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xqa++vMF; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xqa++vMF"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7dbcb505578so69023907b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 13:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784578511; cv=none;
        d=google.com; s=arc-20260327;
        b=jGwAyLNwi+RffH8jtYpgX6GK79DWL24t3kT1E/FNBCrJQqpvXf/DbNzQNzWEi9/OHf
         ASq3E6NBMAkgzCJbb7MqQzpwqibvdCa5Vyy6cRUAg44xQhNhgkLEK02kJMeaYvtRUw1T
         I+sAmVa/1hw3PQqeo+qIOaMnnZdwGl2uxRtgH7JtPGUdulHeaN3aH9gGodAA/VY57Tuy
         ZCR/4zQKaFOWiwg0MyK2b0hjSX6VWQi7pyKaGPfbtq1N6SsQYcnXxZoT7EA1ggPvoBC9
         hb0yNQ/dZ5u4nvC7dlLevlnwJQJF/ehqlgnBK8WPMg0eUB9aXkq1dJRilvXAnuEtGuN4
         gzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z25dC1BOzQgy1FCvsPZxxpbwFFBNTKqx/c1GUWGd7wY=;
        fh=TJwHJsEYdMUNCzSsFmBYnqsY3TT4k79AzZGb32Nmle8=;
        b=pj6c/AFdLKeJcll1e+2BxR69u3uKt56XOQLRPGnmfI+09MXNZOS28KY1v/siITLuFW
         l3mOdLyQqddQwWhfTm2X45tYo6bbqhZTVqaREdn9BtyMtU7X3WiNuCOSmSd8thVV2iRo
         8mInMMq+U38OQDzjYnhnpyOUCkyWnZKLtRbPrVWEGVxxF7mz+U+yjelQqjhbrUdNYfQe
         MecHTV+eGGqtVeon1mvAHpyJvtjiRN/2Ov0xP71mWmAIZxeVDA5SHdv9Rz4n1+4f18Id
         1qDaPKlkbXo8tSPN89ToyGzPhZ3zVgMgxS9jVkxBURLw9NhYJM9euBDoQgH/5gUMq186
         OI/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784578511; x=1785183311; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z25dC1BOzQgy1FCvsPZxxpbwFFBNTKqx/c1GUWGd7wY=;
        b=Xqa++vMF3Mp4A9Pqie+4mM+M6C61ArmPmThakmix8Bm0zkoFBWHMXzjy7eiXtcjwe9
         M5lqli0/qynRlhEr7UTlSHYQzty+x8wdsUsCLWzwlagly9dhnJrHPriyPxvRcnt1ABzX
         pw8sUCuk1PgSTzck3pDVLu0mOfmj3cZq7BQJP5Xo4TA3YfmkBVHQWtbEOGcsTCXaKg14
         AT2ET2F67GHMi4+fpGBxIwDkGVFPNB115HgRwJyMAv7fEyp6SOPyqNbQSrsnAcDrKjRN
         3lmaw7EJew1jc80zTSSgfXx1uaxyRd8oMImCqZGjn2GN1neOwtj1gKnG1SqAuU9YJQeg
         TtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784578511; x=1785183311;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z25dC1BOzQgy1FCvsPZxxpbwFFBNTKqx/c1GUWGd7wY=;
        b=MxxSOKJwC8Q6cfoYRRY3hD68zZ/FzY9buoRLpTqZ9RnaIieU0U8tCsAeTbzozwMTYt
         09QD1T/H9LlEy7l7L2fvGL26TMsGst6uZfBDGAVxJC0XLylSq/PvJCS62lIYhCOi7o7J
         laVN27aNM3dP5fR5h5Pbl5E15cLX9yuOhVx1A+gGHLZp+Ldi8e5Bi2Hf0dAOlp1hGHRb
         9yJLIQOv0Xprl+outpSG97hfpNlOehRtHw3xBFMZYUjTKuqNyMENF8Q3LrlNSHntozUR
         0yFA4z6qCqqGH70MeECUcBvnzNojjXYgZZU0fajzz/Hvrja8jexe9Ryyrj7FQud/KkRT
         1Uxg==
X-Gm-Message-State: AOJu0YyAg8LpKxahp9Zbc5GgizQB0TvvgXdDKG6e4rHtBi6F6PN/jCVi
	Eq4lcyJSd6da2GytbKfBxQsp8sY15mEXLvNvBvw/Wr/5mzR8qF4GfIsX4yW2mYmlU6FwhbC4vFN
	NtVO6jmv/yvbvFjwwO3OETgyfqdIZOTE=
X-Gm-Gg: AR+sD13fOz55oYLKifhu4V8+MqrpqVRLLTSRzXZLIJPAB0EfMMT+hKfmL3PRXKxiYcd
	p3PtI1IMHqckbmlDY5kxc2Q+W6mm0mbcx7dZSklONg3A4gcNUMKSACK0DmReLohFkw2mqDxVlLt
	o6nhmsfBVdN8t5hU8loa0yUrpgLqWIwq/Xa5tHG+2Xwpn0JDzyrXbj9gF6yb0zeiAawpnBrH3+A
	uRNQlXJeGjIM8FklAKElw5Ir2hNRh98A/Tf3VYGZYQ2VY3czGyB/0uycqUDe1W7z66pXRk50ZQu
	eP6xMTxtuKk1cDqFGOEGAS0pzKnRx9Tm0juOz91K4hbO7S02
X-Received: by 2002:a05:690c:9689:b0:81e:68f6:f84d with SMTP id
 00721157ae682-81ef2601726mr48185917b3.52.1784578510112; Mon, 20 Jul 2026
 13:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4d96c545ad1a2fed02440a3478905853286aa0c7.1784571683.git.pav@iki.fi>
 <CABBYNZKtXwpnz9PH3eR31ETKAvPOoCnWebKf0UUDpe7tPQs3Kg@mail.gmail.com> <bdf9806d5f2de01e355f0e835201df692f0b2744.camel@iki.fi>
In-Reply-To: <bdf9806d5f2de01e355f0e835201df692f0b2744.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Jul 2026 16:14:58 -0400
X-Gm-Features: AUfX_mxF7zk7e4QPB0OVLVS8wa2nREgu_dyXXiUoZscChbOEZSOWmbFjlobrDOM
Message-ID: <CABBYNZK4NEsXz_dPxvEFTQ3k+7K=mKNFu3b7CoEAZ62hMciT0A@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: ISO: fix UAF on socket close before
 shutdown completes
To: Pauli Virtanen <pauli.virtanen@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	iulia.tanasescu@nxp.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Jul 20, 2026 at 4:08=E2=80=AFPM Pauli Virtanen <pauli.virtanen@iki.=
fi> wrote:
>
> Hi Luiz,
>
> ma, 2026-07-20 kello 15:37 -0400, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Mon, Jul 20, 2026 at 2:30=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > iso_sock_disconn() aims to disconnect the hcon by dropping it, which
> > > triggers iso_conn_del() once the HCI operation completes, requiring
> > > valid hcon->iso_data to do socket cleanup.  iso_sock_disconn() sets
> > > conn->hcon =3D NULL to avoid a second drop, but also preventing clear=
ing
> > > hcon->iso_data on socket release. Closing the socket before
> > > iso_conn_del() runs then results to UAF.
> > >
> > > Fix by using a separate flag to track the hcon drop status, instead o=
f
> > > clearing conn->hcon.
> > >
> > > Log: (BlueZ iso-tester ISO Connect Close - Success)
> > > BUG: KASAN: slab-use-after-free in iso_conn_hold_unless_zero
> > > ...
> > >  iso_conn_hold_unless_zero (net/bluetooth/iso.c:138)
> > >  iso_conn_del (net/bluetooth/iso.c:270)
> > >  hci_conn_failed (net/bluetooth/hci_conn.c:1408)
> > >  hci_abort_conn_sync (net/bluetooth/hci_sync.c:5817)
> > >
> > > Allocated by task 34:
> > >  iso_conn_add (net/bluetooth/iso.c:216)
> > >  iso_connect_cis (net/bluetooth/iso.c:507)
> > >  iso_sock_connect (net/bluetooth/iso.c:1211)
> > >  __sys_connect (net/socket.c:2148)
> > >
> > > Freed by task 34:
> > >  iso_chan_del (net/bluetooth/iso.c:248)
> > >  iso_sock_close (net/bluetooth/iso.c:885)
> > >  iso_sock_release (net/bluetooth/iso.c:2022)
> > >  sock_close (net/socket.c:722)
> > >
> > > Fixes: fbdc4bc47268 ("Bluetooth: ISO: Use defer setup to separate PA =
sync and BIG sync")
> > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > ---
> > >  net/bluetooth/iso.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > > index 2e95a153912c..6abc2b1f59bc 100644
> > > --- a/net/bluetooth/iso.c
> > > +++ b/net/bluetooth/iso.c
> > > @@ -30,6 +30,7 @@ struct iso_conn {
> > >         /* @lock: spinlock protecting changes to iso_conn fields */
> > >         spinlock_t      lock;
> > >         struct sock     *sk;
> > > +       bool            hcon_dropped;
> >
> > It might be safer to add a flag or something so we can perform atomic
> > operations to check if dropping is necessary.
>
> It is serialized by iso_conn::lock + kref, so AFAICS it is safe. I can
> change it to test_and_set_bit() regardless if still preferable.

I'm afraid in today's world that is sort of required; otherwise,
someone using an AI model might miss the serialization and send
patches to 'fix' it anyway, just creating more work for us to review.

> The lock is not taken in iso_conn_free() --- at that point nobody is
> holding a reference so there should be no concurrent modification, so
> AFAIK it is taken care of by the refcount memory ordering (see comment
> in include/linux/refcount.h), otherwise conn->hcon etc would also be
> wrong.
>
> The
> comment https://sashiko.dev/#/patchset/4d96c545ad1a2fed02440a347890585328=
6aa0c7.1784571683.git.pav%40iki.fi
> on Sashiko seems to miss that iso_connect_cfm / iso_disconn_cfm ->
> iso_conn_del() are called before hci_conn is deleted, and should make
> sure there's no dangling reference to the hci_conn. It would be same as
> for remote disconnect. Maybe the prompts it uses in
> https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/blue=
tooth.md
> could be improved vs hci_conn and socket life cycles.
>
> > >         struct delayed_work     timeout_work;
> > >
> > > @@ -107,7 +108,8 @@ static void iso_conn_free(struct kref *ref)
> > >
> > >         if (conn->hcon) {
> > >                 conn->hcon->iso_data =3D NULL;
> > > -               hci_conn_drop(conn->hcon);
> > > +               if (!conn->hcon_dropped)
> > > +                       hci_conn_drop(conn->hcon);
> > >         }
> > >
> > >         /* Ensure no more work items will run since hci_conn has been=
 dropped */
> > > @@ -306,6 +308,7 @@ static int __iso_chan_add(struct iso_conn *conn, =
struct sock *sk,
> > >
> > >         iso_pi(sk)->conn =3D conn;
> > >         conn->sk =3D sk;
> > > +       conn->hcon_dropped =3D false;
> > >
> > >         if (parent)
> > >                 bt_accept_enqueue(parent, sk, true);
> > > @@ -836,8 +839,10 @@ static void iso_sock_disconn(struct sock *sk)
> > >
> > >         sk->sk_state =3D BT_DISCONN;
> > >         iso_conn_lock(iso_pi(sk)->conn);
> > > -       hci_conn_drop(iso_pi(sk)->conn->hcon);
> > > -       iso_pi(sk)->conn->hcon =3D NULL;
> > > +       if (!iso_pi(sk)->conn->hcon_dropped) {
> > > +               iso_pi(sk)->conn->hcon_dropped =3D true;
> > > +               hci_conn_drop(iso_pi(sk)->conn->hcon);
> > > +       }
> > >         iso_conn_unlock(iso_pi(sk)->conn);
> > >  }
> > >
> > > --
> > > 2.55.0
> > >
> >



--=20
Luiz Augusto von Dentz
