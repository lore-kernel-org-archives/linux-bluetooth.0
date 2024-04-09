Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6DB12C531
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670344; cv=none; b=CCpdLQxgpiaIxig53JNWJ8h3kE6oJxLFPXjvLNF5RYkZ+6mycnieBAlwQzqV3xU4FQWamyfVGnarufU2xsKNTksjKc4PRaAYbggkeNdWjRbAG4cDpVtHlutFwWHPM8XFjb8xl5JgvogQgFD8r1MKFq+Cekyc4tZ4hXUYp9rCan0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670344; c=relaxed/simple;
	bh=XQpz2CXMrdVdvbxwHpvms1nyuxH7Qma4dMfeGnvYuRE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NRqW1mDmen6J2scD3oJDK3v4duhBnmqHFHzRop+X8etTZ81GWEtzCu6xnfc1LsyvQr5ASN/YDzkwSQ+p5uRg4/KU2RtZWrJvRfLI7aXF8Q0sRN8tripaYdwKP8ZMMsG69i2tJOpA99x6jPQXb4339Nil433uNpqzgAnC4orIYjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sy4y7kMg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sy4y7kMg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 321E5C433B1
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 13:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712670344;
	bh=XQpz2CXMrdVdvbxwHpvms1nyuxH7Qma4dMfeGnvYuRE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Sy4y7kMg4ZBpkVHGVuDsBzygDEuDxmZQOTWDqaBtFh8MmSczdn4HrljHHzIAedhwj
	 ujCwlyhHaXQUcUFqebpiaFx1+avRrUASgSr/Uu9y2B4nT6nr5muWABgOV03V+UvtQx
	 rqk4VenH6meQSi3hjDFQaDxAdJcLacdf0lsmt1bsulkZ9EembXbfwDiffiL+HikD10
	 CdEKIAIWUHQDn7zIWoxdatXsA0wg+Pr9o2FP1IPqxpKU2p5OC6r226pwj5+Zc4Vp71
	 AEaSy71la5zdM8/SFX0zQUD8JwzBAWJfV2XYYDJuzpCfVj7CZ/RdeyQ4I0Py0hO8qr
	 sQbs4UK8f+YVg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 269DFC53BD6; Tue,  9 Apr 2024 13:45:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Tue, 09 Apr 2024 13:45:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nickolas@gupton.xyz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218416-62941-5J6OBtCkZH@https.bugzilla.kernel.org/>
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

--- Comment #20 from Nickolas Gupton (nickolas@gupton.xyz) ---
I am on kernel 6.8.4 and using firmware 20242312, but Bluetooth is still not
working for me:

$ uname -a
Linux andromeda 6.8.4-arch1-1 #1 SMP PREEMPT_DYNAMIC Fri, 05 Apr 2024 00:14=
:23
+0000 x86_64 GNU/Linux

$ journalctl -b | grep -E -i bluetooth
Apr 09 07:01:20 andromeda kernel: Bluetooth: Core ver 2.22
Apr 09 07:01:20 andromeda kernel: NET: Registered PF_BLUETOOTH protocol fam=
ily
Apr 09 07:01:20 andromeda kernel: Bluetooth: HCI device and connection mana=
ger
initialized
Apr 09 07:01:20 andromeda kernel: Bluetooth: HCI socket layer initialized
Apr 09 07:01:20 andromeda kernel: Bluetooth: L2CAP socket layer initialized
Apr 09 07:01:20 andromeda kernel: Bluetooth: SCO socket layer initialized
Apr 09 07:01:21 andromeda systemd[1]: Reached target Bluetooth Support.
Apr 09 07:01:21 andromeda NetworkManager[794]: <info>  [1712664081.1498] Lo=
aded
device plugin: NMBluezManager
(/usr/lib/NetworkManager/1.46.0-2/libnm-device-plugin-bluetooth.so)
Apr 09 07:01:23 andromeda kernel: Bluetooth: hci0: Reading Intel version
command failed (-110)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
