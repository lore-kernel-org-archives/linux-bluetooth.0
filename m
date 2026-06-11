Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C90E32142B
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781188604; cv=none; b=RQVFgzO7P3uP829ICMTu2FENhyPqoyor9hYN4MQNl22IFUvwGkiqEh/3UsCueGAMQHGuroKPszD1eP5074r+CFGhQiZzjb/TkJohtMR8Jaha6DRoPb/7pC5OdpGc61b0XnVr4YC2ypcA3aqHjOGmSUoAl8KqBPdHBj9KgxnBN40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781188604; c=relaxed/simple;
	bh=z+k8rD+FiIO0qaif2gLn3LEe1NMdcFsU0QZ8vVu8dA8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GpZ9Ppo6uQRmomxqvSglyC3nRcwNV18RWmmG3pkGHGkzkfYxSJV44TN5qL96wML46VflRvi/mznDm2ll3srjEZHrSr3baZJDx7X6CB9aBasA1NwY/TFSPJArcNqJ63g0nmiCRsoqcDZBtYFEgSmfp0zEpa7AwgvPflpZr6OmuyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYPdTxbn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYPdTxbn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C638FC2BCB0
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 14:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781188603;
	bh=z+k8rD+FiIO0qaif2gLn3LEe1NMdcFsU0QZ8vVu8dA8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AYPdTxbnuIfvK6F1kN0ReOqfVTCAIJ3FNrd4Qa8xl/W34GJvtNQFA/E1EkC6k9bCL
	 d2DErbNsNvrBVjPFv6D1Fl7I1tiBzaFL/Nhpjbkz79Ej7Vz1a6fz0R2sWDVow3usIN
	 7IVNHYkzcpBaHnIyc1rXldmEHX7qQOhci8YxUN29lfAfmjv/00UJLtbPU0xLzhgyfM
	 yHvWsUcp64FlSqRD2iNS4j2dnKOWaxZ/DFl7Y+q7zFHTFp7HgRpf3cDBREUpidUP37
	 ORfI7h3KLLw9Xj1TS/Aw32hiOgy2KgMHm2581JTF3MdVQbj4xUIkriTYkZfpsFl9HF
	 C4Dya8Yn+xNKg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BB7BCC41614; Thu, 11 Jun 2026 14:36:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221637] Regression for Intel Corporation Device a876 (rev 10)
Date: Thu, 11 Jun 2026 14:36:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nibheis@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221637-62941-xyJbGrdE3Z@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221637-62941@https.bugzilla.kernel.org/>
References: <bug-221637-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221637

--- Comment #2 from Pierre-Olivier Vall=C3=A8s (nibheis@gmail.com) ---
I added in CC one of the author of the last 2 commits.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
