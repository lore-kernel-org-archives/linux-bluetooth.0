Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D797F47E
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585047; cv=none; b=lwcAcov2NKX5Hk3HEAZ/8AowOdJwVdCUDyHZXA1zjkMbQ49hF8QglytE0lzsn5OqE2q+crKnaNpccGuP4PkNteabFJ2Q0wpBxRUQ/ONzJNr4Otp++XwqOx6dnwxECarZU9BueI62AvpqNnCa/kBH6P4+9MPYQtZ52c6AJ6nUMYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585047; c=relaxed/simple;
	bh=JJDoG/WUHoobskzviNIzuL1KfenU8pcZpeoOC3XGcu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izCp76pgeq1O17+YjqioNwJre/xkFqB3PJwQEBb6Ub8jouo/I2uXroUU2n2Hs43VOh33AMC1v0of6+1Z5wrqD62/Rx3R45YowmGoC2gg2ZcXxOW3XHNBM4TfOx8ltRew5Pdi+5vEIqwyDPtnmvdT2OAyl1+z3e/kiELBrCIqId8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dd5mWZGY; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dd5mWZGY"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so60950441fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2024 07:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712585043; x=1713189843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbstmPXXnxsYZlwiSTPLpPOWctVPisYuLlBmul7P2fE=;
        b=dd5mWZGY9nWTFUcSPWtqnVLy2L0oRLbweQtUcfyC5b1lNRZMG3it8IigUhGvL8kQQE
         L0D1gBaSPiQwSQSSZ0a20NnpzDcOKvoqsSddXIa2dA7h61pYQxVE0UbVt/k8Z3PqQvNy
         pKkFoShLpdPTX7KN4prRmVTbdpl3TUpSPm2MRRED5EDYUc+ndwP3VcWGySNQ4aaY4UV5
         vtaH/V7IKmP3i8q7yb41TERirSby3FA+//l1rtdGbqof6khb7ifrL/LWWgsN5rtDk8x2
         bqOtLllZuU+w9GV9ELuATnoeqcxsKj61fpWU34lUyjRzBUB7IQr8kyE6iwS+leG8S80d
         O+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712585043; x=1713189843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbstmPXXnxsYZlwiSTPLpPOWctVPisYuLlBmul7P2fE=;
        b=jEob/71wFgN21L2dl7O+owKuSJi6XUK29fWteTlM77Aph9AK1Ztc3zjKlmvLc7/xrU
         KhI8WJb8J9Gt0wnCGTxhMbOWJhb66ckFEwzIuGZ0/MUsUuxcG2ZIdmh6GkAWl8SuhU4T
         XQdolUjqqQcwopBz7iXD0FZutdqxlrtxBj5PcQt3Xyq33V6JsQCdhxH9CWPqTHG5wyfV
         Wbh33+tGLg2x+p+067HDbBhjmjyBeL5J1DYI7SNgN9lWLqH5NV61g0l8xjaLv5BB36sH
         Ya6QLmHl0cK3dBIA0oIZ91W0ll30za59sQYb1qR8i7T5SW49S7U5XimYeKFD+Xk2qhen
         uEpg==
X-Gm-Message-State: AOJu0YyYJtVt5Y77gefKFuapP4h/6wYobFBK/+xgqrTY0t2uFU1Xcc9T
	ir25NUfC1sv2C3iThMRaZogoeYaYbBim34ru+xKUltX9wNSc+VllgfgGlIfKArrkSXphCh3GMZc
	A4eZzMcpx5FEh/clcN7ZQvJP+Wwc=
X-Google-Smtp-Source: AGHT+IGk7PbWgz8+OvNiUuPucE7tfzFmrib0kAZsnowqji8sDAG53iKcA5lYQOhxlmkgRgb7puCFKtf/isjYunASSQI=
X-Received: by 2002:a05:651c:1025:b0:2d6:cd05:1895 with SMTP id
 w5-20020a05651c102500b002d6cd051895mr6083976ljm.29.1712585042741; Mon, 08 Apr
 2024 07:04:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403110549.75516-1-howardchung@google.com>
 <20240403110549.75516-2-howardchung@google.com> <CABBYNZKpPbnPcfJmi42smd6E-JUh6kBi9aX6EWpq-h7_tBVJMA@mail.gmail.com>
 <CAPHZWUcRfNT-QXGE3FQhMYUHG6jr8gAyjpFZc=ov9tbiNHaAWg@mail.gmail.com>
In-Reply-To: <CAPHZWUcRfNT-QXGE3FQhMYUHG6jr8gAyjpFZc=ov9tbiNHaAWg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 8 Apr 2024 10:03:50 -0400
Message-ID: <CABBYNZ+fEntpd7j=vo0rDDZOmct=VWQzmucjFxP-LCvPrJNHcA@mail.gmail.com>
Subject: Re: [Bluez PATCH 2/2] shared/gatt: Add descriptor insert function
To: Yun-hao Chung <howardchung@google.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 8, 2024 at 8:23=E2=80=AFAM Yun-hao Chung <howardchung@google.co=
m> wrote:
>
> Hi Luiz,
>
> Thanks for the response.
>
> This issue was found in ChromeOS edition BlueZ. I'm not sure if any
> official BlueZ would do the same discovery procedure or not.
>
> I extracted relevant part of the trace as below
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> < ACL Data TX: Handle 2048 flags 0x00 dlen 11
>
>                                                 #43961 [hci0]
> 2024-03-05 07:33:55.936283
>       ATT: Read By Group Type Request (0x10) len 6
>         Handle range: 0x001f-0xffff
>         Attribute group type: Primary Service (0x2800)
> ...
> > ACL Data RX: Handle 2048 flags 0x02 dlen 27                            =
                                                                           =
                                          #43963 [hci0] 2024-03-05 07:33:55=
.967020
> > ACL Data RX: Handle 2048 flags 0x01 dlen 3                             =
                                                                           =
                                          #43964 [hci0] 2024-03-05 07:33:55=
.967022
>       ATT: Read By Group Type Response (0x11) len 25
>         Attribute data length: 6
>         Attribute group list: 4 entries
>         Handle range: 0x001f-0x0035
>         UUID: Human Interface Device (0x1812)
>         Handle range: 0x0036-0x0044
>         UUID: Human Interface Device (0x1812)
>         Handle range: 0x0045-0x0055
>         UUID: Human Interface Device (0x1812)
>         Handle range: 0x0056-0x0062
>         UUID: Logitech International SA (0xfd72)
> =E2=80=A6
> < ACL Data TX: Handle 2048 flags 0x00 dlen 11
>
>                                                 #44018 [hci0]
> 2024-03-05 07:33:56.281436
>       ATT: Read By Type Request (0x08) len 6
>         Handle range: 0x0021-0xffff
>         Attribute type: Characteristic (0x2803)
> ...
> > ACL Data RX: Handle 2048 flags 0x02 dlen 27                            =
                                                                           =
                                          #44023 [hci0] 2024-03-05 07:33:56=
.311026
>       ATT: Read By Type Response (0x09) len 22
>         Attribute data length: 7
>         Attribute data list: 3 entries
>         Handle: 0x0022
>         Value: 122300332a
>             Properties: 0x12
>               Read (0x02)
>               Notify (0x10)
>             Value Handle: 0x0023
>             Value UUID: Boot Mouse Input Report (0x2a33)
>         Handle: 0x0025
>         Value: 0226004b2a
>             Properties: 0x02
>               Read (0x02)
>             Value Handle: 0x0026
>             Value UUID: Report Map (0x2a4b)
>         Handle: 0x0027
>         Value: 1228004d2a
>             Properties: 0x12
>               Read (0x02)
>               Notify (0x10)
>             Value Handle: 0x0028
>             Value UUID: Report (0x2a4d)
> ...
> < ACL Data TX: Handle 2048 flags 0x00 dlen 11
>
>                                                 #44024 [hci0]
> 2024-03-05 07:33:56.311458
>       ATT: Read By Type Request (0x08) len 6
>         Handle range: 0x0028-0xffff
>         Attribute type: Characteristic (0x2803)
> =E2=80=A6
> > ACL Data RX: Handle 2048 flags 0x02 dlen 27                            =
                                                                           =
                                          #44029 [hci0] 2024-03-05 07:33:56=
.341025
>       ATT: Read By Type Response (0x09) len 22
>         Attribute data length: 7
>         Attribute data list: 3 entries
>         Handle: 0x002b
>         Value: 122c004d2a
>             Properties: 0x12
>               Read (0x02)
>               Notify (0x10)
>             Value Handle: 0x002c
>             Value UUID: Report (0x2a4d)
>         Handle: 0x002f
>         Value: 0e30004d2a
>             Properties: 0x0e
>               Read (0x02)
>               Write Without Response (0x04)
>               Write (0x08)
>             Value Handle: 0x0030
>             Value UUID: Report (0x2a4d)
>         Handle: 0x0032
>         Value: 0433004c2a
>             Properties: 0x04
>               Write Without Response (0x04)
>             Value Handle: 0x0033
>             Value UUID: HID Control Point (0x2a4c)
> =E2=80=A6
> < ACL Data TX: Handle 2048 flags 0x00 dlen 9
>
>                                                 #44071 [hci0]
> 2024-03-05 07:33:56.702334
>       ATT: Find Information Request (0x04) len 4
>         Handle range: 0x0029-0x002a
> =E2=80=A6
> > ACL Data RX: Handle 2048 flags 0x02 dlen 14                            =
                                                                           =
                                          #44073 [hci0] 2024-03-05 07:33:56=
.731069
>       ATT: Find Information Response (0x05) len 9
>         Format: UUID-16 (0x01)
>         Handle: 0x0029
>         UUID: Client Characteristic Configuration (0x2902)
>         Handle: 0x002a
>         UUID: Report Reference (0x2908)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
> When decoding packet #44073, we can't append descriptors 0x0029 and
> 0x002a at the tail of the |service->attributes| since the
> characteristics 0x002b,0x002f and 0x0032 are already in the array.

So bluetoothd works but the monitor doesn't? They both are using
gatt_db_insert_descriptor which uses servvice_insert_descriptor, so
where exactly is it failing at? The only difference I see is that in
case of gatt-client.c we do:

            attr =3D gatt_db_get_attribute(client->db, handle);
            if (attr && !bt_uuid_cmp(&uuid,
                    gatt_db_attribute_get_type(attr)))
                continue;


The daemon does actually insert the CCC automatically in case there is
only one handle left for the it:

        if (desc_start =3D=3D chrc_data->end_handle &&
            (chrc_data->properties & BT_GATT_CHRC_PROP_NOTIFY ||
             chrc_data->properties & BT_GATT_CHRC_PROP_INDICATE)) {
            bt_uuid_t ccc_uuid;

            /* If there is only one descriptor that must be the CCC
             * in case either notify or indicate are supported.
             */
            bt_uuid16_create(&ccc_uuid,
                    GATT_CLIENT_CHARAC_CFG_UUID);
            attr =3D gatt_db_insert_descriptor(client->db, desc_start,
                            &ccc_uuid, 0, NULL,
                            NULL, NULL);
            if (attr) {
                free(chrc_data);
                continue;
            }
        }

That said perhaps we need to revise the implementation of
get_attribute_index, it does attempt to take the first free index
which is incorrect when we are inserting characteristics it shall not
allocate the indexes one after another, instead the index shall be
handle - service->attribute[0].handle when the handle is set.

>
>
> On Wed, Apr 3, 2024 at 10:37=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Howard,
> >
> > On Wed, Apr 3, 2024 at 7:06=E2=80=AFAM Howard Chung <howardchung@google=
.com> wrote:
> > >
> > > service->attributes has an assumption that it should look like:
> > > |char_uuid|char_1|desc_1_1|desc_1_2|char_uuid|char_2|desc_2_1|char_uu=
id|...
> > > where desc_x_y means a descriptor of char_x.
> >
> > Will need to check the trace but I believe BlueZ always discover all
> > characteristics before moving to descriptors, if that is not happening
> > they there is probably a bug somewhere, that said perhaps you are
> > doing the discovery procedure with another stack which doesn't employ
> > the same logic, although inefficient it is possible to discover out of
> > order but that would require reassigning the descriptors to
> > characteristics once they are found, which is also inefficient but I
> > would understand if you after supporting other stacks.
> >
> > > In monitor, an attribute is inserted as soon as it is found. It is no=
t
> > > guranteed that all the descriptors of a characteristic would be found
> > > before another characteristic is found.
> >
> > You might want to include such a trace, don't recall seeing any stack
> > that does out-order discover.
> >
> > > This adds a function to insert the descriptor with the given handle t=
o
> > > an appropriate place in its service attribute list and make monitor t=
o
> > > use this function when a descripter is found.
> > >
> > > Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> > > ---
> > >
> > >  monitor/att.c        |  2 +-
> > >  src/shared/gatt-db.c | 66 ++++++++++++++++++++++++++++++++++++++++++=
++
> > >  src/shared/gatt-db.h |  9 ++++++
> > >  3 files changed, 76 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/monitor/att.c b/monitor/att.c
> > > index ddeb54d9e..503099745 100644
> > > --- a/monitor/att.c
> > > +++ b/monitor/att.c
> > > @@ -4153,7 +4153,7 @@ static struct gatt_db_attribute *insert_desc(co=
nst struct l2cap_frame *frame,
> > >         if (!db)
> > >                 return NULL;
> > >
> > > -       return gatt_db_append_descriptor(db, handle, uuid, 0, NULL, N=
ULL, NULL);
> > > +       return gatt_db_insert_descriptor(db, handle, uuid, 0, NULL, N=
ULL, NULL);
> > >  }
> > >
> > >  static void att_find_info_rsp_16(const struct l2cap_frame *frame)
> > > diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> > > index 39bba9b54..f08c5afaa 100644
> > > --- a/src/shared/gatt-db.c
> > > +++ b/src/shared/gatt-db.c
> > > @@ -1002,6 +1002,72 @@ service_append_descriptor(struct gatt_db_servi=
ce *service,
> > >         return service->attributes[i];
> > >  }
> > >
> > > +struct gatt_db_attribute *
> > > +gatt_db_insert_descriptor(struct gatt_db *db,
> > > +                                       uint16_t handle,
> > > +                                       const bt_uuid_t *uuid,
> > > +                                       uint32_t permissions,
> > > +                                       gatt_db_read_t read_func,
> > > +                                       gatt_db_write_t write_func,
> > > +                                       void *user_data)
> > > +{
> > > +       struct gatt_db_attribute *attrib, *iter_attr, *char_attr =3D =
NULL;
> > > +       struct gatt_db_service *service;
> > > +       int i, j, num_index, char_index;
> > > +
> > > +       attrib =3D gatt_db_get_service(db, handle);
> > > +       if (!attrib)
> > > +               return NULL;
> > > +
> > > +       service =3D attrib->service;
> > > +       num_index =3D get_attribute_index(service, 0);
> > > +       if (!num_index)
> > > +               return NULL;
> > > +
> > > +       // Find the characteristic the descriptor belongs to.
> > > +       for (i =3D 0; i < num_index; i++) {
> > > +               iter_attr =3D service->attributes[i];
> > > +               if (bt_uuid_cmp(&characteristic_uuid, &iter_attr->uui=
d))
> > > +                       continue;
> > > +
> > > +               if (iter_attr->handle > handle)
> > > +                       continue;
> > > +
> > > +               // Find the characteristic with the largest handle am=
ong those
> > > +               // with handles less than the descriptor's handle.
> > > +               if (!char_attr || iter_attr->handle > char_attr->hand=
le) {
> > > +                       char_attr =3D iter_attr;
> > > +                       char_index =3D i;
> > > +               }
> > > +       }
> > > +
> > > +       // There is no characteristic contain this descriptor. Someth=
ing went
> > > +       // wrong
> > > +       if (!char_attr)
> > > +               return NULL;
> > > +
> > > +       // Find the end of this characteristic
> > > +       for (i =3D char_index + 1; i < num_index; i++) {
> > > +               iter_attr =3D service->attributes[i];
> > > +
> > > +               if (!bt_uuid_cmp(&characteristic_uuid, &iter_attr->uu=
id) ||
> > > +                       !bt_uuid_cmp(&included_service_uuid, &iter_at=
tr->uuid))
> > > +                       break;
> > > +       }
> > > +
> > > +       // Move all of the attributes after the end of this character=
istic to
> > > +       // its next index.
> > > +       for (j =3D num_index; j > i; j--)
> > > +               service->attributes[j] =3D service->attributes[j - 1]=
;
> > > +
> > > +       service->attributes[i] =3D new_attribute(service, handle, uui=
d, NULL, 0);
> > > +
> > > +       set_attribute_data(service->attributes[i], read_func, write_f=
unc,
> > > +                                                       permissions, =
user_data);
> > > +
> > > +       return service->attributes[i];
> > > +}
> > > +
> > >  struct gatt_db_attribute *
> > >  gatt_db_append_descriptor(struct gatt_db *db,
> > >                                         uint16_t handle,
> > > diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> > > index ec0eccdfc..4c4e88d87 100644
> > > --- a/src/shared/gatt-db.h
> > > +++ b/src/shared/gatt-db.h
> > > @@ -80,6 +80,15 @@ gatt_db_append_characteristic(struct gatt_db *db,
> > >                                         gatt_db_write_t write_func,
> > >                                         void *user_data);
> > >
> > > +struct gatt_db_attribute *
> > > +gatt_db_insert_descriptor(struct gatt_db *db,
> > > +                                       uint16_t handle,
> > > +                                       const bt_uuid_t *uuid,
> > > +                                       uint32_t permissions,
> > > +                                       gatt_db_read_t read_func,
> > > +                                       gatt_db_write_t write_func,
> > > +                                       void *user_data);
> > > +
> > >  struct gatt_db_attribute *
> > >  gatt_db_append_descriptor(struct gatt_db *db,
> > >                                         uint16_t handle,
> > > --
> > > 2.44.0.478.gd926399ef9-goog
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
