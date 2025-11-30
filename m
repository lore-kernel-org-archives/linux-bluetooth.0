Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363F3125A9
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Nov 2025 06:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764485894; cv=none; b=eERtrH4GTGje12zwdToGdW81Uncleuvra0Lk5WcJaH4CUAzNDsoCbnuI+mAIDc9JAPDWFQcG2XAy2/l6R8qDHEyk/2GS/0xAmGps4JaaeFN5ghIhctJzFUy6djfA+d3uz9N/mzfPuyJkoxfzLCPGkLOdsWIJ/X8xqX2wVqWQjOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764485894; c=relaxed/simple;
	bh=7XsljZQjRC11K6Sh4nkvfRirprHeifHV7zYyKFtH6d8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F8U2RKGSsF9Uf+QOiJUoUdtjU2wIdqTeORRHV3ACjK3a9Pht4Lr7AE0PtkUHF9wqS3q9Jn8sZInznN8IAtdg4ni/OXyfhrYBB39sw9wOH0m/hQfwqncQDMQiRKDCaG3zYB0JsFlv3QgzSumwyWe/5FLfRd4RF7g/4kX1v8JA2mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQHhP/Qm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQHhP/Qm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2DF8C4CEF8
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Nov 2025 06:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764485893;
	bh=7XsljZQjRC11K6Sh4nkvfRirprHeifHV7zYyKFtH6d8=;
	h=From:To:Subject:Date:From;
	b=sQHhP/Qm04YL8pMuAdE9tbq95mUwQJYpOXvLZDk9EfgGZ7IJkay/p6olNYOR1QSfL
	 DunXuBzjhfAT740vLP5wmeB8i44kstqZJQK/DupSsJaLRzCFKByHGNrPNVMe3cVG+h
	 wFkIsoMd7ya1jTckzAjhQhDoEcQtnUBq8cJN5e+3pvxETWxRKQKRc6k9vD5xlxmRTs
	 oGvXgO7oh0v4hAX7BsAnf+5E2OSd50HOEAhO7u7Ypmd2gq++eyzMMJOw+kTVs2ycZv
	 gK0IbNWLGl4F3MmNzq2fMFzyfxJHvf3rG8Ds4wmyTgqfyArqK/iKM18tPi/cEKcvZi
	 b6PLpmo//89cA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A06DFC433E1; Sun, 30 Nov 2025 06:58:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220815] New: btusb: Add Realtek RTL8852CE device ID (13d3:3612)
Date: Sun, 30 Nov 2025 06:58:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: azureller1@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220815-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220815

            Bug ID: 220815
           Summary: btusb: Add Realtek RTL8852CE device ID (13d3:3612)
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: azureller1@gmail.com
        Regression: No

The Realtek RTL8852CE combo WiFi/Bluetooth chip in the ASUS TUF Gaming A16
(2025) FA608 series laptops has a Bluetooth device that is not recognized a=
s a
Realtek device by btusb, preventing btrtl from loading firmware.

Hardware Information:
- Laptop: ASUS TUF Gaming A16 FA608UP (2025)
- Bluetooth USB ID: 13d3:3612 (IMC Networks Bluetooth Radio)
- Chip: Realtek RTL8852CE
- WiFi works with rtw89 driver

lsusb output:
Bus 001 Device 002: ID 13d3:3612 IMC Networks Bluetooth Radio

Chip identification from btmon:
HCI version: Bluetooth 5.3 (0x0c) - Revision 12 (0x000c)
LMP version: Bluetooth 5.3 (0x0c) - Subversion 34898 (0x8852)
Manufacturer: Realtek Semiconductor Corporation (93)

Problem:
The USB ID 13d3:3612 is not in btusb's device table with BTUSB_REALTEK flag.
Without this flag, btusb handles the device generically and never calls btr=
tl.
The chip responds to HCI commands but the radio doesn't function because
firmware is never loaded.

Solution:
Add to drivers/bluetooth/btusb.c:
{ USB_DEVICE(0x13d3, 0x3612), .driver_info =3D BTUSB_REALTEK },

Tested on kernel 6.17.9-zen1-1-zen. After adding this line, btrtl loads
rtl8852cu_fw_v2.bin and Bluetooth works normally.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
