Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21E230EF6B
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 22:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737636; cv=none; b=SngctVDNbTEDVgvKFdg6qLAY2/OrF+f5s1AzupJZyMSSUpK7Q5lo23XYPHyOOOdddJ2QwOWWmAh2rv1dPsU7u3pv2hWSQggLVtbvUNyQr7zzxiDFSripvBbrgZBU7c/NC78LtJV0LIcpvF4Tf0eYVeQt5bw2H3eGkBrzjiY1YBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737636; c=relaxed/simple;
	bh=lVY1PZQE0SXVUEs/B+cq31IWK997NAKeraTesBMktlQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AJyKNPf+VfJuW8lppsJyt5bx/i+AA9jVH/UaVu1z/aZgNbS1Fhk7xuOtxPJdF8GjEC2kTYNwTgINoBrijLHjyWt0ZynwvDGjpH8ldJOsNz1iDqQOSJ2aqYTqMOoczCyK16YOjA902VjDttCU/dXFjPiupPAabHmQL7hJNmghK9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCdhdjqY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCdhdjqY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 759D5C19422
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 22:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767737635;
	bh=lVY1PZQE0SXVUEs/B+cq31IWK997NAKeraTesBMktlQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sCdhdjqYwSuYrHmmV5gaX27EE2RRWH8IkslFZIQ5CQhfnrbMYu1ZHlM7nHuuZLcFU
	 dcMkWTpeV8jP5uYek9H180aeKul8DRT3bSt4+nUcY3d2B9subhopXbtOdJbeCMnPac
	 /toERnyKmxgo7wh+5TPmJlHrDIz3CI/YfwIWnmDfMoT7qzKNadfMYh4BozWUTJ92VI
	 chgaqWoyR9cY9SSDytWU5Nbep7iT0kiaZ9iiwoHQIygjTEgD3y5uQU9vDv09uLUIfX
	 Sh2Ih1J9qdYLzsSKy8xupgn0rPFDBEGYd4HOwzIegipT9WAl+AZwUCb5e/FSGH0+LH
	 GO3VHLY+Zc5CQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6C0A4C41612; Tue,  6 Jan 2026 22:13:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220564] hci0: ACL packet for unknown connection handle 3837 and
 sound interruption
Date: Tue, 06 Jan 2026 22:13:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jcubic@onet.pl
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution short_desc
Message-ID: <bug-220564-62941-7RxRlFUk2R@https.bugzilla.kernel.org/>
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

Jakub Jankiewicz (jcubic@onet.pl) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|RESOLVED                    |REOPENED
         Resolution|OBSOLETE                    |---
            Summary|Wrong indentification of    |hci0: ACL packet for
                   |Bluetooth in Lenovo Legion  |unknown connection handle
                   |Pro 5 16IAX10 and 0489:e111 |3837 and sound interruption
                   |Foxconn / Hon Hai           |
                   |Wireless_Device             |

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
