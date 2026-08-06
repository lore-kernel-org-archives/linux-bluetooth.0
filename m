Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE3B4252BB
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786010120; cv=none; b=GE3uDFgu2PT7ciHqWJTeVsqlSIspGtHOYQYYa+j0wyPyUkYY3yLFJWZZa0KaZv/xOjYbsfYA8WMahWjFfWDxPzTMVQf1EmLKeUyue9IbwK+d6BBim9fRClTkSZZ7j4CalWt+1Y6RD+m0bAL9on4wRoBY+lG+FLIz0RJmN0pBSX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786010120; c=relaxed/simple;
	bh=Cfs7+FTinwitm9eXKnpr/CnOhQKaKTLv1eHs9aaig0k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GkeliYfV33vcqIsFJU7QyY3BiyPQyED3wFpxvrozoGRjPvdrAl/5j+g3bfleGYhgpbL9CkVfbhSGftxPvFeHtxsRuT3dHn9mc9FD8PJ4vCkmrLzhiJZHW2YdjmqNfxxhH+mGoI85i3NLdPw+7KTvL2hqDErJWp1pb/JH8unfzrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBeEjeQd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBeEjeQd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EFDCC2BCB9
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 09:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786010120;
	bh=Cfs7+FTinwitm9eXKnpr/CnOhQKaKTLv1eHs9aaig0k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kBeEjeQdQ2hlBoPWee+hOJknvmvBfGPLUulz2nuj2RyyeiaDnMMdLXyQUfbU1EiWb
	 Cp1CGcYP9za4qAP/AD2+RisFlZ9qa4KDnLaDRhgXPkYbwlQqgWZDDNe5izj93l16FA
	 gelj9PPzduG+eyi2/q8y/6yEgileyZ8IIrTHjNA5JumQLYKhd9BOZzkeRdpreDYdZx
	 X2MrY2Bemvm1F+neeXKkU1cfS1YSHDhUmZKq5/R9nhwsTDLgjzxa5YuAbkVYhDqigm
	 baTuLfpqgD7acE8nvUizmUiVaeLOnMzhqnq3AXIAQSaWWgvukG+RxcCDsGIHP+0OKJ
	 h1Oer4yvEITLQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0E7F6C3279F; Thu,  6 Aug 2026 09:55:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221840] Regression: Intel Bluetooth (btintel/hci0) fails
 firmware boot on 7.0.12, works on 6.17.10 (Dell Inspiron 3501, AX201)
Date: Thu, 06 Aug 2026 09:55:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rohitanand9418@gmail.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221840-62941-FhMCXcXZWV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221840-62941@https.bugzilla.kernel.org/>
References: <bug-221840-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221840

--- Comment #2 from rohitanand9418@gmail.com ---
(In reply to Artem S. Tashkinov from comment #1)
> This kernel release is not supported.
>=20
> Can you reproduce the issue using 7.1.6 or 7.2-rc6 **with** the latest
> firmware?
>=20
> Also, are you dual-booting with Windows?
>=20
> If you do, make sure you have disabled hybrid shutdown off in Windows.
>=20
> To disable hybrid shutdown (Fast Startup) in Windows, open the Control
> Panel, go to Power Options, click "Choose what the power buttons do," unl=
ock
> the settings, and uncheck "Turn on fast startup." Alternatively, disable
> hibernation via admin command prompt using powercfg /hibernate off

No dual-boot =E2=80=94 this machine runs Kali only, so Fast Startup/hybrid =
shutdown
doesn't apply here. Will test on 7.1.6 and/or 7.2-rc6 with latest firmware =
and
report back.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
