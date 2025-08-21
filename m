Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F112E27EFFE
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786563; cv=none; b=kS8+R5XJxHU1QZOjkfP3SihEA02R1gDAQtWIV9Fc83Un6F0fhvoktad+fC3pQWGR6EgrTp3KKEoFUW7ahU3kRYfiUlHT0L5PUnEPiFXyqXUQmsO5RNvx+wlAZSL9dx/KKIqXTAn7ymjGx+XosZ2eoNsf8X6rW/RzFpYBhOTkJhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786563; c=relaxed/simple;
	bh=UNk09SsSmkwg/5xxsHGZmAXGcN3m2/87Ya0XGGzE8rE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FfbsFV4AUMB5ZsZ3yaYn25jjG7X18l7UjoJW5sBina+Q9/YEW7uJZk4mxMDUesS+MQl7Rp9xwFoaWplodhuey5JPmTJ5nZORu2aENY3kvJvAJbLFbpnMdpuH3PwUlTCCWsKnfQi1r7S3AtSuWFaOcNWKfydkNlXxP+YJMFTMl+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RinXyA+U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RinXyA+U"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 802D7C4CEF4
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 14:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786562;
	bh=UNk09SsSmkwg/5xxsHGZmAXGcN3m2/87Ya0XGGzE8rE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RinXyA+Unyq+IX15J6GH8LJ7hyC6S5HBs6+UMvvMCqv0Qblehn+5uUPFoe6Am5iNJ
	 r88YWAW7YcdfKEjHPIf4kYok7B45wwJvFYu5RVDLUtpRDIv0lSzabwlO1uXShIYBnk
	 Ms52H0LoSv2iWWspo/jvBjd7HtRHNf9ZvCGYakLnmLh8SUqkv6US8+1X2BRM80OI53
	 vG6dUthVDP1jPyIooGbaLdDovN7DJr1CATpeYKRO5g7FIq3zLfuUzDljKGjw/JB/9l
	 7l8eEpEj+6I0wubTJC7Ydm+Mm0NczXvix7oBN5o2NgFP9GYg4/he1kawuMriOUeZ1+
	 /CIJ/NaLuRwJA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 765F7C53BBF; Thu, 21 Aug 2025 14:29:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220341] Bluetooth crashes about 30-40 minutes after I connect
 my headphones:  "Bluetooth: hci0: Hardware error 0x0a"
Date: Thu, 21 Aug 2025 14:29:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: martin@hignett.net
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-220341-62941-ygwtLl8qL9@https.bugzilla.kernel.org/>
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

Martin Hignett (martin@hignett.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #20 from Martin Hignett (martin@hignett.net) ---
Its been a few weeks since I've experienced this issue. I have a feeling th=
at
one of that later 6.15.x releases fixed it, but I can't be sure which one.=
=20

I propose to close this ticket.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
