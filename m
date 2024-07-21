Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5134400
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jul 2024 22:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721599446; cv=none; b=CS68DwJqr/GxMicQyq6TcRrkwsOrXw5ABhGN4bmkxQ6VtXQpkE3U22y3bC25lOnVmczXpcynBqZ1s9Dyye+yhgA5gvCocMGXv+5jjUYXAKj880wP+jGVnCwCBgvRBlNJq6u48t516JpYaaaX2y+FZG7/5QqkuBGAj34qLmN8Mc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721599446; c=relaxed/simple;
	bh=KXls7B8PwE24L618/l+5UhDWTevNTFIqWpO6v4GSzsE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aue+K7uXXtw0GkWi56anm3f4WicJEPYmUVf7Wne4VefliHHiaOwN5CyaBdyr5rbYIS/saxzHdX8BxU49xjLXuN9QQ6S7dXNs9SfAXni/cS6d9IlGRl7epPp5stxDBO7nqKZV2CGYWCqehkYi+32TpyssqeopnXz3E8bNv0rI67k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ss71ooft; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ss71ooft"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FEC1C32782
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jul 2024 22:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721599445;
	bh=KXls7B8PwE24L618/l+5UhDWTevNTFIqWpO6v4GSzsE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ss71ooftqmU28AUvU4TnoHxgmmsP0A5bGtw8awlpQVg+/bi5HGQ6kParkkqkkc8TM
	 HdRi+s1Bja1/d9+gF3M+FpO0AixNdJcptzluKFDSHb9/v/Qa/XcyCkClnXQ2B7klRM
	 Qx9ewLRUYS3HqqoagiWMdmZ8cPb55Q/Xl6dEFSccCYphkHnsCfgq9tYdkIJgsqEgdf
	 9j6n9X3tgCGuQOKO+Qr6xggr1/jSoqNY1WovB3xkgyySgvci+MgKdwItrUvNmIdhkK
	 5fbQObADQX3le1FVD7EqYeyq/6daYyZxGHPc/i/GCupFej3Ietse6cHaXXRwddH6a8
	 rnUqZyzmM7Qww==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5845EC53BB8; Sun, 21 Jul 2024 22:04:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219057] dongle bluetooth does't work on linux mint
Date: Sun, 21 Jul 2024 22:04:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ricardo.andres.riquelmerios97@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219057-62941-Wbu9SmuRce@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219057-62941@https.bugzilla.kernel.org/>
References: <bug-219057-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219057

--- Comment #12 from ricardo (ricardo.andres.riquelmerios97@gmail.com) ---
so... the doungle it must be remplaced it? there's not another solution from
this?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
