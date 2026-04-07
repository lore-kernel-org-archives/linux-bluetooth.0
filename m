Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3908D2BEFE5
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573110; cv=none; b=oSPYEccF15OAD3/O5FjjV2nZv8d8JIWx9tVBpiKul1yr09fVAj9AvBub+lQm9OhwzXXjIHWc6A5UaY8U6zj/FwPOfWdxH9JlIJ2qQqGDHK+gzIu3C4GpAipgVGQzwzt0h8TOuj5+pWpYMWVqySp0UzJDp3i4OhoLsAO7+hyO9Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573110; c=relaxed/simple;
	bh=w+8Qd/Nh5B14AclKWeuzAcwU68RkDjfCVt1TyskgF0k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ywl/uO8T+sbmeOSgILmJEpqAxvhRtTOQj+sZAqziQhRDfDStUVUqz2iWvFgRvQNs9IINFq3oGd35aZjP6APv3w76/z3WGQ6luhJRbVLYRLAa+2WRxbEp0tFhTXOo8MrOfhf/2AYBh01Os7PNhAzj78eN3caw42kcSV5/f8FrpQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtGi+pMH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtGi+pMH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E96E6C2BCB0
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 14:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775573109;
	bh=w+8Qd/Nh5B14AclKWeuzAcwU68RkDjfCVt1TyskgF0k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QtGi+pMHbdL26IrUqWR1Hs2j7/EHzlAthWv3CMCuVYwrdPIigefn1VbJ1TAOryoje
	 U8vbFH7lgsQVUe6GBnB0PAZevEWdqztxC4ECahkjidN4LBBwquf9/+Rtwocq2PnVbr
	 Yv4KiTlA/8AP1jq4xsbdxt2M4JsfgHGPw38t/aoIHEFtscDyMqaKh7OI6sbGfvU1uU
	 OMEKkkBYuSdb7937EwhTUHGnNst3XXOufBgCV0EUe7MRHbt2MwRiHVTC5Qq5HPRpaP
	 J8zuKTR1ccyK26cOL7MGmHAUddxOmA7h2ynJqy7GgrLmML1BGkflwzrsjFk+OxHXRP
	 ukWsLN7dcEY8Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E1C05C41612; Tue,  7 Apr 2026 14:45:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221309] [REGRESSION] rtl8822cu: BLE disconnects with firmware
 0x0673_0EDC
Date: Tue, 07 Apr 2026 14:45:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221309-62941-M1XRTLSEFE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221309-62941@https.bugzilla.kernel.org/>
References: <bug-221309-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221309

--- Comment #3 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Hilda replied [1]:

> Thank you for notifying us and providing the detailed information.
> We have already reverted the commit. We will proceed with fixing this iss=
ue
> and provide an updated firmware once the fix is complete.
> Thank you again.


[1]:
https://lore.kernel.org/linux-bluetooth/bug-221309-62941-wS09ufbMTD@https.b=
ugzilla.kernel.org%2F/T/#me79bb1b45c47cbda2de692a6499ecd514709c0e2

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
