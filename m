Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9FC15749A
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712692665; cv=none; b=rBPjGtvGA2IVOoDuni/4lTlRv/nkWDkCfKQ+C0wYJgAeB2RvKt+xS1p7EGmPR89Nl1ddtUbv72slDz23RgREKYAKOs1rTxJ8mCJCSoNu+T1poiDLuwX7S5HPqFuk7R3nA1KbBzI5GFVmYMr/YAeD+Ze7Evxa/riyKXRci8U3lHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712692665; c=relaxed/simple;
	bh=XGJvWovINBZnVbONsIxFDcucJijow2yZESyDA0ucHmk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=paf3y3WGnzRLhJFNoVo/bMgNCPkwAZoeH1NJb2in4Xn2ARL3yYTzdPZifhiSTAs6Y63hnpYlqYkVOMKK9/v6nP+Ecj2xSwZbT2DjYtQZzq8qxu4umg1CLdRYFONYTr82MjSLiPAUykOnpCoxFMJCvwpbWpF4DTKLEpWwCLc7It8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STtrTiwh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STtrTiwh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24C43C433A6
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 19:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712692665;
	bh=XGJvWovINBZnVbONsIxFDcucJijow2yZESyDA0ucHmk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=STtrTiwh4EvMONF56TuZkD7wOyq41l1C+skWYZGoCZtwzhbWElEk3lVfUtwFooaHa
	 1ASfFDxnAiNbh7Pyit5Auw0Kt34mp87n0bGsKgqy9Azsp8xaei8dN2CYXV2zNKlvn3
	 Komu7Z61Gkf0eElUB3kogrb+Ys+h06+4hJgmL2DUHPhg4hG7s6VVNRJnaPuGIaYR5/
	 FJcCLVyO0O+nTi7Q6DD6/ThyPOmoCUBT8pXWSSdsriFzggbaieLqI8SdGUoZwghNhb
	 9T5LGhaXjIKDiSqyQV6IoyF//r0yx9kNBQPboGuqkdkbRrOEg3jvRlW7OvyKbvbpYc
	 ysLmE1d+xwUsw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1BE20C53BDA; Tue,  9 Apr 2024 19:57:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Tue, 09 Apr 2024 19:57:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wt@penguintechs.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218416-62941-vHJrJWYcuK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218416-62941@https.bugzilla.kernel.org/>
References: <bug-218416-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218416

Warren Turkal (wt@penguintechs.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |wt@penguintechs.org

--- Comment #24 from Warren Turkal (wt@penguintechs.org) ---
Does this have any relation to the message I am seeing in the journal logs
after warm boot? Namely this:

Bluetooth: hci0: command 0xfc00 tx timeout

I can confirm that I still get this message on a mainline kernel build.

I have started a thread on linux-bluetooth with the subject "QCA6390 blueto=
oth
doesn't work after warm boot or disable/reenable" if that helps.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
