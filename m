Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BE92629C
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jul 2025 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752926803; cv=none; b=YgwEFUxT8F0rn0X4EhtnATXLHIHLIWZAnX02JIcS1bfuc2XIdqVErR4hDfWeeYYYOFldUl2vdjGpvDFLiYIGoO4GGf4oadeFTA1X4LAOgChjsgCpUcAELbJDp9gDi524Fn0I4anpfG3I7cZygrmDYuYyIAulxBTStXjuwmDao9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752926803; c=relaxed/simple;
	bh=VFW0K/geB4LCKD8K9EY/g7SE+ykrNgwMJTzIQVPMOzs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eYTh/xfnJDjyRCBuGZEgFU1jzXwoOMODLZBw+HtzDCpzkOySb20oUo5c2UsjhaOFNHzwC8oXI/EwQHoqBVkI2eUV33zlOr8iuJWGhJ9kjiQu80znGeo8izwj1Fcn6QqOZgi2DUu/FWFiYJ/Sz+JDM9NXRQCzGakLHycDPI34z5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPxRKa3r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPxRKa3r"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22EC3C4CEF6
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jul 2025 12:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752926803;
	bh=VFW0K/geB4LCKD8K9EY/g7SE+ykrNgwMJTzIQVPMOzs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aPxRKa3rFzJOQ0/VDpjxbB5o0NuWQHQ42EzJKhxeo78BJ6KubTKpHww7G4WuZ2SaZ
	 PcJ35qiY6CY9yxpVRICxBLdj82HX8G0X8a3QMISyuUbZCDM0o8fydFjaE8vD2I373m
	 59hQAvYoJfyemoD9rKmmgjyqcmpV9gYMo9nprOJZpEUkAtlcRaAb2ApUrb/5ldOpvq
	 ar4IY2NHIen2AjyhsQe4HtMMUqMkmkKCzJ0PifPDWJNfMKT63pdeUk+hS61Uss3XCD
	 bOUM4Jq2hghsFSxQ9uhcH90ki0shZFQ8cZR/YnhtBrji7/jOcgijlb0tIdktB3iuK8
	 RKzWsb/2krI9g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 17C00C41616; Sat, 19 Jul 2025 12:06:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220344] Intel AX211 bluetooth randomly disconnects and
 reconnects, started after kernel update
Date: Sat, 19 Jul 2025 12:06:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220344-62941-qCkgDQiLzn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220344-62941@https.bugzilla.kernel.org/>
References: <bug-220344-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220344

--- Comment #2 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Was the Linux firmware updated on your system, so you actually need to test=
 an
*older* firmware version?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
