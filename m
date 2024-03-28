Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224AF7E105
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624085; cv=none; b=lCShYBa19x8KbfX472kgJAgXo+EWkUYYfwm3hZldztzcXP1dJ8SM6U41Zrbxhgt3Hbfqluv1B1nqMpLB6DbMtMm3O/maJz82GPqz3HnkFl5uBOnyBvvAdzA10kFvLgaiP9pAov+AienGpqR9iB5VGqd8y2wB/MyLhqjbq3I+1Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624085; c=relaxed/simple;
	bh=gLGo7uj3cXhY3Hzd0EIiFb2aB5ITDoplxEqs3raI9sA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nOLTzTvUCNPmPJN2XI8BWiewubTdWGZNub44rVh7l5yuLW7RJQ9NyspIu51ZP4VUzdxEZy/4DO6i8REu2wuSqtovrc6z2EBtyOyBZeyeNJtnQglj4wm/NBfMqD7A3ELPBabiLb5E829LyT+5WdYvkdvLnYGurvaKUhgL7ywLHfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAHoflWK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAHoflWK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD0F2C433F1
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 11:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711624084;
	bh=gLGo7uj3cXhY3Hzd0EIiFb2aB5ITDoplxEqs3raI9sA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UAHoflWKKICSDTpTXHTFE3cZt0NvrObI/ZuKqnLKPZfSO0S04mLEWvlc6wxvuJ2N2
	 QjQH2UCuBPyjjYHEpQTCsm1BvXjugQZvnzcDxvcG8dI1yTqAiCbaJ4IUhhQ+kIiI2A
	 aLlQGQ+3hDmj9YCBDQ86IDcAdDb+u9Y0dJIOVkjWp2wj6ei24nWrS8Uau+TYuD0nHq
	 6Q2wCLU4sRD1N5hY8Kv83xVMbKycWOvi15lcR5mOAitHWYgndwIMMrxe3+nM9SPSsN
	 7SB1SHKvtMykjWDA5NQNZHpqVXyhQyUdIk9ylhNm5g8IrBPRF8VPWQkME+mwHVrhfe
	 1s1EeHWpwYvwQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A0F8EC4332E; Thu, 28 Mar 2024 11:08:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Thu, 28 Mar 2024 11:08:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: agurenko@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218651-62941-iH6kVKZpDf@https.bugzilla.kernel.org/>
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

--- Comment #5 from Gurenko Alex (agurenko@protonmail.com) ---
Okay, probably command timeout is related to this one:
https://bugzilla.kernel.org/show_bug.cgi?id=3D218416, but I indeed missed t=
he
null pointer, which is also present in my log

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
