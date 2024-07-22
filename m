Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CFF381A4
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721679650; cv=none; b=Pk0c4dvBprqLzx7RbarCm7qjV2QE6Vo8u4iiN9+LY5lXh+alsyo3ocCHknDUWi4l5bFZlU+Bnpy9PB2vvFP1vN6Hhh60GdVSd1KeKZPKyTx7jVr2XK4fEz+O02IWTijiHm0we+Ac5H4YGexmnNiMI4oQuRvrmLDfDGOUnNK39kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721679650; c=relaxed/simple;
	bh=6kbwqVdBcd2KYKRpp6F1BuL8Qpi73yeMnJji9j0CN3k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U6psfoo9DP1uX/kaCPVIQYN5DYTm05/p5HxDw5vxfBIteD10nazDsnEtUXmer5tN2F98HyvbeMeQk7+171bBRKlHjoWFGF9MACdZB117T6BFMO2q+tCmv5i+yB0e8GN/LQiS33AlGRLfm+rhb6uBI4LUOnMQmL1LClec5Bac5EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdlcNsLN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdlcNsLN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44B4EC4AF0A
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 20:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721679650;
	bh=6kbwqVdBcd2KYKRpp6F1BuL8Qpi73yeMnJji9j0CN3k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sdlcNsLNJz7cO5s8AWUyMWkqge+RftFdv2sIiJGYpZFuX4bApjhlCZLzHR6UOqUAK
	 6VcSilISW4UDP1PQPxFi4tKnt8PBJDNRivxJElbGHQExD435WVhydyYPoxuNdju4iH
	 LagFmDX8GAo/3BmQ7iqApR9/ynIIxfiEGwvlSbHkwMX6xxQTGXgZmGq2Y1jcXzTRkO
	 HWw7ylE81uG+xZDP6Kom2UhsSWuhMWFfg+u4VpL/WbzgZ2jw2vHaSeHUri9LBCkqtj
	 h/Mfp01JCtL1vf+Fhp0tKnsAbOOh5id4xuJ9O4/T195bmZnYvi+YftAn8+y18Tku5y
	 usXTbrdTioc/A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 31F9CC53BB7; Mon, 22 Jul 2024 20:20:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219057] dongle bluetooth does't work on linux mint
Date: Mon, 22 Jul 2024 20:20:49 +0000
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
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219057-62941-RxlqfQcAbD@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219057-62941@https.bugzilla.kernel.org/>
References: <bug-219057-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219057

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
