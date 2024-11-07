Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E727215C43
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Nov 2024 20:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012446; cv=none; b=GKUelRxlfVC9R+Bnn4pVG6z74Sv9g3yddpBW6wnMEaQIVG69YYmgyusMFE0lTTmgfsuP4NlVkK0OyVAg99GhAeg0F/KzqKcHOz8h394UMiGt2GDmgPHXXvvsCaTcDSDv/QfTwRc7nuTX2rx4jEqxm6CYz4yegiVRowZFGCTwIhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012446; c=relaxed/simple;
	bh=w28itLSQlYGzpokeKs6FROJaQbhAOwTCVfxP3aQ+aKo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sp1EBxzSFAcKWlL+Qa6CV4SMfZ8mhr6C4/0Oc8oPuhZW51jQ6LodnOCN/EreRt6jK4hSlKR6JC5T5NvxkSrTiBbF6dFicOxHBOtJ8Kwrhx8xTmiWYcDmW6jqgYOh7oQgkyZiHfMFyr2fUjHWlyJglfqMmLQDo9254EcvKizndNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeIm/NIW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeIm/NIW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3152EC4CECE
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Nov 2024 20:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731012446;
	bh=w28itLSQlYGzpokeKs6FROJaQbhAOwTCVfxP3aQ+aKo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JeIm/NIW0Md+osg3x55AwHGV05Cxk9HKPEeKJWCtXWUMyPZcpueWmTtznJLO9vnFA
	 qK5LOgAWXDAQWxaRQz5KzV93U4gliz/Cijaqri0HWPvuMNSIRRnKKz2XPF42y39TMk
	 vZjOa5if7QHjezuXzsf+GAs7R4iibQaAOXzkAWDsKN9nvwE75aINuF29yxj1fdhZ35
	 uu7NPYcERv7EDdYnTfp/wjMQ1V93rPYQ3igM8Xka+O4RZoRPhtmDrWsYcMZzuhhplU
	 PBQpuT1QeAFRwjM81ejy4E1ZHwbj0e/UAbAQTKltDAwyq5RUJG+6SHdrdIBTbNL7dG
	 JurfeD1lQQeiQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 29008C53BC7; Thu,  7 Nov 2024 20:47:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219458] bluetooth connection fails after L2CAP: Fix uaf in
 l2cap_connect patch
Date: Thu, 07 Nov 2024 20:47:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ghibo@mageia.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219458-62941-0HxiXWazTS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219458-62941@https.bugzilla.kernel.org/>
References: <bug-219458-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219458

--- Comment #3 from Giuseppe Ghib=C3=B2 (ghibo@mageia.org) ---
Created attachment 307182
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307182&action=3Dedit
btmon output (connection not working)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
