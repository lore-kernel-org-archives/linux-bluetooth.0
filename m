Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DEC17BB21
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jan 2026 19:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768247726; cv=none; b=s/+bU53gpxVgkBUFXvNKXj0tSjXlmXW4ayYFkF6dkrhPMWeEObYnRPip3SxzIVKFDP+TJ37ZvZ+naNrLjjj/2HZqpkVwPQDYY04GvHm1vCD2FTumyM7LPe1PTpUCf4rQDBOz3pgOvk5DdqqNfGPyLf1fi4rE1BAT+XZ3fIhDVuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768247726; c=relaxed/simple;
	bh=4MFEmNreU7Mw8LkNpYWbJzgdSPpm4Or5fbx9ysEnx3E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P7YqEuERTbb8v5Yl8aZGJn83l9GojGeIpH/luuc2+t+6i+qfoXLCeJ0nm3cMRwj04iHrwK/j6QqXCBBcYx021SohkvI/Yx5zy5LcI5dyrqpyzLoryR0GiDB5DnU5hnS05xN8tyYg6diLaGmbXeU3JlaIOpcxsOERkfJ/NJ9Fa58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8we4V+B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8we4V+B"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C346C16AAE
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jan 2026 19:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768247726;
	bh=4MFEmNreU7Mw8LkNpYWbJzgdSPpm4Or5fbx9ysEnx3E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=u8we4V+BOqNjJJgpdZ8/tlrPHzD1oPt+c58bHgS83ilG35b/GkPVpY9yVvCEFhMDw
	 EAZOOHAfZaQEO0+UOmZMdFE/IDlbaUuvi8y/ISmcwLAaJMqe1eaViyOHETpMd4I8sj
	 lMu516gOA04nzcNnoh0+3mP8dhicDw6rgHSm5tKfCKzjv8qpmwBcTLKEyzjY2r81EL
	 PQOND26cCayIKGQBTO5ECRXbN235KUXL1cvO/+PoQw6UhKf0+DDOrIrKVNYgjg3XIL
	 1gEtTSLDoV1DOKkU67R8voAmXf8ju4KStV0529PzoXi5iuA0X/fil+jQqkYOrwmeFm
	 zrrKg/sSEWoVw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 19185C433E1; Mon, 12 Jan 2026 19:55:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220922] btusb: Add USB ID 0x13d3:0x3625 for MediaTek MT7922
Date: Mon, 12 Jan 2026 19:55:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lucenz@proton.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220922-62941-cpltv9eUny@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220922-62941@https.bugzilla.kernel.org/>
References: <bug-220922-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220922

--- Comment #3 from lucenz@proton.me ---
Any updates on this?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
