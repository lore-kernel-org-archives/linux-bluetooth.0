Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B881D435F
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 02:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786071124; cv=none; b=lvlCjOSKORQOxUBSNaCYXZUJ9duaTgVDVpom1eZOtC2usCNjuLHLFC5qor3+Eencm7LnZZ0eoVM2Cn6kcgbyJjl37+M/fJOUmm+xwdntcR1l2wLl14X7TnpxRzCvcXXi6avsi9e8QHT6xE4zrUlEvz4FleQnZvnX8SPYknnq+6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786071124; c=relaxed/simple;
	bh=ziYGmbhF72zdAuxRzO3gIOt8Cu1kR9eu8vjhSXVLe6w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fwnj0I/he/5fBjMIpnQduGu0uVFUimiKCKh3hAiNb3kl5WKFq4+BqsB5BRwCBtdIznq1tolDNm1gFeJ9XyNkMf5G9N+qzflZ4K/SDKgJNm4DFSF2OQx9iR+8PgJmjZwe09FUcbVnD5DXv/s8LsqBzyjyDHqr3Gp54rYhnlVNpnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+lFnzgj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+lFnzgj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE832C2BCB9
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 02:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786071123;
	bh=ziYGmbhF72zdAuxRzO3gIOt8Cu1kR9eu8vjhSXVLe6w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=t+lFnzgjFpAJg128PX+yOq844Nm49U6AHURu/ExUzPsd0+J5lpsVACa8Y5zFtqe5x
	 5FyttwHlpF84gNPSw5QELCEcMDRmE/bNLP6OmxhuGi7dHKKmmdgEdmRrySwcJKHUvn
	 LDYWTX7MEGshOKvi2UXIQn1UHZM8HksRGA5lTblwDSWmT0OgCXz3DuJNMm4mCJS3W5
	 49Mslo4z9GKMXXSNFP+bXwhqkA3zCNmOibu/YRMaXPy9k692bWjNU6Zf86Rwg0d/0L
	 BBb8sdCLF0QPPQdxf+d1gba+05nqDXe5fdQWxcwj7520Uw4yA4HsOvHDX6WBASOVfv
	 u+yP2GhmQFeiQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B4D12C3279F; Fri,  7 Aug 2026 02:52:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221832] MT7925 (Foxcon T99H493.03) BT missing in lsusb on
 Vivobook S16
Date: Fri, 07 Aug 2026 02:52:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lnxps@bbtex.net
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221832-62941-YWKEFRuzKp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221832-62941@https.bugzilla.kernel.org/>
References: <bug-221832-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221832

--- Comment #8 from IQ (lnxps@bbtex.net) ---
ps the DTB taken from 7.0.0 x1p42100-asus-vivobook-s15.dtb crashed the boot
process (not video output, screen black)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
