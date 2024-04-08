Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7BC3032A
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578984; cv=none; b=Ae8UmcTk3N/EgYoDeYju0GkgZaPePLx8sFmdkT44De6HufhvBSgBz28oPKc4RmeYwZOk+hEBzSgao70VmePT0UWxSlI0OvJqEOjqZb5lqW/WmjkDOUoL0vqV5e0ZGRGAgMuQX7ruW+OrRNlCxXh3Ci/LTLvl69d4dPGXUQdpe+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578984; c=relaxed/simple;
	bh=r2ab7DnHx/JBZJG0msf7iyZR7W75hbYUjqwWXv3ANc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZdOKyRSQwoz604FmZsYFydJLjknK4C0R8SxYtrDGa0GD6iCke50KMpSXqQMn97rLACIC56fNyb51SbOTO6o3npEweIJRBj52z5edc9jteByjTEMTXoPbZufiOvtc5mVjNgcVvLc307vaaqqD2ojWNpvkWodupkD1NvlGU8oIBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jEORUiEN; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jEORUiEN"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36a2825cdf7so131475ab.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2024 05:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712578981; x=1713183781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4pc/eyzibX/2rI6tU9nYlDx8gXcfACJ+68NLUMiRRw=;
        b=jEORUiENjCiQE+4u8Ov0BNM/hg0VtJHgOnK+SMBcUaLS7jlitvLJEc/Ggdntqi0MQJ
         TJCo24pOM9E9V2fCI6x9TX3wylTxfEuAumPWfRts/ezLbSJLX2XYGcI9ngJX1V9l/iQL
         wVdLCzW9if/5ic4XSiM1Hdise+EtLPGwGI/oZK8v+fZunaKEDj6fk+nFCK28SUXy1ude
         SMBEyj1RB+dB9ELZUc5G/O+21Ny/2VDGUYo5ep3rsujHQBkX4aXNDGkn/zaibaQVaBBB
         biztG9qWXoeo8WMPdfNlk9W6sCtHMkVA+ZpBHwdQLfpG+BSI/LmKi41/Ocyp59dPuwgc
         BC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712578981; x=1713183781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4pc/eyzibX/2rI6tU9nYlDx8gXcfACJ+68NLUMiRRw=;
        b=aCzDTWkSY424+q1JnSPBdd/WS3jBQwhTAeqGb78fCZwJ56JHCyouPDc80+DmoELu9w
         6hJJn7mtRALrlx+OvvhNjr4Ixhi7jMjtU3CwyNteppv3hrIXzIOhDDQ1HCaBHaSoAZ1V
         UFJElzWb09O/ebLM6jhMaP6LW8MdbN0vYo0TSXUw8AeQYkmYNxbN5eKBxE+HHUFbcxyc
         xe5IxWDWDRlxwedPjEBddG7MGbT064A96ZS/e2M6gxa4GzOGZ+UDynziulxdgATz3V9E
         QQ4+17pDLrEC7TNwrx2I6gBEInCuz0dhi8QhSB/v03Zehw4V/++S8SqNTBrdE4IOqojk
         /0NQ==
X-Gm-Message-State: AOJu0YyJM3cxIMUtY12tQ9KcZ43WjxFzD3xoM4Mc259Itmes8cP6OvUp
	6jfYwxfGH6rdZZzf57uRKI/sujGPG+7pgvvTO/GXmLHHS80epTM6WW/HzcyT1RN4UaSfA2q0vwj
	LwMhAJhaQHtuuB3yX+JpjB4v0a+f3VqM8W7bbGVSV8T4POJfTQSNu
X-Google-Smtp-Source: AGHT+IGJ/dclV0IsmupCW+h1mEQ4S+YonUwoqsOdpZfQ065ObzbiHQYVwGsD0WmlKFki7dYAvznOrqB32KtBwcE18KA=
X-Received: by 2002:a92:c005:0:b0:368:d0b1:4cad with SMTP id
 q5-20020a92c005000000b00368d0b14cadmr354576ild.7.1712578981443; Mon, 08 Apr
 2024 05:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403110549.75516-1-howardchung@google.com>
 <20240403110549.75516-2-howardchung@google.com> <CABBYNZKpPbnPcfJmi42smd6E-JUh6kBi9aX6EWpq-h7_tBVJMA@mail.gmail.com>
In-Reply-To: <CABBYNZKpPbnPcfJmi42smd6E-JUh6kBi9aX6EWpq-h7_tBVJMA@mail.gmail.com>
From: Yun-hao Chung <howardchung@google.com>
Date: Mon, 8 Apr 2024 20:22:50 +0800
Message-ID: <CAPHZWUcRfNT-QXGE3FQhMYUHG6jr8gAyjpFZc=ov9tbiNHaAWg@mail.gmail.com>
Subject: Re: [Bluez PATCH 2/2] shared/gatt: Add descriptor insert function
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

Thanks for the response.

This issue was found in ChromeOS edition BlueZ. I'm not sure if any
official BlueZ would do the same discovery procedure or not.

I extracted relevant part of the trace as below
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
< ACL Data TX: Handle 2048 flags 0x00 dlen 11

                                                #43961 [hci0]
2024-03-05 07:33:55.936283
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x001f-0xffff
        Attribute group type: Primary Service (0x2800)
...
> ACL Data RX: Handle 2048 flags 0x02 dlen 27                              =
                                                                           =
                                        #43963 [hci0] 2024-03-05 07:33:55.9=
67020
> ACL Data RX: Handle 2048 flags 0x01 dlen 3                               =
                                                                           =
                                        #43964 [hci0] 2024-03-05 07:33:55.9=
67022
      ATT: Read By Group Type Response (0x11) len 25
        Attribute data length: 6
        Attribute group list: 4 entries
        Handle range: 0x001f-0x0035
        UUID: Human Interface Device (0x1812)
        Handle range: 0x0036-0x0044
        UUID: Human Interface Device (0x1812)
        Handle range: 0x0045-0x0055
        UUID: Human Interface Device (0x1812)
        Handle range: 0x0056-0x0062
        UUID: Logitech International SA (0xfd72)
=E2=80=A6
< ACL Data TX: Handle 2048 flags 0x00 dlen 11

                                                #44018 [hci0]
2024-03-05 07:33:56.281436
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0021-0xffff
        Attribute type: Characteristic (0x2803)
...
> ACL Data RX: Handle 2048 flags 0x02 dlen 27                              =
                                                                           =
                                        #44023 [hci0] 2024-03-05 07:33:56.3=
11026
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
        Handle: 0x0022
        Value: 122300332a
            Properties: 0x12
              Read (0x02)
              Notify (0x10)
            Value Handle: 0x0023
            Value UUID: Boot Mouse Input Report (0x2a33)
        Handle: 0x0025
        Value: 0226004b2a
            Properties: 0x02
              Read (0x02)
            Value Handle: 0x0026
            Value UUID: Report Map (0x2a4b)
        Handle: 0x0027
        Value: 1228004d2a
            Properties: 0x12
              Read (0x02)
              Notify (0x10)
            Value Handle: 0x0028
            Value UUID: Report (0x2a4d)
...
< ACL Data TX: Handle 2048 flags 0x00 dlen 11

                                                #44024 [hci0]
2024-03-05 07:33:56.311458
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0028-0xffff
        Attribute type: Characteristic (0x2803)
=E2=80=A6
> ACL Data RX: Handle 2048 flags 0x02 dlen 27                              =
                                                                           =
                                        #44029 [hci0] 2024-03-05 07:33:56.3=
41025
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
        Handle: 0x002b
        Value: 122c004d2a
            Properties: 0x12
              Read (0x02)
              Notify (0x10)
            Value Handle: 0x002c
            Value UUID: Report (0x2a4d)
        Handle: 0x002f
        Value: 0e30004d2a
            Properties: 0x0e
              Read (0x02)
              Write Without Response (0x04)
              Write (0x08)
            Value Handle: 0x0030
            Value UUID: Report (0x2a4d)
        Handle: 0x0032
        Value: 0433004c2a
            Properties: 0x04
              Write Without Response (0x04)
            Value Handle: 0x0033
            Value UUID: HID Control Point (0x2a4c)
=E2=80=A6
< ACL Data TX: Handle 2048 flags 0x00 dlen 9

                                                #44071 [hci0]
2024-03-05 07:33:56.702334
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0029-0x002a
=E2=80=A6
> ACL Data RX: Handle 2048 flags 0x02 dlen 14                              =
                                                                           =
                                        #44073 [hci0] 2024-03-05 07:33:56.7=
31069
      ATT: Find Information Response (0x05) len 9
        Format: UUID-16 (0x01)
        Handle: 0x0029
        UUID: Client Characteristic Configuration (0x2902)
        Handle: 0x002a
        UUID: Report Reference (0x2908)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

When decoding packet #44073, we can't append descriptors 0x0029 and
0x002a at the tail of the |service->attributes| since the
characteristics 0x002b,0x002f and 0x0032 are already in the array.



On Wed, Apr 3, 2024 at 10:37=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Howard,
>
> On Wed, Apr 3, 2024 at 7:06=E2=80=AFAM Howard Chung <howardchung@google.c=
om> wrote:
> >
> > service->attributes has an assumption that it should look like:
> > |char_uuid|char_1|desc_1_1|desc_1_2|char_uuid|char_2|desc_2_1|char_uuid=
|...
> > where desc_x_y means a descriptor of char_x.
>
> Will need to check the trace but I believe BlueZ always discover all
> characteristics before moving to descriptors, if that is not happening
> they there is probably a bug somewhere, that said perhaps you are
> doing the discovery procedure with another stack which doesn't employ
> the same logic, although inefficient it is possible to discover out of
> order but that would require reassigning the descriptors to
> characteristics once they are found, which is also inefficient but I
> would understand if you after supporting other stacks.
>
> > In monitor, an attribute is inserted as soon as it is found. It is not
> > guranteed that all the descriptors of a characteristic would be found
> > before another characteristic is found.
>
> You might want to include such a trace, don't recall seeing any stack
> that does out-order discover.
>
> > This adds a function to insert the descriptor with the given handle to
> > an appropriate place in its service attribute list and make monitor to
> > use this function when a descripter is found.
> >
> > Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> > ---
> >
> >  monitor/att.c        |  2 +-
> >  src/shared/gatt-db.c | 66 ++++++++++++++++++++++++++++++++++++++++++++
> >  src/shared/gatt-db.h |  9 ++++++
> >  3 files changed, 76 insertions(+), 1 deletion(-)
> >
> > diff --git a/monitor/att.c b/monitor/att.c
> > index ddeb54d9e..503099745 100644
> > --- a/monitor/att.c
> > +++ b/monitor/att.c
> > @@ -4153,7 +4153,7 @@ static struct gatt_db_attribute *insert_desc(cons=
t struct l2cap_frame *frame,
> >         if (!db)
> >                 return NULL;
> >
> > -       return gatt_db_append_descriptor(db, handle, uuid, 0, NULL, NUL=
L, NULL);
> > +       return gatt_db_insert_descriptor(db, handle, uuid, 0, NULL, NUL=
L, NULL);
> >  }
> >
> >  static void att_find_info_rsp_16(const struct l2cap_frame *frame)
> > diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> > index 39bba9b54..f08c5afaa 100644
> > --- a/src/shared/gatt-db.c
> > +++ b/src/shared/gatt-db.c
> > @@ -1002,6 +1002,72 @@ service_append_descriptor(struct gatt_db_service=
 *service,
> >         return service->attributes[i];
> >  }
> >
> > +struct gatt_db_attribute *
> > +gatt_db_insert_descriptor(struct gatt_db *db,
> > +                                       uint16_t handle,
> > +                                       const bt_uuid_t *uuid,
> > +                                       uint32_t permissions,
> > +                                       gatt_db_read_t read_func,
> > +                                       gatt_db_write_t write_func,
> > +                                       void *user_data)
> > +{
> > +       struct gatt_db_attribute *attrib, *iter_attr, *char_attr =3D NU=
LL;
> > +       struct gatt_db_service *service;
> > +       int i, j, num_index, char_index;
> > +
> > +       attrib =3D gatt_db_get_service(db, handle);
> > +       if (!attrib)
> > +               return NULL;
> > +
> > +       service =3D attrib->service;
> > +       num_index =3D get_attribute_index(service, 0);
> > +       if (!num_index)
> > +               return NULL;
> > +
> > +       // Find the characteristic the descriptor belongs to.
> > +       for (i =3D 0; i < num_index; i++) {
> > +               iter_attr =3D service->attributes[i];
> > +               if (bt_uuid_cmp(&characteristic_uuid, &iter_attr->uuid)=
)
> > +                       continue;
> > +
> > +               if (iter_attr->handle > handle)
> > +                       continue;
> > +
> > +               // Find the characteristic with the largest handle amon=
g those
> > +               // with handles less than the descriptor's handle.
> > +               if (!char_attr || iter_attr->handle > char_attr->handle=
) {
> > +                       char_attr =3D iter_attr;
> > +                       char_index =3D i;
> > +               }
> > +       }
> > +
> > +       // There is no characteristic contain this descriptor. Somethin=
g went
> > +       // wrong
> > +       if (!char_attr)
> > +               return NULL;
> > +
> > +       // Find the end of this characteristic
> > +       for (i =3D char_index + 1; i < num_index; i++) {
> > +               iter_attr =3D service->attributes[i];
> > +
> > +               if (!bt_uuid_cmp(&characteristic_uuid, &iter_attr->uuid=
) ||
> > +                       !bt_uuid_cmp(&included_service_uuid, &iter_attr=
->uuid))
> > +                       break;
> > +       }
> > +
> > +       // Move all of the attributes after the end of this characteris=
tic to
> > +       // its next index.
> > +       for (j =3D num_index; j > i; j--)
> > +               service->attributes[j] =3D service->attributes[j - 1];
> > +
> > +       service->attributes[i] =3D new_attribute(service, handle, uuid,=
 NULL, 0);
> > +
> > +       set_attribute_data(service->attributes[i], read_func, write_fun=
c,
> > +                                                       permissions, us=
er_data);
> > +
> > +       return service->attributes[i];
> > +}
> > +
> >  struct gatt_db_attribute *
> >  gatt_db_append_descriptor(struct gatt_db *db,
> >                                         uint16_t handle,
> > diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> > index ec0eccdfc..4c4e88d87 100644
> > --- a/src/shared/gatt-db.h
> > +++ b/src/shared/gatt-db.h
> > @@ -80,6 +80,15 @@ gatt_db_append_characteristic(struct gatt_db *db,
> >                                         gatt_db_write_t write_func,
> >                                         void *user_data);
> >
> > +struct gatt_db_attribute *
> > +gatt_db_insert_descriptor(struct gatt_db *db,
> > +                                       uint16_t handle,
> > +                                       const bt_uuid_t *uuid,
> > +                                       uint32_t permissions,
> > +                                       gatt_db_read_t read_func,
> > +                                       gatt_db_write_t write_func,
> > +                                       void *user_data);
> > +
> >  struct gatt_db_attribute *
> >  gatt_db_append_descriptor(struct gatt_db *db,
> >                                         uint16_t handle,
> > --
> > 2.44.0.478.gd926399ef9-goog
> >
>
>
> --
> Luiz Augusto von Dentz
