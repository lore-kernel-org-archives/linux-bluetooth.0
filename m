Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EE417A2E8
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745236892; cv=none; b=L2I7gakRcXi4Ff8KNBiMOaDjFN34UlXA/EtTsovFrbbm94X0X5YoQH1tb+prtibq00Qu2uaqB2L8gaIh7O0N5g59KVkplFfauRnSy3ixQK3BCy1LN2DP8vG0Nzdau8hh+Bgo0Ez86J0T0BzDoMOQEFrT3VS9sfOG2o/oy0KXWYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745236892; c=relaxed/simple;
	bh=Dt4KGGMyOUxXZScM0ne47kdg0SyCoElqmxO4OIdg9xI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rqgs2VPknI+WraqHlDGZr/gTceVZwgK0i6P2tb175gDJu5IixUX5+wHarfRjAw5i3rf8NIsPyge2uFF+C2MBufyxtpMO7b+uujrIpItLaiz1mbPoJrDWiCcLUKy/tezJXE9nIHmkyT3OAuHhj4FXl5alqQWjT2vHkwzEGJBkvBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+LTjfto; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+LTjfto"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E92BFC4CEE4
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 12:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745236891;
	bh=Dt4KGGMyOUxXZScM0ne47kdg0SyCoElqmxO4OIdg9xI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=B+LTjftoKMCL+dh1GmC/blXwNyBiLqnlocZkMtIGSWi+LrU9sUZrNVN1u4w5X1GoG
	 VR7g7yeis1Y+o6e9wj6r54dLKKzK8RXVE2bzBEUp0UBu7M5f+LDT4EEA/mOUYnsDVv
	 sx1jhO9XGX12mx2MVUIxgjifANAczbaF3IXaoDG0xGexiyB8Poe08b3MpNdX48xUqW
	 FGW43Agi/Eiw0FNw7WHClQhqCp275uPDJW3VGjB2rvn1Fg93zo7y9WxiDVYPUdDW7A
	 Ja5bnfOMMMhSFlaBLl3diUV1Q0bNbSY0Hka94pXy9RMNprdZacUv7ZjMerW6ZI+VCc
	 0d+d0dRXTOeiw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C940EC3279F; Mon, 21 Apr 2025 12:01:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219894] Bluetooth Qualcomm WCN785x - Input/output error
Date: Mon, 21 Apr 2025 12:01:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: agurenko@protonmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219894-62941-YpkAL5NIk5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219894-62941@https.bugzilla.kernel.org/>
References: <bug-219894-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219894

Gurenko Alex (agurenko@protonmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #3 from Gurenko Alex (agurenko@protonmail.com) ---
Thanks to the background work, the issue is now resolved.

New firmware added into linux-firmware as of 20250410 release -
https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/510

Kernel 6.14.3 contains the kernel fix:

commit ece126a8a2f571ee89b65656ec73e41fe9ea36c2
Author: Zijun Hu <quic_zijuhu@quicinc.com>
Date:   Tue Jan 21 19:46:42 2025 -0800

    Bluetooth: btusb: Add 13 USB device IDs for Qualcomm WCN785x

    [ Upstream commit 2dd1c1eee3e496fcc16971be4db5bb792a36025c ]

I can confirm it's working on Fedora 42 with said versions. Thank you for t=
he
fix.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
