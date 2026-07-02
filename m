Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87DE4DB566
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001916; cv=none; b=K25NiNwswzFOiODM0pMIqgB13UQQMpU7xXrh6kysz5W/+Z87nQB1J3iZ9/lRJeKCkkFl/Q9ZGv1jKuwXyv8lQR/gtfQFlcXHZVH5RzPA3ErYpbnUpJ1oh84zl8kNbGzyD5kX/jL0rN199aNq5C397yU/PQo7Lyn3Fs7zzEFHwrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001916; c=relaxed/simple;
	bh=mT5SCpeEAHXkyS4AnLfK1nvRJqnS0rTW93vHIQ8Usuc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WWkCBxrYHk4CFR+Kv+6hSU9I5EYwlAN6IMxhKOkwNAVwPSKTIYVE8T4UfWZkoWEY3uTM2Js4Ttd9cLpswYGTI8l/25BnE8x7UOQX7NADpM/+TuS+3O88jzeB5ekHRO8OA9FBWEnA6d9cgs7c0k/YXhcDrEjc9rb9npIeSZvJJ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXziG3ky; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXziG3ky"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08B9DC2BCC6
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 14:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783001916;
	bh=mT5SCpeEAHXkyS4AnLfK1nvRJqnS0rTW93vHIQ8Usuc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OXziG3kyo7A71OpPFTTaFrhZUqA8ROdOLjGpDVJitNYH5q6Al+moaomU0ZTwlJRd5
	 4Nuu+nlNZjEBDQ5yOooV9DPNQFpRZugIPQxVI8LIsf74/QU+IbclZEsk0h258YJXPM
	 5HKm1hBFgROxhJQ4L3dlFm6ypJ0HqZRsoWc43Ui7flBlOAZYmu/BtAo64BkM+QmJJS
	 PLXCmyKbNydQOHUZknxs0xIdMcu1hgADdi7aGEP6TttQ5C8fFgPxmHBbanHJZuOdaZ
	 mg6mZQGdz9Xpl/n89HAQMpv8Mwud995D2OjoIir6U2gqkBeMdH4Cf+kSlk+ALBg8Az
	 Z7LK+yxOgVHUw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E4021C41612; Thu,  2 Jul 2026 14:18:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221696] btmtk: regression in 6.6.142: NULL pointer dereference
 in btmtk_usb_hci_wmt_sync during resume from S4
Date: Thu, 02 Jul 2026 14:18:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernel@mattwhitlock.name
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221696-62941-JuxwMZrX0o@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221696-62941@https.bugzilla.kernel.org/>
References: <bug-221696-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221696

--- Comment #8 from Matt Whitlock (kernel@mattwhitlock.name) ---
I've figured out where the bisection went wrong. It isn't sufficient to tell
Git that a commit that exhibits the bug is "old" and one that doesn't is "n=
ew"
because git-bisect actually wants to test some commits that do not have the
bug-introducing commit as an ancestor.

So, at each step of the bisection, I have to manually check that the
bug-introducing commit (d019930b0049fc2648a6b279893d8ad330596e81) is actual=
ly
an ancestor of the current bisection step, and if it isn't, then the current
step is definitionally "old":

$ git merge-base --is-ancestor \
      d019930b0049fc2648a6b279893d8ad330596e81 BISECT_HEAD ||
  git bisect old

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
