Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075E224219
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 02:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711591965; cv=none; b=afAuoSigNuBvPK+uwkpw49+E0SFaAkTRqKFOuN7u6UaNVdCKKtyPiJLB3SSY7F7cCaMLsL2a2/vLY/LiOOfYm6I43Q3F3mou0dqOshkXfWrRCtWIO3G7zfU4HABZYQ8i3tyRC/CSj/zy5vUIyPI/AofcwOmKylPF6ITTxzDpW9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711591965; c=relaxed/simple;
	bh=se/FOGzIY2iWeAYbbCK8HL5XtHKsKj6ksF+Dj8kkITA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k2pvlsCR17QzwwfOZbexGDZre0+EaYE6VgqqNAj3ZgCLTL22mu6Xtr4RNs00ez1NcG19KzLgq2tZqBOcoPpayhF3AMHIXM+C/ekbkZ7jDN9hfeQRQO2k68klxP4fhck7oSPwdfDDGV7xDgvXQdr2+cWuC5bmFBHvr2AsbAoKDYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2kPiJ8x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2kPiJ8x"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CF46C433C7
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 02:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711591964;
	bh=se/FOGzIY2iWeAYbbCK8HL5XtHKsKj6ksF+Dj8kkITA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=L2kPiJ8xVq9+3Pogi0T6WN5PEb+3E1lOdKntId/0RFRNEekAC8Dm/sQNlV63SDTXC
	 BfwedzAoXogmd28rcL/WcpBEcFwHZGEyeVzJN+L9wUrYhbzaIngINrRzHCZYNRTIS/
	 BxDpJXOULb/P6IIiBAOxiagUAgLDIreGrCBnJ6ksNT+kdwRVFIf3bT4V30ubHL98+q
	 XKZptzDE8fgvxmVnFGMEIUII8Q223y0h3n1hic65K5snlQ2RhvNWbh0Ri7Lbj8BQMv
	 +qKqBETKCKV/JB/T4KM4p38gs4AdSi7fwwLLTNfvS7WD/f/+npeH2IY5sU6DjBJw1a
	 FCiNwbaWge+vQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 67D36C4332E; Thu, 28 Mar 2024 02:12:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Thu, 28 Mar 2024 02:12:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: jb.1234abcd@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218651-62941-wgcFu04QjQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218651-62941@https.bugzilla.kernel.org/>
References: <bug-218651-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218651

--- Comment #1 from jb (jb.1234abcd@gmail.com) ---
Created attachment 306050
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306050&action=3Dedit
lsusb

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
