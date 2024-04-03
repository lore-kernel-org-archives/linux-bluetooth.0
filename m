Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49753C152
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147543; cv=none; b=esIZRoygnKqS6guXPRAxlJz5kcoSkqF+qF4nN4TinsXvRf/w8YcudjEQmXEhPsmj8ARS0QFCJ23Wb8vfuitv1uGzHU5GI6k/3nMPfe4Da5aQROFiWOf02tXeP854QtUiSm7fQZOSv7ShOoLJ53WhC6vMi3rv38Aqega7DEDkVIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147543; c=relaxed/simple;
	bh=X35XMzk3A8uoTckEnKiVMa5b/pZxR7OiFNkczAB5vXE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pGlIzbxWL1LgAWdpHmHZuUkr1biGj2cJV0cYwp+zGti+0ZGa6nZnUY91QYQbmZlkdLlDFiaEdsZsqaJJPpwZkdF8GEMjx4jndpNYEFxiisNozn2sxDpLRUoC4conWEsKTi1rtGBnw4jO8NWlf49ezDkjar2wTQBlb/DL0NRMvmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvU/cvNf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvU/cvNf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7946C433A6
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 12:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712147542;
	bh=X35XMzk3A8uoTckEnKiVMa5b/pZxR7OiFNkczAB5vXE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KvU/cvNf1J0zJuzGPdCzP+VdLBQmhvG7FBPa2d7Ii2I2Kg6S3LM1j/ei3U6W0wxTR
	 SwfaHzu0ueOVryi1Icj65CkitmsOvYPtUOfA44VRG7luLy9/bMK8a+u4FHuf3u0y47
	 YuR0L0mC0b6vcP145zLARPTnSZ8I5AoC/UuxogRHeV+AD41WATzEANqO+UTBfNjAUU
	 yhY1D/xqfnnzCwoB/8VkPN4SM/91DAWeTBwnpu6xzxyBm5ALcx2rnp3W8gI9BMp+EC
	 Hgzw55y2TH5EgRdNekJtJgPDMSUVH9gjY6FbBdD4/hp4/bYA7iAQ6+zDH+1ClS0fzD
	 ixBdHT2Sktt7w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9FA22C53BD1; Wed,  3 Apr 2024 12:32:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Wed, 03 Apr 2024 12:32:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: thomas.creutz@gmx.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218416-62941-VstOn0gUXv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218416-62941@https.bugzilla.kernel.org/>
References: <bug-218416-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218416

Thomas Creutz (thomas.creutz@gmx.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |thomas.creutz@gmx.de

--- Comment #15 from Thomas Creutz (thomas.creutz@gmx.de) ---
I also get:

~$ dmesg | grep -i blue
[   13.838221] Bluetooth: Core ver 2.22
[   13.838236] NET: Registered PF_BLUETOOTH protocol family
[   13.838237] Bluetooth: HCI device and connection manager initialized
[   13.838240] Bluetooth: HCI socket layer initialized
[   13.838241] Bluetooth: L2CAP socket layer initialized
[   13.838244] Bluetooth: SCO socket layer initialized
[   14.329584] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   14.329588] Bluetooth: BNEP filters: protocol multicast
[   14.329590] Bluetooth: BNEP socket layer initialized
[   16.032582] Bluetooth: hci0: Reading Intel version command failed (-110)
[   16.032583] Bluetooth: hci0: command 0xfc05 tx timeout


~$ modinfo btintel
filename:=20=20=20=20=20=20
/lib/modules/6.5.0-26-generic/kernel/drivers/bluetooth/btintel.ko
firmware:       intel/ibt-12-16.ddc
firmware:       intel/ibt-12-16.sfi
firmware:       intel/ibt-11-5.ddc
firmware:       intel/ibt-11-5.sfi
license:        GPL
version:        0.1
description:    Bluetooth support for Intel devices ver 0.1
author:         Marcel Holtmann <marcel@holtmann.org>
srcversion:     FDF2221B8ED4B01F8EADF85
depends:        bluetooth
retpoline:      Y
intree:         Y
name:           btintel
vermagic:       6.5.0-26-generic SMP preempt mod_unload modversions=20

~$ lsusb | grep -i bluetooth
Bus 001 Device 005: ID 8087:0025 Intel Corp. Wireless-AC 9260 Bluetooth Ada=
pter

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
