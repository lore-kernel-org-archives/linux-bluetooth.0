Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9531217E0
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jan 2025 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736153587; cv=none; b=lGF0q2keEzPMbaOdVrGyr8PMOOMYn3lZxlgJi1MJ2qXy/9c590T+Zo95UWeHkChwHnLfTnGhA0KhgUxHj39EY50y9lYo33TfL/4Rlz5QpD2X7cStEPyLb4L+F3/CJ4vQ6fHL1W2vjQXgX6xtCQASAT8dYJSqAlQIQsH9XitROMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736153587; c=relaxed/simple;
	bh=9n16ewwA9FCuei/47/TGUk2+Pu3+3jtGK0wj1rmrIX4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RK+ajZYVdY2TEOwlqMIA06mlX1DSoCe5cBb03gVa9PCB6j10TISslEs57C1rl6sDmWF7bdOn7VYNIq/TZpHdwBoaoibB9ohh1tV1GK/R4yvtyxMWNVaHCl9whGmUMAAFed1rjI+ClLC0goK90ECKe3r4yLhGjWeGp1m6cC8vy3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJLaDrdQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJLaDrdQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EEACC4CEE3
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jan 2025 08:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736153586;
	bh=9n16ewwA9FCuei/47/TGUk2+Pu3+3jtGK0wj1rmrIX4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QJLaDrdQhHHaGKYb7TQoqIHwXJH4Yhemp6O8Ql2vZwsEkg0Hi0WIDEsws8QZ/iK2Z
	 vUm37wIKKEfORGoHj/k/aE6Jbc6Lb6Ey61EBKDRu1J3zN43RI5LcpSdkX355bb9yBN
	 zRv3O06PZVFWTHV1i5OY7FaCPwTQnwvDnFjBxJdz4fKzN1DNM3fik2pM4lNfa+QlXM
	 iFHktpNr6yhY2ZR0O/sWKCt2E5cnSobaDUiVQNzqOmaoOFUGmkabjGsBUY/svffDd2
	 oGzQWNdNtGGS1iMHZqkYIYpWrGVX0pLJdC2bKHlWCraaFfApGmHzBg2AljqCV7HovV
	 kjtgHEwW1wteQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2D2BFC41612; Mon,  6 Jan 2025 08:53:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219514] PC does not resume from suspend, bisect points to
 btusb/mediatek
Date: Mon, 06 Jan 2025 08:53:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bojan@kseneman.si
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219514-62941-zRCML3FzjY@https.bugzilla.kernel.org/>
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

Bojan Kseneman (bojan@kseneman.si) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bojan@kseneman.si

--- Comment #8 from Bojan Kseneman (bojan@kseneman.si) ---
If you also need to kill wifi you should replace the "rfkill block bluetoot=
h"
with "rfkill block all" in the script, it should kill both BT & Wifi

Anyway, I've installed kernel 6.12.8 today and disabled the service and can=
not
reproduce this issue anymore. Can someone else also confirm this?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
