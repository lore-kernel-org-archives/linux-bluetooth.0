Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472D04F88C
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Feb 2024 13:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707570552; cv=none; b=FwNzP/eUT5LpxD8r+qH2u+GIHPT813+SJ6PDfd9URTm2irMXWeluSWeP8b3VA+bHLLyyfSIj9+kirNM1vPZUTJJi6VQr7lVIso9i2dROXITxxudKCvacp2YCcokv7JE2svfYrqfBTxZfLCI3gTLEuE+NHwhrdGVut7m3xx6n/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707570552; c=relaxed/simple;
	bh=zlQX8ZDR0qdlT5Oe00AB7vZABJnogYY7aVk0ibIS8gw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EuaZikWQhLbR0gRbPMzD7xyt6bK623syG6up5GEuw43RL+qrdETxZrqe/rg8jnYF3GKKhwTk5hGmrf/8CtqcWLHt4WDFUuWgWqaST/MDYxiPyMWXM/jp4m8cKvd4ko7cZbMKTh3h4oWVi9x2UXmG8IOIacYKnpxR1gtgmCDBZMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czOQhzy7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czOQhzy7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1033C43390
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Feb 2024 13:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707570551;
	bh=zlQX8ZDR0qdlT5Oe00AB7vZABJnogYY7aVk0ibIS8gw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=czOQhzy7Oxtq0YKdUcwCLaOU6b4UPW0hWY4fuc3JHxJsdYR5NUToy8oQzG9DSdXXf
	 xObDS4Lrh20hufz9gKM2AB4WRNX8gWOLzAtQO8rF2pjXiSZ2lV+xzbi4McE1kbX8PU
	 RnB1WX5c7q2FJJKubUk5m3Qvfq5W1W1bQqvj/BaZsmu673TZ2YUJEUw2eZZM4jqr9W
	 Xd1L/70yuWMbmorFtNE4hNB/51f76OMxFdbUzTbZpU52QCfZ1smEgQ8b0S8e+flSIl
	 Hpw0J8q+/gom+XGB9G2E1HaIDFVnyM2ebkYi468YBgtvFZh4Zkwg0dG3KRsLZSpcfO
	 lZYRt8594YieQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id ABF7EC53BCD; Sat, 10 Feb 2024 13:09:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218472] mt7921e bluetooth not working
Date: Sat, 10 Feb 2024 13:09:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218472-62941-9zWK55CAxz@https.bugzilla.kernel.org/>
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

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
What's the output of `sudo rfkill`?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
