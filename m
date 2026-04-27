Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296723624DE
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 20:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320952; cv=none; b=UCeGKZgp/j3etQgB8h3duwf44ZQcJTmdjFv7BDhYvZn8dUUisK6GvPq0tHm3EMwjtt6Q9LEPCFFfRyxhU8Xo3EAkKXKVa5jfrmeeQz4pTFfD3MY2gtsEcq0ULFm+yuiaEpG+Ep0eWiqF12TYKKqWcolb39+U6DpUIZOPu09+mnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320952; c=relaxed/simple;
	bh=56f29bGLQjL5b+ZEJuVFipNoXeBI4SLZgm4fhgcKYFc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MfGuZ9pCSuEc6pestrw2HjRNjNFiUTMgCK4MYf7lr0Fcm0SCsJWA+GMV789P4ipleDdHcyxLojkwLMmBfq/p+5yHl0IGPpIJODoVQkXtUwV2C7hEXW5XGzNvO04+TRDs61zjZdgmZQaiqnUXfLvRWoRlLHz3RMbOsDd1ADnsE8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfYm2bBQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfYm2bBQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0331BC19425
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 20:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777320952;
	bh=56f29bGLQjL5b+ZEJuVFipNoXeBI4SLZgm4fhgcKYFc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LfYm2bBQaH7X8OOJ2LeK4dhO/JN6q8lJEXaSsuewYfpzJu0hrtJb2IUueLdAY0/Ip
	 H7tPhYLn/R05Uz9xO3vk89kW+wwnQCrF1/8aA+iVejffdJmlJQob1nbT+xYhlNAPjb
	 R3i1/EyTdGnoX5V0ELaZYM3GKDA8dT8kV9RufES39h+WfgQiLxJAjdUh8gXLqlsdrr
	 m8Gj4EHD4xMlz6kiTac7/Lx7/y4MmSsVQ9t7NVW4O02sXydx3bAWrCNJilzv0LsJ+D
	 oQzR0n/jdNfo/kYFMrvHthR3s6C/miA2Bk8z75QQEPEBF8PTW8FsWrVlZDD1Q9AMMK
	 GGxdiXFTFbExg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E2E9BC41612; Mon, 27 Apr 2026 20:15:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221426] Intel AX211 Bluetooth hci0 hardware error 0x0c with
 HID/HOG failures on 6.19.14-zen
Date: Mon, 27 Apr 2026 20:15:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cristi@ieee.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221426-62941-S0knV1AJDL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221426-62941@https.bugzilla.kernel.org/>
References: <bug-221426-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221426

--- Comment #5 from Cristian Cocos (cristi@ieee.org) ---
(In reply to Paul Menzel from comment #4)
> (In reply to Cristian Cocos from comment #3)
> > I do not recall this issue's happening with the previous Linux kernel
> > (6.19.13), hence very likely no regression.
>=20
> Sorry, that is a contradiction, if I am not mistaken. Which not/no is wro=
ng?
> ;-)

This phenomenon did NOT happen with the previous kernel version (6.19.13). =
I am
not familiar with the "regression" jargon: I take it this counts as a ...
"regression"? If so, please excuse my ignorance, and feel free to ignore my
previous post.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
