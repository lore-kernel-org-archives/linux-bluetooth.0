Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187D730F938;
	Fri, 24 Jul 2026 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902081; cv=pass; b=A5KXabKPif4b402zupqupcw3yiOA6/2jDd9OeOcIKNOD27+ZlVeV+lTgxzPDEr/Jxi0F6L5Uc94/4kpDjEOphsWeUkSiQ+om+XVNFv3AywmqvfMgjRw9ZZ5X1vbPSkt7CMR0zGqVzWIX7xnS4MiYQQMuqNFRzXfMVPb9oLeAUqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902081; c=relaxed/simple;
	bh=3S4U6ZW7AMrGi/JfwXVjPdzx3BDVGxmPNhp0iElxeas=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=p6zGgiVkrr0zFNrdATTZYwOabiv8q9LPN4SOAx6SUvqANNhvg23tMEyCexybwXPYek/J7qBoVFqY7Af6dPRUYnNNp+HCCAam9dqkpVewWLgJ5QgMk9v2atoxKgC+lM78qxDE8xueKVikpnEgs5kq0J1g9GBYYTIsJgoPj5Dj5aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=LJo2ugI7; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="LJo2ugI7"
ARC-Seal: i=1; a=rsa-sha256; t=1784902059; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YKvJmuuAoiYlBaxvhEp+AIxUD1Lgaf65i8HpSRN7YwpSQ1FyVwT3nsBQAlG1JVzTwS97qH3APwDFvVi4TFSs2mlrATsnQW3GMC3J4IzwVtEpSysgPDxbDdp6JBDC7XNiWz+tIbIRgL4uoRBkH6eEccgZ1rWO7WBdkZ01oZGjJK0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784902059; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iu4wbxqcLom/H/FbY/ZQCfSjh5pOiWuRukV1A4OFUGw=; 
	b=oDWcVVXYzuJBund12Wl4th9yRd5rhtjPkX647VVpAWyDoTz56h25c+SGmvXza9iCVHxs03zOkISeGRYLTcPlvQcWoRnl1xkwOmkM9LGlZbXdMOz2drNFFePCcGoNkqkdr/N+eofzjfWgyxGtnLH8ouwZxukc7Pvza1/dWk2P8x8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784902059;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=iu4wbxqcLom/H/FbY/ZQCfSjh5pOiWuRukV1A4OFUGw=;
	b=LJo2ugI7swLgCIK/MgQzPWPaMq1e8HAbr8ehn351BUV/OCheVqdWERuKMDrS0lh/
	ksepgqVn+uj6hzdgunXv0diL3XI1jADwghpdWiHlccXKKA5WiWO8AuCxaTW5GhHbzhf
	HY499wyPGqxIWuK7e3BkxCKCDekbHXqKQzfzSk9avoJ+nnuBQA65/QgKtGsn2CL6NGa
	T13icpYNjypx1SG3G1NqVwhMmGUJ4a6vQrtlEBuvxg17RL0pivTSH4FTqCG0bVjDmuT
	1+FQjh85ZO2DTaZ/RjyYg8KNrQvrifB2Aeqz3/9BzLmrcSc/Wct9keOY4e9jWKfXdbL
	5R+x7pbD3g==
Received: by mx.zohomail.com with SMTPS id 1784902056495308.9712137744291;
	Fri, 24 Jul 2026 07:07:36 -0700 (PDT)
Message-ID: <2d5c6e301b4979caa16342f9b0e9c88f5926f9c3.camel@rong.moe>
Subject: Re: [PATCH v2] Bluetooth: Properly disable remote wakeup for
 MT7922/MT7925 on Ryzen platform
From: Rong Zhang <i@rong.moe>
To: Chris Lu =?Big5?Q?=28=B3=B0=B8X=AAl=29?= <Chris.Lu@mediatek.com>, 
 "luiz.dentz@gmail.com"	 <luiz.dentz@gmail.com>, "luiz.von.dentz@intel.com"
 <luiz.von.dentz@intel.com>
Cc: Will-CY Lee =?Big5?Q?=28=A7=F5=ACF=BFo=29?= <Will-CY.Lee@mediatek.com>,
  "marcel@holtmann.org"	 <marcel@holtmann.org>, AngeloGioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>, SS Wu
 =?Big5?Q?=28=A7=C5=BE=CB=AAY=29?=	 <ss.wu@mediatek.com>,
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"	
 <linux-arm-kernel@lists.infradead.org>, "linux-bluetooth@vger.kernel.org"	
 <linux-bluetooth@vger.kernel.org>, "matthias.bgg@gmail.com"	
 <matthias.bgg@gmail.com>, "linux-mediatek@lists.infradead.org"	
 <linux-mediatek@lists.infradead.org>
In-Reply-To: <9f0eae65e94ab8296bef2e663854f6bc7f150d70.camel@mediatek.com>
References: <20260701-btmtk-ryzen-remote-wakeup-v2-1-767ac7907472@rong.moe>
		 <b1ad06c9585707688445c11d47067580fc17c8b8.camel@rong.moe>
	 <9f0eae65e94ab8296bef2e663854f6bc7f150d70.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 22:07:11 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10 
X-ZohoMailClient: External

Hi Chris,

Thanks for your reply.

On Fri, 2026-07-24 at 09:54 +0000, Chris Lu (=E9=99=B8=E7=A8=9A=E6=B3=93) w=
rote:
> Hi Rong,
>=20
> Sorry for not getting back you sooner,
> MediaTek BT team is currently looking for an AMD platform that can
> reproduce this issue, but we haven't found a environment which has
> similar problem.

FYI, the buggy devices I have are

- ThinkBook 14 G7+ ASP
  - SoC: AMD Ryzen AI 9 H 365 w/ Radeon 880M
  - PCI: 62:00.0 Network controller [0280]: MEDIATEK Corp. MT7925 802.11be =
160MHz 2x2 PCIe Wireless Network Adapter [Filogic 360] [14c3:7925] Subsyste=
m: Lenovo Device [17aa:e0ff]
  - USB: Bus 003 Device 004: ID 0489:e111 Foxconn / Hon Hai Wireless_Device

- Beelink GTR 9 Pro
  - SoC: AMD RYZEN AI MAX+ 395 w/ Radeon 8060S
  - PCI: c1:00.0 Network controller [0280]: MEDIATEK Corp. MT7925 802.11be =
160MHz 2x2 PCIe Wireless Network Adapter [Filogic 360] [14c3:7925] Subsyste=
m: AzureWave Device [1a3b:6002]
  - USB: Bus 003 Device 004: ID 13d3:3604 IMC Networks Wireless_Device

I can easily reproduce the issue in the office, but rarely at home. So I
guess it must be some sort of Bluetooth device triggering the issue. I
can't determine what device it is as many colleagues in the office have
their Bluetooth devices.

>=20
> About the patch, LGTM.

Could you kindly reply with a Reviewed-by: or Acked-by: tag? It's the
standard way to say "LGTM" and helps the review process.

> Your change can limit setting wakeup up capable to false to platform
> with X86_FEATURE_ZEN. I also tried this patch locally with Arm-based
> platform and it successfully avoids the issue of incorrectly disable BT
> wakeup.

Thanks for testing. I would also appreciate a Tested-by: tag indicating
that it correctly fixes the wakeup issue introduced in my previous patch.

Thanks a lot,
Rong

>=20
> Thanks,
> Chris Lu
>=20
> On Thu, 2026-07-23 at 21:38 +0800, Rong Zhang wrote:
> >=20
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >=20
> >=20
> > Hi Luiz, Chris,
> >=20
> > Could you kindly take a look at the patch?
> >=20
> > Thanks,
> > Rong
> >=20
> > On Wed, 2026-07-01 at 23:43 +0800, Rong Zhang wrote:
> > > It is reported that a remote wakeup could cause MT7922/MT7925's
> > > btusb
> > > interface completely unresponsive. Resetting the xHCI root hub
> > > doesn't
> > > help at all, and recovering from such a state needs a power cycle.
> > >=20
> > > All reports seen to be relevant to Ryzen-based laptops. These NICs
> > > are
> > > usually used as OEM components thanks to some sort of reference
> > > designs.
> > > Their popularity on other platforms is unclear. While there is
> > > still a
> > > chance that the quirk may exist on other platforms, be cautious and
> > > only
> > > apply the quirk to direct children of Ryzen platforms's root hubs
> > > for
> > > the time being. In most cases the root hub is on the SoC or PCH,
> > > which
> > > needs the quirk. Unfortunately, this can't distinguish root hubs on
> > > PCIe
> > > add-in cards. Such roughness should be acceptable, as PCIe USB
> > > controller add-in cards are less commonly used nowadays. On the
> > > other
> > > hand, applying the quirk doesn't hurt any functionalities either,
> > > as the
> > > device can still be used as a wakeup source if desired.
> > > Theoretically,
> > > we could retrieve the root hub's PCI vendor ID with some hierarchy
> > > magic, but that's too intrusive...
> > >=20
> > > Meanwhile, though device_set_wakeup_capable(false) is the correct
> > > fix
> > > for other NICs with fake remote wakeup capabilities, doing so for
> > > MT7922/MT7925 effectively prevents it from being used as wakeup
> > > sources as per userspace requests. Hence, return -EBUSY on runtime
> > > suspend to prevent the interface from being autosuspended while
> > > it's
> > > still opened, which has the same effect as
> > > device_set_wakeup_capable(false), since disabling remote wakeup
> > > simply
> > > causes the USB core to gate runtime autosuspend as well due to
> > > needs_remote_wakeup =3D=3D 1. The interface can be safely autosuspend=
ed
> > > as
> > > long as remote wakeup is disabled, i.e., after closing the HCI
> > > device.
> > >=20
> > > Specifically, the interface may still take the advantage of remote
> > > wakeup in order to wake up the system from sleep if userspace has
> > > enabled it as a wakeup source.
> > >=20
> > > Fixes: e31d761628ad ("Bluetooth: btmtk: Disable remote wakeup for
> > > MT7922/MT7925")
> > > Signed-off-by: Rong Zhang <i@rong.moe>
> > > ---
> > > Changes in v2:
> > > - Only apply the quirk to to direct children of Ryzen platforms's
> > > root
> > > =C2=A0 hubs
> > > =C2=A0 - Theoretically, we could retrieve the root hub's PCI vendor I=
D
> > > with
> > > =C2=A0=C2=A0=C2=A0 some hierarchy magic to further limit the range do=
wn to only
> > > root
> > > =C2=A0=C2=A0=C2=A0 hubs on the SoC or PCH, but that's too intrusive -=
- the
> > > hierarchy
> > > =C2=A0=C2=A0=C2=A0 magic really made me nervous once I saw what I hav=
e wrote, so I
> > > gave
> > > =C2=A0=C2=A0=C2=A0 it up
> > > - Link to v1:
> > > https://urldefense.com/v3/__https://patch.msgid.link/20260629-btmtk-r=
yzen-remote-wakeup-v1-1-1d2f1cee6d22@rong.moe__;!!CTRNKA9wMg0ARbw!iS1xt56ho=
l42azIYmHUZP_NI-N6WX6yn7_A1lf72MMvo1ZG_CNJRRSLgAbMx_AWK4kGyC2yBMQ$
> > > ---
> > > =C2=A0drivers/bluetooth/btmtk.c | 10 -------
> > > =C2=A0drivers/bluetooth/btusb.c | 73
> > > ++++++++++++++++++++++++++++++++++++++++++++---
> > > =C2=A02 files changed, 69 insertions(+), 14 deletions(-)
> > >=20
> > > diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> > > index 02a96342e964..4614434dd57b 100644
> > > --- a/drivers/bluetooth/btmtk.c
> > > +++ b/drivers/bluetooth/btmtk.c
> > > @@ -1381,16 +1381,6 @@ int btmtk_usb_setup(struct hci_dev *hdev)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 break;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0x7922:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0x7925:
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /*
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * A remote wakeup could cause the device completely
> > > unresponsive, and
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * recovering from such a state needs a power cycle.
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 *
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * Since the remote wakeup capability is super
> > > broken, just disable it
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * to get rid of the troubles. The device can still
> > > be autosuspended
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * when the bluetooth interface is closed.
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 device_set_wakeup_capable(&btmtk_data->udev->dev,
> > > false);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fallthrough;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0x7961:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0x7902:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0x6639:
> > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > > index 08c0a99a62c5..eef6e3b43bf9 100644
> > > --- a/drivers/bluetooth/btusb.c
> > > +++ b/drivers/bluetooth/btusb.c
> > > @@ -6,6 +6,7 @@
> > > =C2=A0 *=C2=A0 Copyright (C) 2005-2008=C2=A0 Marcel Holtmann <marcel@=
holtmann.org>
> > > =C2=A0 */
> > >=20
> > > +#include <linux/cpufeature.h>
> > > =C2=A0#include <linux/dmi.h>
> > > =C2=A0#include <linux/module.h>
> > > =C2=A0#include <linux/usb.h>
> > > @@ -957,6 +958,7 @@ struct qca_dump_info {
> > > =C2=A0#define BTUSB_USE_ALT3_FOR_WBS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 15
> > > =C2=A0#define BTUSB_ALT6_CONTINUOUS_TX=C2=A0=C2=A0=C2=A0=C2=A0 16
> > > =C2=A0#define BTUSB_HW_SSR_ACTIVE=C2=A0 17
> > > +#define BTUSB_WAKEUP_BROKEN=C2=A0 18
> > >=20
> > > =C2=A0struct btusb_data {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hci_dev=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 *hdev;
> > > @@ -2936,10 +2938,25 @@ static int btusb_send_frame_mtk(struct
> > > hci_dev *hdev, struct sk_buff *skb)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0}
> > >=20
> > > +static inline bool platform_is_ryzen(void)
> > > +{
> > > +#ifdef CONFIG_X86
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return boot_cpu_has(X86_FEATURE_ZEN);
> > > +#else
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> > > +#endif
> > > +}
> > > +
> > > +static inline bool is_direct_child_of_root_hub(struct usb_device
> > > *udev)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return udev->parent =3D=3D udev->bus->root_=
hub;
> > > +}
> > > +
> > > =C2=A0static int btusb_mtk_setup(struct hci_dev *hdev)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btusb_data *data =3D hci_get_dr=
vdata(hdev);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btmtk_data *btmtk_data =3D hci_=
get_priv(hdev);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 int err;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* MediaTek WMT vendor cmd requiring b=
elow USB resources to
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * complete the handshake.
> > > @@ -2956,7 +2973,40 @@ static int btusb_mtk_setup(struct hci_dev
> > > *hdev)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 btusb_mtk_claim_iso_intf(data);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 return btmtk_usb_setup(hdev);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 err =3D btmtk_usb_setup(hdev);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return err;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 switch (btmtk_data->dev_id) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 case 0x7922:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 case 0x7925:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * All reports seen to be relevant to Ryzen-based
> > > laptops. These
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * NICs are usually used as OEM components thanks to
> > > some sort
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * of reference designs.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 *
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * Their popularity on other platforms is unclear.
> > > While there
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * is still a chance that the quirk may exist on
> > > other
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * platforms, be cautious and only apply the quirk to
> > > direct
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * children of Ryzen platforms's root hubs for the
> > > time being.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 *
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * In most cases the root hub is on the SoC or PCH,
> > > which needs
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * the quirk. Unfortunately, this can't distinguish
> > > root hubs on
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * PCIe add-in cards. Such roughness should be
> > > acceptable, as
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * PCIe USB controller add-in cards are less commonly
> > > used
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * nowadays. On the other hand, applying the quirk
> > > doesn't hurt
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * any functionalities either, as the device can
> > > still be used
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * as a wakeup source if desired.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 *
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * Theoretically, we could retrieve the root hub's
> > > PCI vendor ID
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * with some hierarchy magic, but that's too
> > > intrusive...
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (platform_is_ryzen() &&
> > > is_direct_child_of_root_hub(data->udev))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(BTUSB_WAKEUP=
_BROKEN, &data->flags);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > =C2=A0}
> > >=20
> > > =C2=A0static int btusb_mtk_shutdown(struct hci_dev *hdev)
> > > @@ -4532,11 +4582,26 @@ static int btusb_suspend(struct
> > > usb_interface *intf, pm_message_t message)
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BT_DBG("intf %p", intf);
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 /* Don't auto-suspend if there are connecti=
ons or discovery
> > > in
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * progress; external suspend calls sh=
all never fail.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * It is reported that remote wakeup e=
vents could sometimes
> > > cause some
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * adapters completely unresponsive. R=
esetting the xHCI root
> > > hub doesn't
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * help at all, and recovering from su=
ch a state needs a
> > > power cycle.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Since disabling remote wakeup simpl=
y causes the USB core
> > > to gate
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * runtime autosuspend as well due to =
needs_remote_wakeup =3D=3D
> > > 1, let's do
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * this ourselves to make our life eas=
ier. The interface can
> > > be safely
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * autosuspended as long as remote wak=
eup is disabled, i.e.,
> > > after
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * closing the HCI device.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Don't auto-suspend if there are con=
nections or discovery
> > > in progress.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * External suspend calls shall never =
fail. Specifically, a
> > > device with
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * broken remote wakeup may still take=
 the advantage of
> > > remote wakeup in
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * order to wake up the system from sl=
eep if userspace has
> > > enabled it as
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * a wakeup source.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (PMSG_IS_AUTO(message) &&
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (hci_conn_count(dat=
a->hdev) || hci_discovery_active(data-
> > > > hdev)))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((test_bit(BTUSB_WA=
KEUP_BROKEN, &data->flags) && data-
> > > > intf->needs_remote_wakeup) ||
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hci_conn_coun=
t(data->hdev) || hci_discovery_active(data-
> > > > hdev)))
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return -EBUSY;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (data->suspend_count++)
> > >=20
> > > ---
> > > base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> > > change-id: 230ba8c9-btmtk-ryzen-remote-wakeup-055a407682ef
> > >=20
> > > Thanks,
> > > Rong
