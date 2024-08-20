Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C80C18E353
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724151675; cv=none; b=HBlTdDTZXF62nD4146+YbZokdXjwJc0U9/ybSvFyzPvHupCgSX9/3dGKpju1cOqeTALn6ApTxiMaJvb5kgt87p45sCiTyjsaf/K3ISGoItaOUALEkwQKe8TmENTSSyAjYw9Xv2L5VzoKHZkom42BMP+21R4P2rnJQEdRzCZCThQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724151675; c=relaxed/simple;
	bh=HH1/5/jUWki9TnnOOgElTY8DZ/ohiVl9VrPI0O0O3uo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OaHoRCS3wbO1aVsOhwVAjU44O0nselZzW1Y6nUkBc8h8quXk6BezSnVrsMdO0sL4bXXtFvbHgd+e8YUbOl4mLf278HQB7LSe9lKCZpuO79pHGLYKjrRUH5oXIoqbhzbE3Ei0xJvLR2rJZArZOlYoNdMrzRgik8pZbTktVJzl+ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6djw0yJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6djw0yJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A33B8C4AF10
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 11:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724151674;
	bh=HH1/5/jUWki9TnnOOgElTY8DZ/ohiVl9VrPI0O0O3uo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=A6djw0yJh2VkrUwZYlDm026UFbrNH6w+yPqita1BFGhzIloZC3zMFZK+p4fkEeuY4
	 ya61BHzzWmxb+ahPURF3k8py8kZYA0MB72zR1KN4ICoBMc06yBntbxDGsJjn0p1QYe
	 Ui8HZ0nN62OqJDWmvIJIkmUmZg5iPMpAAzonoq7CsZQGCdFvWGHOPULMwYFONO1dal
	 YH+Bm8xrJHF8ZG7ai4c7VymNQUFbmQrdsw7554I/5+zDur0dwTsBVYVBaPfeiS/eDb
	 qNxXIk6CU5YM5uOd8sMwoxJMazBgbl8gPTKOiDfrfeMtOmum6FCVjSye3toxrm4Bb0
	 gYiJubhVfHg0g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9E233C53B7F; Tue, 20 Aug 2024 11:01:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219182] MT7925 new USBID 13d3:3608
Date: Tue, 20 Aug 2024 11:01:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pavel@noa-labs.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219182-62941-mzd9ic3cB0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219182-62941@https.bugzilla.kernel.org/>
References: <bug-219182-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219182

--- Comment #3 from Pavel (pavel@noa-labs.com) ---
> Dear Pavel, thank you for the diff. It=E2=80=99d be great if you sent a p=
roperly
> git-formatted patch to the mailing list.

Understood

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
