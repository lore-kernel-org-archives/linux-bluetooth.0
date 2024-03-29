Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FEF1C0DC0
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729004; cv=none; b=cSpG7a9c3jwK7WzDHB5Lw7gmH/mDJWu5fPQfblRz8euGRDBpwHUkT2iR0Rj4A5/juA9u7a99SOub/n2nnus+wEg2QneUA/sEIDAxSo6N0XPkhLYu3Ny6jCJhZ+dgjLsvNk8EpB4iL0VhdCAe/uEK2saFJvzwMngypLgI+AwNL+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729004; c=relaxed/simple;
	bh=HEg9t+TubEx45a1rMMaK94hxMnDwp4N8zNUulAC8YfE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DrqWseVIpM7uWg+Jo11TBzzg6Pr6UfaxoI1FI1v1hYqSShDFOc0BpJs4S89b4S1xdSjcQcBB6st3rnMMfLM9ZBSKzPfU+wfUch895De7TcZFgp7uLSxWMqWMY2Z0JH2ESydUAcc9TL+bURtPVaf3zYmVZrlv3fH8Wi+eOekGhR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCQNf7wO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCQNf7wO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E41B0C433A6
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 16:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711729003;
	bh=HEg9t+TubEx45a1rMMaK94hxMnDwp4N8zNUulAC8YfE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qCQNf7wOBsN1Fl9evOoqmCfCxN4sWDe5lVWZyHDAYNUy3lVRHtzJSnEr/NB5wC0r7
	 AHBd93+jChFCyOR+KA/KtpQYgaiYV/wCq8C46zERIgX0s47c26A/DmCLjeqq29eHVb
	 poaHcICqalNALkEycAVE2swmYlbnl7o658qcW50OY27nwI5AjZAqE08KTIw0IM/2sg
	 69HdOv1NxuqDV3utBWOcOwdebIKzz48KHsyo7/jkpZSsG+pmy5GCjdZK9B+wxAYbKN
	 JRGufx/bzagtE35UJfGNTNwTROJLoVNbffH7oKukXrll+7523DFAWwbc3/+zfRdhyP
	 jy81u2mFj9LGQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D0FF4C53BD7; Fri, 29 Mar 2024 16:16:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Fri, 29 Mar 2024 16:16:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: agurenko@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218416-62941-uecAghWFRD@https.bugzilla.kernel.org/>
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

--- Comment #10 from Gurenko Alex (agurenko@protonmail.com) ---
(In reply to Olivier Delierre from comment #9)
> Had the same issue. Somehow, after a long power-off and turning on again,
> Bluetooth managed to show up and the message was gone. Using an AX200 as
> well.
>=20
> Currently using kernel 6.8.2

Wow, indeed, after upgrade powered off my desktop, flipped the PSU switch f=
or a
few minutes and it worked on boot. This is very weird behavior.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
