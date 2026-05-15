Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6AB36215F
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778829498; cv=none; b=tSD9DwT99BP5UyUdHA7hi2bjAZXJ/1txZs5iu/p9em4oo1LNPwUs2JdcPVw78v3zLinF2gEVfOxLSB2jAsfe9ndeLkwNE6AGvX1Lga4MVZhrb7xo8SxPjYJD4vmq94Nf70FnaCJ/zewaPiIo1isNd7TtoJYKhmKqAKAwUKZ9R2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778829498; c=relaxed/simple;
	bh=nJa7MPruZKYKWYjzI6zEqF2FO4vxLODLmuCq6zIcTlU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bFhHisnFedqXOgKctgSzXYHgIZhY5YkhnXfGckvlJ1X+0Oz0tefFsP4F2U+IrdWH6xt7Li9uHFauI3Ion9s97UpHcV0E4y9beAwA2Abpn2aoyOrLRHRYRWcr7xztXI5FbIjqweIGVC9OYFofdIs6x/1FouVs2Dlyx+IfN96eoqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcuB+1UE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcuB+1UE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F657C2BCB0
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 07:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778829497;
	bh=nJa7MPruZKYKWYjzI6zEqF2FO4vxLODLmuCq6zIcTlU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KcuB+1UEgLvlp8LSlZ7ZRMQ2Sedl/f+OqvNZ3iqGH6VaG6kT3v5JNsITkw839nSNq
	 EICdQQ9kLOs4JCzaaqQ6J/nQ+dbpdsv/h5pf3TeYnG7kFLocTY1VNOnshXbuuHLFbS
	 AvcAy4EeOrZ0qEORyKQvPR1EzGCA3U1DYeHBnb7QNriYb+VYjHyJ0pEtn/Eu1MwVvk
	 Xdn8YKykLPeGv5gJSJ0yGqmVSIgHAOlwKVXiBFl+NR2FxFCwZQk5pRnihvVdmks/Yc
	 jXwoZThl2/e2rXCNeSmxZ1mukk0hfo2UGoWUcP6hs0KjndDnC8zNsYzw9TRQQS1MLb
	 oTa4VDjLx195w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8B1B7C41612; Fri, 15 May 2026 07:18:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
 (-22) on MediaTek MT7921 combo adapter
Date: Fri, 15 May 2026 07:18:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: txxlc@pm.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_severity
Message-ID: <bug-221521-62941-giM4bKDc8S@https.bugzilla.kernel.org/>
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
           Severity|blocking                    |normal

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
