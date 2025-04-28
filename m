Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC99D2797B9
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745853049; cv=none; b=i7yI69GBMPb9aO7cZueLwLb+93X5QS0UaBrew5bzwej4kY+pswJDZH6z8ndnGK/r8AGs0iSdCYWJhZLAV4Mq8M5sA/32euZmOeQzDA4NDp1IoE0/tAFnZtX8b6dKYlo2pEZ2kPhgY0+SSpK5NozUbeIOZgXFrZfD26Z4LSJz/7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745853049; c=relaxed/simple;
	bh=pUxVtvuDVc92hrhFoykdahJaFBL9pPeJxyd8bgCr288=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XqV4Go6W5p6z/QaZOKgvLNuaCL/JE7KXkxej31sGQQ65Qh3Pf6vwtnefsbtfPHQS8yH99YbfpDbASZM4tllLppOATnF+/n93X/76fySXtqGZklQVZhDcKsn3TiNAv1/8X4dgVFWWKIgtzllejoCbWKyLdtR5bW3jy9pRnbKhmyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=do2rwhKu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="do2rwhKu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68E39C4CEF0
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 15:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745853049;
	bh=pUxVtvuDVc92hrhFoykdahJaFBL9pPeJxyd8bgCr288=;
	h=From:To:Subject:Date:From;
	b=do2rwhKuNS1cpweUscLXKg5Rvhc/2o9rpWC+yjHdXDnmfOiL26AXPSGkMAuuxcIOp
	 y/1eOrjU0AXyOHKWnwDJVsym64AASHTJwjDEe4zCe+hOTh6OvFZWADWecuGxVRIWso
	 BiSwo2k+lePfqKaVh56R4OLg6JfuQWszk52aGmxQfxCOLP2EHiCeRNqQ9+mjrJ0Q2f
	 CLp2vmrvPakO15Dw+FwAsFHBRrKKkBrM+qiSY141uipFI86uR9u3Y3N5BiyNEp3+Xc
	 sjT6mGX+JbrC/PC1u/hA0auExipUZFycWuv4kSOEgX6QuGd3RKzg3t6cPXd6fGh3M8
	 AcVt6WQ63gd/Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5B2B2C4160E; Mon, 28 Apr 2025 15:10:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220061] New: [REGRESSION, BISECTED] Multiple Bluetooth devices
 cannot be paired under Linux 6.14.4
Date: Mon, 28 Apr 2025 15:10:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220061-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220061

            Bug ID: 220061
           Summary: [REGRESSION, BISECTED] Multiple Bluetooth devices
                    cannot be paired under Linux 6.14.4
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: blocking
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: aros@gmx.com
        Regression: No

Bisected to d4ca2fd218caafbf50e3343ba1260c6a23b5676a

All the details are here:

https://bbs.archlinux.org/viewtopic.php?id=3D305211

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
