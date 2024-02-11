Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA885B5AD
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Feb 2024 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707659947; cv=none; b=Kq4rbag7BdYnJQ0hgQ3EMnJFnvpoShDZsTprph6jKMQVmQM5Ii21wUOnm+aVUivwcqlk7CzNGzv4GhfBc2soRAt2+0IVvhFsDicl62M9jJasAi24GOpQ1GlsQXKFr9r6o8bKINd1VlwaxY2OUmnqHixPoT8VerBx6GVuH5IasqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707659947; c=relaxed/simple;
	bh=939Z7UFNA4R/UH3jUXw2nMhGPwxkYGOKik0NlJ/4HcI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DHWJ6QO6rDpDzWpkvuvKEH/kV0ZMxCrw0yzPwqaP1XAEirAqq/E+/JByncQJRQCkbcKgQJnJochhBp+UJHHOaF+a/VFhop7bc8S8IycCItzQh4mXFYkNvt4zH7ef1n6Yed3MndT4y8XiACN6fnr4KhYcx8pRVCoD3FMHDeZdlPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTwVcknQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTwVcknQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 353B2C43142
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Feb 2024 13:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707659947;
	bh=939Z7UFNA4R/UH3jUXw2nMhGPwxkYGOKik0NlJ/4HcI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oTwVcknQrTmFlITTPEKcuQIqB0L65F/pOoblJpLyEYWwrtjI4R8++u5KqL1ua3Zsr
	 wsJPXj9YUrr1Hyl67pGJ6UbfW6pRvimunsw2KZXwKd9UT6+02OwqRqihUc3RVKcteh
	 BT8+XW8jquW02dyBizKlGycpmAU5YQgSOm3/VasOK/KjfqT1Mqg4DzvVOAIxwnHgMC
	 bazuJRWidsx1daReiSebPJWjorKlyIE5i4WEz8k40IcxAcYaI9LYGCyBmAYXdamEfx
	 +BPn4MuBHtSdzYL5G9umz9vE5fNgu+MwHCCowVNQkkKap2GaJU/X9D5Uq86HmBNSF6
	 PUtYwJp+n+/5g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2541DC4332E; Sun, 11 Feb 2024 13:59:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date: Sun, 11 Feb 2024 13:59:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hlechner@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-kiFYp2XmoV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

Henrique Lechner (hlechner@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hlechner@gmail.com

--- Comment #277 from Henrique Lechner (hlechner@gmail.com) ---
My bluetooth USB device: Baseus BA04

lsusb:
Bus 003 Device 012: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Don=
gle
(HCI mode)

Kernel with the problem: 6.7.4
Kernel without the problem: 6.1.77 (installed via AUR: linux-lts61)


When I tried with kernel 6.1 to connect to my PS5 controller already paired
with the kernel 6.7 it do not work, once I removed it and re-paired it did
work.

Once the pair was done on kernel 6.1 I could go back to 6.7 and it connected
without issue.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
