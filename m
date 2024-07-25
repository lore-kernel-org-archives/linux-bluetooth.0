Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A85A5C8FC
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721942940; cv=none; b=ZYCFwH3Pg7qA4G1PTND3GvG8S0nicR8aeKyAUbtMof4cEhaWlBRSEw1n0h5lv1jcVmSJieTZemamPcylCChJP/wYvJzp7d8nVwJ2EkmiGdEIPF0Ka6LW2OwyRt/d3OcR5X9OHPjpiv1ohtpgzzAHi467ot4YOWW/bOSTqjhKYiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721942940; c=relaxed/simple;
	bh=A63PKHafq1lpZtiJBixdCE8YKnpPY+snjSerLUMTQbE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l51HipD6CvdbilOhzSpYZgyDqOYjqWccwnMGEtbTHFponXTlTM3hR0ksFuqCWxg7Cvudr57XMFF2mLTTTiM+bfbE3jA/tXAw3SJkwHkKW/w5Ss2PTjKyn4FuT4gaNbqbMgRo+XSQlpN7cyBQVM1x3ngO3G0Ww7mvLSntngTPHAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTgBJi2T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTgBJi2T"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8ED1C116B1
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 21:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721942939;
	bh=A63PKHafq1lpZtiJBixdCE8YKnpPY+snjSerLUMTQbE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tTgBJi2T8mc28YHQzrKpeUfpz8RfZVtlIcWBUWjwxIHO74R5GXM5Pf4q/u+7h941C
	 oHlM3WzPG5m3cIU3JBOTJJK/ZDj8kwBVl7qE47/DVT+8aCdTY8TDo5v0wZbJwO3R61
	 6qijNXeDLatYjq5W3DCf58xg6npIVFG7NxVjjG9XKGt1iWxj04OoSQz1FF6OrPGdXs
	 wr+pDsmCFqm/+pVC+IKy2kAi0MLyh+fMRFKeeQW16KnLlcBwz6bTLWKw93vKbTE+Jp
	 yVNm97EKEcecJ351tDZZ0JZljou5xJ0OaQIzjYshN9O0vRKtgMX+tzpE0+LZDx2idP
	 XyyiEJs1s9amA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AB310C53B73; Thu, 25 Jul 2024 21:28:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219088] bluetooth scanning doesn't work in 6.10.0
Date: Thu, 25 Jul 2024 21:28:59 +0000
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
Message-ID: <bug-219088-62941-Z1mYI4kAKj@https.bugzilla.kernel.org/>
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

--- Comment #11 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
On 6.9 there is the Start Discovery but on 6.10 there is nothing which
indicates the userspace is not even attempting to start it for some reason:

bluetoothd[945]: @ MGMT Command: Start Discovery (0x0023) plen 1=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20
                                                                    {0x0001}
[hci0] 12.038247
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
