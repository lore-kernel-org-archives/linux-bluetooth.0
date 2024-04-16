Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E8A85280
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262282; cv=none; b=FqSWhx6hmcWI2uI+lEscD/gCqxcPNUkclxB8bG3K5VJp1PWA9cGKL05C4lbrPn07E7QFXLzCGprXeHyxRkg3Y89SkuqMzch90afZTUBKV+5kiLWmSFIcR1fvA2j6w9IDPGSZysz6+yMSxDFB1uRAEmFuAYjMrnlNEy7eOaULLjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262282; c=relaxed/simple;
	bh=ajw7/o1rydgpmHKqeY1ucfPiPFKKdFmBcVwUKRZl2nk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qS/PgNrtx3BymANeV8n4D7UUvdDegjlwxxElVHR169iSbTY/JWy7F2AhZnfba+77YzAPfBXePNuNcUhJjtRIcnqL7AQkODru6GYmatJA7KtdgbmWvOw6mLf5F1b3SKiVd3Rt/scqO4/zNg9YV4bfNS2hJ1vIgC+JKTlNMCbacUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIxPgO3u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIxPgO3u"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E7BBC2BD10
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 10:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713262282;
	bh=ajw7/o1rydgpmHKqeY1ucfPiPFKKdFmBcVwUKRZl2nk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FIxPgO3u1tXPtY/ccIO2Oy5zs3X8KG8fPD5AdoGamzmjfqrVEuF+IF6M4CqX4mQhE
	 KNk6OjLhwuC/+FtE8xKosEd7TOiJ3bNwHepJvKtJG4NG4WB5ku0AvrkhtKD74taEg/
	 I1IxBwGlOTaXNhGtcGOBdGqK7HO2Z9iN1RRJwkDoZBB3yqoYG1EHFgQopqVBGNaMaY
	 05yoSfoqfWBeWzqiW0sU1WOuHxDV4YzJzYYg8NPUCFj1TfKtk+BNjO8GFt3X0avtiv
	 osvlfBzsFEZNJz56kYimFTT70piCTFq8w4liTqla8cylrw/PmzLZX63A2VUSmncjjP
	 eY70r7krqtTCw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F3CAEC433E2; Tue, 16 Apr 2024 10:11:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Tue, 16 Apr 2024 10:11:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wt@penguintechs.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-Lm7CPI4Uwg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218726-62941@https.bugzilla.kernel.org/>
References: <bug-218726-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218726

--- Comment #21 from Wren Turkal (wt@penguintechs.org) ---
On bluetooth-next/master, I simply reverted 56d074d26c5828773 (just like I =
did
on 6.9.0-rc4). This allows disabling/re-enabling bluetooth over and over. I
think this indicates there is some kind of problem with that quirk handling
hunk.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
