Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9506E2E8B83
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 05:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790831213; cv=none; b=THNcp4kO9rEXcKmf5iUaTQz8+RSCuCclw/nAk2D3Ng9GwNAe6B3s8+ELhgMF7c6r05UeAT15LRbEWPoF7HjwIsmbxSNfriCZUXg2vSEfkQeYOp4MnFKrquOpF5C+bmVJI5bGpk4sX15ZNI2//dYyyb1YFgWPZ6yGrrphi5GKyLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790831213; c=relaxed/simple;
	bh=nsryrxi1SlM82VJ7wcUFK6wDkoWejrIvDhNTdrypQKg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o+AM+8GbVutnRsN9SC+J/VvCY6IPLMGXmiYcX3Xder+FqW7XbH1mieNicw++ZEvmIyXd5kydt2UUWUrrpM6EJ5jP/kx17wpoq+PbKaIyFhCndHbsEgJ3iVlyDkmxm3Gx4X2PRk8hGHmmy0gcV6uG+hiPEeaCcP6ihkQwpg/Ah7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsVX5xd0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsVX5xd0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9BCEC4AF15
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 05:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790831212;
	bh=nsryrxi1SlM82VJ7wcUFK6wDkoWejrIvDhNTdrypQKg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lsVX5xd095w+U9ia/csdph5nIibpsdt42TA+N96pvjM0oVgrUjQ4+/Rxq5hSUiw8t
	 zIf+86vTV3TbSCawgbf93zn4dWosmi/0bzAyGHKa+wcnOyWLMVVqvZaU0NS+zofGPW
	 2piEbFcEpcVqIfk/QmEnVkj9OFXM32leVbjgcaNByM+Vny1n6uUsDkAwx/4gkdKOuL
	 Gv0bKc15Te1+f5ZWFTVq8L3gMcGYioT7pfP3xZe5pl9tyZp50Ml4q6VldK/nb9GDyr
	 CK4QovqKKTcXlPvHr4tKaGPNsiXoZ2cYPMEruY5pEJcX9ANCW82qXEkNSup30Lcwk6
	 MBGDXHWVe0wJg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9262DC53BC7; Thu,  1 Oct 2026 05:06:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220344] Intel AX211 bluetooth randomly disconnects and
 reconnects, started after kernel update
Date: Thu, 01 Oct 2026 05:06:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ctrom@trom.co
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220344-62941-GLhnHJ1bM0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220344-62941@https.bugzilla.kernel.org/>
References: <bug-220344-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D220344

Christopher Trom (ctrom@trom.co) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |ctrom@trom.co

--- Comment #9 from Christopher Trom (ctrom@trom.co) ---
Adding a data point - same symptoms on current software, with a couple of
workarounds ruled out.

SYSTEM

Hardware: Intel Wi-Fi 6E AX211 160MHz (CNVi combo WiFi/BT; BT enumerates as=
 USB
8087:0033 via btusb/btintel)
Distro: Arch Linux
Kernel: 7.2.7-arch1-1
linux-firmware: 20260916-1 (current at time of testing)
Bluetooth modules: btusb, btintel (not btintel_pcie - BT side is USB-enumer=
ated
despite WiFi being PCIe)
WiFi modules: iwlwifi, iwlmvm

Both kernel and firmware were current as of testing.

SYMPTOM

Same as OP: Bluetooth headphones disconnect, recovering automatically withi=
n a
couple of seconds. dmesg/journal shows:

kernel: Bluetooth: hci0: Hardware error 0x0c
kernel: Bluetooth: hci0: Retrieving Intel exception info failed (-16)

followed by bluetoothd/wireplumber/pipewire reporting the audio transport
failing and reconnecting:

wireplumber: pw.node: (bluez_output.<MAC>.1-XX) running -> error (Received
error event)
wireplumber: spa.bluez5: Failure in Bluetooth audio transport
/org/bluez/hci0/dev_<MAC>/fd0
bluetoothd: profiles/audio/avdtp.c:handle_unanswered_req() No reply to Susp=
end
request
bluetoothd: src/profile.c:ext_io_disconnected() Unable to get io data for
Hands-Free Voice gateway: getpeername: Transport endpoint is not connected
(107)

FREQUENCY / TIMING

Crashes recorded in one session (single boot), timestamps and gaps between
them:

21:21:40
21:29:17  (+7:37)
23:19:54  (separate session, same boot)
23:24:46  (+4:52)
23:30:36  (+5:50, no accompanying Hardware error - just a transport disconn=
ect
w/ no crash)
23:35:34  (+4:58, no accompanying Hardware error)
23:37:17  (+1:43, + Hardware error)

No consistent period. Looked like it might be ~5 minutes for a stretch, but
that broke down (see the 1:43 gap).

THINGS I TRIED TO IDENTIFY A TRIGGER

1. WiFi AP roaming

Initially looked correlated (a crash followed a WiFi roam event by ~7s), si=
nce
this is a combo WiFi/BT chip. Pinned the NetworkManager WiFi connection to a
single AP's BSSID + 5GHz band to eliminate roaming entirely:

nmcli con modify <conn> 802-11-wireless.bssid <BSSID> 802-11-wireless.band a

Confirmed via nmcli con show that the pin was active and WiFi stayed on one
BSSID. A Hardware error 0x0c crash still occurred 3.5 minutes into a stable,
non-roaming WiFi connection, ruling out roaming as the (sole) trigger.

2. BT/WiFi coexistence + power-saving

Tried disabling hardware coexistence arbitration and power management via
modprobe options:

options iwlwifi bt_coex_active=3D0
options iwlwifi power_save=3D0
options iwlmvm power_scheme=3D1
options btusb enable_autosuspend=3D0

Rebuilt initramfs (mkinitcpio -P) and rebooted; verified all four parameters
took effect via /sys/module/*/parameters/*. A Hardware error 0x0c crash with
identical signature still occurred 3m20s after boot, with coexistence and
power-saving both disabled.

At this point the trigger doesn't appear to be WiFi-roaming-related or
coexistence/power-management-related. I'm open to suggestions on what else =
to
test (increased BT debug verbosity, btmon capture during a crash, etc.) if
useful for the bug report.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
