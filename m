Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3365013D8B4
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592111; cv=none; b=AUOUG41gr5TTjdhS00J2bRwmRpprdU0L4I85al8JG2KucEuT2sFm7Gv1VomAmbOa9mznkhvc+HgFXev8F3HmsMtF23dUjFJHxluimJeLa7/uLTKeMcUVeQxM5z7K4RKS14ZWbh4Nv5t0STE1lZUT3cXMYsiPmLpR48EnHpk2aM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592111; c=relaxed/simple;
	bh=fc3yLe5xY+CuTk96B8vUoWm/QYF7PVaGBJ5SGck6B6E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qOgzQY8xlYtOrttMWL6t0XXFsZAbNpj+fPZWo8gyxA5Sw6ipOpwenrowltzNwbuc7ZpKRZhD6dfLjZrwh0gapWmyZnDOjzWb9sxaPHf4RbGTR9KNOFXZQ0/Q+rerbX8E4QzbuBzlcj0IWrYVtZFnSEUWX4w+FMNCdp9qhsP1M3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLCeh1v+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLCeh1v+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B65FCC4CEE6
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 10:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729592110;
	bh=fc3yLe5xY+CuTk96B8vUoWm/QYF7PVaGBJ5SGck6B6E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QLCeh1v+dN/vNdX37linntLseBTWZ9sCSG/MvDnpXEbKeW81hiTfxfJy8GwphweOc
	 NxAY3CudCwd1Rj49UENhPjW6azfETjvjTsFrlxWTJnFywPWVaVKqp8nxpEbK6iDAEo
	 7z6GCOxc8/+dfWHis6NZ6jB9iN5py318U7VjYnPF9A2cDZeqUu7jzv8Q8AZODuuFka
	 172LrDxXtuLNUDfBMQCQz49rpZ8g+cFaDW3rIMlF5YNIVL2PVrwa1ae+Ihku7+N2U1
	 F1wUuUlcXuzYrxdvgJTcrWxqPtPGmQS1tOiQoLl6rdQCHoD5hvxoNPA3H5g/nOgB14
	 /h3W0MV8K+a8Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AA05BC53BCB; Tue, 22 Oct 2024 10:15:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219405] [regression] mt7922 bluetooth scanning does not work in
 6.11.4
Date: Tue, 22 Oct 2024 10:15:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: eugene.shalygin@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219405-62941-P6VgDT8Ylt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219405-62941@https.bugzilla.kernel.org/>
References: <bug-219405-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219405

Eugene Shalygin (eugene.shalygin@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #5 from Eugene Shalygin (eugene.shalygin@gmail.com) ---
Thanks for the feedback! Can confirm 4084286151fc91cd093578f615bfb68f9efbbf=
cb
fixes this problem as well.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
