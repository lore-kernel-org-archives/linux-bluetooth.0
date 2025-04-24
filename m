Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987731891AA
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745525003; cv=none; b=fNKTEC2UBxX6I1cJuDKL9f/z2R2MXL2Qt6EzLc9nOTpQ7nSPT0FdeCmV7cxkdjs6kbsLypoxmjwvPvs7kP6fWUXEQhQUQYEoUYwQiWWzZRm1Nr91Duu5yKulbRHxRtEGWhbYIB2i9V4qB3aqz66OfZSep95y71DsPNLoxN2x0ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745525003; c=relaxed/simple;
	bh=WyBS+7xFCHv+gM1Vj+1iIDx1AYgOJA8woifn5m+SAAk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JnYZOfknuxNSRbioZcpOgDTAHIjj6jV5QmfeRVc6GAjm0+FdqJSSDxdDMYbtJN1AdRMhxS0th5PT59yBAK6geMVyURoblU668IxGrjAwCYPP1RLb9H9KLq0kYjUE7/tXSciNMy4geo3IEElw4bgoNy1OKG5Db+7yWKDwA3c5Hy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vK3h5cAT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vK3h5cAT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18285C4CEE4
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 20:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745525003;
	bh=WyBS+7xFCHv+gM1Vj+1iIDx1AYgOJA8woifn5m+SAAk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=vK3h5cATo3BnKLa66w469vaHo9MvfLZ4PXC3W+7ILhCoJb6a7zVe66+EfagIxI9VU
	 BofEkwr72F/xVxQraCBjeAUYibEE6b0WlO6Hjpe2OJBzfSL32Y9AzjKY+xtRnFXzO+
	 ySP6HI9/I/ZZHEHw3DWC7R0QoRnFVToJBEbpr6a/ASkonXI+T5eheG4ZpWf1sxbU4d
	 mniqpfDKmoCXm+KMgPcDQuC8CabBnENxM5poNo2PIgR47TBP3WEv6iIATDp3xyAaDN
	 pp6tcmG/XacrFD+gQ3f7n7bT/BFH/deo/H2UGiOr4pXxsqdi6dsTyxntargTu77bjI
	 VEBlkAp5mkjuw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0CAAEC41613; Thu, 24 Apr 2025 20:03:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219854] Bluetooth devices can't connect after toggling
 Bluetooth unless they are re-paired
Date: Thu, 24 Apr 2025 20:03:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: UNREPRODUCIBLE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219854-62941-Fuhnhhe2lW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219854-62941@https.bugzilla.kernel.org/>
References: <bug-219854-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219854

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #3 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Should it happen again, I think, the output of `sudo btmon` could be helpfu=
l.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
