Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0274D8AE
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727445846; cv=none; b=NOUl15dRBGDbAceGLiHoVObbrrqC7MUOrZl+L/kW4Gy8k+jhaSy6DEiHT7QRmtyzaMkfJQe8Rdo0SnOVOIEJMw9/wB3+M3qsquUR8SPuCAFuX+csEvcJjcaN0WTqFRfyezl0DaF2uI8O4HVYs9Y1wz5oPzP5DSQqGJqxtMXK0bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727445846; c=relaxed/simple;
	bh=xi771b3alc1fONBXY5mndzop2Ch4Alrv71ofNyh6lV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Feu2C2KeoR9RmOFpC//FNcZO23DcJAYCO2GLCAIur9kFGooTrWQt2GFtrXozjibW1Yg12wR34e9ho6lOPzHIVM0YCfMOz+d1LaBwW9sCkxan3qM+cIetNSZjDoJxtxEAJ7exNO1tl0RsYmVIIQwaZlV9KHB6NEZOBgPSsOx5Qko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPQ928xn; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPQ928xn"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e078d28fe9so1672725a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 07:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727445844; x=1728050644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmOY+Gm8ZjonH2bBJkgcnepbJdHLQAXV0V/l6wZ3V/g=;
        b=LPQ928xnv6vndw4uYWzRp4bz9LBvoHipHsoucxOp34yUS1aG1R6FUQdUobvvHQUpOS
         8UazUDEeNHQ+E0kTSmoXcg9uzrxKROL5tiP8dI0qNvLhbGusV2FSAI+gwEhM3XqCZkr+
         RXunbYFC18Drv71R8IP3oGjydwF1Ya1n48CVPvThqeTk1mP2Cx1de6BNNIWN9TIwe5EQ
         Be3vaw+WvdFWZm8ctIA+FLoaiarmWbfykPPLa+wKSQ0ggIt76FTLlS/zGizLM2a46C4c
         mdfiEl4lb83lZkbRGAIRMphL0NzsVJjH/0M/t7mUMmcBKUaSuS2W/v+5aNtA33kZYO3G
         P56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727445844; x=1728050644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmOY+Gm8ZjonH2bBJkgcnepbJdHLQAXV0V/l6wZ3V/g=;
        b=HhCwe0Th28SbgJmTt3hq16mzYfBdVDd8c9+KEWoXNGMk/Le1BXHJlArpSdS4DK9ukU
         LJxa57A+uf0mudBpz46B67OTbfDG3OIzw1OvoMSHoPwgWFTeq9kbhnsV5I+In4bJTk3G
         ikYcWIL+5K4y9H77YbtGO82vNJEUvgM9C7KpwfgD8+7t7ilnt13LBkA6LDc3JRr+/w3o
         AnQHVtzL8cQtLFG9RAVPWhTElnqfBNrCP04OGrufexWM5DOnnsANWmX+dbByLQevnSYc
         OPHfdbpUcaTKBdqQHPuQgQzkwy0jre602yBogfgXIfou8cMiMobTgGQM05bTeFBv9DRL
         kt5A==
X-Gm-Message-State: AOJu0YyJGtI8+QIj3z73GYuWd3l76skqa5C/tJjpbcfmZ5iovTxsT7pM
	0lWHdswKMdNYTT/wex3yRJa+s5KaR5gfPBLPiP16LpsWHvkkOUM9j7dlv0nA1+79fVZsRJRw29/
	6wTsuxJNLQeF7xsA6RPtqSoqxITs=
X-Google-Smtp-Source: AGHT+IGpMTUgVTUMt2RyFebTEYKoZvP399JiXhRSh6/QWCKxCAT29dS51dTCE5d2CwCJaNUDblKWhcUYjcAoW680Hio=
X-Received: by 2002:a17:90a:cb96:b0:2c8:f3b4:421 with SMTP id
 98e67ed59e1d1-2e0b89a68d7mr4126522a91.4.1727445844023; Fri, 27 Sep 2024
 07:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927023854.2447283-1-quic_chejiang@quicinc.com>
In-Reply-To: <20240927023854.2447283-1-quic_chejiang@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 27 Sep 2024 10:03:27 -0400
Message-ID: <CABBYNZKy191ztOWergLbA1B5O0f-E-e59XT4eQoEFebzxPW-iQ@mail.gmail.com>
Subject: Re: [PATCH v4] device: Remove device after all bearers are disconnected
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_jiaymao@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cheng,

On Thu, Sep 26, 2024 at 10:39=E2=80=AFPM Cheng Jiang <quic_chejiang@quicinc=
.com> wrote:
>
> For a combo mode remote, both BR/EDR and BLE may be connected.
> RemoveDevice should be handled after all bearers are dropped,
> otherwise, remove device is not performed in adapter_remove_connection.
> ---
>  src/device.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/src/device.c b/src/device.c
> index f8f61e643..4efd755a0 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -3492,8 +3492,27 @@ void device_remove_connection(struct btd_device *d=
evice, uint8_t bdaddr_type,
>                 DBusMessage *msg =3D device->disconnects->data;
>
>                 if (dbus_message_is_method_call(msg, ADAPTER_INTERFACE,
> -                                                               "RemoveDe=
vice"))
> +                                                       "RemoveDevice")) =
{
> +
> +                       /* Don't handle the RemoveDevice msg if device is
> +                        * connected. For a dual-mode remote, both BR/EDR
> +                        * and BLE may be connected, RemoveDevice should
> +                        * be handled after all bearers are disconnects.
> +                        * Otherwise, if msg is removed, but not all
> +                        * connection are dropped, this function returns
> +                        * before *remove is updated, then after all
> +                        * connections are dropped, but device->disconnec=
ts
> +                        * is NULL, remove_device is not updated. Consequ=
ently
> +                        * *remove is not set to true. The device is not =
removed
> +                        * for adapter in adapter_remove_connection. Need
> +                        * to wait for temporary device timeout to remove
> +                        * the device.
> +                        */

I mean as git description, anyway Im having second thoughts about this
change, see below.

> +                       if (device->bredr_state.connected ||
> +                                       device->le_state.connected)
> +                               break;
>                         remove_device =3D true;
> +               }
>
>                 g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
>                 device->disconnects =3D g_slist_remove(device->disconnect=
s, msg);

How we move the block checking for disconnect message after check all
bearers have been disconnected:

diff --git a/src/device.c b/src/device.c
index f8f61e64376c..76d2c859c747 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3488,18 +3488,6 @@ void device_remove_connection(struct btd_device
*device, uint8_t bdaddr_type,
                device->connect =3D NULL;
        }

-       while (device->disconnects) {
-               DBusMessage *msg =3D device->disconnects->data;
-
-               if (dbus_message_is_method_call(msg, ADAPTER_INTERFACE,
-                                                               "RemoveDevi=
ce"))
-                       remove_device =3D true;
-
-               g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
-               device->disconnects =3D g_slist_remove(device->disconnects,=
 msg);
-               dbus_message_unref(msg);
-       }
-
        /* Check paired status of both bearers since it's possible to be
        /* Check paired status of both bearers since it's possible to be
        /* Check paired status of both bearers since it's possible to be
         * paired but not connected via link key to LTK conversion.
         */
@@ -3539,6 +3527,18 @@ void device_remove_connection(struct btd_device
*device, uint8_t bdaddr_type,
        g_dbus_emit_property_changed(dbus_conn, device->path,
                                                DEVICE_INTERFACE, "Connecte=
d");

+       while (device->disconnects) {
+               DBusMessage *msg =3D device->disconnects->data;
+
+               if (dbus_message_is_method_call(msg, ADAPTER_INTERFACE,
+                                                               "RemoveDevi=
ce"))
+                       remove_device =3D true;
+
+               g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
+               device->disconnects =3D g_slist_remove(device->disconnects,=
 msg);
+               dbus_message_unref(msg);
+       }
+
        if (remove_device)
                *remove =3D remove_device;


> --
> 2.25.1
>
>


--=20
Luiz Augusto von Dentz
