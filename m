Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ABF42B72F
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836643; cv=none; b=Sc6yHmkfcUhqhSffoiKJiEt4ZPfP0DGkmdbaIXC3OTEXUo+qF6T0JAOY2myCk2R+9SPDjeMOkZcfPe2m1rGVuGoUPTV873FQOZ85Op8SRJFHb3M0YZcnqKlN1JDZDvUwtBqlC+yRNyHoa4OvA+OLCtkWhC7XlHJO6RfUSVh6Tto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836643; c=relaxed/simple;
	bh=4jYqFgiBTP/FuHoexvw6YCMPu4PIehOhAnHXXFxwjNY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kBHmRGJayFpOuUGi8JaJbpkAqGWn8nr6cQfjMe8GZ29TMLHIbeh7UZRr6cObPfciFnWxmoWXiLMrnmTSyqunIaTLoHrrs6blros7+12LpMChzqvYV36ByM8xryRZvJbU6VXaeolGmlist1em/jHuTmE2ifjwtnh7mrxJgCwColo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I49ASZWP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I49ASZWP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BB5BC2BCC7
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 09:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778836643;
	bh=4jYqFgiBTP/FuHoexvw6YCMPu4PIehOhAnHXXFxwjNY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=I49ASZWPSYheo5/og89qqGCU4eAbDIzhH2F68BBa2AxyFWazywTFNlVZX1xmOwHbK
	 g2qzZ+DSBmk5sxHBHa+ra572RDynYRWQSvjkRUt8JAXy50HS+uADxhOjdZQXLuG3Kj
	 HJ5E+rrlVI8VPgb+NxI6DezllqVmZ2EYCkgDx+ENsNqAOii/paAnANbaAYB/Rw8Hrf
	 cZCGuEg4hdTFvN5Go2fQibNSoHCl9uqIaLv47m25q4uW/JSIv8fIpciS5i0jNsXsuy
	 K2ziU517fZ7oz52BP2wEvWvF1nw5qMLzP+r28gxbGJknBckIRMOjuxvudL90Y9VR1D
	 /DqSOcZgy1Pnw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2152AC53BBF; Fri, 15 May 2026 09:17:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
 (-22) on MediaTek MT7921 combo adapter
Date: Fri, 15 May 2026 09:17:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: txxlc@pm.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_bisect_commit cf_regression
Message-ID: <bug-221521-62941-ic7rY9pfbU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221521-62941@https.bugzilla.kernel.org/>
References: <bug-221521-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221521

txxlc@pm.me changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Bisected commit-id|                            |634a4408c061
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
