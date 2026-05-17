Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9996033F8B2
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 23:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779060331; cv=pass; b=iw1Si5ahIH8lhLhVz9V4MKug6kVgHzLHR16GIeb+fq8rjnwqe2bDH318RhX5HBRwFQsptWo30GQkr2aXG7upJPglfZjXn3a/R+uKpPJRKQ0S6eMqNXfsMl+xwNc2chvXzw2wOk8020tUWHUINohR5KA6Pbso6VH991VUCMFvwYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779060331; c=relaxed/simple;
	bh=oQMlYsX+VgifZz5u10HC4ZEMVQVuCOrZ67vfrQ1RB6s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=vGf0wavEKTtSju+8MWA5cyKD8XL7WnSPQ09LK16Yx+PbX6kPK+HMSUEmxHboK1XJvhgTPFWcerSq9HelJgF+pMEJ1TwBEXH4rBsvb3CPH6ivmZPA1dnsPAkQ28smElAV7Tuo8kmzN564sZKtlY+IIJR6h2UoN+lKJlMeQbTEq00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mpdxvxyw; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mpdxvxyw"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ee990e8597so5064851eec.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 16:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779060329; cv=none;
        d=google.com; s=arc-20240605;
        b=g7WaQ1qalhObKzlqlSgbeqm/AeynpM/X1MmNYMg7WGWIFhFLgSn0yFCfUr8iWiCAky
         RFPykmr2Qd6VDlSFRVae+V8pyLc8JPDn6ZMF29hafSHZNVr7Ouio2oI5TKILzDN3Dvng
         Xe708/ozVBVFqPMR9df8E2wluVieyR2pPY57LZXqPeQyIAuxc694KNfGUh+Js9FmV0hL
         hNEDXNAx6wZmsukgnQF4H3sMbx7vbADSdC5prjGRNdI1tsgHspaU93/0qiLxCeA4+QVK
         mPJSDWdVtqpYsSq6ZZ9SXIjEtHkJpGjy5GoC1jmIaf1UkqnqS5XIXOezxmW22eh0E6I2
         8Y5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=oQMlYsX+VgifZz5u10HC4ZEMVQVuCOrZ67vfrQ1RB6s=;
        fh=ULUQ3PfFniKhAi3eYIKhsoU/3Va41C5R49Zgz+t1Wko=;
        b=IGwXwhH2CdvlRhLdmsuLDLZXKWOYfdO5f2qAC6Vz+qRyC3qp/UX8UqEK0fl0CWW0Fi
         V2g/45yFu5Tjzzv3HskolD3Nv0C/wEawsEbihWU65vVWkRgJskcWOXuBQM8vS6ASqeYV
         0NbcHOF+j2S0M8xNgg+/R0+fWKgOzopnkEBqwYvHFk872D+jk/WlPMr4UamKcBbiK+EW
         RT8VYL7fop9q96gSanmbjPWhHM75YxydgDbp7ZZMuaVtupCcqOQkcXufinhdmTLZZ09m
         jrilbCsI6E7bzhhfegSNCNmyRWMS7dRQ8o9Rp3dnhRY5jSyv0o/LeggmYv0C3SDPxvit
         BMfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779060329; x=1779665129; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oQMlYsX+VgifZz5u10HC4ZEMVQVuCOrZ67vfrQ1RB6s=;
        b=MpdxvxywM23tEMa+p+S4FucznTx6wftW6GqyRn4MkXbXEdUFpEvvyKIMdRHNNKhYxp
         uEasM96n93LnExhAgxWcBhfMicoaKlP6+3YTD+BtTQBC6YzgzXqonPf+qdC2IMVTIDrY
         XISthFKJQfFCmgagd4h0PJUYZiQd3PikvTF+hJlrjh06g/XsihcMq7zDjULrMEcmpcXQ
         zm/3NjqONKIsvGj4uCaByzXeZ7umLdCW6cn63NOcb0wH80hOh+OM3H6dApdS7wCONW73
         FTV0lTqOGxlslippL1cIFWeS+32Smf7A7HArwCZnCUJ/LzAFjX/F5kcWn6RS6pmPKZWj
         Gy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779060329; x=1779665129;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQMlYsX+VgifZz5u10HC4ZEMVQVuCOrZ67vfrQ1RB6s=;
        b=WFI3CabrXtJrKgm8HbUi1PwhqtCC/twUYOnVjg3CWFkHZ624ePY+SRqWgY/W9U0rWA
         unSvrx/8RGfXCFKP3w7RcdS6YKWRnB8vtv6IRMChcuKEJ20uNlUG7jQezeXCVcx6apMD
         nSl+KHpaiM5jdwmXFfUN1DPFyWI6/Y/aUwuTQeCv9EWpN60EnVfEKrqbevt43KDMt0kW
         SLC0APr1xQxjZRjOe6X+ZHKG6407EMZK8m6aoTkciSRAZN8T2EkevnYGgSUQNQhdYYNA
         ARg5fLMiPplhlL/HVEJ6uVv0fRL8EOfLVooCyMzg25eDZlS3iDccQ7hIO8Y/fcYviek0
         xwJg==
X-Gm-Message-State: AOJu0YyrH1M6eKhfg7vCNugLF1CVKRziZnzP0Lsqsc2gbOaQSFX6QamV
	RuAq4KkEIK3HzxJN171qVNb9nr/4FFyap9hD5Znc113KcstaR2+QAQjy8+6LYg5ixl6eAB5i2gR
	3HVzGd+UCEfoIlcLUlk4WWT6sbAyjwINtqEYE
X-Gm-Gg: Acq92OFTBYTLJVHI6hggCTURwVwZ7GyTOTjXilgxUAA5RDEJkmQF+IrPJO8VojtAcoT
	HcpIuT/JYpOh6YJs2Mgklgg9AIxw77K0z4Ttyrc0iT1ucuUpOKNwSBihlP3jJJaXbQs447ikJIe
	Vop8iGZ0ipHeHF9clHoy0ozUgHGO/KJsjZxZKIUA+Wp5MtXEOkKKvIomcDwN52QCDJKAcUXYaNS
	yb6ecqtHpl4X484Kg9912I4pHTAFe/3EcuvVEVk3J8iP0AhMmIe+Xl/MIzJ9IOD+0qlv8qKFoRE
	542WiX9oSmhSMpdZKTaLKf+nAzzUstYmGHetfqPW
X-Received: by 2002:a05:7300:e125:b0:2f5:6d9c:7156 with SMTP id
 5a478bee46e88-303986814f8mr6045988eec.17.1779060329249; Sun, 17 May 2026
 16:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Brandon Arnold <brandon.arnold@gmail.com>
Date: Sun, 17 May 2026 16:25:17 -0700
X-Gm-Features: AVHnY4InOi6pS-JhDeB7XWvzVJUHUwJqjaT6X2kyEDvJ9oU5Qy6fDU_IKgrEFzo
Message-ID: <CAM07e=vYJE8khJmbsn75SOYye44o8YV8TZsRyF1mFRuUTMCgUw@mail.gmail.com>
Subject: [REGRESSION] Bluetooth: btmtk: MT7922 "Failed to send wmt func ctrl
 (-22)" after 634a4408c0615c ("validate WMT event SKB length before struct access")
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com, tristan@talencesecurity.com, 
	chris.lu@mediatek.com, linux-mediatek@lists.infradead.org, 
	gregkh@linuxfoundation.org, stable@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

#regzbot introduced: 634a4408c0615c206885e60ea05f489c426f64b6
#regzbot title: MT7922 BT controller never registers (wmt func ctrl
-22) after btmtk WMT SKB-length validation

Hello there.

I wanted to report the below information about a commit that I
confirmed broke my MediaTek MT7922 adapter. The commit is also built
into the main Arch Linux package, so it affected me during a routine
update (see the BBS link in the report below). This adapter is the one
that came with my Framework Laptop 16 system.

Apologies for Claude's verbosity and language but I can confirm I
attended the bisect and revert of the offending diff. Thank you!

Workaround in use: pinned to the Arch Linux pre-7.0.7 kernel.

Thanks,
Brandon Arnold

Commit 634a4408c0615c ("Bluetooth: btmtk: validate WMT event SKB
length before struct access"), backported to 7.0.x stable and shipped
in v7.0.7, breaks Bluetooth on the MediaTek MT7922: the WMT function
control step fails with -EINVAL and the HCI controller never
registers. WiFi on the same chip (mt7921e) is unaffected.

This is NOT a v6.19->v7.0 mainline regression -- mainline v7.0 is
GOOD. The regression is the above commit specifically; it is absent
from v7.0 and v7.0.6 and present in v7.0.7.

Scope / affected versions
-------------------------
- GOOD: mainline v7.0, linux-stable v7.0.6 (commit absent)
- BAD: linux-stable v7.0.7 (commit present)
- Independently reported on Arch (different machine -- Lenovo
IdeaPad, MT7922 USB [0489:e0d8]): BROKEN on linux 7.0.7.arch2-1,
WORKING on 7.0.6.arch1-1, identical symptom.
https://bbs.archlinux.org/viewtopic.php?id=313561

Hardware / firmware (primary reporter)
--------------------------------------
- Framework Laptop 16 (AMD Ryzen AI 300 Series), board FRANMHCP09 A9
- BIOS: INSYDE/Framework 03.04, 2025-11-06
- MT7922, PCI [14c3:0616] subsys [14c3:e616]; BT side USB, driver
btusb/btmtk; WiFi side mt7921e (works)
- linux-firmware 20260410; BT firmware BT_RAM_CODE_MT7922_1_1,
HW/SW Version 0x008a008a, Build Time 20260224103448
- bluez 5.86

Symptom
-------
The firmware download and version handshake still succeed (identical
HW/SW version line before and after), then:

Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20260224103448
Bluetooth: hci0: Failed to send wmt func ctrl (-22)

No "Device setup in N usecs" follows; BlueZ reports "No default
controller available". hci0 exists in /sys/class/bluetooth and is not
rfkill-blocked. Reproducible deterministically on cold boot,
`modprobe -r btusb; modprobe btusb`, and full USB unbind/rebind. It
fails even with btusb enable_autosuspend=0, so this is distinct from
the known func-ctrl/autosuspend race.

Analysis
--------
634a4408c0615c reworks btmtk_usb_hci_wmt_sync() to validate length
with skb_pull_data() before casting the WMT event:

- wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
+ wmt_evt = skb_pull_data(data->evt_skb, sizeof(*wmt_evt));
+ if (!wmt_evt) { ... err = -EINVAL; goto err_free_skb; }
...
case BTMTK_WMT_FUNC_CTRL:
+ if (!skb_pull_data(data->evt_skb,
+ sizeof(wmt_evt_funcc->status))) {
+ err = -EINVAL; goto err_free_skb;
+ }
wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;

For the FUNC_CTRL response from the MT7922, one of these
skb_pull_data() calls returns NULL and the function returns -EINVAL
(surfaced as "Failed to send wmt func ctrl (-22)"). In effect the
length the driver now requires
(sizeof(struct btmtk_hci_wmt_evt) + sizeof(status)) exceeds what this
controller actually sends for FUNC_CTRL, so a valid handshake is now
rejected. The pre-patch code cast and read the same bytes without the
strict length gate and worked on this hardware.

Empirical confirmation (mainline, no distro patches)
----------------------------------------------------
Built faithfully from the running Arch config (only LOCALVERSION
added); no out-of-tree changes.

- mainline v7.0 : GOOD (commit absent)
- linux-stable v7.0.7 : BAD (kernel 7.0.7-bisect; WMT func ctrl -22
count = 1; hci0 device setup never completes; bluetoothctl shows 0
controllers)
- v7.0.7 + revert of
70d37a8b9229 (the 7.0.7
backport of 634a4408c0615c): GOOD (kernel
7.0.7-bisect-00001-ge33bfb5d7480; WMT func ctrl -22 count = 0; hci0
device setup OK; bluetoothctl shows 1 controller)

The reverted tree's drivers/bluetooth/btmtk.c is byte-identical to
v7.0.6 (git diff v7.0.6 -- drivers/bluetooth/btmtk.c is empty), so the
v7.0.7-vs-revert pair isolates exactly this one commit.

Reproduction
------------
1. Boot a kernel >= v7.0.7-equivalent on MT7922 hardware.
2. `bluetoothctl list` -> no controller.
3. `journalctl -k -b | grep 'wmt func ctrl'` -> -22.
4. Revert 634a4408c0615c (or boot v7.0.6) -> controller registers.

A straight revert restores operation and is offered as the candidate
fix; alternatively the length checks should be relaxed to match the
MT7922's actual FUNC_CTRL WMT event length. I can test patches, or
provide full bad/good kernel logs, btmon/hci traces, and the exact
short SKB length on request.
