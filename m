Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABA05F48B
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Feb 2024 18:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707589877; cv=none; b=MiUPTq+NyBLQz9CxEX/mLKUfu0uvmXwBuzULBu2hhfkj2Xuc49nVPRfPMdx557jKknH0nHgSsjerE8hW7BfkC4iMpV7jyQO2lfvqWhGpLgWKvP7msYTHOUUb7LJJJPHz/UnxhEf2U/LbklNPRDpyDkX7zZk2FyvP5lo2B1ElYVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707589877; c=relaxed/simple;
	bh=lYz/Zm2DzYOTberSN7vyjG18+XEk/5Ql1XoDq8IHvNU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hFzFkAYvbZ9K+naaa8eRdpUJvJjh4kmVDrLdlxPC2U7bdyWGuAoZy3raQkJy7T/oxkYzCUzJPMRTUUKzxfpdHstBXJrl2sGwlIUfxdXluNGqXZDM0VnpZENMM7xCDT3AFmz03Vjg8jHI7p/eyVVNvyMyi0nXNAHYxWc8mtioiUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7R2U5/0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7R2U5/0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 102BCC433C7
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Feb 2024 18:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707589877;
	bh=lYz/Zm2DzYOTberSN7vyjG18+XEk/5Ql1XoDq8IHvNU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=O7R2U5/0/azXnx01XS2DGKWZ/abEcc/m6T60z0cxSc2vYgEqOKItB25qy6sXE4+2s
	 ET6/E9hnkkPNocjxDNreCjNyt5AjMaOzV+1Tw4jKaXwgx3NzhGsJ/9ZfypESrk0B0e
	 wzKIJf/+Wasy1e3a6EEbbFSMdASGyaCarQF05IcQJqSxW5ACi9mg1GWUiGOMVzvWQL
	 c8cekYow5QAYzHAF9ym+8DF8v4VKsIG8B0IdUFtmwHSaq2TcOoRc+mnqaVCGvMW5k5
	 5XajjqAuhflldXHZFB2j5sOyB4GMcR2Au8st6+N0EnjgaszfkwrBTBeh2avnEMuOx3
	 FJzpkL8vyyodA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EF3D4C53BC6; Sat, 10 Feb 2024 18:31:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218472] mt7921e bluetooth not working
Date: Sat, 10 Feb 2024 18:31:16 +0000
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
Message-ID: <bug-218472-62941-bgbTvtxTWM@https.bugzilla.kernel.org/>
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

--- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
I have a similar/same device and it's working fine here.

Kernel 6.7.4 + latest firmware.

No idea what's going on.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
