Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41C316631C
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500138; cv=none; b=SygG0+n+3SnfGJ4Cr2JRE9CUUKQgLJ3g+P1HKDOQSUmDZUT863lrAiOPSOgvzT1JbZhSBlFjFpx/0l8ClFRMfnfnYp0TFMs76GqCU4ntMgA18p6wlDIyikETaN749vRE9elRpR+kUR0rz+xxovz3pFKbUgL79Sj7NoJ1vN4BLzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500138; c=relaxed/simple;
	bh=Fc+3yYtigCn+w018yLHgePIur/ecTQ+RYJeUda2lJ+A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u7zLxz/WkLhfPZwheMK30RfMmFfWxzLIQSypPSWA1mJ1JznaN8j3yJLEEz8NzI7PgiAYYKlj3OrIKntnQelg1Uwl96+l0SXBg3N/wng2UzWbydXHYAnNz/1LGfJ8or43XPGi1+7iFt3JPys2poJjjVKi0lQBAuIwO9CUgEbTY0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpasrHM2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpasrHM2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 807C6C4CEDD
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 16:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740500138;
	bh=Fc+3yYtigCn+w018yLHgePIur/ecTQ+RYJeUda2lJ+A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RpasrHM2UbxWBJEAmeQLc1N5vrOUbqGNMmS7S3VTslzrtSE/0IeBjfwbtfAzLf6kx
	 g/qZWEReKhMkwp/86p/kHnSZQLQsQuCga4itDxYmGD70msj+Q+MoJeBRVyt4C1mm0N
	 cC0wFXxBDdyv7WKua9o5xkdrQrBzasnrYZUlE/ugTsP+AgjitQSUuYuwrPrY9Oz2Rb
	 5BXeePywfhzO+jBgg2sfuStffFTHNRwoaiaTjJwjJw8iWk5gC4cl9sEmbic+oUexzf
	 jFLivCkSkv9aRfoAsN7hheL22jn58hShI3xuyS7QWTwYowmZjWV1HR4KmERJ+eciRw
	 ingeQR4ksQ8kA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6B27FC3279E; Tue, 25 Feb 2025 16:15:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219812] Bluetooth: hci0: Invalid LTK for MAC_ADDRESS
Date: Tue, 25 Feb 2025 16:15:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219812-62941-9Lmktpb612@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219812-62941@https.bugzilla.kernel.org/>
References: <bug-219812-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219812

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #1 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
This was introduced in:

commit 1e9683c9b6ca88cc9340cdca85edd6134c8cffe3 (tag: for-net-2024-08-30,
bluetooth/master)
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Tue Aug 27 15:01:34 2024 -0400

    Bluetooth: MGMT: Ignore keys being loaded with invalid type

    Due to 59b047bc98084f8af2c41483e4d68a5adf2fa7f7 there could be keys sto=
red
    with the wrong address type so this attempt to detect it and ignore them
    instead of just failing to load all keys.

    Cc: stable@vger.kernel.org
    Link: https://github.com/bluez/bluez/issues/875
    Fixes: 59b047bc9808 ("Bluetooth: MGMT/SMP: Fix address type when using =
SMP
over BREDR/LE")
    Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Most likely you got an older release without the following fix to userspace:

commit 7322ec38fb65afe8f34b9e363ed9fce37e1ff868
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Mon Nov 4 15:31:27 2024 -0500

    adapter: Fix up address type for all keys

    66a8c522b64 ("adapter: Fix up address type when loading keys") didn't
    fix all instances of wrong address type being loaded, so peripheral LTK
    and IRK were still left with possible invalid types.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
