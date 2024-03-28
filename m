Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D10154BCB
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711623792; cv=none; b=GMdEoSkugop4TcNQciy8bFb1+EYnXR3xg8hJhSoIWvlYzF6u4sQqkFiYo+I5WNJkhEqRw71R7fILBom4TOxExRnobQrB+F9BfAS4WZD6z6u4UbY/GxIQLIUK7PCxHKk5tbaiBuPUfPtO4fUd4MYOcWRkKHNLU3Nx3W7f9hZf3Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711623792; c=relaxed/simple;
	bh=aUhkEvBwMTv+OI+O4ioAZnjPrtZSTr2HS1eMpyLMARM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i8pH+o3es9x/BtVbxb5fMwt5fk8kG6heEd7lyaqVEYzzD4kSGgFSd2qT9oga5MCkAVl2kYfcnU+cGwK+84TOeb6l1ncoUzGmq+YkZQUTZpNoNhVqfU3CAiOOUrkIA9RHx48EpjtzSJxlEvJqKNby2v0DRrWfVltdipQuyTk8Eks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=De/pdUx6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="De/pdUx6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E11FC43390
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 11:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711623792;
	bh=aUhkEvBwMTv+OI+O4ioAZnjPrtZSTr2HS1eMpyLMARM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=De/pdUx6VstKUVpjgc6KJEdzH9FOXXKeItqTz2ofTjvSEdtG1Tecx0UoGABJNtQDF
	 YUN57Fn5G9sKtz45yNcu54X7oVUKyhrluQ7HqNBPWUyu9HCMYtbB0e8lhuXt/g1JWL
	 5RUjRUKiSsElIehLBnTfLmC5IjA4k8gBDUwk3+wEIRhDd6qaImnMWbuDxKP2aAXTaP
	 zjfBGtpM140ODVzYsDi7OnL/+oJT7G1rF6ZtJ8W3sSv9rXC/94WpaHGTskP2Axxstd
	 yZ2UPtabeQiDRZTnI8hI2dYQ5eMPwAVzEyF7WLHBqIMls3cGveJwt+ajVYzENknMmN
	 oSyksGtyF/6oA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 05A74C4332E; Thu, 28 Mar 2024 11:03:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Thu, 28 Mar 2024 11:03:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: agurenko@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218651-62941-0zTQGW7yBK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218651-62941@https.bugzilla.kernel.org/>
References: <bug-218651-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218651

--- Comment #4 from Gurenko Alex (agurenko@protonmail.com) ---
Created attachment 306052
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306052&action=3Dedit
dmesg log from several boots

Same here on my MSI Tomahawk X570 WiFi with AX200. 6.8.1 works fine, 6.8.2
*and* 6.9.0-0.rc1 has Bluetooth: hci0: command <command> tx timeout:

kernel: Bluetooth: hci0: command 0xfc01 tx timeout
or
kernel: Bluetooth: hci0: command 0xfc05 tx timeout

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
