Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE7937FF70
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786106959; cv=none; b=MAht4vglryZelBQLYyAIExAzbufBq00cBnnMRZaLnlFudTS9Ni3aCWJQROd2fFGdjIN1s/+aCDI6XdPCZR2AKf4KT1r8vvi/D/mtaawZ3b2TRKK241dE6yILJGR7JSY2KEwKTd+mjmLi9faqxsMTjnQmvPFKPfqW4eTkY7XUi8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786106959; c=relaxed/simple;
	bh=a6QGANa6ZeYyBcSlFkc7qIsSrDPjCN+EslxW/oWpwGs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f+RsTtyowAgNOlvIMYuMWsyBZ6wFMpBhDK6lIG/vjTu/4AHQfqXiunf0t+nIKpsDBxL+4YNrtu0b4IayB8T0bXsdzaIhKdOshau+TSW9fd3KaqJG+9r4NvlpfU7rgkwLt+X/EI6Eu+ynmpi24dqUg4XfSQFsQq4/QmOIKwJq1fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hszss7wc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hszss7wc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77DCAC19425
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 12:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786106957;
	bh=a6QGANa6ZeYyBcSlFkc7qIsSrDPjCN+EslxW/oWpwGs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Hszss7wc6ov+8LWRljnNcfN0CPH4WPILuUaGdimtk2mv7t/FcCoL5PVTkL0nC/Y8H
	 GgK2KDmGGCMGXDg3Mv/eIGg55lJUBny/VYA2b4oCbmjZ9m0DG5WKNc6Vh9zUiDqjFP
	 odk4fC4PcrOIKnhccRPhaSaTnwIq7FPGFgcCiU26Kdj+gCQuolsaDzixYXpFjx5aV7
	 TnCoFACbHO3/+5Si6jPJ5gr53bzemVDuuDUlml9aGVznNf+qwRZ6YnsFTopr223ykM
	 0idR8Jn5lnzVTKRjuoS9Mgc0klCjOgsddPc09FK1aIWPI64akO78e4Cf1lnUOokn5N
	 OPUHBfu/R3o1Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 52899C433E1; Fri,  7 Aug 2026 12:49:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221837] Bluetooth (RTL8852BU, 0bda:b853) never initializes. 
 Opcode 0xfcf0
Date: Fri, 07 Aug 2026 12:49:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: rohanasrani3@gmail.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221837-62941-SSwjxBYv5J@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221837-62941@https.bugzilla.kernel.org/>
References: <bug-221837-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221837

--- Comment #4 from Rohan (rohanasrani3@gmail.com) ---
It's just:
No default controller available

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
