Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4BA3148B2
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899306; cv=none; b=dR36HVSk7cfEUEgrGlhHFst5WmLSObqWGXdRmGhZO/QFSnIuxjkczHhpQ+REX/Q/sLiKWQvNds6gdBNB8Of4CKYLAdoeBtWqEGuSOmx2wJlyy/PcfHqM9dXoKOSDOU/CyLIDVt60mtcJWdqi9RXvNQANyLLsuUovL1N6f4eddwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899306; c=relaxed/simple;
	bh=paj68YlKuDhphsTveBORIQr4jqi0QmKHl7Ze+tZI5DY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QUu/IhiQIVBjNfb/Y5iA6rDKdDzVsSgjK5uO4jSEYcGcByQZnRAtIwba6DhaW04yo8c2es++XduvoJeJD/uChhyF/LMChWBAlTyAA8RTGdFfOsNR+fuuOwtrP4wsr/JFxUUDdBfGJBOIZuVrf07UfMqX4KPvuj5MxtQHiGpM77Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFuDslvv; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFuDslvv"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7904a401d5cso39252187b3.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jan 2026 11:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767899304; x=1768504104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZ+Ju5pkye5pKeBr6/aXHrkqHDRAXzZc4AYMADkQUTQ=;
        b=UFuDslvvARbgCR3DXD9ec5PkgUc4Mwh/2XSI7yIGSabFXGTxfto+sAiBjpElilmp9W
         Q6kEp4SMkFK7BhkMmcoVQPNrXDdMvNoS/TUXBBrTZUxhgzUr4NqghfeI3Vr22PBqBM6u
         n5q2BzSbw9tojpb6bcnhyE+Yqo0ktW7j0ATIGgN6NdRSP8fj/NMNgAKg5FDwQmfhWFcQ
         ZqAQMiduAcq0gGXAxgx/ACmqCUGTO/Qomvv6sZpI861do+PoGSQKhRlwN2l7OJonRS4G
         /SBT80LkJBeBOXFWjyUdU6lfMAlj6h8OEQnGofM6/Hud6zkDuq6niMw9uU0YRpMC48Vw
         8gUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899304; x=1768504104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OZ+Ju5pkye5pKeBr6/aXHrkqHDRAXzZc4AYMADkQUTQ=;
        b=pFY69Lah/o93/Tfepa9jpokjXdkPZKOsk2UZ3JVN/WToPduPJ9i3rscqlIDdE3cgay
         ZpN21vmdWOXIoNavDGFEkJ8rTxxYAUhtTOEXnS+AjB9D+j4T8t0aybtG55X0n2L4WjyK
         AJlzPBfO8DzI8g9kHdrOxCu42vzyK02Itz9fQ6rjM7r+Yf7U/9m6O9UWawuCAeDedIpA
         gbH2pDY0beDYaqxw/zD+Pb51viDSsUVb3NUXQYr+lu16b9bQ+6ilT0C8k0Kt2sx2+IeF
         zbhIghXspXQdXm7i5jJYlgc6zAvf0jqMPVvpVbf/1RvHpYHYeabGuvQqehjidJoVJWXE
         e2Sg==
X-Gm-Message-State: AOJu0YzV6ctaPzdEV7tIZx9EBkOd2822kxSWTJaLBVl1XF5L+aM54lfA
	zcMdVv2dvjpN06ma1amlozVXyjZxaAVNlJCUEMDfHcl21+/Z3YATh/VdMMzoXytJ3Iko+MwQtls
	pepYAXsTFiJC9waHdbycF8xhOp4PM4V8=
X-Gm-Gg: AY/fxX7DU/SMYHKKCaWYtVuCiaHMxxPecupe3FZoTv1XJL5Z56oUxgn6x6KPPaBzCu3
	aPz80utXa1hDiYr71AgyN73vxoof72xuWq8N727p9RZi9w9ImUzna2suQ7fuKBW2ya9sauG45qW
	XiZfkp/Z+UQ1a3JIL1Xthy3EZ3H5KVWwvU6CZnsniYPpQhwf9v8SgoSmM27AmXOtLCjpVmUqB/X
	6wIWoS/ITA4SFvQ3vFy7hdezk97fzICgJ8TWPdj7XH4mPVKTEgOAnfVSvzzWYG0TU3v6FY+vtR6
	35h5mSIF8PNa0QERTotzkat7KdGwSwQ0wi3/SH1lMKXZR41ET7J6QFM=
X-Google-Smtp-Source: AGHT+IFR5Eq5/InMp1p62pjk/Q1CmbdRJFd59dlZ/1s+Cfy8rkWpE+g1rssfeSt1l6gXvKyPNIiYxOSWtv17OJ9RPls=
X-Received: by 2002:a05:690e:169e:b0:644:5c0a:6bd4 with SMTP id
 956f58d0204a3-64716c1354amr5750950d50.70.1767899303096; Thu, 08 Jan 2026
 11:08:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108100136.486675-1-dalegaard@gmail.com> <20260108100136.486675-2-dalegaard@gmail.com>
 <CABBYNZKT91_1arQSNSxzy-4RVVnAX+BV=Vw6qBMyCHjQSdE_KA@mail.gmail.com> <CAJWtJbasVwvFsdhOpc_fBUW_vSyS6=YbRza7LRw3e8mWH44ZbQ@mail.gmail.com>
In-Reply-To: <CAJWtJbasVwvFsdhOpc_fBUW_vSyS6=YbRza7LRw3e8mWH44ZbQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 8 Jan 2026 14:08:11 -0500
X-Gm-Features: AQt7F2oXt2ohGtk6iZgXt_SdE6Du3T1IAog29EJ4ZCRiSZJ8ArLP0MEhenbdilg
Message-ID: <CABBYNZ+gqdm2a53T_8wY1Fkjre0mZmH0kpCoYOVO5G_izvpzXA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] device: fix memory leak
To: Lasse Dalegaard <dalegaard@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lasse,

On Thu, Jan 8, 2026 at 1:50=E2=80=AFPM Lasse Dalegaard <dalegaard@gmail.com=
> wrote:
>
> Hi Luiz,
>
> On Thu, Jan 8, 2026 at 4:28=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Lasse,
> >
> > On Thu, Jan 8, 2026 at 7:29=E2=80=AFAM Lasse Dalegaard <dalegaard@gmail=
.com> wrote:
> > >
> > > device_add_eir_uuids creates a list of added UUIDs, but it was never
> > > freed.
> >
> > This seems valid, how did you find it though, I don't recall seeing it
> > with the likes of valgrind, anyway it would be great to have the
> > information how this was detected.
>
> This was detected with the address sanitizer leak checker.

Interesting, Ive haven't seen it although I have the sanitizer
enabled, I think, but anyway it seem to be correct, do add its output
though so in case someone e.g google for it it shows up in the git
commit message.

> >
> > > ---
> > >  src/device.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/src/device.c b/src/device.c
> > > index c8aaf042f..0842becde 100644
> > > --- a/src/device.c
> > > +++ b/src/device.c
> > > @@ -2453,6 +2453,7 @@ void device_add_eir_uuids(struct btd_device *de=
v, GSList *uuids)
> > >         }
> > >
> > >         device_probe_profiles(dev, added);
> > > +       g_slist_free(added);
> > >  }
> > >
> > >  static void add_manufacturer_data(void *data, void *user_data)
> > > --
> > > 2.52.0
> > >
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
> Best regards,
> Lasse



--=20
Luiz Augusto von Dentz
