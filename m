Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78552580E1;
	Tue, 30 Jun 2026 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846950; cv=pass; b=bQViMmfKPYjiMVJEdHkaftD62iRrXlQC/WFOGxIdmKirl62GOVSB/5SDuvFHGn/4WNElVDApI5Pcz5gZ79wZfpAMyArZDnww+Dx/9ubhh7X5ttEKhwOsHimANWHxlw3g6gc7lW+Q00olM+Yl/vyMMbx3YntCW6oW5rnx2g5RVIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846950; c=relaxed/simple;
	bh=8hMo+0gTrjI/uJh+UUz9hPhW4SlFPnkUvoujDFUZjZI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=HDmFkdDZb/VDp6fcd3eHCAd9m/3ovqolfsZD7H+iCTkp0i/5jzEbjucCpKCI4BBIONjZOUCG/JM7sCFLlXLU9cy/jMRmuLYvQV06crGZ+W2vnH2D9th51da0HPJ/w1ytuo7FDWBx3Pz7CO+rqMOY9TGaYqlx86LdFIQHd3F333A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=WKdlm2zY; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="WKdlm2zY"
ARC-Seal: i=1; a=rsa-sha256; t=1782846932; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=O3eJ1En/l9r2mDqOFLIxD267cRY9zriaeO74GfZ6YClSvSR+yp+31StrsNE5ll4CHdH/wX00frO5sXGD6rH/zSvyS1KNzhzJSnn6xXQ+u63Cgo/mCbqJ57wpu50N1oafYLjhOm3aEdR1cIy60W+1ZNP3j8Yj1u5833ek7Lywe9A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782846932; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1qagP0VuISi0UOXqphEC64UCJS1rYEuCpGZ+HrzWmK8=; 
	b=LUdOVPOY11Mr+fl4wSwar9giH8+XUDU/7D4Vuae2BF0zQqVPb5irb37bdETm8cHv76a0cLvpHCZg3mhvOdJ+1frpEyljiJDN9IZHEzf1FyBXQjet6gSOaxkf7i9S7KqawSeLGOJRyPKRgJvBkTLwpeXnr3C2TRbbWzdqK7l366M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782846932;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=1qagP0VuISi0UOXqphEC64UCJS1rYEuCpGZ+HrzWmK8=;
	b=WKdlm2zYjWv5uWW9qnDQTh9z34SpI6+w5yRv78MPN9oW1AWAwK1yqWOD3hBwbb0D
	PFXcLD5Epg5tr0xjHWfQOBuv4bNTuWT6A2+tm6oqTAdsgpXQT5Xbjsd8Mg+eQ7H3z2X
	tIcaf+AvRcwbdi2w2MEgX1FkFKJ+JndHaNkwRLkucZf3/GYHCdYTnu2u3knbJAGqMVN
	bne78IRVMI3zJnsP28CRxCTee95JtrjB06LFWTcn8Ja6XgP1kFpAQ54AcBnhMa6S4n4
	F0i61y0/n9ObNFou24Zh2kI1pGI/IJNbAOSzy9Epj4uj3b6tTnr6F4ZHKFEdW3EVW+W
	Cnwd/JSIzQ==
Received: by mx.zohomail.com with SMTPS id 1782846928874810.0972195254349;
	Tue, 30 Jun 2026 12:15:28 -0700 (PDT)
Date: Wed, 01 Jul 2026 03:15:19 +0800
From: Rong Zhang <i@rong.moe>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 =?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>,
 =?UTF-8?B?V2lsbC1DWSBMZWUgKOadjuaUv+epjik=?= <Will-CY.Lee@mediatek.com>,
 =?UTF-8?B?U1MgV3UgKOW3q+aGsuasoyk=?= <ss.wu@mediatek.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_Bluetooth=3A_Properly_disable_remo?=
 =?US-ASCII?Q?te_wakeup_for_MT7922/MT7925_on_Ryzen_platform?=
User-Agent: Thunderbird for Android
In-Reply-To: <CABBYNZLhqQF-V8sJORwMW2C_4FxFY+pkAK=cSDg4aeWJYfiJrA@mail.gmail.com>
References: <20260629-btmtk-ryzen-remote-wakeup-v1-1-1d2f1cee6d22@rong.moe> <CABBYNZLhqQF-V8sJORwMW2C_4FxFY+pkAK=cSDg4aeWJYfiJrA@mail.gmail.com>
Message-ID: <7410991C-F48D-4D58-8F27-0DFCB27E81FF@rong.moe>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hi Luiz,

=E4=BA=8E 2026=E5=B9=B47=E6=9C=881=E6=97=A5 GMT+08:00 02:13:39=EF=BC=8CLui=
z Augusto von Dentz <luiz=2Edentz@gmail=2Ecom> =E5=86=99=E9=81=93=EF=BC=9A
>Hi Rong,
>
>On Mon, Jun 29, 2026 at 11:28=E2=80=AFAM Rong Zhang <i@rong=2Emoe> wrote:
>>
>> It is reported that a remote wakeup could cause MT7922/MT7925's btusb
>> interface completely unresponsive=2E Resetting the xHCI root hub doesn'=
t
>> help at all, and recovering from such a state needs a power cycle=2E
>>
>> All reports seen to be relevant to Ryzen-based laptops=2E These NICs ar=
e
>> usually used as OEM components thanks to some sort of reference designs=
=2E
>>
>> Their popularity on other platforms is unclear=2E While there is still =
a
>> chance that the quirk may exist on other platforms, be cautious and onl=
y
>> apply the quirk on AMD platforms for the time being=2E
>>
>> Meanwhile, though device_set_wakeup_capable(false) is the correct fix
>> for other NICs with fake remote wakeup capabilities, doing so for
>> MT7922/MT7925 effectively prevents it from being used as wakeup
>> sources as per userspace requests=2E Hence, return -EBUSY on runtime
>> suspend to prevent the interface from being autosuspended while it's
>> still opened, which has the same effect as
>> device_set_wakeup_capable(false), since disabling remote wakeup simply
>> causes the USB core to gate runtime autosuspend as well due to
>> needs_remote_wakeup =3D=3D 1=2E The interface can be safely autosuspend=
ed as
>> long as remote wakeup is disabled, i=2Ee=2E, after closing the HCI devi=
ce=2E
>>
>> Specifically, the interface may still take the advantage of remote
>> wakeup in order to wake up the system from sleep if userspace has
>> enabled it as a wakeup source=2E
>>
>> Fixes: e31d761628ad ("Bluetooth: btmtk: Disable remote wakeup for MT792=
2/MT7925")
>> Signed-off-by: Rong Zhang <i@rong=2Emoe>
>> ---
>>  drivers/bluetooth/btmtk=2Ec | 10 ---------
>>  drivers/bluetooth/btusb=2Ec | 57 +++++++++++++++++++++++++++++++++++++=
++++++----
>>  2 files changed, 53 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btmtk=2Ec b/drivers/bluetooth/btmtk=2Ec
>> index 02a96342e964=2E=2E4614434dd57b 100644
>> --- a/drivers/bluetooth/btmtk=2Ec
>> +++ b/drivers/bluetooth/btmtk=2Ec
>> @@ -1381,16 +1381,6 @@ int btmtk_usb_setup(struct hci_dev *hdev)
>>                 break;
>>         case 0x7922:
>>         case 0x7925:
>> -               /*
>> -                * A remote wakeup could cause the device completely un=
responsive, and
>> -                * recovering from such a state needs a power cycle=2E
>> -                *
>> -                * Since the remote wakeup capability is super broken, =
just disable it
>> -                * to get rid of the troubles=2E The device can still b=
e autosuspended
>> -                * when the bluetooth interface is closed=2E
>> -                */
>> -               device_set_wakeup_capable(&btmtk_data->udev->dev, false=
);
>> -               fallthrough;
>>         case 0x7961:
>>         case 0x7902:
>>         case 0x6639:
>> diff --git a/drivers/bluetooth/btusb=2Ec b/drivers/bluetooth/btusb=2Ec
>> index 08c0a99a62c5=2E=2E023ae782f41a 100644
>> --- a/drivers/bluetooth/btusb=2Ec
>> +++ b/drivers/bluetooth/btusb=2Ec
>> @@ -6,6 +6,7 @@
>>   *  Copyright (C) 2005-2008  Marcel Holtmann <marcel@holtmann=2Eorg>
>>   */
>>
>> +#include <linux/cpufeature=2Eh>
>>  #include <linux/dmi=2Eh>
>>  #include <linux/module=2Eh>
>>  #include <linux/usb=2Eh>
>> @@ -957,6 +958,7 @@ struct qca_dump_info {
>>  #define BTUSB_USE_ALT3_FOR_WBS 15
>>  #define BTUSB_ALT6_CONTINUOUS_TX       16
>>  #define BTUSB_HW_SSR_ACTIVE    17
>> +#define BTUSB_WAKEUP_BROKEN    18
>>
>>  struct btusb_data {
>>         struct hci_dev       *hdev;
>> @@ -2936,10 +2938,20 @@ static int btusb_send_frame_mtk(struct hci_dev =
*hdev, struct sk_buff *skb)
>>         }
>>  }
>>
>> +static inline bool platform_is_ryzen(void)
>> +{
>> +#ifdef CONFIG_X86
>> +       return boot_cpu_has(X86_FEATURE_ZEN);
>> +#else
>> +       return false;
>> +#endif
>> +}
>> +
>>  static int btusb_mtk_setup(struct hci_dev *hdev)
>>  {
>>         struct btusb_data *data =3D hci_get_drvdata(hdev);
>>         struct btmtk_data *btmtk_data =3D hci_get_priv(hdev);
>> +       int err;
>>
>>         /* MediaTek WMT vendor cmd requiring below USB resources to
>>          * complete the handshake=2E
>> @@ -2956,7 +2968,29 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>>                 btusb_mtk_claim_iso_intf(data);
>>         }
>>
>> -       return btmtk_usb_setup(hdev);
>> +       err =3D btmtk_usb_setup(hdev);
>> +       if (err)
>> +               return err;
>> +
>> +       switch (btmtk_data->dev_id) {
>> +       case 0x7922:
>> +       case 0x7925:
>> +               /*
>> +                * All reports seen to be relevant to Ryzen-based lapto=
ps=2E These
>> +                * NICs are usually used as OEM components thanks to so=
me sort
>> +                * of reference designs=2E
>> +                *
>> +                * Their popularity on other platforms is unclear=2E Wh=
ile there
>> +                * is still a chance that the quirk may exist on other
>> +                * platforms, be cautious and only apply the quirk on A=
MD
>> +                * platforms for the time being=2E
>> +                */
>
>Is this going to be a reliable way to detect if wakeup is broken or
>not? Since USB is a bus capable of hotplug, this check would block not
>only internal/built-in controllers with the above IDs but also those
>plugged via external ports if the CPU happens to be of the ZEN
>familly=2E

Hmm, it seems that we can detect the device's position by comparing its pa=
rent and its bus=2E We can additionally make it further by checking against=
 the root hub's VID=2E In this manner we should be able to drop the boot_cp=
u_has() check too=2E

I will try and send a v2=2E

Thanks,
Rong

>
>> +               if (platform_is_ryzen())
>> +                       set_bit(BTUSB_WAKEUP_BROKEN, &data->flags);
>> +               break;
>> +       }
>> +
>> +       return 0;
>>  }
>>
>>  static int btusb_mtk_shutdown(struct hci_dev *hdev)
>> @@ -4532,11 +4566,26 @@ static int btusb_suspend(struct usb_interface *=
intf, pm_message_t message)
>>
>>         BT_DBG("intf %p", intf);
>>
>> -       /* Don't auto-suspend if there are connections or discovery in
>> -        * progress; external suspend calls shall never fail=2E
>> +       /*
>> +        * It is reported that remote wakeup events could sometimes cau=
se some
>> +        * adapters completely unresponsive=2E Resetting the xHCI root =
hub doesn't
>> +        * help at all, and recovering from such a state needs a power =
cycle=2E
>> +        * Since disabling remote wakeup simply causes the USB core to =
gate
>> +        * runtime autosuspend as well due to needs_remote_wakeup =3D=
=3D 1, let's do
>> +        * this ourselves to make our life easier=2E The interface can =
be safely
>> +        * autosuspended as long as remote wakeup is disabled, i=2Ee=2E=
, after
>> +        * closing the HCI device=2E
>> +        *
>> +        * Don't auto-suspend if there are connections or discovery in =
progress=2E
>> +        *
>> +        * External suspend calls shall never fail=2E Specifically, a d=
evice with
>> +        * broken remote wakeup may still take the advantage of remote =
wakeup in
>> +        * order to wake up the system from sleep if userspace has enab=
led it as
>> +        * a wakeup source=2E
>>          */
>>         if (PMSG_IS_AUTO(message) &&
>> -           (hci_conn_count(data->hdev) || hci_discovery_active(data->h=
dev)))
>> +           ((test_bit(BTUSB_WAKEUP_BROKEN, &data->flags) && data->intf=
->needs_remote_wakeup) ||
>> +            hci_conn_count(data->hdev) || hci_discovery_active(data->h=
dev)))
>>                 return -EBUSY;
>>
>>         if (data->suspend_count++)
>>
>> ---
>> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
>> change-id: 230ba8c9-btmtk-ryzen-remote-wakeup-055a407682ef
>>
>> Thanks,
>> Rong
>>
>
>
