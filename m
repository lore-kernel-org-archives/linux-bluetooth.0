Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E4219BA3
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Apr 2024 04:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713069418; cv=none; b=tOMHMVM38pjMPyy3oixbjlerSN1WRN+Kb/0kVxvd3/6u56vcz3Ny3AXMplYZOZsrvoxPa0M/b4Xvr9H62A1teH1UxO2/iXv7+RonHI5lAOv7Qe9itjtAWyMmLTBqed4Jh3DN1xJhE8jogWpB6IwAc3KVSE9UYD+qvR5EBeWEU+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713069418; c=relaxed/simple;
	bh=Tbu4apRO/zc9bepiMQwa8gjcArcpiAsyUl5YRVMk+Fw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o45frOOhTS9HxitIEA/GnFZp20s+viQz0EHHpYJLDT3fnbk84+PlLtMy3ggSRM74axDavAbzdNBBwNpbKeRHFa4V2j50li657OGPwMS3ZgTAHqS8U9dx+tNqYw9imroO+rYCVVTM4c6hz1fM53AvOG7pf553OGFmvsr59H///UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXY40PQw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXY40PQw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF3ABC2BD11
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Apr 2024 04:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713069417;
	bh=Tbu4apRO/zc9bepiMQwa8gjcArcpiAsyUl5YRVMk+Fw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AXY40PQw/VnUNam/TF3IxH5N7g/zXVmmKkDTF5Ap/A5d9CDZt8v+2JGwepYcPf8Rd
	 srrmzGPohPva+6r79X2nB/81+qdwMY0KpfJWK6sBqOtRotrWvaPyq6uHu9mgCXmUJM
	 6TS8rBT89VuovHLeYN2nsfH/cPb8tSJIiNtrnEnoNqc2Jykf0DkwkVXqDVAZlcWF7T
	 NF7m2Od/g0bwp/gWITKzwB6MzBo6wIYbHRGnNcBsqMPFKbn4XO6vPVO5r3oc0QmWXh
	 h/KU9BgBeN+SKIiZNsdjEg7/dk6MkW/vJzTh/u/Tndnd4q/udbdoDgywmAy+oRc5o6
	 /GoURRkxdfvkw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A3138C43230; Sun, 14 Apr 2024 04:36:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218680] bluetooth connected status not shown in KDE desktop
 GUIs
Date: Sun, 14 Apr 2024 04:36:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wolf.seifert@web.de
X-Bugzilla-Status: CLOSED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218680-62941-eOYfq0jkAQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218680-62941@https.bugzilla.kernel.org/>
References: <bug-218680-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218680

--- Comment #6 from wolf.seifert@web.de ---
I cannot find the fix in linux kernel archives "stable 6.8.6" (2024-04-13) =
or
"longterm 6.6.27" (2024-04-13), only in "next-20240412" (2024-04-12).

Why? When will it be in stable and longterm?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
