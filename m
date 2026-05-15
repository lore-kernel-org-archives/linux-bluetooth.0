Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A3839934C
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778828665; cv=none; b=gTMcXhIb9/0wqJC/ZjRc7DvWEbbSpmpFv8jX6T6Xsj/i7/yhP+RYp3dhD10p+Bisr/vbaLjkkxPjLTay/4DF6KLxJ5yMBPsbQMnZP7wMdDdfOKXM+rM4pM77WsRXMygrFC880zR1NhDAoxTTy25rDxc848eEzVJE3W9H/QSq5YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778828665; c=relaxed/simple;
	bh=xJHuNOTFck0Hfgu3WR/1oGttiM8QIR90KeaOiNgaJOk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U5Ir/9LIa5Mra23eg0CWjsx0SKwOA05eTSRUyx8Sircdgx127A6CB5fvc84TR6kj2aAUEPEYFYoZX5mpj7zAcpSU6eC6kePHYy7+j2HA2Q7ap+V5bWpwz3rP9EePDP6MnwkDMbjp9m9iATkWwwaoBjMPqsamD6PgTqHntT5mAP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rm5e/Ul3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rm5e/Ul3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68651C2BCC7
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 07:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778828665;
	bh=xJHuNOTFck0Hfgu3WR/1oGttiM8QIR90KeaOiNgaJOk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Rm5e/Ul3BrdDQXN3XI9QZRKmPrBP55gb/ByPpCWdWrcce1zrLBJ0k7DN9aE5S2P/v
	 e4zrY8NiWlu5Zo/cXGDADfiLHmLWzLACqw7Z4ioYyCJdke0fOkSoZzSoNaUKqSPZ4G
	 eeQeMimGsSyAfZfose44lC5kWBagJe9G6BZcHMuBbQ6Zv3xkHnGu3xlF67hg0qxzRv
	 fzvdNrCelmLz8+o104i5zPVz40g9GVhQmPjb5wdFknUmws0T5QD3jEkjtMRLvM/+45
	 7QO6VA7QMyR9I0A/a6RwIsEMvXshLdM4lIGms3kHYy03teG0Pw/Uau2ZoD42BFl9li
	 Xjp88m2At85KA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5EC37C41612; Fri, 15 May 2026 07:04:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
 (-22) on MediaTek MT7921 combo adapter
Date: Fri, 15 May 2026 07:04:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: txxlc@pm.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-221521-62941-80iSh9LfaI@https.bugzilla.kernel.org/>
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

txxlc@pm.me changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |7.0.7

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
