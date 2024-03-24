Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16C26FB5
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 Mar 2024 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711277985; cv=none; b=ggE77SFP0UMZCl0Oi/f82wISeyUGapYqcm5NC0uPT5YGOlnOC7LWYl4Ip1JTK9SSESJ37P8tK5W/+yn+oep7Ukly6y09aTB3YsOx71WThzaQQj6UZbL0W7ERvX3sZzmQ74d3FOFRT4FxVdRUtFrsRnEMs/kerj6dZo539YGl1QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711277985; c=relaxed/simple;
	bh=NCdd+OsCamgKuB87jnCFv2kiGeazaxLsUVusHskHU+4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KO/YjdBu2blFyQGznnqpJMQOvCqOa1zBeaZd0wqqvJWb6FJOv9XklzhRDAQUHANlzYnVPxDtaWd+F335jyoKpGHLMB52kU4MlpnZTKVu88+DRK2P5/QreMyMZoEJdKkNG3BuSYU2aAyVQY5BKXEpJPCV9K3X63y1HtYLLryu0+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAefxG3w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAefxG3w"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5289C433C7
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 Mar 2024 10:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711277984;
	bh=NCdd+OsCamgKuB87jnCFv2kiGeazaxLsUVusHskHU+4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dAefxG3wvLscX8sAGNfQXEOMAZpQEC8WJA16T4uy6XksuEYNIpuDOoQFXjBs6Z7B+
	 d7YndT5MSflA2/eZY08/2hRfRE/PqSR24RnVd9bApZOClyDu5aTR7r7z30Oc9bImCk
	 VyxvGH6YCZuPRngz0rfgCqBTszXncRN5IJZBVPJ1sQwzZGmnmx6DcLs+hZy5SzAUI+
	 VL+5HppskDhL2sLVbYPn0DVe9LSEYtg5K+7rIW5+NyEk1UXY/MxTh8qvH4rfJJF6ON
	 qmFpWW+pTWzO7CI6KPjYK/OQ+EvEB7NH6gssvyHyGpn54tahD6ggTdjnpLjH+MxsKx
	 1LG5/rxnhxrSQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B004EC53BC6; Sun, 24 Mar 2024 10:59:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218472] mt7921e bluetooth not working
Date: Sun, 24 Mar 2024 10:59:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jeremy53561@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218472-62941-b0xb5o1Hpy@https.bugzilla.kernel.org/>
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

--- Comment #8 from jeremy (jeremy53561@gmail.com) ---
Fixed with
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3Df4a0fc6780c7c1583133a9b8f10d76f769e41d34

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
