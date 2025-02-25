Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1A8175AB
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499418; cv=none; b=EqnhI0AF4RP/0C6AABXNPP120qOoTEv57VFz3yDiDHjmnTe+rpRgf4u7gmfpowx48pYX3NK1qwcQZnCOD9O4qTdmd51oNJ4qvNvCkPYfx8WqFjEZEVEbFNCgALwySC35Pm4VKq2KYMMOn42+jES7sz5rC7YBej6fKCIJSH7Xc18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499418; c=relaxed/simple;
	bh=y9goY/3ZCVyDkKVFwRu+6BTg/HMCQTqj8tIK+pa++ko=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aOtjPbcGZ7lykGPYlXQmxuExUeOgeRizb04FSUoXBm8PG5bDymg/yaGQD8y2U+R6CGDbDpfDljlyfgdjkeaZGoItOEdz6EchB5BkNU8MK8FWcKoNjpBmpe9/dzUQj+AMiecFdoMdIZlYXliLlHwfnNRMLztHfVM/9JcklOGFz4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIzj0Qvc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIzj0Qvc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A725BC4CEDD
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 16:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740499418;
	bh=y9goY/3ZCVyDkKVFwRu+6BTg/HMCQTqj8tIK+pa++ko=;
	h=From:To:Subject:Date:From;
	b=tIzj0QvcuGKDr4YOBAIlI5R2nggeqSF2+E86xQnrn0k04KdrhAc5hElzISJU4uqfM
	 9CRgxX20gOeXg8POwyRMUsNx8VViu22KESSq3tUvLdvGUeHFl3ToHFJjuVhQZwpWEs
	 67EbuH72E33gEHCSpj4Hqua1f+OY8xcF2WWF+qKe3LnfrqhnxizUoJwRXClmMJymGS
	 kcBIlJwmlwAN9een2k+AOWjdt0VcfU/0Ig0uKRIX3PwGY8SIOakWR5vghzQXgQF4Zv
	 Cut4BgCg6uCL/Kqhnfjp0Amu+VptZP7vt5ABOgjM7tmLtXW38RTcuoh2wFPzA/eWDj
	 GdRBAxcmly01A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8F5D6C3279E; Tue, 25 Feb 2025 16:03:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219812] New: Bluetooth: hci0: Invalid LTK for MAC_ADDRESS
Date: Tue, 25 Feb 2025 16:03:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219812-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219812

            Bug ID: 219812
           Summary: Bluetooth: hci0: Invalid LTK for MAC_ADDRESS
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: low
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: aros@gmx.com
        Regression: No

On boot I see these messages:

Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is
advertised, but not supported.
Bluetooth: hci0: Invalid LTK for MAC_ADDRESS

What do they mean?

My device is MT7921, 0489:e0f2.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
