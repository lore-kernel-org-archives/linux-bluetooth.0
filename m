Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E693E1233
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779179073; cv=none; b=ASivvH/Fj8CkCp4omhK+GJk8fscq88qBrlFkYzzgzbmSPGxB+/zo0kE958iMuN4a+K03+7IEEMXuThzHcAVlJlSZVL8ocsMVIECurcvTn+DCiPn3hJLmBP/OjLEjyEFfwtNflwoNPAmfnP6GmqJe06/kdBxvLstiHYC/7J/xREo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779179073; c=relaxed/simple;
	bh=v/q/f1jzicN8ckViKafh25OEKIYmQcQyUaEDO9C1W8U=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WNk7uUOuIYxHdd5V4sBXoMCrxMWe5WaD/qj54Lb7+/FL+ci8dibkUPKioUD0WOMjp8f2pSqFm0gAJEGR7ukq2esrDWtJQ3e26F8wdNndxAVkUw7EXkdCjaix5B4uTS5nRN/83AYuqiAu+IGxNXRNmHdPeQ9TwBt09sApSR8DOT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfF9y50l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfF9y50l"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C268C2BCC6
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 08:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779179073;
	bh=v/q/f1jzicN8ckViKafh25OEKIYmQcQyUaEDO9C1W8U=;
	h=From:To:Subject:Date:From;
	b=JfF9y50l6MLz8zlnSiZYJSmm2zRljmKP8FFPJLIJ3WvCfglevZeyRQTjAGgYgbiqH
	 XiruX+rZldytUlx7sr6MA82tEpjybq/QPu/MBM41DM4rrGlaayQJ6aJCtQP9Irj0XE
	 ByLMLQ4MSwF8gJest+TslFocAHnmkH01SEWdVd5bYPz+90svndaB/UsMw1YgzPlN4k
	 mhkujNSaVYP6NNOAeOuMSvHalBzMserbAIhQg4CobmGqSy9KEwpHlfarJUBwcQ5ywf
	 Gu4u5g89jciln4NGbZFk2IOxb7EMURpvM5L3KNdSwBXCmR9YerfANU6Wav9nnaIQm2
	 UDJyhrEJ7BErg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1841EC4160E; Tue, 19 May 2026 08:24:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221547] New: MT7902 Bluetooth: Failed to send wmt func ctrl
 (-22) regression in 6.18.31 and 6.12.32
Date: Tue, 19 May 2026 08:24:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: olle@vixit.nu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221547-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221547

            Bug ID: 221547
           Summary: MT7902 Bluetooth: Failed to send wmt func ctrl (-22)
                    regression in 6.18.31 and 6.12.32
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: olle@vixit.nu
        Regression: No

Adapter: Foxconn/Hon Hai 0489:e0f5 (MediaTek MT7902)
Machine: ASUS laptop (asus_wmi)

Works: linux-lts 6.18.26-2
Fails: linux-lts 6.18.31-1, 6.18.32-1
Works: linux 7.0.9-arch1-1

Kernel error:
[8.509092] Bluetooth: hci0: Failed to send wmt func ctrl (-22)
[8.509685] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection comma=
nd
is advertised, but not supported.

bluetoothctl shows "No default controller available" and power on fails.
rfkill unblock bluetooth required after each boot when using working kernel.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
