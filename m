Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CD42F619A;
	Mon, 17 Nov 2025 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398132; cv=none; b=cJjE83/GC5rgYoab4li4BT6lxqyp6v/xZylwNM3+S5QFBuoJ4B8jCDvonkc0CK7cZPTY94kW0Fv6YjmMPBT7D4IYCchECnKJ/+3lPgI0Yw0YXktkymo7dLhwPshPbr3L+wRI7fCDBjV3zlZWgHIlD+TQ6irKqv6mGn4Zw7VBq20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398132; c=relaxed/simple;
	bh=BGIJaDC3IsRIVR5JkPelR0lyes11w6zdTP7OAlcbHgU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NOIwXBP7wTuPbp0lOqnh31gayOHJSf6HRgGrnzMNllt49j9ZbwFDyohCM/nSKpxM15wKYxSdF00CdmPG4B/hItTpSymLOELBnXtx4BDyYSwvdxj3OfTziHi0rraFuOCP+qxkFrVAiJ4m/OesUW8nB3NobU0XZq36NNdpaO7Kwtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=yMA2lW4y; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="yMA2lW4y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=otcX3ivF9kAIFCgXfh203cKEmoNr3ZS8vHSsQUu++q8=; t=1763398127;
	x=1763830127; b=yMA2lW4yV3gmKnKcSh9Iz0ZVgYtspKI5li238HhXtU+AU9+ellUwwclwq2zU3
	e8Z5+Ou5Dug7Br5v1H07n1K9XNujXdaPluh3qwwwvaZ/QVEgs+Zhi3DmyvL95Ylpa7Chf8qe63RNY
	sL6nAe3C+xgQoOszrPmhAEMcWSl65ZjV2nGSmVG3o9UaoAdjUM9ExoZNPCTaLcCbZljYiVSsFXAOZ
	1PU4E9hahdkQQQwm+O0u9F/wRWFZLexcmv+sr5j4pbw/umhAXWUCa5yvKJwM5glOYRpmKcQIF1K98
	enhWyHRrDnKZKNOs+GUDXQO4+rwH+WtYWeSi4qQ+vxCUs8OZqg==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1vL2P8-006DD9-25;
	Mon, 17 Nov 2025 17:48:38 +0100
Message-ID: <a380d061-479e-4713-bddd-1d6571ca7e86@leemhuis.info>
Date: Mon, 17 Nov 2025 17:48:38 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Bluetooth adapter provided by `btusb` not recognized
 since v6.13.2
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: incogcyberpunk@proton.me
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "marcel@holtmann.org" <marcel@holtmann.org>,
 "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
 "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
 Douglas Anderson <dianders@chromium.org>, LKML <linux-kernel@vger.kernel.org>
References: <jOB6zqCC3xjlPPJXwPYPb4MxHJOhxVgp380ayP7lYq-aT2iA5D8YCdMeCvq5Cp_ICZmqjpfgX8o9siQdlPu9DY4qgnL_zCjgqP23fXc-P4U=@proton.me>
 <1b59d3c2-1ed0-40df-a3ba-cca2316e866b@leemhuis.info>
 <a03739b9-3a54-4ecb-b55f-6aaa69da3fc6@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <a03739b9-3a54-4ecb-b55f-6aaa69da3fc6@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1763398127;82b022ad;
X-HE-SMSGID: 1vL2P8-006DD9-25

[Ccing Douglas Anderson, who might have an idea]
[dropping stable from To, that is irrelevant there]

On 11/17/25 11:55, Thorsten Leemhuis wrote:
> On 11/17/25 10:42, Thorsten Leemhuis wrote:
>> On 11/17/25 02:30, incogcyberpunk@proton.me wrote:
>>> Distro: Arch Linux=C2=A0
>>> Kernel: since v6.13.2
>> Lo! Thx for the report. It's unlikely that any developer will look int=
o
>> this report[1] as 6.13.y is ancient by kernel development standards an=
d
>> EOL for quite a while.
>>
>> Please check if the latest stable version is still affected; if it is,=

>> ideally try latest mainline (6.18-rc6), too. If that is as well, it
>> would be great if you could bisect between 6.13.1 and 6.13.2.
>=20
> TWIMC, IncogCyberpunk replied in private to me and wrote:
>=20
> """
> Sorry, if I was not clear but, the problem persists in both the stable
> (v6.17.8) and the latest mainline (v6.18-rc6) linux kernels as of Nov 2=
025
> """
>=20
> Please reply in public next time.

IncogCyberpunk sent another reply in private. IncogCyberpunk, please
just use "reply-to-all", I cannot forward each of your replies manually.
Anyway, here it is:

"""
The logs for the 6.18-rc6 mainline kernel are provided below Also, to
make it clear, the regression has been observed in both the stable and
the mainline kernels since the kernel 6.13.2.=20

Logs for v6.18-rc6 kernel:=20
https://pastebin.com/GeAzr56Z
"""

To quote from that:

"""
Nov 17 17:14:30 Incog kernel: BUG: kernel NULL pointer dereference, addre=
ss: 00000000000000d0
Nov 17 17:14:30 Incog kernel: fbcon: Taking over console
Nov 17 17:14:30 Incog kernel: #PF: supervisor write access in kernel mode=

Nov 17 17:14:30 Incog kernel: #PF: error_code(0x0002) - not-present page
Nov 17 17:14:30 Incog kernel: PGD 0 P4D 0=20
Nov 17 17:14:30 Incog kernel: Oops: Oops: 0002 [#1] SMP NOPTI
Nov 17 17:14:30 Incog kernel: CPU: 8 UID: 0 PID: 136 Comm: kworker/u49:0 =
Tainted: G S                  6.18.0-rc6-1-mainline #1 PREEMPT(full)  232=
968b2ab8c223687b1bdd5c39590a8f510b2d3
Nov 17 17:14:30 Incog kernel: Tainted: [S]=3DCPU_OUT_OF_SPEC
Nov 17 17:14:30 Incog kernel: Hardware name: Acer Aspire A315-59/Callisto=
_ADU, BIOS V1.16 08/16/2022
Nov 17 17:14:30 Incog kernel: Workqueue: hci0 hci_power_on [bluetooth]
Nov 17 17:14:30 Incog kernel: RIP: 0010:mutex_lock+0x1c/0x30
Nov 17 17:14:30 Incog kernel: Code: 90 90 90 90 90 90 90 90 90 90 90 90 9=
0 90 f3 0f 1e fa 0f 1f 44 00 00 53 48 89 fb 2e 2e 2e 31 c0 65 48 8b 15 de=
 07 d7 01 31 c0 <f0> 48 0f b1 13 75 06 5b c3 cc cc cc cc 48 89 df 5b eb b=
1 90 90 90
Nov 17 17:14:30 Incog kernel: RSP: 0018:ffffcf12807fbd88 EFLAGS: 00010246=

Nov 17 17:14:30 Incog kernel: RAX: 0000000000000000 RBX: 00000000000000d0=
 RCX: 0000000000000001
Nov 17 17:14:30 Incog kernel: RDX: ffff8c88c61f0000 RSI: 0000000000000002=
 RDI: 00000000000000d0
Nov 17 17:14:30 Incog kernel: RBP: ffff8c88c7a20028 R08: 0000000000000000=
 R09: 0000000000000010
Nov 17 17:14:30 Incog kernel: R10: 0000000000000000 R11: 0000000000000404=
 R12: ffff8c88c9fb4000
Nov 17 17:14:30 Incog kernel: R13: ffff8c88c61c1a05 R14: 0000000000000000=
 R15: ffff8c88c9fb4408
Nov 17 17:14:30 Incog kernel: FS:  0000000000000000(0000) GS:ffff8c8cd8f0=
2000(0000) knlGS:0000000000000000
Nov 17 17:14:30 Incog kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
Nov 17 17:14:30 Incog kernel: CR2: 00000000000000d0 CR3: 000000010b106000=
 CR4: 0000000000f50ef0
Nov 17 17:14:30 Incog kernel: PKRU: 55555554
Nov 17 17:14:30 Incog kernel: Call Trace:
Nov 17 17:14:30 Incog kernel:  <TASK>
Nov 17 17:14:30 Incog kernel:  btusb_mtk_setup+0xa0/0x1a0 [btusb 3ead27e0=
9a395fe31ca20705f760e78aab4d59d8]
Nov 17 17:14:30 Incog kernel:  hci_dev_open_sync+0x102/0xb80 [bluetooth e=
25d49b4e9236169faf4970d9c81deaa8aed0e62]
Nov 17 17:14:30 Incog kernel:  ? try_to_wake_up+0x35b/0x840
Nov 17 17:14:30 Incog kernel:  hci_dev_do_open+0x23/0x60 [bluetooth e25d4=
9b4e9236169faf4970d9c81deaa8aed0e62]
Nov 17 17:14:30 Incog kernel:  hci_power_on+0x4d/0x250 [bluetooth e25d49b=
4e9236169faf4970d9c81deaa8aed0e62]
Nov 17 17:14:30 Incog kernel:  process_one_work+0x193/0x350
Nov 17 17:14:30 Incog kernel:  worker_thread+0x2d7/0x410
Nov 17 17:14:30 Incog kernel:  ? __pfx_worker_thread+0x10/0x10
Nov 17 17:14:30 Incog kernel:  kthread+0xfc/0x240
Nov 17 17:14:30 Incog kernel:  ? __pfx_kthread+0x10/0x10
Nov 17 17:14:30 Incog kernel:  ? __pfx_kthread+0x10/0x10
Nov 17 17:14:30 Incog kernel:  ret_from_fork+0x1c2/0x1f0
Nov 17 17:14:30 Incog kernel:  ? __pfx_kthread+0x10/0x10
Nov 17 17:14:30 Incog kernel:  ret_from_fork_asm+0x1a/0x30
Nov 17 17:14:30 Incog kernel:  </TASK>
Nov 17 17:14:30 Incog kernel: Modules linked in: btusb intel_rapl_msr uvc=
video ghash_clmulni_intel snd_pcm_dmaengine processor_thermal_rfim iTCO_w=
dt mt76 btmtk processor_thermal_rapl videobuf2_vmalloc intel_pmc_bxt snd_=
pcm aesni_intel mei_pxp btrtl mei_hdcp iTCO_vendor_support ee1004 intel_r=
apl_common btbcm uvc rapl snd_timer videobuf2_memops btintel intel_cstate=
 processor_thermal_wt_req mac80211 hid_multitouch(+) i2c_i801 spi_nor mei=
_me videobuf2_v4l2 acer_wmi snd i2c_smbus processor_thermal_power_floor b=
luetooth intel_uncore mtd videobuf2_common pcspkr wmi_bmof platform_profi=
le libarc4 soundcore i2c_mux mei thunderbolt(+) processor_thermal_mbox ig=
en6_edac intel_oc_wdt ov13858 i2c_hid_acpi v4l2_fwnode int3403_thermal in=
t340x_thermal_zone v4l2_async i2c_hid intel_pmc_core videodev pmt_telemet=
ry mc pmt_discovery intel_hid int3400_thermal pmt_class pinctrl_tigerlake=
 acpi_thermal_rel sparse_keymap mousedev acpi_pad intel_pmc_ssram_telemet=
ry joydev acer_wireless mac_hid cfg80211 rfkill usblp pkcs8_key_parser cr=
ypto_user ntsync dm_mod loop
Nov 17 17:14:30 Incog kernel:  nfnetlink ip_tables x_tables xe intel_vsec=
 drm_ttm_helper drm_suballoc_helper gpu_sched nvme drm_gpuvm nvme_core nv=
me_keyring drm_exec nvme_auth hkdf drm_gpusvm_helper i915 i2c_algo_bit dr=
m_buddy ttm serio_raw video intel_gtt spi_intel_pci intel_lpss_pci drm_di=
splay_helper intel_lpss spi_intel wmi vmd cec idma64
Nov 17 17:14:30 Incog kernel: CR2: 00000000000000d0
Nov 17 17:14:30 Incog kernel: ---[ end trace 0000000000000000 ]---
Nov 17 17:14:30 Incog kernel: RIP: 0010:mutex_lock+0x1c/0x30
Nov 17 17:14:30 Incog kernel: Code: 90 90 90 90 90 90 90 90 90 90 90 90 9=
0 90 f3 0f 1e fa 0f 1f 44 00 00 53 48 89 fb 2e 2e 2e 31 c0 65 48 8b 15 de=
 07 d7 01 31 c0 <f0> 48 0f b1 13 75 06 5b c3 cc cc cc cc 48 89 df 5b eb b=
1 90 90 90
Nov 17 17:14:30 Incog kernel: RSP: 0018:ffffcf12807fbd88 EFLAGS: 00010246=

Nov 17 17:14:30 Incog kernel: RAX: 0000000000000000 RBX: 00000000000000d0=
 RCX: 0000000000000001
Nov 17 17:14:30 Incog kernel: RDX: ffff8c88c61f0000 RSI: 0000000000000002=
 RDI: 00000000000000d0
Nov 17 17:14:30 Incog kernel: RBP: ffff8c88c7a20028 R08: 0000000000000000=
 R09: 0000000000000010
Nov 17 17:14:30 Incog kernel: R10: 0000000000000000 R11: 0000000000000404=
 R12: ffff8c88c9fb4000
Nov 17 17:14:30 Incog kernel: R13: ffff8c88c61c1a05 R14: 0000000000000000=
 R15: ffff8c88c9fb4408
Nov 17 17:14:30 Incog kernel: FS:  0000000000000000(0000) GS:ffff8c8cd8f0=
2000(0000) knlGS:0000000000000000
Nov 17 17:14:30 Incog kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
Nov 17 17:14:30 Incog kernel: CR2: 00000000000000d0 CR3: 000000010b106000=
 CR4: 0000000000f50ef0
Nov 17 17:14:30 Incog kernel: PKRU: 55555554
Nov 17 17:14:30 Incog kernel: note: kworker/u49:0[136] exited with irqs d=
isabled
"""

A very quick a rough search on lore made me wonder if e9087e828827e5
("Bluetooth: btusb: mediatek: Add locks for usb_driver_claim_interface()"=
)
from Douglas might be the culprit, which was indeed added to 6.13.2:
https://lore.kernel.org/all/20250205134516.957708847@linuxfoundation.org/=


IncogCyberpunk, you might want to try if reverting that one helps.

Ciao, Thorsten

> And no problem, but quite a few people
> write "since v6.13.2" and only mean later 6.13 versions, that's why I a=
sked.
>=20
> You might want to provide the logs from 6.18-rc6. Then feel free to wai=
t
> two or three days to see if a developer replies. If not, please bisect
> the problem between 6.13.1 and 6.13.2 =E2=80=93 and then try if reverti=
ng the
> culprit in mainline fixes the problem (if it's possible to revert it
> there easily). For details, see:
> https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.=
html
>=20
> HTH, ciao, Thorsten
>=20
>>> The bluetooth adapter would be recognized and the bluetooth worked
>>> flawlessly till v6.13.1 , but since the v6.13.2 , the bluetooth adapt=
er
>>> doesn't get recognized by the bluetooth service and therefore the
>>> bluetooth functionality doesn't work .=C2=A0
>>>
>>> I suspect the bluetooth's driver failing to load at the kernel-level.=
=C2=A0
>>>
>>>   * The output of |bluetoothctl|=E2=80=8B :
>>>
>>> $: bluetoothctl
>>> Agent registered
>>> [bluetoothctl]> list
>>> [bluetoothctl]> devices
>>> No default controller available
>>> [bluetoothctl]>
>>>
>>>   * The output of |systemctl status bluetooth.service|=E2=80=8B :
>>>
>>> =E2=97=8F bluetooth.service - Bluetooth service
>>> =C2=A0 =C2=A0 =C2=A0Loaded: loaded (/usr/lib/systemd/system/bluetooth=
=2Eservice; enabled;
>>> preset: disabled)
>>> =C2=A0 =C2=A0 =C2=A0Active: active (running) since Sat 2025-11-15 22:=
57:00 +0545; 1 day
>>> 8h ago
>>> =C2=A0Invocation: bddf190655fd4a4290d41cde594f2efaNov 17 17:14:30 Inc=
og kernel: BUG: kernel NULL pointer dereference, address: 00000000000000d=
0
Nov 17 17:14:30 Incog kernel: fbcon: Taking over console
Nov 17 17:14:30 Incog kernel: #PF: supervisor write access in kernel mode=

Nov 17 17:14:30 Incog kernel: #PF: error_code(0x0002) - not-present page
Nov 17 17:14:30 Incog kernel: PGD 0 P4D 0=20
Nov 17 17:14:30 Incog kernel: Oops: Oops: 0002 [#1] SMP NOPTI
Nov 17 17:14:30 Incog kernel: CPU: 8 UID: 0 PID: 136 Comm: kworker/u49:0 =
Tainted: G S                  6.18.0-rc6-1-mainline #1 PREEMPT(full)  232=
968b2ab8c223687b1bdd5c39590a8f510b2d3
Nov 17 17:14:30 Incog kernel: Tainted: [S]=3DCPU_OUT_OF_SPEC
Nov 17 17:14:30 Incog kernel: Hardware name: Acer Aspire A315-59/Callisto=
_ADU, BIOS V1.16 08/16/2022
Nov 17 17:14:30 Incog kernel: Workqueue: hci0 hci_power_on [bluetooth]
Nov 17 17:14:30 Incog kernel: RIP: 0010:mutex_lock+0x1c/0x30
Nov 17 17:14:30 Incog kernel: Code: 90 90 90 90 90 90 90 90 90 90 90 90 9=
0 90 f3 0f 1e fa 0f 1f 44 00 00 53 48 89 fb 2e 2e 2e 31 c0 65 48 8b 15 de=
 07 d7 01 31 c0 <f0> 48 0f b1 13 75 06 5b c3 cc cc cc cc 48 89 df 5b eb b=
1 90 90 90
Nov 17 17:14:30 Incog kernel: RSP: 0018:ffffcf12807fbd88 EFLAGS: 00010246=

Nov 17 17:14:30 Incog kernel: RAX: 0000000000000000 RBX: 00000000000000d0=
 RCX: 0000000000000001
Nov 17 17:14:30 Incog kernel: RDX: ffff8c88c61f0000 RSI: 0000000000000002=
 RDI: 00000000000000d0
Nov 17 17:14:30 Incog kernel: RBP: ffff8c88c7a20028 R08: 0000000000000000=
 R09: 0000000000000010
Nov 17 17:14:30 Incog kernel: R10: 0000000000000000 R11: 0000000000000404=
 R12: ffff8c88c9fb4000
Nov 17 17:14:30 Incog kernel: R13: ffff8c88c61c1a05 R14: 0000000000000000=
 R15: ffff8c88c9fb4408
Nov 17 17:14:30 Incog kernel: FS:  0000000000000000(0000) GS:ffff8c8cd8f0=
2000(0000) knlGS:0000000000000000
Nov 17 17:14:30 Incog kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
Nov 17 17:14:30 Incog kernel: CR2: 00000000000000d0 CR3: 000000010b106000=
 CR4: 0000000000f50ef0
Nov 17 17:14:30 Incog kernel: PKRU: 55555554
Nov 17 17:14:30 Incog kernel: Call Trace:
Nov 17 17:14:30 Incog kernel:  <TASK>
Nov 17 17:14:30 Incog kernel:  btusb_mtk_setup+0xa0/0x1a0 [btusb 3ead27e0=
9a395fe31ca20705f760e78aab4d59d8]
Nov 17 17:14:30 Incog kernel:  hci_dev_open_sync+0x102/0xb80 [bluetooth e=
25d49b4e9236169faf4970d9c81deaa8aed0e62]
Nov 17 17:14:30 Incog kernel:  ? try_to_wake_up+0x35b/0x840
Nov 17 17:14:30 Incog kernel:  hci_dev_do_open+0x23/0x60 [bluetooth e25d4=
9b4e9236169faf4970d9c81deaa8aed0e62]
Nov 17 17:14:30 Incog kernel:  hci_power_on+0x4d/0x250 [bluetooth e25d49b=
4e9236169faf4970d9c81deaa8aed0e62]
Nov 17 17:14:30 Incog kernel:  process_one_work+0x193/0x350
Nov 17 17:14:30 Incog kernel:  worker_thread+0x2d7/0x410
Nov 17 17:14:30 Incog kernel:  ? __pfx_worker_thread+0x10/0x10
Nov 17 17:14:30 Incog kernel:  kthread+0xfc/0x240
Nov 17 17:14:30 Incog kernel:  ? __pfx_kthread+0x10/0x10
Nov 17 17:14:30 Incog kernel:  ? __pfx_kthread+0x10/0x10
Nov 17 17:14:30 Incog kernel:  ret_from_fork+0x1c2/0x1f0
Nov 17 17:14:30 Incog kernel:  ? __pfx_kthread+0x10/0x10
Nov 17 17:14:30 Incog kernel:  ret_from_fork_asm+0x1a/0x30
Nov 17 17:14:30 Incog kernel:  </TASK>
Nov 17 17:14:30 Incog kernel: Modules linked in: btusb intel_rapl_msr uvc=
video ghash_clmulni_intel snd_pcm_dmaengine processor_thermal_rfim iTCO_w=
dt mt76 btmtk processor_thermal_rapl videobuf2_vmalloc intel_pmc_bxt snd_=
pcm aesni_intel mei_pxp btrtl mei_hdcp iTCO_vendor_support ee1004 intel_r=
apl_common btbcm uvc rapl snd_timer videobuf2_memops btintel intel_cstate=
 processor_thermal_wt_req mac80211 hid_multitouch(+) i2c_i801 spi_nor mei=
_me videobuf2_v4l2 acer_wmi snd i2c_smbus processor_thermal_power_floor b=
luetooth intel_uncore mtd videobuf2_common pcspkr wmi_bmof platform_profi=
le libarc4 soundcore i2c_mux mei thunderbolt(+) processor_thermal_mbox ig=
en6_edac intel_oc_wdt ov13858 i2c_hid_acpi v4l2_fwnode int3403_thermal in=
t340x_thermal_zone v4l2_async i2c_hid intel_pmc_core videodev pmt_telemet=
ry mc pmt_discovery intel_hid int3400_thermal pmt_class pinctrl_tigerlake=
 acpi_thermal_rel sparse_keymap mousedev acpi_pad intel_pmc_ssram_telemet=
ry joydev acer_wireless mac_hid cfg80211 rfkill usblp pkcs8_key_parser cr=
ypto_user ntsync dm_mod loop
Nov 17 17:14:30 Incog kernel:  nfnetlink ip_tables x_tables xe intel_vsec=
 drm_ttm_helper drm_suballoc_helper gpu_sched nvme drm_gpuvm nvme_core nv=
me_keyring drm_exec nvme_auth hkdf drm_gpusvm_helper i915 i2c_algo_bit dr=
m_buddy ttm serio_raw video intel_gtt spi_intel_pci intel_lpss_pci drm_di=
splay_helper intel_lpss spi_intel wmi vmd cec idma64
Nov 17 17:14:30 Incog kernel: CR2: 00000000000000d0
Nov 17 17:14:30 Incog kernel: ---[ end trace 0000000000000000 ]---
Nov 17 17:14:30 Incog kernel: RIP: 0010:mutex_lock+0x1c/0x30
Nov 17 17:14:30 Incog kernel: Code: 90 90 90 90 90 90 90 90 90 90 90 90 9=
0 90 f3 0f 1e fa 0f 1f 44 00 00 53 48 89 fb 2e 2e 2e 31 c0 65 48 8b 15 de=
 07 d7 01 31 c0 <f0> 48 0f b1 13 75 06 5b c3 cc cc cc cc 48 89 df 5b eb b=
1 90 90 90
Nov 17 17:14:30 Incog kernel: RSP: 0018:ffffcf12807fbd88 EFLAGS: 00010246=

Nov 17 17:14:30 Incog kernel: RAX: 0000000000000000 RBX: 00000000000000d0=
 RCX: 0000000000000001
Nov 17 17:14:30 Incog kernel: RDX: ffff8c88c61f0000 RSI: 0000000000000002=
 RDI: 00000000000000d0
Nov 17 17:14:30 Incog kernel: RBP: ffff8c88c7a20028 R08: 0000000000000000=
 R09: 0000000000000010
Nov 17 17:14:30 Incog kernel: R10: 0000000000000000 R11: 0000000000000404=
 R12: ffff8c88c9fb4000
Nov 17 17:14:30 Incog kernel: R13: ffff8c88c61c1a05 R14: 0000000000000000=
 R15: ffff8c88c9fb4408
Nov 17 17:14:30 Incog kernel: FS:  0000000000000000(0000) GS:ffff8c8cd8f0=
2000(0000) knlGS:0000000000000000
Nov 17 17:14:30 Incog kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
Nov 17 17:14:30 Incog kernel: CR2: 00000000000000d0 CR3: 000000010b106000=
 CR4: 0000000000f50ef0
Nov 17 17:14:30 Incog kernel: PKRU: 55555554
Nov 17 17:14:30 Incog kernel: note: kworker/u49:0[136] exited with irqs d=
isabled
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Docs: man:bluetoothd(8)
>>> =C2=A0 =C2=A0Main PID: 617 (bluetoothd)
>>> =C2=A0 =C2=A0 =C2=A0Status: "Running"
>>> =C2=A0 =C2=A0 =C2=A0 Tasks: 1 (limit: 18701)
>>> =C2=A0 =C2=A0 =C2=A0Memory: 2.8M (peak: 3.8M)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPU: 38ms
>>> =C2=A0 =C2=A0 =C2=A0CGroup: /system.slice/bluetooth.service
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E2=94=94=E2=94=80617=
 /usr/lib/bluetooth/bluetoothd
>>>
>>> Nov 15 22:57:00 Incog systemd[1]: Starting Bluetooth service...
>>> Nov 15 22:57:00 Incog bluetoothd[617]: Bluetooth daemon 5.84
>>> Nov 15 22:57:00 Incog systemd[1]: Started Bluetooth service.
>>> Nov 15 22:57:00 Incog bluetoothd[617]: Starting SDP server
>>> Nov 15 22:57:00 Incog bluetoothd[617]: Bluetooth management interface=

>>> 1.23 initialized
>>>
>>>   * The output of |lspci|=E2=80=8B is attached below .=C2=A0
>>>
>>>   * The logs for |journalctl -b|=E2=80=8B for both v6.13.1 and v6.13.=
2 are
>>>     attached below.=C2=A0
>>>
>>>
>>> Regards,
>>> IncogCyberpunk
>>>
>>
>>
>>
>=20
>=20
>=20

