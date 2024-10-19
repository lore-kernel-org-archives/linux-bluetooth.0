Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C8D2629D
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Oct 2024 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729341405; cv=none; b=TLN8rXoFwR7++TpLJWvcVcSTaD1g0ceiQoh3CXvfXx/351D2tgvmZQz4sojWD42JKVHtU0HGSY5mkj5su9Ry0De/3sdbY3FrwPnaAJmDJuYWHYqu8LA5lQytoT5oOHo+UkufdZ6zCt7FX6WSa4+9oIbEU8+N9oIZpPJ7Qym5WOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729341405; c=relaxed/simple;
	bh=CZZV8sxvhdquotpBhryZdsY7o/q8zz743jdFuQYbIu8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cVtuKLrgyOg8PsdFN/S0+0cbA73HsyB9x4PFLuGM15KyEek5MB7CCiL9VjcMPeHYVCOc9mBKditsdY7pUFzHYDSOnuNlMaZQLC47P8jF0wes+8YtZ/tUndvrx6Ae8IbHov1hBBVmD5oc1RztIULYimissPqegffNCKN2zkrSwqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8SeqX0k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8SeqX0k"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB871C4CED0
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Oct 2024 12:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729341404;
	bh=CZZV8sxvhdquotpBhryZdsY7o/q8zz743jdFuQYbIu8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=V8SeqX0kxRAhXghf9NNyDyiORi7DYC1ZMqS36Vg70KBsVx+ex09jbjixhcOjnH/c1
	 sspb3RwhJKvHN5GeZ8rRmPPona/eDpHw6pAYPyrCntpFtgEozsjjr/8BMOXjbkuD5q
	 pKJTWH0t6I5t2EYpGxKUfm9ClQ7777rb3Ijcay5UmlHAQM6R/o5v7FzEjMr3LlHOPt
	 Gh1Jnl9eQTMs+MLUrHYeuJVYc6SYixv31bC2+Oz/d3wfiaBBrSh7Icf5zdbQ74AXF6
	 z88NavLy9s8u/zi1STz9fH7sI7OnhghhNNX+YQvK7KW6EsTLrxQUmC7UY5mOoIZqnQ
	 42UKXIknMPDhg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BE43BC53BCB; Sat, 19 Oct 2024 12:36:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219385] BT mouse can not be found and/or connected in 6.12-rc3
Date: Sat, 19 Oct 2024 12:36:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rkeller@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219385-62941-v3d8p1kSuy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219385-62941@https.bugzilla.kernel.org/>
References: <bug-219385-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219385

Rodolphe Keller (rkeller@mailbox.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |rkeller@mailbox.org

--- Comment #5 from Rodolphe Keller (rkeller@mailbox.org) ---
I have the same problem here, on an Acer Swift SF314-54-53QH. According to
lsusb the affected material is : "ID 8087:0a2a Intel Corp. Bluetooth wirele=
ss
interface". The mouse trying to connect is a Logitech M240. But it looks li=
ke
the bluetooth controller is unable to scan its whole environment.

I have NOT the problem with another laptop (Dell Latitude 7490) which conne=
cts
with a mouse of the same brand (Logitech M240). The bluetooth controller is
nearly the same but slightly different: "8087:0a2b Intel Corp. Bluetooth
wireless" (note the different product identifier).

Note: I have the problem starting with Linux-6.11.4 (Archlinux flavor) so f=
or
now I stick with 6.11.3.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
