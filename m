Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6972E3707
	for <linux-bluetooth@vger.kernel.org>; Sat,  5 Jul 2025 11:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751715298; cv=none; b=EhUs1nf8OrY+7QQm/zpDIbPu+e02pRiNZY4RNYU8JEpWsTET/x9UhXOz6AQvwTzn73xaKHCc45KAcrjJJtpc/esyCxGIh4ZKVal+R1cwh9T7G7QdVU+6X7gw313x+JYxm/gjw6k9piQQPG69ThrXpd/DuseJ10VdDwwxJ8Zusy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751715298; c=relaxed/simple;
	bh=qTOFqc8O5/oKMcAmuXjHe/l3GfRKMmVaL4YiL0YIQmc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qhaqUyK2HcPvWnnHVkv1TvFH1oK/YOgvGeUOAitru0W/oZUub4Lc0LwtJhbFaKLpX++uZyZ0a7SHCy9+2qX3ypobEh4Wavreo5zf9c8pQjUrFGNO5fOZmSu9EZfJRoDscfJy/pSXij0eyhzgi9xb2ss7mvUn4gNvio8hrEf6L4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhIkA4N8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhIkA4N8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE6AFC4CEED
	for <linux-bluetooth@vger.kernel.org>; Sat,  5 Jul 2025 11:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751715297;
	bh=qTOFqc8O5/oKMcAmuXjHe/l3GfRKMmVaL4YiL0YIQmc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RhIkA4N8cTrxRoFn4ZajpPnBhD60kDL3y/BTfNF50FOfm0g6G9IqVscuXD2M8f1SX
	 +2eqElkRZ4mXXdVVBtW23telxosuwtRHVi/B3qVC6ls9Y1JE1OGGpUcjkQf/F6374T
	 DRFajj+VE4tdhHeRAP7ubnlxdmQ/QCZlOxz/svr4d/3qMDwlcIIzzDRPBZwLTw7Tko
	 nLfhrZdgZZn+mNy8anerjjZm1qB9DS7tt4QAHqptrpj//o0tw3fG+7Ka1ESMy8J+X6
	 6UgeGaoCF54Yq5STTpHQj7bRjh15JLjTK+K158xpeiV1hjexEg5nl5qYYzZc9jcJap
	 UvD0iXh+x/PQg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CEDA5C41613; Sat,  5 Jul 2025 11:34:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220306] Updated ibt-18-16-1.sfi is bugged, "Invalid exception
 type 03" kernel spam
Date: Sat, 05 Jul 2025 11:34:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220306-62941-GI5srOgFaW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220306-62941@https.bugzilla.kernel.org/>
References: <bug-220306-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220306

--- Comment #5 from Artem S. Tashkinov (aros@gmx.com) ---
I haven't seen this error once since I downgraded the firmware.

With the new firmware, I received dozens of messages per hour.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
