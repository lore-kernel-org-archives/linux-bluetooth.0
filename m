Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ADA3B0AF0
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Aug 2026 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785745502; cv=none; b=Kk0AWDDv687nMnriD0AvySzEVY0ynVURfZVB0o3rHcny0KUzWWvjL/KMHpC/OvbBS2J2EUGi426a98oDBsgMxzHSHZkeNqgcBVahNX2E5uQLFK1clQTGFvVrn866+Zc/zn1AcRSovthHTKqIKZqASeMeX55OQhoj+3JNKxd7L7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785745502; c=relaxed/simple;
	bh=9oFyfBCxsB+yz1X3ce/nqm/x9oevRJiWut0iyrTPSmk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wc+zItbhdwLukd2DZMhgN96MtmPAb6T6C3wuxky/RybUWeQTgNnfqJqi3SeLbYZ+929hsyFlNS/fvD9z3IvHgrvUJDHU4vhG4r9Gx89837cGsOqnX+Ia4bvbDJWZlxC6lOZFtH5rxl4rCCdaQXOknaY3lCATCHh5/iS/+Klextc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8HIc5Q6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8HIc5Q6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67BDEC2BCFA
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Aug 2026 08:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785745501;
	bh=9oFyfBCxsB+yz1X3ce/nqm/x9oevRJiWut0iyrTPSmk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=i8HIc5Q6dskj0Hb3de18w8+/1AxMt9pVeX3fwxdKUeJ690V1Tgy8ahbrmN0X0P0Az
	 bgo/kkiUdhvoURhQqrGQTWLWkTxpSvfjvhW4IrdMDcvqgqHvr3JjYcy5IIMOpNCwa6
	 lMGYrG7q1KTV8WrKFLZ2OTem6i7qeUd5T/1YgHySrJ3BrLV4xel9qOdBte+Qrojlaj
	 uFUX9FKtqDpp3YKH0QrGL9GztmFKFTknjomu9JvKimH7jOJ4fdI8sm+XtD46C8I/Lm
	 puQlyghWihKCpCntYE7Qn0HecNi4lB8Y/TNn615hNiU32CFXop8yyL1sgXxaSqQ4K/
	 YnF/ka+/QL7vw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4B549C53BC5; Mon,  3 Aug 2026 08:25:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 80791] "Bluetooth: hci0: ACL packet for unknown connection
 handle" must be hidden behind "debug"
Date: Mon, 03 Aug 2026 08:25:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: webcapcha@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-80791-62941-8xCXt1KPiU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-80791-62941@https.bugzilla.kernel.org/>
References: <bug-80791-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D80791

webcaptcha (webcapcha@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |webcapcha@gmail.com

--- Comment #15 from webcaptcha (webcapcha@gmail.com) ---
Do we have any updates on this?=20

I have notificattions on journal errors and this spam me so bad. Every 30
seconds or so I get a notification.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
