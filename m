Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE9C446AD
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173658; cv=none; b=DO1mGkF6SvGqH633klnlt+zGPiCUYFGdstUlSHH9wfOjyLuqHcTg81lLdOJDRjLLq9yODskRZ4FdJZ4oQSgIwZ3Xm4Z7FhsC5G4Mdsq2SSx+vFhEeb31LKPslxnsixzAudOegHQr+N1pbTX4t4ksqtKN9Lc809gYX1vAhoMzOwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173658; c=relaxed/simple;
	bh=96eFGPVH/QouQocOZSYM/RzkciTDYaHfk5QG3bgbIws=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qmcl5NX68EhMdVVChAC15MSSVKEUcE41tS/fmzo5R5rdvKo3RMQOx7yh6n6M7awWv9ovCQq3moZfIgLWqthPGU4oEl0AVWG+KbjqgTKJkDOBJquD+/5q9sFVZ6Ikfa9cbon2uq8michCtudhMHUXRd3whJgBQwRIzBNQ/fJueEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AY4aLfRd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AY4aLfRd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60C78C2BD11
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 09:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713173658;
	bh=96eFGPVH/QouQocOZSYM/RzkciTDYaHfk5QG3bgbIws=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AY4aLfRdsBd7jkuOKDakagUdVJSneT0m28Mpzapvxnz8kNWlXhu0ArrJeCgOLD+f/
	 kyL5sv5q//0XZhfx8mo4IoqpZjc0cIoHV44tbE0CugzQXPcqPwtmSNE2+5yn9REtis
	 C7SvO/0MDbqc8SA0cAgG8kQvGN+8w6NBVVVvqzKFqVgGipWZ/mZhm60EQWkaNcqePH
	 hqKN0dyGPdHvbPX2rK5KscbaO2xvRSBmzpcvys2xo0viNEfHpHPAdw24UNqfQOX0P4
	 SMXcBIhIVhVvBd3PRxEJAmE+qsQBsmE8okzU1vPR7fDYGWWmc2yraUvZwFhyt6gbc5
	 g/kkTO3hyJ0Mw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 54A14C433E3; Mon, 15 Apr 2024 09:34:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Mon, 15 Apr 2024 09:34:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: quic_zijuhu@quicinc.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218726-62941-henc7rSvhs@https.bugzilla.kernel.org/>
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

Zijun Hu (quic_zijuhu@quicinc.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |quic_zijuhu@quicinc.com

--- Comment #5 from Zijun Hu (quic_zijuhu@quicinc.com) ---
it will not print below logs if the patches are applied successfully.
Apr 12 00:30:05 braindead.localdomain kernel: Bluetooth: hci0: setting up
ROME/QCA6390

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
