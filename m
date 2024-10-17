Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D7F20E302
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 23:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729209119; cv=none; b=GWdqY5cB5fmiTOeQ4gEUcyhGxw/mYqCJZrQJje3LjEdLABbmb31R+RsScEdu1EQMTOjwbKKwUlflEyq0LH3vkSNWp6Is2QnOzncrznIZ8nx/Z/BXUCAnsrQnkafPxS4Mg4/FtqYgGZq92ERjb0aRUR2s2YV11DALG4yPb4fMkr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729209119; c=relaxed/simple;
	bh=WKKPE3lgAWLiTeAWrG7fuPQm/fHrxNoLCSEuXjSdmY8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tSXeg3DgdhD48GXRhLnH1ruTfRpmehtDpRzaWKXKFhvd/quMw4pz38pah81TZJ7Jw9ROBGcwhQRg7uQ9kB9PKDahrqi2Dfpm+7LcOKnCKpStwi9D2JWXOKKEvHC+ukFKzue5q1kEQyHTwHJ2jsy/GwlIYTfl37gSKsqXE0zLJGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1PZBH/1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1PZBH/1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 335F2C4CED1
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 23:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729209119;
	bh=WKKPE3lgAWLiTeAWrG7fuPQm/fHrxNoLCSEuXjSdmY8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=a1PZBH/1pNwV43KkLufZzpUzKGy8K/uU5L0Voc1gyylc7iL39+Yi4T+8bS+BtFTPL
	 FbFRwO5rsDLXnoSb98t5bLbiLxOuKHrEPg2O/3HApdKNqb0ZeYfRBS/hTpa8HHbhh9
	 zJ5+3Xi+4p6VbX4FwA2jAv8C/8iE4qK82EurvoOeFQigNQsZHOFj5ft6ChZf7X3rlz
	 /j9nuPkXVxLejAD67gOEz0F9E5FY2PjjCGMFXnejLpFsHRxMQxWZXZbRGIJz0rz8WX
	 asMgjho+YXtRForHLUUs98+7hUHW2bX5xl+QqkinE4rFShkVBfvOdyYqzFh04/bHhp
	 A2ViurSuCIIjg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2BD14C53BCF; Thu, 17 Oct 2024 23:51:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219385] BT mouse can not be found and/or connected in 6.12-rc3
Date: Thu, 17 Oct 2024 23:51:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rjgolo@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219385-62941-53XRVSyzF4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219385-62941@https.bugzilla.kernel.org/>
References: <bug-219385-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219385

Raymond Jay Golo (rjgolo@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |rjgolo@gmail.com

--- Comment #3 from Raymond Jay Golo (rjgolo@gmail.com) ---
I've also been having some problems with BT connectivity after installing
6.11.4. I'll test the above patch and report back in a few.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
