Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C779718DB03
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748519443; cv=none; b=gy4rWiqOS5u9XvZld/4JTttaez34XqZDduvb+grlGcTYAA5TO7Bq/VFiwDZ+rsR7trRxR9CMbaGC+f+DjqNj16fzEN458yu1vunFPYheZrJ2OX9SSCImYY6WUNSWCA3+NujCGbG9ltYkIMFcZ8XXevdC3SIPv2ydlVVD1tfpews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748519443; c=relaxed/simple;
	bh=EwnDoAVTMehqL2EaHnBlkmLIdIZBw9jWKBmIJojAFgc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oHoL8WkaOQrppl2d/YN0ELTU0h7eHCf2we/CnmcLY5PQw6sRf3jbBNlxve+WM2MiNE1ZXNvIb5nWgix9fj6lpWLubXObmlbCtMsj+4zVerqX6n7NdSUgKYnCtdyMvrevitMdUUM2wvsWhZL7NH5GMXMHP1zAQAA9s0Osqm3VkTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSf4So66; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSf4So66"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41ED9C4CEE7
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 11:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748519443;
	bh=EwnDoAVTMehqL2EaHnBlkmLIdIZBw9jWKBmIJojAFgc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iSf4So66GDsfR0qoo9yxRNfGoSj1+icg+lGjcMjbWxXr2+7+fNM8YJU/R4ihxDD6q
	 fCL3uXZkvN7dJmWuxt4PjXPIDLtRUB5Oa6MEhfS2MXgzRxBjIhPLocRvDSIHRpmwsM
	 vnW3oDn6OtCXHlOotfpgxPECt/vmQuL5bn5l99nv8fgS+ztogi8yWQiSWUsTaDIq3L
	 6Kf4X/6+AdfE0ldv6F7vZ8E7qXyGwez7kORk1tQ27K1NNucVJVGDytljH15F6WsPU7
	 TVpfnCHd29uXjZgtihfMcbpqjF+LhkiPwao929tVQGlX4DoyI2KvebPCEbXsXRgI7E
	 WjJIb8jcVqdzQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 314FEC3279F; Thu, 29 May 2025 11:50:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220173] Bluetooth: hci0: command 0x1004 tx timeout
Date: Thu, 29 May 2025 11:50:43 +0000
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
X-Bugzilla-Resolution: INSUFFICIENT_DATA
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-220173-62941-RfxYzPW1Fz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220173-62941@https.bugzilla.kernel.org/>
References: <bug-220173-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220173

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INSUFFICIENT_DATA

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
