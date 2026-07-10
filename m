Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1978D32AAC5
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692796; cv=pass; b=eRLf8SSO1NVMYZyUvOtw+zdngn0E6S0KCdYy0U+FLOaRUL+dcAV4eZnsIbxt5oLeK8Hg5tFihTMoXRbRyWynn4HmtYT7sgqMr0ezNu/4GemelGufLRLmvXmrLY1uWYW36qkW4agsemJfQ+NQyZwTYo0ZGtjfMerBBzm+vDy2MEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692796; c=relaxed/simple;
	bh=HtuOTcMuv28AG4TC5qIlHyGf/HgRKhcxW0N1gr8M+EI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sahtv3P2aA5UOdrDy9cnuVt3z3g/yuqbHyHR9ABE72TDyjY1E1UbT0T44HZ8LlCAy6mGSBD4BeJwqH03ybpnSk3U4rn9qwN4HLjOTZJPCvZ2ZpT7nuI+27t/i37ToTH+1i6yS3YlsKy6YL+Y3ph8F4m7Yb4c3A8nj4AhIEEOtUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPkF1pc6; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPkF1pc6"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-667a0f55a59so1410008d50.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 07:13:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783692794; cv=none;
        d=google.com; s=arc-20260327;
        b=oMztSmkkMWzSv0m/cHD/H9XDlUcOpjBOSdh2T1r/tZHeGizDAh9veXUH4eQm0fe/fi
         OJyz7F3una+xIPr9VFlN1C/C0jgLNGGqk8G4N++jR6FGBs6jH5BV2trrLQZWkwHcLum/
         2+VYGLodRoaHpJVDiM2ZdhRDgLzizIXB6HkKi/PQo8XkVFQImBLcpgAoOggMIBWGDZQC
         RwKO6gZQFYjCBq7ggKQVHP3YNH4Ck0VCJufTAFDO9fxCos06+jnE0pMlFbTxbM/+09yp
         bYogRN9rencfzi4r4GY4vG3SEGXigrRERcVcLoG5GFej3r+8wMxTVZg3MZY2P7wfOWJx
         DBSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OE6Zf/Uv878MLjyBZ5h8gJ9XY0REbTQDyuLB9+x5TUU=;
        fh=EeG1bk4C1pw+aWiACZPZxYh8LCQD//WkbHEtgMrFToE=;
        b=ekH30ThhrApIQkqC6PPaC9jOllbEh3l/boBIpmpWPjwdRupBthwljNAktoORSuGyQu
         uv808OaTvMLSLCSsg2Uo8aaPG8SI7z6NhAK5RZqjA9WZoMCmIvi/sn++14PgRfM5PexY
         i9TKsIhYBUbQzfalG7QYHwFzbYQGR9ERBS2HfKxpc0Z28RIkD/ZMDURRa7415wRU52M5
         huRkOuycmPeYZb4sKoHX+VNUG92Epvnc+EZg34h1P2/uRPbw8EhkmVfVNd4jFKSIke7L
         YqoMeF6De8eFhdq4DIE7yCz7h4s9MxP+pcTwJ/Q3jhFZubGsFU5A/o+lxyJEPxhbLMc0
         dc4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692794; x=1784297594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OE6Zf/Uv878MLjyBZ5h8gJ9XY0REbTQDyuLB9+x5TUU=;
        b=BPkF1pc6Gf8W+HH+J5reFeqTT6sBGA5S8lRpjfe3tcZ7h4+4nM2jnw02RqdrEXU4rc
         JPeniM5H0GTL2I4y29ewW9fT1b/qqOuFyI9/r6ujfaidB+cA/JgrU2FXX+yxgYqCKyVD
         0hQP0qrQ+B7eGlZM37dQidpZu/QZ4pz04OKO60JZZVE+0mkqHgZb27AK49o5BREoSG7o
         xrLZqWYRBFgy1GgjzJ9dBOVCGHQyEJoLJekHIzZrhmW0n+2+ISCdEcKzZ3+dHMKlqd71
         /26EgfdzKpvb9s2dTPueR/AmOQDD5kp6GY8QE9Fml7/i3+siEm9NcSjdTsgsAYkrJK4m
         MyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692794; x=1784297594;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OE6Zf/Uv878MLjyBZ5h8gJ9XY0REbTQDyuLB9+x5TUU=;
        b=kVKkVvTfa6FWixtR1vJyyRVxEaJHnQRuH5QiTDhDsr1j/WP4m8f7i/nJCjfrItYGTP
         KBB5xbUZ0ptqJbGDgCEIKwC/IqbHVK1EJwwBJ7pJHaRg6ZUNynHON1mldyopbF0/NAT7
         MlN9f9nfgPxZOaFGXdOvk26C22vNOQYEq4jKOZzZBKrpnpUT9hGauJqrHDsR58RRqxw0
         QUi8lFkHHgYptc21QAhzb39kbz0iBoj72jwZ5YQx1RpDUbbXtgFt3dZ4DPR4c21P8K9s
         SYZVdxNhrZ/MzHsywHS6TOne2FzIU6ZD17j+vV5CCPyDX7X7pQ7i8u/2B2vSLv80GhGM
         Nm+g==
X-Forwarded-Encrypted: i=1; AHgh+RqBD77ZTy4ucQ0Ei7MFD82s9aMFcviKYZTQqHcBj50oIGNi6eAupXvjNa2k52kd9zp9CFcruGeE3XRWGdDgxw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBaqC21N1lmM8AduJKrliHSfehsNMcgImUWJB6i+ZkiBJEaKcF
	7v8UEuC2aYs9l/uhneWAV0D6vJCmVUf28YheIu0J6B/mnoND7RBPwBWO/N7b08FHMWuZlxmJsBo
	9VF1nsPis0LQ/XpDzirQ76A20Lph1YTI=
X-Gm-Gg: AfdE7cmcQFp8vB1h7S1nf1lbkdZp9CkzqqvQUhUrPy4zxAuAjpk74lA3SEZ/MrmYZFY
	+jIlOtY1ja1V8LzRuHZFKAGjr8Lfj9tzm5W4jRvMrS5O7VWzUvhxr4qCrtiBMfJuGLTskefWQDt
	vDGniimj/nS30MeiW3Hv1ha7AV/pGUmQ1cZVK0ayraGIL1BxblXS1jViHO1qH2ER0LADZIcL4OV
	WcYthdjcAE+pJD2A9mwWkEyjkM8YUp0CgRBRqxyC6Knm1htQtxj/7lr8g95x2WHmc3eHcY1H218
	rrG9GC6Qk2DTmOWAIbIANVjPYNQM0WUNCE7SMU30MnQEiZa/TSBcfPnLAns=
X-Received: by 2002:a05:690e:dc8:b0:664:d71f:4e90 with SMTP id
 956f58d0204a3-6679ed15910mr8999133d50.0.1783692789313; Fri, 10 Jul 2026
 07:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710075548.1072741-1-xiuzhuo.shang@oss.qualcomm.com>
In-Reply-To: <20260710075548.1072741-1-xiuzhuo.shang@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 10 Jul 2026 10:12:54 -0400
X-Gm-Features: AVVi8Ce5oos0eLuIbcU6B1h4zsKYBSdeBo7S6297Ayu89yGHQYwoYByGE3YXZ_0
Message-ID: <CABBYNZJrrQO5XU1yC-HOry1eEaF8fBKV_jK4g3A+qJTAtw0Qqg@mail.gmail.com>
Subject: Re: [PATCH v1] gdbus: Skip BLE random-address devices and remove
 broad match rule
To: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
Cc: denkenz@gmail.com, ofono@lists.linux.dev, linux-bluetooth@vger.kernel.org, 
	cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com, 
	wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com, 
	mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xiuzhuo,

On Fri, Jul 10, 2026 at 3:55=E2=80=AFAM Xiuzhuo Shang
<xiuzhuo.shang@oss.qualcomm.com> wrote:
>
> Two related changes to reduce dbus-daemon load caused by high-rate
> BLE advertising signals:
>
> 1. In parse_properties(), skip creating a GDBusProxy for Device1
>    objects whose AddressType is 'random' (BLE-only devices). Each
>    proxy registers a per-device PropertiesChanged watch via
>    g_dbus_add_properties_watch(); with hundreds of BLE peripherals
>    advertising simultaneously, this results in hundreds of match rules
>    and dbus-daemon routing thousands of RSSI PropertiesChanged signals
>    per second to ofono, none of which ofono processes. The
>    AddressType property is available in the InterfacesAdded dict at
>    the time parse_properties() is called, so the check is reliable
>    and race-free.
>
>    BR/EDR devices (AddressType=3D'public') are unaffected: their proxies
>    are created as before, and the property_changed callback continues
>    to receive Paired and ServicesResolved updates needed for HFP/HSP.
>
> 2. In g_dbus_client_new_full(), remove the broad
>    type=3D'signal',sender=3D<service>,path_namespace=3D<path> match rule.
>    This rule was the sole feeder for the signal_func path in
>    message_filter(). ofono never calls g_dbus_client_set_signal_watch()
>    so signal_func is always NULL; the broad rule therefore served no
>    purpose and caused dbus-daemon to route every bluetoothd signal
>    (including all BLE PropertiesChanged) to ofono.
>
>    InterfacesAdded and InterfacesRemoved are already covered by the
>    precise watches registered via g_dbus_add_signal_watch() earlier in
>    g_dbus_client_new_full(), so no functionality is lost.

Looks like this is on ofono though, why are you chaning the BlueZ side?

> Together these two changes prevent dbus-daemon from routing BLE
> advertising PropertiesChanged signals to ofono entirely, eliminating
> the dbus-daemon memory growth and bluetoothd socket backpressure seen
> after hours of BLE scanning.
>
> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
> ---
>  gdbus/client.c | 46 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 38 insertions(+), 8 deletions(-)
>
> diff --git a/gdbus/client.c b/gdbus/client.c
> index 48711ae8..dd3c17f9 100644
> --- a/gdbus/client.c
> +++ b/gdbus/client.c
> @@ -937,6 +937,44 @@ static void parse_properties(GDBusClient *client, co=
nst char *path,
>         if (g_str_equal(interface, DBUS_INTERFACE_PROPERTIES) =3D=3D TRUE=
)
>                 return;
>
> +       /*
> +        * Skip BLE devices (AddressType=3D'random') to avoid registering=
 a
> +        * per-device PropertiesChanged watch for every advertising BLE
> +        * peripheral. ofono only needs BR/EDR devices for HFP/HSP; the
> +        * high-rate RSSI PropertiesChanged signals from BLE scanners cau=
se
> +        * dbus-daemon memory bloat and socket backpressure in bluetoothd=
.
> +        *
> +        * The AddressType property is present in the InterfacesAdded dic=
t
> +        * (iter) at this point, so it can be checked before proxy_new().
> +        */
> +       if (g_str_equal(interface, "org.bluez.Device1") =3D=3D TRUE) {
> +               DBusMessageIter props, entry;
> +               DBusMessageIter copy =3D *iter;
> +
> +               if (dbus_message_iter_get_arg_type(&copy) =3D=3D DBUS_TYP=
E_ARRAY) {
> +                       dbus_message_iter_recurse(&copy, &props);
> +                       while (dbus_message_iter_get_arg_type(&props) =3D=
=3D
> +                                               DBUS_TYPE_DICT_ENTRY) {
> +                               const char *key;
> +                               dbus_message_iter_recurse(&props, &entry)=
;
> +                               dbus_message_iter_get_basic(&entry, &key)=
;
> +                               if (g_str_equal(key, "AddressType") =3D=
=3D TRUE) {
> +                                       DBusMessageIter var;
> +                                       const char *addr_type;
> +                                       dbus_message_iter_next(&entry);
> +                                       dbus_message_iter_recurse(&entry,=
 &var);
> +                                       dbus_message_iter_get_basic(&var,
> +                                                               &addr_typ=
e);
> +                                       if (g_str_equal(addr_type,
> +                                                       "random") =3D=3D =
TRUE)
> +                                               return;
> +                                       break;
> +                               }
> +                               dbus_message_iter_next(&props);
> +                       }
> +               }
> +       }

Nack, not going to introduce BlueZ specific logic into gdbus like
this. If we need to rate limit the RSSI notification then it means
it's not suitable to be a property, but I believe we have a threshold
logic in the likes of device_set_rssi_with_delta so perhaps we shall
check why it is not working in your case.

>         proxy =3D proxy_lookup(client, path, interface);
>         if (proxy) {
>                 update_properties(proxy, iter, FALSE);
> @@ -1255,14 +1293,6 @@ GDBusClient *g_dbus_client_new_full(DBusConnection=
 *connection,
>                                                 "InterfacesRemoved",
>                                                 interfaces_removed,
>                                                 client, NULL);
> -       g_ptr_array_add(client->match_rules, g_strdup_printf("type=3D'sig=
nal',"
> -                               "sender=3D'%s',path_namespace=3D'%s'",
> -                               client->service_name, client->base_path))=
;
> -
> -       for (i =3D 0; i < client->match_rules->len; i++) {
> -               modify_match(client->dbus_conn, "AddMatch",
> -                               g_ptr_array_index(client->match_rules, i)=
);
> -       }

This perhaps has a merit, but I can't recall what this watch was for.
Is it matching every signal from the sender? It seems it was introduce
before the watch infra existed, so if we can safely remove it we can
perhaps remove the whole client-->match_rules.

>         return g_dbus_client_ref(client);
>  }
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
