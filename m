Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE67345CDA
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272577; cv=none; b=SpAELjyyX6/uALlRuE9vViUkbP2b8xK5bqMK2j8WoWJClod2ABNm9sPb31Dyod9guO5HkVVnlF10pIKn9FmNXPsMqfyMLVy61oqY2uUyPPj0SRCb8b2wr5++9PY1Tke2S/m+4+uMFAf22yf2zQHK7hN24z/mHZDxofF6e5/Q3fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272577; c=relaxed/simple;
	bh=jfT+32ceXyfVHVZKsSWc+15wxEnc750aFyXkcmgLQ+8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qZ2ULOoi7QA2qzDw1Ga/IDc2BoOrbJ+qmuO2s73qQLqrFaLecW7cLA5Z+ux+GIIB+bpoSIWIDfQcoJwnAmahma81hYwl2onxEUu+OEl5cxc4DbYmz29S21Or9eEMlmfPWEqts6qOTFT9d1nxxuaH39DIor6KQQ17f5GeHnMeXL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGH7Y26+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGH7Y26+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B9F2C4AF10
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 13:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781272577;
	bh=jfT+32ceXyfVHVZKsSWc+15wxEnc750aFyXkcmgLQ+8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NGH7Y26+ElF/7ZG/vNC0zL+zUC6fDEGX1jU1ZrGLuW2V3QpWBa0qkfCi6I6ovajqy
	 59qO8ZRD1lp1Q2ds35AXJjdNl28fhHr1+M5wSqOxSjdjX7kJlMuC4mpVFpbZq/4lCw
	 5XK7RcTqmO5k6UpAcBfAPFSpHos9Ch/Vz4pMnebS7rz0D4cU3NJn8Oa6MZPNUpr8Rx
	 xsAiigsZWBug1/7oTSYi7NqVW+sQSZbqaoetkyfNhDUQZ0snpByUovntLcbR+mdciR
	 YHKbQ/d17b6rHjleDS359NMnEd4HSvkeBDkxRQNl1pPaXcxJNaB2vrZHoqUb8AnVS5
	 TktPsB2zu27KA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 22C58C53BC9; Fri, 12 Jun 2026 13:56:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 73081] Fail to setup Bluetooth on Dell Venue 11 Pro
Date: Fri, 12 Jun 2026 13:56:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-73081-62941-ULK5svJmRE@https.bugzilla.kernel.org/>
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

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #5 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Puh, that is an old issue, and no attachments. Please attach the output of
`dmesg` and all other things asked for if you create a new issue in
https://github.com/bluez/bluez/issues.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
