Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAA21411DB
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366793; cv=none; b=eeIyHLC+jyQGumnsiHlHSxqOqV8eLJnqihPQlUDoBkSrlsrY1vkbj2XwU9fYr06rVR4X2petrYXcg0MHJG7SHfsY2ABgMr1hiPD0ICgo4ynDcLWzg71L9JeEbab3xw2cbZ4K/SX2sxSa+YEnJeuMpSA1xACFQGWf8KEGn/9Tx6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366793; c=relaxed/simple;
	bh=1sBdPLEvOVPStTludyg90TKPQ9QyaE9oibeCSnlLoFU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cA1urSG1WNIDDf00l34h9p5QGbK1yQLubvJn/7ha+c895bAoB5CW/2F87ff2jsF0EZozaGH7YI8iVNbt9anvD5Y53V/l5Vj1eyNtGkgad+1DxsPxpPAR5NoivC+ub3enmX8ZvOxioSjA6C5pqsZK+ZxxZUJIfLOdMntwleQCl1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FB1Nx99I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FB1Nx99I"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 044CAC072AA
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 15:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713366793;
	bh=1sBdPLEvOVPStTludyg90TKPQ9QyaE9oibeCSnlLoFU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FB1Nx99I4TKyeFOhFzQhCSES4k2X5c/uPUACO1asb+lGsELVDdDnxlq7wP6xrFzTM
	 HifNdGLfRDdXNu1mi9lVCkOZ43PKLHwQVBjuUk1JagG28D+AANmg1ZN+sySGO0zXBs
	 f2C90SjO7XLNUYMZrwt7+CLtaINw1z/8srTyuyQHF9WPd4XIoCA7urZuhj+6H7tJ4o
	 0CnAVMVYcqBH08WQbFy2yp3S5dFcTa7UUyR5slupMV3XCOeU+lsWSlMGdkYE+qzuoY
	 5pCw0RypKjgAjdME+OCqJ4VgNJMKRzhgL+m/oxigzBBeXDNarZlPOX3v6VunLv+M+B
	 iMPeBOOBUj7uA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DDB84C433DE; Wed, 17 Apr 2024 15:13:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Wed, 17 Apr 2024 15:13:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: quic_zijuhu@quicinc.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-elAIkCW6r4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218726-62941@https.bugzilla.kernel.org/>
References: <bug-218726-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218726

--- Comment #35 from Zijun Hu (quic_zijuhu@quicinc.com) ---
Hi Wren,
sorry, it is my mistake, my 2nd debugging patch don't completely revert the
Commit=20
56d074d26c58. i have updated that debugging patches.

you ONLY need to apply below to changes over the tip of bluetooth-next tree.

https://patchwork.kernel.org/project/bluetooth/patch/1713095825-4954-2-git-=
send-email-quic_zijuhu@quicinc.com/

https://patchwork.kernel.org/project/bluetooth/patch/1713366251-22144-1-git=
-send-email-quic_zijuhu@quicinc.com/

if there are conflict, you maybe git reset beluetooth-next tree into below
commit and apply the above two changes.
e00fc2700a3f Bluetooth: btusb: Fix triggering coredump implementation for Q=
CA

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
