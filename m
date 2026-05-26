Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E833CCFA9
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779782030; cv=none; b=UbN2UehUhfycC8tfC/64KFnCe5oFp7fL8Dcd0Q2n9EzVVynrUmPymyqpZ2BHOgVji1f6JBU3gKFm41pURamoz9ADR5tARw12FkjxC0Autcr3lOZ7G0saOMnP/jP9H5FpE++xE+Hp+rc8FIP7cVBil55+zOX+yRhHSBqmiv7vrAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779782030; c=relaxed/simple;
	bh=02KWLKSjnjaZY/yRW2s4T5+Bd7Sk2a5sdoVYCOmrqvk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jck1/yeHHC/sWz3DaK6fMz/fLgT+lhRez11iTwI95DPyGssCFyKj/CmuLTT6oFIDp99glJaJgl4h3ylPuN9mGp7docQHu+uhzet87Zt58j/6b60uwenyIbUNiWvIPBoRYTh9KsotieJDcjw4MZ/X/m7MZa5h7coVghRS04ZWGRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UT+nItI6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UT+nItI6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B02FC2BCC7
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 07:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779782030;
	bh=02KWLKSjnjaZY/yRW2s4T5+Bd7Sk2a5sdoVYCOmrqvk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UT+nItI6/9A2Fusi0tPnWZTm9JRFtlRM55Ovg9z/nK6ljMpJO6GR+i/d2UCrZqDn4
	 9vl1dcehAavJfttdPPKbKw4bmFIMJG+RUFdjcepaDr6YcqWFaLrdn7adt+jFGMTr/2
	 iPjmSNgeyLlHRCOXw1b9/I6buSKH5qbgv0WC7nLTvSGDjptmGgQ99zlL8kV5lgri6D
	 PSoB8hVFORPYhVypopdk5RKofQBpv9NCmMYxIix9MchgOPchOUBDDgAOQydd4HCHz/
	 c7yYWK3/PdhWaCaU6Oa3xPSAKpaHHsdKhmMxzS4dyVy6KfGsC9syn6tArDeVA1rECi
	 zMeCkGZSXJ2kA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 12E3EC3279F; Tue, 26 May 2026 07:53:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
 (-22) on MediaTek MT7921 combo adapter
Date: Tue, 26 May 2026 07:53:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221521-62941-UiX617uG4V@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221521-62941@https.bugzilla.kernel.org/>
References: <bug-221521-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221521

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |sergey@batalov.email

--- Comment #14 from Artem S. Tashkinov (aros@gmx.com) ---
*** Bug 221576 has been marked as a duplicate of this bug. ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
