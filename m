Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB2F3E0C47
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843234; cv=pass; b=EKHwZrH75QZdcqpLtLebrFFZ2/TiWYYtNLcwkmY8bSKwfUpUlexrCeeHjLrdGjOufLrUgPAhaZeeSAmQ84zGkUXpbbSX1/kONpMM0fUokJW7sFcp1v7IYT1Qhlap8brhE+apWnwRPBNTa2MdMPq6C4Cityg7ckmQ2y80lXBhIss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843234; c=relaxed/simple;
	bh=UGbYlaQgwW18fu7kYLjI0Kp48R62rEIrckmBTnB7rAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BE892bmBlNerJj1bZoD3vmVVcfOxLHGOJwNTB8NDJool6hWL7BiSrvXNwLL5woOxowgMgvYkDIocwZejDHsEzhK+Prm5ki9tCr1PXlMLazPVRLXwj1bKrHr+yga5Wkrz66ck/qtuMV7Pyqv4DQ67fGE67NzjbTxmB5aM4FOHGAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPhSxSH9; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPhSxSH9"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-495ee8e807aso579084b6e.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 11:13:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782843231; cv=none;
        d=google.com; s=arc-20260327;
        b=DBW4HPI1z7ikTdCiuKck7pCHgu363dprq5ZoRVwQGDN4QMduuO6g+Tmw8vl7SrqjtT
         veNsfSFttLF58bi/D5avCMuCWIexsj0fsWn7AsAgRSLXjgo89OdUn2vUyRypcB4TYFuE
         KaKuEotXnSkN4qczYKe5auf27Y9XAk018o0+LjzXGavJ8Xnaq6pfQuBzdRP2R9aPp1Di
         nJPYS9BeEcL4nEW/zEOo4d8MIlV3k1G+zZpNr48u3UDQ7yqjIZmtbNDKq5PkeD3Rk1hR
         p0bZSzciU5yK93hu/6FmjN8cINjOWSpJJJ05+7DYTeQkHogR8vnhZ5u08DJpycWCoASG
         favQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OrrsP9OG2U9lID1ZHHoUeFSJyWq6cn3Ni7Hbvjxkttw=;
        fh=+UF4WEFJCXokI1KVaJuNvhV47TZtLx4HFtzKdIpr9Pg=;
        b=J8biD2/TiowYQbsQKrbmtiaIa5T5A3g8tcEowy3rkYbDiLZryt24tsSIciL84eZZ6k
         8nNT29HrX/DJuc/GnST9Fhd+4x4h8/8+Z4snmD3WPiNl7//gL0kD1Jg4G2mWTzL10XQi
         Dgqbcdo4HNS7Xoez49EPGFmyNYFSfmff8XqQWLAhM3LTTDUhX2q+d/3oqFMxegWBBSgR
         klxdodvYAMROtUpU0yEgFlLd0OUqQXljt39rUKAkzc0faexqP2ZhBX/KJAWhlbA2WFxZ
         V+Xx+DUje8MRFHrjONIelMxC5cZOcJL4No8VtrhOi+KaPssvhqqM83IYrKVTwvLc6YIH
         agnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782843231; x=1783448031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrrsP9OG2U9lID1ZHHoUeFSJyWq6cn3Ni7Hbvjxkttw=;
        b=PPhSxSH96mWePqPIBMP76tcgs+UWFOtHcchRcBBfI8kMatPf8p3LeJKiPu/7C8DCJ/
         l/RhJQfK/y1fmOLCTTuL2NagxOLm7deeQmbMDh+rH69k3sT/Hw64NQx428ZUnK2vniiw
         JdASeOOH8gt8+d6eU5BkLnPj7+yBCzk2UH8XlD4Ffi35Xzyr1W2A61sltL7AwTm1fC0t
         ydtoV9fO7XYwAfa3ZvsAyyz29gonXqukZoiWLJ8vA5YASoR45/biKU1pYaccqsPiynLK
         IZ4BlCVUrDBGrCEHNxmQ0+xS5LKcmi64TZy3OOsh91fM+b/SYPB6RhB1eyj1dBEDZigP
         8B8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843231; x=1783448031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OrrsP9OG2U9lID1ZHHoUeFSJyWq6cn3Ni7Hbvjxkttw=;
        b=TQqlQedQ8bdS/dh8Qg5n/qZaacfSRiNQD0Watkc1ff/4gZI4pMXwWz9blwOkUVBheN
         brwrgG0R0PVHAgpF1IcuuWJejfGEhzInRoj4V58dGEOcwRCbI3rlir3I8EDrtnNw83Ys
         pG/KwEub4+5kN7V+A0YygwpArudsyqGqYS6FWXX3mE4vOqMDYoWzG2hstfjnrz5XLPz6
         gq9U8eWJSHDtnSuD64Sch7cjdc44MBknK9DPIKUP/3TiXSehi+hh/QwdatsPOY10FFr/
         VzafflTUe7dnNCi8QUYWS0m63waxBlc0EdUuOFUonn5ylXSh3G1kpBJwj8kHoanf2aBC
         6GRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+QeZpLyGFDke6uFhiGG2cUfRy1QHGMpSCISOE723G6cDVzznfLQ+Cz0RB+xXBZyuV0tdIyb+MAjvZg6Wb5hS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3WDILUgeN7/+AnQeGGVwGckVDZHUplzQJGu6s3FN88QeIZlNI
	xGmk0mwIt9NaoWrq1KGkkjB4HmMCWXmIS0l/Z6kUe094WA87VRnbvfnePFAI/kz4QkdUNJdFl2O
	1dS/FS4xaCIApGRtVSl7vMQklzitBMEY=
X-Gm-Gg: AfdE7cknzZpdr224xFxfQkhkH963K8u2DocOP4YSOnMwktnuWvjNNu9lPq1S1+/GCQX
	tGyjrbY5fPzMfcgesiQmG/pv6p07PF/twSpv7JqIRVaTdr4RQrpgqCHzTGqq8lRIy+zgqGGVF2z
	uYhAVJtBGTlfJfSlYpFWckBGb4/XLXlGtIgbbprRdy+oSemhxhE9p5GpIx6cCc9auobtJTNsdiu
	/eac4gOmkwUkfjF31qaciI26Cp4bpSFrmeI1VroyEKqU+8TmapRHjE8YZ7054+30xi5K/QqT03N
	AxXAdqMmuUO/f+E4B5CU36Qf7bKzgs6J+0ItoyURiVXmpoBiBN8paYTJz6SSzhVv9fU=
X-Received: by 2002:a05:6808:1308:b0:48b:626c:77b0 with SMTP id
 5614622812f47-495eaef2c2emr3952635b6e.26.1782843230620; Tue, 30 Jun 2026
 11:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-btmtk-ryzen-remote-wakeup-v1-1-1d2f1cee6d22@rong.moe>
In-Reply-To: <20260629-btmtk-ryzen-remote-wakeup-v1-1-1d2f1cee6d22@rong.moe>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 30 Jun 2026 14:13:39 -0400
X-Gm-Features: AVVi8Cf_dKRwkrq_lWyyBPSPON224TZvf1AOfBhLImbCwdJjDU6urnQUGZKhu3Y
Message-ID: <CABBYNZLhqQF-V8sJORwMW2C_4FxFY+pkAK=cSDg4aeWJYfiJrA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Properly disable remote wakeup for
 MT7922/MT7925 on Ryzen platform
To: Rong Zhang <i@rong.moe>
Cc: Marcel Holtmann <marcel@holtmann.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, =?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>, 
	=?UTF-8?B?V2lsbC1DWSBMZWUgKOadjuaUv+epjik=?= <Will-CY.Lee@mediatek.com>, 
	=?UTF-8?B?U1MgV3UgKOW3q+aGsuasoyk=?= <ss.wu@mediatek.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rong,

On Mon, Jun 29, 2026 at 11:28=E2=80=AFAM Rong Zhang <i@rong.moe> wrote:
>
> It is reported that a remote wakeup could cause MT7922/MT7925's btusb
> interface completely unresponsive. Resetting the xHCI root hub doesn't
> help at all, and recovering from such a state needs a power cycle.
>
> All reports seen to be relevant to Ryzen-based laptops. These NICs are
> usually used as OEM components thanks to some sort of reference designs.
>
> Their popularity on other platforms is unclear. While there is still a
> chance that the quirk may exist on other platforms, be cautious and only
> apply the quirk on AMD platforms for the time being.
>
> Meanwhile, though device_set_wakeup_capable(false) is the correct fix
> for other NICs with fake remote wakeup capabilities, doing so for
> MT7922/MT7925 effectively prevents it from being used as wakeup
> sources as per userspace requests. Hence, return -EBUSY on runtime
> suspend to prevent the interface from being autosuspended while it's
> still opened, which has the same effect as
> device_set_wakeup_capable(false), since disabling remote wakeup simply
> causes the USB core to gate runtime autosuspend as well due to
> needs_remote_wakeup =3D=3D 1. The interface can be safely autosuspended a=
s
> long as remote wakeup is disabled, i.e., after closing the HCI device.
>
> Specifically, the interface may still take the advantage of remote
> wakeup in order to wake up the system from sleep if userspace has
> enabled it as a wakeup source.
>
> Fixes: e31d761628ad ("Bluetooth: btmtk: Disable remote wakeup for MT7922/=
MT7925")
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
>  drivers/bluetooth/btmtk.c | 10 ---------
>  drivers/bluetooth/btusb.c | 57 +++++++++++++++++++++++++++++++++++++++++=
++----
>  2 files changed, 53 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 02a96342e964..4614434dd57b 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -1381,16 +1381,6 @@ int btmtk_usb_setup(struct hci_dev *hdev)
>                 break;
>         case 0x7922:
>         case 0x7925:
> -               /*
> -                * A remote wakeup could cause the device completely unre=
sponsive, and
> -                * recovering from such a state needs a power cycle.
> -                *
> -                * Since the remote wakeup capability is super broken, ju=
st disable it
> -                * to get rid of the troubles. The device can still be au=
tosuspended
> -                * when the bluetooth interface is closed.
> -                */
> -               device_set_wakeup_capable(&btmtk_data->udev->dev, false);
> -               fallthrough;
>         case 0x7961:
>         case 0x7902:
>         case 0x6639:
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 08c0a99a62c5..023ae782f41a 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -6,6 +6,7 @@
>   *  Copyright (C) 2005-2008  Marcel Holtmann <marcel@holtmann.org>
>   */
>
> +#include <linux/cpufeature.h>
>  #include <linux/dmi.h>
>  #include <linux/module.h>
>  #include <linux/usb.h>
> @@ -957,6 +958,7 @@ struct qca_dump_info {
>  #define BTUSB_USE_ALT3_FOR_WBS 15
>  #define BTUSB_ALT6_CONTINUOUS_TX       16
>  #define BTUSB_HW_SSR_ACTIVE    17
> +#define BTUSB_WAKEUP_BROKEN    18
>
>  struct btusb_data {
>         struct hci_dev       *hdev;
> @@ -2936,10 +2938,20 @@ static int btusb_send_frame_mtk(struct hci_dev *h=
dev, struct sk_buff *skb)
>         }
>  }
>
> +static inline bool platform_is_ryzen(void)
> +{
> +#ifdef CONFIG_X86
> +       return boot_cpu_has(X86_FEATURE_ZEN);
> +#else
> +       return false;
> +#endif
> +}
> +
>  static int btusb_mtk_setup(struct hci_dev *hdev)
>  {
>         struct btusb_data *data =3D hci_get_drvdata(hdev);
>         struct btmtk_data *btmtk_data =3D hci_get_priv(hdev);
> +       int err;
>
>         /* MediaTek WMT vendor cmd requiring below USB resources to
>          * complete the handshake.
> @@ -2956,7 +2968,29 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>                 btusb_mtk_claim_iso_intf(data);
>         }
>
> -       return btmtk_usb_setup(hdev);
> +       err =3D btmtk_usb_setup(hdev);
> +       if (err)
> +               return err;
> +
> +       switch (btmtk_data->dev_id) {
> +       case 0x7922:
> +       case 0x7925:
> +               /*
> +                * All reports seen to be relevant to Ryzen-based laptops=
. These
> +                * NICs are usually used as OEM components thanks to some=
 sort
> +                * of reference designs.
> +                *
> +                * Their popularity on other platforms is unclear. While =
there
> +                * is still a chance that the quirk may exist on other
> +                * platforms, be cautious and only apply the quirk on AMD
> +                * platforms for the time being.
> +                */

Is this going to be a reliable way to detect if wakeup is broken or
not? Since USB is a bus capable of hotplug, this check would block not
only internal/built-in controllers with the above IDs but also those
plugged via external ports if the CPU happens to be of the ZEN
familly.

> +               if (platform_is_ryzen())
> +                       set_bit(BTUSB_WAKEUP_BROKEN, &data->flags);
> +               break;
> +       }
> +
> +       return 0;
>  }
>
>  static int btusb_mtk_shutdown(struct hci_dev *hdev)
> @@ -4532,11 +4566,26 @@ static int btusb_suspend(struct usb_interface *in=
tf, pm_message_t message)
>
>         BT_DBG("intf %p", intf);
>
> -       /* Don't auto-suspend if there are connections or discovery in
> -        * progress; external suspend calls shall never fail.
> +       /*
> +        * It is reported that remote wakeup events could sometimes cause=
 some
> +        * adapters completely unresponsive. Resetting the xHCI root hub =
doesn't
> +        * help at all, and recovering from such a state needs a power cy=
cle.
> +        * Since disabling remote wakeup simply causes the USB core to ga=
te
> +        * runtime autosuspend as well due to needs_remote_wakeup =3D=3D =
1, let's do
> +        * this ourselves to make our life easier. The interface can be s=
afely
> +        * autosuspended as long as remote wakeup is disabled, i.e., afte=
r
> +        * closing the HCI device.
> +        *
> +        * Don't auto-suspend if there are connections or discovery in pr=
ogress.
> +        *
> +        * External suspend calls shall never fail. Specifically, a devic=
e with
> +        * broken remote wakeup may still take the advantage of remote wa=
keup in
> +        * order to wake up the system from sleep if userspace has enable=
d it as
> +        * a wakeup source.
>          */
>         if (PMSG_IS_AUTO(message) &&
> -           (hci_conn_count(data->hdev) || hci_discovery_active(data->hde=
v)))
> +           ((test_bit(BTUSB_WAKEUP_BROKEN, &data->flags) && data->intf->=
needs_remote_wakeup) ||
> +            hci_conn_count(data->hdev) || hci_discovery_active(data->hde=
v)))
>                 return -EBUSY;
>
>         if (data->suspend_count++)
>
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 230ba8c9-btmtk-ryzen-remote-wakeup-055a407682ef
>
> Thanks,
> Rong
>


--=20
Luiz Augusto von Dentz
