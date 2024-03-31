Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774D91E88C
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 Mar 2024 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711900129; cv=none; b=uifhRiuebSexaNtfpQJ4T19AuvJHQQSkfvaXW2hJIkgFJuFLheOt4EUQ4vyznfa77LRSlJUD+QeagqlSlsZcJ8hJ0XZmUEG9T1hIjL9J51s9TBgNT3ypH/yTDztzUZBIHpvBMsLyK6TDlMWtGVSwINHLyIA9x7C0B0ACmcV1gVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711900129; c=relaxed/simple;
	bh=IDGqOedMBSgstM9fm1BDnqJgIzydYlIyr/QjmlQKSNY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rkESrV1qks+5OBuninRdb2FXUu21RoLYPbVccw6IaXvgbxCjOoc7p1F7EQpIVRJfVSkXwhoRMwbJyGJF6SqEw/AN7IH3ilgpXoKfDH/jrK7UZAfar41frn0KQsKreqQTcmUk+etlffFhqdQ+3MDCB+k/EMVcxAdMNwK8NPXQNBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW86aypD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW86aypD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FB6BC43390
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 Mar 2024 15:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711900129;
	bh=IDGqOedMBSgstM9fm1BDnqJgIzydYlIyr/QjmlQKSNY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NW86aypDoof3/1D/ypqIQeNzH7LVlExNwqqzTvu/zUcess14zG5YPSasIV724NgkE
	 b2C7D/yta3wo8WsDN9bYQWewYvOe53yyl526hT8j0pS/334IU45ncVXG/TRJ8m+qMX
	 2mUWdWbvyM6qTqwHmiKZyh0RMrCuDizejU89rpSm+6lbYBL0VEou1QqkUTxZuzMUjG
	 q12cFg5yxgZ4H0szgiNoBUhp4MR5XOj6WUou5If5C13qKpntBs47Bdz9G0/utIUiLt
	 d5vnSfwHUD0ovAd2o5lFaH9gdiFoLmh867QqOi6fSLGqslORrwXGI64dMu+SEZ+oyu
	 jfUzG/ccU5Waw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 122C9C53BD7; Sun, 31 Mar 2024 15:48:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Sun, 31 Mar 2024 15:48:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: wolf.seifert@web.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218651-62941-jhtuJ1YAy1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218651-62941@https.bugzilla.kernel.org/>
References: <bug-218651-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218651

wolf.seifert@web.de changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |wolf.seifert@web.de

--- Comment #17 from wolf.seifert@web.de ---
(In reply to The Linux kernel's regression tracker (Thorsten Leemhuis) from
comment #12)
> From the bisection and the oops it's pretty like a duplicate of
> https://lore.kernel.org/all/08275279-7462-4f4a-a0ee-8aa015f829bc@leemhuis.
> info/
>=20
> Then this patch should help (which might only get to Linus next Thursday):
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/
> ?id=3D1c3366abdbe884

Although the git bisect gave the same git commit, the problem is probably
different and the suggested fix did not work.

See
https://bbs.archlinux.org/viewtopic.php?pid=3D2161135#p2161135
for details.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
