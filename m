Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C046614F9E9
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712951799; cv=none; b=JWTXFq8j/6n4HJ89W+FVfTYTlGVxVrRrPbrV0X4izlxZjzr6atU/Bc6T/GtRh01o+YQAtCD8i7sYOq8+y6LW92DSsCQSu1gkmJ7Ze09CcRKqkOqP69Cl+zBEOXOX3UYHM/unmM+yuUtlfx3d/vY9ww60EjyxxX58Vmeml2nz9Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712951799; c=relaxed/simple;
	bh=ojgws8V1QNgQZfwnOK0f6pEo5GMhBImR6/CvH8NaUFo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DHQX+iwLakMLdK3Mh7cbGrNQJTjgHJQrkUCpvuqPcKHqyZnbSG5wNSg936NkiwPk/XiyTELd9J+/QYJua1c0dECoj/pruQ6GygTYuOLW4q2mbyp+RshuvbJKh/VGs675wIMJQQusDb0MqRSQouTilfZCv8JWfzDls0KWYaOWCKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPrCBPs8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPrCBPs8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52CCDC113CD
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 19:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712951799;
	bh=ojgws8V1QNgQZfwnOK0f6pEo5GMhBImR6/CvH8NaUFo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bPrCBPs80GvvbEPEssfToHdmgA3iUN8CqiMU0+/EGHX2Tmr77bLROG8jdIycv5F5T
	 s4UZ2GZ5FEZnHbOpNPuvFoYS8Ajl+wlfgCDnVuv97HecD929S3CVXJrrsR2XB3ZNAL
	 wEC5IiPYEo8HD3AuE3JtRb8AGRmT28iDG/zWHe/OzL2ZkhBbZplz2d8p8lfhILEqbE
	 uNinknhSToJ8Kebh4GhV3Z2aHO+na+4hl5rqVOC2wLfQEKMIq7pgqf4idfJbkhItF2
	 DnBs1H3IFseWsxmlE9N8GS7FVC6CQVMSK1N+qVgJNpoILdJ+iznB9QbXjji4M4k60M
	 wJKMJWo/wTSOQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 454C6C433DE; Fri, 12 Apr 2024 19:56:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date: Fri, 12 Apr 2024 19:56:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wt@penguintechs.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216936-62941-KUiTzgGSLU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

Warren Turkal (wt@penguintechs.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |wt@penguintechs.org

--- Comment #21 from Warren Turkal (wt@penguintechs.org) ---
I got a similar issue with btqca. I wonder if this is something bigger than=
 a
single module.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
