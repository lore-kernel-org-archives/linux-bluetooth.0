Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CC14570F7
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249925; cv=none; b=Be5HoS/CtgBBn6nE6q1ZD9HHWQKlkWCgnGiNyS9yCRvz0UnlKNtf9s+ygY4PrjUUyPo5qSqcEauWtnVnNDmdx/J/tSVPHOk3i5667t/QnwiR4Utvj1wLpy/1dEMFEFphk+pNYocx5exXzdo2Gpd//Wporirbi20nTafPGHE0iH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249925; c=relaxed/simple;
	bh=O+EunIaQuvuAl6mYIdHtaHmtFznc9bUOIDoAFlXeg5s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=cIUbbhVW9scXuWU61u7FHIXTCa52EeFG05KCIy5A0AZ3Q028xxauACbmJ8SoUBuQQ6swX9K02UDLriH9x2sjY/f10+kxdR1z2knkurMaZ3GLi8Ktx4gLsI56MfyN1ZXwEjXg6K0rcYRPruSC5y5UB/BqudjClCtlWH/4sbi6hj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=eZwInGNs; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=jlzYklcQ; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="eZwInGNs";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="jlzYklcQ"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=eZwInGNsa6ReMfcqs8CTGI43ZysY8pZMj1Sidd+d1AfcQ7BHSVl/733uR9lN06EUrJs6OV2z20wJ2ztqJ7S6/DoH0Q6VnZ5kxmwLAYkBzBBZPLmJHmLrsF8Ua3U7QqlZVlcq6K6jjdmK61xNhxjVj+qX0vDaWXclKwSf1QwAjEKSQJ/DwtJfTZgPn66hM8TA6o28Fc2NpLEPIzibPNU9KeLmf0yWpbWIQfxHr0kLkXmVPXVLm3f/DfNdvKSDQm9TR5eR0f3WuqmMJek7nCHnC/QsGQaFSBz7EGJfK2g1gfUCLoDOvqYFX9sXozjSIaCAXmo7FNToUUtrs36k3OhslA==; s=purelymail3; d=rcpassos.me; v=1; bh=O+EunIaQuvuAl6mYIdHtaHmtFznc9bUOIDoAFlXeg5s=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=jlzYklcQXD/DOKtZIA648V4a8hSY2EscTLMzkfsMWamDA0RNShxDdDla6ILuZtDLkOKwbpOICG2Ke06cQnEh/6/XIazK3s3jvqOfP99O8e4dxfE03zpzbQa16ay80R+iRI7YjX3FzvveUh0fpht2G7ik+Xrsh529fRvwvO23zT81AbajB4ARWAGWgzRACgSGs3swjrMkb/p+JURiSUrYaxunZB1h5lISQwCMm8eyfMsVBfew+PjvZgIOk2wYfRvMo55hloe/quKIl7c1odtb+P1zL3eeIu7W2Q4hGLLTAbfAlQQl5e3IFYBT8FdMBcUiyiDajzBnyKFQwbdnMHd0Nw==; s=purelymail3; d=purelymail.com; v=1; bh=O+EunIaQuvuAl6mYIdHtaHmtFznc9bUOIDoAFlXeg5s=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-bluetooth@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 2061556761;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 28 Jul 2026 14:45:08 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 11:45:03 -0300
Message-Id: <DKAA9VN5E4DS.2U03T6V5HEAAE@rcpassos.me>
Cc: "Luiz Augusto von Dentz" <luiz.von.dentz@intel.com>,
 =?utf-8?b?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>,
 =?utf-8?b?V2lsbC1DWSBMZWUgKOadjuaUv+epjik=?= <Will-CY.Lee@mediatek.com>,
 =?utf-8?b?U1MgV3UgKOW3q+aGsuasoyk=?= <ss.wu@mediatek.com>,
 <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
From: "Rafael Passos" <rafael@rcpassos.me>
To: "Rong Zhang" <i@rong.moe>, "Rafael Passos" <rafael@rcpassos.me>, "Marcel
 Holtmann" <marcel@holtmann.org>, "Luiz Augusto von Dentz"
 <luiz.dentz@gmail.com>, "Matthias Brugger" <matthias.bgg@gmail.com>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] Bluetooth: Properly disable remote wakeup for
 MT7922/MT7925 on Ryzen platform
X-Mailer: aerc 0.21.0
References: <20260701-btmtk-ryzen-remote-wakeup-v2-1-767ac7907472@rong.moe>
 <DJRKO72HWZOI.QJYJUAC45QOJ@rcpassos.me>
 <79D5F3E6-8F40-4422-BB2D-16691E377394@rong.moe>
 <DJRP3YO7Y0WK.20KNRZIMX1CYK@rcpassos.me>
 <F16A2A9A-A43F-45FE-8CC0-44A129360D47@rong.moe>
 <DKA8F33O8HID.2UV2DWTLE6S48@rcpassos.me>
 <133c4858657c55b31affd4bff1cbd68f812de5e1.camel@rong.moe>
In-Reply-To: <133c4858657c55b31affd4bff1cbd68f812de5e1.camel@rong.moe>

Hi Rong,

On Tue Jul 28, 2026 at 11:00 AM -03, Rong Zhang wrote:
>> I believe its a hub connected to the chipset.
>>=20
>> /:  Bus 001.Port 001: Dev 001, Class=3Droot_hub, Driver=3Dxhci_hcd/12p, =
480M
>>     | ...
>>     |__ Port 008: Dev 004, If 0, Class=3DWireless, Driver=3Dbtusb, 480M
>>=20
>> In the block diagram on the manual [1], Key "E" Wifi is tied
>> to the AMD PROM21 CHipset.
>
> Yes, and no.
>
> The block diagram indicates that the NIC card's PCIe interface (note the
> "x1") is connected to the chipset, without any mention of its USB
> interface.
>
> Based on the bus number (001), it's more likely a root hub of the SoC
> instead of the chipset.
>
> You can check the root hub's PCI path with
>
>    realpath /sys/bus/usb/devices/usb1
>
> Then you can cross-check with the PCI topology, i.e., `lspci -tnnnvvv'.

Interesting!

lspci -tnnnvvv
-[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge=
 Root Complex [1022:14d8]
           +-00.2  Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge=
 IOMMU [1022:14d9]
           +-01.0  Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge=
 Dummy Host Bridge [1022:14da]
           +-01.1-[01-03]----00.0-[02-03]----00.0-[03]--+-00.0  Advanced Mi=
cro Devices, Inc. [AMD/ATI] Navi 21 [Radeon RX 6800/6800 XT / 6900 XT] [100=
2:73bf]
           |                                            \-00.1  Advanced Mi=
cro Devices, Inc. [AMD/ATI] Navi 21/23 HDMI/DP Audio Controller [1002:ab28]
           +-02.0  Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge=
 Dummy Host Bridge [1022:14da]
           +-02.1-[04-0e]----00.0-[05-0e]--+-00.0-[06]--
           |                               +-02.0-[07]----00.0  MEDIATEK Co=
rp. MT7925 (RZ717) Wi-Fi 7 160MHz [14c3:0717]
           |                               +-03.0-[08]----00.0  Realtek Sem=
iconductor Co., Ltd. RTL8125 2.5GbE Controller [10ec:8125]
           ...


realpath /sys/bus/usb/devices/usb1
/sys/devices/pci0000:00/0000:00:02.1/0000:04:00.0/0000:05:0c.0/0000:0d:00.0=
/usb1
                ------               --------------------
                /                    |
        This matches the             \--and this matches the chain before
        root complex                    the MT7925.

Am I on the right path ?

>> It is integrated (soldered) to my motherboard.
>
> Huh? How can an M.2 "Key E WiFi" expansion card being soldered to a
> "vertical M.2 socket"?
>
> AFAIK, once the metal shield(s) are unscrewed, it should be replaceable,
> see
> https://www.techpowerup.com/review/asrock-b850-steel-legend-wi-fi/4.html
>
> But it doesn't matter anyway since the issue has gone ;-)

Oh ! Its vertical ! You nailed it!
I assumed it was soldered because there was no space there for a
horizontal layout (and I didnt try unscrewing it). Neat!

Thanks,
Rafael Passos

