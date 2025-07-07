Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90E91373
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 03:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751860603; cv=none; b=bGJAXZeH1J7jrfW3xjWlbf/PVK4D6+h8V8x4BalHA+hPhvG9XB/thWEQakT8kn1aCLdQe1SkCROOqLuUqAP8uGkzMwCQYQYyJ5dj4z4eKq/P6LQOwxGjch+qRya11m8GH+R+AMyk9U1YsQ7vv4iy6UDC767aGuEROzymurejJFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751860603; c=relaxed/simple;
	bh=JohLCWC7lH6PUmsWhhMyaaTK04XaWmyrUsiJssXIJ6g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RZqOiyAqFsgPzH2RraPkxiv2ThvOr6N7L1hyL2n2g+3L5EWXpn5UvsUUMNync7fKMaa/cm0/zSITt9jTNyuiOESVuRlLAPlkBp72sbBu+WnEiDqtB61d1RYKequ+eHthSZIJxz1zUsekd2aNbwsUYuCEQpXiNDu73Xc88UAYDHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpqDprXQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpqDprXQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CA4FC4CEEE
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 03:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751860603;
	bh=JohLCWC7lH6PUmsWhhMyaaTK04XaWmyrUsiJssXIJ6g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BpqDprXQ2UKp/ja6JJ+TH1/w9JEIFNVL+63gwTfVxHMs83zibvgbCT3vjuKAjMUR+
	 /ObC8TRRkDm0moo+ssqIGUCO0uyiJBtufSlpBI9HW3dF6k/ywYJHG2gPVRM7KXveJ7
	 U39MW1ZpHUAtlgHqCSAdETseTLF1uxKfvszORzaPU0u3iVvUc/euPMSdJCVaYZOLvj
	 7N3WgusgPxEzqNyTqU69/yuAY4+6wQY3Z5ZaMc4zp1DkhaDBHzIi2nWb7y6u6JKQqa
	 NEbRfKH10eNb4IUDwJ4JsTWEeQHwhIsTywGwuh5xEBVr3OL9eBE4jw1X7Q7y7yQLDe
	 biLZLH88becyQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 389C2C433E1; Mon,  7 Jul 2025 03:56:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220306] Updated ibt-18-16-1.sfi is bugged, "Invalid exception
 type 03" kernel spam
Date: Mon, 07 Jul 2025 03:56:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: kiran.k@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220306-62941-kpsDKTdr10@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220306-62941@https.bugzilla.kernel.org/>
References: <bug-220306-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220306

--- Comment #7 from Kiran (kiran.k@intel.com) ---
Hi Artem S. Tashkinov,

Sai would revert this firmware for now and follow up with firmware team for
further debug.

Thanks,
Kiran

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
