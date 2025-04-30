Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D841D88D0
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 07:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745999509; cv=none; b=eE0IlocUVzFRYaNGBVMx/LWAK9qbR8kbNPvNT4Eg990HcJKAcQAUe6gLExdgL19/5lkcbhdVa0LqODH16aU22+Ni76i5aoLiHLANeg4fGI/COZf1NmAecqbiqlSAA3rdAAEq71A/1mwvtmoH+Q0aJlcgavTlTGxCu2FzBfU7vSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745999509; c=relaxed/simple;
	bh=lZAYrIdl9TQC97U34ByEPZcW4T4vljkHrQl+avdo+iI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s+6yvH+5IPxdoN1kiJ9SgXzd2eXg4Oj7HZxjmSMj5RhwNwXCfgk4cQ+tWknphB1t2mBCs8GGtgklZJAwfOgxlcgithlkz1lyKRBHPLkTSgul86ILtBM13vHGwNqPZPaRcbFvNGfz8MBZu1nKA3yTunxRQBys6OsfiaXzlRMTarg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vj7YIFi+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vj7YIFi+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B540C4CEF1
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 07:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745999508;
	bh=lZAYrIdl9TQC97U34ByEPZcW4T4vljkHrQl+avdo+iI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Vj7YIFi+yG/AAC45OCKu0kM1WL7+JdoRJoBGamrdAgr3lw32dsuaMpKU9x8QwzS43
	 6GAtWsvAGfBEz64V7n18LP9TB/OqesRQE/iPzh2vwkk5QzHEem/cp3q3fK5IPbP5zF
	 g96H+80VBsPWJSfv9plgCLjO5oY7VRBfozNRiMSUh3VtrVU4bx7luBz35N9VoDrlDS
	 uiP7UrxHoQW+1eBJk7o0OYnvdsspekP9UHb2zmWw/4RrKgf9ZHO95uD3OA73/B2lgJ
	 xej8QhuS58N/Qdj/yX2T49p8UuaH2HSJ+oKEjzPwwMn52wfhFC0KaFrQlrkJSZR01Y
	 /oUvyDnQc3dCA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4F759C4160E; Wed, 30 Apr 2025 07:51:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220061] [REGRESSION, BISECTED] Multiple Bluetooth devices
 cannot be paired under Linux 6.14.4
Date: Wed, 30 Apr 2025 07:51:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220061-62941-xdjdK72LIN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220061-62941@https.bugzilla.kernel.org/>
References: <bug-220061-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220061

--- Comment #6 from Artem S. Tashkinov (aros@gmx.com) ---
I have to admit Bluetooth has completely broken for me as well in 6.14.4.

If I don't connect to my BT speakers right on boot, I cannot pair with them=
 at
all.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
