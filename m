Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B426348C7F
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785348657; cv=none; b=WQv1EysY1tjMLVxiSL57lNdK/JEdPZavFc0MDKEv/j06eUtqpnDYFa8eWUggWo4YQVLBxFdxYqtV38ksfToJpVRtVbUoCDXCypNQ7UqG2X2n8pkkA0VT+OIi4LiCWscXk2Gb4kMOHKGr2fA85s1h3PxFSg3CEFwvV5nhHbAML/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785348657; c=relaxed/simple;
	bh=VwOH3/KHuExtlOYcLirATKBwbipuhYrwkC9cQN3a9do=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nsxcyt2R4qI9zz8aQnCVDfVdsqkH67TMMQqWxqq3zM+ratb2lMb4t2bLPMDyXY99+xIvyy+YO6DhDgk/eaT5+FSHxItWwX2nzU5mTwxwNt2XNy7aPUoxTl2qdd6Z93wi9VBIptwHoV0NquJDxSb58W3IkZn83/C6oZlQ8Kj/Lwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAPSqDG/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAPSqDG/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17970C2BCF5
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 18:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785348657;
	bh=VwOH3/KHuExtlOYcLirATKBwbipuhYrwkC9cQN3a9do=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tAPSqDG/iEcsaulzMuzaVkvbH9DNti4FQFPVr8EtIo03wOLXAOuFXC8A92LVf930Z
	 5TXiPek5GtBAde43x1FD4v353S+3WsOk/EzUX7GJqXvD5mMKAdHlljY2hQ7gR37qPp
	 nrK0wkjuDscz/ZCg78CD0+KQw2gw+xTZ7cqFVVY2+7sJQX9lL+AZQ1oxOIcApY6nRU
	 JubWiIBec9J5y376k6grYtTWmgtXhvJSx+tLOg/rLfVwnsyp8x7TaBHKX4zfbB74yg
	 aw0gNGy+WOgLXWGCOOlpGEktfzsLR3bgYeh/9L8BXYZ4dX1ygtcGdfI2fz5lQagzTj
	 uQ3qB/cvsdetQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EAB5CC433E1; Wed, 29 Jul 2026 18:10:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221783] Bluetooth: new-device pairing consistently fails on
 Intel AX211 due to ~20s delay between connect and Authentication Requested
 (WiFi/BT coexistence?)
Date: Wed, 29 Jul 2026 18:10:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: galagann@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221783-62941-5XQJ1FtYIH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221783-62941@https.bugzilla.kernel.org/>
References: <bug-221783-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221783

--- Comment #4 from GaLaGaNN (galagann@gmail.com) ---
Thank you for your feedback. I just received a new version of the
kernel=E2=80=947.1.4-1-default=E2=80=94and I'm testing it thoroughly.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
