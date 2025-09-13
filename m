Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0154E1DDDD
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Sep 2025 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757778134; cv=none; b=UysjCKwAYQv0mL5gxv0Cx6NZUUO7qsjlWY+fcYxJZPnuHNlQvlyEUKWFw//jsYRKSK3hwM9/4XZ8WDoeONqjH29AExmY6RyiPW2KHOSQ4chy7XjjaF0HAILY1yMd5pnwvg+MPR8shYvmfiOLpmoxgssW5B6emVJpsu7Tq74okCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757778134; c=relaxed/simple;
	bh=JJoIYBXUANSX7tVFJ6i/BtAGaVzcwW4zPCpdkRoQ+ng=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q3psE47QPtjZM4b93efvjzWeZBXXVrfqAGFJUV1e16y5KMY77wMUh0dlG1NfR9D3u4bIxLAmRD7PdXR8u2iqJMjXw9MHk24ESumMPsbIA9TaOkryTcXAWDtqbyhupWr60mJCWEAdJVJB/qD3n6hUu/S1xB8kaPHM3Cp4I/Oba5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSw6Nll/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSw6Nll/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88D97C4CEF5
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Sep 2025 15:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757778133;
	bh=JJoIYBXUANSX7tVFJ6i/BtAGaVzcwW4zPCpdkRoQ+ng=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kSw6Nll/8N/c6cN7bjsbULgXzHOlQCeuouKJGEf8/0p5pqvKD09U4Ge4wS9piiVxk
	 +6e06g4SGstTeq/4mqS2XheYyqdwz6AURSgeThn62sjXurWiWG1T+A+PlTDUXfh2ZX
	 W3uxqJDvlZdTMUAGyvCCyRj9u+PwoWi03Z53MNWZZOCW9X7HAT7P/nEuEFlaE/EG08
	 Vj9jtzTDsq/ZamZ3o0zEmV69+6ge3ypsfsmLRo865WtKDKPwEcph3h2FtIiYUBWWO5
	 I8Ji9IWcregXeyh4OMtXNfuYQdp1MESTsmIdpKjXuqdW4n1DeLyPk1ZWO67RhDwMZY
	 Nlk7sMgQRpLWQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 75E6AC433E1; Sat, 13 Sep 2025 15:42:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220564] Wrong indentification of Bluetooth in Lenovo Legion Pro
 5 16IAX10 and 0489:e111 Foxconn / Hon Hai Wireless_Device
Date: Sat, 13 Sep 2025 15:42:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jcubic@onet.pl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220564-62941-jWNuYGqp6b@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220564-62941@https.bugzilla.kernel.org/>
References: <bug-220564-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220564

--- Comment #1 from Jakub Jankiewicz (jcubic@onet.pl) ---
The issue is solved in 6.16.7-200.fc42.x86_64 package.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
