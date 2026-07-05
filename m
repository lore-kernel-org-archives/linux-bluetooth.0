Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE295125AA
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jul 2026 06:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783234076; cv=none; b=hnhmI5wTqOcTB6Tlqk+eTgofy6RsmQFLkGA2942i5+idUKeKkXjKiuH3w6Xl6S7VQWE1NNVKDRsEEQxMKFkpoUf7iNaCu5jc/9UVU6g8696rIhp5Q+Fw3tdUasB+wh7snXbMb9OAyrW4ZL4cBtLdF/U3ERWCxwF7c9UtLyHY/F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783234076; c=relaxed/simple;
	bh=+MXSv604NUwvSZuaeZoF4PMLhUixzra2rHbkpkPXuno=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YkSjIcTXXgnldr99FmXPsloAkd6A1VSkHRXxvIm34QfTTbOo13DHL5a2D6cbwvWlUSCHz/IjZJ6qliZKwgK9QWbZ9cWFe3fBo0U26tVwYVeIKk18IUIGeiHiuRpmG5CHSbfEDyEcUFH7nBTZxLbfXBvZDZNqRKpUqtjOKitsyKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQnCGAKf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQnCGAKf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D169C2BCB8
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jul 2026 06:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783234076;
	bh=+MXSv604NUwvSZuaeZoF4PMLhUixzra2rHbkpkPXuno=;
	h=From:To:Subject:Date:From;
	b=kQnCGAKf4f1vGbSoIgnxF9h8/hIbTu6Xxmo2PJxzhgJwMVA7X8HRN07c5A9+4RbW4
	 6E28OT18BBNDXd9M7eODSNXbmzeDhOiVVvcK7/hyw3hfqJws1Wg1/+5N52QKJpAXf9
	 vNrAiDFGq1OLZvKAajQhLybnPQpjaPw4IMTZw3I7rjAUXORhiiZOJ5bMNAyRpVnBUm
	 z2nUlsksJdGYQulKb8E1oTJwMfiIB+qrSi7MXaFnqYYPhu6s3R0T0byYrWcH+rovqP
	 ZP61CsEsmDEKslWUXlouN/0LfNeu1z7y4fNj77p9vSQkoRxUriYMGFLEUR3+BA7DvW
	 tSSUPN5kKydEQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 39321C3279F; Sun,  5 Jul 2026 06:47:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221724] New: RTL8852BE Bluetooth (0bda:b853) fails to
 initialize - hci0 stays DOWN
Date: Sun, 05 Jul 2026 06:47:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: elbanano2.0@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221724-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221724

            Bug ID: 221724
           Summary: RTL8852BE Bluetooth (0bda:b853) fails to initialize -
                    hci0 stays DOWN
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: blocking
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: elbanano2.0@outlook.com
        Regression: No

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
