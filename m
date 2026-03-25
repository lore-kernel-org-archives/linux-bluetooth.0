Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC1631F99F
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774466574; cv=pass; b=ENor/CqEgs9chdXFqLbxPXjBmTuplM+B9MZpgaFA0miFOMFPdYMpSmn4xiZ8+tJR4ua1LqnYZ3vgFvx91wGM0kxJCV8AXAJ/0Mx6YoL8bOdMlZQ8HUeVbA7RvBD4IUsWShCrA3yVki2wyrFhMPwSTL9Zl6qzKRzFrmwM6XHSVR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774466574; c=relaxed/simple;
	bh=M23odA6iUh/3k9hZ+Ebrm2lXVOhcX4kDmUrO0yXCJPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHXc5FDbzlu1lfC+Dt9uhmMGbcPf96H7Inwg3bhhiTg9X6UujKSRGBsC3KpdEdvYdy5prIMyYCh4wIh7y62RtaKvKIqLDx3IIo3LU6WgkkLcCA1dguMKwQCAk32JyhYCDOX7lYPeP55cbzyB86oFytRoQ8mXfKnfRrR2m3XkTx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkBwYCiV; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkBwYCiV"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64937edbc9eso251408d50.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 12:22:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774466572; cv=none;
        d=google.com; s=arc-20240605;
        b=kvugCv1KF3BerPqkBQnpDC7yi5fUlIsn2tPzfSKNdyciH6OZgC01MlGar35QucCXv5
         Cd6FntLWaz9c2wkumA13sh7AYEjg7DHLOblbb3WHnUPmdQoJOys0G2ys0bdgwrpVxKjj
         oqYvnZI0he5DAaKScKyE5by+IHumLY0wJqIFdaeBR+bpO5WvD4TrGL1uasG1iUxkKCUS
         D1MFEhVcKSPVk6erOfqQ0vfnMZg8WfNiYMEY7ILJXGbKmVaFRTDLZcErXCJ/biyVA/W8
         lhOSsJ5wGtPlzHd1lxbvVwNjMGp+Ortt2s7K5Ahl1fhRuikdoQZRMdEbdYYB8RTWcy8p
         kmJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RCipcYHV41WSFUBdXxt5GlaKJxP2x0Xd6EISWGVu8LM=;
        fh=kLfBEwCGkV+7Pgt3CaQ3c2c3YyO9mc6jW6GVYbhg9nk=;
        b=YLbglf9UJIANBHXa1OJ811RyH117gCU0KRus/7mxM01XkGJRPrvFWuadwR0CpDUKYL
         95pssLIZlB7IVLP+DHbOmkvVJuZRyCU+pcAWjB/H/g2cOHeG1hlYlCWCCjuaD1MEiSDw
         Gs9VlmaJj/8IgYQN5gLm7wK/lQIvkyq2Yaq/Okeq8r4dCK1hgiyY0AMdFHXPRDgBgBpD
         qIR3NcVHXXPt/fgYA7Gixe1atOQh6MK/t00/ysovYRqjAFe8u7h0hw8RWGGO8E3u+9uY
         16Gr29jTf7WIIJUOl4Pu08/XPLTl5FySIgDvAFB3mdZY11AuVlTOMjig2Qybi97nVsZa
         pHbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774466572; x=1775071372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCipcYHV41WSFUBdXxt5GlaKJxP2x0Xd6EISWGVu8LM=;
        b=YkBwYCiVmXOfhbSfjYauNJfZA1v+LHKrAAyzuRjyqYn5FzKx657hllb8M7PhoMvthC
         TbN2RgOk92CWpDspXHrajpfRYI6hv8ljtjWXendZZOf8aJvg1ok6pYnnaCSz4Eimi6Yu
         OWSD0RBP8ppEy0XrTkd1w6TYCo1KHFsqDeHJY1a5ZukEWEEVYt/W7a9EjUGIUUhfeYCx
         BM+Ml3HZLzv0H5PJUKrhcT3vafcsbABzEKZzTWKPnMdveNx2SgPksJL4DZMLfp0sv0w9
         DINmSO+qvwMWmEntOKr606VrWmNNRE4tC89wg33AB/es7UmFJKqeWyunIoy0a/zKuQI0
         PJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774466572; x=1775071372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RCipcYHV41WSFUBdXxt5GlaKJxP2x0Xd6EISWGVu8LM=;
        b=kybI0MHt6MZelB/Xu2VfOJWeJSC0kjHKIbcEdqZqIUUHEjIX+EWw2p0r2ui0hEKexr
         Gi+a0KryOtlLfrzvWqE1p3njHmWKDDOlKLk6u6FN+6NKyyJRvpDaQLmxWZR/ZMnKcfpF
         O5vz/pLfNHMpMkJyYzYhZ6Pcq7FT5cCmmA0/oeInsdrjF6CvepUOWDWAJXrUe/EGxbDg
         kcO/0O2iqe6mdAM9bfuxnIsNE3dl7CHwHUI2cP54r2t36EaXEmo7gM2rmP2R1F/AR5iP
         QGFqUoOr2uDWxTTvXhrS6w3lTE4/HhJWK9am611RYmVcOyIuJwP0E4o/xoF/EzLYT1CW
         9x4g==
X-Gm-Message-State: AOJu0YxZqR7iDgkN+xKwgUBscmTpCFFfEm+dSsgWfb5ASwe2bQcnjkUa
	yoq37rhQjsO5pzmBUQBSUfNyKvGidzSHG9pvD3DvnoRk96BJ0YgGLL9PSTDWr+JTboWN0xAwc3q
	Jcdb1jET+dhvTgFvnBGecMg7OoQcnJ+bccKRL
X-Gm-Gg: ATEYQzyC7Nl+l5hZcGl4pxw5txgLs0Ja0NGC9sZPMchGlLK0IPoM51bq0cmhuVRwanH
	A43QXxhJ9yHw7cVV9BJIXXtUPZAWv2JzIxBMTCxxDSzT1eeU/KvT0TZdm+5zfbXq4hRBFta+hFT
	NkWAKuqtWjEStS3WwVys/Q0aaRPHzGZM5spU4G3TEG3Dr74fHT/QwQ8DiMI0E8Sv5okyAXu3PpS
	yCub+3S69P8clZOJ1204hNuo4cZXofH48l9nh1a0cYUQs2bgqZUWJ0EJu7Acr/t4AG85RNVGhht
	trU6oS0Kxl39fF4mohf2M2/G2D014pOzALmh0dfa/5Vp13kLu0zyNA8HwgcNvYu3xE0JMg==
X-Received: by 2002:a05:690e:4090:b0:64e:abca:564a with SMTP id
 956f58d0204a3-64ee609cf72mr4657741d50.22.1774466571780; Wed, 25 Mar 2026
 12:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f7ccb4a4f9e462a6c1c1ddba8dd1cdcc9456944b.1774459946.git.pav@iki.fi>
 <1eec5447ed02666ef9463bbc96c25971ce9c0d1f.1774459946.git.pav@iki.fi>
 <CABBYNZ+aBV2C6NQ=Pv_1ZRhhnntcd46bkOS2gj1sj_X4PoUjjw@mail.gmail.com> <96256cdd679395e70b8317db7655ec6dfc4c9386.camel@iki.fi>
In-Reply-To: <96256cdd679395e70b8317db7655ec6dfc4c9386.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Mar 2026 15:22:39 -0400
X-Gm-Features: AaiRm52DhZRww8BG39lIBBl62Wg6SBnuAJzKP9pB-RlaS3h6iryOKGpR6TIP6Ps
Message-ID: <CABBYNZ+exqVhSSkGgaMJk=FQsPorf_h5uSLQR8GAjbLshRzwtQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: hci_sync: make hci_cmd_sync_run_once
 return -EEXIST if exists
To: Pauli Virtanen <pauli.virtanen@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, Mar 25, 2026 at 3:15=E2=80=AFPM Pauli Virtanen <pauli.virtanen@iki.=
fi> wrote:
>
> Hi,
>
> ke, 2026-03-25 kello 14:43 -0400, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Wed, Mar 25, 2026 at 1:42=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > hci_cmd_sync_run_once() needs to indicate whether a queue item was
> > > added, so caller can know if callbacks are called, so it can avoid
> > > leaking resources.
> > >
> > > Change the function to return -EEXIST if queue item already exists.
> > >
> > > hci_cmd_sync_run() may run the work immediately. If so, make it behav=
e
> > > as if item was queued successfully. Change it to call also destroy() =
and
> > > return 0.
> > >
> > > Modify all callsites vs. the changes.
> > >
> > > The only callsite is hci_abort_conn(), and this changes its return
> > > value. However, its return value is not used except as the return val=
ue
> > > for hci_disconnect(), and nothing uses the return value of
> > > hci_disconnect(). Hence there should be no behavior change anywhere.
> > >
> > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > ---
> > >  net/bluetooth/hci_conn.c |  4 +++-
> > >  net/bluetooth/hci_sync.c | 13 ++++++++++---
> > >  2 files changed, 13 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > > index e6393f17576b..8cc2cc58c3f8 100644
> > > --- a/net/bluetooth/hci_conn.c
> > > +++ b/net/bluetooth/hci_conn.c
> > > @@ -3077,6 +3077,7 @@ static int abort_conn_sync(struct hci_dev *hdev=
, void *data)
> > >  int hci_abort_conn(struct hci_conn *conn, u8 reason)
> > >  {
> > >         struct hci_dev *hdev =3D conn->hdev;
> > > +       int err;
> > >
> > >         /* If abort_reason has already been set it means the connecti=
on is
> > >          * already being aborted so don't attempt to overwrite it.
> > > @@ -3113,7 +3114,8 @@ int hci_abort_conn(struct hci_conn *conn, u8 re=
ason)
> > >          * as a result to MGMT_OP_DISCONNECT/MGMT_OP_UNPAIR which doe=
s
> > >          * already queue its callback on cmd_sync_work.
> > >          */
> > > -       return hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NUL=
L);
> > > +       err =3D hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NU=
LL);
> > > +       return (err =3D=3D -EEXIST) ? 0 : err;
> > >  }
> > >
> > >  void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
> > > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > > index 0b28495197c2..47d902310b19 100644
> > > --- a/net/bluetooth/hci_sync.c
> > > +++ b/net/bluetooth/hci_sync.c
> > > @@ -801,8 +801,15 @@ int hci_cmd_sync_run(struct hci_dev *hdev, hci_c=
md_sync_work_func_t func,
> > >                 return -ENETDOWN;
> > >
> > >         /* If on cmd_sync_work then run immediately otherwise queue *=
/
> > > -       if (current_work() =3D=3D &hdev->cmd_sync_work)
> > > -               return func(hdev, data);
> > > +       if (current_work() =3D=3D &hdev->cmd_sync_work) {
> > > +               int err;
> > > +
> > > +               err =3D func(hdev, data);
> > > +               if (destroy)
> > > +                       destroy(hdev, data, err);
> >
> > It is probably worth splitting this change into its own commit so we
> > can add a Fixes: tag and backport it.
>
> Ok.
>
> Btw, sashiko produced valid comments on pre-existing usage of
> queue_once, maybe some of these should be hci_cmd_sync_queue or
> queue_once needs custom comparison API
>
> https://sashiko.dev/#/patchset/f7ccb4a4f9e462a6c1c1ddba8dd1cdcc9456944b.1=
774459946.git.pav%40iki.fi

Yeah, the data might be useless to compare most of the time, well
except if it is something like hci_conn for example.

> >
> > > +               return 0;
> > > +       }
> > >
> > >         return hci_cmd_sync_submit(hdev, func, data, destroy);
> > >  }
> > > @@ -818,7 +825,7 @@ int hci_cmd_sync_run_once(struct hci_dev *hdev, h=
ci_cmd_sync_work_func_t func,
> > >                           void *data, hci_cmd_sync_work_destroy_t des=
troy)
> > >  {
> > >         if (hci_cmd_sync_lookup_entry(hdev, func, data, destroy))
> > > -               return 0;
> > > +               return -EEXIST;
> > >
> > >         return hci_cmd_sync_run(hdev, func, data, destroy);
> > >  }
> > > --
> > > 2.53.0
> > >
> > >
> >
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
