Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A359356A0D;
	Sun, 23 Aug 2026 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787477999; cv=none; b=Suz/UjZL583RmY1hWh73aGMgPcFEiM7qpGptT2nAiG+A8K25T6eGGGPLAVvSKKkc3kKfAU2Zzs2iXbkkCpt6gCNTLz9fyg85TXVq9CkcsvY//OJYwaEHpzXX3WQif9/qcwnxe7SLIyx4g8wTF0Tn+NdRj3thaKYQiOIS82eIVtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787477999; c=relaxed/simple;
	bh=ftx9u6xLsxE3noaPLhxxbCkOHccXa7Ry5dy3qW+WJpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TfZcrzsNFu3c/UVMG852fU4LfxD8YQl83ZCyekA4O8synQ2HeexKDl5yh8O6L+fEENmIW+5yHZZTyV6r+hP4xCJR9BGtSAJyFYeIcCVHuABBdcGpaHnNGXo929iLsmc3yW6srHoMea6NIFMCrWxhqxalIIao6lt0OnVR0hWH16U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=hrmimnUk; arc=none smtp.client-ip=188.68.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="hrmimnUk"
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4hSTXf4nVjz8JWk;
	Sun, 23 Aug 2026 11:39:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1787477986;
	bh=ftx9u6xLsxE3noaPLhxxbCkOHccXa7Ry5dy3qW+WJpU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hrmimnUkT6bfwgStjJK7YEv8bUiurUqDOcRa2pqDUmKJgao9ohcCG3/l2cHv0nRXy
	 aCiPXjX+yyzdhMf/7cYl8sR7vK9TU9CdhZB8bX26rv6eLwjN5OJ3r0bpgoFYglw4WQ
	 XEu8iJaYeYrOXJrBMHQ21CXmJovz5V3P+Fc7UI+zYyXmsEJe8mAwCZ0GKg2qauSEwy
	 VCV0ilNTzSn7Pn+CvR4TuNKmVlgH1qQPyogHEfoPP3Gk+JQoNVDiH1ROSi10NW3mbB
	 De/sLkn3KOqLlCcErRqeZbeJBgoM6OLQeCbBy/5soqo0TcTWXgD+KcfUJZSfvdh/Wl
	 lPpK/iA0Pb2Gw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4hSTXc2Wd2z8JWK;
	Sun, 23 Aug 2026 11:39:44 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hSTXb1r5Vz8sb9;
	Sun, 23 Aug 2026 11:39:43 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 8D9CE5FAE4;
	Sun, 23 Aug 2026 11:39:42 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <68dc7fba-ddda-4505-bdaf-4bb7af2df44e@leemhuis.info>
Date: Sun, 23 Aug 2026 11:39:41 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Bluetooth: detect broken extended scan instead of
 guessing by chip id
To: Kamil Serwus <kserwus@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: Alexej Sidorenko <alexej@sidorenko.cz>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260822141115.58815-1-kserwus@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20260822141115.58815-1-kserwus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <178747798296.2482991.13838159982066758837@mxe9fb.netcup.net>
X-NC-CID: vO/itB60kEuuOyfmVl320RxER75AOQXY34as42vAZ5MzP95ftss=

Hi! Thx for the report.

On 8/22/26 16:11, Kamil Serwus wrote:
> commit 5ead2063611ae5 ("Bluetooth: btrtl: fix RTL8761B/BU broken LE
> extended scan"), which landed in v7.2,

And a few days ago made it to 7.1.9 and 6.18.45. :-/

> regresses a different RTL8761BU
> dongle than the one it was written for. This series reports that and
> proposes a way out that should not need a new patch per dongle.

Not my area of expertise, so the bluetooth maintainers might disagree
with me, but FWIW:

Given the above and the fact that we are in the merge window right now
I'd say the better approach would be to fix this fast by reverting the
culprit in mainline (then stable can pick up the revert to fix the
problem there) to buy time to work this out properly.

Would you maybe be willing to submit a revert?

Ciao, Thorsten
> The regression
> --------------
> 
> Hardware here is USB 0bda:8771, firmware 0xdfc6d922, ROM lmp_subver
> 0x8761 - an RTL8761BU, so CHIP_ID_8761B, so it gets the new quirk, which
> makes use_ext_scan() false and moves scanning from LE Set Extended Scan
> Enable (0x2042) to the legacy LE Set Scan Enable (0x200c).
> 
> This dongle is the opposite of the one the quirk was written for:
> extended scan works flawlessly, but the firmware stops answering the
> legacy scan-disable command about ten seconds into any scan:
> 
>   Bluetooth: hci0: command 0x200c tx timeout
>   Bluetooth: hci0: Opcode 0x200c failed: -110
>   Bluetooth: hci0: Unable to disable scanning: -110
>   Bluetooth: hci0: disable scanning failed: -110
>   Bluetooth: hci0: Resetting usb device.
>   Bluetooth: hci0: start background scanning failed: -110
>   usb 3-1: reset full-speed USB device number 2 using xhci_hcd
> 
> btusb resets the device, it re-enumerates (hci0 -> hci1 -> hci2 -> ...)
> and every connected BLE device is dropped. With a Bluetooth keyboard and
> trackball that leaves the machine with no input at all.
> 
> v7.1.7 drives the same dongle, with byte-identical linux-firmware and
> identical CONFIG_BT_HCIBTUSB_*, for eleven hours and nine BLE HID
> connects without a single scan error.
> 
> Why not just narrow the quirk
> -----------------------------
> 
> Nothing available at setup time separates the two dongles:
> 
>   - same project_id (CHIP_ID_8761B)
>   - same ic_id_table entry, IC_INFO(RTL_ROM_LMP_8761A, 0xb, 0xa, HCI_USB)
>   - same firmware file, rtl_bt/rtl8761bu_fw.bin
>   - both advertise the extended scan commands in commands[37]
> 
> They differ only by USB id, which btrtl_set_quirks() cannot see.
> driver_info cannot carry it either: 0bda:a728 has no entry of its own, so
> it falls to the generic Realtek entry in btusb's quirks_table -
> USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01) - which precedes
> the per-device entries. usb_match_id() takes the first match and
> 0bda:8771 also presents e0/01/01, so the specific entry for it at
> quirks_table:840 never applies.
> 
> What this series does instead
> -----------------------------
> 
> The quirk is documented as being for controllers which "erroneously
> claim to support extended scanning" - and one that claims support in
> commands[37] and then answers Command Disallowed is saying so itself.
> Patch 1 latches the quirk right where that command is issued; every
> later scan uses the legacy commands. Patch 2 then drops the static
> per-chip-id guess, which 0bda:a728 no longer needs. In this order the
> series is bisectable: patch 1 alone changes nothing for anyone whose
> quirk is already set at setup.
> 
> An affected controller pays one rejected scan round per power cycle
> instead of a permanent stream of failures, and dongles nobody has owned
> yet are handled without waiting for a patch.
> 
> The latch is sticky, as quirk_flags is never cleared, so it matters that
> false positives are unlikely: hci_passive_scan_sync() always disables
> scanning before starting it, so the controller is never asked to enable
> a scan that is already running - the obvious legitimate source of
> Command Disallowed.
> 
> Testing
> -------
> 
> Built and running on v7.2 on the 0bda:8771 dongle. Extended scan is used,
> the quirk is never set, no 0x200c and no controller resets, and a
> keyboard plus a trackball stay connected across repeated LE scans - the
> exact sequence that wedged the adapter within ten seconds before.
> 
> What I cannot test is the other half: I do not have a 0bda:a728, so the
> err == -EBUSY path has never executed here. Alexej, does your dongle
> still work with this series, and do you see the "extended scan rejected,
> using legacy scan" warning once? Also, 0x2042 carries both the enable and
> the disable, so I cannot tell from your report which call site returned
> -EBUSY - knowing that would tell us whether a single rejected round is
> really all it costs you.
> 
> Sending as RFC mainly because patch 1 sets the quirk at runtime, while
> the existing comment says it is set before hci_register_dev or in
> hdev->setup. I updated that comment, but if you would rather keep the
> quirk strictly setup-time I am happy to respin as a USB-id match in
> btusb.c instead - it just needs the quirks_table ordering sorted out
> first.
> 
> #regzbot introduced: 5ead2063611ae56809b1b113ac44cef9547c81d7
> 
> Kamil Serwus (2):
>   Bluetooth: hci_sync: latch broken ext scan on Command Disallowed
>   Bluetooth: btrtl: drop the blanket RTL8761B extended scan quirk
> 
>  drivers/bluetooth/btrtl.c   | 13 -------------
>  include/net/bluetooth/hci.h |  4 ++--
>  net/bluetooth/hci_sync.c    | 15 +++++++++++++--
>  3 files changed, 15 insertions(+), 17 deletions(-)
> 
> 
> base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f

