Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C1F381E93
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 22:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783033185; cv=none; b=En5eGACcObovIA4NzwXnKaIYvgBqq1EC9fhSAw9P0/0pdnLdnFtSQnfTgqqj5LlBKeBSqtTmgsD97QzjPAxTazfm+iod6xNdIvO3b7J5D07abhCCy73Dsg6QmdrVe6Hlzm5h9mMLqlxrAv5duwGRgcjKiEJ6QX0Cdv5OaGe9q6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783033185; c=relaxed/simple;
	bh=bFkR958k8s8OK+2Fz6S0VNJ31VZTgI1Vnmu9Cfv7kO8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c+5/OP9T8O980eTN+NdFPcXZx1MnPokC1Cnb/Grys/BkBFbyys4l51kZptojQTU3pDOK/ltuh6aJoqyTH1YEsJfbx/7Xx7G4m3LXxWM7QCh53jxRpzorGh+FzLdEATCwHvTzgTmPRpEUdJAnQXGcSbScn/341BGuXdT0roAiu1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYtdrnq2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYtdrnq2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50890C19425
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 22:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783033185;
	bh=bFkR958k8s8OK+2Fz6S0VNJ31VZTgI1Vnmu9Cfv7kO8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bYtdrnq20OzxLPuipytff9RtUvXX8ttgCRaACQzcJFJEIcJS1P16kub5QgSpun0Wk
	 kDiKPqQviRxL/2NttfTLKDc+50xAJtY4ioXKEoFxSgENrWqqpBzwrQ3o5tZL1AYRpu
	 RY+GKM+KJXmk2C9BCHAGWNcQmUU+EVperdObBH+U+zfH3/5nTLge4eaYgO8RlgQ3p6
	 C21aFH3QmMwST/EkMTeFNzp425JOEW2QMrBOwCKo9vTpoazHp+1Ej7Hnuimoa424TR
	 0Rj8qjt8sFQmfDKQ1dj1ux4T/e1W1U3SqqecUddeBnU87NG+UNW0m7HNQ7IjpAkt6Q
	 JZq0uyXd9EgbA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 41221C4160E; Thu,  2 Jul 2026 22:59:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
 (-22) on MediaTek MT7921 combo adapter
Date: Thu, 02 Jul 2026 22:59:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: p@atiq.xyz
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221521-62941-LRzC1bJLTY@https.bugzilla.kernel.org/>
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

--- Comment #19 from Solarized (p@atiq.xyz) ---
Fixed on kernel-7.0.11

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
