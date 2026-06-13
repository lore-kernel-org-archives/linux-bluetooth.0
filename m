Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC53E30ACE6
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 06:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333859; cv=none; b=aOjgqo37jfEJz9qIg9N1kctceACfuzkmi/ZBJN31/4Xeyj81zysuB8nU6vvjsXUG7eA8pvKdxKFF0vCtqovy2zh5Lw1/qhy0RbN4ToHLLxY2l+aQ2wK2Cii+1siaTaOxfNC3DiiwqH7TA3YqnOXZMNqcZZmGNMvjfTjrJ4I8J3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333859; c=relaxed/simple;
	bh=qgjxqvq1vaibo1ee8v+o9dbwVFGVUHQkmUCMWwstUIo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tnsl+01RBdLmnpsX+QpM4ze3md7PFi6LsKJR68/zHG99hPgY82fFPHLDAVQg4XcoL/x8RRopO75gDlhEv73G00LQNiXHay2hlKMbPcKt/7tbmR+Y0mip28/jv44Fuh0isJGJI1qgnUSgD531DBxtD5IW1Gq5FsOy/QkOr8xfwhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAvp5HhM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAvp5HhM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62C10C19425
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 06:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781333859;
	bh=qgjxqvq1vaibo1ee8v+o9dbwVFGVUHQkmUCMWwstUIo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XAvp5HhM/hCascc0UaIkxA6YOrKMp+GxxCoLrA7uWSOXlaGCw4ifovqgeJ+o3efqf
	 rYIJUiioEs0NkPu8um2VQk4NrGFMzD8uNR7GbCuS/morhkOErXOdJp/8VbZ0Usfwm2
	 y1K6USG0EvWqAzOfVn8HTBDFsuwGXq88pO+0n+iGVZ3M6zG1i6cdLjwPv9r80ovf8W
	 G7eiPfGGieKMGV9m8w0on4iv31DW9ZGJ/nZHpDJavnIKqPKnvK7X2kC/45CWDSeV7M
	 9+aw6EYKQwpOctkXr5U17/XKtqi+dxloewfQI5p+jdzDQQ8KhE/L10CyS7oXkp41GK
	 DHTDp7SYw8Edg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 58F31C3279F; Sat, 13 Jun 2026 06:57:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 73081] Fail to setup Bluetooth on Dell Venue 11 Pro
Date: Sat, 13 Jun 2026 06:57:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hytham@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-73081-62941-wFsTR4PtNO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-73081-62941@https.bugzilla.kernel.org/>
References: <bug-73081-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D73081

--- Comment #9 from Hytham (hytham@gmail.com) ---
Hi Paul,

Yes, I confirmed that the kernel I already have in /boot has
CONFIG_SERIAL_DEV_BUG=3Dy.

Thanks,
Hytham

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
