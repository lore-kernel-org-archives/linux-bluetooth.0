Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071F93385A1
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781805392; cv=none; b=EstiQ1/r6SXG8uHCO4WMxNY2QiMV28wPvIJxX7TbCT0xZkG98u41hZylOrPqEOqqEIPZN8xoPEH78YtKAXAPBREy7GUmYUR+n1M2r978BnwwPCAgJ8DUoxsb6bnNKbphUmEG+VYQpc0d7oKwv656PhMr7KYYzo32SxKNNswtwtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781805392; c=relaxed/simple;
	bh=V3GzmGmXcJsXuSUdO7SOiYcYwg5fzI573/fhv1Q1rww=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QbRh36aj46dqJCXWMlsBxnQn5BLuA4gsBmvDJ6Q2IRUbRqnz1bcXT1FJbnqgK+ijUzlqRwgti82DAQ98/r9IArfV1Bgpk1mljaJ8/CRPoExpgVkvBqjTqRIZfA/dTWkIF8dWNgPTN++2AgVFY6Zk0vPmQYESmECC2SAk8AGf4+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMw9E21S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMw9E21S"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85398C2BCF5
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 17:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781805391;
	bh=V3GzmGmXcJsXuSUdO7SOiYcYwg5fzI573/fhv1Q1rww=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dMw9E21STfZ8yoOu/IYDgc/BvejmmwP9qf6vQHqnR16CcZ5pwwIXwqfWr4ZNRrLGj
	 MDEx3hqZjOaTaRkVrYT5zjBRjTl7L8snVVDXo5n2vjMrQcfqAiuuzjRYluVTNPzbZn
	 qvFWFDOre39psRe5N/LD5PDwS69Tg536ikqoVDkvbEfrfl8P4tMve47lrva6XmKwQV
	 HbzAJ6YAHnkMuLB0UCXkErE7H3hcTdzKZpC3rvTW/9hWhfZq5HGbjgQCikv9IN2aA6
	 jGbCtj6Sygr7dJGDyPJP+XdMYy5XApxDYBuRxLExfbs1861JI9VA+i0DQW1zXdykGd
	 HTYuxeyZ5319w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 77372C41614; Thu, 18 Jun 2026 17:56:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221666] Regression in 7.1: Kernel Oops in
 hidinput_setup_battery (hid_microsoft) causing uhid deadlock when pairing
 Xbox controller
Date: Thu, 18 Jun 2026 17:56:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Input Devices
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: bugzilla@hadess.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_input-devices@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc component assigned_to
Message-ID: <bug-221666-62941-EYIegpjhHv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221666-62941@https.bugzilla.kernel.org/>
References: <bug-221666-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221666

Bastien Nocera (bugzilla@hadess.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bugzilla@hadess.net
          Component|Bluetooth                   |Input Devices
           Assignee|linux-bluetooth@vger.kernel |drivers_input-devices@kerne
                   |.org                        |l-bugs.osdl.org

--- Comment #1 from Bastien Nocera (bugzilla@hadess.net) ---
Does your kernel have this patch?

https://lore.kernel.org/all/20260602030519.3097058-1-rafael@rcpassos.me/=20

I'll reassign to the HID subsystem as that's where the original problem lie=
s.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
