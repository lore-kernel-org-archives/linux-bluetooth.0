Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405162EEE66;
	Mon, 13 Jul 2026 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963992; cv=pass; b=RFiFcEIaTmO53+w3Q4qj9VEinc+R/hj9PMFNlTInQLTax6MObhGVGtnPA8BpDtUCdi2BKUP7DkRayCSpcqjdTtiw0bvxsgKkUvJrUjcwzsaLKYeUL3G+bkB3tBYq8R6VGWwR43NSdDrw0cOC+llDhQ6KICpYvJoDXfTCN5HRjew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963992; c=relaxed/simple;
	bh=Hpn3ImAjbhJNtPU1RYJlAIMlATkxrZgSnYFuPfa45yI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=J6H8bkbPAjbTMqKS2R1RY0Bf9tpasDmUs3gbhUs8mF0gQU7dhKs7B/TrNTEcd1OnbS3sal2EwGRKpR9IzASQ497XecjkALaQX36RV2aVzs+ua9xVjrd1wxV0vu4VYj7Zmvuohh+bN2YEpfaGR9Lfoi4zCWWoGirogOncv/+yVTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=iKTNkh22; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="iKTNkh22"
ARC-Seal: i=1; a=rsa-sha256; t=1783963957; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S+qEc5ZNM6OxXqadj85bW/TL2GFk1r5GZz1BmL/CMf9i8B8WCf++7JhPAvES2qXpwr9Ye1Uw2ZU3c4TV0xx3w5ZRNcN2FkZ/3EA3pls4G7g8DR/Fu4SMnnWBn3pgGP8RqfIWQQX9pDYNVHmmEOpstiaGrZJM99ykPFAUG66uR+8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783963957; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/lGiSWvjYmuW/eRCdWMkVVt912olY9aPgO/4phlrOJ4=; 
	b=bS13JviCvqA69CPN1vMaakzv9RdSoVCs5Nwj2iJZ8/x3hJT5P5Tz7EOCqDqLOE+JEN8/znegB0PUuGbIEwizVHGT1QyPLZdATxGJnE2I2xSQrD6VZGWYuit9EL5nq/MInAv7K1zcqI52nkqOjRn1vNu6qT9kYq7BSLAgZJkYUZs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783963957;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=/lGiSWvjYmuW/eRCdWMkVVt912olY9aPgO/4phlrOJ4=;
	b=iKTNkh22tT8BvBDIUDbNSPTuhCZa+cbZxWDH8QfTgRsaKXjjADUFhiTWkpOx4eNA
	v6ZXwKoCoH5bJ5iH7x8KfDTjcNXwAS6aCQnSuA34fMLoOFufhj1RNRP+GZdeGBf7cah
	1q3c3iVJn71bEAGRV3hbvcSHmyI1TuTyhWBULJO9JZwdbX0ypgG3sIDC9beYdPSDQEh
	daCKt4XGR2qBdqIzKO+L8m585KgDiV+Eam/Z+Ok8oOsWApHY3EhKRaDvRksCARmlxaN
	ZZpDL5ysneEj36OllCZIIqzeeSkMFHOOCXdLpDNe1Z/cBI+kwULciGsqiM7i8lHLfRm
	RKeZADaqyQ==
Received: by mx.zohomail.com with SMTPS id 1783963952941762.0404407028492;
	Mon, 13 Jul 2026 10:32:32 -0700 (PDT)
Date: Tue, 14 Jul 2026 01:32:22 +0800
From: Rong Zhang <i@rong.moe>
To: John Rowley <hey@johnrowley.me>
CC: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 =?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>,
 =?UTF-8?B?V2lsbC1DWSBMZWUgKOadjuaUv+epjik=?= <Will-CY.Lee@mediatek.com>,
 =?UTF-8?B?U1MgV3UgKOW3q+aGsuasoyk=?= <ss.wu@mediatek.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_Bluetooth=3A_Properly_disable_rem?=
 =?US-ASCII?Q?ote_wakeup_for_MT7922/MT7925_on_Ryzen_platform?=
User-Agent: Thunderbird for Android
In-Reply-To: <alT767DjNf3bD5V0@localhost.localdomain>
References: <20260701-btmtk-ryzen-remote-wakeup-v2-1-767ac7907472@rong.moe> <alT767DjNf3bD5V0@localhost.localdomain>
Message-ID: <F4F84CDA-3F44-477C-A3FA-24B1617F2F4E@rong.moe>
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

Hi John,

=E4=BA=8E 2026=E5=B9=B47=E6=9C=8813=E6=97=A5 GMT+08:00 23:06:56=EF=BC=8CJo=
hn Rowley <hey@johnrowley=2Eme> =E5=86=99=E9=81=93=EF=BC=9A
>On Wed, Jul 01, 2026 at 11:43:01PM +0800, Rong Zhang wrote:
>> It is reported that a remote wakeup could cause MT7922/MT7925's btusb
>> interface completely unresponsive=2E Resetting the xHCI root hub doesn'=
t
>> help at all, and recovering from such a state needs a power cycle=2E
>>=20
>> All reports seen to be relevant to Ryzen-based laptops=2E These NICs ar=
e
>> usually used as OEM components thanks to some sort of reference designs=
=2E
>> Their popularity on other platforms is unclear=2E While there is still =
a
>> chance that the quirk may exist on other platforms, be cautious and onl=
y
>> apply the quirk to direct children of Ryzen platforms's root hubs for
>> the time being=2E In most cases the root hub is on the SoC or PCH, whic=
h
>> needs the quirk=2E Unfortunately, this can't distinguish root hubs on P=
CIe
>> add-in cards=2E Such roughness should be acceptable, as PCIe USB
>> controller add-in cards are less commonly used nowadays=2E On the other
>> hand, applying the quirk doesn't hurt any functionalities either, as th=
e
>> device can still be used as a wakeup source if desired=2E Theoretically=
,
>> we could retrieve the root hub's PCI vendor ID with some hierarchy
>> magic, but that's too intrusive=2E=2E=2E
>>=20
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
>>=20
>> Specifically, the interface may still take the advantage of remote
>> wakeup in order to wake up the system from sleep if userspace has
>> enabled it as a wakeup source=2E
>
>Hi Rong,
>
>I'm experiencing xHCI hub freezing issues when bringing my AMD Framework
>13 laptop out of suspend mode=2E Sometimes, the wifi controller will
>freeze up, and dmesg will show:

Hmm, it doesn't seem relevant to the issue here, because=2E=2E=2E

>
>[ 7238=2E147897] PM: suspend exit
>[ 7239=2E423823] usb 1-4: reset full-speed USB device number 3 using xhci=
_hcd
>[ 7239=2E692328] usb 1-4: reset full-speed USB device number 3 using xhci=
_hcd
>=2E=2E=2Eand so on=2E=2E=2E

=2E=2E=2Eusb 1-4 means Bus 001 Port 004, which is=2E=2E=2E

>
>Any attempt to access the wireless interface, e=2Eg=2E `ip addr show`, wi=
ll
>hang the system=2E Only a power cycle fixes it=2E
>
>This has only started since 7=2E2-rc1=2E Here's my USB bus tree (1- only)=
:
>
>/:  Bus 001=2EPort 001: Dev 001, Class=3Droot_hub, Driver=3Dxhci_hcd/5p, =
480M
>    ID 1d6b:0002 Linux Foundation 2=2E0 root hub
>    |__ Port 001: Dev 002, 12M
>        ID 32ac:0002 =20
>    |__ Port 004: Dev 003, If 0, Class=3DVendor Specific Class, Driver=3D=
[none], 12M
>        ID 27c6:609c Shenzhen Goodix Technology Co=2E,Ltd=2E=20

=2E=2E=2Eprobably a fingerprint reader module=2E

A USB device reset is not necessarily caused by an xHCI hub failure=2E It'=
s more commonly caused by the (buggy) device itself=2E=20

And it's common to see a USB device reset after a USB autoresume=2E The US=
B core calls it "reset-resume"=2E

Sometimes userspace initiates USB reset via usbfs, so there was also a cha=
nce that fprintd initiated it=2E

>    |__ Port 005: Dev 004, If 0, Class=3DWireless, Driver=3D[none], 480M
>        ID 0e8d:e616 MediaTek Inc=2E=20
>    |__ Port 005: Dev 004, If 1, Class=3DWireless, Driver=3D[none], 480M
>        ID 0e8d:e616 MediaTek Inc=2E=20
>    |__ Port 005: Dev 004, If 2, Class=3DWireless, Driver=3D[none], 480M
>        ID 0e8d:e616 MediaTek Inc=2E
>
>Seeing as I have a MT7922 that is providing both wireless and Bluetooth
>functionality, I'm wondering if I'm hitting this bug also? Perhaps it's
>my fingerprint reader that's the problem, but your description above
>sounds very similar to what I'm seeing=2E

It sounds like a different issue to me=2E

The Bluetooth and WLAN interfaces, though provided by the same NIC, are co=
nnected to different buses=2E The Bluetooth interface connects to the USB b=
us while the WLAN one connects to the PCIe bus=2E

The btusb issue here won't hang the system at all=2E It just renders the B=
luetooth interface unusable until the next power cycle, but the WLAN one st=
ill works totally fine in all reports (as well as on my device)=2E

Based on the symptoms that "the wifi controller will freeze up" and that "=
any attempt to access the wireless interface will hang the system", it's mo=
re likely either a PCIe issue or an NIC one=2E

>
>I have applied your patch, which I thought had fixed the problem, but I
>had a freeze again earlier today after resuming my machine fron standby=
=2E

PCIe issues may be quite random=2E Perhaps you will encounter it after som=
e more time=2E

>
>I keep the bluetooth/btusb/bt* modules blacklisted, but that apparently
>hasn't made a difference=2E

That really sounds like a PCIe issue to me=2E

Could you try if executing `lspci' after triggering the bug freezes or res=
ets the system? Additionally, there may be some helpful information: https:=
//docs=2Ekernel=2Eorg/arch/x86/amd-debugging=2Ehtml

Since it's likely unrelated to the btusb issue here, bugzilla=2Ekernel=2Eo=
rg may be a better place to post your follow-up experiment results=2E

Thanks,
Rong

>
>>=20
>> Fixes: e31d761628ad ("Bluetooth: btmtk: Disable remote wakeup for MT792=
2/MT7925")
>> Signed-off-by: Rong Zhang <i@rong=2Emoe>
>> ---
>> Changes in v2:
>> - Only apply the quirk to to direct children of Ryzen platforms's root
>>   hubs
>>   - Theoretically, we could retrieve the root hub's PCI vendor ID with
>>     some hierarchy magic to further limit the range down to only root
>>     hubs on the SoC or PCH, but that's too intrusive -- the hierarchy
>>     magic really made me nervous once I saw what I have wrote, so I gav=
e
>>     it up
>> - Link to v1: https://patch=2Emsgid=2Elink/20260629-btmtk-ryzen-remote-=
wakeup-v1-1-1d2f1cee6d22@rong=2Emoe
>> ---
>>  drivers/bluetooth/btmtk=2Ec | 10 -------
>>  drivers/bluetooth/btusb=2Ec | 73 +++++++++++++++++++++++++++++++++++++=
+++++++---
>>  2 files changed, 69 insertions(+), 14 deletions(-)
>>=20
>> diff --git a/drivers/bluetooth/btmtk=2Ec b/drivers/bluetooth/btmtk=2Ec
>> index 02a96342e964=2E=2E4614434dd57b 100644
>> --- a/drivers/bluetooth/btmtk=2Ec
>> +++ b/drivers/bluetooth/btmtk=2Ec
>> @@ -1381,16 +1381,6 @@ int btmtk_usb_setup(struct hci_dev *hdev)
>>  		break;
>>  	case 0x7922:
>>  	case 0x7925:
>> -		/*
>> -		 * A remote wakeup could cause the device completely unresponsive, a=
nd
>> -		 * recovering from such a state needs a power cycle=2E
>> -		 *
>> -		 * Since the remote wakeup capability is super broken, just disable =
it
>> -		 * to get rid of the troubles=2E The device can still be autosuspend=
ed
>> -		 * when the bluetooth interface is closed=2E
>> -		 */
>> -		device_set_wakeup_capable(&btmtk_data->udev->dev, false);
>> -		fallthrough;
>>  	case 0x7961:
>>  	case 0x7902:
>>  	case 0x6639:
>> diff --git a/drivers/bluetooth/btusb=2Ec b/drivers/bluetooth/btusb=2Ec
>> index 08c0a99a62c5=2E=2Eeef6e3b43bf9 100644
>> --- a/drivers/bluetooth/btusb=2Ec
>> +++ b/drivers/bluetooth/btusb=2Ec
>> @@ -6,6 +6,7 @@
>>   *  Copyright (C) 2005-2008  Marcel Holtmann <marcel@holtmann=2Eorg>
>>   */
>> =20
>> +#include <linux/cpufeature=2Eh>
>>  #include <linux/dmi=2Eh>
>>  #include <linux/module=2Eh>
>>  #include <linux/usb=2Eh>
>> @@ -957,6 +958,7 @@ struct qca_dump_info {
>>  #define BTUSB_USE_ALT3_FOR_WBS	15
>>  #define BTUSB_ALT6_CONTINUOUS_TX	16
>>  #define BTUSB_HW_SSR_ACTIVE	17
>> +#define BTUSB_WAKEUP_BROKEN	18
>> =20
>>  struct btusb_data {
>>  	struct hci_dev       *hdev;
>> @@ -2936,10 +2938,25 @@ static int btusb_send_frame_mtk(struct hci_dev =
*hdev, struct sk_buff *skb)
>>  	}
>>  }
>> =20
>> +static inline bool platform_is_ryzen(void)
>> +{
>> +#ifdef CONFIG_X86
>> +	return boot_cpu_has(X86_FEATURE_ZEN);
>> +#else
>> +	return false;
>> +#endif
>> +}
>> +
>> +static inline bool is_direct_child_of_root_hub(struct usb_device *udev=
)
>> +{
>> +	return udev->parent =3D=3D udev->bus->root_hub;
>> +}
>> +
>>  static int btusb_mtk_setup(struct hci_dev *hdev)
>>  {
>>  	struct btusb_data *data =3D hci_get_drvdata(hdev);
>>  	struct btmtk_data *btmtk_data =3D hci_get_priv(hdev);
>> +	int err;
>> =20
>>  	/* MediaTek WMT vendor cmd requiring below USB resources to
>>  	 * complete the handshake=2E
>> @@ -2956,7 +2973,40 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>>  		btusb_mtk_claim_iso_intf(data);
>>  	}
>> =20
>> -	return btmtk_usb_setup(hdev);
>> +	err =3D btmtk_usb_setup(hdev);
>> +	if (err)
>> +		return err;
>> +
>> +	switch (btmtk_data->dev_id) {
>> +	case 0x7922:
>> +	case 0x7925:
>> +		/*
>> +		 * All reports seen to be relevant to Ryzen-based laptops=2E These
>> +		 * NICs are usually used as OEM components thanks to some sort
>> +		 * of reference designs=2E
>> +		 *
>> +		 * Their popularity on other platforms is unclear=2E While there
>> +		 * is still a chance that the quirk may exist on other
>> +		 * platforms, be cautious and only apply the quirk to direct
>> +		 * children of Ryzen platforms's root hubs for the time being=2E
>> +		 *
>> +		 * In most cases the root hub is on the SoC or PCH, which needs
>> +		 * the quirk=2E Unfortunately, this can't distinguish root hubs on
>> +		 * PCIe add-in cards=2E Such roughness should be acceptable, as
>> +		 * PCIe USB controller add-in cards are less commonly used
>> +		 * nowadays=2E On the other hand, applying the quirk doesn't hurt
>> +		 * any functionalities either, as the device can still be used
>> +		 * as a wakeup source if desired=2E
>> +		 *
>> +		 * Theoretically, we could retrieve the root hub's PCI vendor ID
>> +		 * with some hierarchy magic, but that's too intrusive=2E=2E=2E
>> +		 */
>> +		if (platform_is_ryzen() && is_direct_child_of_root_hub(data->udev))
>> +			set_bit(BTUSB_WAKEUP_BROKEN, &data->flags);
>> +		break;
>> +	}
>> +
>> +	return 0;
>>  }
>> =20
>>  static int btusb_mtk_shutdown(struct hci_dev *hdev)
>> @@ -4532,11 +4582,26 @@ static int btusb_suspend(struct usb_interface *=
intf, pm_message_t message)
>> =20
>>  	BT_DBG("intf %p", intf);
>> =20
>> -	/* Don't auto-suspend if there are connections or discovery in
>> -	 * progress; external suspend calls shall never fail=2E
>> +	/*
>> +	 * It is reported that remote wakeup events could sometimes cause som=
e
>> +	 * adapters completely unresponsive=2E Resetting the xHCI root hub do=
esn't
>> +	 * help at all, and recovering from such a state needs a power cycle=
=2E
>> +	 * Since disabling remote wakeup simply causes the USB core to gate
>> +	 * runtime autosuspend as well due to needs_remote_wakeup =3D=3D 1, l=
et's do
>> +	 * this ourselves to make our life easier=2E The interface can be saf=
ely
>> +	 * autosuspended as long as remote wakeup is disabled, i=2Ee=2E, afte=
r
>> +	 * closing the HCI device=2E
>> +	 *
>> +	 * Don't auto-suspend if there are connections or discovery in progre=
ss=2E
>> +	 *
>> +	 * External suspend calls shall never fail=2E Specifically, a device =
with
>> +	 * broken remote wakeup may still take the advantage of remote wakeup=
 in
>> +	 * order to wake up the system from sleep if userspace has enabled it=
 as
>> +	 * a wakeup source=2E
>>  	 */
>>  	if (PMSG_IS_AUTO(message) &&
>> -	    (hci_conn_count(data->hdev) || hci_discovery_active(data->hdev)))
>> +	    ((test_bit(BTUSB_WAKEUP_BROKEN, &data->flags) && data->intf->need=
s_remote_wakeup) ||
>> +	     hci_conn_count(data->hdev) || hci_discovery_active(data->hdev)))
>>  		return -EBUSY;
>> =20
>>  	if (data->suspend_count++)
>>=20
>> ---
>> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
>> change-id: 230ba8c9-btmtk-ryzen-remote-wakeup-055a407682ef
>>=20
>> Thanks,
>> Rong
>>=20
