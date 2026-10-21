Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792558602;
	b=sKAg2NnkL3ivOpJKQOIaC6tklwdlX/FjMj7irNaeGjqakarrRf7t4ZHM8m1xEbITabeL
	 IfT0hsK87AUWgOO4lYyhiExKQiwt7xe0iedmRDV3xG2eWYSA/ZVBedYaHXrA1ERbOuyiD
	 7D4i/Dp1G1I2vxeVd668UUZH/Tbw+ffVi2vFocjzyxKX6i8pqJjd8vsP+PrAWjx/K94CM
	 CrLN1RFAVZxrkU439o0kKV7rwEt52XTWmuavOLkSfZkyUkY2EuJJRvH6VwsTNUZwImeh9
	 OsKy+iJXnE7YEFh35mg37yxOUdNJ0NC5nyB2ogkJ2s4V90Sol/d4UlNDaH9RMJr9Uqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792558602;
	h=Received:Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=b5y9P59EMlZ+OPPP2FRpajZFydSCvyi8umiPandoCX0=;
	b=C6IGLdjdDy+7fz3E7r1faWOc9HWc6SpxvLen1WW4sb/987nf2dJetaxPO5Qjr2pQwscZ
	 JFBzNGorDba/qXh4aBXnX5+NsU59u1rc6Lt+J/EO4SAI2B8FTRH/R/3PQMW2lpU/fb4At
	 ohzVo77ck+jsIq1K3a/+SmJd34axqH4KGGbKKg6gHCCzPPPy8IW19shDuSwVxhlkXucv8
	 w/oqR59dSw6OhIVhtNKwv3Ueth42atJkjtBW6qsesCDm8Dnfm9BQ+abZk3YFMdozh1siX
	 W7ARAi3aEJHFHXiASSn762Rodf4waIgNWvKp+xd1pBbko8ddlMzaXaoG7C0AABn3IyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZWN+1LZ+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375E1606A319
	for <linux-bluetooth.vger.kernel.org@localhost.mlmmj>; Wed, 21 Oct 2026 04:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZWN+1LZ+
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFAC25771
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 04:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792558602; cv=none; b=b49Zlp95x+pIOw2Au8fpfllJGBMlF5QWr32IvR5n+F1qEtg0wWxcicCLeaW2V1G/1/A0MGSP7gaNUJ0r/mAqSgUF5sssBlgXSB07auggtnwTF2clZ6WBhd0SNmg8x3FInk1vHFPY3vTfj+0dkFgb1y7pTvxe2cT9h5ZzoI9dnjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792558602; c=relaxed/simple;
	bh=yw6b/XQ+v0IkUIuUmnvvKsA11QcNCM/JglTt3OPjOjw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GxI7ceDlsXJTDOA20FUyPYZpOkiuEWsb9deBA5eNv/6ek22LU2SJwOt+0I80gSocK9kQyF3oCgK9ID7zoCmCf1taaZme/UYi+9wugagrf35b6K+J73MPCqhU3rdjZ3ft0AlQDv/BURzmm4BnTXI/5aJXoVt/egLmzzey1udbqa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWN+1LZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D4ABC2BCF7
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 04:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792558601;
	bh=yw6b/XQ+v0IkUIuUmnvvKsA11QcNCM/JglTt3OPjOjw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZWN+1LZ+MTt5gb+6nsgbTHQyOdGoKDwHjlxu1F5EsvmDg6anXnqIGUan2L/Zm38DE
	 rozUjaYMGCmFAIFvUmpLt/wWtgZCa0FXbpdC4kyasvUxEr3wzJO6xZ5PS/iJCmaJvw
	 YkZc87hpmZko3xK70NhCsH2NhooiF7VTScbjGV9+NIJQu+kMFpQKllmS3Nh9fsZwVy
	 u/Sxd1C/hgSszL76ZSlqlPDwdlsq+sLFA6t4myGA+fvv1qphZLSi5GZvXOzZj3duaO
	 tswpBLBp6eMOx9jOfC7cWGm1SyBLvmLYalJNKPrEklGfv4ep70uZCT+Uq0qoB/YSqE
	 g8IDPQTdJx3gg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 54CB3C41616; Wed, 21 Oct 2026 04:56:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222164] MT7902 Bluetooth: firmware coredump after ~10h uptime,
 then &amp;quot;subsys reset fail&amp;quot; and permanent USB disconnect
Date: Wed, 21 Oct 2026 04:56:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hongweifei@cyue.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-222164-62941-IGjCAf8vML@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222164-62941@https.bugzilla.kernel.org/>
References: <bug-222164-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D222164

hongweifei@cyue.net changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|MT7902 Bluetooth: firmware  |MT7902 Bluetooth: firmware
                   |coredump after ~10h uptime, |coredump after ~10h uptime,
                   |then &quot;subsys reset     |then &amp;quot;subsys reset
                   |fail&quot; and permanent    |fail&amp;quot; and
                   |USB disconnect              |permanent USB disconnect

--- Comment #6 from hongweifei@cyue.net ---
I analyzed the captured HCI trace to answer whether the host side triggers
this, and
to separate two questions that the log actually supports differentiating:

  (a) what makes the firmware die, and
  (b) why the driver cannot bring the controller back afterwards.

## (a) The host is not triggering the firmware crash

From the btmon trace of occurrence #3, the host side was completely quiet f=
or
over
ten minutes before the firmware fell over:

    12:30:45.022549   < HCI Command (0x08|0x0042) LE Set Extended Scan Enab=
le
                      -> Status: Success (0x00)
                      (last HCI command sent by the host, ever)

    12:30:45.02  ->  12:41:16.37     =3D 10 min 31 s with ZERO host commands

    during that same window the firmware kept working normally, sending 19
    HCI events of its own (Authentication (0x57), etc.)

    12:41:16.374569   firmware starts emitting the Vendor Diagnostic flood
    12:41:18.025926   Bluetooth: hci0: Mediatek coredump end

So: no failed command, no error status, no unusual command sequence, no com=
mand
flood from the driver. The last thing the driver did was a routine scan-ena=
ble
that
returned Success, and then it did nothing at all for 10.5 minutes. The firm=
ware
then
entered an abnormal state on its own and produced ~6878 diagnostic
events/second,
ending in a 41 KB event and a coredump.

Also worth stating explicitly: there is no KASAN, oops, or lockdep output
anywhere
in the kernel log for any of the three occurrences. So this is not memory
corruption
inside the driver either.

## (b) But the recovery failure may still be ours

This is where I think the kernel side could help, even though the crash its=
elf
looks
firmware-side:

The diagnostic flood arrives through the normal HCI event path, so `btmtk` =
is
processing it while the firmware is dying =E2=80=94 including that final 41=
 KB event,
which
is far larger than any normal HCI event. Two things I would like to underst=
and:

1. **Is `btmtk_process_coredump()` handling a pathological input stream
safely?**
   11348 events in 1.65 s, ending in a 41 KB event, with 2372 all-zero payl=
oad
   fragments mixed in. If the dump path allocates per-event or has any bound
that
   assumed sane firmware behaviour, this is exactly the input that would br=
eak
it.

2. **Why does `subsys reset` fail, and can recovery be stronger?**
   The failure is `Bluetooth: hci0: Can't get device id, subsys reset fail.`
   after which the USB device stops answering descriptor reads entirely
   (`device descriptor read/64, error -110`) and never comes back.

   From the user side I tried and confirmed the following do NOT recover it
   (details and the exact commands are in my original report):
   USB port re-enumerate, driver reload (`btusb`/`btmtk`), unload-drivers-t=
hen-
   re-enumerate-then-reload, and finally xHCI controller unbind/bind. For t=
he
last
   one, the controller re-bound fine and every other USB device on it (webc=
am,
   storage, keyboard) re-enumerated normally =E2=80=94 only the Bluetooth c=
ontroller
   stayed dead. That says the controller is not merely stuck in a bad driver
state.

   Question: is there a recovery path that re-downloads the firmware to the
   controller over USB after a coredump (like a full re-initialisation rath=
er
than
   a subsystem reset)? If the firmware can crash on its own after hours,
"notify
   the user, they must reboot" is a poor outcome when the device might be
   recoverable by re-uploading firmware. I do not know whether the MT7902
hardware
   allows that after this particular failure mode =E2=80=94 hence asking ra=
ther than
   assuming.

## Summary of where the evidence points

- Firmware crash: appears to be firmware-side. Host idle for 10.5 min
beforehand,
  firmware answering normally right up to the moment it starts dumping.
- Permanent controller loss afterwards: possibly improvable on the kernel s=
ide,
  either in coredump handling robustness or in a deeper recovery path than
  `subsys reset`.

Happy to collect more targeted data =E2=80=94 e.g. ftrace on the btmtk core=
dump path,
or a
run with the flood piped through while watching allocation behaviour =E2=80=
=94 if that
would
be useful.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
