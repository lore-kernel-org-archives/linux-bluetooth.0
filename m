Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1608D1BD024
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763167; cv=none; b=XjrSifexIiUzFiYeoJgCpss/3eYh2eE+QyeCQHOBpQBPi4JV0JVdwHO+bXMkLnTWLNpTeHLIznB3SRx4oJJHi7PqtyNgkGvw/D7xGZ8RKWBC0HjPUpIT7VFQpdO9PdzeVv2qhEGKiUNV2czDPJr3tZzzMiqgEnX7UIucv85Tjrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763167; c=relaxed/simple;
	bh=7aAVk8tMWCZe4Liq6YJ4SWoHmQCx5RCy0s5bkWpLGeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/WG5bRLsStwuT8cJ1wsa4cVvmuheVGXIpxWaGyeJaVckQ7SgHi8E4m2YAepvRZ+UeyDAlTUKT/ZBtLrQ95rGJ1zbwNcsGKZchRpMLvTLWciEXaRGRPTDDtOeFN0wRrqN4NKJfJq153Ybln/hUn3ee8jmpNIKD+e1riGQcTyJs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiRcdxtE; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiRcdxtE"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f409c87b07so64446321fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 05:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724763163; x=1725367963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxUYPqT6ZPp9068Jkws9vhA6n06kwWsvls9f8P2748Y=;
        b=QiRcdxtE+Kr49MeZVSm8h5S+8TN0NMLl7N1cf0ONWkWoDdYPw6jldY7/r1i33PE4Iz
         X3187WZJ46DwK6DlY1qZDensardM3xV2UYnm+5LwzVgyhcJJr84upHVw6np5A55XUo1n
         jDZdK3QQhcFzFKKDvNuJ+HLhDW2Z54I+HthD3r56VeWQXC537gKoNvomoeORKBt0ApJd
         DUSf7Ill+JqtThmFsCqTnXDo0+UX/N4s8gje+dPiliMXuSFmTlCqtOOkFPMCQTFea9Zk
         G1J5YBpvnBUSmlIPDDKNGQfj5txqJPTBDnxwM0ohjqe4I5zKcbLHfNeMpDLIXKSESGnS
         iFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724763163; x=1725367963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxUYPqT6ZPp9068Jkws9vhA6n06kwWsvls9f8P2748Y=;
        b=PIOqOCHT6MQZwBaZrTxAnC7h4K0CY8FmiN2AKtCeGl4xl/I9AnvXvJs1pianvJA9QU
         xVAHlGaWleXIiotv3ruAPBErz6eCzXDHHYMlF19sZaLSimmnkhWVSa2dfai1PLP1w322
         2M/RgCSfVFczSa48+HBRvdHi0MMYpGElDqk+u514NCZ1TzSCmAyPsh4iJ5lsEqpZsw2c
         HU6/bxCu4YCjrqiWQtsuYrvNjCqpKzvw4I985YtuRDZMcYfxuZ+Q2AgywqgeXFrSAhH6
         /nLY+7NgBEdy8WvomiVsZZHcwDHMy+Y1hXwrLlMh/VwHuB3ZHzZjXwDn5vMwguV/wpKY
         72Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUZRl1F7Uyck3triVKof8u9G1Old8n13A2+GoKvNPrqyK6o0gW1ok3na8+PgOpK93MZcZf/0b9+ZIilIcyXhLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxufeddwK/5hUuy5ff9WUs6IH34J1UMlDbeb3lU/7FUvF5Cl3hz
	nl70l/VqgNO/PFDpRKX9udQbgdj+nfuTp9yeJ9sfMIBwCVIBPXtR0iOzkwVWSMiC18DapqXynFI
	9IoxNKxtvuyJIQq10xwonJitMF7s=
X-Google-Smtp-Source: AGHT+IEhjfld5ga1Ez9I2Lb29PwCC3Nr/lJ4mJvYCYwCDicodhiAW1hD694I94bFGpGe3OAjYlB6y1mcl5XKOsiGeUs=
X-Received: by 2002:a2e:bc08:0:b0:2ef:243b:6dca with SMTP id
 38308e7fff4ca-2f4f48d6069mr94635911fa.10.1724763162107; Tue, 27 Aug 2024
 05:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211162729.1183207-1-xiaokeqinhealth@126.com>
 <55903fdb-e970-4b89-b620-daa93bad7811@archlinux.org> <CABBYNZ+X1gWovfui7Vyaag80PFz_1q4A_F7r=wpgF_gm9f9orA@mail.gmail.com>
 <e4be48f5-1139-4871-a229-8dae7a7d745f@126.com>
In-Reply-To: <e4be48f5-1139-4871-a229-8dae7a7d745f@126.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 27 Aug 2024 08:52:29 -0400
Message-ID: <CABBYNZK6qYdvAkKJDTfgxOxC2+qBxRriaprH3ooxV0jRMsf8fQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] adapter: Fix addr_type for smp_irk/ltk_info/link_key
To: Yao Xiao <xiaokeqinhealth@126.com>
Cc: Robin Candau <antiz@archlinux.org>, quic_chejiang@quicinc.com, 
	linux-bluetooth@vger.kernel.org, Xiao Yao <xiaoyao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 27, 2024 at 3:41=E2=80=AFAM Yao Xiao <xiaokeqinhealth@126.com> =
wrote:
>
> Hi luiz,
> The kernel should always report the correct address type for all kinds
> of keys. Older kernels ignore the derivation of keys, which prevents the
> user layer from knowing the correct address type. This can cause a lot
> of confusion for users. For example, when a user connects to a
> traditional Bluetooth audio device, due to the default activation of key
> derivation, bluetoothd reports both BREDR and BLE pairing and binding,
> and the address is updated to LE public. When the user actively calls
> the Connect method of org.bluez.Device1 to reconnect, sometimes the
> address type is set to LE public, leading to a failed connection, and
> vice versa.

The correct address type can only be the ones listed on mgmt-api
otherwise we are breaking APIs, also except if there are some new case
I don't know and Load Keys and Load LTK are bearer specific.

> We should enable bluetoothd to know the reason for the generation of
> keys as much as possible. Older kernels always assume the address type
> of linkey is BREDR, and ltk/irk/csrk are LE public. Therefore, we can
> use this as a basis for judgment, allowing bluetoothd to handle various
> issues, such as reloading keys and handling unpaired devices. Below is a
> pseudo-code that is not running in practice but just a thought. Please
> help review it.

Yeah, and what exactly was wrong with that? What you mention about
having keys for both BR/EDR and LE public is not an issue, that
basically the very definition of a dual-mode device and bluetoothd
shall be able to tell when to connect to BR/EDR and LE public, if it
doesn't we shall fix that and not start breaking APIs.

> -------------------------------------------
> diff --git a/src/adapter.c b/src/adapter.c
> index 85ddfc165..babe7c9b2 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -4958,6 +4958,7 @@ static void load_devices(struct btd_adapter *adapte=
r)
>           struct irk_info *irk_info;
>           struct conn_param *param;
>           uint8_t bdaddr_type;
> +        bool derived_key;
>
>           if (entry->d_type =3D=3D DT_UNKNOWN)
>               entry->d_type =3D util_get_dt(dirname, entry->d_name);
> @@ -4976,10 +4977,21 @@ static void load_devices(struct btd_adapter
> *adapter)
>               g_clear_error(&gerr);
>           }
>
> +        derived_key =3D g_key_file_get_boolean(key_file, "General",
> +                                "DerivedKey", NULL);
> +
> +        /* For link key */
>           bdaddr_type =3D get_addr_type(key_file);
> +        if (!derived_key)
> +            bdaddr_type =3D BDADDR_BREDR;
>
>           key_info =3D get_key_info(key_file, entry->d_name, bdaddr_type)=
;
>
> +        /* For ltk/irk/csrk */
> +        bdaddr_type =3D get_addr_type(key_file);
> +        if (!derived_key)
> +            bdaddr_type =3D BDADDR_LE_PUBLIC;
> +
>           ltk_info =3D get_ltk_info(key_file, entry->d_name, bdaddr_type)=
;
>
>           peripheral_ltk_info =3D get_peripheral_ltk_info(key_file,
> @@ -8673,6 +8685,12 @@ static void new_link_key_callback(uint16_t index,
> uint16_t length,
>           return;
>       }
>
> +    /*
> +     * For older kernels, the address type is always BREDR.
> +     */
> +    if (addr->type =3D=3D BDADDR_LE_PUBLIC)
> +        device->derived_key =3D true;
> +
>       if (ev->store_hint) {
>           const struct mgmt_link_key_info *key =3D &ev->key;
>
> @@ -8791,6 +8809,12 @@ static void new_long_term_key_callback(uint16_t
> index, uint16_t length,
>           return;
>       }
>
> +    /*
> +     * For older kernels, the address type is always BDADDR_LE_PUBLIC.
> +     */
> +    if (addr->type =3D=3D BDADDR_BREDR)
> +        device->derived_key =3D true;
> +
>       /*
>        * Some older kernel versions set store_hint for long term keys
>        * from resolvable and unresolvable random addresses, but there
> @@ -8855,6 +8879,9 @@ static void new_csrk_callback(uint16_t index,
> uint16_t length,
>           return;
>       }
>
> +    if (addr->type =3D=3D BDADDR_BREDR)
> +        device->derived_key =3D true;
> +
>       device_set_csrk(device, key->val, 0, key->type, ev->store_hint);
>   }
>
> @@ -8941,6 +8968,9 @@ static void new_irk_callback(uint16_t index,
> uint16_t length,
>           return;
>       }
>
> +    if (addr->type =3D=3D BDADDR_BREDR)
> +        device->derived_key =3D true;
> +
>       device_update_addr(device, &addr->bdaddr, addr->type);
>
>       if (duplicate)
> diff --git a/src/device.c b/src/device.c
> index a1dc0750c..062b9c49d 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -272,6 +272,7 @@ struct btd_device {
>       struct csrk_info *remote_csrk;
>       struct ltk_info *ltk;
>       struct queue    *sirks;
> +    bool        derived_key;            /* key is derived. */
>
>       sdp_list_t    *tmp_records;
>
> @@ -482,6 +483,9 @@ static gboolean store_device_info_cb(gpointer user_da=
ta)
>       g_key_file_set_boolean(key_file, "General", "Blocked",
>                               device->blocked);
>
> +    g_key_file_set_boolean(key_file, "General", "DerivedKey",
> +                            device->derived_key);
> +
>       if (device->wake_override !=3D WAKE_FLAG_DEFAULT) {
>           g_key_file_set_boolean(key_file, "General", "WakeAllowed",
>                          device->wake_override =3D=3D
> @@ -1829,7 +1833,11 @@ static void bonding_request_cancel(struct
> bonding_req *bonding)
>       struct btd_device *device =3D bonding->device;
>       struct btd_adapter *adapter =3D device->adapter;
>
> -    adapter_cancel_bonding(adapter, &device->bdaddr, device->bdaddr_type=
);
> +    if (device->derived_key) {
> +        adapter_cancel_bonding(adapter, &device->bdaddr, BDADDR_BREDR);
> +        adapter_cancel_bonding(adapter, &device->bdaddr, BDADDR_LE_PUBLI=
C);
> +    } else
> +        adapter_cancel_bonding(adapter, &device->bdaddr,
> device->bdaddr_type);
>   }
>
>   static void dev_disconn_service(gpointer a, gpointer b)
> @@ -3196,12 +3204,19 @@ static DBusMessage
> *cancel_pairing(DBusConnection *conn, DBusMessage *msg,
>   {
>       struct btd_device *device =3D data;
>       struct bonding_req *req =3D device->bonding;
> +    uint8_t bdaddr_type;
>
>       DBG("");
>
>       if (!req) {
> -        btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
> -                        device->bdaddr_type);
> +        if (device->derived_key) {
> +            btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
> +                            BDADDR_BREDR);
> +            btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
> +                            BDADDR_LE_PUBLIC);
> +        } else
> +            btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
> +                            device->bdaddr_type);
>           return btd_error_does_not_exist(msg);
>       }
>
> @@ -3833,6 +3848,9 @@ next:
>           gerr =3D NULL;
>       }
>
> +    device->derived_key =3D g_key_file_get_boolean(key_file, "General",
> +                            "DerivedKey", NULL);
> +
>       if (store_needed)
>           store_device_info(device);
>   }
>
> On 2024/8/27 5:12, Luiz Augusto von Dentz wrote:
> > Hi Xiao,
> >
> > On Fri, Dec 15, 2023 at 8:06=E2=80=AFPM Robin Candau <antiz@archlinux.o=
rg> wrote:
> >>
> >> On 12/11/23 17:27, Xiao Yao wrote:
> >>
> >> From: Xiao Yao <xiaoyao@rock-chips.com>
> >>
> >> According to BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 3,
> >> Part H, 2.4.24/2.4.25, The LE LTK and BR/EDR link keys can be
> >> converted between each other, so the addr type can be either
> >> BREDR or LE, so fix it.
> >>
> >> Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
> >> ---
> >>   src/adapter.c | 20 ++++++++++++++------
> >>   1 file changed, 14 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/src/adapter.c b/src/adapter.c
> >> index 86fff72bc..ee70b00d2 100644
> >> --- a/src/adapter.c
> >> +++ b/src/adapter.c
> >> @@ -170,6 +170,7 @@ static GSList *conn_fail_list =3D NULL;
> >>
> >>   struct link_key_info {
> >>    bdaddr_t bdaddr;
> >> + uint8_t bdaddr_type;
> >>    unsigned char key[16];
> >>    uint8_t type;
> >>    uint8_t pin_len;
> >> @@ -3964,7 +3965,9 @@ static bool is_blocked_key(uint8_t key_type, uin=
t8_t *key_value)
> >>    return false;
> >>   }
> >>
> >> -static struct link_key_info *get_key_info(GKeyFile *key_file, const c=
har *peer)
> >> +static struct link_key_info *get_key_info(GKeyFile *key_file, const c=
har *peer,
> >> + uint8_t bdaddr_type)
> >> +
> >>   {
> >>    struct link_key_info *info =3D NULL;
> >>    char *str;
> >> @@ -3976,6 +3979,7 @@ static struct link_key_info *get_key_info(GKeyFi=
le *key_file, const char *peer)
> >>    info =3D g_new0(struct link_key_info, 1);
> >>
> >>    str2ba(peer, &info->bdaddr);
> >> + info->bdaddr_type =3D bdaddr_type;
> >>
> >>    if (!strncmp(str, "0x", 2))
> >>    str2buf(&str[2], info->key, sizeof(info->key));
> >> @@ -4343,7 +4347,7 @@ static void load_link_keys(struct btd_adapter *a=
dapter, GSList *keys,
> >>    struct link_key_info *info =3D l->data;
> >>
> >>    bacpy(&key->addr.bdaddr, &info->bdaddr);
> >> - key->addr.type =3D BDADDR_BREDR;
> >> + key->addr.type =3D info->bdaddr_type;
> >>    key->type =3D info->type;
> >>    memcpy(key->val, info->key, 16);
> >>    key->pin_len =3D info->pin_len;
> >> @@ -4598,14 +4602,18 @@ static void load_conn_params(struct btd_adapte=
r *adapter, GSList *params)
> >>    btd_error(adapter->dev_id, "Load connection parameters failed");
> >>   }
> >>
> >> -static uint8_t get_le_addr_type(GKeyFile *keyfile)
> >> +static uint8_t get_addr_type(GKeyFile *keyfile)
> >>   {
> >>    uint8_t addr_type;
> >>    char *type;
> >>
> >> + /* The AddressType is written to file only When dev->le is
> >> + * set to true, as referenced in the update_technologies().
> >> + * Therefore, When type is NULL, it default to BDADDR_BREDR.
> >> + */
> >>    type =3D g_key_file_get_string(keyfile, "General", "AddressType", N=
ULL);
> >>    if (!type)
> >> - return BDADDR_LE_PUBLIC;
> >> + return BDADDR_BREDR;
> >>
> >>    if (g_str_equal(type, "public"))
> >>    addr_type =3D BDADDR_LE_PUBLIC;
> >> @@ -4914,9 +4922,9 @@ static void load_devices(struct btd_adapter *ada=
pter)
> >>    g_clear_error(&gerr);
> >>    }
> >>
> >> - key_info =3D get_key_info(key_file, entry->d_name);
> >> + bdaddr_type =3D get_addr_type(key_file);
> >>
> >> - bdaddr_type =3D get_le_addr_type(key_file);
> >> + key_info =3D get_key_info(key_file, entry->d_name, bdaddr_type);
> >>
> >>    ltk_info =3D get_ltk_info(key_file, entry->d_name, bdaddr_type);
> >>
> >>
> >> Hello,
> >>
> >> It seems like the above commit introduced a regression where the initi=
al auto-connect for Bluetooth devices doesn't work anymore.
> >>
> >> Indeed, at system startup, starting a Bluetooth device will cause it t=
o go in a "connected/disconnected" state loop, requiring to initialize a ma=
nual connection first (with sometimes multiple attempts needed) before gett=
ing it connected correctly and working as intended.
> >>
> >> `systemctl status bluetooth` reports the following error:
> >>
> >> [...]
> >> d=C3=A9c. 15 11:03:18 Arch-Desktop bluetoothd[592]: Failed to load lin=
k keys for hci0: Invalid Parameters (0x0d)
> >> [...]
> >>
> >> I bisected the bug with `git bisect` and it pointed out this commit [1=
] as the "faulty" one.
> >> I can confirm that reverting it solves the issue.
> >>
> >> I reported this bug including details in the GitHub repo [2].
> >>
> >> I remain available if any additional information are needed.
> >>
> >> [1] https://github.com/bluez/bluez/commit/d5536e0cd431e22be9a1132be6d4=
af2445590633
> >> [2] https://github.com/bluez/bluez/issues/686
> >>
> >> --
> >> Regards,
> >> Robin Candau / Antiz
> >
> > Perhaps related to:
> > https://github.com/bluez/bluez/issues/875#issuecomment-2311100872?
>


--=20
Luiz Augusto von Dentz
