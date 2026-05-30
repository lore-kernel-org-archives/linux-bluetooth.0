Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE5D3438AC
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780158095; cv=none; b=EpoM8E/VYt8G5U0HdidX+bgJmOSyjBKh283x+eWcTPqBcssVx9hbEnE0vmJPrx2Dr243MB/SpCn//pjw2MdseDkQsae4EPRYqy01zbQ5S03FtQP2e7CKpoGi3QCoWbUru5NFXa+BslLaI+xeuh+r6xh8laoldd1dh87R5SSPs6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780158095; c=relaxed/simple;
	bh=FIdCSPbyPpBna6vA1v3bKcOZif6VT8M7PC5oTXUPeok=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PfAW8qtKUQwWSP9j93DPTTU3gVxG3fAn09CNDkTOm9Es1DvI03IMLAwblvj2iRUpZ9c9ISZ64Ai8Eldncgwy/de4H2woDsG2t4brky+xKx7XgsVvYQUw9VHPVtaQ7NyrJuoK+x9Hp5AXL30hL3WBK6ZZv+bAycwfEGdlazbLouM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYZajdG4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYZajdG4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CADC0C19425
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 16:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780158094;
	bh=FIdCSPbyPpBna6vA1v3bKcOZif6VT8M7PC5oTXUPeok=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FYZajdG4lWlA/5XvtlFgy+0jl2r/z+pOepbe0DSSOoWK9znDczp6xC0xH5PhGgJPq
	 hn0y6Z1JjkJyQDUdNON8jmkeMGHY5TawxJ2soFwk42i6JrK+uLxjbCSKOoTVnrf+vF
	 ip+Ps9SxZAg+1JqLBm0Xs3STt3phVPlhWTNv4zDCAe36wIHTWEN/TReNwFngte6M2+
	 eAHnBzQdlweLscfrifPHz/kYlYmPi74TP6ffCveJRN+Ukb48deCskvYASkO30I4+DC
	 JPBoo9Dgg54lUNoKUq+OvaAfWuTIaSesPbASRBO4dzIzsRghLk0s/19rqws/LVzQMy
	 Gif47SB6T9vRg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B0689C3279F; Sat, 30 May 2026 16:21:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221598] Bluetooth: btusb/btrtl RTL8821C 0bda:c821 HFP/mSBC
 microphone stutters with bursty SCO RX delivery
Date: Sat, 30 May 2026 16:21:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: apocarteres@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-221598-62941-53efKiBhPh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221598-62941@https.bugzilla.kernel.org/>
References: <bug-221598-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221598

--- Comment #5 from Alexander Paderin (apocarteres@gmail.com) ---
Created attachment 310214
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310214&action=3Dedit
binary usbmon SCO/H2 analysis update

Archive with simultaneous btmon capture, binary usbmon JSONL.GZ capture,
analysis reports and scripts.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
