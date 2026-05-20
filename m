Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FA7374E5C
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263549; cv=none; b=HLBwBdrbcydIt6Gn18YrRWA2sStmkDooZ4NyxIT2/yXqcBsn28wimnX8R7+i8w/E6/ULkZsUkftvXMaB3NneZ7SvSpyus9IgQLCJWMnvLf/biDoL0gIqjyLaqzBDqScLwxXNk/PxlfF+8Lw8IV2tmYaKtGlGodQcR/qXbzXnMXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263549; c=relaxed/simple;
	bh=URgnTYoVIk1uNm8A/QUTFAPlwPem1vUblRmaAX7451o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dVxkqyK5QJ3/K0vAQRF/Bk/V0GRzMtKsjQzQO6zR15Z02/6L2Pgy71WNrVIA+ixO9V3Qk2zINA00zgGUE6dBUTIAc2qJ53UnyMb7Ehf/h85wTzW1eNFgE9uOZ3CXZLcWuCP0kkGYSOs4d8QgUmXSEDBehhvIkd2CUOicdRx3bhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONZWpRy2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONZWpRy2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DA93C2BCB0
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 07:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779263549;
	bh=URgnTYoVIk1uNm8A/QUTFAPlwPem1vUblRmaAX7451o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ONZWpRy2XfIxieHc86xfZHhuCNr/1m9exFE4EdStrUCMAdjpfkEDNabPuYfmAZwsR
	 pQRDnCtPUvqGsFhkDrfv7KAeJxF2hjtfagpA4OysLqxfA86qW71TdiT1WnP7cPr2qy
	 QZLBW7fDUZarrIXFO1IOayZbnEgmkFAvlHyT7zvEbpFRxnHKxhY7i7SEzG6zDLEvsY
	 sLws9OPCGwCWPesiQm6gJO5Ufi/UVE0IGPuU5W4z5ZbXLsASlpNBVoR0t5DpK4fKxD
	 txtO5etWJzFuJeS7BknvnsIeVxkTtI7JDqh2PM5oPetlicA3QuI8rUdo6BUMu2HCuF
	 6USHAn5J2DpiQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EE2F5C433E1; Wed, 20 May 2026 07:52:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221547] MT7902 Bluetooth: Failed to send wmt func ctrl (-22)
 regression in 6.18.31 and 6.12.32
Date: Wed, 20 May 2026 07:52:28 +0000
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
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221547-62941-owVzAZMIIy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221547-62941@https.bugzilla.kernel.org/>
References: <bug-221547-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221547

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |DUPLICATE

--- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
It's been queued in stable, either apply it immediately or wait for the next
stable release.

*** This bug has been marked as a duplicate of bug 221521 ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
