Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4476CC2FD
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662978; cv=none; b=BSw8HCnIJC3B/cMOSzBmmDhSR/qQ/w881A8w5HnnmHIyaAx72+d/cw6PQWnXOUkbo1mC5FyD6yN6gjShuCDpVm9/o8mk+QqQHVIMF1w6j+6V56OrcBc+brFKFLIcsUkejRGpEdN/6xA2fKNcdORHQuocETtgLT7asE3AXa3tpiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662978; c=relaxed/simple;
	bh=pB5Ti6lbyP6qAcVcLHohXNsnyaER5nXfuOfXjMO/ZwA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kpp//nu7PY935K9Lr6bED6hGI6i/h8o2ywG8ABaHguNWlH9k/xxaYTudhaYDsT8KkPTGCOfYOQSYIV3OLhSSfuTUkAYUr8JabXCd6ZHGyVPPotNsA5+D83RUwvFd5L8YARSjLkRweOE94KTwf3h6XPwK9WIjviUiHWsL++cM4bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6s/1jQ0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6s/1jQ0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB8D8C116B1
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 15:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721662977;
	bh=pB5Ti6lbyP6qAcVcLHohXNsnyaER5nXfuOfXjMO/ZwA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=s6s/1jQ0xSC3+qtNfNCOBQ5GS62vLkYNNaX+5vDq7Uoz3mxNfq0oJhDpW/n6vjLMl
	 h1VxW5hSfTs/EEz4PEaIZ7VJK4ka24mA84t37Tq88KVP50UD3TOGKw40EPBVGVw7Tw
	 xfmLOBCYdzp3b3p8tf4+ZcQOr1Vdv5dmT2y25F137wqRVGmGFwCOaijsmD1zVHQeg9
	 7n0L69jbHfsCqOA/En7OAQeDgv2fT8+VbaBjEk0ngkfaqJcYOwWbOqwjlCxLPRGAax
	 7k9wVhIJBtteif5U3/Jk4mi392vCGP970/ZXK7zix06Rbg3Nnu5dDFZ3EqhIbgB8kA
	 RmsuG3AtxaL/g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BC5ABC53BB8; Mon, 22 Jul 2024 15:42:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219057] dongle bluetooth does't work on linux mint
Date: Mon, 22 Jul 2024 15:42:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ricardo.andres.riquelmerios97@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219057-62941-khYDcCuYCq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219057-62941@https.bugzilla.kernel.org/>
References: <bug-219057-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219057

--- Comment #13 from ricardo (ricardo.andres.riquelmerios97@gmail.com) ---
I bought the brand tp link nano USB adapter UB400 , and now is worked so it=
 was
the other bluetooth device the issue not a bug , thanks for the support

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
