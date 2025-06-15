Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8025A2E11C1
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Jun 2025 21:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750022580; cv=none; b=XhSzOyO/qPu3XXeScZK3Bfl4zvsE1IyTI/sLak97HyEy2IDhsAHRP9ym8F0VB8luCNq8DOszdOzrsGFmBO1YMpcMzS1uKTlDdd7hEKw91Ca7cvXbadcUx38szasQ79vK9Ax9PhTDOhEfTOKnMUwJlEMNqgBTPeuW7M50uGFYWqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750022580; c=relaxed/simple;
	bh=FCQEkiScEt/9PQMhexhW0/inmR8uiulR7mUA44ItWls=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gnQdpgPkzK8wc8hOMvG9hvjyxJgc9afKbD5tdRmtYFhsWaeqI4gIcWxa45paNQJHxzuorWX2jf5a8rc3FDB7NPUGbgkpHE9HrjQjamG5Y+SNfABGyvSaeE15jTn62Pp/Idd88C4i0t577E/6q7A8/pX7h4zzxRfvD+oTh5ElDrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bK9BYWoP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bK9BYWoP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A322C4CEE3
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Jun 2025 21:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750022580;
	bh=FCQEkiScEt/9PQMhexhW0/inmR8uiulR7mUA44ItWls=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bK9BYWoPFy0/UmAguzJdtPnobWipUuC9QztpIDj4PykpGC/Uw50X8RZFLfA+qg6qG
	 N1QNipF2NrDcks24LKy8AUWBUxbs41eCeID/vGIXWb7dgm6dVBz9D2bwndu/qse4+J
	 i0lXwcXZLUz5s0gTfFCzH2OqCevXAdSCEjGQR//bbpbUBhmYe7XTaT6d3cXDJZZNqV
	 9Z4gcbu0VTgiqZ5J3lBISSiPqkZ5ss10wiUeNDUv6R2HAuBx/hOI2Dh6RFXxg/HR99
	 LvVOflknuJnCyMeM+7mZWzpnDZ5WcfwxHHoGNX72n6K4aIcJlPTfZlxx8Q40+Qf1nJ
	 LdMaUFzeyjrCg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EBBCFC4160E; Sun, 15 Jun 2025 21:22:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220237] Bluetooth: MediaTek MT7925 (0e8d:7925) fails to load
 firmware with timeout (-110)
Date: Sun, 15 Jun 2025 21:22:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: are.mehus@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc attachments.created
Message-ID: <bug-220237-62941-RYV1DD6Htm@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220237-62941@https.bugzilla.kernel.org/>
References: <bug-220237-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220237

Are Mehus (are.mehus@protonmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |are.mehus@protonmail.com

--- Comment #1 from Are Mehus (are.mehus@protonmail.com) ---
Created attachment 308260
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308260&action=3Dedit
Output from lsusb log log

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
