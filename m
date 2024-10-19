Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D26317DE2D
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Oct 2024 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729373810; cv=none; b=jgyEi0skHPTxfiZnGsFx+M8aIWiTx2P0hQb5iZg+sPj238JebJesPqojzf/LqM2sp1fDuedq6dqeJCsQV5dDcTorXwsNCnB9mQruFb/YX102/Y6l1Egz0ugKB52QR/0uD7oaKcd9gEi0E+WRaYeDb4MPI4kbiMh3vHnkGqPIJhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729373810; c=relaxed/simple;
	bh=Mt5IklRoH0TrEq/e7kcvUz/bJ3i0+X243ahr587vsn8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gCdLeLnDoIXvKTiTqqqeVY+4Up9wy21hnHonV2t+Xa0gslRRdflZTVGh9G+fpBv/6TbTW7vP2AXYr7LhAN502RUiNFYeSb4yBCtxFdMjgczTe8celjBx9GAI1Ma+loK+Btv1FIKdeseO3wutcMnJnW1tIjpNbyBT6iFBKvoFqbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeULAaUl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeULAaUl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E369C4CEC5
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Oct 2024 21:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729373810;
	bh=Mt5IklRoH0TrEq/e7kcvUz/bJ3i0+X243ahr587vsn8=;
	h=From:To:Subject:Date:From;
	b=IeULAaUlG3XzqL27y8I2yBuqf4DuSfuN4Rzt/69LmSKBJk9sQG+ydtbKaeWgC+OiG
	 IEWZ85aO3SJ5T5EGFzNldrKsjA0b8iQ7+zu8InVRX+XflWO3rcGpJWRsiN+GoQjCKq
	 L/UFM2RLvK/vGy7LA/tCZuQPi75VyWVRapOUS87VcBFLn/8nkr4QfEv0r+om9NOZv/
	 hQQa057BS64QE9JgxaDo8pRgaVdi2YuNIaNwk5KZqIP/BvwSU3m+swCPodsbBAOSth
	 MA8NIcpNbEe1LT7/BlbfQGCxxIAmkEC1nPCA2rB0oAzeUFSh5A61zYONyFcDFYrCWQ
	 yuJEpu4F5GuNg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1D4A9C53BC2; Sat, 19 Oct 2024 21:36:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219401] New: Intel AX210/AX211 struggles to connect, has
 unstable connection, and bluez crashes
Date: Sat, 19 Oct 2024 21:36:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: acerspyro@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219401-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219401

            Bug ID: 219401
           Summary: Intel AX210/AX211 struggles to connect, has unstable
                    connection, and bluez crashes
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: acerspyro@gmail.com
        Regression: No

(Downstream Red Hat Bug: https://bugzilla.redhat.com/show_bug.cgi?id=3D2277=
661)

I have an Intel AX210 PCIe card for both Wi-Fi and Bluetooth.

Wi-Fi functions correctly, however Bluetooth tends to be unstable when two =
or
more devices are connected, takes a while to re-connect already paired devi=
ces
and occasionally bluez crashes, disconnecting all devices.

See downstream bug report for more details. A friend of mine with the AX211
chipset also has this issue, also on Fedora 41.

Please let me know if you require additional information.

# System Details Report
---

## Report details
- **Date generated:**                              2024-10-19 17:34:15

## Hardware Information:
- **Hardware Model:**                              Gigabyte Technology Co.,
Ltd. X470 AORUS ULTRA GAMING
- **Memory:**                                      32.0=C2=A0GiB
- **Processor:**                                   AMD Ryzen=E2=84=A2 7 570=
0X =C3=97 16
- **Graphics:**                                    AMD Radeon=E2=84=A2 RX 6=
600
- **Disk Capacity:**                               2.0=C2=A0TB

## Software Information:
- **Firmware Version:**                            F63c
- **OS Name:**                                     Fedora Linux 41 (Worksta=
tion
Edition Prerelease)
- **OS Build:**                                    (null)
- **OS Type:**                                     64-bit
- **GNOME Version:**                               47
- **Windowing System:**                            Wayland
- **Kernel Version:**                              Linux 6.11.1-300.fc41.x8=
6_64

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
