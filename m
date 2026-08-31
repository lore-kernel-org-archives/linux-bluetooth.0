Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574CD33938C
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176269; cv=none; b=u9BxFaTtnt0Mo/m6RKOUnkBmdHxCNQOizmk2iyyfRJw2Bm6k6bgt1UPmonDE3C8AuQOKY/I0DOFtfLJ5zggU9N/jkttqe1iin7Vf0BoOBtjC8hVnjCcXmz2sMbCQC8rocy91m7rgFHfphJbBE1hdaZ3P/csa3Z2p3yfCZnzz57k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176269; c=relaxed/simple;
	bh=n2jyS+t/zyIw6kQUvl6sCh9Zu4oXbSQetD3jQdccSi4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a4rqLJ395dJVgQestkxzWmOWfC4sxav7Vm8SMIBCsLU/CkuL6X8bw/bXlloCuXOyqNk9YOAeNrK+WOHdI/nXyAa1h2+XRqHjKu+lT5fLhtAlQp1iN3H2QOVGj9NC5Yq8IbKa2W2X+049NG+mw6zcJkaWpq59Za3+63v8y2XG9cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSYoMj0e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSYoMj0e"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9099C2BCFA
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 11:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788176268;
	bh=n2jyS+t/zyIw6kQUvl6sCh9Zu4oXbSQetD3jQdccSi4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZSYoMj0eeO7KgyVp0TcUiN0BJwuTupp68ABh5e49DRwJxT7iFUL4eIMmk250+TPbm
	 U7CKpAj5Y5rBZ5WPGlGVmVNhhAVoLS2A4590WNpF0ZmQjBU37TI7Pn7WrA/YD2h+Lp
	 gub6/bYWFKNjr+JN4uZVUdWPZrtVogSR0VS+YoWsPoz9hKMKWYL23dFvw/JpoYhEcS
	 wg6dQTPGak2yuXFKo0qeOvjD/Bzs4qFfgMLqKBK0WH6ULVVgwBUohClOJqrCFmZCpu
	 6LlVHxW5BhA8jYHENmc1vpuhHmbFYhSchB6ais+WwdmUGwXlRbS82Qcql9Afdc2rgv
	 Y3fA2H5J2QJGQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AA644C4160E; Mon, 31 Aug 2026 11:37:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221837] Bluetooth (RTL8852BU, 0bda:b853) never initializes. 
 Opcode 0xfcf0
Date: Mon, 31 Aug 2026 11:37:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: rohanasrani3@gmail.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221837-62941-z1RwHoh1GT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221837-62941@https.bugzilla.kernel.org/>
References: <bug-221837-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221837

--- Comment #11 from Rohan (rohanasrani3@gmail.com) ---
Hi, kindly following up for any updates!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
