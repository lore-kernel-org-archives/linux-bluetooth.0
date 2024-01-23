Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8EF53812
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022863; cv=none; b=ZwxBLGy1M55+qio2ABwuprloEy0NnFy0NLS4LEsRBSjWSFvRjK2SRbSQF6K3MoTW35SoGwiG7AJo+fSV9kb8xK0xJqvho8Z2si2wb2z0UPMt2NB7Y0xJyzKQjaY3B7FbKk/fVE3wrzlI560LJBabYfInNJpCGrOJQP3q7riKfsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022863; c=relaxed/simple;
	bh=b4Zc0degP72het/XVUAA7rCZgFaZZe3sc/gnS5S7Oro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/TPuvhOoNrhNyk/MBBDnavwn8jWYxYm9VfLYNuOjg2Tm6HsOIi+chFg0rh9bkSa8b+wK8KC6J/ZhA4Ej8bqK7Hob485EkRwfnffsIzAHETM5bScYJcTC78YOXD8a4MbuF38svCR9u426W4DuzfghsbYzABDPT1xcKoWPs68TLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/hTGbAc; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/hTGbAc"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cd1232a2c7so59599861fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 07:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706022860; x=1706627660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mf9B4X1qVi8AtJEpNNoNWj+oRsqYqKydgEdwnKYN1Xg=;
        b=X/hTGbAcKW1PEa//9dtbFgpeIL3aTxA0UYWWWKgh3GTRY0EA1G+E6QOvIoAmqDVomG
         nEAHNvtL5JCy7D566+uot7DZCMGoRfX/tYQ/ncKSBK78UyBS/acD7RZtodAVKE3i5n+4
         7b5XhJan2551VH/w2ECfpl0abn6S0f07f17dDz2GBfH9lRo8GgVyJXs6W/MELHFX0pUz
         51W2TIkpp3vXk3tnxVwYfmw3jNwdEZJkHCaO7sAldkFwXbOX3zf9m8ZSlLmkNmCyV9CT
         nIBaV5UfsUcIl5W9x7johZxKqS0c4UCS1J/Kv5G20DG5jfDEjL1b4ZUclh/iIiRZehdm
         srFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706022860; x=1706627660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mf9B4X1qVi8AtJEpNNoNWj+oRsqYqKydgEdwnKYN1Xg=;
        b=PB08rX8+ijLW93jZqLVt0/Gb+Vk+fECC1PnExJq+hu0NbiXsa14t0OtY3P6OjqSg57
         Kt6FElT8Cp2hq+pGemdoViGhTiMtGXtTQprlOdqaZXpSTlwf3pAw+/Uyaz2W6vhQvU5L
         pl3T4qoy1vTmzy2cD16bZzy5OOvMrtNUi3ldNoS1sE4/7fhCseZVQqAte/ORDj0MUHSJ
         2+nZOHGB2hb6UvLR5DzK2IiDo4TTg8EFy3LxEjfayQbLcT7ecXBunyFiKPA9Q2WTO6kB
         cr5Ky6/8/CmkfAvFQeMj3HtGiI0tIpmXqSchsKgLUfWFrjkaFsQ5AiZ3n3/2a898IuPf
         WeTQ==
X-Gm-Message-State: AOJu0Yy3K2Fk12xRyzP321WDmRwojjyRHeFqPhpzzhjaekxP/P83No41
	zcHgcD04PC6xQ8CqaIrsc3vPtBLvjgUgMAzf+WnYT1OJ/RQvRT770ex4008OmiecG6ArQnvKPYY
	mBntkTzdey8KkuTeVBLf/3fIUUaHoyJbd
X-Google-Smtp-Source: AGHT+IGlvxIAPp3wiLzqbz3IU2obduywWs9a2o/S3xSMvz1zdiP2phfuqdRhsUoRXIgXqRYfUBWevqCaAS8oNABdQ4c=
X-Received: by 2002:a2e:bc83:0:b0:2ce:d1d:e97e with SMTP id
 h3-20020a2ebc83000000b002ce0d1de97emr2533925ljf.102.1706022859846; Tue, 23
 Jan 2024 07:14:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123121519.523735-1-frederic.danis@collabora.com>
 <20240123121519.523735-2-frederic.danis@collabora.com> <CABBYNZKMry5Vh5Xu5t7ykoWOo8zjqjVfS+zfYk1fxDomHRpDQg@mail.gmail.com>
 <741ff02f-596c-4c50-b809-d5fd39b77244@collabora.com>
In-Reply-To: <741ff02f-596c-4c50-b809-d5fd39b77244@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 23 Jan 2024 10:14:06 -0500
Message-ID: <CABBYNZ+bmanaepVN4Xq1kiOqjuZJ07mtKcFBqjVsefw-PwYkew@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] device: Update local and remote CSRK on
 management event
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Tue, Jan 23, 2024 at 10:00=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> Hi Luiz,
>
> On 23/01/2024 14:53, Luiz Augusto von Dentz wrote:
> > Hi Fr=C3=A9d=C3=A9ric,
> >
> > On Tue, Jan 23, 2024 at 7:15=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
> > <frederic.danis@collabora.com> wrote:
> >> The local and remote CSRK keys are only loaded from storage during sta=
rt.
> >>
> >> Those keys should be updated on MGMT_EV_NEW_CSRK event to be able to
> >> perform signed write for GAP/SEC/CSIGN/BV-02-C.
> >> ---
> >>   src/adapter.c |  2 ++
> >>   src/device.c  | 16 ++++++++++++++++
> >>   src/device.h  |  2 ++
> >>   3 files changed, 20 insertions(+)
> >>
> >> diff --git a/src/adapter.c b/src/adapter.c
> >> index 022390f0d..fb71ef83e 100644
> >> --- a/src/adapter.c
> >> +++ b/src/adapter.c
> >> @@ -8882,6 +8882,8 @@ static void new_csrk_callback(uint16_t index, ui=
nt16_t length,
> >>                  return;
> >>          }
> >>
> >> +       device_set_csrk(device, key->val, key->type & 0x01);
> >> +
> >>          if (!ev->store_hint)
> >>                  return;
> >>
> >> diff --git a/src/device.c b/src/device.c
> >> index 17bcfbc49..34f64ca5b 100644
> >> --- a/src/device.c
> >> +++ b/src/device.c
> >> @@ -1955,6 +1955,22 @@ bool btd_device_get_ltk(struct btd_device *devi=
ce, uint8_t key[16],
> >>          return true;
> >>   }
> >>
> >> +void device_set_csrk(struct btd_device *device, const uint8_t val[16]=
,
> >> +                               bool remote)
> >> +{
> >> +       if (remote) {
> >> +               g_free(device->remote_csrk);
> >> +               device->remote_csrk =3D g_new0(struct csrk_info, 1);
> >> +               memcpy(device->remote_csrk->key, val,
> >> +                      sizeof(device->remote_csrk->key));
> >> +       } else {
> >> +               g_free(device->local_csrk);
> >> +               device->local_csrk =3D g_new0(struct csrk_info, 1);
> >> +               memcpy(device->local_csrk->key, val,
> >> +                      sizeof(device->local_csrk->key));
> >> +       }
> >> +}
> >> +
> >>   static bool match_sirk(const void *data, const void *match_data)
> >>   {
> >>          const struct sirk_info *sirk =3D data;
> >> diff --git a/src/device.h b/src/device.h
> >> index 8bb38669d..d00c002c3 100644
> >> --- a/src/device.h
> >> +++ b/src/device.h
> >> @@ -134,6 +134,8 @@ void device_set_ltk(struct btd_device *device, con=
st uint8_t val[16],
> >>                                  bool central, uint8_t enc_size);
> >>   bool btd_device_get_ltk(struct btd_device *device, uint8_t val[16],
> >>                                  bool *central, uint8_t *enc_size);
> >> +void device_set_csrk(struct btd_device *device, const uint8_t val[16]=
,
> >> +                               bool remote);
> > Looks like there is only one use of this function and it is always set
> > for the remote, actually the fact that this is on the device object
> > already means it is for the remote so I wonder if we really need to
> > store the local as well?
>
> As device is able to store and load both keys from storage I think it
> could be better to keep them in sync, no?

Don't we have the CSRK stored at adapter level though? Or we have to
generate a pair of local/remote CSRK for each device, if we do I'm not
seeing when we store the local CSRK.

> >>   bool btd_device_add_set(struct btd_device *device, bool encrypted,
> >>                                  uint8_t sirk[16], uint8_t size, uint8=
_t rank);
> >>   void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bd=
addr_type,
> >> --
> >> 2.34.1
> >>
> >>
> >
>
> --
> Fr=C3=A9d=C3=A9ric Danis
> Senior Software Engineer
>
> Collabora Ltd.
> Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United K=
ingdom
> Registered in England & Wales, no. 5513718
>


--=20
Luiz Augusto von Dentz
