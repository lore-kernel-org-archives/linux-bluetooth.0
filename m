Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB543594C
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Aug 2025 21:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430220; cv=none; b=SE58DkV0psn24HGuGDdkh2sQEYlQDDjGKNQVE5UPeE8mwRDh6mtf5LdTPw/QA0kzTQ7/5hledtjxGVYW/HPpSc95VOg718a3t3ZQkzQpRomn2hyA179he/KolvpEnHmO9JrBgukIyrg7tuiXRqQ4vSNft8BhQzPsUOAnbA+WIHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430220; c=relaxed/simple;
	bh=wLVVtReepdMq3c+ofkDDk0CFpC8x1t7oK/tL9V+EibQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uCP9VOuvCsDth6aip41E+SNPR98bVUTtg4s+I4yf4w/1XeB6AWek8e8LhNK6GaAM4s5jf1yiIHy+OvR+ZG+R+rBF9InjjXAYo0EJSLlSnZbGY4SfW4ZM8o8agxk56e3S6SGhO8ea8kfetaZPcsEmg/e4iWWNvUuPHRLtLZS8Aws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcTiwEWc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcTiwEWc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F41BC4CEF0
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Aug 2025 21:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754430219;
	bh=wLVVtReepdMq3c+ofkDDk0CFpC8x1t7oK/tL9V+EibQ=;
	h=From:To:Subject:Date:From;
	b=fcTiwEWcoR6dVIKv0GEcKcR3g6sHfpAB/Tbn0X8slaWKha2cYtkSxdwBIf3efErq7
	 mud73LE3ZgQ2rpD5Yzu/2Ziu5d3N8IVFnFq9wsGS3F27qddqowgBLkcQBDie8rlrpk
	 1Qt9lzOtL21O5hXHz7bNwrnbRHlP/MUHMX7VgiY5/6HUXNsIYODno0Zn+tFIMG9mBO
	 VQsDZbpbYEtbLNUmy+TQpnvEmlD+wv9oO4MrzXQWBq7BCELPNp/Mllkk3IjLzE+9gr
	 uADmh3+zefo5uyni7/RX8oN4CboInkHZG3AAYFV2U9qSziDTlMl9U53LktN+w43A8o
	 f/oXusYi0XPdA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 79CCDC3279F; Tue,  5 Aug 2025 21:43:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220419] New: Bluetooth stops working on Intel BE201 a few
 seconds after connecting a BT peripheral
Date: Tue, 05 Aug 2025 21:43:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: anton@ekblad.cc
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys bug_status bug_severity priority
 component assigned_to reporter cf_regression cf_bisect_commit
Message-ID: <bug-220419-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220419

            Bug ID: 220419
           Summary: Bluetooth stops working on Intel BE201 a few seconds
                    after connecting a BT peripheral
           Product: Drivers
           Version: 2.5
    Kernel Version: 6.15
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: anton@ekblad.cc
        Regression: Yes
           Bisected 6ed83047389c63a8d7712b0bf19eb38a6e4dc68e
         commit-id:

Since 6.15, Bluetooth stops working a few dozen seconds after connecting on=
e or
more BT peripherals on Intel BE201.

"Stops working" means that all BT connections time out, Blueman and anything
else that interacts with Bluetooth hangs, and a series of messages like this
end up in dmesg:

Aug 05 21:01:40 albedo kernel: Bluetooth: hci0: Failed to send frame (-62)
Aug 05 21:01:40 albedo kernel: Bluetooth: hci0: sending frame failed (-62)
Aug 05 21:01:41 albedo kernel: Bluetooth: hci0: Failed to send frame (-62)
Aug 05 21:01:41 albedo kernel: Bluetooth: hci0: sending frame failed (-62)
Aug 05 21:01:43 albedo kernel: Bluetooth: hci0: command tx timeout
Aug 05 21:02:10 albedo kernel: Bluetooth: hci0: Failed to send frame (-62)
Aug 05 21:02:10 albedo kernel: Bluetooth: hci0: sending frame failed (-62)
Aug 05 21:02:40 albedo kernel: Bluetooth: hci0: Failed to send frame (-62)
Aug 05 21:02:40 albedo kernel: Bluetooth: hci0: sending frame failed (-62)
Aug 05 21:03:10 albedo kernel: Bluetooth: hci0: Failed to send frame (-62)
Aug 05 21:03:10 albedo kernel: Bluetooth: hci0: sending frame failed (-62)
Aug 05 21:03:40 albedo kernel: Bluetooth: hci0: Failed to send frame (-62)
Aug 05 21:03:40 albedo kernel: Bluetooth: hci0: sending frame failed (-62)
Aug 05 21:04:40 albedo kernel: Bluetooth: hci0: link tx timeout
Aug 05 21:04:40 albedo kernel: Bluetooth: hci0: killing stalled connection
dc:2c:26:3e:58:cf
Aug 05 21:04:40 albedo kernel: Bluetooth: hci0: Failed to send frame (-62)
Aug 05 21:04:40 albedo kernel: Bluetooth: hci0: sending frame failed (-62)
Aug 05 21:04:42 albedo kernel: Bluetooth: hci0: command tx timeout
Aug 05 21:04:43 albedo kernel: Bluetooth: hci0: Failed to send frame (-62)
Aug 05 21:04:43 albedo kernel: Bluetooth: hci0: sending frame failed (-62)
Aug 05 21:04:45 albedo kernel: Bluetooth: hci0: command tx timeout

Some other observations that might be helpful:
- Problem still exists in 6.16 and 6.15.9.
- WiFi is not affected.
- Unloading and reloading btintel_pcie and btintel "fixes" the problem for
another few dozen seconds.
- Turning off power management for BE201 doesn't seem to affect the problem.
- Actively streaming audio over Bluetooth seems to delay the problem.
- Tested with all possible permutations of Sony WH-1000XM6 headphones, Logi=
tech
MX Master 3S mouse, and Keychron K7 keyboard.
- Bisecting shows the problem was introduced by commit
6ed83047389c63a8d7712b0bf19eb38a6e4dc68e.
- Hardware is a Dell XPS 13 9350 (2024, Lunar Lake) with Intel BE201 WiFi/B=
T.
- Firmware version is 20250708.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
