Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1350F1DE89B
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748516478; cv=none; b=JkdAPKR1aicSz3KxLPJZzrCnNUJBW7/2GWOZRN/5F9W+IZTuKXrWoYjPFRkeZQcfvBsE3ZmOxa0Cv7mnXxkQ1SIhn7XeGt/rLVWzzPR/zndBQd7PRudMoW4IlqM7gpSd40SVjoflRNmwit+obrg39b2AzNI5beafV0m/6g7qjCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748516478; c=relaxed/simple;
	bh=gPM7+52uYUXh8dfbdeu+HSCsgsaHjSyTqanhKBcSD1M=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F8/tmAm61YAMiVrkiy5k5xyMH2GZas7B4dnagoN1gwm3ZpfTKTDeYtmSy2ZVjzGcv4w4XThUpQIGrskF6bGDcuGVg3TUbz8hxVIWny7wDFpQ/Ey9syUDt/gwB+k5Ra4yDV50yaOsz5Wyiqiey0b6UrTHwS8fF0CGGHweE6wOOj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYDIoX/2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYDIoX/2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83688C4CEEF
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 11:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748516477;
	bh=gPM7+52uYUXh8dfbdeu+HSCsgsaHjSyTqanhKBcSD1M=;
	h=From:To:Subject:Date:From;
	b=AYDIoX/2NSyRzZjXxbYsQtjdsDOxudNhQcq0zRUMP3qlsoBbGvfCnscqQ3aL9hyDz
	 4pPTE6eiYhL4ZDqUh7uWwW16hYxhrWBAD/MdQ5emI14/WPg2W1thM8VtwfexCx01of
	 6Hs2h8vdpGdjtYp1t3utR+pEutL0KdTHHk/Z4unteXs9wO7iSk/LrDzbBgy3xpGjDV
	 JPxe4J2WvBudSPPFmPmUhDtPymdt8aRmaXET4y+QahOxL0LnfPTU9RDUZCT63lWK2c
	 jHN2PCysTuY6TaHT5tgwztYLU+pwohJDQ52Xj6rYJXdn3ZhosWsmdqUFA3npK33LTb
	 h/cJ7R6HldEjA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 75388C3279F; Thu, 29 May 2025 11:01:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220173] New: Bluetooth: hci0: command 0x1004 tx timeout
Date: Thu, 29 May 2025 11:01:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: harshil123dabhoya@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220173-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220173

            Bug ID: 220173
           Summary: Bluetooth: hci0: command 0x1004 tx timeout
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: harshil123dabhoya@gmail.com
        Regression: No

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
