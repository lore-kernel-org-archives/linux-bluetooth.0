Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793189549;
	b=w2XfMk45Ahs4O9tiE7bdGxT4WS1GlGWGq6DJyqJ7ol+9QeI04OXEiX357VhkIESWcdhb
	 MVtCd8nLA+QAfcFkA+8h4iYhLVNn/pJX/rx8N1GfYtUKGmtSkJ8QFkTMmPAp7oOZJgDmS
	 V83gwCeiPn8FnyrTI112/CKmVpIakS5AEMKELK5t5AWegnffOaPuMxzUT+Zg/2BE1z6Uj
	 MaqQFxtn+xp2eyR6Rrff8v+rpBXNVKYibE1YIe5vlr7RY6d7wBAHrkSN/BEkocoHExXH/
	 MaZvF1Y5s3nV1RRSLgPbsv7k7XIuAYMxbUK1X/jgJEnqg7cxj45UvCthRdeob2eVwBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793189549;
	h=Received:Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=REn663Qow1FxvLbXyCGd094Qm0SkARbMTH8Tz7Wxc2c=;
	b=lZtFk8q2OWSxepeIVnLVqS8yVh2u6UZ87mN76SzNHb9GkXHJ+EJl3SHsU92XiBRGDVDo
	 PQ7w6e3iQPMV84Ng/99nZnEOLRMSO+XBv4QdckZdoHXWr9qjHtbRwFkDHJQXPPEAZrvuu
	 p1bsgNmlpSi+1CF6w4+JgfhbS7zL1Kzn/u1cI4KIFdgAjequp7uSgECCNVw9t3u/H4sTf
	 IY5gOJ7VW7fmyf7t1ojmgGQmUCzQ4MkeD8BvTrD+Ap5PvXB59WV9qK6hpV19+yxrXiKSL
	 NmV9nVUlYCSWghtCf10fVLKn/yw9dYIkOtMETnTUMMbaGNhOAsH+yKI7OV9Z30uGOaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ed1c9U6e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CBC606A31C
	for <linux-bluetooth.vger.kernel.org@localhost.mlmmj>; Wed, 28 Oct 2026 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ed1c9U6e
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BEA6513C0
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1793189549; cv=none; b=Rhcjkj/vC9U+ldyhc7+Wif7qC4MXVxgyObbWnzOn/OzpTZ9Mjw/xWl7JnR6VGgTq/yKxn3ZCfNaEx1w+0G6xHNoKtL8rU0b5aWPrXHja2E+91uqpYeeKVDxurtC6pbtt7FexyAY/TiGl303MnosUo3CnRzH3xDtrtN3AZru1WUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1793189549; c=relaxed/simple;
	bh=YXmmPAHTBL8ofwAkngFYtbxF7st95v5C3k9MWXVzT2c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GTC6xS6DiJn6xyuN9z9tJN8MlANqR6+kga4JDz/koO0gKWNGst9UZ9lXafYrJzKu5hA03w9qXRAWBuUbgYL/w0sP79PEnD4e/anzA/lKea37ipHUfuzTpQrwGVMFLpxSmlECGkdYXUUhvYiXZ45JkIV55vAXz11d9zdtKDZXmw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ed1c9U6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEE99C2BCFA
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 12:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1793189549;
	bh=YXmmPAHTBL8ofwAkngFYtbxF7st95v5C3k9MWXVzT2c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ed1c9U6eOSz7zuUfibbBuGghc8lnwJiRFEL+Lb5b82VxrHhwEDTDPLSLAHsgAL7W2
	 aarLLya3CI+/ipAYDwTmpxGN7qOgLpMFsmQaJWnl+psN6mYyrZsFMuAMDXTbv1tsQI
	 PUX70Od3a/cRxw2+K0UsZXjniY7JkjVoEkRM83HX1Ut/4Gv/NwoewyH1Tm9Ej1lK/G
	 8YaOyq66YnHF/gHlK1fLyTcxwJVcrMhFmG2K9YEHoG0hsWggy4aEiSEW2AwcHNiKhS
	 r9CQdqkh2nFf0YfpCeFIs3vJncX/lEW11sI1EBoZHcf0Vk9QHsKplBmxMyKDTi5XvA
	 hfiJBybRplBfQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DABC6C41612; Wed, 28 Oct 2026 12:12:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222151] MT7925 (0489:e111): BT firmware 20260813113236
 (linux-firmware 50e034a2) intermittently fails WMT init, possibly drops HFP
 calls; 20260605184935 does not
Date: Wed, 28 Oct 2026 12:12:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: purpleritza@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-222151-62941-8cz2sdx0tr@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222151-62941@https.bugzilla.kernel.org/>
References: <bug-222151-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D222151

purpleritza@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|MT7925 (0489:e111): BT      |MT7925 (0489:e111): BT
                   |firmware 20260813113236     |firmware 20260813113236
                   |(linux-firmware 50e034a2)   |(linux-firmware 50e034a2)
                   |breaks HFP calls and fails  |intermittently fails WMT
                   |WMT init; 20260605184935    |init, possibly drops HFP
                   |works                       |calls; 20260605184935 does
                   |                            |not

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
