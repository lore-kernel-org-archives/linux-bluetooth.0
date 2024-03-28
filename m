Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FED13A1AB
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711630229; cv=none; b=mtJtxk0u26Kj1VjNKhhWvocfXCBhjSvZAz3SAJ/tIpDp0wGbKgTXlaMEtPUn2G+jG/LI9WrEibPbIUpHwosVJXRieoGajX8WAwp9nLF/tf05/Y4jkpZw0rnz0aoVAH3J+hw4eV0xnZ5UZHbuYoJl4kcJVJ2a3+ydodbJY9NsinQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711630229; c=relaxed/simple;
	bh=Iiseb/QqfKQdPP3ul6Enptt2XyilgxokowEySHQc51Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PwGoWaG42IatuRhtRtYkQqdP/7b7ZBC8kXVeyVaNbJ6LbAieT5AGYHXn8nk1/2SsgRQPAg3lN7lA/VO+PZKl0IR/vai1+YSIjWEelMHxGTEkaJuL0tNf+pjOvlqbl7jVj/Uhf881XJVuXftdQVeE7Qq+e63skMPK3ZqctAjP1S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgP6ICDX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgP6ICDX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22A9AC433F1
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 12:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711630229;
	bh=Iiseb/QqfKQdPP3ul6Enptt2XyilgxokowEySHQc51Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IgP6ICDXYtJRt3rBsE10NDTsa+4H4DbOcmk/Wh5JBlbRCoIWUHcIZffsBG9OgqDHD
	 CM4EhNhh7DvFPxq3uci9LBb+SMKa9jtjNo8WU/34YcfxRXlSVqx6PoYB8aYFnPN7AG
	 dyk/PYxk9vKyz1kN0qVEAr905TZpHWjdBGN9CSSiqbIO3XW3Pt8lfhuUf0TBWObI+i
	 qf+ZYhnZ7tZPmJSas+9AnjrUct0iVrFrmXmKTTEvmPntW4TJ5ivXQXtv9qiDE6bIxA
	 K8ApMGtWPYKs2EDMrLyQcdynD97EDm9+Zceiz4CNsd58Yr8klReUNULUma6qJTRsK9
	 8P0eo2xO8TbmQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1DA61C53BD0; Thu, 28 Mar 2024 12:50:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Thu, 28 Mar 2024 12:50:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: peter.weber@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218651-62941-c2cexodmKw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218651-62941@https.bugzilla.kernel.org/>
References: <bug-218651-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218651

--- Comment #8 from Peter Weber (peter.weber@mailbox.org) ---
I'm too slow :)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
