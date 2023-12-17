Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944FA137B
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 Dec 2023 00:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPDXggLr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 164C3C433CB
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 Dec 2023 00:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702773061;
	bh=X+Blzxw7DQ26VIMEeTUNIsoqXYR1OGgZczz8DmaGvEA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nPDXggLrNTGJIElBh8ST9NjFSwZ2kXQK6s6N0QMYU/A1VEBsLbc8Urz9OQG92u1dv
	 wRion6AL4oxQJBqRSJR5UxLYXRFpJEwKQdJ0YrtcEVlLlnyeYlBBQST5q50nW6CuD/
	 9MhWef5Cy1MSduyG4Z977G0ySYwQcE+qcWe+UkzDArMNQQRjVyeiWju3Y9JIms88im
	 N2mFC4G0BF8u6cXYA+62lYaLVesaJxB9WJmKcRX2KzNK01fZx6AW+ep3/vQ3xcS+e5
	 kZVjJ40oel+RPjXmmT4mloMZSejJtyoF2VKkKSqSHqXJ+swRol5KL7eGKcYwqRu651
	 qzmznQ22RMCjQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F1CDBC53BCD; Sun, 17 Dec 2023 00:31:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 204589] Bluetooth touchpad (Apple Magic Trackpad) disconnects
 every few minutes
Date: Sun, 17 Dec 2023 00:31:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: heavy@ungoverned.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-204589-62941-TGCb3Oft5t@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204589-62941@https.bugzilla.kernel.org/>
References: <bug-204589-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D204589

--- Comment #19 from heavy@ungoverned.org ---
Unfortunately, I think the issue is still not resolved. The touchpad still
disconnects for me on a fully updated Fedora 39 with Gnome 45.2.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
