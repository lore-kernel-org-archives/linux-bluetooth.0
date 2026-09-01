Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDBB472085
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282375; cv=pass; b=AubM2IqsD4sksYrlVRkCH+Fn2e+hNGzhquqifU7oYvMPqz43Q/TVs7ft/3O4Uy7ly8lmL1nZqbIVqT2CPjJiBqcERslCw0AfNM58MNxDltPfo3sZaOUVfWcfvB2kJYwgKdnLYBmjwq/lYhnIUieO+toRtES0pUy4sQfern81+fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282375; c=relaxed/simple;
	bh=iH75Rh+2KzW8GoyMSWWHTjsWvmXSx3udBLK3PhukoW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ishLlMRVSwbUOfZfk9QoEKsr1f/2B0LXsIlVlLbACMctEtq22+uXPK6mELf0DTmNIAlKzvdCNuuQH2MRhqkCG7o7mZdYmCbA2Ikrb4lU8Dz3hSY1REAYgafCVru8kYlEF9VSho6CLjjZoLsZVn5+RLX8dvLUsfjDMwq2QDK9PJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyIByPG/; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyIByPG/"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-855c26cf490so2382787b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 10:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788282371; cv=none;
        d=google.com; s=arc-20260327;
        b=TPL+5KcY/urpqGL257mhtKPCsVVgb79x4bQpbu0EEeUrYOwtwv5H8GlLKN9AaDnb3X
         arXsIzgwUk6VBfiytU4HSAbuAPvSTzgXX4iH1to+h+L92SasSEum/hUrBiPvAfmcMLrJ
         6QlSPJnIHgMptwL2noQal5XrVYvExHrqEH4O42nJhiPiLCuYniRLCt6cmA5siLkwFAUt
         TpZW6brJIuaWqZOHSlYmnYtGZx86E/m6YylwOk+M5BR5jt5q1/eWJqVrzQUoqzOLaKtn
         7dAtYjMjHiyuxxbCaIIdifr9YUmJv/++Iz3wr3vIfTybpFID2eeHI1pV7E1EvVeYvNIZ
         NbVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2knjofwQvuzR1wr+XZv3xX6N0QAal6YKt6Ix7SMUxH4=;
        fh=pAUwAhPmik5Tamzz5BH+p8G8fN1TnT0LLQ7LQiakrPc=;
        b=B706Q/iUqqWxjxlHuFE9N2e+DcnDa1LKHh9MUzE44S9/KKAuZ9pvVpxe4k3XE4N9Pz
         v7/tX4zJfQelsSGerIfawM9NMNk0pKcNEE4CYu0tB0Tmq7qoYH17fDm5LygAXdYnZNHM
         Mfhon/bhwuUh0YjljudXQ7qjVK8N0Qi89Mf+ICggIUyZahTaeKB7g6i5zfX9exxNes1+
         GmhVMMREc06ZQVSGIhDKESCWg97k7stZprLzqI+5lk34+o/FU1bKfoHFsMmA3E9rgpbq
         oAwxe61B+7lPsD/JxvX+5691a+s2/tHTKt/4IcrYahqeeo5S2MiCLVToTAsmaMdGEc1M
         drPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788282371; x=1788887171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2knjofwQvuzR1wr+XZv3xX6N0QAal6YKt6Ix7SMUxH4=;
        b=VyIByPG/0SQ1MuQqCxwSs0IrFZLDNpq9oouJI28Zvezl43edOpZR6suhCcNoor+iH9
         zlFRtINK3zvj4G9ru2rpxqq+dawgka6T0saR6qkba6JkaPAJN8hG6pi3J719LeKpeB71
         XgVZOGf4xhheiL8bWX08bRtH6r5CWGSrDrBDUsntNC4O/ttaPusJBeIPK+Y+W2Oo1ad0
         M7esHPVDwzass+6AZqk31Uc7ZCgaXAqOoABsiJQwBbnjg36agU1v8prZnsE7TqWnhnqO
         l92inLuPXlV0XJsliAvk6I1ncMbEHOXWO/QT0BNi/J4ObSlyyJNyhA3iMr5RTg6bpeta
         3KAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788282371; x=1788887171;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2knjofwQvuzR1wr+XZv3xX6N0QAal6YKt6Ix7SMUxH4=;
        b=Kz+VffLaMr9qhd3e12b+8tXmH2J3xFAMgypLeHojTAiI1Crf63WgN9RwBdqG6dr88C
         lL6IGJNlXONCdyLMMzFAoaR6Yhzl31JXoy8X/UwQNk7gIDCNxcq4GsGO+SdkHtF1a4ZH
         DfetgeCgoe56dVrRoK/BK6nDBmgayNnBI1uCFOhAPFVCQD9okcd16pPV1MX/FNKUIqTi
         A47KbUwHaJXQsV3JJQ3MSRq+uioDqX6qHlub1Is0P+UPZLldboPyBCj8cAdOOc77VqZy
         e12Kg1o0NiWqGuDt/3Q2sghSO9wyggTlDWoLhwaRCDR/81ofudyf3HM/GLokyrHNvqfV
         9BvA==
X-Forwarded-Encrypted: i=1; AKwUvBya1LLiDRBeYjoYR2ab23l3+o6DxUEKpQonD3wyGVeDErCJAs1ZaNgpNybNIYaVu9BPaq10H10CPi93SYzf1Ms=@vger.kernel.org
X-Gm-Message-State: AFuF++nYG7dIvAZqvI87gKdIHnYw5Uf2sWPHKM6nylL/sTUEr6LXps/w
	ZVnQ1gcuiaWnfS7hndzGEnV4vXE2m4Vyh8Mmy2kCdz4ToCdQqSqcZbad3gi5whlZnvTaHRO4s+Y
	v8GMBnLJklhK8VqJjmotOE8rR6OqW33U=
X-Gm-Gg: AYBFou0r9SoCSLFevHOgLQjPZNgCVz57aAr17gt8SWTp+H1E6szdN0jWQHWcl9ih9y6
	guurlKmXZAZ/BOW72LTeaYasmC5w5EcBgv3ClGvgumCEcgeXdLZnAlKUfJVG4L4uKdLVKeBsrgI
	5gTrS9B3xwA+XkF78735EmnR/V/H3b5UsaFOm4MrEmzjBjLbxl+E9FAWKuwZrNORxGylQio9Rh5
	lP9uakaidFKhJMctan1tGFQQS4PnP8YHeNEW+PCypoxWgHI6TgOrcTHFqgyIECJPRtmQNEdwhlH
	2itRNC30KGwr/I13+cF4cGuLX6azGLauqX+YARWHdJS+LAGjG85DTX5R5WMXKPG7y+bKYwv9A7F
	GJtqeKd6s/JGsXLm8AdmhVFLZWV2TPnw=
X-Received: by 2002:a05:690c:c384:b0:81e:5d2e:89c8 with SMTP id
 00721157ae682-85d69e05ecbmr139075427b3.14.1788282370489; Tue, 01 Sep 2026
 10:06:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701-btmtk-ryzen-remote-wakeup-v2-1-767ac7907472@rong.moe> <8783d4c77f112c55c9f9678b5a8e0a88d49c1141.camel@rong.moe>
In-Reply-To: <8783d4c77f112c55c9f9678b5a8e0a88d49c1141.camel@rong.moe>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 1 Sep 2026 13:05:58 -0400
X-Gm-Features: AcwNN1WyKYfoBfTCbGlRw4onwMdCpqeOdj0mqYvXld-ZqkdT9u9PeZktFapWL2M
Message-ID: <CABBYNZJ2J1Z5X+bb_3DLbXR-xVLP9Jzu62NjhDx1f+GErVTy8w@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Properly disable remote wakeup for
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

On Tue, Sep 1, 2026 at 12:42=E2=80=AFPM Rong Zhang <i@rong.moe> wrote:
>
> Hi Luiz,
>
> Gentle ping.
>
> On Wed, 2026-07-01 at 23:43 +0800, Rong Zhang wrote:
> > It is reported that a remote wakeup could cause MT7922/MT7925's btusb
> > interface completely unresponsive. Resetting the xHCI root hub doesn't
> > help at all, and recovering from such a state needs a power cycle.
> >
> > All reports seen to be relevant to Ryzen-based laptops. These NICs are
> > usually used as OEM components thanks to some sort of reference designs=
.
> > Their popularity on other platforms is unclear. While there is still a
> > chance that the quirk may exist on other platforms, be cautious and onl=
y
> > apply the quirk to direct children of Ryzen platforms's root hubs for
> > the time being. In most cases the root hub is on the SoC or PCH, which
> > needs the quirk. Unfortunately, this can't distinguish root hubs on PCI=
e
> > add-in cards. Such roughness should be acceptable, as PCIe USB
> > controller add-in cards are less commonly used nowadays. On the other
> > hand, applying the quirk doesn't hurt any functionalities either, as th=
e
> > device can still be used as a wakeup source if desired. Theoretically,
> > we could retrieve the root hub's PCI vendor ID with some hierarchy
> > magic, but that's too intrusive...
> >
> > Meanwhile, though device_set_wakeup_capable(false) is the correct fix
> > for other NICs with fake remote wakeup capabilities, doing so for
> > MT7922/MT7925 effectively prevents it from being used as wakeup
> > sources as per userspace requests. Hence, return -EBUSY on runtime
> > suspend to prevent the interface from being autosuspended while it's
> > still opened, which has the same effect as
> > device_set_wakeup_capable(false), since disabling remote wakeup simply
> > causes the USB core to gate runtime autosuspend as well due to
> > needs_remote_wakeup =3D=3D 1. The interface can be safely autosuspended=
 as
> > long as remote wakeup is disabled, i.e., after closing the HCI device.
> >
> > Specifically, the interface may still take the advantage of remote
> > wakeup in order to wake up the system from sleep if userspace has
> > enabled it as a wakeup source.
> >
> > Fixes: e31d761628ad ("Bluetooth: btmtk: Disable remote wakeup for MT792=
2/MT7925")
> > Signed-off-by: Rong Zhang <i@rong.moe>
>
> Could you kindly take a look at the patch?
>
> Chris Lu from MediaTek has relied with a "LGTM" to the patch, and there
> is already a Tested-by from Rafael Passos. Additionally, based on
> Rafael's debugging observations, the issue does exist on AMD PCHs, so
> matching X86_FEATURE_ZEN is appropriate.

Please resubmit so it can be retested, since it has already been
archived for being over 30 days old.

> Thanks,
> Rong
>
> > ---
> > Changes in v2:
> > - Only apply the quirk to to direct children of Ryzen platforms's root
> >   hubs
> >   - Theoretically, we could retrieve the root hub's PCI vendor ID with
> >     some hierarchy magic to further limit the range down to only root
> >     hubs on the SoC or PCH, but that's too intrusive -- the hierarchy
> >     magic really made me nervous once I saw what I have wrote, so I gav=
e
> >     it up
> > - Link to v1: https://patch.msgid.link/20260629-btmtk-ryzen-remote-wake=
up-v1-1-1d2f1cee6d22@rong.moe
> > ---
> >  drivers/bluetooth/btmtk.c | 10 -------
> >  drivers/bluetooth/btusb.c | 73 +++++++++++++++++++++++++++++++++++++++=
+++++---
> >  2 files changed, 69 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> > index 02a96342e964..4614434dd57b 100644
> > --- a/drivers/bluetooth/btmtk.c
> > +++ b/drivers/bluetooth/btmtk.c
> > @@ -1381,16 +1381,6 @@ int btmtk_usb_setup(struct hci_dev *hdev)
> >               break;
> >       case 0x7922:
> >       case 0x7925:
> > -             /*
> > -              * A remote wakeup could cause the device completely unre=
sponsive, and
> > -              * recovering from such a state needs a power cycle.
> > -              *
> > -              * Since the remote wakeup capability is super broken, ju=
st disable it
> > -              * to get rid of the troubles. The device can still be au=
tosuspended
> > -              * when the bluetooth interface is closed.
> > -              */
> > -             device_set_wakeup_capable(&btmtk_data->udev->dev, false);
> > -             fallthrough;
> >       case 0x7961:
> >       case 0x7902:
> >       case 0x6639:
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 08c0a99a62c5..eef6e3b43bf9 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -6,6 +6,7 @@
> >   *  Copyright (C) 2005-2008  Marcel Holtmann <marcel@holtmann.org>
> >   */
> >
> > +#include <linux/cpufeature.h>
> >  #include <linux/dmi.h>
> >  #include <linux/module.h>
> >  #include <linux/usb.h>
> > @@ -957,6 +958,7 @@ struct qca_dump_info {
> >  #define BTUSB_USE_ALT3_FOR_WBS       15
> >  #define BTUSB_ALT6_CONTINUOUS_TX     16
> >  #define BTUSB_HW_SSR_ACTIVE  17
> > +#define BTUSB_WAKEUP_BROKEN  18
> >
> >  struct btusb_data {
> >       struct hci_dev       *hdev;
> > @@ -2936,10 +2938,25 @@ static int btusb_send_frame_mtk(struct hci_dev =
*hdev, struct sk_buff *skb)
> >       }
> >  }
> >
> > +static inline bool platform_is_ryzen(void)
> > +{
> > +#ifdef CONFIG_X86
> > +     return boot_cpu_has(X86_FEATURE_ZEN);
> > +#else
> > +     return false;
> > +#endif
> > +}
> > +
> > +static inline bool is_direct_child_of_root_hub(struct usb_device *udev=
)
> > +{
> > +     return udev->parent =3D=3D udev->bus->root_hub;
> > +}
> > +
> >  static int btusb_mtk_setup(struct hci_dev *hdev)
> >  {
> >       struct btusb_data *data =3D hci_get_drvdata(hdev);
> >       struct btmtk_data *btmtk_data =3D hci_get_priv(hdev);
> > +     int err;
> >
> >       /* MediaTek WMT vendor cmd requiring below USB resources to
> >        * complete the handshake.
> > @@ -2956,7 +2973,40 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
> >               btusb_mtk_claim_iso_intf(data);
> >       }
> >
> > -     return btmtk_usb_setup(hdev);
> > +     err =3D btmtk_usb_setup(hdev);
> > +     if (err)
> > +             return err;
> > +
> > +     switch (btmtk_data->dev_id) {
> > +     case 0x7922:
> > +     case 0x7925:
> > +             /*
> > +              * All reports seen to be relevant to Ryzen-based laptops=
. These
> > +              * NICs are usually used as OEM components thanks to some=
 sort
> > +              * of reference designs.
> > +              *
> > +              * Their popularity on other platforms is unclear. While =
there
> > +              * is still a chance that the quirk may exist on other
> > +              * platforms, be cautious and only apply the quirk to dir=
ect
> > +              * children of Ryzen platforms's root hubs for the time b=
eing.
> > +              *
> > +              * In most cases the root hub is on the SoC or PCH, which=
 needs
> > +              * the quirk. Unfortunately, this can't distinguish root =
hubs on
> > +              * PCIe add-in cards. Such roughness should be acceptable=
, as
> > +              * PCIe USB controller add-in cards are less commonly use=
d
> > +              * nowadays. On the other hand, applying the quirk doesn'=
t hurt
> > +              * any functionalities either, as the device can still be=
 used
> > +              * as a wakeup source if desired.
> > +              *
> > +              * Theoretically, we could retrieve the root hub's PCI ve=
ndor ID
> > +              * with some hierarchy magic, but that's too intrusive...
> > +              */
> > +             if (platform_is_ryzen() && is_direct_child_of_root_hub(da=
ta->udev))
> > +                     set_bit(BTUSB_WAKEUP_BROKEN, &data->flags);
> > +             break;
> > +     }
> > +
> > +     return 0;
> >  }
> >
> >  static int btusb_mtk_shutdown(struct hci_dev *hdev)
> > @@ -4532,11 +4582,26 @@ static int btusb_suspend(struct usb_interface *=
intf, pm_message_t message)
> >
> >       BT_DBG("intf %p", intf);
> >
> > -     /* Don't auto-suspend if there are connections or discovery in
> > -      * progress; external suspend calls shall never fail.
> > +     /*
> > +      * It is reported that remote wakeup events could sometimes cause=
 some
> > +      * adapters completely unresponsive. Resetting the xHCI root hub =
doesn't
> > +      * help at all, and recovering from such a state needs a power cy=
cle.
> > +      * Since disabling remote wakeup simply causes the USB core to ga=
te
> > +      * runtime autosuspend as well due to needs_remote_wakeup =3D=3D =
1, let's do
> > +      * this ourselves to make our life easier. The interface can be s=
afely
> > +      * autosuspended as long as remote wakeup is disabled, i.e., afte=
r
> > +      * closing the HCI device.
> > +      *
> > +      * Don't auto-suspend if there are connections or discovery in pr=
ogress.
> > +      *
> > +      * External suspend calls shall never fail. Specifically, a devic=
e with
> > +      * broken remote wakeup may still take the advantage of remote wa=
keup in
> > +      * order to wake up the system from sleep if userspace has enable=
d it as
> > +      * a wakeup source.
> >        */
> >       if (PMSG_IS_AUTO(message) &&
> > -         (hci_conn_count(data->hdev) || hci_discovery_active(data->hde=
v)))
> > +         ((test_bit(BTUSB_WAKEUP_BROKEN, &data->flags) && data->intf->=
needs_remote_wakeup) ||
> > +          hci_conn_count(data->hdev) || hci_discovery_active(data->hde=
v)))
> >               return -EBUSY;
> >
> >       if (data->suspend_count++)
> >
> > ---
> > base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> > change-id: 230ba8c9-btmtk-ryzen-remote-wakeup-055a407682ef
> >
> > Thanks,
> > Rong



--=20
Luiz Augusto von Dentz
