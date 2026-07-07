Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195DC1EB5CE
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783411635; cv=none; b=u0/4/yoYav9StUTzKfykWP5WO7hf0BkqfBZHcqmH2VKxvdYxpWnbx/bxpHuq2ZyEQKqwNaDP+pDJUZBXNyuW+uig9dJP36nGltU1R4+5rvRpUEEcZRr345YFGYh4Kr74XdUTeH1806F0ckaRgqZ9Ag81deu5lipv67cv+pRU1z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783411635; c=relaxed/simple;
	bh=jiRX/RUpyRWXzjZ0LqSpVB7cGOe+4v2QdBXWsN5JoM4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U7a4oQ+A1iFrnS3wyV4d8ETuL+W3T7ibBEOjk0MdlDmKsuWEvzShndQbBVDdVPDjyGtBNY7DUkLh1W/NEw4sCE0iXpAweOMIICgCWfdnlOyCSydQxEFWwKJ5sCGoFxROkELOttBYEgZ1a+55n0zLuXKbJZCpUIcbyrgJg+8MnGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7ztgH2f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7ztgH2f"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A826CC2BCF6
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 08:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783411634;
	bh=jiRX/RUpyRWXzjZ0LqSpVB7cGOe+4v2QdBXWsN5JoM4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=s7ztgH2fa2NsE8gRXwXBokrvU06Y4gideYlW6tob5w/zUIZE9p25ZlL60U6LM5K12
	 EHLpjFvOS10ZhoZ5jhFLgdtnDGlmi/vDZc7Nc6mCa/jspAxXhmlSvyqMOLdas/mFg4
	 6cznvqbTdAvMZBzDxMCq/TOowX6WGO/nsVRQPqOAYv/psY5jNdExiiaHIGfXLIO8Q8
	 pdlHi7L5sjSYJYDBsBWjqCqZRcijgnj5exadC5X2TrTPCZQyWqAGYd9t+50+9Uxyqi
	 tlnoAAQjJ6gSEAfCkuPk3/uWWIizT1ItrqRcGo1yFg/l6pR3g4ShzctpGp8eS2UH+G
	 eWZA43H+53+8Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8D4E5C41616; Tue,  7 Jul 2026 08:07:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221627] MT7925E - System locks up with flashing caps lock
Date: Tue, 07 Jul 2026 08:07:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: network-wireless
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla@hadess.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_network-wireless@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component assigned_to
Message-ID: <bug-221627-62941-3LFL0JkyIy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221627-62941@https.bugzilla.kernel.org/>
References: <bug-221627-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221627

Bastien Nocera (bugzilla@hadess.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|Bluetooth                   |network-wireless
           Assignee|linux-bluetooth@vger.kernel |drivers_network-wireless@ke
                   |.org                        |rnel-bugs.osdl.org

--- Comment #2 from Bastien Nocera (bugzilla@hadess.net) ---
(In reply to Thomas from comment #1)
> It's caused by switching between AP's with the same 6GHz wifi name.

Reassigning to network-wireless

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
