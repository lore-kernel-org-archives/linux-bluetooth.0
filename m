Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E59215F5B
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729111471; cv=none; b=JViSs82TYj1tq8tZC5m1ouJdoDTf7QoEmtauAzPTKdl4uyynO2rifGK0NK0mGc+z/g9/mA8Of0jLlj6qfW69MNVYLhTFrJsOfSK40PqND8UR1HAJ0idJX3vuy/tEREbjXt/OEO14Ha+O5C+/RL9+jvBRwNNp0aidFFr6Y80gQZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729111471; c=relaxed/simple;
	bh=HnRiCHVpPX7vg7Z6FB5aHCucdSOGseF8OJkwcM3BCTU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ITbTBJQjU3+wMMWVonpZuFtYjtmzKqxuH8yZG6SBpfV3XKy4KlPM2xLOdfcYhTZ8R7r+8qYS8NnIyzxVDFY+ODmSrRu2nPtim/HEvkGGVCdAvEm+Z5NQ9OYnv0N+V8uRS/fZaSo60ivWoPhPmA1bMf1cGVbZAvvZjqwQfxqylvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufNU8Jl8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufNU8Jl8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 732A3C4CEC5
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 20:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729111471;
	bh=HnRiCHVpPX7vg7Z6FB5aHCucdSOGseF8OJkwcM3BCTU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ufNU8Jl8YHkZx351fKFtOslDfnMVQJIZQlTvRXK09t3YhCAZu+ibG5mAea0/vbhI4
	 /F4KE6xKH4ATh8Wc7rA+tfpbbcJGG5lXEDGLgljLDr/wM+EOgctXCRNnhPPQwnQjrT
	 Etfi/zP8UsRNTLlRFjSw7Fwpmywd8oDPmM37BdiAg9UEnOJ/1DB2k6y1u5PZzjsVpH
	 Xt7qctpdONgDxlYUq5UD6IvTfA9yiz/3hcUFQVenmWHdHOt4yLpSQMm4WT39GB/par
	 9ixr4Eo1Eao7GVuaLgjelea6Jv3tmWDMtpDVSa0LM8M5/VgySFLriQqQDYhfjA5wx5
	 EfwbgefOqS5sw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 60C29C53BBF; Wed, 16 Oct 2024 20:44:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219387] Bluetooth: hci0: Reading supported features failed
 (-16)
Date: Wed, 16 Oct 2024 20:44:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alexknoptech@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219387-62941-aTPyP9bvCl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219387-62941@https.bugzilla.kernel.org/>
References: <bug-219387-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219387

--- Comment #2 from alexknoptech@protonmail.com ---
It fails on kernel 6.11 as well. I am not sure when it first broke and whet=
her
it is a regression.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
