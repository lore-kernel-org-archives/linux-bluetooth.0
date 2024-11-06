Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39FE1D0DF7
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Nov 2024 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883493; cv=none; b=RZ0PkIkPC0hYopPTpjBRfK9TMXR7wQY6w+PvZVeB6YUu+YrlP4BhxSFTDK0cXdJL+crWKnV5qrr+YUgD/D3m7c4W10HuS4IIBIOBJIa06HezmeEg2gQdNwpbwKgqgyQ6AzrgmhFU7q/2gPSD/clKTSgmUxcF8zfBv49cayCY7nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883493; c=relaxed/simple;
	bh=t4y8VLcEbVaXv8begVVl1YAlai0Sm7IG728m/huIN8c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l51Vcn7uRWQGOf/fYIV97xNX3CHZ1mvws0LPwMBs3SnzXanQ6OnlenTJo67Y6zQaubujqK6jElrgPIbkLVrA5C76iwFrU7YnPEchSIn3RlPM/RAt69iaSuDccNSzhTgN0TrslJkLQX3ZmFqBFtnyKGXNO9Tp/XO45M2hJ0L6aNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2vaj952; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2vaj952"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B0E7C4CECD
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Nov 2024 08:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730883493;
	bh=t4y8VLcEbVaXv8begVVl1YAlai0Sm7IG728m/huIN8c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=J2vaj952eKoJaWz+aUwC5hAFOaBoqWc26berKe8uKoRW24cjieskgi32B4gmYGynm
	 8pHjhmojpQoJ7xuyYk1YpaSZSqF4bz1t9pBhkfKDnDL+LIQEc5cpDFYU8uKVJP2w7q
	 4YVwH2PxH/8oQvU9DVDLFcp4Ih8B0GHO6j+ueu3uWPbbgAcA/tNJ3asrZEJt//UFoR
	 G7QhwAfxboCz52DZEEj6JNlkOayzxeb2Ah40JffoUwCTewCOYY3rqmsObh5lENgV/Q
	 v3lBn+mem5Cg0YfNZm6CyHpHlCltI74Srut8xfWgz8y+yWfdT/aM1Hv5c/6IU7oxGc
	 LIvv1HJkBlA8w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 51D29C53BC2; Wed,  6 Nov 2024 08:58:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218952] bluetooth and wireplumber stop working after some time
 - dmesg report BUG
Date: Wed, 06 Nov 2024 08:58:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: nicolas.baranger@3xo.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218952-62941-z1AL2OJK0d@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218952-62941@https.bugzilla.kernel.org/>
References: <bug-218952-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218952

--- Comment #4 from Nicolas BARANGER (nicolas.baranger@3xo.fr) ---
Dear maintener

Thanks for help.
Just to inform that since Linux 6.2 I didn't reproduce it anymore.

Kind regards
Nicoals BARANGER

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
