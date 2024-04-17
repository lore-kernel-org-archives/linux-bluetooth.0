Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12E3EDC
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713357319; cv=none; b=Xrq1TMlr3WaewvV1XuYhJ/fa15oOYY4rITcBYiqmbG+qjTWNPvp5hg1OQCOwXyevnGjGUVeKyuAy+Rx1EhMBtaLY2KFf+QDpRtyeEdjvgyzCuYdvPcbfEhm+EZXC96BlOeC/pduB2OcJJI7e/ABKQcg1RqwhkZfCV9tg0lxvrFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713357319; c=relaxed/simple;
	bh=h2LLVJQR4aRvkWyp1xMmoXfLLcBZ0iI5wWy4qgMPVGQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lcfp1gNXD1K88tMXQnjxcR523u5YTk25pNJzPTMbRvJQskEU/b8pr235oggQ4ZHdcI2gp1glj2F3R3NUah4butIgf6LJtWoLHdRUIZsDEWxd7G9zleEiJct26Ie4p7p7W+E6WlISVoDzWqY95Xgr7uYWaT2CxLOALa2Hc+wFcB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiI9BAJ+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiI9BAJ+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58B20C32783
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 12:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713357319;
	bh=h2LLVJQR4aRvkWyp1xMmoXfLLcBZ0iI5wWy4qgMPVGQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RiI9BAJ+ixZLW43JOd0ECIax1mpLKii40QIv4yfu3hS7AogzJ0LOIMNR8OvSJYVKB
	 L/LHrNSeB3X9inkTjG9OD0UhGczgVHo/3zVDRELEG6/jRipCFw8oUGgdjw5/zM1Fdy
	 od6Hch/jMnQzX75lj2KoPlfrsoyPklTXTWDJKYUVdkTXnudIuquJmoJGFsfpWnpgOt
	 Ht1tCjiRZvx8vrQxPkscEuF9SBHN3iDb1y6ajhAP+ldIW0jSrCFjV7Xt7RAM01I4Bc
	 tQIyCiPZrHHPWwUs+H2juOclSOmthNSIwCls4iPlEqhgcXeEBn73RK2xBOmNOl+6XK
	 DF2fy01N+FqNQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4B4A4C43230; Wed, 17 Apr 2024 12:35:19 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218680] bluetooth connected status not shown in KDE desktop
 GUIs
Date: Wed, 17 Apr 2024 12:35:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wolf.seifert@web.de
X-Bugzilla-Status: CLOSED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218680-62941-wrSUiNnjJV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218680-62941@https.bugzilla.kernel.org/>
References: <bug-218680-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218680

--- Comment #7 from wolf.seifert@web.de ---
I found the fix now in linux kernel archives "stable 6.8.7" (2024-04-17) and
"longterm 6.6.28" (2024-04-17).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
