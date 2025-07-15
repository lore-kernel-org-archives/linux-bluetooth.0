Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44514533D6
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581640; cv=none; b=Ira4vw0Q/FETkOzrCswkR6QVyJSUq6Lb7YCtMgodEadqWgM3KEjpNS9ysy0hZQYPjfET7xaizFxRGkh8NrYE/Ifp8qXH1KMO7iwSe4luloVv6xmp1E85svRJumbOEa2gKE0h5+aT+M3HmejlRvfSRyRKoRiC79bw+a8ATRHtICI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581640; c=relaxed/simple;
	bh=S+bLFSO8kapLQJE4XOQmAs4Ng9c3VDQcFUYEMW2jpYM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Am4QaUwG54Pou92edqkb+doTauAiq8gytBBWiUvhPzfizOxraZ6SGdQ5xx9+CODIvBjVcutIzHC5X633cub9EDl6DtY8ha5lGYCxlgWfFbBlHxg2sSpwwvheicyPT+DnkwtNW9l9ToRijCbGMIQKzeItXnHf//m9EcDA3zknMzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/oJwxYE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/oJwxYE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBA46C4CEE3
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 12:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752581639;
	bh=S+bLFSO8kapLQJE4XOQmAs4Ng9c3VDQcFUYEMW2jpYM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=J/oJwxYEsfkH1HQdOJe4o7qLl7uWs4RRN2eQcm8LaKuIlzzL2e+1Ho/O/AuuXf9ll
	 KjGA8PcbG78FzHY8EFDdk08MKWgETVCaXKLTFuWfd7ZD41huqD/wg+rzmpEcNnVv8z
	 BrcxStR2cPbip3JOnkz8j5SPe1MV9ZRjGHR3eq9g9Yw8MyqKS9pNl6BTbmaNZI10gs
	 cg/z1ZueJtCnzVdF3TBHodv8QaXY0GxGeZJp5k1qbTHagsyIFiRC1hS7vQN0W8Hots
	 FtpjTvVysXdQA32teG29fKZ8okoPg2SKVQjiVxX3SAxhqnMAvflwj5H4mguLNeTUXr
	 xFXHbZcv6T9AA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id ACFABC41612; Tue, 15 Jul 2025 12:13:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220341] Bluetooth crashes about 30-40 minutes after I connect
 my headphones:  "Bluetooth: hci0: Hardware error 0x0a"
Date: Tue, 15 Jul 2025 12:13:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: martin@hignett.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220341-62941-m5buouEPGF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220341-62941@https.bugzilla.kernel.org/>
References: <bug-220341-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220341

--- Comment #1 from Martin Hignett (martin@hignett.net) ---
Some more details on the symptoms:

The kernel logs indicate an error in bluez or wireplumber. The entire Bluet=
ooth
stack is crashed though - for example, my Bluetooth mouse & keyboard also
disconnect and remain disconnected if I restart the two Bluetooth services.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
