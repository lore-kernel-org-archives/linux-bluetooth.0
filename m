Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E4944C657
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786618698; cv=none; b=LAvVE0Hsc2KhUJ2TOExsNZHBg7SBTStRCYnELst6ySz+vKkPbchQlUH7i/WSU4NFiZYMaUd2Yeo53EpNGqJjxagHca8YqTa+2QSa9Q6Tg9jmH1fVXk5Tr9w4ay+eyzn/MIJdezXASzlH12DGJ9k5MFlxoNKtoXU7EEc/o8qUmqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786618698; c=relaxed/simple;
	bh=hVT+Gq6NBklcWsrRWfp7FYXjX8vNlJloHCnn2xUJDCY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HYOa8ts0Z7XmQM7erPPXOIKaEtyvObbEfYwk6EEsGukU6+1tIls3a4X7Z+qbhR57YAV68LL/ChQNswmsP7pZ6pTlEdClrT92VCs9arBggRbArcyPy5uTigeQG4FTWtnA21v+aEgKGj4nGuEqGkwX2l1ARqB59TzgJfKtClIzfQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHqnj4Yg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHqnj4Yg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0620C19425
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 10:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786618697;
	bh=hVT+Gq6NBklcWsrRWfp7FYXjX8vNlJloHCnn2xUJDCY=;
	h=From:To:Subject:Date:From;
	b=JHqnj4Yg39mhlGlj0zZn+x/Ueim3tgBd0v3qDq2EMzobWsNWHf7sLo3az5x5ClYHD
	 ju4Gtyr3mcsBEVlGFi8A+ew52mlbyC9G43SpicGmuKZsUxzeEDW9lwJmN0gexXqog+
	 HDAOWW25tqeL08clSVDiULPhORLy7BymDzxu95K0I20ru2sSqxKKaQ/pdUf8Ar8KZU
	 YC/yt1aKXnNyJa1uwC5dU+zT/X0B2tTYpXutvGyr3yQkC+GDIVDiEjHhp9m6pCESi+
	 XxSWrMyXQq7llWqy9CrmfY15V+8c8eFhfqa4wg+izq5BItmHzCU8eWm11qpDiedvCq
	 U7LqlehggNTuw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9B3F5C4160E; Thu, 13 Aug 2026 10:58:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221878] New: MT7902 Bluetooth USB 0e8d:1ede firmware crashes
 during use; reset fails and controller becomes unresponsive
Date: Thu, 13 Aug 2026 10:58:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: maksheev777@mail.ru
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-221878-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221878

            Bug ID: 221878
           Summary: MT7902 Bluetooth USB 0e8d:1ede firmware crashes during
                    use; reset fails and controller becomes unresponsive
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: maksheev777@mail.ru
        Regression: No

Created attachment 310636
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310636&action=3Dedit
Complete MT7902 reproduction report and logs

## Summary

The MediaTek MT7902 Bluetooth adapter (`0e8d:1ede`) initializes and works, =
but
its firmware crashes during normal use. The subsequent subsystem reset fail=
s,
`hci0` disappears, and USB descriptor requests time out. Recovery requires a
full laptop EC/power reset.

## Hardware

* Laptop: HP Laptop 15-fd0xxx
* BIOS: AMI F.14, 2024-12-05
* Wi-Fi PCI ID: `14c3:7902` (MediaTek MT7902 / Filogic 310)
* Bluetooth USB ID: `0e8d:1ede`
* Bluetooth drivers: `btusb`, `btmtk`

## Software

* Distribution: Arch Linux
* Kernel: `7.1.8-arch1-3`
* BlueZ: `5.87-2`
* linux-firmware: `20260810-1`
* linux-firmware-mediatek: `20260810-1`

The same failure was previously reproduced on Linux 7.1.6 and with
linux-firmware 20260622.

## Steps to reproduce

1. Shut down the laptop, disconnect AC, and hold the power button for 40=E2=
=80=9360
seconds to recover the controller.
2. Boot Linux and verify that `hci0` initializes.
3. Connect and use Bluetooth normally.
4. Wait several minutes for the controller failure.

## Latest reproduction timeline

* 15:32:23 =E2=80=94 USB device `0e8d:1ede` enumerated.
* 15:32:27 =E2=80=94 `hci0` setup completed.
* 15:33:08 =E2=80=94 Sony WH-1000XM5 connected.
* 15:41:54 =E2=80=94 MediaTek coredump completed.
* 15:42:04 =E2=80=94 MediaTek subsystem reset failed.
* After 15:42 =E2=80=94 USB descriptor requests failed with `-110`, followe=
d by address
failures with `-62` and USB disconnect.

## Key kernel messages

```
Bluetooth: hci0: Mediatek coredump end
Bluetooth: hci0: Can't get device id, subsys reset fail.
usb 1-10: device descriptor read/64, error -110
usb 1-10: device not accepting address 3, error -62
usb 1-10: USB disconnect, device number 3
```

## State after failure

`bluetoothctl show` reports:

```
No default controller available
```

BlueZ remains running, but `hci0` is gone. Reloading `btusb` cannot recover=
 the
hardware because it no longer responds. An ordinary reboot may preserve the
failed state; a full EC/power reset is required.

## Additional observations

* The failure has occurred with Sony WH-1000XM5 connected.
* It has also occurred on another boot without the XM5, while a Bluetooth
keyboard was used.
* Restricting WirePlumber to A2DP and excluding HSP/HFP did not prevent
failure.
* Updating both the kernel and MediaTek firmware did not prevent failure.
* A devcoredump entry existed immediately after this reproduction. Its data
file was deliberately not read/consumed pending maintainer instructions.

## Expected result

The controller remains operational, or successfully recovers after the driv=
er
initiates a subsystem/USB reset.

## Actual result

The firmware crashes, reset fails, the USB device becomes unresponsive, and
physical power recovery is required.

## Related reports

* https://bugzilla.kernel.org/show_bug.cgi?id=3D221380 =E2=80=94 same MT790=
2 USB ID. That
report concerns unsupported hardware; my controller initializes and works
before crashing at runtime, so this does not appear to be a duplicate.
* https://bugzilla.kernel.org/show_bug.cgi?id=3D220986 =E2=80=94 related MT=
7902
initialization report for a different USB product ID.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
