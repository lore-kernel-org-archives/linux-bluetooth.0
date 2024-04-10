Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527F517F39B
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 17:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768922; cv=none; b=RG5jQPa0KfUITmCxyjlYtg8jZ/ry29wggWYkulecNQSg1Ffivd0rq6dytVtqH2oRF4KNPkOzBSj4pMqyUnZ+7sv7gOATzZRiRDIRCiDMAt2uIouhG0ZU0qItGuyZiy8lkmXqVhICQyN6ZiD/V6fCqcC/mYxGhYASXLLN2JMeE9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768922; c=relaxed/simple;
	bh=EgEbh9xK9AG/Wq1PdyrsOJ/SJDZzKZK8s5YB+lW6uAI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KeAXPPc3lpccbWlvRE1Cf2dEAVfqxJomqyvzruqgt9lpCfFH20/zY30WmDbz0FSmBz0oSsi6dNb9403v7trLgFpBVVveX9ntn3O8KVa9hnyEFUepRxGFved7UmHkBNUJImmcW1Cx2mpYXVkVfU6jblJ9Mbh+ZDldFT1V8rG+Jik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2JWIfom; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2JWIfom"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9AC6C43399
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 17:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712768920;
	bh=EgEbh9xK9AG/Wq1PdyrsOJ/SJDZzKZK8s5YB+lW6uAI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=B2JWIfomUB50D7ahUPoCGPCbxkJRgFcKYFg0j7224WtyXfNXFIBSdQgBby3zsd8aV
	 KtzipRMKpuoyi/oDDMj+Vqd5991PUFF5mx1NE6cvR81B9h/jZ6s0cSpyBcxTqD0asn
	 +KspSqE3PaqhZ9RcAsHb7QpR7l8FYBAjTbzDuiiYy/1dutwyMvNLIvl/Ww95nGC1Zw
	 JbIe9o1GljGKAv40ANhYXifzPdeZOEyEAdn+eppDUdwRgusQm8/eEQNp8KbVuoxbnc
	 7Ml5wMQXogc3Auc6Zzu8ESymXRIwS9NYcVPzwpQcJm//9yV8pJQunMoKlD00HLT4uc
	 v8uuSiRUeEIRQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D014FC53BDB; Wed, 10 Apr 2024 17:08:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218680] bluetooth connected status not shown in KDE desktop
 GUIs
Date: Wed, 10 Apr 2024 17:08:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernel-ODwfxu5zp4@maxxor.org
X-Bugzilla-Status: CLOSED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218680-62941-w2ccd5y1LB@https.bugzilla.kernel.org/>
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

max (kernel-ODwfxu5zp4@maxxor.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kernel-ODwfxu5zp4@maxxor.or
                   |                            |g

--- Comment #4 from max (kernel-ODwfxu5zp4@maxxor.org) ---
Working for me too! Can this patch please be submitted to the stable tree?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
