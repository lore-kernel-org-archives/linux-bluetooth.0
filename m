Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68F5320B
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 04:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716524239; cv=none; b=YYEIjMkgR/z78UIa3BSndNx+aPWZUjCHLUCwhgg5zgU2idLzmBjeXH61HEe9R3K3hWrrkk9M49IB+eakWVIDbt8mM6G3q79HRegdAbTj4Olcvi3+RQZeyRXWoR6NbAP6dTlIppjfc6HUbCreA2BLjipHPwj4CwMXegBsquhV4e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716524239; c=relaxed/simple;
	bh=kYxH7HVsKHX47z4l/cIDVdiOToS9I2JeVhf4IoNEkn0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tVX1oJpm3+YG/ncmHQytMpPKIYuze/TUKCWdrb5ezaI6+i9asilIqo7QAhIha4VB8Fs+CqiW49RtJxXOzqjFw7HpbbDiX+W5VlGCGEU+uF6XhbxufWztV0GVZfbVv+lycQtiARO3lFuCGaxXKbC4JRUr9SChr2m2LOE3X6URVTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPl1nlZ9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPl1nlZ9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F29DC4AF08
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 04:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716524239;
	bh=kYxH7HVsKHX47z4l/cIDVdiOToS9I2JeVhf4IoNEkn0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UPl1nlZ9nY6A6GBh0j3yb1x+wHSiLFZxhWFnx93zXFNDu8/1V8ys6QeHT/KgvFE34
	 U/T5OCstxaJqMvD3/f39G4htftEhTYN5UDNUWvweplcE1hf7/wxUklRGZXw8mBQog6
	 fq0Mgs6BZRUlRiTVBjqBeyk1tSs6vUU3N40r7xJ3c0ej8MFaHv8JYtd6nEniwn60GW
	 ahf0XmXPyo8+CG3JVuECkY+yHOGokGtz8gf29j8npRrVycgxfc98sFpfHo7uaE/ZZX
	 pRZnCdg8Mh/oGMWX24Dh2FUOKeKFf5d+lem3vYxeBVxrfOJrBoU79ENC1Wm4TwLqq4
	 JNaBsTVtyIUFQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 25190C53B50; Fri, 24 May 2024 04:17:19 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Fri, 24 May 2024 04:17:18 +0000
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
Message-ID: <bug-218416-62941-fUxQ4f4F1O@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218416-62941@https.bugzilla.kernel.org/>
References: <bug-218416-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218416

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #26 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de=
) ---
@nickolas, from your bug description it=E2=80=99s unclear, if this is a reg=
ression, or
if Bluetooth never worked for you. Could you please clarify?

Please attach the output of `dmesg`.

Also, please run `bluetoothctl` and share all the output.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
