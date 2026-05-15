Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297A03CF021
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840446; cv=none; b=BDD8R0CHf8PT2xf1E8hRUTo4PCITEmDjgP6OACai8iNoC620RmFPRY1IVM/+77Cy+1Wv7C/TTuR3azc+91ODsOwPtqzZBnsJk/NVgyb2EhL9i5ernj0S7+x0Fl84F6MB60Rb35dxbgzA97fCU99WGpjqGRcLhod6jOZm4GMUUg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840446; c=relaxed/simple;
	bh=4IklIiWJ+aJLFWO5n0xmoaRUk3x93T+E09vozC9jgUg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OvVB7rc2mdmUZu9lFbqZ7oz7gTcaRMGRolW94aYTGauH8rSxp+3jTXiRX9vfhGP7Yfgt2bd3DWkFAOybRnQHxmcz7RoCxivRmSGC+pro14CzQBd6ku56hks7a5uMbZSI4jjww5VcRk9fE/PdVd4omf4RuNmcrkjIsPuOwiI8jdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiGYW1cO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiGYW1cO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C635AC2BCF5
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 10:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778840445;
	bh=4IklIiWJ+aJLFWO5n0xmoaRUk3x93T+E09vozC9jgUg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qiGYW1cOkRYEiTLlwvpPpWVzUpgdmhdcorhnaVOSaoT5KZ/UQjhJMtVZXv7c29Uh5
	 xCAZc0PUmSfCBNFaLsq4pOrPAjhUKULAlcT8LjP53N/Vc2U3ILrIDW+dQpg2RtCbwv
	 U0pJoi37ZXIHhunzRHteVbJSO2EiDcGN1LAsdscXPXVQ7NlAHs3VP4Sy7iw8fy7RMQ
	 g+1RN8+PbosfCLcQfaAjd0abX6A4cABAMzI/R6eW22t38mJbjQ2x6F0Y7S5VUs8ZcK
	 Wlv+IIUEl+jZQ3WWK4tgidYLweBoYsV3Mcabkwos4Yl7SgPc+239vWW3OP32Glv0v0
	 1BkbG4ZpKu+nA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BDE80C53BC5; Fri, 15 May 2026 10:20:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
 (-22) on MediaTek MT7921 combo adapter
Date: Fri, 15 May 2026 10:20:45 +0000
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
X-Bugzilla-Changed-Fields: cf_bisect_commit bug_status bug_file_loc
 resolution
Message-ID: <bug-221521-62941-wh1XIfLQs4@https.bugzilla.kernel.org/>
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
 Bisected commit-id|634a4408c061                |634a4408c0615c523cf7531790f
                   |                            |4f14a422b9206
             Status|NEW                         |RESOLVED
                URL|                            |https://lore.kernel.org/all
                   |                            |/5i35wmc4z7sz54jo5uj6ywext2
                   |                            |enh4ik3oxmfmperqk2v5kc27@pp
                   |                            |vm6oodzipn/
         Resolution|---                         |CODE_FIX

--- Comment #5 from Artem S. Tashkinov (aros@gmx.com) ---
This commit should fix it:

https://lore.kernel.org/all/770d36b07311bf88210c187923f243fb9f126f04.177705=
8551.git.pav@iki.fi/

Not yet pushed to stable but hopefully will be there in time for 7.0.8.

Keep an eye on
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-7.0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
