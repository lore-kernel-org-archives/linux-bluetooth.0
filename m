Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5605919006B
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738004543; cv=none; b=TK4iUGvuBw0FWSfzKrprvH4QLLoqLvT7qE1xafnjphXGRHsvneMwTTgloNpCLm/OdwlY1SwumVGHMwfDA9Emt8QR+pKr/i+1pI+h+WLYLKdVXy4K95fHQz8kn3+Rri/QTXhGmM674u03EqKaUICQd/PpITebX4Jy3XeAQWiw2mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738004543; c=relaxed/simple;
	bh=E3iPGB2pYCwokt9u2IkYkCbNvAwaVS4t/pg433sBJLo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TT5TfRTWFzFYIzcIp02A3Trg9YfIHM1XQ72u9XYQ9Nu/E58aXBztxYBKOiPq4etG4pTqDjxXbxziHro2uJdEdJdc136uWQ+F1qJKtiDhreZC1WrXBmxjGfF+g1IYmw/11SfeTnPoWUPJ5SmFCvuR9lC0SkOnwWiEkeEQtYRu40s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfflL2eQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfflL2eQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6769C4CEE4
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 19:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738004542;
	bh=E3iPGB2pYCwokt9u2IkYkCbNvAwaVS4t/pg433sBJLo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qfflL2eQ2sSuaBzsBMjCl6kfVOUp1dLJ2/696zPk0FV6vY6zyGoL6t9MfOKiMqBnT
	 9dvg1vvrfX802Aim6ggPOGdjFkMxVHP0FOBrb7RdI1+aRQd2ly6Y+xmutywonowtZY
	 QaxyOa8ixkEhF4/a7a9ytrXwsyq/tVnsb8HMNvo1o9c39gie+vRqmjPFipwQTPAczh
	 775KPrnT1BM8MaFa/2NR5GebGawwRrF9N+c5O3Zp0nau8qmHElFRjt//NvTq2hc/xu
	 q9uhy1B5HHkykHdHI/hSBjo7xeswQeI4Q8ZsssPaKAbTo81ZSOjPVfq15aVZEWKAtF
	 7IxezVO2L9IEw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B6DCCC41606; Mon, 27 Jan 2025 19:02:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219387] Bluetooth: hci0: Reading supported features failed
 (-16)
Date: Mon, 27 Jan 2025 19:02:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alexknoptech@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219387-62941-yS7cmNH5Ti@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219387-62941@https.bugzilla.kernel.org/>
References: <bug-219387-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219387

--- Comment #9 from alexknoptech@protonmail.com ---
If this is normal can we change the log level to a debugging level instead =
of
an error?


If not, can it be fixed?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
