Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0C730C631
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 06:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778049621; cv=none; b=fMCBLJ2O1+lgvASEq4rDJMolioGvymQyjlA6G8o9hQ5f9KkT3UPRxnQSl23Muuk5z2M3YWt2Omj8yk9ldFp5RPwlnKQ03dfZFLQGo/XLLqs0X/HxvYoCOM9hDVPPzn8kITYd3N/wnjoozc/NWUuVS5tRrOVUxIsigbSapoTK7DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778049621; c=relaxed/simple;
	bh=nEtNz+gN1IhMgEfmQ3b2+csMakAyyZd1+gzE1Z5mdlg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FFlolupgUcP01fQ4LnjAPdiGOtaZ2UUoeCNmmVMLKQavrKbIjPqDBUlq69rqQRvWKSvxosCcEVORAhOSjCHpZxzVzB35GtcPL1C1U1bofvGRf4ICkMOIyz/ho1QbJld3VWlirFvFsE8kO+/ApKg+MVLYJejZn36XvYsyxVl3M/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBAx0A/l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBAx0A/l"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F5CEC2BCF5
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 06:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778049621;
	bh=nEtNz+gN1IhMgEfmQ3b2+csMakAyyZd1+gzE1Z5mdlg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jBAx0A/l06O0CXUmr4FuFpH6HQQVbcEGwpmb4KI14+ZqLx4vpO6SzyCOVHPXQFYsR
	 PtJlVxmiCIifvPGpYGXU7F0cW99IOMkF77gm8rIl86KZ2PoBEHHxC5Tqfb2fuObW2t
	 e4wjo804kQ9sDOqtqjJf9nTz0aqKbdk33wHuqL2OUyBuoHwCQ+ChdMkuvUYZQDSvet
	 4Y8Pkv8ZIy72Jg88RZoNtjMVluBWhNvmp/G5ZRYCXla5nTn66d+S/LTe0S/FH+z/AM
	 KU7wNFeqVayjPQqVDoMfC7ifEhbeRI2d5pK70w30TbEThWb1U3stOMFMI7cyxX8qPF
	 6iRKn1w9uzJ7A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 252C6C53BBF; Wed,  6 May 2026 06:40:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221449] Wireless gamepad stopped working through Bluetooth
Date: Wed, 06 May 2026 06:40:20 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221449-62941-maNhDVwuCu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221449-62941@https.bugzilla.kernel.org/>
References: <bug-221449-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221449

--- Comment #6 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
> What's a good way to isolate the kernel as the issue? Install and reboot =
with
> an older and newer version and test the behavior under each, or is there a
> better way?

That=E2=80=99s the easiest way. Sometimes it=E2=80=99s possible to do all t=
his in a virtual
machine and the Bluetooth controller is passed into the virtual machine. But
setting this up is unfortunately, at least last I checked, non-trivial.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
