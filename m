Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0897462
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Oct 2024 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729342045; cv=none; b=EaRddHEBczyWTevS4K8yx1W4e4gWiDI3XrrlnrxCvmlxNMWbMCedvPSUkDtFkMkqX16OP5hFoZHoGp7RlCJKtW64z5tekiH7IPb4QHRHPnlQK/AQo/ThIZYnVR6gr7BHNagmaH1IRZDAKRKMnJ7/MCmkE0DQWg8YqWEVBKxaz5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729342045; c=relaxed/simple;
	bh=pieUlRHrqL3PfMUVho5IWtBSJP3b2VRYakzNU4XAT1k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jjZRg92vn8S201vZ/9Nf7EGj1BJR0DEmhil6lcIRLQqTWRCOuebyb13FEuhulqdGzo/MAggivpnYyvMlp44mUKYEKfiIr2BjGokcBEK/mZtnXbPGyLSXpo/vgGEzSMnTKeM4NWBu1gvCdXzlcgMPLsAEQHxJAh7MRVq1Cwu44Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0BptmaP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0BptmaP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15E86C4CEC5
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Oct 2024 12:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729342045;
	bh=pieUlRHrqL3PfMUVho5IWtBSJP3b2VRYakzNU4XAT1k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=E0BptmaPv+IOFv8a/RtYlg2u0nM5W0LMLIC5MNf4kmnAdqVR0VFxn8HbZHhgGMpSE
	 odC2nGIxli6sODNunIdrNbEwl/aoGnHIPVBgzabqY8rZxFtu+ubQOY56nkXwvmZwws
	 mGDmMWqhjg6l1n6jOdyvd2D064ABWDdN/EHBeiobduv/zCX0CBzwtk4tjg3AbGwCW5
	 yqZjzq/RJGO/1KLVigZE3SiNSD/o2+kcR0ngnbQvbLJK00CdtkUmcEVvTqU+YrCCRy
	 Ny9QKjBTja4OYhtfaOIIG3t1zdPrzPk609ziPbNsngzO4lNxvwrDB2GM5Ms/TbUDrs
	 YmXLqnTLeg79Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 02817C53BC2; Sat, 19 Oct 2024 12:47:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219398] 6.11.4 cannot connect DualSense controller via
 bluetooth
Date: Sat, 19 Oct 2024 12:47:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: velemas@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219398-62941-yWmDY5YhRA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219398-62941@https.bugzilla.kernel.org/>
References: <bug-219398-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219398

--- Comment #1 from velemas@gmail.com ---
I was wrong, the mentioned commit is not the culprit. Without it i was able=
 to
connect the controller once but after reboot the problem occurs again.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
