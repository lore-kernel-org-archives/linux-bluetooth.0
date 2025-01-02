Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED237198A36
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jan 2025 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735850338; cv=none; b=gAI37hmLtypXgsnpGns47oIsOYh8xzg3Tul3pytplYXzIaob0S98YMVhWySccvlQW+rwH2KyOU//0HxIVvLJaCxlcbHTxrDTfw0t/vV/IQ+HqJyWTJBqMDm46OyI9T/dcSF9DUs/R8EUALJcxPcaOtGFG0j2s9VNA1t0bJDOWig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735850338; c=relaxed/simple;
	bh=OroWyNNc9dms3nGfT3az8I5uHui9sff3kvsfmZJ4N10=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=dqIFJUlmyK+CJybCDbcTI4U9mMsIdgL65STgMtjDNqjF79Dqo6MCSQFSS3hQwAXFmVjN51HCJgY1Ppz7m49hV8aGjf3JA7vyycT+UTHhSmUXPIZYSarDeUM/gndFKJzYU8F5ohHXO7UBd8y64prGoBnccmBagh8TkGHk6pC5rMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=croquette.de; spf=pass smtp.mailfrom=croquette.de; dkim=pass (2048-bit key) header.d=croquette.de header.i=olivier@croquette.de header.b=aEUqpdRY; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=croquette.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=croquette.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=croquette.de header.i=olivier@croquette.de header.b="aEUqpdRY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=croquette.de;
	s=s1-ionos; t=1735850325; x=1736455125; i=olivier@croquette.de;
	bh=/oAKzoPe6cU3ZSWahOXw0HRGsVQ9BpK1Doo2HwfohKk=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aEUqpdRYQ7FubE1VYkNJHiZQjsJG5WF/7I8iQqr19fKqn093XXmfHJPrL+gI/Hzw
	 op0hzlge9ehfaWveVOjnDoTS5Ymo3wO0W7LrqwiMp6CDkTv+j6fmskErbpszmCm+9
	 7effRKCubyX9UzkO5x/X5mtQJIiJThB+aMGISuRQ/UVmorsoNBc46oeAZW66caY2l
	 c1uR3fI/bYkaWMzZHduZw292PZnQct9kjRksUUCp0m7XjtV5LmSI278J0Ow8RKRe9
	 qGhwPYW5t00cS2BGzwHv/7B+ao6hVS2gP9DvcWPgKkjm5LudUPeeXAqD0m9naZt0O
	 tXBf9cBtCQ99YAa/9w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.200.73] ([82.135.79.74]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M5jA2-1tQg0d0kI6-00BXYJ; Thu, 02 Jan 2025 21:38:45 +0100
Message-ID: <073c3b772abe84d480913495eea0c4da73607d6e.camel@croquette.de>
Subject: Black screen after standby, Oops in bt subsystem
From: Olivier Croquette <olivier@croquette.de>
To: linux-bluetooth@vger.kernel.org
Cc: "chris.lu" <chris.lu@mediatek.com>
Date: Thu, 02 Jan 2025 21:38:44 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:USqDPlU396i6GFTd2JTtHV0ra0+otFX2P8W5OKEaq26Islh2kBj
 ycifz2c8hNOTVhwVRXN81gXAZrrwBay/RHTUu2MJoJkyL8kIrq/jsu7+daCDQqAUt59itae
 7IyTf5zLxZD8ZenfegAHtpJd3yUExdXp3wTVQtIZ9E16npZ3ci7PyX1yI0ox+HSTZ7iVeB8
 JIqPzNO5X9JbBg+/SIWKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w+VxTjDqdqo=;T9qwRlWTAudWexDUcwa/AKZE+Iw
 fID6Fj10YcxAsn9Hh+cDbQ8T8kToOTlMw/WEGo0Quy7//LqtM9wqF3Ca5c+9buJHA0gADlVqJ
 YUo/dS75Qho+UPbsuvIzWfqHXtSBUbsZOQ42awvRZqWTDB1eUBly/dYX0CwXoi5MZsxPohA5k
 QfQ0cH+CVp0g9HShfPHRodyXR8i+TfUxdCQkb76GEEe67HD0pVnFsizS30mjU5RNSz+UULmhd
 WGG45ZntIfLPoppeyhNBrlM5GCPY9k8KfV5h8bRcfa7w1xey0r4GLgLgL/p6q/08X+8zGxO1a
 CSV2pbismYM+E00zGa2xvFJSVo6M///BL7+GN/JJBE0UhBAb+8ErfF1YAMkjcHxPCKZu4etu0
 AtXwpDyd4CYxSkw0QgwmJgGXAtmHVt05Vy2zmK0sJcRgA8OftogopQqCuqWKG5Ewx+m+NXX4s
 +FBlhv5A1tjI2jV8Apg9iu3dge1J3HHbn4OXXVKjgLIgb5FS5OrxBNGtjHlRfH/SfxPXBDarD
 Y9RepM2DtkYJJwKhEV6sgMibCC7ejyrUuqlPKpsGcwCgH7p8Lj7zZE1gwAu/jApROHYoep2m0
 IQUEM/v7KaMULgUJTUU4UefUWVB1C1J28Xjr1OLpXJDaQJyIPtGmwaYsN9q55ZsG0ZoNUCrPC
 4QTlvhkJVkB3Q2KmGvtBNrzc7pDzN0A8A80hekwKsQpZxSaKncepuiSJB9e8MFKu/fbkZTwod
 LQSkBLh6eug26qTMbJ82aR7JFPIEx7dAyEIl/UJguB3kjWoFtv+ofHwL42fWCaJwTt4WOREF1
 LmPAslSY6+QS678TArGTXuC3lQh20JFqAV64ChPQ/Q6IDEuIUSxkqjwhOYxUsQ3mimg6sFZE/
 Fc3E5h+Pit6AuweVEIhdX8KI4+rhjkFxRGOSrmR6ykAZ6F0Xyc+Eww2OaL9uD30/SJ49JadPG
 0XnegOyszTe4EbMeKzIAC+642/IsS0pQg1jVc76zq0zJjid0xlFQ/oNM0M75wp9HpbRfORC6H
 /sDQYt+AebUszAJFJ808495THhlTNNU4n2/Ez1n

Hi everyone,

I am experiencing reproducible black screens after standby on a desktop
PC since several months. The only way out is to hard reset the system.
The problem appeared after kernel updates. At first, I wrongly assumed
that the issue was in the AMD subsystem
(https://gitlab.freedesktop.org/drm/amd/-/issues/3580)

But after a "git bisect", I found out that the issue is triggered by
the following commit:

Author: Chris Lu <chris.lu@mediatek.com>
Date:   Thu Jul 4 14:01:13 2024 +0800

    Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c
   =20
    Move btusb_mtk_hci_wmt_sync from btusb.c to btmtk.c which holds
    vendor specific stuff and would make btusb.c clean.
   =20
    Add usb.h header to btmtksdio.c/btmtkuart.c for usb related element
    defined in btmtk.h
   =20
    Signed-off-by: Sean Wang <sean.wang@mediatek.com>
    Signed-off-by: Chris Lu <chris.lu@mediatek.com>
    Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

I find it surprising, because this change looks like a refactoring. But
I have indeed a BT adapter from Mediatek:

$ inxi -Eaz
Bluetooth:
  Device-1: MediaTek Wireless_Device driver: btusb v: 0.8 type: USB
rev: 2.1
    speed: 480 Mb/s lanes: 1 mode: 2.0 bus-ID: 1-7:8 chip-ID: 0e8d:0616
    class-ID: e001 serial: <filter>
  Report: rfkill ID: hci0 rfk-id: 2 state: up address: see --recommends

I have also noticed some Oops in the system log, but I don=E2=80=99t know i=
f
they are related:

Jan 02 06:51:53 kernel: Bluetooth: hci0: HW/SW Version: 0x008a008a,
Build Time: 20241106163512
Jan 02 06:51:53 kernel: BUG: kernel NULL pointer dereference, address:
0000000000000209
Jan 02 06:51:53 kernel: #PF: supervisor read access in kernel mode
Jan 02 06:51:53 kernel: #PF: error_code(0x0000) - not-present page
Jan 02 06:51:53 kernel: PGD 0 P4D 0=20
Jan 02 06:51:53 kernel: Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
Jan 02 06:51:53 kernel: CPU: 11 PID: 252 Comm: kworker/u99:0 Tainted: G
W          6.10.0-rc7-MANJARO+ #24
0fce326ab6f7abf1b1427ec9bb2e550935eaff74
Jan 02 06:51:53 kernel: Hardware name: Micro-Star International Co.,
Ltd. MS-7D76/MAG B650M MORTAR WIFI (MS-7D76), BIOS A.H0 07/25/2024
Jan 02 06:51:53 kernel: Workqueue: hci0 hci_power_on [bluetooth]
Jan 02 06:51:53 kernel: RIP: 0010:__pm_runtime_resume+0x19/0x80
Jan 02 06:51:53 kernel: Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90
90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 55 41 54 55 89 f5 83 e6 01 53 48
89 fb 75 09 <f6> 87 b9 01 00 00 04 74 43 40 f6 c5 04 74 07 f0 ff 83 b0
01 00 00
Jan 02 06:51:53 kernel: RSP: 0018:ffffbafc80bebbf0 EFLAGS: 00010246
Jan 02 06:51:53 kernel: RAX: ffff93f1e6b74005 RBX: 0000000000000050
RCX: 0000000000000000
Jan 02 06:51:53 kernel: RDX: 0000000000000035 RSI: 0000000000000000
RDI: 0000000000000050
Jan 02 06:51:53 kernel: RBP: 0000000000000004 R08: 0000000000000000
R09: ffff93f1e6b74000
Jan 02 06:51:53 kernel: R10: ffffbafc80bebc28 R11: 0000000000000003
R12: 0000000000000035
Jan 02 06:51:53 kernel: R13: ffffbafc80bebc88 R14: 000000000000003a
R15: ffff93f1d733d468
Jan 02 06:51:53 kernel: FS:  0000000000000000(0000)
GS:ffff93f8be380000(0000) knlGS:0000000000000000
Jan 02 06:51:53 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jan 02 06:51:53 kernel: CR2: 0000000000000209 CR3: 000000011cb38000
CR4: 0000000000f50ef0
Jan 02 06:51:53 kernel: PKRU: 55555554
Jan 02 06:51:53 kernel: Call Trace:
Jan 02 06:51:53 kernel:  <TASK>
Jan 02 06:51:53 kernel:  ? __die_body.cold+0x19/0x27
Jan 02 06:51:53 kernel:  ? page_fault_oops+0x15a/0x2d0
Jan 02 06:51:53 kernel:  ? exc_page_fault+0x7e/0x180
Jan 02 06:51:53 kernel:  ? asm_exc_page_fault+0x26/0x30
Jan 02 06:51:53 kernel:  ? __pm_runtime_resume+0x19/0x80
Jan 02 06:51:53 kernel:  usb_autopm_get_interface+0x1b/0x50
Jan 02 06:51:53 kernel:  btmtk_usb_hci_wmt_sync+0x9f/0x420 [btmtk
fa79ad7fd7fb66d07fc217cb4ff72c4bf8aee393]
Jan 02 06:51:53 kernel:  ? __pfx_btmtk_usb_hci_wmt_sync+0x10/0x10
[btmtk fa79ad7fd7fb66d07fc217cb4ff72c4bf8aee393]
Jan 02 06:51:53 kernel:  btmtk_setup_firmware_79xx+0x19d/0x310 [btmtk
fa79ad7fd7fb66d07fc217cb4ff72c4bf8aee393]
Jan 02 06:51:53 kernel:  btusb_mtk_setup+0x1bf/0x5c0 [btusb
b9af32c76c9c6213ec8e1d819803a203230d3bb2]
Jan 02 06:51:53 kernel:  hci_dev_open_sync+0x102/0xb80 [bluetooth
298a305cf3cb3f35d2593edb9982f2d8837c12b0]
Jan 02 06:51:53 kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 02 06:51:53 kernel:  ? try_to_wake_up+0x22f/0x660
Jan 02 06:51:53 kernel:  hci_dev_do_open+0x23/0x60 [bluetooth
298a305cf3cb3f35d2593edb9982f2d8837c12b0]
Jan 02 06:51:53 kernel:  hci_power_on+0x4f/0x260 [bluetooth
298a305cf3cb3f35d2593edb9982f2d8837c12b0]
Jan 02 06:51:53 kernel:  process_one_work+0x17b/0x330
Jan 02 06:51:53 kernel:  worker_thread+0x2e2/0x410
Jan 02 06:51:53 kernel:  ? __pfx_worker_thread+0x10/0x10
Jan 02 06:51:53 kernel:  kthread+0xcf/0x100
Jan 02 06:51:53 kernel:  ? __pfx_kthread+0x10/0x10
Jan 02 06:51:53 kernel:  ret_from_fork+0x31/0x50
Jan 02 06:51:53 kernel:  ? __pfx_kthread+0x10/0x10
Jan 02 06:51:53 kernel:  ret_from_fork_asm+0x1a/0x30
Jan 02 06:51:53 kernel:  </TASK>
Jan 02 06:51:53 kernel: Modules linked in: intel_rapl_msr(+)
intel_rapl_common mt7921e mt7921_common mt792x_lib mt76_connac_lib mt76
btusb snd_hda_codec_hdmi btrtl btintel snd_hda_intel btbcm mac80211
kvm_amd btmtk snd_intel_dspcfg libarc4 snd_intel_sdw_acpi bluetooth
snd_usb>
Jan 02 06:51:53 kernel:  cryptd xhci_pci video xhci_pci_renesas wmi
Jan 02 06:51:53 kernel: CR2: 0000000000000209
Jan 02 06:51:53 kernel: ---[ end trace 0000000000000000 ]---
Jan 02 06:51:53 kernel: RIP: 0010:__pm_runtime_resume+0x19/0x80
Jan 02 06:51:53 kernel: Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90
90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 55 41 54 55 89 f5 83 e6 01 53 48
89 fb 75 09 <f6> 87 b9 01 00 00 04 74 43 40 f6 c5 04 74 07 f0 ff 83 b0
01 00 00
Jan 02 06:51:53 kernel: RSP: 0018:ffffbafc80bebbf0 EFLAGS: 00010246
Jan 02 06:51:53 kernel: RAX: ffff93f1e6b74005 RBX: 0000000000000050
RCX: 0000000000000000
Jan 02 06:51:53 kernel: RDX: 0000000000000035 RSI: 0000000000000000
RDI: 0000000000000050
Jan 02 06:51:53 kernel: RBP: 0000000000000004 R08: 0000000000000000
R09: ffff93f1e6b74000
Jan 02 06:51:53 kernel: R10: ffffbafc80bebc28 R11: 0000000000000003
R12: 0000000000000035
Jan 02 06:51:53 kernel: R13: ffffbafc80bebc88 R14: 000000000000003a
R15: ffff93f1d733d468
Jan 02 06:51:53 kernel: FS:  0000000000000000(0000)
GS:ffff93f8be380000(0000) knlGS:0000000000000000
Jan 02 06:51:53 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jan 02 06:51:53 kernel: CR2: 0000000000000209 CR3: 000000011cb38000
CR4: 0000000000f50ef0
Jan 02 06:51:53 kernel: PKRU: 55555554


Does that make sense to anyone? I can provide more information if
required.

In the meantime I use older versions of the kernel, but with time this
becomes a bigger problem.

Cheers
Olivier




