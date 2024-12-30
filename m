Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5590522339
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Dec 2024 20:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735590234; cv=none; b=hVSukBVPPASMlpZ2pEIownDRZ2V1RqXWDPUWQr/iu0bdX/y9MAxjOVXSxbQJ6SvaFwdnNiWxgbJaR7UuAVV1Upw29MCTR8Cig6Ms4V30GFnWAGWAhR6TIXmsJOAZe3ncPD4JKw/c5mlztT3QvynZZbUTRJgssGcVn19ALKjGm9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735590234; c=relaxed/simple;
	bh=9AYNzwTAeAtYeOYYN/sSgZNw2oteGb+inRuZuKx9XmU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oxFaT21q0UPlQfR2xOFY702AGfjDEUGovKFk1VUjdym39ghL9ZlDDMUtK+BBv1R3zicDG1IKg2uXJLQXLCdoQMdkq1oarVkGle9LJKGrDLLwZSf3BHtV629P5KpLoTm7vTjkk4O2cUmu2cTyg+5uoGMOiBqqTT50MTQlV2eTNUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oG3olPOK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oG3olPOK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC4A1C4CED7
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Dec 2024 20:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735590233;
	bh=9AYNzwTAeAtYeOYYN/sSgZNw2oteGb+inRuZuKx9XmU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oG3olPOKXRCJWUk13YhfYwjCT8BpP0X5TOdhCQD7lic8RdcNqxbL2I7/MaiPlEAl7
	 JmBHawKTB5Ad991dbiy5NyerZZh5EZV2HlZ48L6M1DO9nNGP5wBvfgjzFdZkboACs7
	 YlhXqsGIgVHYIxYEpMXqSYL9t9RwSgOqHhSU4mCtsU/5DNTfwjgtswc1Kyl5YxE1U5
	 xdVZEW3/xGF4Z4ZfUFweL2WkE2Hvt0c/ujEmvSoLCiYicqVRbzznZKlcEoyFpJhX4i
	 3HAeTg1c4nZz+2DWtnOGmwQS32mymWXhSzuHNmRzmallHI+5Dg7eanWzYsY6zMD1UD
	 Z75m9OD/coT7A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C8B9EC41612; Mon, 30 Dec 2024 20:23:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219642] graph xrun not-triggered
Date: Mon, 30 Dec 2024 20:23:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219642-62941-gtr0F90ivJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219642-62941@https.bugzilla.kernel.org/>
References: <bug-219642-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219642

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
This looks similar to this:

https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4310

https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4233

https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4182

And it looks like these messages couldn't have produced the behaviour you're
observing.

Please try upgrading to the latest version of PipeWire regardless.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
