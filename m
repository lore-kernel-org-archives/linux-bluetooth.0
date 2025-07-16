Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF8B2882C3
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653428; cv=none; b=Z/vhtWY1Y1IeG91/3J+ziF827tTlMZZ9tPnKFvc+fF2g6JArB1eY1/KJzGy2z4x1Pr9/jvjbIdQG/yi5v+14xTVpHLSSc1mC1B55bUtAgmpzmBKIuQCX9ML7Q8H5gUVILK8a5uqN8Z9qvY8TjHbYsuzFCNdbAgNDFEb0WU6UiKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653428; c=relaxed/simple;
	bh=qDBo9Ag7PJG4K4ycCzciKoSTQ5jnAsaXvl7tdtuMT78=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z4qcJ5Zp7vVNupZXPkgVfz5NMBSZBvac9uZvm9OqtOkkmPE8Ji8BLBbRulWZvSoGS9SdDI3bjwqwvwd1BWMyh9snxyVlS/liik2yxUlRJ2a4NWVrtCkRAhyyleLZiDMEXsfnl5vp8EU5Ob8SlJCbrQq9OQDzdxo26atHIiZWMGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDCBZgYP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDCBZgYP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F09EC4CEF0
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 08:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752653428;
	bh=qDBo9Ag7PJG4K4ycCzciKoSTQ5jnAsaXvl7tdtuMT78=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nDCBZgYPnbTINrllbdiNd1OK0vrqy7gIMI7ItJxIBVE8DCjErW+IQf2RLF8jP2ZAw
	 LOSUNMEwk7fBdhxl8g4XcTfx5psBwEqLvkKYMPiZseUoLrfR2N50lexeXRzjue6EjR
	 Lbykih3FSSGYnP4OVu+7wpkApp6Rx1c88lUwu0x9Bn//ipDFhwTcDBb6esXIoi1inh
	 4i9jGGEkfxo9FciXPoazzJNbhAzAj/RS9yrJur1rofiPpP0+ugLse7eES0VkfzYVAR
	 8w2E3gS/HYtzHqV/a0aPEJrmWufgId4/HBdmK52vucRlWBAZNhtwU8Rc40qBUxSRto
	 doP8CBkXK5+bw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4FC60C3279F; Wed, 16 Jul 2025 08:10:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220341] Bluetooth crashes about 30-40 minutes after I connect
 my headphones:  "Bluetooth: hci0: Hardware error 0x0a"
Date: Wed, 16 Jul 2025 08:10:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nicolas.baranger@3xo.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220341-62941-GXLjxReXsN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220341-62941@https.bugzilla.kernel.org/>
References: <bug-220341-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220341

--- Comment #6 from Nicolas BARANGER (nicolas.baranger@3xo.fr) ---
Hi all

Unfortunatly I don't have this laptop anymore (dell xps 15 9530), but from =
my
remember of last summer issue, rmmod -f followed by insmod don't work as rm=
mod
-f was not able to remove the module from the kernel.

The only way I found to recover the situation was to forcely reboot the sys=
tem
.

Also, don't know if it's related but I remmember that I had no issues during
the last 2 weeks I used this laptop (corporate laptop) and that was just af=
ter
removing pcie gen5x2 nvme m2 drive end replacing it by a mdadm done with 2 =
pcie
gen4x4 nvme drive.
Also note that the issue always happens when I was using an Aquantia AQC100S
10gb nic plugged on thunderbolt bus and maybe when cpu total load was highe=
r to
30% on pcie bus
My feeling was an hardware issue at I/O or DMA that kernel don't handle
properly=20

NB: I was using grub and not systemd-boot

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
