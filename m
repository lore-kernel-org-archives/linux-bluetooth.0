Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79686215798
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jul 2025 07:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752822751; cv=none; b=SuN6RcXgo7tcDtC7VLjJz2xaE0vGEoMkDyXy68Gg0fCMvmxuQavj+C/k5UxiWfkd8RCzP3KdSvyFHn+o5n/BMr7e/3tbeLD2pfEfoAbs73og2uwcpZ2Xh4IDa1d694wPFOflZ+oRlJvjN842Tw6bTDuSD/dhbh6GtXidCRleeNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752822751; c=relaxed/simple;
	bh=lSzkeMPIqMRW5jmhpfCZcJDyqq08fCU6t1IFw1U41MU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nrbtFbVQdzxZP98TO671AAqxS7xcHIeWpt3b7TcVG9QsVDfRbaqRcAYChO+iha1n0tNMBktYiqKnfBwOz4fjGoOdF4bXCag33e6JLQB8uMWChHgHWTb1DCDuNsRjP8YMnhbCNG9bqgIItFzJXO67h8QsKH8Mc2K+JM7+ln6AxMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvqkKq+D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvqkKq+D"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0394DC113D0
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jul 2025 07:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752822751;
	bh=lSzkeMPIqMRW5jmhpfCZcJDyqq08fCU6t1IFw1U41MU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bvqkKq+DH3WVue/UsO28jqOYjGU8Jc3WQBbuo8Z6Fl/eg09+udnVz21/EIDqk63YN
	 brdSInP4nfbW0Sed2gmGNDkeqsX0SeQFMhaC+Df8/TQ+LndRrL7DJTJg30cmMOjg48
	 BZISKVpl3ChQBScvkc2flWq7nrSATJ/t/FmqvI4C89b2jkKGYYcq8icQOL8FJXuA6A
	 TeE7gLEy7kbmklMINfIqeknwTReD9b0Aj06uPCPo3hmT70Z+subnoQorCxeCt3jAz2
	 RMtz6lTbw+mr506AJGuOv3XGwLRUWYQttuZU/asb6NCkxdEXbaGdJ1CnQinqTcvBvI
	 OWj8tjC/QX8vw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E3E42C433E1; Fri, 18 Jul 2025 07:12:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220341] Bluetooth crashes about 30-40 minutes after I connect
 my headphones:  "Bluetooth: hci0: Hardware error 0x0a"
Date: Fri, 18 Jul 2025 07:12:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nicolas.baranger@3xo.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220341-62941-9fLUulVLgE@https.bugzilla.kernel.org/>
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

--- Comment #14 from Nicolas BARANGER (nicolas.baranger@3xo.fr) ---
Hi Martin

Before doing the bisection yourself (except if you wanted to do it yourself=
) in
your case I would post a link to this bugzilla quickly explaning the issue =
on
kernel mailing list "linux-bluetooth".
You can find it on this page:=20
https://subspace.kernel.org/vger.kernel.org.html

From my experiment it's the best way to discuss with kernel mainteners.

If you want to make the bisection yourself, here is a guide:
https://docs.kernel.org/admin-guide/bug-bisect.html

Unfortunatly I cannot help you bisecting the issue as I don't have the hard=
ware
anymore and I cannot reproduce the issue today, but if I can help do not
hesitate to ask

Regards
Nicolas

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
