Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8031EBA14
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Mar 2025 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741891420; cv=none; b=fdsjR7EH4Rjm7oBL67T8L/JQ4BjcuVH3t95OtR84xCJbAo1nnnQ69AfzLZmT84DVtkm1Xdy7G7VJbmi2JotcUGEvz6gkiCeuxAD8dDgAepzk2IL6z/4sbqmz8VDA+rvnP99MNJgS7QIVty1SQK2F41AZ1pBWXMbx1jWyaz2BpMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741891420; c=relaxed/simple;
	bh=Zau4FCn7/mNsJXreQTei8N1KVFCW58BQ30fBXK660hM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Gg9QzPviPZ5g/ZionpRPbSL27uvdeigIFKxJ9nFx/MpjzwwzA4JTk0Kb37nUGqkSIKKJIt51h3NT8pVXA8dUkNOGMascnw+ANUmqxEJw8t3ethI3bKi0jOszTZ1Dsb2KeBcYSs9ybslurw55220vAQUS6bGF1Beaj6eLloFApZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ora5nlb+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ora5nlb+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DB1DC4CEEA
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Mar 2025 18:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741891420;
	bh=Zau4FCn7/mNsJXreQTei8N1KVFCW58BQ30fBXK660hM=;
	h=From:To:Subject:Date:From;
	b=Ora5nlb+yE1EPjXQ/qP2hvaN1mfzXMEDbYf/uSuJ+sgXGItQljmiouyiRpHELxFtc
	 D6fhIdlZ29xOThNRLBBqup4fLnBjdaCZpk4NMGhFXRInGJ8uMpMDRKUbq/xm4YdEnt
	 oaod62Ne1uzswssr3c/HeBm1pfEDWPLfoqz87m8FXMYof9MS0MH/2qtBHf4K30gcOZ
	 lYOdGAIROLwSZ2UpOEdGHMDToBFaRplpVqLmQqAAnH9kJ2QL4YfLjQXNMwDKbQ+dZX
	 taQ9jhr6Dp8U66q8h4vAmItyZZF/J1NQvHG0e6iu7b54zVSugWUfe+pRVL2xn/gK1c
	 loKU6i0xhvGpQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3DE01C41614; Thu, 13 Mar 2025 18:43:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219866] New: Bluetooth stops working on BE201 after
 linux-firmware 20250311
Date: Thu, 13 Mar 2025 18:43:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bhabeck34@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219866-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219866

            Bug ID: 219866
           Summary: Bluetooth stops working on BE201 after linux-firmware
                    20250311
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: bhabeck34@outlook.com
        Regression: No

The linux-firmware 20250311 release appears to have shipped firmware for the
BE201 Wi-Fi chipset that has made Bluetooth unusable. 9971a5b6 appears to be
the commit that has updated firmware for this device.

Steps to reproduce:

1. Update to linux-firmware 20250311
2. Reboot
3. Notice that Bluetooth isn't working

There are some logs in the systemd journal:

Bluetooth: hci0: Failed to load Intel firmware file intel/ibt-0190-0291-pci=
.sfi
(-2)
Bluetooth: hci0: Failed to read MSFT supported features (-56)

Upon reverting to the linux-firmware 20250211 release, Bluetooth is functio=
nal
again.

System Info:
Distribution: Arch Linux
Kernel: 6.13.6
CPU: Intel(R) Core(TM) Ultra 7 258V
Network Controller: Intel Corporation BE201 320MHz (rev 10)
Bluetooth: Intel Corporation Device a876 (rev 10)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
