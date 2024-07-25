Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F05BE556
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 20:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940604; cv=none; b=TnSS77YcScGhRESxiE1XkdAZxRVkbukwpULrJELni8RKfx6hEEMyr9WX8DAD5sD36ZBgmhF4SFWmd0cuH6Wycdcj8eao+zY+1P744epV2YDRbcr1e899g6LpwQGZTuWffop7kBUTBh6+VUQd87VDx2zSS+giyhjdahpLXDEbat4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940604; c=relaxed/simple;
	bh=W2YZDERmLM6gz0XMxcOe24peho7Ru6sutmLxGeUi6KM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=srBYhf/lx8Up8XsYfmj8RqHy/mTwmrTlAUsfWHRhnWwd9GYx29O3K/eYnyjsUHuBfmA6b/GCXI6CKg/CkzZ/q2rArzGfJXhtIqW6W4QennesTm97jmVcz3vEDf9w2XSv4AOG0fNsHN+cW2tPH8BIk26J8FgMSIdyj3RNJ2XPE50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJ9V6q87; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJ9V6q87"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D850C4AF0A
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 20:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721940604;
	bh=W2YZDERmLM6gz0XMxcOe24peho7Ru6sutmLxGeUi6KM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pJ9V6q87pwB+DAxpnUO/iYQs1kvg0ixe8/S0NqdoGvUtLEaN1lBgFZQj+gI0KyY6e
	 wpgldM8v0Loao4DhBHPVZ8lwXPwfGoKK94/fBhhYB1tsoQUsZRCPYOrjGXznE4STQa
	 8By6XrFz++v24I3xumniD2j3yLFuZAXlsqJMCH8IILPUV6AOjD0v27SARVFhG5RP2D
	 SLT/oWuFks+P92K2MhlM/T+ezf1bIz6sHgWZHSjDE/nCKqlGuyZzoAgMhugrmADiUZ
	 xTZ5odWOMUNNAKNlRLExj6hhLppqdb5v7YOQWw2iAgDPVyxmeJPalhqkiQqnO98lHR
	 z0J4WU4nYAYxQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 05D95C53BB7; Thu, 25 Jul 2024 20:50:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219088] bluetooth scanning doesn't work in 6.10.0
Date: Thu, 25 Jul 2024 20:50:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: eugene.shalygin@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219088-62941-v6u5KOa3FX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219088-62941@https.bugzilla.kernel.org/>
References: <bug-219088-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219088

--- Comment #8 from Eugene Shalygin (eugene.shalygin@gmail.com) ---
Created attachment 306619
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306619&action=3Dedit
btmon trace 6.10.0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
