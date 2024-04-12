Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFB014F9C6
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712952123; cv=none; b=g2GZLB3UlzAk7PYD5xy+RU46Znny8h3fT1UL7pYsWboCbVU7a8qTI31PhkmuIXpFbs6FcmHnw9nkZLGlzAsaQ+uHFRYy4DZp1CcuCqpDwZq6qOBmE+ETyOPq445ZxZpKibQlKRdBh7TqTw9CPl7qgPqBKF2UJT80lF5Mw8fvFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712952123; c=relaxed/simple;
	bh=dL5XO0/DI4hMfCKG7eqpa9+BmthpRE5I29Yl5KuWtUA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EjUe8Ua9wevD1GnLrAs+wIStsS7Vz85/+nxKYyTQywnh0uXLLiAvMUtsvxiRs5W3j8lCa+4pAhf8i16VSqPiAam+JBG4cyVcfNc1+ZQfZQJ3wJiX0MO4Xnh07kQrW0ep9E0rUwGYF5dP0ECU7O3yINZ1NAQQgK4+pfbbYbfYVUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deOoZd0a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deOoZd0a"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FE00C32781
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 20:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712952123;
	bh=dL5XO0/DI4hMfCKG7eqpa9+BmthpRE5I29Yl5KuWtUA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=deOoZd0aH4JamhrtKo4d6eZsuRsAhJu6I6QNM6XI6WZrIWf/JCRdR/9zN/n/abobv
	 xvOKTvnvlEFNNs4+IuIZTxTTVhAjzQtE1rsYdlypMqplsQjulyQ42qLkRVL4eyCX41
	 yyYqQzoCQWymEOhQN4WJ0LHnxfv3s7v8HcARyF/u71dS1eWOOTCQnPOAT1x1m54tdy
	 Ha/jSXOskkVmXF3XcUquG9tyuF/+8ys4AR4p7UZIJ2cIt1YkJWrKmHu+yKSXtdhtfU
	 XUqm5Ab+iXHJrni+MsbwCq0JpUsst7Q0vuqOgKZ7UCpjy6Y51qU9OI5N+i79eC2Dst
	 0msNDDguvdNpA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 44F4FC43230; Fri, 12 Apr 2024 20:02:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date: Fri, 12 Apr 2024 20:02:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216936-62941-2aTb1G2bda@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

--- Comment #22 from Artem S. Tashkinov (aros@gmx.com) ---
It's not a big issue that's why I kept it close.

I just wonder if it's possible to poll HW and ask it "Hey, do you already h=
ave
firmware uploaded?" because it surely looks like Linux tries to upload it
without much success twice only to fail and realize it's not necessary.

I'm not sure btqca is affected by the same issue and it's not like too many
people casually switch between OSes all the time.

At the same time AFAIK ALSA has quite a number of workarounds to deal with =
the
exact same situation: Windows initializes audio HW a certain way and then it
starts malfunctioning after rebooting into Linux. It was the case years ago,
I've not heard much if any about this recently.

TBO, it more looks like the case of Windows not using cold reboot (and AFAI=
K by
default Linux doesn't do it either) but why would it if e.g. makes booting
slower.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
