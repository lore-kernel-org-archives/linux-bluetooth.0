Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CE93644C1
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781265753; cv=none; b=PtbKfdBgIQ2jNt9mGSCi18Q0lMJMJRZtqP9KYKsC/Q2/tNKviWXGvIc8ln1dqxSE5/WQZ7jaRE39dKqgJsocmfx0X9aBA9ZJg7EY8rsSDMfzlVfXIzkKj6l6jfwytE3PLHWo+7MqZqK0L4MAP/+S2XlM1KPCR+1x+3i09QAwdKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781265753; c=relaxed/simple;
	bh=1b9wZnF058/4YnrJOTrBAIOaZ0ztkVZ+4zIpvPJCTs0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mq0lDTgo38i1y2dh2KvXuH6G5KsuvbSsMEM5S13F1PXClJT01RCORwVz2TTf48snDoO7WdL/fdEZM9odxIymurtIXmnmTctbiTEIPzqN4KLhk5buLOI5T3nA5oNd1OhZCkwbY0NLzCu8lVyA75+y+PHUOjtRv73dxHlucyB8l1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgPMin51; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgPMin51"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EC42C2BCB9
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 12:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781265753;
	bh=1b9wZnF058/4YnrJOTrBAIOaZ0ztkVZ+4zIpvPJCTs0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BgPMin51zQ2JrQdcAE9p+Q8kgLtF7s49VNgP3vfq9xUt7lajab+8Oa0jJUOqIf4jf
	 DHLaqzpZUQiiwGmfRASDdjN3CNOYQoLJ2vRB0eKtt5IIBR59DJIHjL5NFtRHZZpr4G
	 lIuwUmgNt4iaNsnTHqzn8MsiyCBsf0lNV5J2pee+XGvUj5BfIwfCKFrPHUON5Etk+R
	 VBk7nGUkJKSYnIOp4DXlLFhzZBjKxC0O4hf+NY/0DX1JFVxcI+vykPxBWixT2eQqul
	 tGrMQIbgKxf29RoXbArh+PqXxRKwfdDg7RPhyvQdHcn+oFZ7RLAFmwSX4oC26Mq2ps
	 p4gvHl3L0mzXA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 25098C433E1; Fri, 12 Jun 2026 12:02:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
 (-22) on MediaTek MT7921 combo adapter
Date: Fri, 12 Jun 2026 12:02:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: caravanumpire@atomicmail.io
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221521-62941-rp33PN59lT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221521-62941@https.bugzilla.kernel.org/>
References: <bug-221521-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221521

togaassorted (caravanumpire@atomicmail.io) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |caravanumpire@atomicmail.io

--- Comment #17 from togaassorted (caravanumpire@atomicmail.io) ---
You can see this if you use `journalctl` to view the kernel
log.https://lore.kernel.org/all/81bcf9fd-2f07-4fc6-be90-da4e448379e4@leemhu=
is.info/
https://musicgames.io/sprunki-game

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
