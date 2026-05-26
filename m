Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C223CCFA6
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779782030; cv=none; b=GR45FK146K6NSnD859qoX3bfUiwn99zmFQH2xvYeTwdA4iTUeuRQfP6WraCiBz9B3ccVkNVAvAQg3smi4vWHUlsxJcW3HzbvHG8fSi+UxK+U7PCczcXtz2FS3fJS7B21LePGK2sq/MzMHG0fyNnbOf4bx5Phl9OSghNKbXSevig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779782030; c=relaxed/simple;
	bh=movrjejQbrQZ+D31seEGrf/Jwy+UCNjedyWb6qt6CJo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r18wpY4u1djFwskZwNZZSPRzjUS5/nD/wBMQ74lUDc3kuq5rWw3wlASt248b8nYS/R9pM4ALcstQmYsnLRlVPw1J471l9z4R+dDIx1KzUgfW7PHOsX5laVkVmKsRg8HPe0TU/+6QbDzarqI7iShaTxyDt30x6R2GHYzLIlO0Zgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Khqm/D5b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Khqm/D5b"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA62FC2BCF4
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 07:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779782029;
	bh=movrjejQbrQZ+D31seEGrf/Jwy+UCNjedyWb6qt6CJo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Khqm/D5b/bUy3NfuANWHd332TBlCxfNdjeedT28K2yip7SGGPV1OfOurJzppKIFpo
	 ftahxLv7z4looGGEDYhdSIqwTzBxrmM/R3LnFtV1s/ovIQseYxSQTKt713HC98dtku
	 8TiGH6T2ec1In3PkBsv03hjG1ga/SwXz391sEyfarOU/Jc8s5gN5eEMV27XEbSITRz
	 IpEzkkHRZVCmtzrPUQ83qTuJIvgYW/hi02RIW3Wt4s/kR4Y02ra3gVN+/Fs5LpChtf
	 wTNt/lAx0jvdfLAzxKagj+tki6zEV7N3/7d7rJe0RFaOL2kM7FHP9/h9L07AkC/1tn
	 iq5g3b+d+pc8Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C8FB9C53BBF; Tue, 26 May 2026 07:53:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221576] btmtk: MT7925 USB Bluetooth fails with "Failed to send
 wmt func ctrl (-22)" since kernel 7.0.7
Date: Tue, 26 May 2026 07:53:49 +0000
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
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221576-62941-otSeIN8LWo@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221576-62941@https.bugzilla.kernel.org/>
References: <bug-221576-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221576

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |DUPLICATE

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
This is fixed in 7.0.10.

*** This bug has been marked as a duplicate of bug 221521 ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
