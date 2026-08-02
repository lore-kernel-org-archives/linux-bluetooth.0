Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E0023394E
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2026 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785675673; cv=none; b=d8GWWzNIPBzLwFPZo8zLEVOi1YL9hU/FfGW9b2pDRKwDFWm65fnXw3QpijJ/MOkdgWmviWO2ApMLi+NWaTnpCI48G0z509B7pzPwwFL7Bx3dpqu8nQkAbTrh2Csjsqye5zmJV1PjGw9VYMrFlipLjw9UfXhXLqysQ1+bIYJ4aeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785675673; c=relaxed/simple;
	bh=xcPzDIHRlUl7Idzu4WNWmurZLkk84b+cLiUqTrI4Eow=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=raiJP5Sdjr2rfqBSYR3G56jTPV09QcnYoaGn1+r0C7E7aVUhNeNzZcHkUIw+Uov+FSXU3j7xBZFXDdMCbWl7LdrPL4tR6cnNF8rnZbTLJck4Y3pqriiUkbWz1MPWH8MPnUSjGZxw3Cs8njuiRkkWOH2nMFJTQdQUThiycuEUlF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTiRTwsR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTiRTwsR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62E50C2BCF7
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2026 13:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785675672;
	bh=xcPzDIHRlUl7Idzu4WNWmurZLkk84b+cLiUqTrI4Eow=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DTiRTwsRcf9STkhCYLclSppXVzRKhs7r+M66I1DwwE44yfkxCQ0xk1TVeaH41iglF
	 JbyB7mkdJ16YzAwD1OyLxAs8GDprVtZmpyfAPgQN/+9BLG/kQG+zqw+YXeNg0f9OEe
	 uVWtqqQ3D5UR091qO69maoquYpiGFpB8476E2WJQjXjGRQjErfHgHCBSPD+1sMmF/P
	 rN+BZqc9LJBblxpck9GxB9FwRi+TZB8YixuHnbcv7AauYK3zXyldLyxvKhtow9siwK
	 toTxa16LkANNUKenFDrCnN3bzWMHNmgQFh1WpaMzmukw07Tm1uct8b92lGddFx9Xk2
	 M4QXnYX8kxNoQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 48FE4C4160E; Sun,  2 Aug 2026 13:01:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221754] RTL8852BE Bluetooth (0bda:b853) fails to init: Opcode
 0xfcf0 failed: -16, hci0 never registers with mgmt (BD Address
 00:00:00:00:00:00)
Date: Sun, 02 Aug 2026 13:01:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: jeremy53561@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221754-62941-ukDxbRENL6@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221754-62941@https.bugzilla.kernel.org/>
References: <bug-221754-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221754

jeremy (jeremy53561@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jeremy53561@gmail.com

--- Comment #3 from jeremy (jeremy53561@gmail.com) ---
(In reply to serge.brun from comment #1)
> Created attachment 310453 [details]
> rtl8852be-bluetooth-bug-report.md

My Bluetooth-7.0 repo only recently included the ID of your bluetooth devic=
e,
you may want to try it again

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
