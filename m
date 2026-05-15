Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA47392C32
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778851620; cv=none; b=m6yf8HG+zkEZmCPFEICx51D7AALOy9kFE0Y64pcspkNz4mgpoFm1+raDwRqyTil0geMUYOWNzOhcFm1UGsOrToaETTAAPG5HvKVplWurRAisBPu6G2BoUGpy5TwxrxLrEVoV4BvuaDhRvOZxZyJNYlzezf5q/6yIFT2skgtvghA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778851620; c=relaxed/simple;
	bh=sFcVwTKwKgWCsXp85NA+DLfoj8hps0wJM5kqUIsO40I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a1or9FbvlIJzKjAJDwGAM562mrL8jTUTb5tc9EAQJ4LTgmOC60pzIB7QqrmgK2hiNKFTNIq9CQHyto0h3V5LL8dsZ4Ah6uA2t2TpEL3XzOlOYr/dWY4g9t7BwcIqLhlVUF4GVRdDcCKCI0BEY2SHtQXxc4fN+DhGemIuO+6o+uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPxAuHj6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPxAuHj6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9DD6C2BCC7
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 13:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778851620;
	bh=sFcVwTKwKgWCsXp85NA+DLfoj8hps0wJM5kqUIsO40I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sPxAuHj6j7FLU6alZaoJJkKWqtUv4Y2iP6qbibAJiD9mMzdRaYx0OrmaglwZKd2zu
	 xL/CZhUjDeTglQnJ+7J+8ClaYZyIiVbvO/tZEsd9uBQJbcsVG+MUvMMTyFLmeSC6WT
	 dH+MNe/3bmYuTj3ADY4rgBkso6pKpn5NgFkNm4ZGBise7CxnPDhB6ExADFINWBdiLR
	 ZL1t3JmUe6/7N36WiEjCUnbmuVKzIMZ+9tcQBNw02DedmD1xD+hWvmmjBaB+IzQUP5
	 amZC/VQC/ksVRXn18LkQwf6wchHtQIwl67FTopFbsofHkZtnSdir/biMWrGtwWZren
	 MOeJE244zoMTg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E2A67C41613; Fri, 15 May 2026 13:26:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221524] Intel 8265 Bluetooth regression (BLE hearing aid
 unusable) in kernel 6.12 vs 6.1
Date: Fri, 15 May 2026 13:26:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221524-62941-xO0kWgVDHV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221524-62941@https.bugzilla.kernel.org/>
References: <bug-221524-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221524

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
This is a really old kernel.

Could you test 6.18.30 or 7.0.7?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
