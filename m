Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937A21E3762
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502961; cv=none; b=E19qqNb1QPpOsH3Lq/iPVdqP2d09XcU/sOmEhiio1/1NoHuyH995k3hUz7rovQpcxFsCSPAtrlg1JUbPrVunw0phzQJX018mbi3qspsuWTZ0XibVtoyJ9xq1sgF0jTvBDcVhb90PpOSSX8FLHLsv3hsnTR07fHZXru5YufXRnvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502961; c=relaxed/simple;
	bh=OsH5t3HmSrwXO93kIZN24MXlgAqaxl4UZ41g6yyZqiU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kK4a1kO3M1vdNsfqCdsA1CWMVYD+SkmMkAFXX8W/pG6dmKt7pmvxrLgRHIO5GA6R1+2mUrdV/N+aTOpsURLTiO5Tic9Uhs9ugkZ5eHTiDYGdfSIq68NQ6Xl5fwQfLgC9RvVuRROb0W87rMMrk8yStG1obzKbgeTWEAgQruH05nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8iAS3YQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8iAS3YQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A7C4C4CEC3
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 09:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729502961;
	bh=OsH5t3HmSrwXO93kIZN24MXlgAqaxl4UZ41g6yyZqiU=;
	h=From:To:Subject:Date:From;
	b=s8iAS3YQ+9Q32GQz7JLaVn3/6CWTy+JrHDGh0vmA3hIupvDRsvMHKAVO+0YaEXLMb
	 UzV70XlDPq0wK8ybJL5K2oO4JZvNHJGRf/0fZotjYNYEhfqNRrzVJpSjrM4aXpLRHd
	 eDu0Ec7TCHlj5o2iJ7JWFfcfSEK4J8OF+dhfz1mKhpmDMt4B81Ny71ilEM3gDwgCeg
	 CjrmNgiJ9e4RZqm+v9naLJ+UHmTKbDVmGnAuSP/AJZBQddHUs0VsJyRQwsfQa5kD7R
	 U7LXpz489/wDDITxX3bykPG58otunRUuSMGFXKFmoSTpq9+OtS2xpvr2K/40VOezWC
	 i6mlfWjy3OUjw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 16E1AC53BC2; Mon, 21 Oct 2024 09:29:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219405] New: [regression] mt7922 bluetooth scanning does not
 work in 6.11.4
Date: Mon, 21 Oct 2024 09:29:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: eugene.shalygin@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219405-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219405

            Bug ID: 219405
           Summary: [regression] mt7922 bluetooth scanning does not work
                    in 6.11.4
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: eugene.shalygin@gmail.com
        Regression: No

6.11.3 -> 6.11.4 update broke bluetooth scanning for mt7922.=20

09:00.0 Network controller: MEDIATEK Corp. MT7922 802.11ax PCI Express Wire=
less
Network Adapter
    Subsystem: Foxconn International, Inc. Device e0cd
    Kernel driver in use: mt7921e
    Kernel modules: mt7921e

With 6.11.3:
$ dmesg| grep -i bluetooth=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20
                                                                [    5.1705=
54]
Bluetooth: Core ver 2.22
[    5.170762] NET: Registered PF_BLUETOOTH protocol family
[    5.170949] Bluetooth: HCI device and connection manager initialized
[    5.171130] Bluetooth: HCI socket layer initialized
[    5.171313] Bluetooth: L2CAP socket layer initialized
[    5.171495] Bluetooth: SCO socket layer initialized
[    6.574657] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time:
20240716163633
[    6.614305] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    6.614311] Bluetooth: BNEP filters: protocol multicast
[    6.614316] Bluetooth: BNEP socket layer initialized
[   27.410062] Bluetooth: hci0: Device setup in 20480957 usecs
[   27.410070] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection
command is advertised, but not supported.
[   27.687794] Bluetooth: hci0: AOSP extensions version v1.00
[   27.687800] Bluetooth: hci0: AOSP quality report is supported
[   27.687914] Bluetooth: MGMT ver 1.23
[   27.687951] Bluetooth: ISO socket layer initialized
[   27.784423] Bluetooth: RFCOMM TTY layer initialized
[   27.784430] Bluetooth: RFCOMM socket layer initialized
[   27.784432] Bluetooth: RFCOMM ver 1.11
[   27.955038] Bluetooth: hci0: Invalid LTK for a8:79:8d:fe:ef:cb

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
