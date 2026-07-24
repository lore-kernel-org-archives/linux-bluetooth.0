Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDED2AEE1
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913553; cv=none; b=ClG1kWCX6XwRZfA3gc5xo5QlLg7IBX2OgiilFb/fO76ZE31+9nLzlatlZESauhDRaAEfIMXNnkK7daHUVTrBNiDtYc4nYgKaVPK7wKhBqaLipLu3l1v0TFmyRsMWamJw6cnIFXg4J+RYp10eFgfSDTLa3UGCEA162Xci84bpahg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913553; c=relaxed/simple;
	bh=/6oEZTef9oM+zXZ1RCZSRTHGzcSaPyY1rp8e3EJONr4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hBWH7fVYqFYwNa+oMgBlQ6y1TcJ4BaJCina+Ik5ONqsnx157Fvp92aG49axjnI0V7Nzx+D7f85vAtMtHkfxLtvqCxdtJiLGfVFS2RFO9oLwV08iOKbVZPYN6xR61jDwE886seub8C0kAw1CHQGoJ0chRH5Lz97y9qyGd0LiHpqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5ravtim; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5ravtim"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EA3BC2BCF7
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 17:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784913552;
	bh=/6oEZTef9oM+zXZ1RCZSRTHGzcSaPyY1rp8e3EJONr4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=g5ravtimNnI6d1qPmOsvMcG4Mkyn/tlgsygpgFwFrIzrnxVU80VdVrs/d7LbiimZ+
	 9ipcuGKSHQitcYd7jcukvoqkUZPTZfsudRdAeLFUMbXi+hT1pOQuRRlDsN1zeS8WSg
	 HrzfaCphOgYtMbaA5gTqVWJFRCUVxt5iBCF6K458U4dm4Ix+NW46N6yNCOKHTKqIon
	 oRZ/cDyR3MaG1jwC4riJPCMyN4Y6bXg6NCYH9YpFZnB98UJfu+yzldNl+4p0IZeTNk
	 cb4ruUZ5MOBr/eE8LeO398JVJ1W51Va61lUZcCsxZXZgU0bTiXOF08ERUUmjBUYDVj
	 P7U/M4OGGTuzA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8099CC41616; Fri, 24 Jul 2026 17:19:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221722] Blanket HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for
 all MediaTek chips breaks HFP mSBC microphone on MT7925 (0489:e111)
Date: Fri, 24 Jul 2026 17:19:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: enbonnet@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221722-62941-LM2gobTIP6@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221722-62941@https.bugzilla.kernel.org/>
References: <bug-221722-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221722

Ender Bonnet (enbonnet@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |enbonnet@gmail.com

--- Comment #1 from Ender Bonnet (enbonnet@gmail.com) ---
Additional affected hardware =E2=80=94 new USB ID for this quirk:

  Adapter:  MediaTek MT7925, USB ID 0e8d:e025 (MediaTek Inc. Wireless_Devic=
e)
            =E2=80=94 note: different from the reporter's 0489:e111 (Foxcon=
n), so the
            blanket quirk affects at least two MT7925 USB variants.
  Machine:  Lenovo ThinkPad P14s Gen 6 AMD (21QL), BIOS R2XET40W 1.20
(2026-05-26)
  Kernel:   7.1.4-204.fc44.x86_64 (Fedora 44)
  Stack:    bluez 5.87, pipewire 1.6.8, wireplumber 0.5.14
  BT FW:    Build Time 20260605184935

dmesg confirms the blanket quirk fires on this variant too:

  Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is
  advertised, but not supported.

Possibly related additional impact beyond the broken mSBC microphone:
on this machine, roughly every 2nd reconnect of an A2DP-only-use headset
(SLEVE EVO) comes up either stuck in the HFP profile (16 kHz mono sink)
or with garbled audio while bluetoothctl reports the connection healthy.
Forcing the profile back with `pactl set-card-profile ... a2dp-sink`
sometimes recovers; otherwise only a full adapter power cycle
(`bluetoothctl power off / on`) heals it. Frequency: 5 occurrences in the
last 30 days, logged by a watchdog script I run as a workaround.

Since the quirk forces all SCO/profile setup on MT7925 down the legacy
fallback path, this reconnect misbehavior may share the same root cause.
Happy to test a kernel with the quirk scoped per-chip (the proposed
one-line change in btusb_probe()) and report back.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
