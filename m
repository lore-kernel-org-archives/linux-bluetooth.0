Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B267D41A
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Feb 2024 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408030; cv=none; b=HONdALq20lp6VJCTAqlUbkkupOPMc/6xZhOYqKnaC+4O3DeuTDpo7jTwjBw3r/jNQUYna7nH54e0Xl5iqM2GoFGq7LVLaRC8oIC+u9/RnMJtoN52umzJwxw+Lcr6rlq87tHQ8G3XLNRvEoz2FeYcqEp52tx65d+s9Yp/zKUqJfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408030; c=relaxed/simple;
	bh=t+SXXZOxeYYHJfsdEcyUDh80p14COsyMs52QJGskpoI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SkjifrHy9CiXPEptBb6v81bE7Ribo17RaxApS2pcFZaXI9eJBUIpTRE2NIHW7t0U7JaFezsF77WuRBs8cOINZVz0Ox7BdcA+lXup6PvAcLAvLWTyk4Z4AhArgEYOdw0WU4Tcxd7rJsEvpMnvt9bdMFUivpZxSBBNbZJJG8yLRdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnK/v0pi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnK/v0pi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D2E3C433F1
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Feb 2024 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707408029;
	bh=t+SXXZOxeYYHJfsdEcyUDh80p14COsyMs52QJGskpoI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZnK/v0pixhKSOHvUwAYXaU4RVPnUXIe1Ecgv8Y8VTKi5rGG24r618uJ0gy1fdZ4FV
	 byleTuEoHIVdDqP0jIIa5drOeKGlYzrUoBXOOPDEE6Fe8LZRL3VnNqeFcbgJ3Wkte/
	 IZcWSeXjTYdjZvPkxFktCJONVXyP+af6sIwwubD685+X/AvZE9nogmGA2/iUHbxqIB
	 bswMywCOq6w+YPdq8SXj4bVRGNLYkLTkZrs5mIjvoXp5dFP7E2ZpAdh5PSfmkAVLJ2
	 GF6M7Ot8nkii9lJg1A0XtY724h/tBb6qofe0ia+EQcjocmxVIczReEmN7dHxYRZHAb
	 olHzM5TxJWjNg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 81945C4332E; Thu,  8 Feb 2024 16:00:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218264] Potential kernel regression with bluetooth pairing on
 specific radios
Date: Thu, 08 Feb 2024 16:00:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: marco.rodolfi@tuta.io
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218264-62941-iprrc70YHn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218264-62941@https.bugzilla.kernel.org/>
References: <bug-218264-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218264

Marco (marco.rodolfi@tuta.io) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--- Comment #7 from Marco (marco.rodolfi@tuta.io) ---
Everything seem to be back working on the latest builds of Bluez, so this m=
ight
just be a Bluez and not a kernel regression after all.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
