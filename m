Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A733115C158
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Aug 2025 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754149396; cv=none; b=a8KBQg46v9gNMm0mhISxfa6G7ErqOW0nq5MlN3hU/ZF5fuD1HlPkJIR2PBWFNx9w5Xv6JcpZh41els2QVRElwwhir/J6IE4nWxAbNdmhjT2duugzdY4/DUNw1mboAy6VBYmbU4yyjWB5XkJCossjDEtbTfm5PkJpDX7QZD7acno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754149396; c=relaxed/simple;
	bh=xFdlY2HPGY5FgADWydcrOBKq3qOn64BVNawRybUepSU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QIrG3LxJf/6gLRMKLKlIiuwTrKJSvAz2NTiRgXwjhRAJ+i9dR2bpVDIG5lL5O2RGJlzyppKd877IrTrjJIBekhRb8EgCWxUuhyIKw1VAYQ/EfiiZJ3o2gMHVbLq7nNwNTRNFo/NjFUZM5bJLdSHkST6kJTu6yMzYPdRcMU9ajQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iz8Nd8tu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iz8Nd8tu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29140C4CEF8
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Aug 2025 15:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754149396;
	bh=xFdlY2HPGY5FgADWydcrOBKq3qOn64BVNawRybUepSU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Iz8Nd8tu0SMOWUSpOy4+uxz25f7jcwCn9EmAI4sWBHIyjzZaqUm/C1v8fzM3fgEjT
	 2dUlS4XHOW6K/kzNAODU/OYPvq1US0GBEwEtk2A0Q61x4VD7xj0UclZP8U2YvCMNZd
	 mxG0w9qMoj1a8mvmeR2V5ej4MgiYy304xToJiivqWUiHrQqYpapNO9b3X3FoAJzSAD
	 s1TYcfQHidhj6s6UGPQOfDYgzXr15MZG8Uw4MzaYyywDJwu/td/Iikk170zVUYmpiC
	 bIlBrvs2ls3eTKidq4maxz0uPcGCPDljbmUHqd/rtluRtKw4QV2qAvEbMDMyomUAx/
	 uWt+AiKk7KCcg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1C32FC41612; Sat,  2 Aug 2025 15:43:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220391] Headset is disconnected immediately
Date: Sat, 02 Aug 2025 15:43:15 +0000
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
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cf_kernel_version resolution
Message-ID: <bug-220391-62941-Y33N0JrN4P@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220391-62941@https.bugzilla.kernel.org/>
References: <bug-220391-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220391

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
     Kernel Version|                            |vmlinuz-6.8.0-64-generic
         Resolution|---                         |ANSWERED

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Vendor kernels are not supported here.

Please test kernel 6.16.0 with the latest firmware.

If that's reproducible please reopen.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
