Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF56218D65F
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738004950; cv=none; b=UrltgJqaxjeN79fiknCXkWkMWTB1UtVeK9OOppX0M4+IFnb/f3I30MtO/ZyvuGLzn6NXDss/wA8lHtEenm9E39VUjhEw/TzV/wzIUVfJ4v8/7FzM2BpLRCdpD8Rwac0SZ4G+1py+HQJIQ7yk1hw1LpuRlH7nZK6ep8FddPWeVSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738004950; c=relaxed/simple;
	bh=6GUNZdSVaHMSMzvmmIjA2x5ga4Tg7bOwmvGKeIQ6d/g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qlIDKgeXw6AvaAKJEG6RUcfT87qVXtsxQdj8j+QXzAS9lwUAWFvnvdTJ8rTWOywbnXaX0teKLjIi88UHYKeHjM1GjPYNfZNxUzxg65dvZTxga4BWpckx5QWRbtrxmSBh078Yt88mCI0bXF6g0PKT6TlCpMNzJqOBIkMRG9fqQ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJggk0Ae; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJggk0Ae"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39267C4CEE3
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 19:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738004949;
	bh=6GUNZdSVaHMSMzvmmIjA2x5ga4Tg7bOwmvGKeIQ6d/g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sJggk0AeR7YJTXN+xCWIRRJoh4d2GDazvxRAcsk6uKX8jBv5EIz1N1kswH3zEdCL1
	 upDSmN0p1zv3l9CJ4pWgBZze4TWgNeDIgC042FGr13mHhlIsDhHKGNK/tLYeRWU4Fv
	 fDCwmcVPEjVCEKi/G2Lu/2FQbSnRFYJgKS2BqiS1bTDvhZ+OjuEf8V7Ap36xhc0b7H
	 7OOFA+l4aDy15AeJCKQ0deJ1g2BOb2Z8cBp6D7ZjWn67u5j5h7leCO52dCKYiXMYq3
	 //IMIxR9lQO5rl96XYja9dNBLT8s/8BwUAmCsuoQ9FYVgsH+EABckvaYXy5FjiIT8B
	 3bYehD/UQyfAQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 25D29C41615; Mon, 27 Jan 2025 19:09:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219387] Bluetooth: hci0: Reading supported features failed
 (-16)
Date: Mon, 27 Jan 2025 19:09:08 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219387-62941-54zub48t4q@https.bugzilla.kernel.org/>
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

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #10 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to alexknoptech from comment #9)
> If this is normal can we change the log level to a debugging level instead
> of an error?
>=20
>=20
> If not, can it be fixed?

Well without that information the whole firmware loading is sort of impossi=
ble
since we don't have enough information regarding what firmware file to load.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
