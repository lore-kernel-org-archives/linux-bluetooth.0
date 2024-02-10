Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4548A38DC0
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Feb 2024 23:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707606474; cv=none; b=Fspk1We8pEhJ2A8uhtjW8hT6OtkdgIDUkSLok9D/8FzLhX1G0KQFiaL02/P/nYfOMxWmBmPrKC0m4xaCaNefnFkR4jkPY8HXRVQwDx45dVvCDlLoogJKLAosVAmT89dfMto2P8RpPD0z2aFtQUkOPmiawAAy0vIzXP11QV/N88Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707606474; c=relaxed/simple;
	bh=nT9X3dJneTAcIj7oefjKBuB85jWB/ZJzW0aDYbfYOPQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sHZZQ6gPfWl+bbwBmWYthxGebxZe+zpI9Ts8DWRFBme/uVja1JD8nN/OoHf5/IbvkCiKYFanuD94MXSXz13alrbCU0juLvU4r9iyi/BVsLM+EopI/b18YGXnfVum+G0AkXoLG0ez8bpP0Pf4ZYBn2K7tZHfb9C0pbref42LPmdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7+ChFKA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7+ChFKA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3290C433F1
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Feb 2024 23:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707606473;
	bh=nT9X3dJneTAcIj7oefjKBuB85jWB/ZJzW0aDYbfYOPQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Z7+ChFKAjozjuXBYK8VzL+hLgjTl6SELtM0XURCTPnZaXEOQvkS2lDZCDnj6J4Gn7
	 v1jThYu+1Y0N2Aa51KNsSj21pmFqTpA9I7woGAAawla/fEkNjJ4ZlRi4nt1Z12Y/ig
	 t1MQzDDl8zZhjDyuZ5VfifOVqi0dpQePOQc1DP3OP007GU92WW4bcmGN2UuG1kF3k7
	 5yzEvghELrOBVz+F1AhbmMlqSycTiFHd0rDp9LQKlUAPh9aFIj+YWlnviRnVs2wr29
	 twx99/pwks1aGIr2ecdkNa08J8g567MomOlnbPr40a1PsEoOpjVqL4cvcgPjcpb0BQ
	 1EyzzN27Vz2LA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A435DC4332E; Sat, 10 Feb 2024 23:07:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Sat, 10 Feb 2024 23:07:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dustin@falgout.us
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218416-62941-cSG2psEnw3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218416-62941@https.bugzilla.kernel.org/>
References: <bug-218416-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218416

--- Comment #4 from Dustin (dustin@falgout.us) ---
I discovered that Bluetooth starts working again after a cold boot (shutdow=
n,
disconnect power for 30 seconds, then boot normally).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
