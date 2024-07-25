Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C0813D8A8
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 22:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721945343; cv=none; b=ZegFONjZwnOiS9kn5Y07bzkdzmfnEA93E8Q7uYPfH/SMPAdE0cTfLctQwhblztH/aOvLom5UX7pY/zKiUtxZz6ZEPeVaXp0eO/Cys6zshaMxAXmaQ4QTGPhleQCtOls7F9CEgAbHAs6U9zfepqOizShgHtQvsX4/FKkpyYnH7dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721945343; c=relaxed/simple;
	bh=2PQU67oBQq9pfAKnjT6BzUYl9CpeI3I1kwLhavLBnVQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GDWlhHvS7Qnp0PM2dbdxYQWtLLqaruqpPDsGbORkEPgEkt31ns0CJ3TjIACzdDMarI08tXvow2iD7OJmxYVT5YLS0oNMb403KiXLyuEdOGFdlon3/DsqPG/FZGIiD2Qzm0/0Z1S5Rw/FuV+QLom01utJ4qn1QcCmW075XHEVY8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fC2BihTh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fC2BihTh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A48A0C4AF07
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 22:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721945342;
	bh=2PQU67oBQq9pfAKnjT6BzUYl9CpeI3I1kwLhavLBnVQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fC2BihThCi/dfi3UwDdJ7wM2kbozhkOj0HshJ2R20MCgM8CqvPE1ttRAaDtzyCOKG
	 DrjKUsAhRr+tKr77ndr/MWAIqs6da8eh2Ugnsu9htxjnQSL9sKaJ7O+zv6XS3IswWU
	 rCjBBkDJ8boo1O0kos1xc9/OsFVoNK2fshVobqRJh1rvAWDLhjZlXMf+PqbE9BBTIq
	 eJpCJL69hW6COmkUInLeYH03eooMIopYnF7VaCIHDnMq9bYpiTRB5U0pxz9uHnlXYB
	 04o13eQgnIorh6iw3NhnxVUdzzDV+jNzP2i5KCKr3ic+XpjzR4qlgvoxbgh6hUZw5+
	 aEpx7JbQmyobg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 97BB5C53B7F; Thu, 25 Jul 2024 22:09:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219088] bluetooth scanning doesn't work in 6.10.0
Date: Thu, 25 Jul 2024 22:09:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: eugene.shalygin@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219088-62941-gAUBQqo2ul@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219088-62941@https.bugzilla.kernel.org/>
References: <bug-219088-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219088

--- Comment #16 from Eugene Shalygin (eugene.shalygin@gmail.com) ---
Seems like it's more complicated.=20

In attempt to get a clean btmon log, I reloaded the btusb module a few time=
s.
And it turns out if I issue the scan command right after reloading the modu=
le,
before moving my Bluetooth mouse, scan works. But if it gets busy with the
mouse, scanning can not even be stopped (Discovering: yes is still present
after multiple "scan off").

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
