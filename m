Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FBF285041
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Dec 2025 23:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767050762; cv=none; b=Ig93U8ryDSZ4D+/m4ELiPs/Wxr7GkS7fejKiCyYoev0jS0SiuGK1ce7KyAy+3luf/vq/vJS6gYCY+jGTRvNGnxfXiVQIzZkVkA/FTvmgw9VvL7CSqBe8MXRa71MrdOfy91FBxktOsECIfImzY/e559Z/LIMFRAazopsJgVO3Y2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767050762; c=relaxed/simple;
	bh=gOj4Di/wqYIHcgvgZifmmWhisETJHrtm4oU0Td0/Rsg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qQuZVe3+/YVyKjpFgZ2hWnEVRiT0GLKF+cw/9WIrdojhPFNj0RKp+LNJ/ErxZrIZKlMPN4ZMqWBSMAkggP94dwFYrg4K9mNafkBkx06nRD/J2gGcdkcYEgloW+BHMnsBNncRU3+Q7R6UZwUbsrPO4FJETEi/Tww0IxwOQ/DfQbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aO1uAC2/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aO1uAC2/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BC9CC4CEF7
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Dec 2025 23:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767050759;
	bh=gOj4Di/wqYIHcgvgZifmmWhisETJHrtm4oU0Td0/Rsg=;
	h=From:To:Subject:Date:From;
	b=aO1uAC2/qkjj9n90qFpRR5zioTyeIiaOy97+2mF/m0PrYIqXZ3CAdtphh+hdRbAve
	 lRHEq+YmK2eD9l/Wi64LlKi0njugyGh/5smLU3C2wJWHioS061OqVopDqK2tlpoWTu
	 P5SbzloToZAsWvV+AAwAUH0Cx9EcZEBKNKKKDodm4xQO0N+3AILC0AEbuyW61ojZmP
	 OtbQAJy+/W/6VdzQ1If7BrndxieZDR29CnCLlQX0MkjVpH/K5mfRzzLhZY5obstB2l
	 V0eIsB6bhk1SqOT1BOzYiBrJOuPo/F+s560JA2Rm0c49evMWxEybeWNTjbt6ipqRHX
	 f5yDTPp+dQs9Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8E40AC433E1; Mon, 29 Dec 2025 23:25:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220922] New: btusb: Add USB ID 0x13d3:0x3625 for MediaTek
 MT7922
Date: Mon, 29 Dec 2025 23:25:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lucenz@proton.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220922-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220922

            Bug ID: 220922
           Summary: btusb: Add USB ID 0x13d3:0x3625 for MediaTek MT7922
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: lucenz@proton.me
        Regression: No

USB ID 0x13d3:0x3625 (IMC Networks / Mercusys MA80XE AX3000) for MediaTek
MT7922 Bluetooth is missing from drivers/bluetooth/btusb.c.


  Without it, Bluetooth fails to initialize:

      Bluetooth: hci0: Opcode 0x0c03 failed: -110


  lsusb output:

      Bus 001 Device 002: ID 13d3:3625 IMC Networks Wireless_Device


  Fix: Add to "MediaTek MT7922 Bluetooth devices" section in btusb.c:

      { USB_DEVICE(0x13d3, 0x3625), .driver_info =3D BTUSB_MEDIATEK |
                                   BTUSB_WIDEBAND_SPEECH },

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
