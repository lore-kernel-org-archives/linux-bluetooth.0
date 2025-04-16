Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6FF217657
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744835352; cv=none; b=A7Riu7Yq+Gj/Ku2Ju/P6U+ZHauq6mbT2uvT3aeesih8ylNyntVDNrqQAORkbr+Qf7acI65thhjTBFQsa1adetQyUK/RoHdhi6gy1rA4NRzzRreeIjKK9XrzaHrYKSkCailAFMj89vEXK7DDcp+j2EMUQLaHMpmSwsqAwYlKBrLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744835352; c=relaxed/simple;
	bh=bAfQHdj9nGt9V0ye/BH0rg4gHMIrFApC68e5UxbfbRo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fnzMfF8Y4asWobqIFtjBC8z7tpaPQlhTKO6ee+h1lm7k3/4WBYwigDPv95GAqIv/HkQB6QN0abuBC8tJo8VoqvSqSfhuqW+byVPXivTXBiXwlk2JzRZgJ8lFEqb51FGIiyP26YATVp9KAPh6U57lGpgJ/cHIs7qspLuoZJdnFEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+3RLm0J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+3RLm0J"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA8C5C4CEE2
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 20:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744835351;
	bh=bAfQHdj9nGt9V0ye/BH0rg4gHMIrFApC68e5UxbfbRo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=L+3RLm0J2fpMqbWgPtMV0vjaHZRwJk7G/kBSreGTdEAg6u4yOVUq/NCVx2XArOCn7
	 a/BJ1jr/IGpP/b37P5X+3fBL4/TR508eLxNlpV+6qgv38rG5P6JkTLaZ+uQs/RQOzM
	 dLniNg9Uzck+q2QOyxAvDCK39XkhTO7gF0GRLFUGqDW7KNEldKKARXJIYFT6RDB6IH
	 2oNX0OnLvLFy9UN7rwSmOWwqGhoaNYIPnNbros5BP6n4YxY4wHdOPLr+pouKHNWzBI
	 1uqs5arUZ4st+pf6b8kXMjH312PFzWnDIPb/EUnnruXoI7Ew69SImGGsWNm155PyBo
	 Y23HKirQoxIYg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C89FFC4160E; Wed, 16 Apr 2025 20:29:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219854] Bluetooth devices can't connect after toggling
 Bluetooth unless they are re-paired
Date: Wed, 16 Apr 2025 20:29:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: linux-bugzilla@ericswpark.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219854-62941-MN3aFhiQws@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219854-62941@https.bugzilla.kernel.org/>
References: <bug-219854-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219854

--- Comment #1 from Eric Park (linux-bugzilla@ericswpark.com) ---
Problem persists on 6.14.0.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
