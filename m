Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB11F152196
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Dec 2024 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735586554; cv=none; b=TSpTeKD5nxEu/kpIv4yLsrxZzktPMRhxSY230N6KxJLN+dtcADg9+6m+tUzFf9eW3cR7PHMuZOKtw6YZpOU8bEEq3eA9FlSMaRsY5lSlaxs3JIcUk4/+/CfsiEVGfNIT8tYJ6xrvRTpXstNlSr+GLCKYiL1Car/FhNtaDL+LMAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735586554; c=relaxed/simple;
	bh=u/70hKkrwRwDaGhdDjIP4SSu8kpF0rQUCRcofxbiAn8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gvS0mQOsUQ8qGXvGagJ5amwwJGcGQ2KgOAJQwDyEutH0zvNO7W0i347wbbuigbQQmxj8NWhuuF3s5LTl3r+vH0ZrYdy6p92/tbFiz++jb1vJfs7a/vYtR2pL9ZkoqhHn2u3Tq52LI6OfpytzhUp/A+LU4+Jg+FOh7U6ckAKxFI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vchwcotb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vchwcotb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36555C4CEDC
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Dec 2024 19:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735586554;
	bh=u/70hKkrwRwDaGhdDjIP4SSu8kpF0rQUCRcofxbiAn8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Vchwcotbt9k9RU8JhkfqGwpd8kFpEBjDCf09Ic4vl7AojDBFkJllI/vRvEIhDDuwe
	 GV6mYtndaMjaAD8jubJYn4jZn6J4r0ln68gA11wuAnv6UdtjdWS+nDPgeQ2qUJv54v
	 +OuJKfZveER6YcFnZU15pZ0ItDoeJibb7hKMSrwJ4eVcO+74hHBEwsRH8eijYt1bPZ
	 fdTz2NM90bNr8gR8TEApvxH5Eno7PVMt6ge4FK396vd8yRGp+Wvy5vjO9qRYI2a9RU
	 6Vy6OPptht0L//1mFR2OagQVb4ulMzswXuTZrmIn0MgWatriIpJgIISvFPR0MtHQIX
	 R0lkx4cYyl75A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2FB9EC41612; Mon, 30 Dec 2024 19:22:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219514] PC does not resume from suspend, bisect points to
 btusb/mediatek
Date: Mon, 30 Dec 2024 19:22:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bright.wing2924@fastmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219514-62941-L66FxJQGfX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219514-62941@https.bugzilla.kernel.org/>
References: <bug-219514-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219514

--- Comment #3 from Perroboc (bright.wing2924@fastmail.com) ---
Seems that #219290 is related.

Also discussed in Fedora boards:

https://discussion.fedoraproject.org/t/system-cannot-wake-up/134199
https://discussion.fedoraproject.org/t/kernel-6-11-3-200-fc40-unable-to-res=
ume-from-suspend-when-bluetooth-enabled/134008

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
