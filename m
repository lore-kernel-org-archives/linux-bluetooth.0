Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5C545BE2
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713176093; cv=none; b=XMAUzqtn0ICHHouyK6wPWmmS9lm/u8zgwjytl6bc2P77R8B+Y4qYNy5OOcQlMSbQbv2Lbt+edAlL5IyNNGBOwxX6UXL878gky0IYgVTei2SLOV7T9SngiUjbFAj9+cIF0mGltivSC5qHFUOhtQrhhpTJeBxd/rhaH27Ogl1Kp5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713176093; c=relaxed/simple;
	bh=w7w5RDBesbTGPd2UN/KwNshwesknO8aZYLRQD4zsqHk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eHJH6+UNkZySg2KcBzXxfcsYUCINDrp/WTy1YmffWevkkGwt2D5JchE+kfYsI7PQTSwqaFvQV6U/6+XIdXC2XsbtyYT3uMMQ/+dNSMo2440OVk83Lv+juNT2ple7JS0pbVm8VXXomHrhut6S4gyVMhKtMr2YaD1jFtykoPNUpoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUO6pag/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUO6pag/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0E81C2BD11
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 10:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713176092;
	bh=w7w5RDBesbTGPd2UN/KwNshwesknO8aZYLRQD4zsqHk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oUO6pag/ilPrCSSkJMmffdSxJ15+UYrO/PhIj0B48MYU68xiZPPau1rnJxLBWsRMK
	 W9Dd180xXB5Y/M+KYvXPyG67W83S+vBQEyK8eKeBmD5seUmgtk13OwnlkTldCY0s/5
	 t8NJx53mLOtI3UsN4B0tDUMp9sEOq5IQyV/oT01OsEaKsUDasATNDF3xROXnB62+rb
	 NWSOgH4l6OTvzCMvskZYF3SPAA0paHxwOgJQ6GN3XBqiJi8XndCbKYJDGccOW3TAxP
	 hywvu8/XfQRQZWVDgcza7frvbPAPcw2aGxAX7gy2RL1ns6EutbEbJw0YUTsG8pkvLT
	 eBVQh3ehbKWEw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9F0ECC433E3; Mon, 15 Apr 2024 10:14:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Mon, 15 Apr 2024 10:14:52 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-7h1OkAKtSz@https.bugzilla.kernel.org/>
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

--- Comment #6 from Zijun Hu (quic_zijuhu@quicinc.com) ---
have reverted below commit and update a new patchset
Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with
gpiod_get_optional()")

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
