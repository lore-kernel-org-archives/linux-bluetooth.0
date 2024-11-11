Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40B119F118
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731336976; cv=none; b=SCGqVKBm8avsvAJE0qNVDU/12rtZ4CjMloIrA5VQsrgxP7U8bGyZUBXUQcS/q/0QvOQCFQyL2hlPdBnnwQVKS4SyBwQkOGdfBa4nl0Xz9egBL9WabnDVi1ZyAT6i7wQZBsIXB6Zc73GbjAiLD3d60uNIdv1ECw0e/ALkuxCZkEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731336976; c=relaxed/simple;
	bh=UB5/MVzJVoJpJFSJLh2xiWx/RLYHBdLGVcus6lMFt3Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ioxbdRBeS+T8oxP8gSxXaBzOoq/9763eqpVG0C8h3WVuhFc5jdo0FlYWHQgwDiN4wl0Bw7Ip2EPjr5gZk0KNLce6hnwlZUEqwgibXvkxtGir9ms0SScSq71I1bNxSMV56oC6sivZJf/NMEEZfi9Ms6R2Lrj77NN3ZKyVVAWtsxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeApmvPD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeApmvPD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A4AEC4CED6
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 14:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731336976;
	bh=UB5/MVzJVoJpJFSJLh2xiWx/RLYHBdLGVcus6lMFt3Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jeApmvPDpwEs2mmEabCFmN+Zvz5s8Duzbagrx4gHn+hJiU02bwTZ5XQc7wHICYpiM
	 9ZxJ/yrCmc1bYmggnqmXfiDksZaRMQJMv2SUzl4rg9XJqdioDmF3oKVCYMcaWcpcP6
	 m/N6t0iDs0hdjIFwRGe2CE2pZ8uSKwJz/8mEGPjj9td0eRku80BhsC01jwxZpHWEsh
	 QiebgsfaTw2rNgDk0RDK4HycVuAsC4JIix40PXwSALaBOTQ188dx+QfeaNVROQ5hxH
	 6jCBiMZ2GvS26rl+BbuLHVYTU+7iGM720np/ijRn6JXjGyKwVCjnYO8668S+kDS8zg
	 O+mUWRu3kfKyQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1782ACAB781; Mon, 11 Nov 2024 14:56:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219458] bluetooth connection fails after L2CAP: Fix uaf in
 l2cap_connect patch
Date: Mon, 11 Nov 2024 14:56:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219458-62941-8oJY4qIDha@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219458-62941@https.bugzilla.kernel.org/>
References: <bug-219458-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219458

--- Comment #6 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to Giuseppe Ghib=C3=B2 from comment #4)
> btmon output added. As you can see in the working case the behaviour
> diverges from packet #16 (in the first case, working) and after packet #94
> in the "not working" case, both calls ACL Data RX with L2CAP: Information
> Request:, but in the working case it's followed by HCI Event: Read Remote=
...
> and other commands, while in the not working case it's immediately follow=
ed
> by "MGMT Event: Device Connected", like if something was truncated.
>=20
> [working]
> > ACL Data RX: Handle 256 flags 0x02 dlen 10              #16 [hci0]
> 413.700565
>       L2CAP: Information Request (0x0a) ident 1 len 2
>         Type: Extended features supported (0x0002)
> > HCI Event: Read Remote Extended Featu.. (0x23) plen 13  #17 [hci0]
> 413.700588
>=20
>=20
> [not working]
> > ACL Data RX: Handle 256 flags 0x02 dlen 10               #94 [hci0]
> 20.205711
>       L2CAP: Information Request (0x0a) ident 7 len 2
>         Type: Extended features supported (0x0002)
> @ MGMT Event: Device Connected (0x000b) plen 13       {0x0001} [hci0]
> 20.205764
>         BR/EDR Address: AA:BB:CC:DD:EE:FF (Company)

Any chance to check with the patch above?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
