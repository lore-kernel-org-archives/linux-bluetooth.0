Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF21317D37E
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719410601; cv=none; b=Ibo/0RBaoZOBdXSjOz2g7XPhvhZaFGcrOIQ3aBfaM8052QZu4IJQ/xNB6V2IYoUBg39wi/xXV9hKYedclpw7+mhjqwFD6qGS4GjFJTpvsTd3CWy+e+dJBqWQjZNRPVwr1glSBkUvPYJHxbLTDW9Ow7ddEgXR78/XXjN4gDcPLAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719410601; c=relaxed/simple;
	bh=S8KTamZUhjFtvA1OOEfb29lrmZ8AB9/t7RqztKL6cIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwOZ2ZFl+id4b/iuqhAMeDez2OFije6DxdBFcMDct5AY5kIxbt/vl4RK9UDHLctGU6Qu/HS21F3gM8kbxYCboN+9zP/hy+o4Qf5W75gO+M1PIEsrR9ZdzXIjcmUOeeK5wFv504xoVwsnozmlH8URU/IZVhvQ54NT8E/yXqe0vvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xe7jkIbv; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xe7jkIbv"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebe785b234so74332271fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 07:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719410598; x=1720015398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YClcim1OgiIHm5IBVLd2fK3Jz+I4Z1jnOdLg3fPAsI=;
        b=Xe7jkIbvvzjrKpSCermPeYEaoKQtOmoa+BkdmF6ToGblJ7+ntthhkidgqFRonYiyPg
         bhy8pDiphYPSCWAkX1Sp+Bnz0M6meDyzo9swbW0seuHtsPHnE+gbbVQCw2V++2SB2Bcg
         Hfo+UHVtLEc6geFRV6tQZtYA9VrvYZcfPxYkH50jBdZXC91BYVWdvuGAzB16egFb7j7Q
         Oc5OxoJdTIQ062f46BqEuaQS7CfIziyVfioV8HAyG/2QxoYenrydl+DIXwGG3FLoq8AS
         JuR/X/h1XhGBYJX+jUB7laj0z7bdaYgY/bq+BqKwf2ErQC+0oUw4lxo6GlU/wE62JTM4
         47fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719410598; x=1720015398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YClcim1OgiIHm5IBVLd2fK3Jz+I4Z1jnOdLg3fPAsI=;
        b=sYHVP1QfuLZEk0OOS84zqtb4yGkW74psqQ6/YPIAkaRr3OXWm0AwiEDJ3Fouk+1WnB
         qd6fl20jsXKfMn/nmnKSKAIvVgJrv0mBNqjGkUV0zUT3htoQ6JyGh6LnTVtbPcG/5gLZ
         DM2kLZ9ENlVXQbqkR0QSdGmR2nxit19r4gi0SVU6dns5WoaIiQ01TzgVaEhJTeTMQnS9
         w7Yk7mSF8/frRm4gjPyKq3mwd1cqqMhp05JTuajQfxT7RmqLNZbZoICDals0Z+ALqWQ5
         7xvWY4hYIhgo/HOJqbp5bB0NGx5MyNhqf+q6wOVqaCcnarFemzCmRcP7v8GnuVQlkIyF
         eXaw==
X-Gm-Message-State: AOJu0YwLifrk96Q3+6QbqRSGWPIyFAfr9Uj4UJb4+P1qycnZHjCS1U2s
	9UDFHqPKENqVxUQZFQB9pbOFaCvfSGuNqx/w4Lap13sbTwa3YBi3e1d1zlqVY5yzpzaDQlYXNz7
	OJVuQ9cET3cL5XXv/eBLeAC87dgE=
X-Google-Smtp-Source: AGHT+IHCk6m2shGQ0cky7oRGQ9F4CSqH0avgLBNdpyLdJUPseTVTF1tANrToSKGRYHhfYbJgDWLn5GJfPKgtGP8zixc=
X-Received: by 2002:a2e:3e13:0:b0:2ec:5685:f05f with SMTP id
 38308e7fff4ca-2ec5938a771mr74176311fa.49.1719410597890; Wed, 26 Jun 2024
 07:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH4xE45xkoHOY6kgYLf=HVVrMPrgqDZzRfEwGi3Ozi1MW4e+dg@mail.gmail.com>
In-Reply-To: <CAH4xE45xkoHOY6kgYLf=HVVrMPrgqDZzRfEwGi3Ozi1MW4e+dg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 26 Jun 2024 10:03:05 -0400
Message-ID: <CABBYNZ+aOGdnHTXdHuViagH+9JAFJOuZ=uN-eMcqTD1wPdK56A@mail.gmail.com>
Subject: Re: [bug report] GATT server crash after client disconnect (UAF)
To: =?UTF-8?Q?K=C3=A9vin_Courdesses?= <kevin.courdesses@beacon.bio>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

On Wed, Jun 26, 2024 at 6:58=E2=80=AFAM K=C3=A9vin Courdesses
<kevin.courdesses@beacon.bio> wrote:
>
> Hello,
>
> We detected a spurious crash of `bluetoothd` in our embedded system,
> acting as a GATT server. The system is running the latest BlueZ
> release (5.76).
>
> I traced the problem to a use-after-free (UAF) error, sometimes
> triggered when a device disconnects while a characteristic read or
> write is still being processed. Below are relevant debug and Valgrind
> traces.
>
> ----
> bluetoothd[167]: src/shared/gatt-server.c:handle_read_req() Read Req -
> handle: 0x0014
> bluetoothd[167]: src/shared/gatt-server.c:read_complete_cb() Read
> Complete: err 0
> bluetoothd[167]: src/shared/att.c:can_read_data() (chan 0x53bd198) ATT
> PDU received: 0x0a
> bluetoothd[167]: src/shared/gatt-server.c:handle_read_req() Read Req -
> handle: 0x002e
> bluetoothd[167]: src/shared/mgmt.c:can_read_data() [0x0000] event 0x000c
> bluetoothd[167]: src/adapter.c:dev_disconnected() Device
> 48:A4:72:79:82:D5 disconnected, reason 3
> bluetoothd[167]: src/adapter.c:adapter_remove_connection()
> bluetoothd[167]: plugins/policy.c:disconnect_cb() reason 3
> bluetoothd[167]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
> 48:A4:72:79:82:D5 type 1 status 0xe
> bluetoothd[167]: src/device.c:device_bonding_complete() bonding (nil)
> status 0x0e
> bluetoothd[167]: src/device.c:btd_device_set_temporary() temporary 1
> bluetoothd[167]: src/device.c:device_bonding_failed() status 14
> bluetoothd[167]: src/adapter.c:resume_discovery()
> bluetoothd[167]: src/shared/att.c:disconnect_cb() Channel 0x53bd198
> disconnected: Connection reset by peer
> bluetoothd[167]: src/device.c:att_disconnected_cb()
> bluetoothd[167]: src/device.c:att_disconnected_cb() Connection reset
> by peer (104)
> bluetoothd[167]: src/service.c:change_state() 0x53faa80: device
> 48:A4:72:79:82:D5 profile gap-profile state changed: connected ->
> disconnecting (0)
> bluetoothd[167]: src/service.c:change_state() 0x53faa80: device
> 48:A4:72:79:82:D5 profile gap-profile state changed: disconnecting ->
> disconnected (0)
> bluetoothd[167]: src/service.c:change_state() 0x54017a8: device
> 48:A4:72:79:82:D5 profile deviceinfo state changed: connected ->
> disconnecting (0)
> bluetoothd[167]: src/service.c:change_state() 0x54017a8: device
> 48:A4:72:79:82:D5 profile deviceinfo state changed: disconnecting ->
> disconnected (0)
> bluetoothd[167]: src/gatt-client.c:btd_gatt_client_disconnected()
> Device disconnected. Cleaning up.
> bluetoothd[167]: src/device.c:att_disconnected_cb() Automatic
> connection disabled
> bluetoothd[167]: src/gatt-database.c:btd_gatt_database_att_disconnected()
> bluetoothd[167]: src/gatt-database.c:att_disconnected()
> bluetoothd[167]: attrib/gattrib.c:g_attrib_unref() 0x53bd140: g_attrib_un=
ref=3D0
> bluetoothd[167]: src/gatt-database.c:read_reply_cb() Pending read was
> canceled when object got removed
> bluetoothd[167]: src/shared/gatt-server.c:read_complete_cb() Read
> Complete: err -110
> =3D=3D167=3D=3D Invalid read of size 4
> =3D=3D167=3D=3D    at 0x8277C: bt_att_chan_send_error_rsp (in
> /usr/libexec/bluetooth/bluetoothd)
> =3D=3D167=3D=3D  Address 0x53bd198 is 0 bytes inside a block of size 44 f=
ree'd
> =3D=3D167=3D=3D    at 0x482F350: free (vg_replace_malloc.c:538)
> =3D=3D167=3D=3D    by 0x8320F: disconnect_cb (in /usr/libexec/bluetooth/b=
luetoothd)
> =3D=3D167=3D=3D  Block was alloc'd at
> =3D=3D167=3D=3D    at 0x482DE08: malloc (vg_replace_malloc.c:307)
> =3D=3D167=3D=3D    by 0x7BDD3: util_malloc (in /usr/libexec/bluetooth/blu=
etoothd)
> =3D=3D167=3D=3D
> [cropped, valgrind complains a lot after this]
> ----
>
> These logs illustrate that the problem occurs soon after
> `read_complete_cb` is executed, in `bt_att_chan_send_error_rsp`.
>
> src/shared/gatt-server.c
>      904 static void read_complete_cb(struct gatt_db_attribute *attr, int=
 err,
>      905                     const uint8_t *value, size_t len,
>      906                     void *user_data)
>      907 {
>      908     struct async_read_op *op =3D user_data;
>      909     struct bt_gatt_server *server =3D op->server;
>      910     uint8_t rsp_opcode;
>      911     uint16_t mtu;
>      912     uint16_t handle;
>      913
>      914     DBG(server, "Read Complete: err %d", err);
>      915
>      916     mtu =3D bt_att_get_mtu(server->att);
>      917     handle =3D gatt_db_attribute_get_handle(attr);
>      918
>      919     if (err) {
>      920         bt_att_chan_send_error_rsp(op->chan, op->opcode, handle,=
 err);
>      921         async_read_op_destroy(op);
>      922         return;
>      923     }
>
> However, at this point, `op->chan` has already been freed by a `disconnec=
t_cb`.
>
> I'm not familiar with the BlueZ code base and I don't know the
> idiomatic way to fix this issue. I'd say `bt_att_chan_send_error_rsp`
> should only be called if `op->chan` is still allocated. The following
> patch attempts to implement a solution. It's probably not the right
> way to do it, but this seemingly fixes the issue on our side.

If we get to this point perhaps the op is being cleaned up so we might
need to set the op->chan to NULL or properly reference it at op
creation so it is not freed until the op is freed.

> -----
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 485ef07..baef0cc 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -2068,3 +2068,11 @@ done:
>
>         return true;
>  }
> +
> +struct queue *bt_att_get_chans(struct bt_att *att)
> +{
> +       if (!att)
> +               return NULL;
> +
> +       return att->chans;
> +}
> \ No newline at end of file
> diff --git a/src/shared/att.h b/src/shared/att.h
> index 6fd7863..98f91e1 100644
> --- a/src/shared/att.h
> +++ b/src/shared/att.h
> @@ -111,3 +111,5 @@ bool bt_att_set_remote_key(struct bt_att *att,
> uint8_t sign_key[16],
>                         bt_att_counter_func_t func, void *user_data);
>  bool bt_att_has_crypto(struct bt_att *att);
>  bool bt_att_set_retry(struct bt_att *att, unsigned int id, bool retry);
> +
> +struct queue *bt_att_get_chans(struct bt_att *att);
> \ No newline at end of file
> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> index 0e399ce..ca9af59 100644
> --- a/src/shared/gatt-server.c
> +++ b/src/shared/gatt-server.c
> @@ -790,7 +790,21 @@ static void write_complete_cb(struct
> gatt_db_attribute *attr, int err,
>         handle =3D gatt_db_attribute_get_handle(attr);
>
>         if (err)
> -               bt_att_chan_send_error_rsp(op->chan, op->opcode, handle, =
err);
> +       {
> +               // Only call bt_att_chan_send_error_rsp if the channel
> +               // is still valid
> +               struct bt_att *att =3D bt_gatt_server_get_att(server);
> +               struct queue *chans =3D bt_att_get_chans(att);
> +               const struct queue_entry *entry;
> +               for (entry =3D queue_get_entries(chans); entry; entry =3D
> entry->next)
> +               {
> +                       if (entry->data =3D=3D op->chan)
> +                       {
> +                               bt_att_chan_send_error_rsp(op->chan,
> op->opcode, handle, err);
> +                               break;
> +                       }
> +               }
> +       }
>         else
>                 bt_att_chan_send_rsp(op->chan, BT_ATT_OP_WRITE_RSP, NULL,=
 0);
>
> @@ -917,7 +931,19 @@ static void read_complete_cb(struct
> gatt_db_attribute *attr, int err,
>         handle =3D gatt_db_attribute_get_handle(attr);
>
>         if (err) {
> -               bt_att_chan_send_error_rsp(op->chan, op->opcode, handle, =
err);
> +               // Only call bt_att_chan_send_error_rsp if the channel
> +               // is still valid
> +               struct bt_att *att =3D bt_gatt_server_get_att(server);
> +               struct queue *chans =3D bt_att_get_chans(att);
> +               const struct queue_entry *entry;
> +               for (entry =3D queue_get_entries(chans); entry; entry =3D
> entry->next)
> +               {
> +                       if (entry->data =3D=3D op->chan)
> +                       {
> +                               bt_att_chan_send_error_rsp(op->chan,
> op->opcode, handle, err);
> +                               break;
> +                       }
> +               }
>                 async_read_op_destroy(op);
>                 return;
>         }
> -----
>
> Regards,
>
> K=C3=A9vin
>


--=20
Luiz Augusto von Dentz
