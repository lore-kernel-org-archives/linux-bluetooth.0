Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302757;
	b=xEUDjhygtoj9jNn4+AaCq6NpZgUKVcdupteA9pMdCAAcLPbN9/lWfGDN5kG5elJFwYOL
	 zE92+STXeQCo04WWgDEZ7zqBsgMoDGxBicHP+HGdgK5/cbDiNgqN0QOGA/hwyH6nUUE0Y
	 Ax7zAdCaymg3oBrMlX8lK+emhIKZNSvkGk3s4o8k5uwm9UApy4V2jdKhQx4NCwpMAKmKQ
	 zobYgrFjzKd42hVHiVS3fREBvtJXfg2pm0TF0mMYUgpxFed4tO0DjCwCVsAkS3ZT4l4AY
	 WjtEo3Q7qc3bYE1hnCFseOQzrIKazkmKeug6R20RolUmo93XvBn1EmRU4ZZTX40Jq0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302757;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=nfHCpUB6RLTBtGYXM2mrGMFmyuQlXJSIZq07W8ibM9Q=;
	b=WaQ48VVVBibCaCTR1d/BtborKt7Dx86a9ZAav4fToKAEaIzWZlFAaru87qACjNlF/FLy
	 V8e5uHsJCu9eQd39W1a816EaZMtzk4xJoeaZ6KY2UiHdUJT84czL0WQ5+ulzAXvJQUPgv
	 38tK4fpK7rKAUWvFq4Ia+Y8sObHJxW/h3QKccqp5dXCbMDR09yu8weBya68d+2gBagyFr
	 QebgtBF9/oceglfn0ynxAcud852kDPJFQdxhy5R8iQ0SNDGtBXsSTR6M9Z5Hp3SIER/y9
	 9wDKb0C3XdDZ2RYy/0hSPLxaiMfwdKi+UHFuV8AlVVoYgRcCAMSrKdjAZE8vcKrBNuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y+zzIdlt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576FF606B15E
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y+zzIdlt
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01D8E1F008A3
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 09:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302757;
	bh=nfHCpUB6RLTBtGYXM2mrGMFmyuQlXJSIZq07W8ibM9Q=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=Y+zzIdltN7+Bp5SUZLBpAjTtoVeLd1YS8f6tqfWdagtqpIlFbVtKEvJLWITQaJ0Uk
	 s3YKxdKoPlyitkfIw9QZ52CJPqMtIK06us2n5UzYCdIKSiDaM0y6IvYSaxoe/h/gHG
	 r0olDispv21F8TdmL7G0EQ4allG2q47f1QVyjIBaY3hc/hFZlqS+wHgGukMW475Xah
	 7ELZX4xpDuXXY85CFOtBJGCNWl+SdKv/3NBhUAfDcDq1ahatg2hf2wd1H4vrNXysll
	 0T/ShsUqi4yHiid0BlxKYzVqOUMcL24Ja0Q/B6Fv0aYYG5lOzwHfPtvk7tS+aQAJwD
	 akCLW6HhQvx6Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id ECFC9C41613; Tue, 10 Nov 2026 09:25:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222250] v7.4-rc2: Bluetooth: hci0: Opcode 0x041a failed: -22
Date: Tue, 10 Nov 2026 09:25:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status
Message-ID: <bug-222250-62941-EFb5MehDNh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222250-62941@https.bugzilla.kernel.org/>
References: <bug-222250-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D222250

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Since you're willing to test development snapshots, why not go further and
bisect?

https://docs.kernel.org/admin-guide/bug-bisect.html

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
