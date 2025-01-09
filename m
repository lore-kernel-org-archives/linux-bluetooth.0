Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF6218873E
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jan 2025 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736446527; cv=none; b=Qa72y6ChxKFuinIKvtf+mvQmfh+qQyn6rCmwiDWwVLRAe3aTbCl2ifaJEwrUvY1vA1n/36gQzZ6Nk8uLUcyuQKm11H77vB5Dc2xuTfmRNPTFn2UbJUEJTf4vOnY1nf+rA4F3tX4fOpl6ICx3jm+PybkIQG+/ezzUQueYd244nVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736446527; c=relaxed/simple;
	bh=o8Tte81nNVdJQdhmjggrHfC8rhNDWBegYzke+2nrPJ4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uyJul2C5ZQnFFoqHk00rE62y0q5iiInSILTveF0gFHxxHpTKivYKk0h8W+sSc8FBetA5iI4pwz2ZWS8a/3m1is/HCdRQDLCNORMT4zu47xb4wWvjx6HZICIVXSZbw3qJHSqrK3P/N3dCg99bp1JyIycC7w7CPSGeAviaIdQx+g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/An0o0c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/An0o0c"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B85E0C4CEE3
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jan 2025 18:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736446525;
	bh=o8Tte81nNVdJQdhmjggrHfC8rhNDWBegYzke+2nrPJ4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=P/An0o0cCE57UCSDAdsXeaKhTQM6GwQo+YlvNWuLruGr4RUeY4EhOkfzA23JAdIIR
	 p4IqPv15tCbODXr/glOexkA5Yr89cJ9Db6OEP3gpzgvg9eIvht/lNEyUagpAENcVtR
	 cqTKCVIZge7sN2lv2v9Ks3JgHAoprMWbKV0Si1/wFn3bdDvw26fwCn6C7tPC51K2MI
	 6tbS048hOCwqnzIRdvfpyYfg93z7hjp7r/E/G6AgJuC//3OTAuLsB5MsQzZFSQQvKq
	 IlCTIznnBdCNocTaYAug1EAbHUQyQLVH4Cisc2SzuW26mzeEYEcjkI0pmgzqs3UTAC
	 OBJBJaD+C871g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AE8C2C3279F; Thu,  9 Jan 2025 18:15:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219514] PC does not resume from suspend, bisect points to
 btusb/mediatek
Date: Thu, 09 Jan 2025 18:15:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: olivier@croquette.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219514-62941-HJl7GPPHBQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219514-62941@https.bugzilla.kernel.org/>
References: <bug-219514-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219514

--- Comment #14 from Olivier Croquette (olivier@croquette.de) ---
Thanks for the info, this is the commit then:

commit f5c5661f02b5539d88aea8497f8d0835d165e945
Author: Chris Lu <chris.lu@mediatek.com>
Date:   Mon Sep 23 16:47:05 2024 +0800

    Bluetooth: btusb: mediatek: change the conditions for ISO interface

    commit defc33b5541e0a7e45cc2d99d72fbe80a597afc5 upstream.

    Change conditions for Bluetooth driver claiming and releasing usb
    ISO interface for MediaTek ISO data transmission.

    Signed-off-by: Chris Lu <chris.lu@mediatek.com>
    Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Cc: Fedor Pchelkin <boddah8794@gmail.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

One more discussion about this issue:
https://www.reddit.com/r/Fedora/comments/1hv281d/mt7922_no_longer_causes_ke=
rnel_panic_on_resume/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
