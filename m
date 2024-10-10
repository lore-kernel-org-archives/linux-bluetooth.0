Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65AE188A0D
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Oct 2024 03:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529739; cv=none; b=BAYhfGXBCrV/pblfPXAMr6NKYzlC8Xp19m/LJsKaE/1kaf/caMemYerF37G3SqmTd58KcNMEXW/e0Jc2iUfhSPnBCJoLxe4GtbM9mrKAJ0TyGBjM9/VkqcG5dzvAtoV8e0p5UFGaiLrxFxAFBMAyV6Bwk6KXMehmUDVnHyVq/5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529739; c=relaxed/simple;
	bh=tP5SwicIvQWwq8RSfsOEoOIlVaflgn3Ed2jdmWWKIi8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J0y6J3P97Iz6HbgFy0acWqp6OaYzZWkm9Y5BomtTx4V91u+E8Y7dAxWN+fnMp1rc/cyQ+jGpQYvr5Bx/ahuhlTzXDpx8GEgvz3Ww4Pwk0m+PXSgTlz+qkDZ99qJCOfbG7Kddi1Mpp4wdtYbvyKI98Arim+y1Tx9NY7BVuJe6Yhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lN7OvNLd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lN7OvNLd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49C81C4CED0
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Oct 2024 03:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728529739;
	bh=tP5SwicIvQWwq8RSfsOEoOIlVaflgn3Ed2jdmWWKIi8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lN7OvNLdPxiwG56nZw+i+e9zTSBGrmErkNzW6e5MTRxwVoWYvjbHln7S0FRbfpmsW
	 X6BBSxGVnAlfUyyxOlDudCB93hp8eItQImXRq0k+rP2CgR6Ij7pERId6Zgvf3weDIY
	 NZFF6G3CXvhQ4s+eifVdcmubyk8r+ytGrMta6NxenEDexFod4em8wwLqWeJzGAQc1P
	 YpNCxJlhVywZRVj5aIiE0ayOwkRIKrdS711iRgCGKprgx07f8LLh1Aq/4K2Olb42Hv
	 eY9l20Hv1iFtW8Z1GrGa1axfRKhoQ888lYgmduez1Phdv9cw/oV2OH+qEAScLh3SyJ
	 TCnN7woIAoucw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3D6C3C53BCB; Thu, 10 Oct 2024 03:08:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219365] USB bluetooth dongle stop working after upgrade from
 6.11.1 to 6.11.2
Date: Thu, 10 Oct 2024 03:08:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: adilson@adilson.net.br
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219365-62941-JCisi38NTt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219365-62941@https.bugzilla.kernel.org/>
References: <bug-219365-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219365

--- Comment #9 from Adilson Dantas (adilson@adilson.net.br) ---
(In reply to Luiz Von Dentz from comment #6)
> I guess we need to USB traces to check if that really what is at play sin=
ce
> we are giving a bigger buffer to the USB stack perhaps it expecting the Z=
LP
> to finish the transfer but it never happens for some reason.

I upload two traces from usbmon module.

One from a kernel without the fault commit. So it is working fine.=20

And another from a  kernel with the fault commit. It fails when is plugged.

I hope that theses files should help

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
