Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE801C8FCF
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 22:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637397; cv=none; b=pq6DojfMNob/DRWtyaWs6461d97u+0VOulK4OtQcNiC1Dg2txQJ82HON33Tbqskh5NTHL6aT+LCikBB71mh0BB+LNjPaqMpL5Fu+EDHIqfcp+Xdx7iFTgvWe9ZXa7L+4qz4j0GmFF0iywYSRhQhSRXVRXcVyXJ6A+1mSJTD4j10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637397; c=relaxed/simple;
	bh=//PtBz3FfAVS8W8n2apBU+N42FYvFm9Vra2yUe8ri1c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XErbLOrJltqgvTaN4FRBJ2GFG8H25V9yncU5cWwG2OVK70PWVFx7fKAs8PqSBJo6nmhfUV+ZJzC+QhRmYZPQneI/zT7pEB3XzvYFtPDbX4zWkaiEGAacrqAYCnskSVRvPnVRsR419MwqoQXbN8/Bk/KVTJ4n2gvnyujJ2zrPpF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3rCqPin; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3rCqPin"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94D08C4CEE6
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 22:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729637397;
	bh=//PtBz3FfAVS8W8n2apBU+N42FYvFm9Vra2yUe8ri1c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=H3rCqPin8pFmEk55k4KjXcrRCrcDO1SSoAxbsPJ0U5fk9bg3V2T+OGsF0Kh0nxNIu
	 fC0Hq5zGOMJdxdkivMbkwwBZfNsbtjlTzh6wOAzHVuPadUvugBCkagbZI6yBGGaNRt
	 RlsXMsSZrD6nuDilWPWJgq7OXinBHJIiYhbYJotuRLDQDJBFFoPMtYGgLTJMr9HfF2
	 OK95QdhbUm5ksEyPTSSidGm5pPLtbrT6QOi5Q3rvhZUHkH4cAeDanohPgwNnop6qN0
	 EqtAd/TPm7WAYsZIHIo2cMUgny5A3oX+DNljQ5WzvwDvOg9kAbWNEQMQ4kiGM4yg9t
	 22Kp5k/BK+MEA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 89866C53BCB; Tue, 22 Oct 2024 22:49:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219365] USB bluetooth dongle stop working after upgrade from
 6.11.1 to 6.11.2
Date: Tue, 22 Oct 2024 22:49:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: adilson@adilson.net.br
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: IMPLEMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219365-62941-SdiGlarp5f@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219365-62941@https.bugzilla.kernel.org/>
References: <bug-219365-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219365

Adilson Dantas (adilson@adilson.net.br) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |IMPLEMENTED

--- Comment #12 from Adilson Dantas (adilson@adilson.net.br) ---
Closing it since this regression is resolved with kernel 6.11.5.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
