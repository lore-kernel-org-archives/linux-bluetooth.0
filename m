Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB2BA20
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jul 2024 02:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721356350; cv=none; b=oLF+jziPjPrtYg3LGSF07ITmWeX2qZTZ/gnBxu1+6YJZqWSm1juZzJLXtb7lUK+W9OS18i6JTyF5e1jnx1Fvmsn3J6ZEFn3vgcMyHMTJFZPk4WzeasYa0hMkx8xyohdQLp7KU/OfhnP8ijWEL2RlP7hB+A9QOoZzAC8inxn+K8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721356350; c=relaxed/simple;
	bh=2hp3stz8k0FqTl8D1zsi+SphZFmZRisaPDJVx6jkeHY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FS2IsQs97utgf6Xj6ssIar0kqqe3JI2ZDuQ37DwTGrRv0qQ/x7Goi23Pmfsgo5bnlCE6HHEwEhscw3PeqvL2EDaeHH1bt5UaOpArHGrc6o+K3ogGHCxR+1L9O9bczvSg7XQJX1L7JM3UI93uOD7rPuEf8UtMZ2qyYEjgOETKMgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oW1AaP00; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW1AaP00"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6859C116B1
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jul 2024 02:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721356349;
	bh=2hp3stz8k0FqTl8D1zsi+SphZFmZRisaPDJVx6jkeHY=;
	h=From:To:Subject:Date:From;
	b=oW1AaP00VPJgjS9G1ks7uBR6yCYwV1ypLtEPsZzRLicgoVaIarsw341cyHASeEm4O
	 KxZs8gH1SRLJPBUE1t+dzzBQxFJliebw2ihyCNzFzEpVy/qIhxfoh8n0IFVv/C3XHb
	 ADR7ghFdHOQSLi420U98wyiks6edIjtI6KBzKS0xLFEmq9u1YVJN9M8FYvuYiZQT6i
	 +zsYekH3lGqfl7NtHMKztW9fL40zhi9WJ0ioR7/qz8qE5yFJpJjxGRVVeZniKZFwNA
	 5wJNqndOujeUHCDTWtQxWP4WOmwiweJ+6o0mXiuEvD1PfQCW0qpBn+8l44H3/t3Ui1
	 VCTlgv+WzQtPQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B3721C433E5; Fri, 19 Jul 2024 02:32:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219057] New: dongle bluetooth does't work on linux mint
Date: Fri, 19 Jul 2024 02:32:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ricardo.andres.riquelmerios97@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219057-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219057

            Bug ID: 219057
           Summary: dongle bluetooth does't work on linux mint
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: ricardo.andres.riquelmerios97@gmail.com
        Regression: No

Hi , I build a pc gaming machine and install linux mint on it and for most =
the
thinks works almost perfect except this dougle bluetooth of the brand ugree=
n ,
I just buy this device because it said bluetooth 5,4 and when I put the dev=
ice
the system recognize as a bt device but when I try to enable blueman , the
program in seft crash I try this command and give me this error [    9.4287=
97]
Bluetooth: hci0: command 0x1005 tx timeout
[    9.428845] Bluetooth: hci0: Opcode 0x1005 failed: -110
 so.. I don't know can I do now , I try to forums of linux mint , telegram
about linux mint , discord too and none it can give a awnser , can someone =
with
more experience help me please and thanks for give me a little of your time=
 and
readme

Ricardo.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
