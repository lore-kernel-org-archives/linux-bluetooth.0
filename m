Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8149017C7D3
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719399238; cv=none; b=NpWQJa4LwbrTxwmR+vNAAnqeCKZfkz23sCWoRLMuHj7o6N/DpFDvVFmh4Y2Fht9TPPD+Vhbpy/fnB6eL/0ieNj/aYFATXIK4WDfeJKlMI94PcTtJWv8UKst+2UUJlwpeQ0zRgH/2cGt40aAHIXINbrWOg2zVv96yxWIbB7q2808=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719399238; c=relaxed/simple;
	bh=if6hwJL4giIWmq18U62d6uGOzxFfgX5LpbJ+apKzmBU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=GpD/5Oi4rHMXcnKA05pNn0U1OMQFFnPIa1tGekpcBuUItZnyPio9WGrZRZLtYQLhxTl8UqAo9zpnetx62SQglIJgjV42eDtjtw8jueQ43L80hlrg0QdpJvuu+3TGjQWulvrhc/HfAttH5/uOQA4P8W670f57LhVTRjWOxGR5RHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=beacon.bio; spf=pass smtp.mailfrom=beacon.bio; dkim=pass (1024-bit key) header.d=beacon.bio header.i=@beacon.bio header.b=fWAZ8yxM; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=beacon.bio
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beacon.bio
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=beacon.bio header.i=@beacon.bio header.b="fWAZ8yxM"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52d259dbe3cso1232743e87.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 03:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beacon.bio; s=google; t=1719399234; x=1720004034; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=52AdRwZIJIdW0p4Fx+URJUF8CA/Pk53BmwxoGNYusSs=;
        b=fWAZ8yxMJPbmrKWvFIVA/qovPM+jtFLXEbf8Eumt7Kq9OMDwiQeT1CAwWk0951ipwX
         6yDSPnWPr/2Ga7DykyeoPj7OEKgYMW9I8HqpCyGz/2gSgTmlsmwcuAUch55jRbLN/pI6
         NG1UNI/q0Go0vl+EsLdBmTWJkG62gCtkecuw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719399234; x=1720004034;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52AdRwZIJIdW0p4Fx+URJUF8CA/Pk53BmwxoGNYusSs=;
        b=Py52BcO31UB3iPq5r9jx5kTpRgfGtRleSONJrDiq63deJ3SvPVpbucpbByfRU3jwHb
         mUBl5qvaIXf8BfcswCWcYXpTcxe/jIdSj/6j51E1o2jx1B1hHXDbiDv0s0nMV6DM52lN
         p4ddmcThRCmXwSTXaYxPhrPx6ff+oFm583YSbRaSh1+XnrzEtU2L/k8a5tTpTy61kHcL
         reR0S4HZTYWKuivOomwbdIfFWGg1O/HogmLebCFApkJDnGeUW27D1cf37ftXqW51DvLn
         pCPB0vvzVeiv0uK1IXUT1GO06Ic1IHwxa6Hh9dUZzXM8wm043PtFm11KIiS8vLwsruFm
         RL1Q==
X-Gm-Message-State: AOJu0Yz5XF6l5/VPR/jmTX1fEFOa6VFfuCI0x4zlQ58U3xolgBZ/FFKa
	ksL5B9IG3NDseDBUjQCn9wrlDIu8LZpmAtbqG6DIrh6SIVMjO9NFKcN50riqCMNmY7xGTf6PT0J
	At2ZCwbYfKscE8q/4+O49cdnM5Ap3ibJskfSMSHXjssKG4ffa9LY=
X-Google-Smtp-Source: AGHT+IEo22wsQ0VMwSFhdoHVLVaSi9kY1JynJBHUbccDvpqSAb86QTo+ZhlKc1fu7L6imcsLNsekQxtOP0/GJOZL8Ls=
X-Received: by 2002:ac2:46d4:0:b0:52b:8c88:2d6b with SMTP id
 2adb3069b0e04-52ce061077fmr7048158e87.11.1719399234224; Wed, 26 Jun 2024
 03:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?K=C3=A9vin_Courdesses?= <kevin.courdesses@beacon.bio>
Date: Wed, 26 Jun 2024 12:53:43 +0200
Message-ID: <CAH4xE45xkoHOY6kgYLf=HVVrMPrgqDZzRfEwGi3Ozi1MW4e+dg@mail.gmail.com>
Subject: [bug report] GATT server crash after client disconnect (UAF)
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

We detected a spurious crash of `bluetoothd` in our embedded system,
acting as a GATT server. The system is running the latest BlueZ
release (5.76).

I traced the problem to a use-after-free (UAF) error, sometimes
triggered when a device disconnects while a characteristic read or
write is still being processed. Below are relevant debug and Valgrind
traces.

----
bluetoothd[167]: src/shared/gatt-server.c:handle_read_req() Read Req -
handle: 0x0014
bluetoothd[167]: src/shared/gatt-server.c:read_complete_cb() Read
Complete: err 0
bluetoothd[167]: src/shared/att.c:can_read_data() (chan 0x53bd198) ATT
PDU received: 0x0a
bluetoothd[167]: src/shared/gatt-server.c:handle_read_req() Read Req -
handle: 0x002e
bluetoothd[167]: src/shared/mgmt.c:can_read_data() [0x0000] event 0x000c
bluetoothd[167]: src/adapter.c:dev_disconnected() Device
48:A4:72:79:82:D5 disconnected, reason 3
bluetoothd[167]: src/adapter.c:adapter_remove_connection()
bluetoothd[167]: plugins/policy.c:disconnect_cb() reason 3
bluetoothd[167]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
48:A4:72:79:82:D5 type 1 status 0xe
bluetoothd[167]: src/device.c:device_bonding_complete() bonding (nil)
status 0x0e
bluetoothd[167]: src/device.c:btd_device_set_temporary() temporary 1
bluetoothd[167]: src/device.c:device_bonding_failed() status 14
bluetoothd[167]: src/adapter.c:resume_discovery()
bluetoothd[167]: src/shared/att.c:disconnect_cb() Channel 0x53bd198
disconnected: Connection reset by peer
bluetoothd[167]: src/device.c:att_disconnected_cb()
bluetoothd[167]: src/device.c:att_disconnected_cb() Connection reset
by peer (104)
bluetoothd[167]: src/service.c:change_state() 0x53faa80: device
48:A4:72:79:82:D5 profile gap-profile state changed: connected ->
disconnecting (0)
bluetoothd[167]: src/service.c:change_state() 0x53faa80: device
48:A4:72:79:82:D5 profile gap-profile state changed: disconnecting ->
disconnected (0)
bluetoothd[167]: src/service.c:change_state() 0x54017a8: device
48:A4:72:79:82:D5 profile deviceinfo state changed: connected ->
disconnecting (0)
bluetoothd[167]: src/service.c:change_state() 0x54017a8: device
48:A4:72:79:82:D5 profile deviceinfo state changed: disconnecting ->
disconnected (0)
bluetoothd[167]: src/gatt-client.c:btd_gatt_client_disconnected()
Device disconnected. Cleaning up.
bluetoothd[167]: src/device.c:att_disconnected_cb() Automatic
connection disabled
bluetoothd[167]: src/gatt-database.c:btd_gatt_database_att_disconnected()
bluetoothd[167]: src/gatt-database.c:att_disconnected()
bluetoothd[167]: attrib/gattrib.c:g_attrib_unref() 0x53bd140: g_attrib_unre=
f=3D0
bluetoothd[167]: src/gatt-database.c:read_reply_cb() Pending read was
canceled when object got removed
bluetoothd[167]: src/shared/gatt-server.c:read_complete_cb() Read
Complete: err -110
=3D=3D167=3D=3D Invalid read of size 4
=3D=3D167=3D=3D    at 0x8277C: bt_att_chan_send_error_rsp (in
/usr/libexec/bluetooth/bluetoothd)
=3D=3D167=3D=3D  Address 0x53bd198 is 0 bytes inside a block of size 44 fre=
e'd
=3D=3D167=3D=3D    at 0x482F350: free (vg_replace_malloc.c:538)
=3D=3D167=3D=3D    by 0x8320F: disconnect_cb (in /usr/libexec/bluetooth/blu=
etoothd)
=3D=3D167=3D=3D  Block was alloc'd at
=3D=3D167=3D=3D    at 0x482DE08: malloc (vg_replace_malloc.c:307)
=3D=3D167=3D=3D    by 0x7BDD3: util_malloc (in /usr/libexec/bluetooth/bluet=
oothd)
=3D=3D167=3D=3D
[cropped, valgrind complains a lot after this]
----

These logs illustrate that the problem occurs soon after
`read_complete_cb` is executed, in `bt_att_chan_send_error_rsp`.

src/shared/gatt-server.c
     904 static void read_complete_cb(struct gatt_db_attribute *attr, int e=
rr,
     905                     const uint8_t *value, size_t len,
     906                     void *user_data)
     907 {
     908     struct async_read_op *op =3D user_data;
     909     struct bt_gatt_server *server =3D op->server;
     910     uint8_t rsp_opcode;
     911     uint16_t mtu;
     912     uint16_t handle;
     913
     914     DBG(server, "Read Complete: err %d", err);
     915
     916     mtu =3D bt_att_get_mtu(server->att);
     917     handle =3D gatt_db_attribute_get_handle(attr);
     918
     919     if (err) {
     920         bt_att_chan_send_error_rsp(op->chan, op->opcode, handle, e=
rr);
     921         async_read_op_destroy(op);
     922         return;
     923     }

However, at this point, `op->chan` has already been freed by a `disconnect_=
cb`.

I'm not familiar with the BlueZ code base and I don't know the
idiomatic way to fix this issue. I'd say `bt_att_chan_send_error_rsp`
should only be called if `op->chan` is still allocated. The following
patch attempts to implement a solution. It's probably not the right
way to do it, but this seemingly fixes the issue on our side.

-----
diff --git a/src/shared/att.c b/src/shared/att.c
index 485ef07..baef0cc 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -2068,3 +2068,11 @@ done:

        return true;
 }
+
+struct queue *bt_att_get_chans(struct bt_att *att)
+{
+       if (!att)
+               return NULL;
+
+       return att->chans;
+}
\ No newline at end of file
diff --git a/src/shared/att.h b/src/shared/att.h
index 6fd7863..98f91e1 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -111,3 +111,5 @@ bool bt_att_set_remote_key(struct bt_att *att,
uint8_t sign_key[16],
                        bt_att_counter_func_t func, void *user_data);
 bool bt_att_has_crypto(struct bt_att *att);
 bool bt_att_set_retry(struct bt_att *att, unsigned int id, bool retry);
+
+struct queue *bt_att_get_chans(struct bt_att *att);
\ No newline at end of file
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 0e399ce..ca9af59 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -790,7 +790,21 @@ static void write_complete_cb(struct
gatt_db_attribute *attr, int err,
        handle =3D gatt_db_attribute_get_handle(attr);

        if (err)
-               bt_att_chan_send_error_rsp(op->chan, op->opcode, handle, er=
r);
+       {
+               // Only call bt_att_chan_send_error_rsp if the channel
+               // is still valid
+               struct bt_att *att =3D bt_gatt_server_get_att(server);
+               struct queue *chans =3D bt_att_get_chans(att);
+               const struct queue_entry *entry;
+               for (entry =3D queue_get_entries(chans); entry; entry =3D
entry->next)
+               {
+                       if (entry->data =3D=3D op->chan)
+                       {
+                               bt_att_chan_send_error_rsp(op->chan,
op->opcode, handle, err);
+                               break;
+                       }
+               }
+       }
        else
                bt_att_chan_send_rsp(op->chan, BT_ATT_OP_WRITE_RSP, NULL, 0=
);

@@ -917,7 +931,19 @@ static void read_complete_cb(struct
gatt_db_attribute *attr, int err,
        handle =3D gatt_db_attribute_get_handle(attr);

        if (err) {
-               bt_att_chan_send_error_rsp(op->chan, op->opcode, handle, er=
r);
+               // Only call bt_att_chan_send_error_rsp if the channel
+               // is still valid
+               struct bt_att *att =3D bt_gatt_server_get_att(server);
+               struct queue *chans =3D bt_att_get_chans(att);
+               const struct queue_entry *entry;
+               for (entry =3D queue_get_entries(chans); entry; entry =3D
entry->next)
+               {
+                       if (entry->data =3D=3D op->chan)
+                       {
+                               bt_att_chan_send_error_rsp(op->chan,
op->opcode, handle, err);
+                               break;
+                       }
+               }
                async_read_op_destroy(op);
                return;
        }
-----

Regards,

K=C3=A9vin
