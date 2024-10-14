Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B98318035
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728924052; cv=none; b=q/jiCnwDJfCnkP+ioKlMEGRmpz9ZgLewEIgbaljsswZOteuHH+VLjijdm7nnZbZiF72N6dLDo61GTql/mb9s7EGciB6WXIiXwWJ0A3H+ypQwiCDkzYZGr9Et5PC0SrN7Obf3Ns0cZjXrElBfCAoFwHTdnPUy60PkdX9XshTAph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728924052; c=relaxed/simple;
	bh=go8og48TfBslsoT85nL92seg9hfWEDA9KCRD8qpmbS4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a4fwEdcy1PgShpfj2WNEOSMUgYvR0yh3Omj7Eehbcw7b1TiElmcOitY1V+pvXToFC7hmUm0Zq/lqk77vxNIg8blcWUaNsiC2NOr47ZV6cA8rs4dJdgaewUzP8M/KEAEju2f9HOxLJL3wIQedmn1mGUApy8a7oEJVWvf1wDnmERI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndleNBnZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndleNBnZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2352C4CEC3
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 16:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728924051;
	bh=go8og48TfBslsoT85nL92seg9hfWEDA9KCRD8qpmbS4=;
	h=From:To:Subject:Date:From;
	b=ndleNBnZppf+mmtGj8/iuPDk3j0hRFr+ZRkKE7CS6U+AKvZG4rVzL6uz4IN9sLszy
	 KcdFpmPuDnYmv7CWnuRPRQYtb64JCQT6wnoOOL5h5WbXYlsu2dwx+ckrh479cu0AoT
	 I02/RcDt46iNKGQwii99K73FvyBU+8wF385a4vlHX3cehM6dEQ2ov6VEEPAFsCXs54
	 Wfxp6yWcL1JqFOEKBcgDR5l+sgRxUdS44weKspH6br1n3O7ZDG62NzLMFu070ULKYu
	 8c/acJSq+NNAhBBxgtH6H1mU/aqSme4PXtf9rk6rGsq2VMSYNvphPBS+Zq8u8MjlBU
	 h5UL2kz2rQCLg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 91A31C53BC2; Mon, 14 Oct 2024 16:40:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219387] New: Bluetooth: hci0: Reading supported features failed
 (-16)
Date: Mon, 14 Oct 2024 16:40:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alexknoptech@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219387-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219387

            Bug ID: 219387
           Summary: Bluetooth: hci0: Reading supported features failed
                    (-16)
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: alexknoptech@protonmail.com
        Regression: No

I am getting a consistent error when I turn on my bluetooth adapter:

Bluetooth: hci0: Reading supported features failed (-16)



other messages:
[   12.312885] Bluetooth: Core ver 2.22
[   12.312913] NET: Registered PF_BLUETOOTH protocol family
[   12.312915] Bluetooth: HCI device and connection manager initialized
[   12.312919] Bluetooth: HCI socket layer initialized
[   12.312922] Bluetooth: L2CAP socket layer initialized
[   12.312928] Bluetooth: SCO socket layer initialized
[   12.396183] Bluetooth: hci0: Firmware revision 0.0 build 14 week 44 2021
[   12.399179] Bluetooth: hci0: Reading supported features failed (-16)
[   12.399188] Bluetooth: hci0: Error reading debug features
[   12.399191] Bluetooth: hci0: HCI LE Coded PHY feature bit is set, but its
usage is not supported.
[   12.505983] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is
unblocked
[   14.073552] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   14.073558] Bluetooth: BNEP filters: protocol multicast
[   14.073563] Bluetooth: BNEP socket layer initialized
[   14.077400] Bluetooth: MGMT ver 1.22
[   20.692302] Bluetooth: RFCOMM TTY layer initialized
[   20.692315] Bluetooth: RFCOMM socket layer initialized
[   20.692332] Bluetooth: RFCOMM ver 1.11

Intel Dual Band Wireless-AC 8260 with integrated bluetooth

Device Info:
System:
  Host: centos Kernel: 5.14.0-514.el9.x86_64 arch: x86_64 bits: 64
  Console: pty pts/0 Distro: CentOS Stream 9
Machine:
  Type: Laptop System: LENOVO product: 20FVS2NK00 v: ThinkPad L460
    serial: PF0IAXCS
  Mobo: LENOVO model: 20FVS2NK00 v: SDK0J40697 WIN serial: L1HF6B701KT
    UEFI: LENOVO v: R08ET71W (1.45 ) date: 08/01/2022
Bluetooth:
  Device-1: Intel Bluetooth wireless interface driver: btusb type: USB
  Report: btmgmt ID: hci0 state: up address: F0:D5:BF:3F:14:1A bt-v: 4.2

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
