Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB81990A1
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508617; cv=none; b=kxm1Bt09NgcM12Q9bI3tT6u7DZ3j+WWRXNnDI31hG6gOETmMhzUf9S7rWLd46o4sC0c6kl73X5GJ1jlwnj2t9nkpJukfT1ALTXRcaIsJ0sLXgCOqT1ljTxyLz9PoJ1uzJUr017Wa7f1TykvE0GIyOYz4UzEgY6Qmq74ClTcdego=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508617; c=relaxed/simple;
	bh=nA19gNv7eO/p1ZGslkK/exzN2E7wo5UbdiOIiPU19TM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OT1q0t62W+gmfpeKmxxKZNbPj1Lx+gigvtxN0P99b0MkK+8RA1u7NfY41onmt4ZPjEQGGqV51R8msZwohKVnjJ+t/tyWuFJ10vCLBJkxJc2WQzBcsUvTLdjgv+sKA4lxdR8qrD2/BlV4C/vowcjaq/AK3cVFTGNTA7uubQ/mDBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSuVDQl5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSuVDQl5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D481FC4CEC3
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 11:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729508616;
	bh=nA19gNv7eO/p1ZGslkK/exzN2E7wo5UbdiOIiPU19TM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OSuVDQl5XFYOjmQw2IFjeO7QnJoKMKUYpbN+F0dlN9xglKm5VDmBGaA/5qrnNAYGI
	 9HDt50hIfAYJCRvCh0MGhq+GKJrNDZMJEPFy5qlUWxzWPbSRXfCvAKdLy4eFOom2i/
	 y9wmm8eyIpSoIPSGJhOr8QCQfzhS9yP9MNC090ZB3MlslOKdWKWwENTD7FfKRmCV43
	 aCUO09/fccQDr2N6T337mXp2wB7h0zx08LzhxrlpprqojuTSxEvlJMGPfFB8E9n4iX
	 CkXP5xlolXf1LAza7omnhA1YZ701cZv5As/gmuCx/oTi16wfokickerNrM77QR1fDp
	 H7emFqpaMfMMA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C36F4C53BC2; Mon, 21 Oct 2024 11:03:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219405] [regression] mt7922 bluetooth scanning does not work in
 6.11.4
Date: Mon, 21 Oct 2024 11:03:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: eugene.shalygin@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219405-62941-wlpUKNBrhB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219405-62941@https.bugzilla.kernel.org/>
References: <bug-219405-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219405

--- Comment #2 from Eugene Shalygin (eugene.shalygin@gmail.com) ---
Connecting to paired devices is broken as well.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
