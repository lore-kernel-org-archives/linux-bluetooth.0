Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5851366
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jul 2024 01:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721525903; cv=none; b=O5JNLQwBLD+c2Us9aFRId/wqZRx08mdPCQw+eslGJmzrEyE03jwjOE/netNAt+QaN/tDxtdBTelMX5Qg3nF+Rm5oHSF1v8rDYKUqpIP7T6r2Y0qZLxcOJjyTqvZeDzZ9pVNBjDPH20Yn7PjlNXm73BwLxGesa8RASZichotE/m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721525903; c=relaxed/simple;
	bh=m2h8DGhO4JRNQzFecRUGYC4yuqs+UDKac/a64yRwujw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sgObXfDG5+o1S5tWoEWjltRov60sw3MQHHKKioSa+kaHn97U2PjxaglB7FSl7auS5HojHWEsl5MLD6aBjJaH1He11AxErB5VBVWKis3j+VMTDuaztzhPNV0ipb53z5vzsLDa2SPI7GL9wWOdAyomVqM9H6FyeYoecLaMcX+SXRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dctxM+NS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dctxM+NS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFEBEC4AF0C
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jul 2024 01:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721525903;
	bh=m2h8DGhO4JRNQzFecRUGYC4yuqs+UDKac/a64yRwujw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dctxM+NSCgyx/yOxqRJpfCz+ZbPVcWo5b+GToAHGm2uY/w9+TGfxV4hWkN6i8Z7Fj
	 0B/8D/aktJJnRjEokK7JkQC7JLfVoRjiD6zTk8b7PUXaPaEvlELF8mH6Li3mzcT4W9
	 obQcoLJ6bFfIOcitXivtMtU3m6RHwVpn6ASfTW+7JZxp6hX3yCLJNjsiHQroY20Sl/
	 WK6NN+eeGse5G+P3/BIIeAkCd+JAQDWwUV5O75LmcwTAfJeXRSmKp1DekxPkaCce4r
	 waicy3YF9hA/9eZwHvkYASRjq/R0hlW+WLxoybiEh3+MXX0Wjj5Z8mmV65Eiug6oeI
	 hm8v1N/cWwaZw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E0A39C53B73; Sun, 21 Jul 2024 01:38:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219057] dongle bluetooth does't work on linux mint
Date: Sun, 21 Jul 2024 01:38:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ricardo.andres.riquelmerios97@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219057-62941-UfrzqvIl1y@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219057-62941@https.bugzilla.kernel.org/>
References: <bug-219057-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219057

--- Comment #8 from ricardo (ricardo.andres.riquelmerios97@gmail.com) ---
https://pastebin.com/mNRqk97e

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
