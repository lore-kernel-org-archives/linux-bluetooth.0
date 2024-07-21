Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCF72C95
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jul 2024 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721596623; cv=none; b=T8Vsage5D3L6Vo8eEtf+CHVhEABSZ8Ri/L3QeCPK8WTjAWHLl+6EiN09/4RE4jupWqa4u8JwnoM6lFOVIPAE84LhSyxkQflgNtn8I1EbrVYo3ZwT96SoxDPKCXydMI0jIPb77cC2N3KTwUMgMqh+rXGMpcdBxRFE8k0rbxm8HqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721596623; c=relaxed/simple;
	bh=z4RLMA9cgEegCgvPPNBKhBN4Tm0M00ukQQxES8Dq5gs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Syzz3QfvV1oKSsnqTD2M5f79mUmTtErLk+jf1QWb7EHlbYvY4E5jsHvwDdN7JIqBNHZ1PrGN8PMI29CumKTV+W6i6qMeKaAxyFtbJTgSUgOieGPyh9anes0XY/RtL5GL39TwDvNcO6BFO9WLh+8To71XuooR1S9hQy+cMrY4gfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ljs6yRub; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ljs6yRub"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69463C32782
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jul 2024 21:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721596623;
	bh=z4RLMA9cgEegCgvPPNBKhBN4Tm0M00ukQQxES8Dq5gs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ljs6yRubuVvonLmnxgRcFhhG6xsbQvMarHS/iQJejUqBR6wqxg8v0pZyTo23LUXLh
	 r0gTsyVOMvri2Vhi7DJ2OCLaT88jkVZ8Vd/LtVkySoYM4j4bclTnGY4pmrMnRs1xqi
	 tP28d33vfVwXPEjd+NpUf97Q1mNwT2Nq4suN18yk+lGSJG9HtOSFs2KDjAyYHaabaU
	 xCwIyNl1aqlkkuQ5FV+RQ/l5nZzZU+LRy1LDPo+fWRPUVeVaQ6blNUDN1w307Oa4g2
	 H5jY9NKuTasp+0VY8mndjFquJBfhK5l2xZ4R+DOjSvhcmjKlTI8NlWGUU7MdOQT9/C
	 Uhlq45upgJ3RA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5CED2C53BB8; Sun, 21 Jul 2024 21:17:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219057] dongle bluetooth does't work on linux mint
Date: Sun, 21 Jul 2024 21:17:03 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219057-62941-MG08qTHMSV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219057-62941@https.bugzilla.kernel.org/>
References: <bug-219057-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219057

--- Comment #9 from Artem S. Tashkinov (aros@gmx.com) ---
Created attachment 306602
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306602&action=3Dedit
dmesg

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
