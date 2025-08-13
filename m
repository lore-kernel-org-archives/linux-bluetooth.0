Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1902EE5E8
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 08:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073002; cv=none; b=ilYFU2nkLXWeg38RdgG6fvSs7LpRQGcOO0grVc1WpkZTZbqaYxj9iXj5x1U4YbdchP6vL00Wjt3Pl8QS+ac2xsuWTftZJCV6NtgBqGh5Vx7MKByJ4KvHo3u2lV1q1z9ujahvvOUgfqmhUWHHBXnTizYrqSLbQkql0qvjTcRwNmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073002; c=relaxed/simple;
	bh=y3Q9TxFdbDQeWxPwuHg+NYgY0j8kV+2/nHPbahTzU9c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bYsSbGEWw8WoyYit1k3pg4JaDNRtkgEdLFlbz/5yTQuoGz8zffmhSPjpnjXfrHaSIOpM2mfgXhJZ+a3XXggook5pZ27L5d77ehnBGWAct1VLDqyAHY4/6eghVaWMCvLUWK5r7UUDCsUglCMZe0gHoj49A2IyF85Hr8BSEdgHVJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPD877cC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPD877cC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30516C4CEF1
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 08:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755073002;
	bh=y3Q9TxFdbDQeWxPwuHg+NYgY0j8kV+2/nHPbahTzU9c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CPD877cChPWdd/NaAa62E4XOTOJqsWWQk6z6x7EMuZ5mbzYSsiyw/OrWKPkUz0bB5
	 RPDg0DGK/zbyaF7z3qHpv35p7VqER50a53TPYRyUrE9rd/2y9GzNkn+AOQUoWeH283
	 hnZ+wxsL/8apotp/IkS2jak4XXrQDfzejXcm1hBtSIOQj96ADc5hw7Ns/Lam+dxV2T
	 QZe7xxbcQnwlw83MMzad86qIR0DjK8UK8m0hRFRCk2tf615aZcxRYcjBxM2fB6GCC4
	 pEPc2OIXFEo0HpzzdYBJsYUjm/XdCtd3+urPHQt5tjGzI/dqc6RpQNJd8fULF9YPZe
	 QFoE3YeloHkRQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1EBACC53BC7; Wed, 13 Aug 2025 08:16:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220344] Intel AX211 bluetooth randomly disconnects and
 reconnects, started after kernel update
Date: Wed, 13 Aug 2025 08:16:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: juergh@proton.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220344-62941-XB4gC03Nx3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220344-62941@https.bugzilla.kernel.org/>
References: <bug-220344-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220344

Juerg Haefliger (juergh@proton.me) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |juergh@proton.me

--- Comment #7 from Juerg Haefliger (juergh@proton.me) ---
This looks like:
https://bugs.launchpad.net/bugs/2049676

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
