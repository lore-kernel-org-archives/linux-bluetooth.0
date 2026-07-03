Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B84D54652
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083274; cv=none; b=u6ZiUFRIzvA99f7LBkOD4+5ggm4fmRxRGSBNcPXCk5pVm2Lw2JTAbgDSopQ+1k6V4XyKSqPyO8NkbDnvFp7EaKYYPO57Ep+3FSBZ8jO5wTxVt4ilLs+jy+M3nDPcf+xbnPS84zMQgDCsiJI2akfYPLUsgkVpOmsFiJeVxeRW2IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083274; c=relaxed/simple;
	bh=H/584pHjSOYQGbNzna9njapxSPr+B9PE9U0tz+/ZAxY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AzxefpkpuSNislZThg3XxZHBC41quyA1gvxpEaHOZTEp9SEE7iLAr44estPwLZFFrulBrIkNzZiaipwvRpc9QjFwC7vFe1PFutHf4BIlJfEGvDc12ZoHvQHc6pQypRFF2xFV6vsdY5tINdi9KsachycHbLszcqgRtd3ABts8V4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqlp3gi1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqlp3gi1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30637C2BCF5
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 12:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783083274;
	bh=H/584pHjSOYQGbNzna9njapxSPr+B9PE9U0tz+/ZAxY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dqlp3gi1gM2K8OVhzxcTPQ6W7nH76TaGgH2DjH3od4o4Lp5Me9zZEZuGJB99Qzlw3
	 oDbmM547/1k+P9GSv/GURVlTJPE096P+njua3p77mdebCXq/GGn98rfj2oqNr8NtKl
	 nQNXdstPrcYQ0F1h3YyV3onWzDGupvrxUuI3Jrjp9vbNJfgazM5TfSTikTaVhHxKcb
	 bVK8KSnfzYwhN/ISmuhQ81p+I4RNT1UVl2txjidI1NEsrl1FWF0C5HumqMgezLHG46
	 CtlmbBTEAdiHovURtUt6VQo2a0SwL0r/0Kn709qIP7OUgP5HKvL9mtX1RQncUuwssz
	 F8OQXauqHO8ng==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 15877C53BC5; Fri,  3 Jul 2026 12:54:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220564] hci0: ACL packet for unknown connection handle 3837 and
 sound interruption
Date: Fri, 03 Jul 2026 12:54:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: robhogan@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220564-62941-sDFQIjwC0a@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220564-62941@https.bugzilla.kernel.org/>
References: <bug-220564-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220564

--- Comment #17 from Rob Hogan (robhogan@gmail.com) ---
A factory reset on the speaker appears have to resolved the sound interrupt=
ion
issue for me. I think the 'handle 3837' messages have stopped now too - non=
e in
the past couple of hours. I suspect (although it doesn't make too much sens=
e)
that the issue with the speaker was that it lost its wifi connection due to=
 a
password change and this somehow started the audio interruptions.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
