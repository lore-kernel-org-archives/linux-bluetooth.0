Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A121B4F02
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725362; cv=none; b=cfbhurHD0Xq54Za1S+k2+GawSnT90x9tl1PwzAYLIp4P2eN8yyNb6a7zX4ZJyiQfeBeH/ibacEaDwNoBmZvi9JlEVTOEM6rZGil99atDYMd4QqPZuXnadL8V95X7T5Ygrc9FXvtn8pt9MBFUNGmGYVxW5TuTRLC14U/PxgUGbY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725362; c=relaxed/simple;
	bh=o+njFMQ1zAFh+Y23gfRcVCqnLpJoVVFL+zcaOy5OQRY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pGmflb4PYd3x8e7hl/qt3zHhtI4sbWdjEFwMIG//xS1Wc+CPzGyxYkwVfrJaKmmoC6fzhcze+s7p33lYey/GVBDp+X28AhOn76fJ2fPhQGJ1n4Axsgf21QdmT+Wa5yMteiS3n1XBS+9SBHNuS+rjl7tfY5bnpY4BMQx5Z+oa590=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFPJtuDd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFPJtuDd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B19FAC4CED2
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730725361;
	bh=o+njFMQ1zAFh+Y23gfRcVCqnLpJoVVFL+zcaOy5OQRY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JFPJtuDdIVaW1fXiL964NqLu8HMiWwhURPBnspmJFad9DZF5EY2LjMW43dVWcYx2W
	 yv6qD57BTeqXULOiQcxNMpZGOQRdHCdUbtkw7BnZ4dWrQ2BDDB1Crw4gQTm/OuHi53
	 4UIH206ncZ5bOPxQ/LjvSsUrFBSvMD97Afi+u8Y3ub4I6mtb/24h+AH5Qv0JwpIV4k
	 5kCveRn545vsU94p0mYA4wrwRLJuYwjoGdij503aIW5ty8gtlSUcFAGVt7AxhBGHqp
	 igfMvfnbM5uJZRAQ3xrnBiXC697msRhnGzgRdaCddvJd1Hj0OSjuSiWZIk5a3ZpqDr
	 qv22VZ3aqetlA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A306BC53BCA; Mon,  4 Nov 2024 13:02:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219387] Bluetooth: hci0: Reading supported features failed
 (-16)
Date: Mon, 04 Nov 2024 13:02:41 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219387-62941-YwBU21RQxX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219387-62941@https.bugzilla.kernel.org/>
References: <bug-219387-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219387

--- Comment #6 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Created attachment 307131
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307131&action=3Dedit
Dell XPS 13 9370: Linux 6.11.5 messages (output of `dmesg`)

Linux 6.11.5 logs:

    [    9.094743] Bluetooth: Core ver 2.22
    [    9.095249] NET: Registered PF_BLUETOOTH protocol family
    [    9.095252] Bluetooth: HCI device and connection manager initialized
    [    9.095256] Bluetooth: HCI socket layer initialized
    [    9.095259] Bluetooth: L2CAP socket layer initialized
    [    9.095263] Bluetooth: SCO socket layer initialized
    [=E2=80=A6]
    [   10.698546] Bluetooth: hci0: Waiting for firmware download to comple=
te
    [   10.698731] Bluetooth: hci0: Firmware loaded in 1432875 usecs
    [   10.698774] Bluetooth: hci0: Waiting for device to boot
    [   10.711796] Bluetooth: hci0: Device booted in 12732 usecs
    [   10.711948] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-12-16.ddc
    [   10.714806] Bluetooth: hci0: Applying Intel DDC parameters completed
    [   10.715799] Bluetooth: hci0: Firmware revision 0.1 build 19 week 44 =
2021
    [   10.717794] Bluetooth: hci0: Reading supported features failed (-16)
    [   10.717812] Bluetooth: hci0: Error reading debug features
    [   10.717815] Bluetooth: hci0: HCI LE Coded PHY feature bit is set, but
its usage is not supported.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
