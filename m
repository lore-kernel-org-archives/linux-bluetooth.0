Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792558275;
	b=QyroiNDs6Ha/3sGVcx7AtOcykmtZNwh6/BDr83joZoIZ4+32fuoJ0KIdJBb6l02PgILW
	 4dt5CeoeIbX0kJRlPBbpnzoo49ZPadrbfOLc9/RH16aQ31hMrWIjU1U7g+EyJ97GRVA0D
	 bnucd3TuM0enrsYv1b8UXACCUou+9CfEsVkfs/YQyMOGy5HuSvUAxN/WTGmfRBaDCHgZq
	 6+Cd3qeg86KCoaPAu6cPDhx0+CGEyRoZYRjwioIBO/VSHycmrmnLdxxrVSC/VjmiHTJ2r
	 F+SIH0Kw5AG6hNPdBvlwKt5708WMYl0pFr6gHtN6+e/6+BJcW6EBCAXF/HitJBlHgiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792558275;
	h=Received:Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=ANAqsfLx39ab7ssdaaHtF1xenja3wxo6VXL5fM4Lfs8=;
	b=N7KnYo+XEHTTiqguE2pfHmYZQGWKSL7HyQatRdhdR9MSQUzlHXoVkjUImb3ib4aGNw/n
	 f5qbZVmhKePg4rE0mIelH+s/0uTBmRZTnOsXYYcm7lz86jLTBywoy98bSDnBVIhZLSeMx
	 aCh6C94rbIh7aZOfNwQVHShBuViHc9mw0+IpTp9QTdhJvLuaWIWrvBac2I7NLU6I+njhw
	 5qNeGXxQ2cqbBOUhG0tmtPdn0MsD1osnckusRzReIOJAErsgpFmFlk5UGioGfrXjgFDoV
	 91JnqaEa1DfYT6OITKGgZxAgcarY7tGlRR9O/5hZ1bTZFHmbVpYGNn1K/evIX/nWKYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b="LdHjbK/l";
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D5B606A319
	for <linux-bluetooth.vger.kernel.org@localhost.mlmmj>; Wed, 21 Oct 2026 04:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LdHjbK/l
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4F625771
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 04:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792558275; cv=none; b=XyYRe27tIpMPemb+8ZyUpAV20ERhdPNnDCAi6gOlwDCq0kVKkSXp4yd7kDnFDiNd0iBi3InIbykIG3zG0UYlbT+KawMqZKRpgUPTKEXQv+dkAXBbiE3tWhmQbkWzlH4pAwB+K/uFg7u+Xee3K/n1m87eY5fxDOSnWQqGXn3CtSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792558275; c=relaxed/simple;
	bh=Y4wc3e28hZ0CRb6jOB7Px0nykyanXw6gK5HBpTnNqS0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kavR1JFJ3NCYMEchZUG0Zg7+8TiENm3csSsimk21x42BQRedSrXB/4WfrIR3JM7nfUXQs6/Bx1KwbP/25rLeng2v+xORC1hLood7eOOsOWCF1X4abrpYB+BP8zDQKUNuSnVA9ocz1AgwKjAbuQihSgzwyKdxClmxnjbqeF+k3zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdHjbK/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B34EC2BCF7
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 04:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792558275;
	bh=Y4wc3e28hZ0CRb6jOB7Px0nykyanXw6gK5HBpTnNqS0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LdHjbK/lcKL99mRJhYTEfLVWsldsk6NIswZ1KE0fpeYIOTUzUeEYsihb28wl++a55
	 1SD96HlHPICCVqNlAjKJ3BNYTH/1MVmDo5m3Gxr+eyxixYK7Z5zhYkRXpzPO/M/954
	 mu5cR74se6z2CVjmyksGAOSdAE/7mxRrSE7blqiDWQwCHmBR/GyIAtMrCd8yb2+HAz
	 F0wHT2FQoE/aC797WFMPXwJRDq235Nrf5j4hKaDiLioHcCn8IojxZonQCNDo1Fvfzp
	 Yujc7J7kecDcxJr+/j7zmp0Aizxt7G9Z7HrNUqFn746MpaC7Brc3LcDfy1V9KftMKk
	 FIJwZ61DuQymg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 48D09C41616; Wed, 21 Oct 2026 04:51:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222164] MT7902 Bluetooth: firmware coredump after ~10h uptime,
 then &quot;subsys reset fail&quot; and permanent USB disconnect
Date: Wed, 21 Oct 2026 04:51:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hongweifei@cyue.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-222164-62941-E7FQkRJ4Nn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222164-62941@https.bugzilla.kernel.org/>
References: <bug-222164-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D222164

--- Comment #5 from hongweifei@cyue.net ---
Created attachment 311215
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D311215&action=3Dedit
Crash #3 btmon excerpt: first 40 lines of the Vendor Diagnostic flood, midd=
le
sample, last 300 lines through close/delete index

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
