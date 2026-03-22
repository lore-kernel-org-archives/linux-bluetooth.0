Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587A7367F3B
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774193885; cv=pass; b=FEAXavX3V03+gxjfTzkQ7H1ox8gxgMTcKXWQLPPHs76V8zywgWirztj8BgfpEJs0dx/qJXFUsT4uMeoEK1CsuqAqdGqLVWKgkt3Phmyo7dOcKtA/K+p899/A1e5UEY3PLDkO+VWjK8aaBjejFOQINrD+IM9MRMf71NarLZSWClE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774193885; c=relaxed/simple;
	bh=2iyufkCChmK3C3NNI3URbAXDxCjY1XVTVqwNvJiE034=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LValC67BGJsFO/j+dn1fpoyVYW5Qbpr3nkGAbVv6XxUXmRW7whRQkvntkMsgmOLB6/7vJCs2ZkCQXOjHTXreycnHDv0vFBNe7SCLmm4qGDS3ENI/PzEOmNKSdn6e34PqN21El34vTeVK8zJtcjeQ6qL2vDSGulkCj9yTukbjw10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEPDJyAj; arc=pass smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEPDJyAj"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-668d4751a3bso3099847a12.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 08:38:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774193883; cv=none;
        d=google.com; s=arc-20240605;
        b=DvmAKVGxw7k7U8XtHjiPEa7L3nuHsIlFlwxIEKToy96Men1hDtzpMueStrLMtR0nAg
         qi4X03znfVgTuHoRETqRv1tzh2XX8U/+rE5kBDdko0OZHfd0DTewVZEMOa8V3mxEIeAD
         g89DhUKpfodxjEuiqhNlFmMXoTWPBIwO0KNkl+GJsFd8z6XhOuLcqrrS477RRTNVKUnK
         bHPlIOCHjpLUq13Cs96/mImEi/vEPZPCxKLKEVAmg8+hb7/nUO/+7hMa1va6zWqjvdBi
         Ms5Y3sXp37K4akYYo5QymV/encH0C8KtYMqInDpSO26hoks+nZZy+LkLWA4pg+CckhNC
         M7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aCoJs6JbmGbtI1WN4Udl0z6hLtb+BVAEkUCWkGIOZuk=;
        fh=xXV5vIWjcJuGP9HuealM4TB2MMCMvBISdqpQRGdvrTc=;
        b=YblX9r9W0Iy+geomPCipBuq+BCt7rEm1Xw9DJVuOdTUqBR9OfTDL/yWP+CbqD9t+uv
         nUudoTQ241HvNxn2nO9QBC6VaHE2BdvCxhr1E3kI7ZNDCK/IjHKDpWCKm/uGszDxTkp+
         69eZuYzDbbFXklm04BCtW40OzgQV1aMb77dLSyJdonAu22JYTbCa6ZTiquM3dAcb/LTW
         nRuRJukpTJtZICTFdaahQ0IuqUmG7VVUQ7DZ2smVuXP2HUrA5f7YZtdGqJ9ZzDx6+QEV
         p2J2idneLX80KXDpy9XopvYEDtTM403kTbhjmwPF3DQ/oYDJYQ9JhtFOfKjwnPKN4T8+
         IKFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774193883; x=1774798683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCoJs6JbmGbtI1WN4Udl0z6hLtb+BVAEkUCWkGIOZuk=;
        b=EEPDJyAjOX2+DZ7Pbr1SKyA1l9+dhoijd6tjm7unrdhudc2zruN1x9dd4IZq5wwoMz
         vTd2/634Uw6W1/YLO5U8/C2U+le8xwEPs8fMQ/PrVe7uXQ2pzO37oayyijEG/v+4KM1D
         8RaPCpPQA7lWikIjbPksP/ZswhCPOjdgOBkmhI62r1w4SafEyFx9XwrW2nLYwKpBA+OJ
         t9JNOYQGW2R9fV9WlHePEJMtrfvH3f5dGns11w4+RKKmq1tUUlxgTJK7jQsBtEsozyqL
         p2arTlgjNPpiPxKiPOToVz6WZfViNAK24upd8kY7WNRuH4INxdqX9krbm4lFCm1Gaew0
         bn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774193883; x=1774798683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aCoJs6JbmGbtI1WN4Udl0z6hLtb+BVAEkUCWkGIOZuk=;
        b=d5aqETPJmFevKe/TntsicNrZCJECGzO5VRZguCxdHAlcBWSG/0zsqx7i9WHEUpYQrb
         CX9yv/asZU4fKb8nTO+383Ob2TB+RjugWPIoxemlXaP5p7fs9wPYhyQc5iOhHAnh097o
         Sx51de9C/4dsCfE3DA53pmIfmQvvBme+pn62I3n7CzzvXPQ97l1UZsTbVu4241MGOJAr
         JhAIhhZ66Oub9vTpb4pEKHj5n+wNlx7OplsYf9wu6XjbQnBlu1/N41FEWOXGM1gLdmT6
         8R8gEd49Mt29J4/BW+prnDfqpoHKbEvCRJUSt00gfLGg+uWGzBDPGFYTCw007g1cuGzS
         jdWw==
X-Forwarded-Encrypted: i=1; AJvYcCXrPY/fyK1uOw2tiN1A6gfgFIEbjxgVt3C7SdM9mzRtFmgxA9aY6myCP2cdQDxgkl6khG7KTSFO/QP09dFd+Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKzheUX60MHEdSubj1ijXrl8Qb7JpmFe1MPSfl5gQHKZFGbzC1
	Rwk1vKWhLonsvcTH6ceFTCyhRUdEEHwrySkuMBV1/igJTLAzp2pTWlBr/YJgBO1MdfcfWMITyOV
	0jfSFtiuZh84K4A1j+MO3UTUG0fvyAfQ=
X-Gm-Gg: ATEYQzzidd4JRHMFTFB47u7TNvzQanrp6g1SKlbJj/kZRD7rwPvvGI2L0IUErsRae2d
	UyJQhCwRqdRkB9deSUnVeYIEifhtFtdJiZ2O2Guo0oJbLptGukWZNCR2o+428Nquvr4CFnqqFuF
	rhQHuxD1XveRHSvTq+DYFNqS1Bt1oDegrjmjrLepF5Mzb8qCs4nLICIepXe20nCS+lgk3zi5old
	ViHpnG0eD2OgDO0NLkTgnuhUNmM2pMSuiiV9kNaG1IIJQcZdX/CUB9hLrqahhZexAtxtF04pQID
	pBKNtMhPjw553upZX2vLBnGlo0wMZMPwh0C2DAg=
X-Received: by 2002:a05:6402:1ecc:b0:668:368b:38d7 with SMTP id
 4fb4d7f45d1cf-668c93239dfmr6585165a12.8.1774193882341; Sun, 22 Mar 2026
 08:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZ+9Z8Yd9mRhgz0N9kSSvLR-6euPf9CRA1Sop_D8zV8wqQ@mail.gmail.com>
 <20260228172657.53040-1-ericterminal@gmail.com> <ee5fc583c7d6dad138db759cddd84e409190d1ae.camel@hadess.net>
 <abFA9nm_fBqw8mNS@beelink>
In-Reply-To: <abFA9nm_fBqw8mNS@beelink>
From: Eric_Terminal <ericterminal@gmail.com>
Date: Sun, 22 Mar 2026 23:37:50 +0800
X-Gm-Features: AQROBzBauQzm29du9pe-bkZS9i4dd3Z3Buwh7em_P0ixOAlN6NN3EOpYsbqh59Q
Message-ID: <CAKNPVZCm9joG7szVjMa2VZuqF_oY5nBqWjjLYa8rqReqWeZ0tg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: HIDP: cap report descriptor size in HID setup
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Bastien Nocera <hadess@hadess.net>, marcel@holtmann.org, johan.hedberg@gmail.com, 
	luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Just a gentle ping on this patch.

Since Benjamin reviewed it from the input side and concluded it should
be safe, I was wondering if there are any further comments from the
Bluetooth side, or if anything else is needed from me for this to be
merged?

Thanks,
Yufan

On Wed, Mar 11, 2026 at 6:19=E2=80=AFPM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
> On Mar 01 2026, Bastien Nocera wrote:
> > On Sun, 2026-03-01 at 01:26 +0800, Eric-Terminal wrote:
> > > From: Yufan Chen <ericterminal@gmail.com>
> > >
> > > hidp_setup_hid() duplicates the report descriptor from userspace
> > > based on
> > > req->rd_size. Large values can trigger oversized copies.
> > >
> > > Do not reject the connection when rd_size exceeds
> > > HID_MAX_DESCRIPTOR_SIZE. Instead, cap rd_size in hidp_setup_hid()
> > > and use the capped value for memdup_user() and session->rd_size.
> > >
> > > This keeps compatibility with existing userspace behavior while
> > > bounding memory usage in the HID setup path.
> >
> > Cross-sending this to linux-input@ for review, they would know the best
> > way to deal with oversized HID descriptors.
>
> AFAICT the hid-core code would be fine with it (it would parse it), but
> there will be some issues (hidraw will not be able to export the entire
> rdesc, so is the sysfs).
>
> For reference, usbhid just returns -EINVAL for oversize report
> descriptors.
>
> Anyway, if the report descriptor is truncated, like in this patch, the
> hid core parse will fail if the data is not correct, so I thing this
> should be safe.
>
> Cheers,
> Benjamin
>
> >
> > >
> > > Signed-off-by: Yufan Chen <ericterminal@gmail.com>
> > > ---
> > >  net/bluetooth/hidp/core.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> > > index 6fe815241..31aeffa39 100644
> > > --- a/net/bluetooth/hidp/core.c
> > > +++ b/net/bluetooth/hidp/core.c
> > > @@ -755,13 +755,16 @@ static int hidp_setup_hid(struct hidp_session
> > > *session,
> > >                             const struct hidp_connadd_req *req)
> > >  {
> > >     struct hid_device *hid;
> > > +   unsigned int rd_size;
> > >     int err;
> > >
> > > -   session->rd_data =3D memdup_user(req->rd_data, req->rd_size);
> > > +   rd_size =3D min_t(unsigned int, req->rd_size,
> > > HID_MAX_DESCRIPTOR_SIZE);
> > > +
> > > +   session->rd_data =3D memdup_user(req->rd_data, rd_size);
> > >     if (IS_ERR(session->rd_data))
> > >             return PTR_ERR(session->rd_data);
> > >
> > > -   session->rd_size =3D req->rd_size;
> > > +   session->rd_size =3D rd_size;
> > >
> > >     hid =3D hid_allocate_device();
> > >     if (IS_ERR(hid)) {
> >
