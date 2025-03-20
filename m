Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9702A1A4
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 20:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742502160; cv=none; b=YY/73HHl7ZfHJ8CsXZxZzJq6EmDPF8BfHvrKGtGdU6uqAiEyoWhzvqMVWbKOBalAgHU6jgMmmgWblRBPYy5YLVVNIgiVymtBWl1LvUwvwy8vEmuBMCIl5L7dWY6uTASEvvUmaiOQBCXa0I8hFSov4DzuIxgU0ilwPnzHgpgCZng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742502160; c=relaxed/simple;
	bh=mCkteAk9g34rxNabyYgChvbnoN33bmITSqCVyocjaiQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jlaCKmPdFCkFbBWV2pFZFehQyiqTTSoJsZQ08v3T8XKMRSkyr06YfzocpjcNyRBZUDwTd4tu4Bi6ND1qta46WN6wVPuoe8J3hsDVRxfn37GWqzjFxqWwPuYj2Rj6z94U2nSRaM/h6GzYwbBOjiBkV0GV9ERnSHzLcGt4XSU6FeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mX5qsRiH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mX5qsRiH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3422FC4CEDD
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 20:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742502160;
	bh=mCkteAk9g34rxNabyYgChvbnoN33bmITSqCVyocjaiQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mX5qsRiHoy3XmZsfzWIpsL63tnU9vqtVL4ZTMCMWAnWHTgehPx9pRwmKxjJX4K+jN
	 QHn72zWRJmLkPKfTl2l4VC8C+tjQpY292Vuf1DYT6qasd8hsR8B2TAwVH8N2KDjNpo
	 i3+6lSbNtBWCtNXn8MIwOnawVdSpGOiOQ3XJMy/Y+G2YoJ+rvj/DrzeG1khopdhtbZ
	 4fZbSpPScME7yOdQDavxejxTxJVFqbQlafkhe1ZNW6VGgwyV5kvaaHZqSVdBQWUeHd
	 /VhsCyQMh33hV+OY2dOqL0dJGNgGf6oX27MeGwDibqAwF5O5C1O8GZ0Qxf+3B7F+qn
	 rxKzUyAqt+1zw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 20E20C3279F; Thu, 20 Mar 2025 20:22:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219898] BLE - Intel AX211 fails to Pair on first attempt but
 succeeds on second attempt (utilizing software-controlled bluez API via Dbus)
Date: Thu, 20 Mar 2025 20:22:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: miller.hunterc@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219898-62941-gT0maBd69M@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219898-62941@https.bugzilla.kernel.org/>
References: <bug-219898-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219898

--- Comment #5 from Hunter M (miller.hunterc@gmail.com) ---
Created attachment 307872
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307872&action=3Dedit
Failed Pair Attempt Air Sniffer snoop

Air sniffer failed pair attempt attached (recommend filter btle.length !=3D=
 0 in
wireshark to filter out empty PDUs).

From what I can see, Master (computer with AX211) does not send LL_ENC_REQ
after Slave receives Pairing DHKey Check when pairing fails (failed pair
attempt No. 182 and onward).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
