Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1032264D0
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jul 2025 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752927001; cv=none; b=SGczmKSDNQnrNBRzYOVqzyfCMuQ1kYAyM8TF3sc24Uj0jxFbutB7+k6Uki7JD+U3fZBj4nB/JtWbObRh8J+d8WJnlM6iiNF56RFBDlmjkoe2Bv0KMqBXRuWLCnbul8hnP62lMIOdlP1/8/o3Bn6u3Nq9W3imnCiGRD1c6tZm5mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752927001; c=relaxed/simple;
	bh=UlUcEp8qdjAhZI4Ela8S5V3/T/ul7C72aM6igED1Yqk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZOMeU0NN5H9vHGUURHVesen7/LqX4PaLlBP+S+YT13JSUVAco0r1P7fGgPzdbpnVMKbMclDrDs1E5r31IiSosZUSAb0WKgb8pW9w/REZugIWIpM2ZItuAdFeT1q532jTFFGxMe1vrVYfoU575FLex/hKGJSLdnZMmkK50Jy55VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzxu1Ty9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzxu1Ty9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E35DC4CEE3
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jul 2025 12:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752927001;
	bh=UlUcEp8qdjAhZI4Ela8S5V3/T/ul7C72aM6igED1Yqk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qzxu1Ty9A9w4UAZ60yJq/Lo4I7N2R6Mr0p3SQueESar6BjUIYBLmb1fnJyy9aRQZG
	 QCw909xd6KCSBofbvteS82fp8/EvXXsodtTPirWufvHR/ccYlwDox6/cKwy/MJb3H1
	 0rt3IUTbhGuoyWP1Z403EWAgqOm1ikY8hKxq1BkNIZc96g89zmu48Vk2cjfqFY4SY6
	 QWgx7clGxr0Q/y+bGTExHZ2dOUYkmgXzRj8bEwQEJ7TfTB6Pls+qMDx/2UpKVrvoPr
	 /VhSIVPOtxMtnThYJ1wlmPSjHVZtkFvH2QjxHmAdzxUd5jW3scT/dZ8C71SsUZzLfX
	 QfcPGwQlF8L6g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 32D6AC53BBF; Sat, 19 Jul 2025 12:10:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220341] Bluetooth crashes about 30-40 minutes after I connect
 my headphones:  "Bluetooth: hci0: Hardware error 0x0a"
Date: Sat, 19 Jul 2025 12:10:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220341-62941-nXk4jUI5ns@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220341-62941@https.bugzilla.kernel.org/>
References: <bug-220341-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220341

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tal.lich@gmail.com

--- Comment #19 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de=
) ---
If bug 220344 is the same issue, than it happens also with Ubuntu=E2=80=99s
6.8.0-60-generic #63~22.04.1-Ubuntu, though I do not know, what they backpo=
rt.
The bug=E2=80=99s first comment also links to a post saying, this started h=
appening
with Linux 6.5.

https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html
contains more detailed bisecting information. Especially how to package up =
the
Linux kernel files. For RPM based distributions, that=E2=80=99d be:

    make -j $(nproc --all) binrpm-pkg

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
