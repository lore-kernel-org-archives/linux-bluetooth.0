Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794334698;
	b=mR37JyWo7Ra3Yo5WF/Pkap3UI9EPl4YoZ7kfFn7sx1fmfAxE1ULNUWmlyMELImknyl7b
	 /bfzmYP+TMKEPcVlbJ/VypgImBQNCi/0waNq5++ayQG/n2IktCan16DrQTVbBYul4Yal5
	 ZXGsMUndc65bi4/MT7NAgkz7wvHRhBQRx3YhIYAoByRQZ8UHO/JW0zFH0jn92BsIhWtJp
	 xLH/c5OPHoB9T4Ma2Om/ZPr156g2S//Kf/6COTS1xfnw8yzCKJuwwo70dQSywTjTKLDqn
	 k7HuhquJvzxGoJymJyZpUCPl2Qff1Aw5OHYpbs5qJDxZVF4HLQjqpQMTBYG+cWep5lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334698;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=80LZM7vxA2rau/UmsJfrKvz5NtsF8B/PIiFDePQDDVI=;
	b=OywjH/4YBtVshGN97CzgO4DM8XnLqPRYjNaqnhh3K/TvcJ2G5itCYAI6Rq5abm2Ts7OE
	 0Kqe5QEJLHEMqAUoIZbyfJAMkllCCJxSk4CnGDlxLJOiVpLhz0riJOBfjNLX4Z1zIqbSS
	 29D5VB/AfGGbGQgbR54AstUB+Njg31DS1kHUJthr936vrPnYKiP3cXebDqbSB/87d5aMa
	 Sri+Ket+YJUauHj5wwSVfoE5AQ8RYOgP0TUVVOMOUh9NG2V+IFxiIDIcw0BLvk3TLUWvg
	 hibJQRK5fwj0U8vf5SIM5X2DlE5KbBOY85fQqJFe6DmFeG7YODHMVHelg5nUL4L0svA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=Y7M5Lxs2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205E9606A320
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 18:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 205E9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=Y7M5Lxs2
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b577addee9so3254770a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 10:18:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794334694; cv=none;
        d=google.com; s=arc-20260327;
        b=P1ktkTHM0TB9nlSkeJxbOVl8w1I2hkl7WBLzqV7OU8U2ns8AjzVGfIUhvOCawGvzsB
         b2+4edHdWFhRLz/e1BkXD3jr6tvQuHxYwnkoiPbDII2MQYbXRaRCQ1rto9ne/io0ja+6
         T3pA/1bOyHzXD2151sABfUJpUB7LG5tu4h+YS/AzxDVjHBfNGvb+G0lQ9e4byirLBF9I
         bZ/qQIWfm34gz0uAlZ0X1iJ1U50Fm+vwek0E8cZbdWMo9iKR33EGGAHD0KawO/YQUbRo
         38cDK/l41tX68hYLT4lPdb0UzwY8xEiZsHVD9lTPSRax7zhTzYKZr9MZunnViMJ575Bh
         LdSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=80LZM7vxA2rau/UmsJfrKvz5NtsF8B/PIiFDePQDDVI=;
        fh=MQ3fIGNOcEnWxkEV/4zG699KKHD3edIJINkuwCUoIxU=;
        b=RbgHMU6uSy8UGx4nLDMYKVkRKThqtnsQESHXYDU295R1i0DOB6+dE4VU12uTqiF99O
         tZMT/s5UeHUEpHnLrKANVXQo61mdAEC/JqJQr0KAtCk0DwQFAOjkW6KxUTWYjyVDs1xu
         YsAmpAsxq/0EqMra7OCERHv+uBPlFvFFztGzaaKz7Ff3rhnm8Y0Tux9qgXO/fWzrc1Tn
         q4d8LLiX9RBogPebdZNTiFRJdq2Ot6JLOTCfgtVc0bEh8OKibzhfFubT26B3ORrV22Au
         gs/r9XsGS7coP6FcmxxBdfyR/LsqkDDIr3lLKp9u2JOYHjdsdPWRLvzSubYjX2TF1+nc
         YIQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1794334694; x=1794939494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=80LZM7vxA2rau/UmsJfrKvz5NtsF8B/PIiFDePQDDVI=;
        b=Y7M5Lxs2TuWQ+gyJvw4GYS02oviT+iOC7pbyCxdE9TEDOV4CW+fGbhifuD0yfgmkdw
         yjCqIxNrFVTWQb4govlTxDZrHRf9UUFXnOTx+SueCCABFNUsAbTsyRNaWEE7Zy5apRBE
         AjNgvhPwnEVBjPA82DT2rhUPM9hgcgyhHkEtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794334694; x=1794939494;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=80LZM7vxA2rau/UmsJfrKvz5NtsF8B/PIiFDePQDDVI=;
        b=Lle6rB/uJNYha3MmWU8Qgp8kw5C22krhQfjdplSvAaW3ELc4fdrjs79olPiDHlD7Tm
         3YsOukF88JDAOI2w07dJE0ul4CfsGBLNajoRAP2m/SZRKhWxedI94eHBPYj2a2ptIap/
         ftiO7eJI2QceF37sSS4bm+/9VxvRo+BP5wP6qr7Z79XOZjHSMmYQhTf44xCZhC14wf/j
         LLfbsSEdlHhEeniG727BmvlJaJr8XI1TUNT+kCTy+GWF/wDKe3Rjc72kCr777nMHrEj/
         8Z5VqHZYAruYYlQ59zxg5hrvTwV63loyILN+kmK9PA/aAkQD5GufYKpjhQZqMaIYPx3D
         X3OQ==
X-Forwarded-Encrypted: i=1; AL+hErGxcAPoPL+a/KQKU4U/smqJpeKk8MINx2Pl5HCmfBYyBob/wlymTyWDzOTSlPdsprQiQNfUXHoU5UGpRYe5+4U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ShK0SdU8xBmqgR12CWm2yFVK38I9/ex0Z3h9f/6A19/YpuH9h
	1vIuGlyaF/KSmLiGojfsBypGGrtk8h55GJgfAQcCO6nhVekshNURlsogeUVQkIbX1KJb80xyVl2
	4rYhh+UNBYzb0fo7iZESMqERLlN3nuNNigvdMvNsDGg==
X-Gm-Gg: AYBFou1fB7+wQG74yWNsdhZR2ekMmv7PQ/8W9ow7VVYCwForAEqY0+XDAu7ouytYcVl
	bJ20IVeLtp9hqI3wNN5/Wo54O8lVTXMPu2IRNtyEBT54RmwoP4e72oGgQeizO7dt5bhQQqJbvvy
	R6QuuzWFcZZEDp+eyRHNAAVJIQngnnmLCoX3WRJ9nBR4PQaXZ19u/CT240SO8hQlKqmf+oHsd0L
	U3eAqEXBFg7K6LZNAl0EJfTtMg1zCbP0rwkFmR+rKJYr6bQLZWWH0ws8DNtdaHw3ZYoiHofD3D7
	QF3y97xoow/iZiXctBd4F+ufT6qBIkoqil4NORcxPsK8/HTs8Hbe1nUPliqiGPn9ht5zzZ2L4+i
	2xfiO4wSpYDEHIz9gtHzfjAbCUig8cTAuMy7ZyRzH565b91xOoroxB6lpvLkaGBS6hqn+KBMaGy
	96NawNEEccnOJ06nVMpCz/0UwALL/lJ4VwsPnSerprxr8Jh0t42WVaYqvLd13BCKqz0leeDU75q
	yG9
X-Received: by 2002:a05:6402:1818:b0:6b4:1916:965c with SMTP id
 4fb4d7f45d1cf-6b7773f2f89mr52010a12.18.1794334694406; Tue, 10 Nov 2026
 10:18:14 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CADq=QSxw-5LstC5McTqfsp9NaVrsUcemepw2g_TJXNrdpgFdRQ@mail.gmail.com>
 <CABBYNZJ2zD42-szQ5KWExOVkSLPmO8AH-FNyO2Eq3V4bfSrVxg@mail.gmail.com>
In-Reply-To: <CABBYNZJ2zD42-szQ5KWExOVkSLPmO8AH-FNyO2Eq3V4bfSrVxg@mail.gmail.com>
From: Piyus Kedia <piyus@iiitd.ac.in>
Date: Tue, 10 Nov 2026 23:48:03 +0530
X-Gm-Features: AclHuK9-UryAyf0oDUb3G0rqiUwWeIMBeAgKdlv4az6FLANmzXLCKZjrp5TQw14
Message-ID: <CADq=QSzm_pb0pKT-T3Tm_P1fhE3XfK6iT1PETChLBB4-857Afw@mail.gmail.com>
Subject: Re: [BUG] Bluetooth: stack out-of-bounds write in eir_create_adv_data()
 and eir_create_scan_rsp() when a controller stops reporting LE Extended
 Advertising (seen on 7.3.1)
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kapil Vaswani <kapil@presceralabs.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

Thanks for the review. v2 is on the list, doing what you suggested:
unregistering the oversized instances at power-on rather than bounding
the copy in eir.c, with MGMT_EV_ADVERTISING_REMOVED so userspace is
told. It is also sent as a proper patch this time, with a Fixes: tag,
and verified at runtime.




https://lore.kernel.org/linux-bluetooth/20261110175334.676816-1-piyus@iiitd=
.ac.in/T/#t

On the security@kernel.org point: you are right, and I withdraw the
claim. Posting it to the public list ended any embargo, so this is an
ordinary bug report and should be handled as one. I have not copied
security@kernel.org on v2 and will not pursue it there.

Thanks and regards,
Piyus Kedia
Kapil Vaswani


On Tue, Nov 10, 2026 at 8:41=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Piyus,
>
> On Mon, Nov 9, 2026 at 11:57=E2=80=AFPM Piyus Kedia <piyus@iiitd.ac.in> w=
rote:
> > diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
> >
> > --- a/net/bluetooth/eir.c
> >
> > +++ b/net/bluetooth/eir.c
> >
> > @@ -300,6 +300,16 @@ u8 eir_create_adv_data(struct hci_dev *hdev, u8 in=
stance, u8 *ptr, u8 size)
> >
> >
> >
> >  skip_flags:
> >
> >      if (adv) {
> >
> > +        /* The instance's length was validated against max_adv_len()
> >
> > +         * when it was set, and max_adv_len() depends on a controller
> >
> > +         * capability that is re-read on every bring-up - so by now it
> >
> > +         * can be larger than the caller's buffer. Refuse rather than
> >
> > +         * overflow; a truncated AD structure would not be parseable
> >
> > +         * by a peer anyway.
> >
> > +         */
> >
> > +        if (ad_len + adv->adv_data_len > size)
> >
> > +            return 0;
> >
> > +
>
> We probably need to unregister the advertising instances if the
> controller changes its max size.
>
> >          memcpy(ptr, adv->adv_data, adv->adv_data_len);
> >
> >          ad_len +=3D adv->adv_data_len;
> >
> >          ptr +=3D adv->adv_data_len;
> >
> > @@ -342,7 +352,7 @@ static u8 create_default_scan_rsp(struct hci_dev *h=
dev, u8 *ptr)
> >
> >      return eir_append_local_name(hdev, ptr, scan_rsp_len);
> >
> >  }
> >
> >
> >
> > -u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr)
> >
> > +u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr, u8 =
size)
> >
> >  {
> >
> >      struct adv_info *adv;
> >
> >      u8 scan_rsp_len =3D 0;
> >
> > @@ -357,6 +367,10 @@ u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 in=
stance, u8 *ptr)
> >
> >      if ((adv->flags & MGMT_ADV_FLAG_APPEARANCE) && hdev->appearance)
> >
> >          scan_rsp_len =3D eir_append_appearance(hdev, ptr, scan_rsp_len=
);
> >
> >
> >
> > +    /* See the matching check in eir_create_adv_data(). */
> >
> > +    if (scan_rsp_len + adv->scan_rsp_len > size)
> >
> > +        return 0;
> >
> > +
> >
> >      memcpy(&ptr[scan_rsp_len], adv->scan_rsp_data, adv->scan_rsp_len);
> >
> >
> >
> >      scan_rsp_len +=3D adv->scan_rsp_len;
> >
> > diff --git a/net/bluetooth/eir.h b/net/bluetooth/eir.h
> >
> > --- a/net/bluetooth/eir.h
> >
> > +++ b/net/bluetooth/eir.h
> >
> > @@ -10,7 +10,7 @@
> >
> >  void eir_create(struct hci_dev *hdev, u8 *data);
> >
> >
> >
> >  u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr, u8 =
size);
> >
> > -u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr);
> >
> > +u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr, u8 =
size);
> >
> >  u8 eir_create_per_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)=
;
> >
> >
> >
> >  u8 eir_append_local_name(struct hci_dev *hdev, u8 *eir, u8 ad_len);
> >
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> >
> > --- a/net/bluetooth/hci_sync.c
> >
> > +++ b/net/bluetooth/hci_sync.c
> >
> > @@ -1563,7 +1563,8 @@ static int hci_set_ext_scan_rsp_data_sync(struct =
hci_dev *hdev, u8 instance)
> >
> >          }
> >
> >      }
> >
> >
> >
> > -    len =3D eir_create_scan_rsp(hdev, instance, pdu->data);
> >
> > +    len =3D eir_create_scan_rsp(hdev, instance, pdu->data,
> >
> > +                  HCI_MAX_EXT_AD_LENGTH);
>
> Ditto
>
> >
> >
> >      pdu->handle =3D adv ? adv->handle : instance;
> >
> >      pdu->length =3D len;
> >
> > @@ -1609,7 +1610,7 @@ static int __hci_set_scan_rsp_data_sync(struct hc=
i_dev *hdev, u8 instance)
> >
> >      if (instance)
> >
> >          hci_dev_lock(hdev);
> >
> >
> >
> > -    len =3D eir_create_scan_rsp(hdev, instance, cp.data);
> >
> > +    len =3D eir_create_scan_rsp(hdev, instance, cp.data, sizeof(cp.dat=
a));
>
> Ditto.
>
> >
> >
> >      if (instance)
> >
> >          hci_dev_unlock(hdev);
>
> Next time, send it as a proper patch, so CI can pick it up and Sashiko
> can analyze the changes. Also, and also address the claims about it
> being material to security@kernel.org don't hold anymore since you
> just published it to linux-bluetooth.
