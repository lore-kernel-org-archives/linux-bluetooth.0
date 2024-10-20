Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99C1DFDE
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Oct 2024 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729434278; cv=none; b=YeW3y1pxa/xB0BdBY12baQWkCJ7Zu9DYSfwfWFD+lYZQq+DAmnZaI5QbZTrCShqkVKtlrSlaqiKEMisS6H2QfkwvUhRQZKY6vD634olJFB1W3pbyG5cMO+hz//hSq2mwI60jqFyQMfVwo165W+7aWGMpoKiH8AtXSzfpHUyzfQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729434278; c=relaxed/simple;
	bh=Hbll/kG/KB+GCtoQql/EoSrvtGkrF2yDfdH1UudhbJ4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=L+jZfM8M4qZx2jUaf/eAdMslRZyONvEtnGJF7ljJtG6zuW1kkLeM1+QF/jYbvGvU5ESqF1Z7bRKqlTVgiG2JDPYlzH5iTZBT0ZyRKb0+fraHjXYYsBIQIscWANN1bdJYdeJ3xgnrSp/Gp0fVJwqCEc+xH4yqcd6f7+VKBpWEzs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIG15GtJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIG15GtJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 976FDC4CEC6
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Oct 2024 14:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729434277;
	bh=Hbll/kG/KB+GCtoQql/EoSrvtGkrF2yDfdH1UudhbJ4=;
	h=From:To:Subject:Date:From;
	b=qIG15GtJx8v0LVkXLarpmbqCYUaAsfQzEhygjI8Pn8X+I8flb46czC5ASRWAXJrHo
	 sYEeqDMvTbC7yiuQdGe7uAeTPY/hHODFUZILBY7XLZpsB702IPcOFRAyaBGuHK2NR7
	 EMvuEfU0GVb5JGaXmTULE9xGzaC/jhDLEKi8673FQDc4DzIM1iIzEGd6U4DFOXejgk
	 ai2uQ4wmxT+/S+MEFwsUZJ8M4m+zsLQwCQQYqjtZs5oFJppkhAVpJRpWfFZvZvZvD1
	 Z1MI9Wb11IdujQxRsAMWGcC24fovLOUsk2bQyGW/In2jD20iUsMvxKumy/AU3qOKA1
	 LVE3f1Gdm68zQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7E39EC53BBF; Sun, 20 Oct 2024 14:24:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219404] New: mt7922: bluetooth can't find any devices
Date: Sun, 20 Oct 2024 14:24:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: g.wenzel@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219404-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219404

            Bug ID: 219404
           Summary: mt7922: bluetooth can't find any devices
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: g.wenzel@gmail.com
        Regression: No

With kernel 6.11.4 the bluetooth device can't serach the network.
bluetoothctl:
[bluetooth]# scan on
[bluetooth]# SetDiscoveryFilter success
[bluetooth]# Failed to start discovery: org.bluez.Error.InProgress
[bluetooth]#=20

btmon:
Bluetooth monitor ver 5.78
btmon[6019]: =3D Note: Linux version 6.11.4-floppy (x86_64)=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20
       0.431526
btmon[6019]: =3D Note: Bluetooth subsystem version 2.22=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20
       0.431527
=3D New Index: F0:A6:54:5C:4B:F2 (Primary,USB,hci0)=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20
[hci0] 0.431528
=3D Open Index: F0:A6:54:5C:4B:F2=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20
[hci0] 0.431528
=3D Index Info: F0:A6:54:5C:4B:F2 (MediaTek, Inc.)=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20
[hci0] 0.431529
bluetoothctl[5675]: @ MGMT Open: bluetoothctl (privileged) version 1.23=20=
=20=20=20=20=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
{0x0002} 0.431530
bluetoothd[2715]: @ MGMT Open: bluetoothd (privileged) version 1.23=20=20=
=20=20=20=20=20=20=20=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
{0x0001} 0.431530

l
bluetoothd[2715]: @ MGMT Command: Start Discovery (0x0023) plen 1=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20
                                                                      {0x00=
01}
[hci0] 17.144334
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
@ MGMT Event: Command Complete (0x0001) plen 4=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                                                      {0x00=
01}
[hci0] 17.144343
      Start Discovery (0x0023) plen 1
        Status: Busy (0x0a)
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random


rfkill:
ID TYPE      DEVICE                 SOFT      HARD
 0 wlan      ideapad_wlan      unblocked unblocked
 1 bluetooth ideapad_bluetooth unblocked unblocked
 2 bluetooth hci0              unblocked unblocked
 3 wlan      phy0              unblocked unblocked

With kernel 6.10.14 it is okay.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
