Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7D344102D
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778839993; cv=none; b=iluJvDpZtY4sXtCjg8OxRAkBdrl7/klFIG/tW3DdBU26SKHB55kAOnvyY9UAq/y31NLm6NQ/zarhjJYXzxe4Wqh6lhpOXxwIGlCEpHz7gl/kD0J4kZSBRj44gdYRVuzLwgfFYl1M56NLbUIRq3em/8VEaJ3pdFfEjvKuKskmhcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778839993; c=relaxed/simple;
	bh=MQIsbJtX8Do+tz0hobbwgPLxckomudNi+CdrlpClGh0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AcMLIojQ8PLOAEFcTp0IWcOHG19G/G3B+TpBq7QIOI6jcPzZe+qlYSCzVsitR+2amjNqcw5li3dQIhkDUPVTCrLBDcV+Q6il/iuq51o5vNbaLG62A89/VsEH0809FucQAhs8TE5z0iXp8W9YTrM50hQoH/ap6zDu2g7XTpks8HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqbW4mAD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqbW4mAD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78F68C2BCF7
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 10:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778839993;
	bh=MQIsbJtX8Do+tz0hobbwgPLxckomudNi+CdrlpClGh0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KqbW4mAD61QkB4um7ba2hoiQ3Actk7v9wI2IFdweYqFpjvIc3SZYHtSaOKNOSMIkf
	 F13rBv81HqzYGlPZYJPKGP/zkAWoadYewmgGWCdBeYdDrEE9l4SPBosimA4UFSozgy
	 YbTOdVvF5I5dehxoNlTKTz8vBNbbPhXUw65Qh0skwDN4ylmrI75VEV+VTVfydNc6Z3
	 VTTjsszpyoVZgja70/AHzeu1y4mJjLIJ19dQeeQJNwyXyyDJe7COoAX5JT/+ZapSXI
	 NupxlGACW0xbPYuL93IOHE/vMMNKFKgHb8bmzA+i5j8i+K3aVF9N1XUHTMN9veDNYU
	 U2x3Pmt0yCywg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 70EE9C53BC5; Fri, 15 May 2026 10:13:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
 (-22) on MediaTek MT7921 combo adapter
Date: Fri, 15 May 2026 10:13:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221521-62941-zCjMDgHG2L@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |erpumper@gmail.com

--- Comment #4 from Artem S. Tashkinov (aros@gmx.com) ---
*** Bug 221511 has been marked as a duplicate of this bug. ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
