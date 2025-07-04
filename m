Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE979274FE0
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Jul 2025 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751612814; cv=none; b=Noc98wCs0TFRZaXk+BtOrvTFIJhnyuGIdr1TcRR/ylNzo6I/waGfgRK4T7qceGc4uybfVuC7ggk/auNuA4v6c/rgBcXJCGJc0s14ECPI7DiridyoE+Zrrwlvh10wivF1s32tugjurJu42mRrhlTEpIhjqjDZ0RqglY2qZ2fwZLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751612814; c=relaxed/simple;
	bh=b5dz4XpnMTsLhXbvlsQYSDwWh2WDSzitElP+EMXhEU4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iEEWY5uMXsgclyRT7F54kMDyw5xsiNOjc1PyMT/DwjisRg5MkYboAmzHHIdGi8foKT/39ADxLEzyf6WzfL8UVdakUDjIASO8OL6LI5kRW+7k06qHHXsjfVa1hq0mkVj/MHjmUPlwgJCX64XvMWN0a5wKJP6QZStXO1t8iL9wU58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrmpOahH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrmpOahH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DA7FC4CEE3
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Jul 2025 07:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751612813;
	bh=b5dz4XpnMTsLhXbvlsQYSDwWh2WDSzitElP+EMXhEU4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TrmpOahH5kNyQnJ0cctYYm7kDUSY/30lMjL6SR6B02CAX/rCBXeUkc0JeRxPW6b3v
	 br15+roWWmBD7pNjhlaZESZFJImrYV7/PZyhi0RAfo3hkwVoyQ6I98piVWm0QaGdE0
	 2JsVbWLYebBzutmOyyL05ZLgVD7PjccMw+w7Wlr/6Gt6tw/B+y5+Ylx2SA3a4sly3P
	 9RS4+P/zgPfH5KeR2J6iO/IiqOu23FnnTuhjOHKVcXH6TzdcFyF6NGA9cTunjURT0o
	 syDsejwXOfyJxlHFFrNXOzSIKY3KGcN/TiutTWBYZ1fMPDhiB5/PKOdKAvZNh9OOKP
	 XYNJM2b7ubxxQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 64823C3279F; Fri,  4 Jul 2025 07:06:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220306] Updated ibt-18-16-1.sfi is bugged, "Invalid exception
 type 03" kernel spam
Date: Fri, 04 Jul 2025 07:06:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220306-62941-cCWhXyKEUl@https.bugzilla.kernel.org/>
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

--- Comment #4 from Artem S. Tashkinov (aros@gmx.com) ---
Kiran, could you take a look please?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
