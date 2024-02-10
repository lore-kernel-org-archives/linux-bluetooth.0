Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEED85F562
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Feb 2024 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707593064; cv=none; b=FxdS1q0+CoWsR2FDsG1pkvXvp4I+tsD1yBUzgTXcbaapzPeG15PUDNE4jFV8W7vKUue1K/fE70Bh5fb739OBownISObUy9oX6YHJKBaNVOeJn8kuRJ23fQv0kgIo111IJUw+rsq4UUt7tmRLIRWi2yca7/1h3Dxdhid8PFOLheg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707593064; c=relaxed/simple;
	bh=Rxu8s3mirbgohd4mZ/UvS9zHHgd8FRa8ZkluFylRlRQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bbhpcOQJkC03a0MITf6wuyd0aDgRU+qIqRU6HDBtuWWvNGx4Z53VMy3aQ2S8rjDm2rKd1uekueNU5kKrhNPNXdY0sPer+75KpONEwFUnx7dQGqzfjSyaSWdThutKxzCnlf9L6puu0TkgqwNssCRR9KD9tHsRO+vzppERMEeK9ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOlzgr5t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOlzgr5t"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29DF6C433F1
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Feb 2024 19:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707593064;
	bh=Rxu8s3mirbgohd4mZ/UvS9zHHgd8FRa8ZkluFylRlRQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jOlzgr5t9YU/GLfphFeqV1Hm7CiXErTPOrR4Jq3AIBZMJhJS57wgx/SkSWv9WXdVY
	 R0fFBPmtUCIK4PhY8I7eG6jFIYNLMbLLebkNhjNXw8dqm8O3Z//HuxqV6APUmhIVw0
	 g7Z2rwgEltqhjyuzcdRvj58rKhXBA4F9QgB0YcYILFVxuAFTCkky9EKlB5IXTZxK9D
	 h/oIgBWIQc0Y7iO7XBPM31TWpjgA+iETkHbCFPT/fbHg3dn7wpldIXZqY99/YF5187
	 UBJsh2iV80Nk2i1wohHxbOax1e2ev/6TUeDbYiYIiKLf5P8ic0vv8L3CvYKNgYYV3v
	 8AbUeppXzWbkg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0E3E5C4332E; Sat, 10 Feb 2024 19:24:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218472] mt7921e bluetooth not working
Date: Sat, 10 Feb 2024 19:24:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla@mail.cam-it.nl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218472-62941-3sc3jFGaFp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218472-62941@https.bugzilla.kernel.org/>
References: <bug-218472-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218472

--- Comment #4 from Chris (bugzilla@mail.cam-it.nl) ---
(In reply to Artem S. Tashkinov from comment #3)
> I have a similar/same device and it's working fine here.
>=20
> Kernel 6.7.4 + latest firmware.
>=20
> No idea what's going on.

Thank you for taking a look anyway. Which Linux + version are you using? Do=
 you
get the 'Opcode 0x0c03 failed' and 'Port 007: Dev 005, If 2, Class=3DWirele=
ss,
Driver=3D[none], 480M'  with the commands above?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
