Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B92029347C
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863121; cv=none; b=OFIycrS0OQSXNAyzEA+WVwg3WtOZIxxCctwrqZQG5ROD5ZvvRabKZNQiaB5uu+Mc2RIBHr8XBci8LLpi1GLsy43cK4o1JmTyL9bf39yE/mdblCUOYKkeLLxDbnxAcJhb48gFr8WUiYpQ4Huy6R8CPEXdqAWpuUFkbXrXw8dfPAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863121; c=relaxed/simple;
	bh=owsnx1EM4yHFwtbHy3H4R9d3++g2macbb7rNeSmyAaY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SNb2Zwv1RJ/Ud04palPr96fW5bSuJOfcCFggYorM8kWKn5kcAs96avZ0Z7nBwEx+n7illDhVOiifa0OQTrEsmGQxDP4tzT8QJkcR7UUt3Ud3bVFR+RciVCIqfNfUF9QwAKDINOVas+RA8Us2tdKZeg38MS2zZRYJJr8z1xZEFbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjUEcqfa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjUEcqfa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD038C4CEE4
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 17:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745863120;
	bh=owsnx1EM4yHFwtbHy3H4R9d3++g2macbb7rNeSmyAaY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sjUEcqfaVugDJAfZAdfeiyVo8oMvdyGLxICRhkYQKoJfrwizSETmCJhSWE8O9D3G6
	 PNA6MWPksm62LwclNnauIa1oEOBKma1VARzGIUTIw65opoaibAYiPO/ZCgUVoR6318
	 97Ogmn4S4EU2hEgIGqb8ffskXHOQPmblMoIbPg30X22ME4GbeGxqEzdBVvQ2napMf8
	 1zAq0r9H9o9Pxwg4orZQs3mxeqINZL1QrlwRY0c5+Wqmz+Gxldkg4FJCSjI52LRTmN
	 NMkCuZf9w80eKkCqd59KGbIxBfydErRm3H+JRvME1QIeoCszEKozJIC/bbkn2zMVph
	 7MLRebgywBnaQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D1BDFC41612; Mon, 28 Apr 2025 17:58:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220063] DualSense and DualShock 4 controllers fail to connect
 since 6.14.4
Date: Mon, 28 Apr 2025 17:58:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alan.loewe@foobarlibre.net
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-220063-62941-0jZS3p9EdE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220063-62941@https.bugzilla.kernel.org/>
References: <bug-220063-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220063

alan.loewe@foobarlibre.net changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |DUPLICATE

--- Comment #2 from alan.loewe@foobarlibre.net ---
Yes, exactly the same. Missed it, because I only searched for "dualsense" a=
nd
"dualshock".

*** This bug has been marked as a duplicate of bug 220061 ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
