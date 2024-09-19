Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B888F524B4
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726775606; cv=none; b=eVR0hoprSBqXis0WRfWHJycrTByqGym7aQOzpguxnKSxBWARpwNYtEEM/uB7RsYtulx1S5GbaAOQe8IFMe2cmN6tKzblJXhHeSbzBWmiFZ6gEuhuFa+JL1p41MFPgLTILQX4a9lPWDsdXPuMidNBTdJ/0cPj6Z408mGvc+e0gsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726775606; c=relaxed/simple;
	bh=Lakk0O4/uuP088MJjNH8NHuylEbCBDqoApoie+/LqpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfYdMvwSB1CPQDsVngfN15gWZOxomti/1Z4MLKu1UY8iUOAp24ohJnggdlosp35+Amjf6IEVUnA9AnW2zOAmjb4erg218kDN4JOHbXbFToM8loPm7kK7IMlFAh80IHaSuPQoC9aiVR9iH0cq9QaDzvNjWZtnu7vagFPq8QbboYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iz5j8vu8; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iz5j8vu8"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f75c0b78fbso13722091fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 12:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726775603; x=1727380403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V02/bjpqA3YxpCzxHJ+8CwJ4XHC0EJP7uAUi1/2xNXA=;
        b=iz5j8vu8FrM3NXZlzlSEL5hwRBwEiGF7JHpXgx95NG5F7kQSMG2HL5ZlYynxmADE0q
         e4t5HNI+cP/y+aLA+Nj79F0fqbgX8eaS5z4K4QMV5hiOHvsheQ6mla1xei67qNvYwQhb
         ZIR2uqr78zv3vS1yUc/j0pW1zwxUvJswS6Bxiihj6FTUr952RNGpND7W7Leqlzq7zkn/
         nbksr3RzUOAmoE7l84Y5++MEEYV17mpnswWm/iNQZ2hc1dwHXdw0H1Rs4aSwFW7w/Hit
         CAGYkf5NRwEm+UbN63PnICO84AfUKVOEn5ycGLuoPO3CMW4b+8ju20/yHHvDPOW0RcGT
         ti9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726775603; x=1727380403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V02/bjpqA3YxpCzxHJ+8CwJ4XHC0EJP7uAUi1/2xNXA=;
        b=eDAxw5uthk10WnQD3fB9jp9fPBeYnUcMPYxd9IJoFluZjh3kw5gHRY9Ck1Mtl8+3ep
         xWta5EoPR9rfXAqVguq8dHChZpL1wBZgXYQyz8sJsC9jJrNQjRlB/8t65u+aC/j+XTnD
         QjV5bk9nKi9lz1VJcPcAeIDo2exbhEYkhz1BfAHoCgcxKf63t8TGesobfdG9GRkxVGDs
         zWYI/1sB8r37kwRnzsBQfOvlTkJFSJr6DDPxHt6mbB2Z0P91Lyv1r5kndVhZRqo4bALm
         QplcBqUnNzFsyQ1v4NqsCbQ+Xscph8B+x44E/7T3VnN9i8TtRsOrq+1mlLx2pwl+GjGS
         MU1g==
X-Gm-Message-State: AOJu0YwS0/GRB9Eukhex9c8eCx44XBV35tecW/jj7gDKIXzgInn8p4ny
	axJNkGCJPDVnKJPkLr26HkBR8UrxsyacACXcX3BZ1E836CwPefWIMYhpacebY8JrlqhE2rZSxKH
	dUVZNbSfU7MxstnKzWmkL/0auSMk=
X-Google-Smtp-Source: AGHT+IGdo+w2zPCk1cTLXSKznXLAJ4BUVOrqbs2T5/ff4UkunePCM+bkOONAHIp22KmNn9H1ezTwvq1dDgA18OyvgTM=
X-Received: by 2002:a05:651c:1992:b0:2f5:a29:5a42 with SMTP id
 38308e7fff4ca-2f7cb3190f8mr4843531fa.14.1726775602514; Thu, 19 Sep 2024
 12:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826090044.560142-1-quic_chejiang@quicinc.com>
 <CABBYNZLOawJZgtm89QKBpbMdS1_NgXOzHgh2ftBzPyNRKfx+Sw@mail.gmail.com> <aa242203-72c1-4503-8487-3f45b46a5ace@quicinc.com>
In-Reply-To: <aa242203-72c1-4503-8487-3f45b46a5ace@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 19 Sep 2024 15:53:10 -0400
Message-ID: <CABBYNZKatMoepAJriVOwFUrehDyABV26gU374xFyFY3CNnxWTw@mail.gmail.com>
Subject: Re: [PATCH v2] adapter: Cancel the service authorization when remote
 is disconnected
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cheng,

On Mon, Aug 26, 2024 at 10:30=E2=80=AFAM Cheng Jiang <quic_chejiang@quicinc=
.com> wrote:
>
> Hi Luiz,
>
> Thank you for your feedback. Please check the comment inline.
>
> On 8/26/2024 9:43 PM, Luiz Augusto von Dentz wrote:
> > Hi Cheng,
> >
> > On Mon, Aug 26, 2024 at 5:01=E2=80=AFAM Cheng Jiang <quic_chejiang@quic=
inc.com> wrote:
> >>
> >> If the remote device drops the connection before DUT confirm the
> >> service authorization, the DUT still must wait for service
> >> authorization timeout before processing future request.
> >>
> >> Cancel the service authorization request when connection is dropped.
> >> ---
> >>  src/adapter.c | 20 ++++++++++++++++++++
> >>  1 file changed, 20 insertions(+)
> >>
> >> diff --git a/src/adapter.c b/src/adapter.c
> >> index 245de4456..3ad000425 100644
> >> --- a/src/adapter.c
> >> +++ b/src/adapter.c
> >> @@ -8502,6 +8502,25 @@ static void disconnect_notify(struct btd_device=
 *dev, uint8_t reason)
> >>         }
> >>  }
> >>
> >> +static void adapter_cancel_service_auth(struct btd_adapter *adapter,
> >> +                                       struct btd_device *device)
> >> +{
> >> +       struct service_auth *auth;
> >> +       GList *l;
> >> +
> >> +       auth =3D NULL;
> >> +       for (l =3D adapter->auths->head; l !=3D NULL; l =3D l->next) {
> >> +               auth =3D l->data;
> >> +               if (auth->device =3D=3D device)
> >> +                       break;
> >> +       }
> >> +       if (auth !=3D NULL) {
> >> +               DBG("Cancel pending auth: %s", auth->uuid);
> >> +               g_queue_remove(auth->adapter->auths, auth);
> >> +               service_auth_cancel(auth);
> >> +       }
> >> +}
> >> +
> >>  static void dev_disconnected(struct btd_adapter *adapter,
> >>                                         const struct mgmt_addr_info *a=
ddr,
> >>                                         uint8_t reason)
> >> @@ -8516,6 +8535,7 @@ static void dev_disconnected(struct btd_adapter =
*adapter,
> >>         device =3D btd_adapter_find_device(adapter, &addr->bdaddr, add=
r->type);
> >>         if (device) {
> >>                 adapter_remove_connection(adapter, device, addr->type)=
;
> >> +               adapter_cancel_service_auth(adapter, device);
> >
> > This shall probably be placed together with
> > device_cancel_authentication in adapter_remove_connection but we need
> > to track in what bearer the authorization is for and remove all
> > authorization requests like in btd_adapter_remove_device:
> Yes. It can be put in device_cancel_authentication, but the condition to =
call
> this function in adapter_remove_connection need change. device_is_authent=
icating
> is only true when request, notify or confirm pincode/passkey.
> As for bearer, the service authorize is only happened on BDADDR_BREDR. So=
 it
> can be called when the address type is BDADDR_BREDR in dev_disconnected.
> >
> >     l =3D adapter->auths->head;
> >     while (l !=3D NULL) {
> >         struct service_auth *auth =3D l->data;
> >         GList *next =3D g_list_next(l);
> >
> >         if (auth->device !=3D dev) {
> >             l =3D next;
> >             continue;
> >         }
> >
> >         g_queue_delete_link(adapter->auths, l);
> >         l =3D next;
> >
> >         service_auth_cancel(auth);
> >    }
> >
> > I'd probably move the above code to a helper function so it can be
> > called from different places, as for doing this on a per bearer basis
> > would probably need to add bearer information to btd_service but I
> > guess that can be treated separately.
> Yes, it's great. Need use the above code to cancel all pending authorize.

Looks like you never send another version of this one, are you still
planning on having this fixed?

> >
> >
> >>                 disconnect_notify(device, reason);
> >>         }
> >>
> >> --
> >> 2.25.1
> >>
> >>
> >
> >
>


--=20
Luiz Augusto von Dentz
