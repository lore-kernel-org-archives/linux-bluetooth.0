Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B29F25F7BA
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745853123; cv=none; b=r2zrdOqe3wEBRr1neTdoVQbHMKIUDcKHnDE21fk5/AAHlKl7ICizZq10nLyqw7gb29tMBLMxHnKBRkI9oOKQPhZTkBX22hCh9G7WrTuRBsgBhIgmEQymY/HBJSGz+39s2ABqXLGM35O5l7oOyGOrLFfB2s9FIWZPaSmeGAojLX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745853123; c=relaxed/simple;
	bh=rbJItRYVDx5w8wVmi0/5epgOr0lpzod1Us4qSiFtVHE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Leca6gMdNR9iKtctu8Dg66BVte8A5hAZR4IY7O8TmeO8e7TcRRihCp2uMbjvrj9ZmiyBn3CFKDX56GDZX75olv4CzNphIsjPYHsHMfUV2u6m9EGEWANkjDWhieFkDTZhK8Yf/9fJlsz8fUMnZRpurjCAau8puCeip02XOomAQuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUWlRmHP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUWlRmHP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85ECAC4CEE4
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 15:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745853122;
	bh=rbJItRYVDx5w8wVmi0/5epgOr0lpzod1Us4qSiFtVHE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gUWlRmHP199ZpMLRP+XZKD3CAzk6M65SNnxiVZjIpd9oOz3a9MtBU3PjJwFQ/LuRR
	 9OH+JYugaRVaCFu3awGl8G5qdSIMylhtNLhty6XSFvCo6zLq0BzaulDtX4iTHgkTF9
	 o4T+5VU7i2wHUYNIe1DhG3qnpm2e0dMpzBOn7FQWaFJnkjhqKApUn5GUPi+pfJbFYY
	 n8tIoF4LZzcO4a3KfBPgo5WOkxOeNFLo18bVSsnO1/RVCGKXlVjKMjepHgGggVL16O
	 ctKVS3PYWnlv7eoaVV2GdjoB6k2sJ+SvXqv0vMn0G/bykDc+6omNtFyXzkQ1zn3owy
	 FhTtnGS2DqpfQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7EDDBC4160E; Mon, 28 Apr 2025 15:12:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220061] [REGRESSION, BISECTED] Multiple Bluetooth devices
 cannot be paired under Linux 6.14.4
Date: Mon, 28 Apr 2025 15:12:02 +0000
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
X-Bugzilla-Changed-Fields: cf_bisect_commit cf_kernel_version cf_regression
Message-ID: <bug-220061-62941-ulLlSoCgFP@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Bisected commit-id|                            |d4ca2fd218caafbf50e3343ba12
                   |                            |60c6a23b5676a
     Kernel Version|                            |6.14.4
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
