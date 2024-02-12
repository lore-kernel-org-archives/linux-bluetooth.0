Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6722218B15
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733461; cv=none; b=rzQbhf7GiXd1WP1ETC9604hp+EOyPbFgCxSIxMHsNRrtAeZhrMM7zYtef83gdqMDhx3GClgeQOd1DLt1rovkXHQRvwxliSekcsJMaw67UHdF8/6Ls8ldjC0tpbna/Ug1/2LbGdYzCyTW/l+V+GGfGcD0qRwEzyCoPtDN8V0w440=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733461; c=relaxed/simple;
	bh=EKytqG/xuPpla9ejhGDyy9KAWX84QMLKHE1S2DUZPRA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cv/GAaLHN2SLbnuISpTGxM84Wt4nBds99VY78cwYHwHqswIzAB0hXc5BWgpAxh5wRxVa6tMed9GV2bZ//AF5yRE7d44TIEp8Jo66xdwfRRNkYMoL7YHOqERj1XdPRgkGcMjl7zcl5nHkEgwZEGNHY5qkM1TXicwcnDQ+3LKrDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmI8f8qW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmI8f8qW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4E2AC43390
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 10:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707733460;
	bh=EKytqG/xuPpla9ejhGDyy9KAWX84QMLKHE1S2DUZPRA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BmI8f8qWGmKREpM36FVG2HpnWwJsLMnD0s+y9/rhd4WAi28d4rCxhETRuWeK1bt6s
	 +JPjM/O8oR+ohxnamTJRcJju2fDo2zOR205DUuYSVPElER4CaTcrK7Uge39rzJ8BnW
	 i0S4t5OHVuVSnNP1JGZFlvEWGYQacINqEXPT+8FGSAB0J//NS+zgPZCw9R5hTLbgDO
	 n5CtZwSPzpE5ZJVGsCzdgsDNWypBLC6J85tZUKTxa+R2siJe+NQiJmJuLwyZRnmy1J
	 Q/sOrAmbntrQyehqNYuCvAakfUDY9qp5DMVWq5Gayld+YRp0CSPqxwejq0+vtoener
	 Z6ATzoU8xSCaw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BF757C53BCD; Mon, 12 Feb 2024 10:24:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218468] Unable to transfer file via Bluetooth from mobile phone
 to Linux system
Date: Mon, 12 Feb 2024 10:24:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218468-62941-rCxlIYdS34@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218468-62941@https.bugzilla.kernel.org/>
References: <bug-218468-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218468

--- Comment #1 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Created attachment 305857
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305857&action=3Dedit
Output of `btmon` with Xiami Redmi 9A

This also happens with the Android phone Xiamo Redmin 9A.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
