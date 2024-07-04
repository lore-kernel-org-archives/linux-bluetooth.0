Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38977FC02
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 07:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720079487; cv=none; b=OiMQ+epeclc8QsijsXzXcgCd8ZXDfzEStfBAykmb7dVtl+ghEoCO+f6Aq5nxVajcOqjr/qu7ny3+hCvLgOw9slN4ZYFp5AuOmK+LgzKxty47LbIgplIbmByPgaIc44PUyQyTKJPBrhWlGXSX05sVQIoqZK1zjdMcE5FjbgYpA6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720079487; c=relaxed/simple;
	bh=bAEmwS1D9YtTYK2QRhabApQjU9QylwrZ1bfvFLtiGFg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZssjmrliwP/pFEfOapppBAlgkQMjsftJlIPZuCnYBC8nnk6/X0M65rgAY5K23cb4lCU0uYYlVWvupQ60DMGWcyYYRKKU+K+1RHWbZc6cBj4owz/ApFJOJI3Cz7zwDD0gqGkNS/FUiT5jSzb/EdolMqrd5/+ohyKRL9mVp+8uXUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8GkA4bz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8GkA4bz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEF12C32786
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 07:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720079486;
	bh=bAEmwS1D9YtTYK2QRhabApQjU9QylwrZ1bfvFLtiGFg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=J8GkA4bzSnLeB61yvcSb/30Rw2GDa6YcJ7iEOOMj9ynVEecJ6mN2/VJ7ai/SinPa8
	 ve4iBxdg5EF8ehaJAXkgAMtg8UxVO6j2fQ03Cv2s6/7uZCLBU5bccICi1USdvUMlhF
	 +yNLjZT5N0ds6DjFfPFog73wWuG06lx44nkT6dTBljy/3NHWzER2+9TLb9dYnZnYQS
	 k009/PZsi4NVFLEeloVbYi4HKZ0k+c02fjfiLTuq3EMEFRrEiW4Q8EPINp4Kgz9Jmx
	 jrIbdDdLuAcM7v9l5621KmotyeZNIVzkCVZys7NQIE4Xn8J0u5l1MO2tC0AS6FFG61
	 fzEzc4E4Exyyw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A2F94C53B50; Thu,  4 Jul 2024 07:51:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219003] "Bluetooth: hci0: corrupted SCO packet" on W800BT on
 kernel 6.9.7
Date: Thu, 04 Jul 2024 07:51:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219003-62941-bRJice6Stb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219003-62941@https.bugzilla.kernel.org/>
References: <bug-219003-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219003

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #1 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
A few notes from a bystander:

* please attached a dmesg from a kernel where this problem occurs, ideally =
with
the latest 6.10-rc version or newer

* no developer might look into this, unless you bisect which change causes =
the
problem, as then someone is obliged to fix it
(https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.htm=
l )

* not sure, the bluetooth developers might not even see this report (search=
 for
bugzilla on
https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-ker=
nel-bug-reports-are-ignored/
for details)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
