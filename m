Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C671F1921
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 04:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747197135; cv=none; b=c7RBkzmQ9/Bs1FAbhN2Ug8IqiCFhUcKSd6y54fndl846peD1YkAfXVIB7hvNDOwXgSQ00ACnEmllMed1kE6LoZVfHhaVWiA94sHncvO7YNCFBC/u2izkKWQrtWesN2/yLsLWkIbYzz0udCWDYP/E4nEr+QwWYwAgWMhxiJ7kFsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747197135; c=relaxed/simple;
	bh=2ioE1gCnNQs7zLR1SvVaQgIOUw+qqKxSSGao9KwFm4A=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uuHYywRJumYmJrNh0e0FU8EDqHaMnoKDALNVkPOm7p04j21uZTyzEBB9P9ZAsR1/sCDmcjGHwRAE3umyKdFRxMP+0QayLo9wFIK0vJ6P1lPjvK1p6ixWDa/jP0eqY8CkhEoVVEkZdhbmEIThzJDjEIsDNN/ZGcV5gEN4gQMDx8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyFHLy7R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyFHLy7R"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86937C4CEED
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 04:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747197134;
	bh=2ioE1gCnNQs7zLR1SvVaQgIOUw+qqKxSSGao9KwFm4A=;
	h=From:To:Subject:Date:From;
	b=qyFHLy7RW1qO3oKaX1dApe3m7x+CGwjG84EjYP9zfr+iQcqCbMZEwbLwCAgLQ8myB
	 Dl22M5lrwj4VyxZDGWIuW/lmu1SylB++WqzPvqGcs7W3ZDkioY6oEVNwoOixg+6p0v
	 qtnPPobJjpZv4oTpbLLruSma8J65wIlHxEnMsmkJLA+hGXwXOI2fuVAflUYd9NYybF
	 DlCdUC8pzhMkR7EPeux8vM0gVV6CEgMYULC2BU/WQtMJ0Jo3WJr5QqUrLDN/cga13R
	 CcPLgomKDZcCqKFmyVGTPGr4gSpCWn9bZcM/EsJDogzc6rDb1A0wGxnNZ5wu14Y3sL
	 IuWViGFvsQHpg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 73503C41612; Wed, 14 May 2025 04:32:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220123] New: Bluetooth
Date: Wed, 14 May 2025 04:32:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: quydd.puto@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220123-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220123

            Bug ID: 220123
           Summary: Bluetooth
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: quydd.puto@gmail.com
        Regression: No

124243

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
