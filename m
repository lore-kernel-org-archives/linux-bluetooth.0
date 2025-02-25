Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBD31624CD
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740521420; cv=none; b=lMd8kdfbiDFUQTvMhbe5FrfjhDt9cK2tik5ltIaSxerAP5iOGxlSSCNqCqO5EA8vKZ7SoWB5p9/MkR09LzHzVSqHTwO7XrsT+ihRfxWuL9PqsceBaOgfYrZMWttBZjuE90kLsZR20R825sUoKlDLClRIVb7z8KDhp7bm800Mx88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740521420; c=relaxed/simple;
	bh=rXLbvB8A5moayIRtVoYcL3ovZHWTRNX7MGd/DIGlWfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0KtFhiw63nMaJbqBWLP/YllIjCfAudDdinJ5VwaQ1+lYulGT8lp2hZbI66bpRSLI+yJfKp7c6NV7Nmp7WDphLqvz/47bYu6WAoI6PliEwQulfUwtKlNJJU3lKkcB6DhnZ/5GafRjIMUOD0UFdTDdBQO4XB2nJnsDbTnT6p6WFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtJGo2SR; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtJGo2SR"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-307bc125e2eso57143861fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 14:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740521416; x=1741126216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNcHpE9sEOKfq0skuAJp/uTci+3i4M66dnDDdbiYtRw=;
        b=RtJGo2SRLIbYK+FIPgLCqOubV8Pxn4/kSIg1+oHfaKh6wG3+s/xKpOiulw8sBWqu6k
         +WuXjcgrfS3u6D0j5SoReR13H7p6hU6P7W2oNCJfmpAsKoQJ4/rrG4ONLaBw6Qq8qZRx
         DDZGo5AuTgmqJ95Yp+wSR5Wu/OMGZ5Nm0IFBz/+WiXFHuMQX8OxJCAU/1AsAzW2Z3yfq
         bzHQmv202MLb5+FavonJFw246CW5IXhPmVAkaqRB3O2uvAJwHN+KTusb24AWyeR+yxVQ
         E+0Mi94VNgoeJO3MJm0DnYltJQjpXtJenUDglYRzao1VTA29UVtDTk9ANEjlFe6G/zqi
         DbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740521416; x=1741126216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNcHpE9sEOKfq0skuAJp/uTci+3i4M66dnDDdbiYtRw=;
        b=R/IcbNcnPNJ9R6lWYVw+Km3DCqrZFmHDsNJjbQ1U02kA8NTGO7ePZSJYNHiI6+nll9
         M7NvCe6CecUBiYuSIqZ3GBXq2usmnugBYaObQiBkVKZFVoUGM2r9TQBF8G2friam4Enk
         66txlOebSTTuZPteTnZhbwXr+1IQ4fHrzMwrZTDDGO4r9N194KYG18hYjXwzjwuBNOPs
         mvBc1Wpsd068D5Pg/LuloVgyipwsvtgKSYNaV35ssDFJML5Vz38hoNQqNqGrtCB/OWv6
         vnkYApz1eSLCAyniAUuHq4gw9brdfl+jIF1z+gjczslOtjxj1tpN+gumWHweLZbkFxOM
         LJAw==
X-Gm-Message-State: AOJu0YxJJXVbkBZ2bU39L5PQEAV6Wxg7d5txrX4tlTFLqIJV0a+e1gva
	HLYo56rxJQPbb8eVtFzjN5yErJ+YuiSWZGajvnv3zkP4Qjpt8gMBIjIE/0DsQjCZz5lIian83vq
	7qXd8Lzs/PXUaOJt6JSHcYIlQRs+2nMWDBW0=
X-Gm-Gg: ASbGnctesaE5LDjnpA5j5nxULXIXXRuJMhult3h+dQ2qxJqFzf8Ia0Kj6xVY68eYb5m
	EH+kH91Wc8goK+sAObGh/zo3zX6NgAlWIiQzSV5nwmgt8b8X13dQrwYe3VPt2tczbF3TGlX/zh8
	SJdCX8Kg==
X-Google-Smtp-Source: AGHT+IF2dM3kqSZW0wHrNbgwlUV1d+Mb1kRZU6o43jmngcPow4sbgy8NGOqqGwTDdMUT8+LvaK0jnZVwu/V2wbK0Qo4=
X-Received: by 2002:a2e:914f:0:b0:307:e0c3:5293 with SMTP id
 38308e7fff4ca-30a80cb7d1dmr27853491fa.36.1740521415556; Tue, 25 Feb 2025
 14:10:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225220059.2821394-1-luiz.dentz@gmail.com> <20250225220059.2821394-3-luiz.dentz@gmail.com>
In-Reply-To: <20250225220059.2821394-3-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 25 Feb 2025 17:10:01 -0500
X-Gm-Features: AQ5f1Jq8Miz_Aixriz-294g7x5mqZG6WGmHzHI7g_k_y61-OJ4gfpVz2aBqpKrE
Message-ID: <CABBYNZ+32tuRH+T7M=1aeDJJOqHz9qt4ThsuMF4sVpiEeC380A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 3/3] client: Add support get/set PreferredBearer
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>, Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli, Bastien,

On Tue, Feb 25, 2025 at 5:01=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds support for PreferredBearer which is printed with the likes of
> info command:
>
> bluetoothctl> info <addr>
> ...
>         PreferredBearer: last-seen
>
> It also introduces a new command to get/set the PreferredBearer:
>
> [bluetoothctl]> bearer --help
> Get/Set preferred bearer
> Usage:
>          bearer <dev> [last-seen/bredr/le]
>
> [bluetoothctl]> bearer <addr>
>         PreferredBearer: last-seen
> [bluetoothctl]> bearer <addr> le
> bluetoothd: @ MGMT Command: Add Device (0x0033) plen 8
>         LE Address: <addr>
>         Action: Auto-connect remote device (0x02)
> [CHG] Device <addr> PreferredBearer: le
> Changing le succeeded
> [bluetoothctl]> bearer <addr>
>         PreferredBearer: le
> [bluetoothctl]> bearer <addr> bredr
> bluetoothd: @ MGMT Command: Remove Device (0x0034) plen 7
>         LE Address: <addr>
> [CHG] Device <addr> PreferredBearer: bredr
> Changing bredr succeeded
> ---
>  client/main.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/client/main.c b/client/main.c
> index feb21a1163d2..76c9bc329c96 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -1714,6 +1714,7 @@ static void cmd_info(int argc, char *argv[])
>         print_property(proxy, "AdvertisingFlags");
>         print_property(proxy, "AdvertisingData");
>         print_property(proxy, "Sets");
> +       print_property(proxy, "PreferredBearer");
>
>         battery_proxy =3D find_proxies_by_path(battery_proxies,
>                                         g_dbus_proxy_get_path(proxy));
> @@ -2086,6 +2087,30 @@ static void cmd_wake(int argc, char *argv[])
>         return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  }
>
> +static void cmd_bearer(int argc, char *argv[])
> +{
> +       GDBusProxy *proxy;
> +       char *str;
> +
> +       proxy =3D find_device(argc, argv);
> +       if (!proxy)
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +
> +       if (argc <=3D 2) {
> +               print_property(proxy, "PreferredBearer");
> +               return;
> +       }
> +
> +       str =3D strdup(argv[2]);
> +
> +       if (g_dbus_proxy_set_property_basic(proxy, "PreferredBearer",
> +                                       DBUS_TYPE_STRING, &str,
> +                                       generic_callback, str, free))
> +               return;
> +
> +       return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +}
> +
>  static void cmd_list_attributes(int argc, char *argv[])
>  {
>         GDBusProxy *proxy;
> @@ -3247,6 +3272,8 @@ static const struct bt_shell_menu main_menu =3D {
>                                                         dev_generator },
>         { "wake",         "[dev] [on/off]",    cmd_wake, "Get/Set wake su=
pport",
>                                                         dev_generator },
> +       { "bearer",       "<dev> [last-seen/bredr/le]", cmd_bearer,
> +                               "Get/Set preferred bearer", dev_generator=
 },
>         { } },
>  };
>
> --
> 2.48.1

So I went ahead and implemented the idea of having PreferredBearer,
this works great when setting bredr it really stops from connecting to
LE, the said the other way around when setting to le seems to confuse
some headsets like EarFun and it ends up connecting both bearers:

[EarFun Air Pro 3]> transport.show
Transport /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0/fd1
    UUID: Sink PAC                  (00002bc9-0000-1000-8000-00805f9b34fb)
    Codec: 0x06 (6)
    Configuration.#0: len 0x02 type 0x01
    Configuration.Sampling Frequency: 16 Khz (0x03)
    Configuration.#1: len 0x02 type 0x02
    Configuration.Frame Duration: 7.5 ms (0x00)
    Configuration.#2: len 0x05 type 0x03
    Configuration.Location: 0x00000001
    Configuration.Location: Front Left (0x00000001)
    Configuration.#3: len 0x03 type 0x04
    Configuration.Frame Length: 30 (0x001e)
    Configuration.#4: len 0x02 type 0x05
    Configuration.Frame Blocks per SDU: 1 (0x01)
    Device: /org/bluez/hci0/dev_70_5A_6F_63_B6_41
    State: idle
    Volume: 0x00c8 (200)
    Endpoint: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0
    QoS.CIG: 0x00 (0)
    QoS.CIS: 0x00 (0)
    QoS.Framing: 0x00 (0)
    QoS.PresentationDelay: 0x00009c40 (40000)
    QoS.Interval: 0x00001d4c (7500)
    QoS.Latency: 0x0008 (8)
    QoS.SDU: 0x001e (30)
    QoS.PHY: 0x02 (2)
    QoS.Retransmissions: 0x02 (2)
    Location: 0x00000003 (3)
    Links: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0/fd3
Transport /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0/fd2
    UUID: Sink PAC                  (00002bc9-0000-1000-8000-00805f9b34fb)
    Codec: 0x06 (6)
    Configuration.#0: len 0x02 type 0x01
    Configuration.Sampling Frequency: 16 Khz (0x03)
    Configuration.#1: len 0x02 type 0x02
    Configuration.Frame Duration: 7.5 ms (0x00)
    Configuration.#2: len 0x05 type 0x03
    Configuration.Location: 0x00000002
    Configuration.Location: Front Right (0x00000002)
    Configuration.#3: len 0x03 type 0x04
    Configuration.Frame Length: 30 (0x001e)
    Configuration.#4: len 0x02 type 0x05
    Configuration.Frame Blocks per SDU: 1 (0x01)
    Device: /org/bluez/hci0/dev_70_5A_6F_63_B6_41
    State: idle
    Volume: 0x00c8 (200)
    Endpoint: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0
    QoS.CIG: 0x00 (0)
    QoS.CIS: 0x01 (1)
    QoS.Framing: 0x00 (0)
    QoS.PresentationDelay: 0x00009c40 (40000)
    QoS.Interval: 0x00001d4c (7500)
    QoS.Latency: 0x0008 (8)
    QoS.SDU: 0x001e (30)
    QoS.PHY: 0x02 (2)
    QoS.Retransmissions: 0x02 (2)
    Location: 0x00000003 (3)
    Links: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0/fd4
Transport /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0/fd3
    UUID: Source PAC                (00002bcb-0000-1000-8000-00805f9b34fb)
    Codec: 0x06 (6)
    Configuration.#0: len 0x02 type 0x01
    Configuration.Sampling Frequency: 48 Khz (0x08)
    Configuration.#1: len 0x02 type 0x02
    Configuration.Frame Duration: 7.5 ms (0x00)
    Configuration.#2: len 0x05 type 0x03
    Configuration.Location: 0x00000001
    Configuration.Location: Front Left (0x00000001)
    Configuration.#3: len 0x03 type 0x04
    Configuration.Frame Length: 90 (0x005a)
    Configuration.#4: len 0x02 type 0x05
    Configuration.Frame Blocks per SDU: 1 (0x01)
    Device: /org/bluez/hci0/dev_70_5A_6F_63_B6_41
    State: idle
    Volume: 0x00c8 (200)
    Endpoint: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0
    QoS.CIG: 0x00 (0)
    QoS.CIS: 0x00 (0)
    QoS.Framing: 0x00 (0)
    QoS.PresentationDelay: 0x00009c40 (40000)
    QoS.Interval: 0x00001d4c (7500)
    QoS.Latency: 0x000f (15)
    QoS.SDU: 0x005a (90)
    QoS.PHY: 0x02 (2)
    QoS.Retransmissions: 0x05 (5)
    Location: 0x00000003 (3)
    Links: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0/fd1
Transport /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0/fd4
    UUID: Source PAC                (00002bcb-0000-1000-8000-00805f9b34fb)
    Codec: 0x06 (6)
    Configuration.#0: len 0x02 type 0x01
    Configuration.Sampling Frequency: 48 Khz (0x08)
    Configuration.#1: len 0x02 type 0x02
    Configuration.Frame Duration: 7.5 ms (0x00)
    Configuration.#2: len 0x05 type 0x03
    Configuration.Location: 0x00000002
    Configuration.Location: Front Right (0x00000002)
    Configuration.#3: len 0x03 type 0x04
    Configuration.Frame Length: 90 (0x005a)
    Configuration.#4: len 0x02 type 0x05
    Configuration.Frame Blocks per SDU: 1 (0x01)
    Device: /org/bluez/hci0/dev_70_5A_6F_63_B6_41
    State: idle
    Volume: 0x00c8 (200)
    Endpoint: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_sink0
    QoS.CIG: 0x00 (0)
    QoS.CIS: 0x01 (1)
    QoS.Framing: 0x00 (0)
    QoS.PresentationDelay: 0x00009c40 (40000)
    QoS.Interval: 0x00001d4c (7500)
    QoS.Latency: 0x000f (15)
    QoS.SDU: 0x005a (90)
    QoS.PHY: 0x02 (2)
    QoS.Retransmissions: 0x05 (5)
    Location: 0x00000003 (3)
    Links: /org/bluez/hci0/dev_70_5A_6F_63_B6_41/pac_source0/fd2
Transport /org/bluez/hci0/dev_70_5A_6F_63_B6_41/fd5
    UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
    Codec: 0x02 (2)
    Media Codec: MPEG24
    Object Types: MPEG-4 AAC LC
    Frequencies: 48kHz
    Channels: 2
    Bitrate: 320000
    VBR: Yes
    Device: /org/bluez/hci0/dev_70_5A_6F_63_B6_41
    State: idle
    Delay: 0x0960 (2400)
    Volume: 0x0064 (100)

We might need to check if other devices have such behavior, perhaps
the headset is saving the last bearer it connected to so it tries to
restore it or something like that, this may messes up with that, in
the other hand the bearer can be selected even before first connecting
so we may decide to default to bredr instead of last seen for this
type of devices (Classic+LE Audio).

Anyway there are some pieces left that I still need to implement like
save the bearer in the storage so when the daemon is reloaded, or in
case of reboot, it restores the last mode properly.

--=20
Luiz Augusto von Dentz
