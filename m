Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B986293B42
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863121; cv=none; b=FiexKcmWGaQpWgKl0Z0usHKeLrEfZCSh3n2lZmQDaxrFWsDgNthxF3citFlFJYUIiSrBs30iDQDS1tP6YDUvbc0wc7Ux7RUi/IpBuxnc5enb+x9fIAAgSoGNlfkEPx44PRgiaU+R+JlJvAJUe5F/17Uut7ROgXfkA1T4BJaUDWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863121; c=relaxed/simple;
	bh=LVN6omaXBZpsovu3HJ4PwWoLkWB33GbX6XmCIZCDCFg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=atKGesb/P56CrFxpHTMJ9ET7LpxVzA0aSe2kFNUOFQ0kUQ3LAkTEvPVuZjuY6uWVzTw6X93MSWz2/u0G8P2mLoHs9zZH7FG+RAwC2MMnPdl4vyE5tOtTq6MFwcHhUuJge2PGIW0D3ibQNPSWHUL75ZGdppFXe5xt1IAnxGkRmyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlaQhGJ5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlaQhGJ5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2C08C4CEEE
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 17:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745863121;
	bh=LVN6omaXBZpsovu3HJ4PwWoLkWB33GbX6XmCIZCDCFg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FlaQhGJ5GSAaGTip6duJVz7UnQc09oi4QFjWJvs6MQn2cXCiI3qgH23CW7HuuSx/t
	 cRvlxbrWmdVQwXQ+tADgxJeZbhLYIe9HCp+0y9qpiRn/88s/zJ/OwmZ8eCkZ9t/E5b
	 PMY3pcxBK1VpAwjU3mFwTIQ4YBOtwbSGxE49sU70Tkf7QonO+dDMTPzbnTZPV6nAhD
	 O5ZMWR5RpRl2ftG9NiJ5lqzGH1CrJSk/JnCTTWzDesJrjMRJVA5lDOrCO1BuTVpDkW
	 bJ3GfSN4MJgZ8DNshB8mUsGM+f6GydQyE1tMxU8erEFUsY++ascWXVFD6SQnHZWs+T
	 G9zYAQ+4+booQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E8355C41614; Mon, 28 Apr 2025 17:58:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220061] [REGRESSION, BISECTED] Multiple Bluetooth devices
 cannot be paired under Linux 6.14.4
Date: Mon, 28 Apr 2025 17:58:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: alan.loewe@foobarlibre.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220061-62941-aujqsBnGPK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220061-62941@https.bugzilla.kernel.org/>
References: <bug-220061-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220061

alan.loewe@foobarlibre.net changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alan.loewe@foobarlibre.net

--- Comment #1 from alan.loewe@foobarlibre.net ---
*** Bug 220063 has been marked as a duplicate of this bug. ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
