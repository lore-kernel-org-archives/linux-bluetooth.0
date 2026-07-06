Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04129392824
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 07:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321650; cv=none; b=mfuI4D9v1GNW9Y/OIiC4DMr53Tt7Dht1bkxNqj+WBNp37a0h2eNa9ORZF9cfi5fvjXM+eA9FOJUtIauKi8sWpEZ8vIaIPELEBJJ45r51eQOGL4VweQ+QgpFxNxaEKgWUp8tDvyf0SMjdBBlLRheS7uB1fz7gUGDfASn34IH3YNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321650; c=relaxed/simple;
	bh=r4YwqlE/r7hsHaEIBnHKVRKIaFoCMjmYN4ooXMo613k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FVdXjvUnnPwy/Pc9Jn+E3coLCmP51fbGwZGmMdJocit9eLaXSm9OMWU3qTNZyMZe/h5civYZwUsg2hNOxVboOtRgjEg590vTMJQKEd169SLg7NmgWy1eUy8YHWGlB/bfZ8ANZqN/V1ShIiVkYnS+kg3El8pEVfsTq+21XdPWmJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFjgTAXT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFjgTAXT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06A75C2BCF4
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 07:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783321648;
	bh=r4YwqlE/r7hsHaEIBnHKVRKIaFoCMjmYN4ooXMo613k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dFjgTAXTpLDm3HMPSxYeuzXVpa0diSsPNz9GAb5xOj8WN26so7/yEZJsb3TQ36Rat
	 wSVD0h3TOEd3Cebr9tsM91Mp2rE0Db2T2LAIkv5x9qtIGG8u8Vgq3JQQGT8lFSHH06
	 QrJN8zNHxZq+CHE/UmYbdDGXH2+A3RM78IFBspKHZM/gZ+10M8+Y6l9P9ZOHVc3DNQ
	 a4jY7ZL1UJTBE7kSdNbepsIpwXYUTOmQ6k3avhyJoCBkrFb0ZNIIQMWiVco37oG24D
	 jqR1SxLqcB3FhoL7Y4qY2s72GVPa5AahQ4zTAHlgC2R5dcI3jlJnya6RsSvDZcc0AW
	 uzZ9K8vHdkg7g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DE1E2C41613; Mon,  6 Jul 2026 07:07:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221696] btmtk: regression in 6.6.142: NULL pointer dereference
 in btmtk_usb_hci_wmt_sync during resume from S4
Date: Mon, 06 Jul 2026 07:07:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221696-62941-9ZSWyOI9w1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221696-62941@https.bugzilla.kernel.org/>
References: <bug-221696-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221696

--- Comment #10 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
The next 6.6.y release (to be released in a few days) will have a few fixes
backported, please let us know if it helps
https://lore.kernel.org/all/2026070315-stable-reply-0016@kernel.org/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
