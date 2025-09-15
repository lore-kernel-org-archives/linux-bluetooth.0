Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13671A9F89
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 18:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757960605; cv=none; b=ajUrDWoSbisCcKredfPbj+lRdLnrhDVBIZWQrbEU5G/VkOMRiDiqUhcRDg/O87+p+1PCSuho1c2KEAVm3T7d1ANT2ogu89aUS7eZoVfT7eFaTx5H/uOJL4Km9YYRD+c3kxTnyaRATRD1MUwN4nabn6MaHzPqUF4Ax/sBavF0IqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757960605; c=relaxed/simple;
	bh=PHmj45WCf68WCdhzsaRTT8lwgXCo8iSRFU4Bt9JChRQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fMEJkt0bJLSWNBUTKQ17BcY1t7Hd8670uy63amNeNwNr/WmhdoNhhn0WGLcBuhucVmAy8c1FFP52o05HcYLBKWwCSB7lTZcCf9si7y3A8JQEqayIx/T3MpmK833uNRo4X44ORZJe3a1QnAj88z46luE9koA6/HviBZN6Ff/xSdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqeDSfeX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqeDSfeX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86A4BC4CEF7
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 18:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757960605;
	bh=PHmj45WCf68WCdhzsaRTT8lwgXCo8iSRFU4Bt9JChRQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lqeDSfeXNUB5OXtJiNmFQCVRYdl0If5AG89Xc0rV7WxOatEm3m/2I9j05seCyieK8
	 Ml+hAOXOv9dBmmIynYOMclg1nwZ9tHV9YG6EM0p5VJC/K72q86GXE+p5PP1YMLNlXU
	 Xht8hzhY19S1Tjk2i6ai8cj0Mm+/qIZXzwHydn1znO33qixtOporna+EOfCbERsMkv
	 k8WJHtbc+yH7SGX9tNjIFt7jT4rxtSse7XQ+IV389yC1kUbp4PcJmLiUE1G7c16MV4
	 Gn6AIR/JP40psIL64xuVVgQZv9233sZVKsqGCNiyPt054ZSvm3TfLNgP1FTZ+mDo1Z
	 6WOAwKOTTBTWg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 77D89C433E1; Mon, 15 Sep 2025 18:23:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220560] Bluetooth adapter not found (MediaTek)
Date: Mon, 15 Sep 2025 18:23:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mattias.ohrn@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: UNREPRODUCIBLE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-220560-62941-eHowbBZRx6@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220560-62941@https.bugzilla.kernel.org/>
References: <bug-220560-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220560

Mattias =C3=96hrn (mattias.ohrn@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |UNREPRODUCIBLE

--- Comment #1 from Mattias =C3=96hrn (mattias.ohrn@gmail.com) ---
A strange thing happened. I didn't touch the laptop during the weekend but
apparently there was some battery drain because the battery was flat this
morning. When I plugged it in I was greeted with a =E2=80=98updating, pleas=
e do not
unplug power=E2=80=99 BIOS message and then it booted normally and now Blut=
ooth is
working again. I have no idea where that update came from nor what it
contained. I was checking for updates with `fwupdmgr` last Friday but it di=
dn't
show anything at that point and it seems like this have happened to others =
on
other distros as well
(https://forum.level1techs.com/t/the-ultimate-arch-secureboot-guide-for-ryz=
en-ai-max-ft-hp-g1a-128gb-8060s-monster-laptop/230652/127).

Anyway, since it seems like the problem is solved, I'm resolving this ticke=
t.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
