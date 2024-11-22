Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3B9176FD2
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732269808; cv=none; b=bAA0TyagBBLctBExgN9zl8VXtl8/zgBAcD/uUa6B4VyOdNvAcwDacYeMbLeOpHttcMGQ4wQJf/TS4XaU31soKyjR7ASvi2Sf/w/mMWTCNaAgJwh+vkQE0rkdaD2zLnZRoKkbAZOI5K9xvRAsVApeX9xHyeS6tvZvn/KuYhb+0R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732269808; c=relaxed/simple;
	bh=xdm+lP1P4SKD9Gw31rOf7WDIHZj01tHyhzpD62wjP9U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g+fJOwYW+b1DwMrTdfFn3AfomTx34kWUyMDa1zaymIpSI+q8xs0aefspESHdqqbcJXGaKOZ8RlJ1UWZWTvo2r964OVP0X9yID9xH8So1GnvRWpOl6/SrsvetlJesfE9I/6g3uCLHIZhcQ4SUgPfPKunK33wSlBbm+Lr4WDneCjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPAXHeCZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPAXHeCZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6180AC4CECE
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 10:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732269806;
	bh=xdm+lP1P4SKD9Gw31rOf7WDIHZj01tHyhzpD62wjP9U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dPAXHeCZKRfYwsc/xfme0BVYC5KGUUlASGoZyMddBAuXqf/ZRySD2qm9kY/w51svv
	 DV8rTM5veZMt9ZPHoXUvEuk/qwFAs97PKIEA8hOY0PTCVBUvYK/OWfSg396hJbcZsF
	 n98D7EM6PMg3ts+E2XOXuMwytB+Yl84N4JTROk/hUeVlQ6heuNoql2EBAUXvu7XOZI
	 DtDc7kWdhmBr5Dxl7wrndV1Z3jVya76PtCIdFvNlWXTqHD6IUL53ox3Owyo8B7AjFn
	 X/CFzpNxPLDpGaeyei9dEx4ylIQO4sIz+lo6r7Kv5aeJtam56IquHQ5aqSqy3Opv6W
	 q7N1wl3PWV6cA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5964CC53BC5; Fri, 22 Nov 2024 10:03:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219519] Hibernation Failure on 6.11+ due to btusb
Date: Fri, 22 Nov 2024 10:03:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lkml@antheas.dev
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-219519-62941-GAg3qONIFa@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219519-62941@https.bugzilla.kernel.org/>
References: <bug-219519-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219519

Antheas Kapenekakis (lkml@antheas.dev) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.11+

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
