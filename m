Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F604101EC
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673093; cv=none; b=fklmMnZaxpiy2LBS5Q9/Wl8wdOuQP4mHQBf57iDxpa4cV71pDHHyLONYK4KUX/9QUAi7fasjqN9+V2QPi6rmWEgFr2w2ha9INh9nWU3V+1gLgEsvDeH5BfTM80cEb8l5vIP0Y07Tn+z5g/dym6lb5b7vU3V1Wo5ES5Z09Nok3fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673093; c=relaxed/simple;
	bh=8o7uX5H1D7Gl8pPUGiItxCcaFh3AV0dz7LDwAa8cgic=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GaBh4vc8TZ3Gh4kvQCXKERQaDkczBp3qGDpo8yWTupDuj64RQZD0AHXQbcG2P28qsyGF8UQljfNixGiuWA5JuHNQ8MGzsD2wXLoVJFPOjtXXSCJkqZ7Uqlk1/7jJNmT72esAsqp8KMBTfLlRF2MeLGaTdGBz4SU9OWQHhO/TVIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OztUS1tx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OztUS1tx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41203C433A6
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 14:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712673093;
	bh=8o7uX5H1D7Gl8pPUGiItxCcaFh3AV0dz7LDwAa8cgic=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OztUS1txGMWn0iFaPSH64JJ5XbqivKzOdQpvapy0+C5N2IGwEx48jSlfhxTdQEjtP
	 PlxthGwKzam9qk1vFQ3Po8Brq42OQ4ANW8UhTUN0MBLqhW2xHo7+2eC+z6YpmZ8ilI
	 K1z4vO6ad+KPg57isdS7No/i8vGR5NG5eBOmvEv0iWwF8vikqSyQBBZF7+2Vs3sASE
	 6cW73EqRFnsWR6nsWNWNQohr/wnHaBX8OYNOcHTSJITkw72z9vLrNepm2aX+/cQKbb
	 9Eb2Il6dec9y2I6IfLyPHFtYJTCZnTYPToQK6McAYQCEiadasK1hF319pH6/yk6cGv
	 9g5rG22CWMRxA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 395C9C53BD3; Tue,  9 Apr 2024 14:31:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Tue, 09 Apr 2024 14:31:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: agurenko@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218416-62941-rwIzpHGMzw@https.bugzilla.kernel.org/>
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

--- Comment #22 from Gurenko Alex (agurenko@protonmail.com) ---
(In reply to Nickolas Gupton from comment #21)
> Sorry, a typo in my last comment, firmware 20240312 is what I meant.

make sure you do full "power on - power off - power on" cycle **with fixed
kernel**, it's known that warm boot or older kernel somewhere in this cycle
prevent Bluetooth to recover.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
