Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F3A16D33F
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2024 18:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721389; cv=none; b=Ha3HD/H5STVSj2wlDTsD4HzDoz+52lnPROBo3skVC3Fepbpzrt4DdVTv15PPGwmbTF6FKMNgRUJiX51fjp1k7GmKyOVDiOCTwLyeLTZruB+0LGO8tR1eXOxvDQkIzeVN7T7vQqyr8Qbb65gXPhbx/gc5PhdWfOanmSsz/fiWKeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721389; c=relaxed/simple;
	bh=m38Fmjt3/oXtF8FCJTJlkcX4xSTqCYSDuPDQpXPeI0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1GDNrhtb/YeT6HT6wFNsDambtO9lZdNoldgm/z716RR2p/nyemXc7Wx6RRZpynokAm3Rq6LWhqf3JAT+jSS8PKSj43HhbaUEPhXbI976a+oU/mzZafDS+3cubK91FCPEYX6WGmg59E8XcHdVr5t4y4KLU2a/dsOqMo1sIL8Et0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6nsVzE3; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6nsVzE3"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ee9b1b422fso19553301fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2024 11:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720721385; x=1721326185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZVxyQycBD1A1wrK0DC42eHmm9uBnAbHdG+yQWSNpkw=;
        b=I6nsVzE3SA2XJTvjnFsHmJhtWYH67mvqzCcoNe8Fw+N3pVP8ch7shRzu5KP1qcJeqQ
         jN4+9EwypILHeJJHlJrFvS/2+4fECPj7BywLA/FQA03J9db9jnYYbnz8c2ZIluNV/LXq
         +Cf/yO5Fqjqc6F1dkwhFeCjbAzv4ZmaNQKymi0meTpp3IQqd1j0nPNp5xdwuUWCqSxjn
         HgaJUMB6XI99IFsMyOPjjl9OVGXG/GCJnodVcIgGhzFgmjIr0CkLSmz0tO1cjK3vxcdn
         n12plFvlQoz5XFX/1BngwSj640+g60owoUIkr9eA/rNx4WPg/RR2X0anTAZo+aMXj+HW
         5XcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720721385; x=1721326185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZVxyQycBD1A1wrK0DC42eHmm9uBnAbHdG+yQWSNpkw=;
        b=MHaqGTPxXt+G0iB8MvSXNYjNIUKNgGVY7fS1Gvc8AXDM2DblYWdLmWm2tJcekG7tqu
         vZ0i9LSGvO2KF6avKAc6zeWG+GcAKBWMoNnVnUrA88zvHsASPiD/vvBpJbr/sg0dggAg
         M+wAkKWGwmrWb46IJkQJr+ZGuSfK4inGP04xHs6udUkMMra90lZ2gQdPZ4eeprGq17vj
         kD/yuNR7fBxx0ouXKqiYzSt7mhdgo0cZXK28qCWe1Gj+GyGXOQzMYpS+L7CdXtGvu7kV
         WMc4RxlOlEw2YiBDt9Vt2Inez2HGNlN8yRBtkhsJguYcob+hgQ5QdjsdbiONi9OUOJsO
         Bvow==
X-Gm-Message-State: AOJu0YyHWXO7oKp7HDNiAQqWQ+bPti9TrE08tzjW2Uh6EKeMnil7XUYl
	caQvY4U4gaOoc/CJcSvxYbnEKweK1Jto9JxX2BMhb1MqIG6JYvnkiKkr1KoP94D/d+aAj26eIKS
	QaLRihuHEQPlylXor6s6oQ9ze+bYgQBFU
X-Google-Smtp-Source: AGHT+IEvkwp0JyH8Vlpbs9uCrw8eEUjToNOcOQwXnqvLa2zdYP5ijwDIy4n6uRJedlxBmF3HqV0RLTssKQBVMyhUh7c=
X-Received: by 2002:a2e:30a:0:b0:2eb:ec25:b759 with SMTP id
 38308e7fff4ca-2eed29c303bmr1239851fa.3.1720721384669; Thu, 11 Jul 2024
 11:09:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SN4PR19MB5421B1226EA92B735CADEA44E4C82@SN4PR19MB5421.namprd19.prod.outlook.com>
 <SN4PR19MB54215EF3B4E7380A21387D2EE4DB2@SN4PR19MB5421.namprd19.prod.outlook.com>
 <CABBYNZ+8ca5f6nWG3D3x8mL3g=57Z0pogQP-+ww_aQuC0R1DWw@mail.gmail.com>
 <SN4PR19MB54214DD841A41FB8C01DDFC9E4A42@SN4PR19MB5421.namprd19.prod.outlook.com>
 <CABBYNZJpG3ioCK9Skqx7_ki3TrqF+Z0GecApPF6Crv+D+J3hDA@mail.gmail.com> <SN4PR19MB5421EA5BEB05EFAC63160576E4A52@SN4PR19MB5421.namprd19.prod.outlook.com>
In-Reply-To: <SN4PR19MB5421EA5BEB05EFAC63160576E4A52@SN4PR19MB5421.namprd19.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 11 Jul 2024 14:09:32 -0400
Message-ID: <CABBYNZJXfviR-5FND4LxMtdwDL1y-_iRkEJsrp+PkyVk+g=BNw@mail.gmail.com>
Subject: Re: [PATCH] ATT: Error (0x01) - Error: Unlikely error (14) Prepare
 Write req (0x16)
To: "Ramsay, Trey" <Trey.Ramsay@dell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Trey,

On Thu, Jul 11, 2024 at 1:17=E2=80=AFPM Ramsay, Trey <Trey.Ramsay@dell.com>=
 wrote:
>
> Hi Luiz,
> Correct, the request is timing out.  The problem is "prep_write_complete_=
cb" is never getting called after the "prep_write_cb" is called.  The prep_=
write_complete_cb is responsible for sending the response BT_ATT_OP_PREP_WR=
ITE_RSP back.  The patch I provided fixes the code so that prep_write_compl=
ete_cb  will get called and the response is sent back.   Sorry, I had debug=
ged this issue a quite a while ago using bluez 5.55 and 5.66 and noticed th=
e same issue in the master branch.  We have been using the patch and it has=
 resolved the issue.

Well your patch is more of a workaround and in case the issue is
really the application setting 'authorize' flag the prepare write will
need to be authorized even if they are of 0 length, so it is a nack
from my side. If you think the application is responding properly then
the problem is somewhere else and in that case we probably need to
debug the code path it is taking.

> Thanks,
> Trey
>
> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Wednesday, July 10, 2024 4:14 PM
> To: Ramsay, Trey <Trey_Ramsay@Dell.com>
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH] ATT: Error (0x01) - Error: Unlikely error (14) Prepa=
re Write req (0x16)
>
>
> [EXTERNAL EMAIL]
>
> Hi Trey,
>
> On Wed, Jul 10, 2024 at 3:55=E2=80=AFPM Ramsay, Trey <Trey.Ramsay@dell.co=
m> wrote:
> >
> > Hi Luis,
> > It is a Prepare Write Request but prep_write_complete_cb is never getti=
ng called. In gatt_db_attribute_write, the prep_write_complete_cb function =
is not getting called since "attribe->write_func" is not null and the funct=
ion will return "True".  The prep_write_complete_cb is supposed to get call=
ed after "goto done;" but it's not getting called.  The prep_write_complete=
_cb is assigned to "func".    The patch checks to see if len is 0 and will =
goto done which will call prep_write_complete_cb.
>
> Well if it returns true then it should not return unlikely:
>
>     status =3D gatt_db_attribute_write(attr, offset, NULL, 0,
>                         BT_ATT_OP_PREP_WRITE_REQ,
>                         server->att,
>                         prep_write_complete_cb, pwcd);
>
>     if (status)
>         return;
>
>     ecode =3D BT_ATT_ERROR_UNLIKELY;
>
> error:
>     bt_att_chan_send_error_rsp(chan, opcode, handle, ecode);
>
> >
> > > ACL data: handle 0 flags 0x01 dlen 3
> >     ATT: Prepare Write req (0x16)
> >       attr handle 0x0069, value offset 0x0000
> >       part attr value  0x80 0x02 0x00 0x01 0xaa 0xd3 0x81 0x51 0x54
> > 0x5b 0xea 0xaf 0x68 0x0d 0xeb 0xe6 0x11 0x2d 0x63 0xb1 0x8e 0xbd 0xc4
> > 0x63 0x8f 0xf6 0xb6 0x10 0x63 0xb5 0x54 0x3f 0x36 0x19 0x41 0x5b 0x25
> > 0xcd 0xa7 0xe5 0x9d 0xc7 0x71 0x26 0x33 0x7c 0xe8 0x0e 0x67 0xd8 0x9a
> > 0x0a 0xb5 0xe5 0x24 0x87 0x2d 0xcc 0x00 0xa9 0xc8 0xb8 0x95 0x76 0x75
> > 0x9f 0x79 0x1f 0x94 0xe4 0xd9 0xbe 0xab 0x22 0xa3 0x33 0x18 0x28 0x57
> > 0x26 0xae 0x6d 0x0a 0x9b 0x63 0xeb 0x10 0xf3 0xb5 0xea 0x64 0x4a 0x81
> > 0x55 0xe0 0xa9 0x43 0x8c 0x87 0xb4 0x32 0x1c 0x79 0xd6 0x34 0x97 0xff
> > 0xae 0x71 0x1e 0x50 0x7c 0xb6 0x72 0x7b 0x49 0x44 0xef 0xfe 0xe2 0x40
> > 0xc7 0x3e 0x5e 0x42 0x9b 0xca 0xa4 0x61 0x66 0x72 0x0a 0x1d 0x5c 0xb0
> > 0xdb 0xa1 0xbb 0xf7 0xb6 0x27 0xa0 0x67 0xde 0x69 0xd9 0x67 0xa7 0x09
> > 0x58 0x71 0x37 0x99 0x95 0x5c 0x5d 0x10 0x4d 0xed 0x2f 0xe2 0x85 0x6c
> > 0x03 0x60 0x80 0x67 0x25 0x1b 0x33 0x02 0x53 0xbe 0x67 0xdb 0xd4 0x2a
> > 0x9e 0x8d 0x82 0xe2 0x9d 0xc4 0x86 0x08 0x84 0x2c 0xbf 0xa5 0xc5 0xd3
> > 0x99 0xf1 0x02 0x09 0x80 0x0c 0xc5 0xf9 0x99 0x06 0x20 0x01 0x75 0xdb
> > 0x0c 0x11 0x81 0x87 0x04 0x4d 0xf0 0xcc 0xf7 0x27 0x85 0xcd 0x22 0x84
> > 0x85 0x04 0xb3 0xa2 0xa9 0xcc 0xe9 0x27 0x8b 0x67 0x02 0x1b 0xe0 0x8c
> > 0xd7 0x8f 0x51 0x3a 0xa6 0x0c 0x23 0xa0 0x09 0x2b 0x4c 0xb0 0x80 0x34
> > 0xf9 0x61 0xaa 0x72 0x90 0x3a 0x5e 0xb7 0x11 0xaf 0xc3 0xcd 0x78 0x4f
> > 0xb6 0x1b 0xbb 0xb4 0xb2 0x42 0x9f 0x87 0xad 0xf6 0xa1 0xae 0xdd 0xde
> > 0x38 0x09 0x7a 0xc5 0x7c 0xbd 0x98 0x89 0xae 0x49 0x98 0xe7 0xae 0x92
> > 0x28 0x45 0x5a 0xbc 0x30 0x53 0xe5 0xc1 0x56 0xb3 0x9f 0x56 0x7b 0xa1
> > 0x02 0xcd 0xc2 0x25 0x2a 0xb2 0xc5 0xc9 0x35 0xec 0xa7 0x26 0x79 0x97
> > 0x2e 0x96 0x97 0x3e 0x5b 0x8f 0xc7 0x2f 0xa8 0x39 0x70 0xb1 0x22 0x5b
> > 0x2c 0x15 0x41 0xec 0x6b 0xc4 0x1e 0x2d 0xc0 0x47 0x75 0x42 0x01 0x40
> > 0xc5 0x17 0x69 0xf4 0x0a 0xcd 0x7e 0x62 0x25 0xec 0x1f 0x7c 0xae 0x7b
> > 0xf9 0x1e 0x9f 0x98 0xbd 0xc7 0xc3 0x44 0x4c 0xe2 0x0a 0x8c 0xbe 0xeb
> > 0x1e 0xae 0x7b 0xbc 0x49 0xfa 0x7d 0xa3 0xdf 0xb2 0xc0 0x69 0xf7 0x57
> > 0x6b 0x6f 0xe7 0x2e 0x3c 0x90 0x0a 0x16 0xe8 0x03 0x0d 0xf1 0x9c 0x4c
> > 0xa3 0x4b 0xcf 0x6d 0xc3 0x4a 0x69 0x25 0xc5 0xf6 0x9c 0x4b 0xb3 0x77
> > 0x67 0x7b 0x00 0xbb 0x1f 0xcd 0x59 0xb0 0xe9 0xf6 0xbe 0xa3 0x41 0xd1
> > 0x2c 0x1f 0x09 0x6b 0x4e 0x52 0x01 0x0c 0xe1 0x20 0x6c 0x76 0xfd 0xc9
> > 0xb9 0xb4 0xd8 0xdf 0xcb 0xac 0x77 0x65 0xcd 0x98 0xe9 0x66 0x6c 0xc8
> > 0x8f 0xfc 0xef 0x7e 0x48 0x9f 0xc8 0xd6 0x9c 0x72 0xac 0x44 0xa3 0x67
> > 0xa3 0x6a 0xe3 0xde 0x3a 0xd5 0x21 0x94 0x29 0x94 0x3d 0x7b 0x88 0x29
> > 0xc3 0xc2 0x7e 0x82 0x9d 0xe7 0x00 0x7c 0x96 0x28 0x1d 0x20 0xf8 0x81
> > 0x02 0x7c 0xc2 0xb2 0xfa 0x43 0x90 0x6e
>
> That doesn't seem like a zero length, what BlueZ version is this btw?
>
> > < ACL data: handle 0 flags 0x00 dlen 9
> >     ATT: Error (0x01)
> >       Error: Unlikely error (14)
> >       Prepare Write req (0x16) on handle 0x0069
>
> Check what time does this error is generated, since this well be:
>
> static bool write_timeout(void *user_data) {
>     struct pending_write *p =3D user_data;
>
>     p->timeout_id =3D 0;
>
>     queue_remove(p->attrib->pending_writes, p);
>
>     pending_write_result(p, -ETIMEDOUT);
>
>     return false;
> }
>
> The -ETIMEOUT would be converted to:
>
> static uint8_t att_ecode_from_error(int err) {
>     /*
>      * If the error fits in a single byte, treat it as an ATT protocol
>      * error as is. Since "0" is not a valid ATT protocol error code, we =
map
>      * that to UNLIKELY below.
>      */
>     if (err > 0 && err < UINT8_MAX)
>         return err;
>
>     /*
>      * Since we allow UNIX errnos, map them to appropriate ATT protocol
>      * and "Common Profile and Service" error codes.
>      */
>     switch (err) {
>     case -ENOENT:
>         return BT_ATT_ERROR_INVALID_HANDLE;
>     case -ENOMEM:
>         return BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
>     case -EALREADY:
>         return BT_ERROR_ALREADY_IN_PROGRESS;
>     case -EOVERFLOW:
>         return BT_ERROR_OUT_OF_RANGE;
>     }
>
>     return BT_ATT_ERROR_UNLIKELY;
> }
>
> So on write_timeout it would also generate the unlikely error.
>
> Note that normally prepare write don't need authorization, but perhaps yo=
u have an application setting 'authorize':
>
> https://urldefense.com/v3/__https://github.com/bluez/bluez/blob/master/do=
c/org.bluez.GattCharacteristic.rst*arraystring-flags-read-only__;Iw!!LpKI!m=
OAXmul0EbN_7I2R6edizAu4TW4H0BMt5s6EDMhpj23Ap8xFtV5BRjMJtpqVFcVIZQnbtBdGNs0U=
yAwX178$ [github[.]com], which means the following code would execute:
>
>     if (opcode =3D=3D BT_ATT_OP_PREP_WRITE_REQ) {
>         if (!btd_device_is_trusted(device) && !desc->prep_authorized &&
>                         desc->req_prep_authorization)
>             send_write(att, attrib, desc->proxy,
>                     desc->pending_writes, id, value, len,
>                     offset, false, true);
>         else
>             gatt_db_attribute_write_result(attrib, id, 0);
>
>         return;
>     }
>
> You can also try adding passing -t -p debug to btmon so it logs the debug=
 messages from bluetoothd and include timing information.
>
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> >     handle 0 packets 1
> > > ACL data: handle 0 flags 0x02 dlen 6
> >     ATT: Exec Write req (0x18)
> >       cancel all prepared writes (0x00) < ACL data: handle 0 flags
> > 0x00 dlen 5
> >     ATT: Exec Write resp (0x19)
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> >     handle 0 packets 1
> >
> > -----Original Message-----
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Sent: Tuesday, July 9, 2024 3:34 PM
> > To: Ramsay, Trey <Trey_Ramsay@Dell.com>
> > Cc: linux-bluetooth@vger.kernel.org
> > Subject: Re: [PATCH] ATT: Error (0x01) - Error: Unlikely error (14)
> > Prepare Write req (0x16)
> >
> >
> > [EXTERNAL EMAIL]
> >
> > Hi Trey,
> >
> > On Tue, Jul 9, 2024 at 1:34=E2=80=AFPM Ramsay, Trey <Trey.Ramsay@dell.c=
om> wrote:
> > >
> > > Bluez Maintainers,
> > > Here is a fix for attribute writes not working in
> > > src/shared/gatt-db.c. The prep_write_complete_cb was not getting
> > > called. The attrib->write_func code block should not be called when
> > > len is 0
> > >
> > > commit 5a9baa10d4fde7ca8ab88ecd68e17671c33cb587 (HEAD -> gat-db,
> > > master)
> > > Author: Trey_Ramsay <trey_ramsay@dell.com>
> > > Date:   Fri May 31 15:39:27 2024 -0500
> > >
> > >     shared/gatt-db: Prepare Write req error BT_ATT_ERROR_UNLIKELY
> > >
> > >     Fixes Prepare Write req error: BT_ATT_ERROR_UNLIKELY
> > >
> > >         ATT: Error (0x01)
> > >           Error: Unlikely error (14)
> > >           Prepare Write req (0x16) on handle 0x0069
> > >
> > >     The prep_write_complete_cb was not getting called
> > >     The attrib->write_func code block does not need to be called
> > > when len is 0
> >
> > This doesn't sound quite right, 0 length still needs to be passed to th=
e attribute to confirm since we don't know if it could be a procedure or no=
t. Can you explain what attribute is being written and if it could be due t=
o the application not responding and the procedure timing out (e.g. write_t=
imeout is called?), perhaps if you can paste a btmon trace as well that cou=
ld help checking what attribute it is trying to use prepare write.
> >
> > > diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c index
> > > 2c8e7d31e..678aef4cf 100644
> > > --- a/src/shared/gatt-db.c
> > > +++ b/src/shared/gatt-db.c
> > > @@ -2127,6 +2127,10 @@ bool gatt_db_attribute_write(struct gatt_db_at=
tribute *attrib, uint16_t offset,
> > >      if (!attrib || (!func && attrib->write_func))
> > >          return false;
> > >
> > > +    /* Nothing to write just skip */
> > > +    if (len =3D=3D 0)
> > > +        goto done;
> > > +
> > >      if (attrib->write_func) {
> > >          struct pending_write *p;
> > >
> > > @@ -2162,10 +2166,6 @@ bool gatt_db_attribute_write(struct gatt_db_at=
tribute *attrib, uint16_t offset,
> > >          return true;
> > >      }
> > >
> > > -    /* Nothing to write just skip */
> > > -    if (len =3D=3D 0)
> > > -        goto done;
> > > -
> > >      /* For values stored in db allocate on demand */
> > >      if (!attrib->value || offset >=3D attrib->value_len ||
> > >                  len > (unsigned) (attrib->value_len - offset)) {
> > >
> > >
> > >
> > > -----Original Message-----
> > > From: Ramsay, Trey <Trey.Ramsay@dell.com>
> > > Sent: Thursday, June 20, 2024 1:58 PM
> > > To: linux-bluetooth@vger.kernel.org
> > > Subject: [PATCH] ATT: Error (0x01) - Error: Unlikely error (14)
> > > Prepare Write req (0x16)
> > >
> > >
> > > Bluez Maintainers
> > > Here is a fix for attribute writes not working in
> > > src/shared/gatt-db.c
> > >
> > > https://urldefense.com/v3/__https://github.com/tramsay/bluez-tramsay
> > > /c
> > > ommit/246bc960629dff34e744c728f048e9f50f1a005d__;!!LpKI!jkJYamzU8bOd
> > > d1
> > > qt-sWpj6gy1YwS30UyamHLUJj9Uy0UecrB6QxvCdSWFAUH7Dvq2wVJqu1C5jjoX5amyw
> > > JH
> > > $ [github[.]com]
> > >
> > > shared/gatt-db: Prepare Write req error BT_ATT_ERROR_UNLIKELY Fixes
> > > Prepare Write req error: BT_ATT_ERROR_UNLIKELY
> > >
> > >     ATT: Error (0x01)
> > >       Error: Unlikely error (14)
> > >       Prepare Write req (0x16) on handle 0x0069
> > >
> > > The prep_write_complete_cb was not getting called The
> > > attrib->write_func code block should not be called when len is 0
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
