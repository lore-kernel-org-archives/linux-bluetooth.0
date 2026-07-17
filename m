Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D36400981
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784297190; cv=pass; b=d2lZEiYg+0Cd9n6mDabBpEVUgi9NvZOKOzUyuKAngM0QazdO9H3+ZxQF2UYk+p0/Dl7Vqdp+v/a9MdUnjpfEjxD9xCNWJ4vtdErQBUhb6X7HYPtJ6qdtTO7pSJ7YXaKH4MI34Ue1B1vy7mLyGG/yiRUIuvk2phmwH5GM2Cb8aLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784297190; c=relaxed/simple;
	bh=VdQ9uFAJiiOOB54pGR8vlKUMj4lcyHnUiYeiyCZbYKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7wLr08sxwCmN0QydQtY45fcFyleoJck+k/QdEPP6TPo8PsD44Tzb9tKPmrWdUIcWlvgH8RfIflkaqCvQiQXMaeKgxEHg+Q8DYrKF13M+qHzjwjQ/TNBCv3qhF/qhMcpukWqfc4tQSrk1hp/1IX7kQMCPVtjYqilwyLn9ZMDfEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+xfEPU5; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+xfEPU5"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81e6f2ee60bso14083487b3.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 07:06:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784297188; cv=none;
        d=google.com; s=arc-20260327;
        b=ll33Mb0d2uUHVzAXtARGqn7mn+Bd3Cz7b/V7UKALhPEYfRS15ICW5O5zCf9oLuncui
         o001bfdrxA5VKjoYIIkEkgJ/ZDxtPIeC6ij+h2l8e/49pintN9I54XDCLo0I8YY2c0nK
         NQanOkWsoz2TqqfWkpIg6BjIoVx53gBWkub3doZEztmZipOFkzt3ZnJkUcl7Z+GzUe31
         poXl2FQEFImN3d3XLNRYLj9FRJ0ws5oSQs8ftbknQxYOrlsvT4pMRKZPw1Uy7rYsXScI
         ls1ydfXmL5C5gOHyPJJw9gMXuJzHmSrLLPauNnTeEpi3GPxuXa0w0xw28N5c/vpd9jnG
         bHxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lBVELT/H3K+iuzoVTbPCXfZrhkyR7GoAkD5jvzLrrtM=;
        fh=TxHmgKhQfYbogoK+vmJQIDCo2t34N8xamZxfQlSL1ls=;
        b=LrJeZ/EVoNbYAIojl0sk+hocWxD47DzNx5iN91Ee3oH4die0jqrXx7qviWlbWZQmzR
         RQxw13JneKMS4NSJ6AtY2V1l7Wt50l5rKR/Z93csAy2CY7Bb1tu/7UUotDtH7hqrBwnb
         4QZbC4rvVCMZ5NzHF8Z+veFBC3SlupdSZnOtMvb9NwDy6PwxfmK7KPBrea7CdQx5UhiI
         XwwPSi2uJDgbDbj8M4zX0F/yALKeYZMGSNOZz0l05CC+/ND2DnyTyCjvOkkj+gAT2zFk
         1LSwkMU7mf75zyxYTHRm5L55XATXvfWdLplZNMXnoTcVtWco5rQNmJ8Vq69cboBh+IeC
         yZug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784297188; x=1784901988; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lBVELT/H3K+iuzoVTbPCXfZrhkyR7GoAkD5jvzLrrtM=;
        b=K+xfEPU54dpOSiWazy5V1kaD5PVEwbI58rBotMLy16qtihdkq1viCN8pgqf4cArMFc
         ydwEa/EGFR6veFPwmhLL0RjvUW2+HDPzELy1NyBjdncL4DUShIcvvUKnV7eX/ew56EFR
         WbtvFjqTDzu4JNQUYE0OraFfEEe3AHKbiYmCRI6FtzRG+UDUEjlKPeB3wkxO/ZJMjUwk
         keV3osmK2amM4qQ0ycucbTZk32Php/XxdyhOy1rZ4zRq5ZsB5pJssmfPzK8yZ/iv4HJv
         tX25LRkyjxBAr4I7C2apWDfl7xkZ/LPgyzLr5Xb8tNV2SOr6FOg25Fvt7vhwjgrf4mSm
         2ukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784297188; x=1784901988;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lBVELT/H3K+iuzoVTbPCXfZrhkyR7GoAkD5jvzLrrtM=;
        b=E1jzic0MbtF5q57QVCMX5SKMR9x60fb4ABHF0QfGnOoCe5XSVJmMk5NF6ML5f8roST
         jl7L2A6G/yzGWsvVrzB7WsdD51IDd4QA1Y8KDYeIoKskSUT4LLXyXe9kbZEFbeyPQT6p
         G/8iEKccF1iRexkDdSRAp5BmZTiwCpw8hPRnRsgdeiXvjidp/XxR4Aedsqn5K5YB/eey
         yPVPeeNTkyqtfDi6BAGDue91lOWyQoVCTPPgkpd4Ear4ICjFlOlA0CpgIarQuP8lTbK7
         OSPxx8DdQep95Ja304l5MJ+q++TZzA5tw6c5I1p1zSJ7Ihsz2UOC6lYh2SRhfrisAjwv
         QadQ==
X-Gm-Message-State: AOJu0Yx0T7eeMg/tVrjhZhvpbBNNDrxysLK7Y2EW5e6TVXLJtREx8WJS
	eTOgDcWiiPKd5kp20bpzufYzFQLpde+VBuTVfVSddQ5Co0xUhLGey6axPhLtGioMPH1+ekQe+qs
	VysGGnQ+sCHcYPlwWnfzL9Ds4P4nNsFI=
X-Gm-Gg: AfdE7ckaLGcc/dTeBp8Nv6sjBc1E2vpuOGZT23VhgbaDcUzvUJFEuLUKiKZL45NN3OW
	U5zX3mDdzXPy/ayvnw5trY/n9e7MDIXOArwTw3AIio/bQwsay97HSObMv9YBhUrHj+cdEH2OBF2
	mL/18Fj5pz5TBK+NigIdIX2r07aBwPSEqPMFeuxksPc+0kP45cX3z0MglNQ4z6vBbG2p3EMrKkI
	FvY99ZQ8wfhujVWbTGq89006UlC7ZmbTVoXtlceSWyYNWFcE/ElDFKXhdtKsWiZnejQx5IuiFaZ
	SRkshuf6kvWzubHU+oqi7e2unc+kfrF19k4ZYEHftCi3jKYe
X-Received: by 2002:a05:690c:6c92:b0:81e:6b13:445f with SMTP id
 00721157ae682-81ef158b10dmr9328117b3.23.1784297187971; Fri, 17 Jul 2026
 07:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717124111.3296537-1-naga.akella@oss.qualcomm.com>
 <20260717124111.3296537-3-naga.akella@oss.qualcomm.com> <CABBYNZJuitiNCz_COYYvUEY6_TbB=d6dZet=XEmHUkh=ENrzSg@mail.gmail.com>
In-Reply-To: <CABBYNZJuitiNCz_COYYvUEY6_TbB=d6dZet=XEmHUkh=ENrzSg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 17 Jul 2026 10:06:17 -0400
X-Gm-Features: AUfX_mwELD1bxT8ld5EYx7mHtNsZ8YiSbZflY0rCOziyEbrZxKc467b3dKmBjDU
Message-ID: <CABBYNZLpp-hMUrevPX=_qD5F6Jh2yH+mLJD03A+PSQsBErxAUA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 2/2] profiles: Register RAS UUID reactively
 instead of probing
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Naga,

On Fri, Jul 17, 2026 at 10:02=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Naga,
>
> On Fri, Jul 17, 2026 at 8:41=E2=80=AFAM Naga Bhavani Akella
> <naga.akella@oss.qualcomm.com> wrote:
> >
> > Replace the unconditional reflector-role GATT_UUID probe in
> > gatt_client_init() with a reactive registration driven by actual
> > remote RAS access, using the notification API added in shared/rap.
>
> It seems you already have something like that in bt_rap_register
> attached callback, it is just never used, which explains why
> rap_attached is never called and you need the likes of probe in order
> to create rap_data_new.

In case I wasn't clear, I meant shared/bap.c needs to call
rap->attached callback whenever a session is connected, just follow
what was done in the likes of shared/bap.c which does bt_bap_attach ->
bap->attached, so bt_rap_attach shall probably call rap->attached.

>
> > ---
> >  profiles/ranging/rap.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
> > index 3ffc0da76..4f6d7f2db 100644
> > --- a/profiles/ranging/rap.c
> > +++ b/profiles/ranging/rap.c
> > @@ -308,6 +308,27 @@ static void rap_attached(struct bt_rap *rap, void =
*user_data)
> >         rap_data_add(data);
> >  }
> >
> > +static void rap_ras_accessed(struct bt_att *att, void *user_data)
> > +{
> > +       struct btd_device *device;
> > +       struct btd_service *service;
> > +
> > +       device =3D btd_adapter_find_device_by_fd(bt_att_get_fd(att));
> > +       if (!device) {
> > +               error("unable to find device for RAS access");
> > +               return;
> > +       }
> > +
> > +       service =3D btd_device_get_service(device, GATT_UUID);
> > +       if (!service) {
> > +               btd_device_add_uuid(device, GATT_UUID);
> > +               service =3D btd_device_get_service(device, GATT_UUID);
> > +       }
> > +
> > +       if (service)
> > +               service_accept(service, btd_device_is_initiator(device)=
);
> > +}
> > +
> >  enum cs_dict_target {
> >         CS_TARGET_SETTINGS,
> >         CS_TARGET_CFG,
> > @@ -830,6 +851,7 @@ static struct btd_profile rap_profile =3D {
> >  };
> >
> >  static unsigned int rap_id;
> > +static unsigned int rap_ras_accessed_id;
> >
> >  static int rap_init(void)
> >  {
> > @@ -840,6 +862,8 @@ static int rap_init(void)
> >                 return err;
> >
> >         rap_id =3D bt_rap_register(rap_attached, rap_detached, NULL);
> > +       rap_ras_accessed_id =3D bt_rap_ras_accessed_register(rap_ras_ac=
cessed,
> > +                                                                      =
 NULL);
> >
> >         return 0;
> >  }
> > @@ -848,6 +872,7 @@ static void rap_exit(void)
> >  {
> >         btd_profile_unregister(&rap_profile);
> >         bt_rap_unregister(rap_id);
> > +       bt_rap_ras_accessed_unregister(rap_ras_accessed_id);
> >  }
> >
> >  BLUETOOTH_PLUGIN_DEFINE(rap, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAUL=
T,
> > --
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
