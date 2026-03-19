Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7183793AB
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 23:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773964358; cv=none; b=bLT7gMn5vHUvxhXn7X4K/YDDjGQFqgig3+ZuJ8RU2RG2bsjs0bcgpN8QUmFYbLOOydUcW07BO/PQXTbxn3eQ5RHFfBb49oQNMmxQxBEj//8hWVoVZ2GgU9UipU4vZnfF/e6cGrsGGt02rrvi+ijgiMwHo3qnwi22MO3wfxKRsJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773964358; c=relaxed/simple;
	bh=HxecqbEq1C1QaNQaResq0CWoOwqcc0mzxNqC9lGm5uU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bUPzxNGi6MrdyK82RjtZGnm7FG2y9l0CtBj+6zt+yh3TDMNcNx3jn+HNCXZiEhM95Xw3zpSL6rHSpK1PbdUIKOvTaMApzzXjrLDbxiz9B7eeZ9ZDiO7UbKSlh+ZSnUO/4LErRlKn8puMZIBDeuGGE7OthYQX7JTogATyMIwy+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oatsn5fk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oatsn5fk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1931AC19424
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 23:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773964358;
	bh=HxecqbEq1C1QaNQaResq0CWoOwqcc0mzxNqC9lGm5uU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oatsn5fkUo8hIwW6enujWn+VGNChQUa0uBqr1bvk/OfjRdtmPTYuskvxitvL0x0Ws
	 wl+5dtY2qc7rYD/e1LJ7bX21uL2q1Y6V3OoMf4JyYeJhgH/349B3iVdEaq+G597KvP
	 nyQas5MNFX15QEzHjbu5giX42kZVa8FRrhmQEAbmEePxF0mFv79p9+DzjssKrcbf4V
	 aUti071vKV5h/G0vcm0rOuTAP/4hbrWBTUZpYB1gUqJkW5KskelCx7i6lh+Q1tdB4a
	 ZF/HvH6d65V6n9rYcDlepMO50rUh4/juqMapvxs7HAq3tvRr+mGJwQ8zrELHKT++0g
	 dZAb3EamfGN6A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 144C9C3279F; Thu, 19 Mar 2026 23:52:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221263] HID: Apple Magic Mouse 2 (BT 0x004C:0x0323) reports
 wrong battery percentage -- hidinput_query_battery_capacity() reads buf[1]   
 (status byte) instead of buf[2] (AbsoluteStateOfCharge)
Date: Thu, 19 Mar 2026 23:52:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wh6cyy@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221263-62941-6zFkSUzMCK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221263-62941@https.bugzilla.kernel.org/>
References: <bug-221263-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221263

--- Comment #1 from will (wh6cyy@gmail.com) ---
The bug also existed on Fedora Asahi 42.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
