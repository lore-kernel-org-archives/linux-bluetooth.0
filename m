Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC39226A0F8
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745853140; cv=none; b=Ycz5ECR+9ZvarpCPCoCsAMAQb74+QYlf80VcZQwD6vMfWyGPnEGrcAv1t42p2OBjhifuoUatknUdSijP860vHIfUWLlsn+wwrNHfQnnJQR7+V+wDu8DzEzMqZfzUs25KyVspxewAUwzoHjdhzkQWy1DG7Kw7hnqIt8tmrUNg7pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745853140; c=relaxed/simple;
	bh=K6aqCuxSZqYa+Ubtm8GpnQLYzb6GqTvQapDtbX4U10w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LvxEzNWHIxSDpL20cD4vdPclDuQKEZGEwAJ3q7yMLuSqnthjnRfbAcapsbJy+c4yFSwv1bmzXj70+nCPVIKh+9j8AHi1psKI1TGcUQF35LkVL04/rGZPEe+EJ2GsTa5RcqtJ+bm+Uymp06U7yhLJZ90IX460BrviHy6QoJc5+MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQIkqDdq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQIkqDdq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 283FEC4CEEA
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 15:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745853139;
	bh=K6aqCuxSZqYa+Ubtm8GpnQLYzb6GqTvQapDtbX4U10w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YQIkqDdqIsRXAnz9iGbn7ol5ZEbZV6+nKBPRFHXSP2qE4kY4d0ppGFnqSPVhgUdFX
	 8vF5roOKrFJMir88urh8FZHBBb/VHiyW1JomNisRhT0m/LR2ZfLbzRRpIDwk+LlgJL
	 0fJPoFK8CuF6Gob78v1bDqruqh8fJr7s0cF3NOCTBysFs7Q/Lom1DabsvKyQDBJ07R
	 dbB7Z17Haee8/m2q3Z/EUmW3KfthG5VTWj5cKOm+KfAwWkqbpsQPEQlReqGT0wGH66
	 1nvxZ0icXsdAueVNbLtM0ogTBbPpV21koBeSt8gbR5yNlmhCe6sEMvrdYVSsr+bKUR
	 Ige4ZNY7HPzeQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 207F8C4160E; Mon, 28 Apr 2025 15:12:19 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220061] [REGRESSION, BISECTED] Multiple Bluetooth devices
 cannot be paired under Linux 6.14.4
Date: Mon, 28 Apr 2025 15:12:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_file_loc
Message-ID: <bug-220061-62941-CK7C8JnKVW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220061-62941@https.bugzilla.kernel.org/>
References: <bug-220061-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220061

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                URL|                            |https://bbs.archlinux.org/v
                   |                            |iewtopic.php?id=3D305211

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
