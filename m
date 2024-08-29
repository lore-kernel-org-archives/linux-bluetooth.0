Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF72E1AC8A9
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950604; cv=none; b=gwcK6HLIiVBiU9YgUyQNE3uBhLbfZe7ZWR2YZrLHFKdFiPmGYlJMvatjznWo+rOiQw9EYYWyfdI0mS0midHwvmJuotGqeFs/T9EkippScKLEm/WklrpEdK92Ae6xl39FTzrq5FS5Zh136IY90JTvk1YOyqvfrSOS+5HxIXg2eGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950604; c=relaxed/simple;
	bh=+r1nXpu3BPQkrbGv1ozsrrv3XUNS2q4fMZrkhfExxSY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qUUE4ZMo019tEBTHN66zlh8QMCc14nWlJjfxx+b93ntCQii+74X9TszHQyBomAurXfdlGaFKCACDY+DVSP29Ig+J8BrQmnpRN+mX5//13L8ldGQDETAC+fzOOcwHXYdTd7RvqKUEXdz0M5VnW5S572vdvbJ0UcBmj04za22GG9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erDEB1j8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erDEB1j8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DD42C4CEC1
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 16:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724950604;
	bh=+r1nXpu3BPQkrbGv1ozsrrv3XUNS2q4fMZrkhfExxSY=;
	h=From:To:Subject:Date:From;
	b=erDEB1j8JRFXuMI79YNECRGnSo7MJdfA1Jydbk9TyVfvMLWTai6x+POOOxu2ZPl8s
	 mTpHm/+3gOfnQGSqWOd/qE4NeRQMXl2AVVAXAMmnfMoUR70qAMEMkBpjxsnLWip5O5
	 Ue2CcPEu0v2PNtz2OZyy/3ZeRbnnv1MQoZDIrf5Cn35uQBhhwkIBvjnkNIJ+hOorOV
	 a9kvGFKssJ0pLi9OV5JBinUNZUluAQYbtHBD7dcmlUnI5mK57ZPdq3+2ha5t69EeW3
	 AIIRmeAmhx5F+6vOeysgc82RFEfZd2rkTg2Vg5GYT3jJmqtbuv8HrxDosjoIxNJcKB
	 KavcPI5iNOZHg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1B0D6C53B73; Thu, 29 Aug 2024 16:56:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219211] New: Bluetooth not working. Bluetooth: hci0: Opcode
 0x0c03 failed: -110
Date: Thu, 29 Aug 2024 16:56:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aprilgrimoire@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-219211-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219211

            Bug ID: 219211
           Summary: Bluetooth not working. Bluetooth: hci0: Opcode 0x0c03
                    failed: -110
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: aprilgrimoire@gmail.com
        Regression: No

Created attachment 306791
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306791&action=3Dedit
output of journalctl -b 0

Bluetooth adapter not working:

(base) april@AprilGrimoire-Mechrevo ~ $ rfkill list
0: hci0: Bluetooth
        Soft blocked: no
        Hard blocked: no
1: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no
(base) april@AprilGrimoire-Mechrevo ~ $ bluetoothctl=20
Waiting to connect to bluetoothd...[bluetooth]# Agent registered
[bluetooth]# list
[bluetooth]#=20

I see the following error message from kernel:

[    3.545797] Bluetooth: hci0: Opcode 0x0c03 failed: -110

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
