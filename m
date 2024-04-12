Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4E5824AD
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936054; cv=none; b=XijfpbrKA2PzeY9nGvCaK6JS8PuIi8KOsGG1VnGAlRDTW8FtEB2fv1sOP1DEIi0U276kmGWcrOx+BjoVYVwS2Y8mvFBgMhNTwKMivazBjf68mpXZsGkFsXKoo4gvA0/q3KvSNwfSkAUosQhc4T+5w/lhz3dXAQj4z/+osIcRtg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936054; c=relaxed/simple;
	bh=Z3MW2YF0NBb5UWRU1DCsshuM3LZPtB1MEqRHbQoSBHU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ujKbjPYrWQQO0Tfp2cM2SJbzKwXKwhzvswjFrJL9qhgF+FN7s+e5StOsb2JWgL++7Jd0Gw7FsXuWLU2KxZNyhx/MgaeDQzkPXjI/VfPX0CD5TbiG/t8XzKaULr7Nopcp+/0cASOEEkm3O20edigq1GGar6BW8AcBWVHhDBbfy6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5mn/e6p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5mn/e6p"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B511AC113CC
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 15:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712936053;
	bh=Z3MW2YF0NBb5UWRU1DCsshuM3LZPtB1MEqRHbQoSBHU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=g5mn/e6pwCuag07eqnlfaKv0VD9ZSCat8vbVx+foIIjAPkMxfACjBTSiYiTjKG5Ao
	 lKjRFCDURmxf2HyGoB8ZTixWPuZqz6ImdEUkOY93ezZEqvh/h0fRSFJdAFfJ/IPAjG
	 Hi4IU+PZEomORIM3LP3q2Z2fgV6STirW73+gIG3Hk6XTHbxXDKAEfo0qrQ8rq8I6P/
	 vriEqm0en3oOaQX5LTp7l9cftm1n6XTFuBPWLCgGvalkxHgUwwSMmyVLohPpoUGo1/
	 4DuwVMcK8fQ1UA+17hdkkbysvc27Ch6501l1Fk1mdqREBy4Ewi0JIo+oOvLSq8fvPw
	 gPqdWyqEKGMmw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 94319C433DE; Fri, 12 Apr 2024 15:34:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218717] Lots of oopses from btintel
Date: Fri, 12 Apr 2024 15:34:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218717-62941-Y3NeQVci28@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218717-62941@https.bugzilla.kernel.org/>
References: <bug-218717-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218717

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
Can't reproduce in 6.8.5, let's close it.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
