Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB00B134CC2
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775582; cv=none; b=dTx42AlADXTGOxM7g8e1d7tNTrrkeo0ZpJXxUTdhb15dqKoGIxzoRUIuaBqC5MqUvbTU4HTeERqWa9l7I8/z4fbsYm+fyJSlE1EOfHE2sWceasR8tGYVVkGDrgtFhU8bSXYK9P8EtmOUxJgk8ye4+5GhrwAQeTjyrhP0VuybVpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775582; c=relaxed/simple;
	bh=mVE7ddUyDTQa8u9xGHRPrx4Y2RE0l6vh1KhRd85k2ro=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TcWl2VaWFbgr/B1AFhAFv5LVIDDF6JVY6CTIc69n5CJMLKqWya2HfrmPJWKfRDK286zJLEtMDhsYR05xpma62RU1bQMA9xpVxH+QeoyKHXcrbgFtjl6uvxyvqyRlutFkVDjYcCuUp3mDDOFPPAbK7q/5TFtpk7YMhGmbBFVrSrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7mJ1z/7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7mJ1z/7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 752FAC43399
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 18:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712775582;
	bh=mVE7ddUyDTQa8u9xGHRPrx4Y2RE0l6vh1KhRd85k2ro=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=s7mJ1z/7xbTg/wWjtwXBfXgJpZHi5tAux0MchapC7J+pe342cEC1loa1Cc4hQz8lT
	 Dj2hhjMilNJS2XbIB7mE01uRvVelfJWJHhMCLgLacTEkqdKnFOvSJGtlly5BomLRMz
	 GaByRtyfkppErbD0eUICqgbmuCUN7vaa5A7oudkXnNz06W80XTuMP7QspAV2pofxOl
	 lkrV1623MX8p9KhVT5QwoeeCCIiUpiMFTMd0KoG1vtXHEX9wDIfJzLaWpurrAT3GWh
	 UfJoVZiBb9Lm1GrRvPExVl1DOmxgNrSR8MwIFBlv2hRp2VdgUc/cZzkod3a3+V7qiv
	 fecFqC1oTOUUA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6521FC53BD3; Wed, 10 Apr 2024 18:59:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218680] bluetooth connected status not shown in KDE desktop
 GUIs
Date: Wed, 10 Apr 2024 18:59:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: CLOSED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218680-62941-RUYuwOc9v8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218680-62941@https.bugzilla.kernel.org/>
References: <bug-218680-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218680

--- Comment #5 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to max from comment #4)
> Working for me too! Can this patch please be submitted to the stable tree?

Will do that later today.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
