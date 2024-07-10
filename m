Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5D82B9DD
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720646032; cv=none; b=SNAnmqK1dS8IfxfnDm7CBJUbfduQXk14X7wu62GJUWB6FDbJgtwW58iD8OdN0fwI9eL1+6GzqZ8vThMR9Ny2KL84FKovc/Ie680hjDyhWiHjCaSjMDGC3B5GyAacMDFM4BK7KE3RCHiPJRpZwcG4SK4P2HAAXjsdLGmTRy0t39A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720646032; c=relaxed/simple;
	bh=gtI3FUpI5LEBbl0ztKYMEjLbLmirSWlsijvImtJSWxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHZs2BouFRUnmEaat7XT7BN5KOSMr7iDrXA6EsFYKUMB54QYpNRWkZS9yQ+ifxPSwfOI/laWtoBmwyYX7XfseYyop2zOUTRrV/sUoqK04fBQfKSbrG8dHBJByO/DEcPtj+HkG49r9qzOkpDewR63EnqhQbOeR+mxhszqm3WTnaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqmMAIBZ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqmMAIBZ"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eec7e431d9so2124631fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 14:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720646029; x=1721250829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egp1SC0NW6Jw1SQ7nde2Lju3g4lDVdn9Zvf3JtCC12s=;
        b=LqmMAIBZs6Q+2tVYMcFjKO8cjeeDIklFpOzspJSAbVyF3c1QdSoI/4jBP95Du2Aydp
         odOHYUF3WslxOMGcs6I0td9ujUiS2OUjMUHj2qRkh2WVqjR5GqPfmkvTS8Aidt6goRQV
         H3SXssB/mTWt2d6dIwWU/FILzYHLZByyyVkuOhnoN5pnZ0TJIVfDK1nYLy4WusD513vT
         vBK259vUW3AeospQRddK8Jv6/swbN9uy6Tsak24QZx3mvCwh0d7OJVz+y+FTNaZX8KtD
         gIFr+mXvRQZ/a/O+PJVOEjpoOe6OY+x4huB/P8hTIQFbT/xvUbvsgjnegb5gRnRSFV9M
         WQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720646029; x=1721250829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egp1SC0NW6Jw1SQ7nde2Lju3g4lDVdn9Zvf3JtCC12s=;
        b=MV+81FOozyiBu1AqrrNu4GXeDWs1DoWBER6UNWc5Wyg6YJcfzBoLaL0Z/A1HGvjXtO
         9oW1kNUTuLg1IJVMDOMvBLnBJABqXx2LOCn16KDS2S2sfuuMDUNpzAD+MhcEFNRNsowf
         anXoAIEu++Heh+Z6GkFjSHqkSYpjBSO3Ua80/zi341OGqQgKWVswE6d2gZQhXLriibgN
         hdgwEa9qlUPun0RMNlUnicceiDwPvSikL2X6pY4oBPdfJ3BDmNIsmdvbWx+eJ7KG905S
         YMT6ihce90Q+szOLx+CRXzwPjIASFw5ZU9HGbLjahm7QDVG4Lzb8cx18D5IMdXd9P0D9
         B7pg==
X-Gm-Message-State: AOJu0YzSl/IzfQ0Cv5S+KJ5ys/c4Tw3PBHoasHYPEQCxUI4wSu9C9fsl
	Td+mdbsiAmzmhL4sR3R3kqJZGJB3mq4P6o2FoUhYF1M+A35Dqb+wCnRMHqiey+Bd45SIqeoxySz
	4dEXxTg/uMmSzfM2MKwYa8cLqXu8=
X-Google-Smtp-Source: AGHT+IGZeZiLW+yLNXCTlXS5jfrghOM48f3gFA/dczFc2Ds6PLBoo/urKQFtjc6rI4xg38Vx+9pdN74YNtKYljsI/7w=
X-Received: by 2002:a2e:a98f:0:b0:2ee:bdc8:2ce8 with SMTP id
 38308e7fff4ca-2eebdc83775mr31799081fa.0.1720646028707; Wed, 10 Jul 2024
 14:13:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SN4PR19MB5421B1226EA92B735CADEA44E4C82@SN4PR19MB5421.namprd19.prod.outlook.com>
 <SN4PR19MB54215EF3B4E7380A21387D2EE4DB2@SN4PR19MB5421.namprd19.prod.outlook.com>
 <CABBYNZ+8ca5f6nWG3D3x8mL3g=57Z0pogQP-+ww_aQuC0R1DWw@mail.gmail.com> <SN4PR19MB54214DD841A41FB8C01DDFC9E4A42@SN4PR19MB5421.namprd19.prod.outlook.com>
In-Reply-To: <SN4PR19MB54214DD841A41FB8C01DDFC9E4A42@SN4PR19MB5421.namprd19.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 10 Jul 2024 17:13:36 -0400
Message-ID: <CABBYNZJpG3ioCK9Skqx7_ki3TrqF+Z0GecApPF6Crv+D+J3hDA@mail.gmail.com>
Subject: Re: [PATCH] ATT: Error (0x01) - Error: Unlikely error (14) Prepare
 Write req (0x16)
To: "Ramsay, Trey" <Trey.Ramsay@dell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Trey,

On Wed, Jul 10, 2024 at 3:55=E2=80=AFPM Ramsay, Trey <Trey.Ramsay@dell.com>=
 wrote:
>
> Hi Luis,
> It is a Prepare Write Request but prep_write_complete_cb is never getting=
 called. In gatt_db_attribute_write, the prep_write_complete_cb function is=
 not getting called since "attribe->write_func" is not null and the functio=
n will return "True".  The prep_write_complete_cb is supposed to get called=
 after "goto done;" but it's not getting called.  The prep_write_complete_c=
b is assigned to "func".    The patch checks to see if len is 0 and will go=
to done which will call prep_write_complete_cb.

Well if it returns true then it should not return unlikely:

    status =3D gatt_db_attribute_write(attr, offset, NULL, 0,
                        BT_ATT_OP_PREP_WRITE_REQ,
                        server->att,
                        prep_write_complete_cb, pwcd);

    if (status)
        return;

    ecode =3D BT_ATT_ERROR_UNLIKELY;

error:
    bt_att_chan_send_error_rsp(chan, opcode, handle, ecode);

>
> > ACL data: handle 0 flags 0x01 dlen 3
>     ATT: Prepare Write req (0x16)
>       attr handle 0x0069, value offset 0x0000
>       part attr value  0x80 0x02 0x00 0x01 0xaa 0xd3 0x81 0x51 0x54 0x5b =
0xea 0xaf 0x68 0x0d 0xeb 0xe6 0x11 0x2d 0x63 0xb1 0x8e 0xbd 0xc4 0x63 0x8f =
0xf6 0xb6 0x10 0x63 0xb5 0x54 0x3f 0x36 0x19 0x41 0x5b 0x25 0xcd 0xa7 0xe5 =
0x9d 0xc7 0x71 0x26 0x33 0x7c 0xe8 0x0e 0x67 0xd8 0x9a 0x0a 0xb5 0xe5 0x24 =
0x87 0x2d 0xcc 0x00 0xa9 0xc8 0xb8 0x95 0x76 0x75 0x9f 0x79 0x1f 0x94 0xe4 =
0xd9 0xbe 0xab 0x22 0xa3 0x33 0x18 0x28 0x57 0x26 0xae 0x6d 0x0a 0x9b 0x63 =
0xeb 0x10 0xf3 0xb5 0xea 0x64 0x4a 0x81 0x55 0xe0 0xa9 0x43 0x8c 0x87 0xb4 =
0x32 0x1c 0x79 0xd6 0x34 0x97 0xff 0xae 0x71 0x1e 0x50 0x7c 0xb6 0x72 0x7b =
0x49 0x44 0xef 0xfe 0xe2 0x40 0xc7 0x3e 0x5e 0x42 0x9b 0xca 0xa4 0x61 0x66 =
0x72 0x0a 0x1d 0x5c 0xb0 0xdb 0xa1 0xbb 0xf7 0xb6 0x27 0xa0 0x67 0xde 0x69 =
0xd9 0x67 0xa7 0x09 0x58 0x71 0x37 0x99 0x95 0x5c 0x5d 0x10 0x4d 0xed 0x2f =
0xe2 0x85 0x6c 0x03 0x60 0x80 0x67 0x25 0x1b 0x33 0x02 0x53 0xbe 0x67 0xdb =
0xd4 0x2a 0x9e 0x8d 0x82 0xe2 0x9d 0xc4 0x86 0x08 0x84 0x2c 0xbf 0xa5 0xc5 =
0xd3 0x99 0xf1 0x02 0x09 0x80 0x0c 0xc5 0xf9 0x99 0x06 0x20 0x01 0x75 0xdb =
0x0c 0x11 0x81 0x87 0x04 0x4d 0xf0 0xcc 0xf7 0x27 0x85 0xcd 0x22 0x84 0x85 =
0x04 0xb3 0xa2 0xa9 0xcc 0xe9 0x27 0x8b 0x67 0x02 0x1b 0xe0 0x8c 0xd7 0x8f =
0x51 0x3a 0xa6 0x0c 0x23 0xa0 0x09 0x2b 0x4c 0xb0 0x80 0x34 0xf9 0x61 0xaa =
0x72 0x90 0x3a 0x5e 0xb7 0x11 0xaf 0xc3 0xcd 0x78 0x4f 0xb6 0x1b 0xbb 0xb4 =
0xb2 0x42 0x9f 0x87 0xad 0xf6 0xa1 0xae 0xdd 0xde 0x38 0x09 0x7a 0xc5 0x7c =
0xbd 0x98 0x89 0xae 0x49 0x98 0xe7 0xae 0x92 0x28 0x45 0x5a 0xbc 0x30 0x53 =
0xe5 0xc1 0x56 0xb3 0x9f 0x56 0x7b 0xa1 0x02 0xcd 0xc2 0x25 0x2a 0xb2 0xc5 =
0xc9 0x35 0xec 0xa7 0x26 0x79 0x97 0x2e 0x96 0x97 0x3e 0x5b 0x8f 0xc7 0x2f =
0xa8 0x39 0x70 0xb1 0x22 0x5b 0x2c 0x15 0x41 0xec 0x6b 0xc4 0x1e 0x2d 0xc0 =
0x47 0x75 0x42 0x01 0x40 0xc5 0x17 0x69 0xf4 0x0a 0xcd 0x7e 0x62 0x25 0xec =
0x1f 0x7c 0xae 0x7b 0xf9 0x1e 0x9f 0x98 0xbd 0xc7 0xc3 0x44 0x4c 0xe2 0x0a =
0x8c 0xbe 0xeb 0x1e 0xae 0x7b 0xbc 0x49 0xfa 0x7d 0xa3 0xdf 0xb2 0xc0 0x69 =
0xf7 0x57 0x6b 0x6f 0xe7 0x2e 0x3c 0x90 0x0a 0x16 0xe8 0x03 0x0d 0xf1 0x9c =
0x4c 0xa3 0x4b 0xcf 0x6d 0xc3 0x4a 0x69 0x25 0xc5 0xf6 0x9c 0x4b 0xb3 0x77 =
0x67 0x7b 0x00 0xbb 0x1f 0xcd 0x59 0xb0 0xe9 0xf6 0xbe 0xa3 0x41 0xd1 0x2c =
0x1f 0x09 0x6b 0x4e 0x52 0x01 0x0c 0xe1 0x20 0x6c 0x76 0xfd 0xc9 0xb9 0xb4 =
0xd8 0xdf 0xcb 0xac 0x77 0x65 0xcd 0x98 0xe9 0x66 0x6c 0xc8 0x8f 0xfc 0xef =
0x7e 0x48 0x9f 0xc8 0xd6 0x9c 0x72 0xac 0x44 0xa3 0x67 0xa3 0x6a 0xe3 0xde =
0x3a 0xd5 0x21 0x94 0x29 0x94 0x3d 0x7b 0x88 0x29 0xc3 0xc2 0x7e 0x82 0x9d =
0xe7 0x00 0x7c 0x96 0x28 0x1d 0x20 0xf8 0x81 0x02 0x7c 0xc2 0xb2 0xfa 0x43 =
0x90 0x6e

That doesn't seem like a zero length, what BlueZ version is this btw?

> < ACL data: handle 0 flags 0x00 dlen 9
>     ATT: Error (0x01)
>       Error: Unlikely error (14)
>       Prepare Write req (0x16) on handle 0x0069

Check what time does this error is generated, since this well be:

static bool write_timeout(void *user_data)
{
    struct pending_write *p =3D user_data;

    p->timeout_id =3D 0;

    queue_remove(p->attrib->pending_writes, p);

    pending_write_result(p, -ETIMEDOUT);

    return false;
}

The -ETIMEOUT would be converted to:

static uint8_t att_ecode_from_error(int err)
{
    /*
     * If the error fits in a single byte, treat it as an ATT protocol
     * error as is. Since "0" is not a valid ATT protocol error code, we ma=
p
     * that to UNLIKELY below.
     */
    if (err > 0 && err < UINT8_MAX)
        return err;

    /*
     * Since we allow UNIX errnos, map them to appropriate ATT protocol
     * and "Common Profile and Service" error codes.
     */
    switch (err) {
    case -ENOENT:
        return BT_ATT_ERROR_INVALID_HANDLE;
    case -ENOMEM:
        return BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
    case -EALREADY:
        return BT_ERROR_ALREADY_IN_PROGRESS;
    case -EOVERFLOW:
        return BT_ERROR_OUT_OF_RANGE;
    }

    return BT_ATT_ERROR_UNLIKELY;
}

So on write_timeout it would also generate the unlikely error.

Note that normally prepare write don't need authorization, but perhaps
you have an application setting 'authorize':

https://github.com/bluez/bluez/blob/master/doc/org.bluez.GattCharacteristic=
.rst#arraystring-flags-read-only,
which means the following code would execute:

    if (opcode =3D=3D BT_ATT_OP_PREP_WRITE_REQ) {
        if (!btd_device_is_trusted(device) && !desc->prep_authorized &&
                        desc->req_prep_authorization)
            send_write(att, attrib, desc->proxy,
                    desc->pending_writes, id, value, len,
                    offset, false, true);
        else
            gatt_db_attribute_write_result(attrib, id, 0);

        return;
    }

You can also try adding passing -t -p debug to btmon so it logs the
debug messages from bluetoothd and include timing information.

> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 0 packets 1
> > ACL data: handle 0 flags 0x02 dlen 6
>     ATT: Exec Write req (0x18)
>       cancel all prepared writes (0x00)
> < ACL data: handle 0 flags 0x00 dlen 5
>     ATT: Exec Write resp (0x19)
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 0 packets 1
>
> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Tuesday, July 9, 2024 3:34 PM
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
> On Tue, Jul 9, 2024 at 1:34=E2=80=AFPM Ramsay, Trey <Trey.Ramsay@dell.com=
> wrote:
> >
> > Bluez Maintainers,
> > Here is a fix for attribute writes not working in
> > src/shared/gatt-db.c. The prep_write_complete_cb was not getting
> > called. The attrib->write_func code block should not be called when
> > len is 0
> >
> > commit 5a9baa10d4fde7ca8ab88ecd68e17671c33cb587 (HEAD -> gat-db,
> > master)
> > Author: Trey_Ramsay <trey_ramsay@dell.com>
> > Date:   Fri May 31 15:39:27 2024 -0500
> >
> >     shared/gatt-db: Prepare Write req error BT_ATT_ERROR_UNLIKELY
> >
> >     Fixes Prepare Write req error: BT_ATT_ERROR_UNLIKELY
> >
> >         ATT: Error (0x01)
> >           Error: Unlikely error (14)
> >           Prepare Write req (0x16) on handle 0x0069
> >
> >     The prep_write_complete_cb was not getting called
> >     The attrib->write_func code block does not need to be called when
> > len is 0
>
> This doesn't sound quite right, 0 length still needs to be passed to the =
attribute to confirm since we don't know if it could be a procedure or not.=
 Can you explain what attribute is being written and if it could be due to =
the application not responding and the procedure timing out (e.g. write_tim=
eout is called?), perhaps if you can paste a btmon trace as well that could=
 help checking what attribute it is trying to use prepare write.
>
> > diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c index
> > 2c8e7d31e..678aef4cf 100644
> > --- a/src/shared/gatt-db.c
> > +++ b/src/shared/gatt-db.c
> > @@ -2127,6 +2127,10 @@ bool gatt_db_attribute_write(struct gatt_db_attr=
ibute *attrib, uint16_t offset,
> >      if (!attrib || (!func && attrib->write_func))
> >          return false;
> >
> > +    /* Nothing to write just skip */
> > +    if (len =3D=3D 0)
> > +        goto done;
> > +
> >      if (attrib->write_func) {
> >          struct pending_write *p;
> >
> > @@ -2162,10 +2166,6 @@ bool gatt_db_attribute_write(struct gatt_db_attr=
ibute *attrib, uint16_t offset,
> >          return true;
> >      }
> >
> > -    /* Nothing to write just skip */
> > -    if (len =3D=3D 0)
> > -        goto done;
> > -
> >      /* For values stored in db allocate on demand */
> >      if (!attrib->value || offset >=3D attrib->value_len ||
> >                  len > (unsigned) (attrib->value_len - offset)) {
> >
> >
> >
> > -----Original Message-----
> > From: Ramsay, Trey <Trey.Ramsay@dell.com>
> > Sent: Thursday, June 20, 2024 1:58 PM
> > To: linux-bluetooth@vger.kernel.org
> > Subject: [PATCH] ATT: Error (0x01) - Error: Unlikely error (14)
> > Prepare Write req (0x16)
> >
> >
> > Bluez Maintainers
> > Here is a fix for attribute writes not working in src/shared/gatt-db.c
> >
> > https://urldefense.com/v3/__https://github.com/tramsay/bluez-tramsay/c
> > ommit/246bc960629dff34e744c728f048e9f50f1a005d__;!!LpKI!jkJYamzU8bOdd1
> > qt-sWpj6gy1YwS30UyamHLUJj9Uy0UecrB6QxvCdSWFAUH7Dvq2wVJqu1C5jjoX5amywJH
> > $ [github[.]com]
> >
> > shared/gatt-db: Prepare Write req error BT_ATT_ERROR_UNLIKELY Fixes
> > Prepare Write req error: BT_ATT_ERROR_UNLIKELY
> >
> >     ATT: Error (0x01)
> >       Error: Unlikely error (14)
> >       Prepare Write req (0x16) on handle 0x0069
> >
> > The prep_write_complete_cb was not getting called The
> > attrib->write_func code block should not be called when len is 0
> >
>
>
> --
> Luiz Augusto von Dentz
>


--=20
Luiz Augusto von Dentz
