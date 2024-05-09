Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6321B10979
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 May 2024 02:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715221033; cv=none; b=TTQ6AA2OhVvgN9vt+bKNQvTZSfgP0kuguXHGPAWQCvmNU7Tz+gCUshkl0c9qDncWHgDZxKsdQ9zYGhVE6jeeOh3NB3i+EPEq0M9SUKKce9S+XVg46/AATlpqKepcJts7Oya2dsJq9JQU0nWU5sgRKClSr2+g5PP3U5mYQjKMSvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715221033; c=relaxed/simple;
	bh=Q82uB+Q/vKe+OqaVptglCKVoGQoUgoMFHI6hwJx2aio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1YpP3bd5u6Y8ecwVC7JEeCMZWtKIepCzVlufdEw9MxiCikNQS8h4WSSuv+ilse5wPj+OVwG3cIC595xkqYoVKassRoBkGIbKfvESQp0m0iOyudocWl0srf+Wxd3e0QMAFL+PwyhcAUEgUPfX23OV6t7MnXC10YE3PyiLlCOGPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=qwJizCls; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="qwJizCls"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2df848f9325so4274111fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2024 19:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715221029; x=1715825829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mrJuPMJgQJ12QP/io9xsaE0VljgZf3Gh/egtjjzTEQs=;
        b=qwJizClswq9klNponh7RtAP+H0tet7K6I5BQeiBtH/ztTXPux4EmeW4JfcAn0ThoxT
         KaN+EZtnqQTFxR3Fynddvn5I4JY/BVHDGMsrs00OCKuXuJq3yWAiyMhEaNeEJGWNjwzU
         BMa1hCc906ggQbMQq7c81a5Op6v3hqyADeQXpMxGBy6luk2AOrKUdDiFjpRom2HwD8cf
         2xY/aWGG6ZihN6V2tYpsvQ9ooGNo3j6soQPVWSJ6vrRevHCMDiv58NW7FlIPUbPpQ4st
         ra4PMfT/wCdkpoGeKxOFjUAD8vskZodM3B/z0sMVFH2Kv04zKCIJTSOezIhKBzaz+hFx
         aa5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715221029; x=1715825829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrJuPMJgQJ12QP/io9xsaE0VljgZf3Gh/egtjjzTEQs=;
        b=C5dLnl/BBDNIflm4OJlOCtuL0t0luhQiZEYbtT7wiRanHU7i5b70v8E1OI5E9lJtBK
         Vv0LOef3xL0+9oSc09K1t1HEYJP0NAd9h7aM+kivKe1mNej9wJV3EkDYGqjfsM8Wf8gi
         x5XSg3+Qx7H+DXCcqZucP6Ke7GpqClsc6ZM4kg7YR2+O27bwntJT5c3ZsU0h6P9sHAn4
         60njZLeOLiYqjEokATTI/y2QG76CAJkeK0qgAJslLQ/xY8XsvIpi8/8f562H8SkqYUhF
         5u2Vi+JB0I+aHccPslgBOqk7BXyuFYQrQx7b1kfTdNGPej5xIagp9VNjONOCiXEmLlgX
         NFww==
X-Gm-Message-State: AOJu0Yw/rlQB1K4ROE0D7KTdQZCTlG9cPst5KF8vH87tNUuks7+Ek+IU
	Akgk/Hkq5GE1n9/BRme7pIgpBTKVMI5dwdhPlnjfmjZ8olkbLWD9lLQ6KfdiHHYp0aTXPLRBEek
	xB8MvisuFrvNghyYph5OIFMii/ppYyqHEG/j9yw==
X-Google-Smtp-Source: AGHT+IFB23DmyjlCL4gwgXZ0vlFxOI3em1YNUW0PH1K5zBaOBLd7U7fz4xoteTGXQ4xa02vCHdzp+9A+lolYn9jOCxk=
X-Received: by 2002:a2e:2c18:0:b0:2e0:c689:f8cd with SMTP id
 38308e7fff4ca-2e44707ad53mr27986991fa.29.1715221029358; Wed, 08 May 2024
 19:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508154604.276763-1-arun@asymptotic.io> <20240508154604.276763-2-arun@asymptotic.io>
 <CABBYNZK-_k5913d=dFDw-+quYtyhn1125KKH0DYWKV=bcFHH2g@mail.gmail.com>
In-Reply-To: <CABBYNZK-_k5913d=dFDw-+quYtyhn1125KKH0DYWKV=bcFHH2g@mail.gmail.com>
From: Arun Raghavan <arun@asymptotic.io>
Date: Wed, 8 May 2024 22:16:33 -0400
Message-ID: <CAN03qa8RRTfeYbzF7FsqtMeR78sy8o6qAm1nmfpB8QFo2TNN2w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] profiles: Add initial code for an ASHA plugin
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey Luiz,
Thank you for the quick review!

On Wed, 8 May 2024 at 12:25, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
[...]
> > +// 1 sequence number, 4 for L2CAP header, 2 for SDU, and then 20ms of G.722
> > +#define ASHA_MTU 167
>
> Afaik the L2CAP header is already accounted for, or is it another header?

Good point. I guess both the L2CAP header and the SDU length are
accounted for. I've fixed this to be 161 now (sequence number + data).

[...]
> > +       // We need to bind before connect to work around getting the wrong addr
> > +       // type on older(?) kernels
>
> Lets use C style comments /* */ instead of //, so please fix that in
> other comments as well.

Done.

[...]
> > +       { "Codecs", "q", get_codecs, NULL, NULL,
> > +                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
>
> Codec?

I'm exposing the bitmask from DeviceCapabilities, which is
theoretically a set of codecs. In practice, since we only have one
codec, it will always be 0x2, but I thought I'd stick to the semantics
of the spec.

> > +       { "Device", "o", get_device, NULL, NULL,
> > +                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> > +       { "Transport", "o", get_transport, NULL, NULL,
> > +                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> > +       { }
> > +};
> > +
> > +static void asha_source_endpoint_register(struct asha_device *asha)
> > +{
> > +       char *path;
> > +       const struct media_endpoint *asha_ep;
> > +
> > +       path = make_endpoint_path(asha);
> > +       if (!path)
> > +               goto error;
> > +
> > +       if (g_dbus_register_interface(btd_get_dbus_connection(),
> > +                               path, MEDIA_ENDPOINT_INTERFACE,
> > +                               asha_ep_methods, NULL,
> > +                               asha_ep_properties,
> > +                               asha, NULL) == FALSE) {
> > +               error("Could not register remote ep %s", path);
> > +               goto error;
> > +       }
> > +
> > +       asha_ep = media_endpoint_get_asha();
> > +       asha->transport = media_transport_create(asha->device, path, NULL, 0,
> > +                       (void *) asha_ep, asha);
> > +
> > +error:
> > +       if (path)
> > +               free(path);
> > +       return;
> > +}
> > +
> > +static void asha_source_endpoint_unregister(struct asha_device *asha)
> > +{
> > +       char *path;
> > +
> > +       path = make_endpoint_path(asha);
> > +       if (!path)
> > +               goto error;
> > +
> > +       g_dbus_unregister_interface(btd_get_dbus_connection(),
> > +                               path, MEDIA_ENDPOINT_INTERFACE);
> > +
> > +       if (asha->transport) {
> > +               media_transport_destroy(asha->transport);
> > +               asha->transport = NULL;
> > +       }
> > +
> > +error:
> > +       if (path)
> > +               free(path);
> > +}
> > +
> > +static int asha_source_accept(struct btd_service *service)
> > +{
> > +       struct btd_device *device = btd_service_get_device(service);
> > +       struct gatt_db *db = btd_device_get_gatt_db(device);
> > +       struct bt_gatt_client *client = btd_device_get_gatt_client(device);
> > +       struct asha_device *asha = btd_service_get_user_data(service);
> > +       bt_uuid_t asha_uuid;
> > +       char addr[18];
> > +
> > +       ba2str(device_get_address(device), addr);
> > +       DBG("Accepting ASHA connection on %s", addr);
> > +
> > +       if (!asha) {
> > +               // Can this actually happen?
> > +               DBG("Not handling ASHA profile");
> > +               return -1;
> > +       }
> > +
> > +       asha->db = gatt_db_ref(db);
> > +       asha->client = bt_gatt_client_clone(client);
> > +
> > +       bt_uuid16_create(&asha_uuid, ASHA_SERVICE);
> > +       gatt_db_foreach_service(db, &asha_uuid, foreach_asha_service, asha);
> > +
> > +       if (!asha->attr) {
> > +               error("ASHA attribute not found");
> > +               asha_device_reset(asha);
> > +               return -1;
> > +       }
> > +
> > +       asha_source_endpoint_register(asha);
> > +
> > +       btd_service_connecting_complete(service, 0);
> > +
> > +       return 0;
> > +}
> > +
> > +static int asha_source_disconnect(struct btd_service *service)
> > +{
> > +       struct btd_device *device = btd_service_get_device(service);
> > +       struct gatt_db *db = btd_device_get_gatt_db(device);
> > +       struct bt_gatt_client *client = btd_device_get_gatt_client(device);
> > +       struct asha_device *asha = btd_service_get_user_data(service);
> > +       bt_uuid_t asha_uuid;
> > +       char addr[18];
> > +
> > +       ba2str(device_get_address(device), addr);
> > +       DBG("Disconnecting ASHA on %s", addr);
> > +
> > +       if (!asha) {
> > +               // Can this actually happen?
> > +               DBG("Not handlihng ASHA profile");
> > +               return -1;
> > +       }
> > +
> > +       asha_source_endpoint_unregister(asha);
> > +       asha_device_reset(asha);
> > +
> > +       btd_service_disconnecting_complete(service, 0);
> > +
> > +       return 0;
> > +}
> > +
> > +static struct btd_profile asha_source_profile = {
> > +       .name           = "asha-source",
> > +       .priority       = BTD_PROFILE_PRIORITY_MEDIUM,
> > +       .remote_uuid    = ASHA_PROFILE_UUID,
> > +       .experimental   = true,
> > +
> > +       .device_probe   = asha_source_device_probe,
> > +       .device_remove  = asha_source_device_remove,
> > +
> > +       .auto_connect   = true,
> > +       .accept         = asha_source_accept,
> > +       .disconnect     = asha_source_disconnect,
> > +};
> > +
> > +static int asha_init(void)
> > +{
> > +       int err;
> > +
> > +       err = btd_profile_register(&asha_source_profile);
> > +       if (err)
> > +               return err;
> > +
> > +       return 0;
> > +}
> > +
> > +static void asha_exit(void)
> > +{
> > +       btd_profile_unregister(&asha_source_profile);
> > +}
> > +
> > +BLUETOOTH_PLUGIN_DEFINE(asha, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
> > +                                                       asha_init, asha_exit)
> > diff --git a/profiles/audio/asha.h b/profiles/audio/asha.h
> > new file mode 100644
> > index 000000000..0fc28e8a3
> > --- /dev/null
> > +++ b/profiles/audio/asha.h
> > @@ -0,0 +1,34 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + *
> > + *  BlueZ - Bluetooth protocol stack for Linux
> > + *
> > + *  Copyright (C) 2024  Asymptotic Inc.
> > + *
> > + *  Author: Arun Raghavan <arun@asymptotic.io>
> > + *
> > + *
> > + */
> > +
> > +#include <stdint.h>
> > +
> > +struct asha_device;
> > +
> > +typedef enum {
> > +       ASHA_STOPPED = 0,
> > +       ASHA_STARTING,
> > +       ASHA_STARTED,
> > +       ASHA_STOPPING,
> > +} asha_state_t;
> > +
> > +typedef void (*asha_cb_t)(int status, void *data);
> > +
> > +uint16_t asha_device_get_render_delay(struct asha_device *asha);
> > +asha_state_t asha_device_get_state(struct asha_device *asha);
> > +int asha_device_get_fd(struct asha_device *asha);
> > +uint16_t asha_device_get_mtu(struct asha_device *asha);
> > +
> > +unsigned int asha_device_start(struct asha_device *asha, asha_cb_t cb,
> > +               void *user_data);
> > +unsigned int asha_device_stop(struct asha_device *asha, asha_cb_t cb,
> > +               void *user_data);
>
> I'd suggest we split the protocol portion from the plugin and put it
> under src/shared so we can do unit testing without the D-Bus blocks,
> Id got with bt_asha for instance name, we can do it later if you don't
> feel like it is necessary right now.

Ah, I did not follow the reason for that split previously. Done now.

[...]
> Otherwise it looks pretty good.

Thank you for the quick review! I'll send out a v2 with these fixes
and whatever the linter caught.

Cheers,
Arun
