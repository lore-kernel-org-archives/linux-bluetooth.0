Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C006A17E442
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718205925; cv=none; b=hbgMn5QrpI4lg1BjVEDAYplrwPjsQHHWLhC1kblAp3pR+7ww7K8aIg3tNo6EaaLA5oWl4Kyzh3VQr6AHxEZQaMaDcDzybipwQyg5HS89h6KSXQiKV+kUrR7pa87jS2h7MchAIcWAHbXXC0rgbC8DrtdA49NtBBXnSYvRliQoyz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718205925; c=relaxed/simple;
	bh=lbzAy3aOnP7HMRLVgeNyztl81QTUnNvDXmqbg5Qnn5E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FdYPxh1snOiGWkBBHNkH3oW/Sqkn9EePgVTj2azJCPComTzR747LoEw81Y1iIeY4bI/TBGNEEnEO3WEoYVTnBPeReyd1gzqjmNo1kXM4XPa4945TBxVElIFxbOzq11sUp2wlgWM4ewj9uMuKUYQ/ei9tsm6BBoCqnxar3EWrUQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usScqPnm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usScqPnm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EDC2C116B1
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 15:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718205924;
	bh=lbzAy3aOnP7HMRLVgeNyztl81QTUnNvDXmqbg5Qnn5E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=usScqPnmlmKDllPv/2qUicyRgWF9BgOwxdKjM9edOmcqx8yhCxJVyMBLhQUjsAfgi
	 L9JeLjVOWaLWLkMzHjj3X/S3FwguzK61n6ztrLulSvkrB4xVcflhscxnIZT/5rztrz
	 0vEQC31bwsQkg51JFIkQ2wNzY+y8FJc9glkhn2NOPY3wVhlPP1/WrNseFYdu+x1Iqy
	 z8p/lozTvTKjgxhAqZ8UowG2o9WFB6R8kh7bjp44MEaURxEoLCiG5Lm7bgxXCqtqz1
	 vC46IDisQokwP+YoMCk37WozGFvqWKkCc2KGjYw0q9bUqJfynMQtqmiPzfcftGh4zm
	 Ab61Q2ItUlk2w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3DABCC53BB9; Wed, 12 Jun 2024 15:25:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Wed, 12 Jun 2024 15:25:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218416-62941-3vOCZgPm4B@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218416-62941@https.bugzilla.kernel.org/>
References: <bug-218416-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218416

--- Comment #36 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
What now, CCP (aka AX201), is what I have in my laptop for ages and I never=
 had
a single problem with it:

Linux 6.8.10-300.fc40.x86_64 #1 SMP PREEMPT_DYNAMIC Fri May 17 21:20:54 UTC
2024 x86_64 GNU/Linux

[    5.935014] Bluetooth: hci1: Found device firmware: intel/ibt-20-1-3.sfi
[    5.935118] Bluetooth: hci1: Boot Address: 0x24800
[    5.935120] Bluetooth: hci1: Firmware Version: 132-3.24

Having 0xfc05 to timeout normally means the controller is not responding si=
nce
it is the very first command the btintel.c will send, most likely that is
because there is something at preventing any communication to work or
something, so Id be really surprised this is a regression at btusb/btintel
otherwise we would be consistently seeing this in our systems as well.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
