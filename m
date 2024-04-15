Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9E72E83C
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713176284; cv=none; b=Tnzp6hA7UCrBKMdG0JkdREzUkGrKgdBncnZDhlWrlR8G/w0U2fS57p+OqXkilzk+N1sHhz/lpBKRWCrzvS8mEmDkui97zsZfmVYg8dNptCQx2kMd6yx1NF0T52cU0HRALCMcWsxUbpxokdEymIT5YMwWr2xNpPjMjvNVa7OgGOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713176284; c=relaxed/simple;
	bh=oLDlnEoUzLd1kbT1Zj5f1yD46yev/uUQpYqr3sOL8hg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P7dK16GoBx8zIc5dfsA1tOjILIARR+9ebhlRwCsW/sasU+nLmvAFKE6BmVBxRd4wbNu+RhUCTyq8q4DVQ6Dnj6Ci8rijk12qixXs75YNI7SiVXgxAmpYYFhj4aOFStm/SmA/smfpzxdE6+n20NOXyejHQ9u07s8K4W4IFG4Zyh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r05VxjxW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r05VxjxW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F0C9C2BD11
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 10:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713176284;
	bh=oLDlnEoUzLd1kbT1Zj5f1yD46yev/uUQpYqr3sOL8hg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=r05VxjxW2mJKLQBVvmv/0teZgtrknG9cjiPgequqK/cYy8wHUqzMkRGPQL7DiEkDQ
	 iJJ075dUO6GfaxLrcZTPYaDWdub8xTlfLKsNoMpbfSXaKXiXChQdCigYZNE+84odFa
	 lqjLv0rJeO3nrq/t0drA8YNMr5tkn78FSfbf+AbaUoCY6ON4HYGHrXIe4uLTq0BWj9
	 M4iwY5/FvY7Mkv94lw07xPKIa6R97xUUdChU4FtabofPV7KnejIlSU5wio3r9S2Y/F
	 NyndTGCwXtkLNO6R1b1vBEFFroH0/rNjxwKNtnACGuNcnRwLUw6mdOhQNeTk2FvzDB
	 RYElT+Y6m2P5w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2F88FC433E2; Mon, 15 Apr 2024 10:18:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Mon, 15 Apr 2024 10:18:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: quic_zijuhu@quicinc.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-zJ2T0MhJtu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218726-62941@https.bugzilla.kernel.org/>
References: <bug-218726-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218726

--- Comment #7 from Zijun Hu (quic_zijuhu@quicinc.com) ---
the new patchset is
https://patchwork.kernel.org/project/bluetooth/patch/1713175927-13093-1-git=
-send-email-quic_zijuhu@quicinc.com/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
