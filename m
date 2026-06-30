Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411C33C2B92
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782848325; cv=none; b=lt1yi7mLiK9iHmENTSiYvudTizwUlG1CHkQdnfqTs4OzaZ0u1cxbkVFg+o0cIVayu+NiMHXaVhU5aTnxbUPTPAkURcqVBZylKmqFhmIwMT0R/z0lpLcswwJ6y7GCi3HbPW+vKm3t+2cp5RGySTaHZYLr4qy1OCdPaL+vbEnJ0iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782848325; c=relaxed/simple;
	bh=NFTw9+ohZ7htCwbuU+gm+FczL8eEPpKeNpLtCBchByM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G0LO5pqdTTXnN1MKO6IHTCVrp1hbrMXcjfcxoQtPfw0Ti6E1xp/b+Hu8yfhMlVnUoXmG9qprBSCZi5P+NcMY9nC5yWCp4jy3Yvzhzsg6FNvDeoRqnsqjKZ/9Opt60fHbfMTyIgY8miAkqYfPK7+TogXp5UqXCR2mezioMnE+O88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGQmQRLp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGQmQRLp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D98D9C2BCC6
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 19:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782848324;
	bh=NFTw9+ohZ7htCwbuU+gm+FczL8eEPpKeNpLtCBchByM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nGQmQRLpwJZZ7CIYNFw0I/HWD2ZVzGedVw3jtMiI2ZDBo26YqQ6cafpWyPJBxx7qE
	 3V9NAVRsmWl16r47zObQ/TuymnOhuzZyYRUOO+6OOuyKlahH6VKbfimJoFwxw4nbk7
	 Jx6PMIMdvwh9puEXz9xqw8/XH/RZZsg+E55ZUcQ6pdJv5gvtIl6OiLMEZnZLgYbLch
	 AWVkNsr6uf76rcTn8w1w79y7CUed4mLPFUr66UAJoQKRS5nRkstNlE+BOv/0zAYksg
	 6DimLgKN572grjNCYY+B3MocYDH1ir0SRK1MeFfkVhdRZ/uYKrkn0CCeDKF1B5Pg/i
	 ils9orBYDnGsQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C7F0FC4160E; Tue, 30 Jun 2026 19:38:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMjE3MDddIGJ0dXNiL2J0bXRrOiBNVDc5MjEgQlQgYXVk?=
 =?UTF-8?B?aW8gZmFpbHMgYWZ0ZXIgc3VzcGVuZC9yZXN1bWUg4oCUIHN0YWxlIEFDTCBj?=
 =?UTF-8?B?b25uZWN0aW9uIGhhbmRsZSByZXF1aXJlcyBtb2R1bGUgcmVsb2FkIHRvIGNs?=
 =?UTF-8?B?ZWFy?=
Date: Tue, 30 Jun 2026 19:38:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sandeepmahendrakar11@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc cf_kernel_version
Message-ID: <bug-221707-62941-OqCz4JKlAi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221707-62941@https.bugzilla.kernel.org/>
References: <bug-221707-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221707

sandeep mahendrakar (sandeepmahendrakar11@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |sandeepmahendrakar11@gmail.
                   |                            |com
     Kernel Version|                            |7.0.13-200.fc44.x86_64

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
