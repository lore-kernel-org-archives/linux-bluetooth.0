Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B924E0B8A
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407761; cv=none; b=O8NJvwOO8YJRYyQyKFuH6e6aX+nDp4QH2XIZpbSq7Jhsea+tILK/rI2dPQV4Uv0kpgXJwev+zcRGeRQS9yjIyWPJtrzh91KSnsZ7FU3a5ftAur2h7q2eUWVdFFYGVNv4dDY2NcJiifWSWdKfENiXm5QXYqwbMeJ0zkUiq0nAIpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407761; c=relaxed/simple;
	bh=tpKQXl5Iziqb44ikgBYjbyDmuBNs+x/g17Ux2wHqmc0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GNd3CKIQG9wb6aAtD+GCElRVdsyMeh8r/+khauBEosK+weeiDFpU3wSzAojx3C6V5jsUu12uQ5STRJDR4JKY4zzTvlbTy5j0CgP1QQanJiC/cd3rV+zbaooD40cfqb+U7+et+omiQKmDwuocpzKlLiUJjTTf9yWjwV/uT7uNd7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKtI04yN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKtI04yN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04150C2BCFC
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 11:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792407761;
	bh=tpKQXl5Iziqb44ikgBYjbyDmuBNs+x/g17Ux2wHqmc0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nKtI04yN7AeHInB4M6iG+YtnG0TC1P2eyBfXDSaawPlGvuOG0dgF27l6CCHm7RmQ5
	 TlS5fuZEEL8IMS1R0SOjeS2vO8B1rtsPb/cOT6RQZ7Vxd/rmVbE7QmXprbd031zgZq
	 9LBrcuaxwVBma7HA8pVuYdt2V3hJtmXu+Q9YoebQSNr8rCobjXxZjwarMFWZuHwtXQ
	 xu/qPJnYr6Of20gnNlKc3IMpvdqPPUWyuEvYssork/IGJXRbNnIJrkIkUl/pJ0qoE3
	 3D/cYRBN/Y+BD6mRJJi5gKVVnzCiW7zrsFt0PoMhhmmaDBwXEgoEub1tFYSSj1e8W1
	 eSa/WJqIhJRIQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E6275C41612; Mon, 19 Oct 2026 11:02:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222151] MT7925 (0489:e111): BT firmware 20260813113236
 (linux-firmware 50e034a2) breaks HFP calls and fails WMT init; 20260605184935
 works
Date: Mon, 19 Oct 2026 11:02:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: purpleritza@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_severity
Message-ID: <bug-222151-62941-7IfoiYuLaE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222151-62941@https.bugzilla.kernel.org/>
References: <bug-222151-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D222151

purpleritza@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           Severity|normal                      |high

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
