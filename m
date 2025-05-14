Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C401CFBC
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 04:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747197383; cv=none; b=po6zLqvBYNcu1+Nb+w5IWmG+bZkSR2FC6ImMlpkZazgjlJHD6+anZbyUO1qEt+sbxEZSD5WD3+FiXnQErA7Z834sHr+kVouOWeZME7Uesb5CSOGMCSub4C7ZGyNR1cpmKd1CRwLY7OKpNBAJl6tKW6Y5aVmJ5rQl5sYFDVjvBqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747197383; c=relaxed/simple;
	bh=1fA9/MiVIK8okX9zDLeYUG/wllQ/CwpkjT9dDJjqv1w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jDndvHNwGbgdQPhJNv3jknkCG9UYfZakLjVcM/uWTf4uc3dNqgFgBC3SfPGx/aDKOSxDk+Q8Rc2l893kAJEZYxYSRsxN6zKGcfWOqWpR6h8va9LgocaAgFLo31gx74+oF0axUykrRYymeh/ocrAPeB/KxbFpH88povfkAg4hQlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0pX+Mr5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0pX+Mr5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3544C4CEED
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 04:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747197382;
	bh=1fA9/MiVIK8okX9zDLeYUG/wllQ/CwpkjT9dDJjqv1w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=L0pX+Mr5LfN/BucP6Xa9LVXzZTTiqytN3FfGTuAc40AJPbg6xjmhe0Oo1F2uFUmS5
	 79U4754MLxI0HMUxE6t9KFTjPkNuF2426a/6+j5GI3SIVtTpBBXKI65qcNqgZ83EYo
	 C8qKVVONnGkITrVy/6tJ6JtnEcWrRfruusN/29MgIxAE4pHY+AbNcmXLr2wHAuuoKu
	 qCkD6Bfc4JLsCXNLOXf4zIaMPQazXwg13LwEZP38wFJhbB3jiStYzCr9Dnv5Me33ow
	 P+C4zMkwqy8ESaYRFP/zQnbeSwwvxTY1TedA3LcNaP6CICDU7ic4G3+sP1mkpu9BR3
	 cWbr5Tkw3licA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C1D6BC4160E; Wed, 14 May 2025 04:36:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220123] Bluetooth
Date: Wed, 14 May 2025 04:36:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: quydd.puto@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc attachments.created
Message-ID: <bug-220123-62941-DN7LAs3lUr@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220123-62941@https.bugzilla.kernel.org/>
References: <bug-220123-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220123

Quy (quydd.puto@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |quydd.puto@gmail.com

--- Comment #1 from Quy (quydd.puto@gmail.com) ---
Created attachment 308127
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308127&action=3Dedit
OK

123

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
