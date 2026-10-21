Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792558257;
	b=X1pAtjgmRgkAP7LcdJeAJjCzl5aJ08xvssaQ21WvxpouaaE75KRb0fyUnPapgtGE8J2s
	 ORdeqIBbHOPGINnsDeli63ue28ZT6uRWqKIMr6ql8ov46+9GzB9imvb6t74nL9BXng91i
	 3TanTK93UH0+QbgopF/uflYXmph75Geu2OHLOGjDWV9aI7yHkS/gwFu/bQEDOTxAcpiO5
	 iuoqPoExHYGLBijmG3e9mmISuHK+00VYSh+8Gy/thzUNh+4VXWFAkJEOvIfXHPYyhUwX8
	 nHAvgM2hJIMWYUC2rJe1/HFzHISpXkwvp5s8/Mmg3ehN/JyVDpdG9O4K38es+Gb3EMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792558257;
	h=Received:Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=XFF1mjn3mXgcf70DODAnBwD7Okr4qvjo485L9Y5UhaQ=;
	b=eIdgzgJ7sc1bK/9zoNOiJmKthNukZ4txmMXFQtSiwf4eQZjoVai2//3KVUPRUr0yKxC1
	 8PtR9/barZVCt/00i8Kg+NtU3r3JU5MjA8EwwWLVaXAfEmhGTiofRl6UhVyAst2KTmboE
	 ySx3+ZJ00Xun/WON49mfVqyE8SjULc8+Nt1OZ5kz9nra5QCjulk2+557REMJkba+gWMX1
	 HorjAusv8OD05eAiisNelCktJjVy74yH5U5UMqpkinrAAD4gsBALFyS41N0i6P2OfSG88
	 V47TtiqsiRN8V9ejkIVrqO4JhR+AW3EWeO7Irf2s19k0Rcob1YUsX4HLOB2FN6j51BQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VqQUZscL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DC9606A319
	for <linux-bluetooth.vger.kernel.org@localhost.mlmmj>; Wed, 21 Oct 2026 04:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VqQUZscL
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7584F25771
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 04:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792558257; cv=none; b=ROqf3Jz5EIp+KKCIZk+wy5k0QzHHHGKadELNCPnVuVQfvhOJKRCR4jIut8EtAHEh6bliNzjSs1MX+G+j+fUfUH99Un2TV0ymBc/PZ7BiwmgZaufFs1MaCB7L7FdXxxDzS5f4WMS0Ak9SLDS2MuJaYOyK8AmXcOUY/L6vqVkbo5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792558257; c=relaxed/simple;
	bh=hjaB6fyXgo5/yK4gtFi2a+XObqR8v/3zwQ2Rbq9iksI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A0rIyHeKQKFTEq5cKvw7YbMCfJZnBdsxaVwx3QbR7WfJHCbedNUng0xNY3BttpkzQbriBK6cWhfeBF4ZTisxUbLM71XJRat171CAijNx0KCe7Iwh2V+yeGNYOmGqWcq4CNqNB/bmqh+FLWGYJR3ytwuTW/xojQnhrN2frVqxtGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqQUZscL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01D47C2BCF7
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 04:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792558257;
	bh=hjaB6fyXgo5/yK4gtFi2a+XObqR8v/3zwQ2Rbq9iksI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VqQUZscLU3B4yWjFp17Q5kdB0gwTfVgkylxT3wh6BREz16CIzzDzB94EZyB2TG/dA
	 e1dzK/zmi0MnI+u7CPY3xiu+m8dEAS+qrMkTCZSNMe7eWfFqSPse7gdIeiSPH9/Crd
	 EFmAMWRiPRQvRhOhqB1noMHUWSb74PBZYLxU3e4adgqmjMGsY/0hgaAL0yuFI/5Spo
	 Qf765pMm2rgON2p05ouZLiUfGMRcbbWCfSVohVcv1xAYvmQ3H6XhvF/5hchJXGn5pi
	 WmxaD3Ts7LT5cfhU6iMEIe3IgMEzFTxKEvLqDHd2l0M9XqLjf7enCfp8bzpOsqlBBw
	 XQKsN310vTlLw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CCABAC4160E; Wed, 21 Oct 2026 04:50:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222164] MT7902 Bluetooth: firmware coredump after ~10h uptime,
 then &quot;subsys reset fail&quot; and permanent USB disconnect
Date: Wed, 21 Oct 2026 04:50:56 +0000
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
Message-ID: <bug-222164-62941-VmpMye7u7E@https.bugzilla.kernel.org/>
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
                   |then "subsys reset fail"    |then &quot;subsys reset
                   |and permanent USB           |fail&quot; and permanent
                   |disconnect                  |USB disconnect

--- Comment #3 from hongweifei@cyue.net ---
New data: captured a third occurrence with btmon running, and it revealed
something
much more specific than the original report.

First, an important correction to the timing pattern in my initial report: =
this
time
the controller died after only 2h38m43s, not ~10h.

    #1  2026-10-19 10:19:24 -> 20:21:44   =3D 10h02m20s
    #2  2026-10-20 09:50:30 -> 20:01:29   =3D 10h10m59s
    #3  2026-10-21 10:02:35 -> 12:41:18   =3D  2h38m43s   <-- much shorter

The difference for #3: btmon was running for the whole session (I started a
capture
at 10:02:35 to collect data for this report). btmon subscribes to all HCI
events, so
firmware event traffic through the driver was higher than usual. I cannot p=
rove
causation, but the correlation is worth noting: the crash came ~4x sooner w=
hile
the
monitor was attached. If a firmware-side counter or queue related to diagno=
stic
events feeds into this, that would fit.

## What the capture shows

Immediately before the coredump, the controller emits a massive flood of
MediaTek **Vendor Diagnostic** events:

    12:41:16.374569   flood starts
                     -> 11348 Vendor Diagnostic events in 1.65 seconds
                     -> ~6878 events/second
                     -> final packet: len 41047 (41 KB in one event;
                        normal HCI events here are tens to ~200 bytes)
    12:41:18.025926   Bluetooth: hci0: Mediatek coredump end
    12:41:28.338162   Bluetooth: hci0: Can't get device id, subsys reset fa=
il.
    12:41:28.370      MGMT Close Index / Delete Index  (controller gone)

Two further observations:

1. **Normal traffic stopped ~20 minutes before the crash.** The last ordina=
ry
ACL
   packet is at 12:20:44.820571; between then and 12:41:18 there is nothing=
 but
   diagnostic events. So the firmware appears to have entered an abnormal s=
tate
   well before it finally died, rather than failing instantly.

2. **2372 lines inside the flood contain 16 consecutive zero bytes** (all-z=
ero
   payload fragments). I have not confirmed what they mean; possibly invalid
memory
   being drained, possibly benign padding in diagnostic records.

Sample payload from the flood (first bytes of one 202-byte event):

    6f fc c6 00 5b f0 1a 41 00 2c 51 74 dc 31 5d 5b
    f4 1a 41 00 2c b1 54 bd bf 5d 5b f8 1a 41 00 2c
    0a f2 83 2a 5d 5b fc 1a 41 00 2c 19 a6 39 7b 5d
    ...

This looks more like a memory dump than a meaningful diagnostic stream.

## Attachments

- `mt7902-crash3-analysis.txt` =E2=80=94 the numbers above, in one place
- `mt7902-crash3-vendor-flood.log` =E2=80=94 excerpt of the flood: first 40=
 lines at
  12:41:16.374, a middle sample, and the last 300 lines through
  12:41:28.468 (close/delete index). Kept small on purpose.

The full capture is 86 MB of btmon text plus a 15 MB btsnoop; I can upload
those
somewhere if the excerpt is not enough. My question: is there anything spec=
ific
in
the Vendor Diagnostic stream you would want extracted? I do not know the
MediaTek
diagnostic event format, so I can pull whatever subset is useful.

One more note: after `subsys reset fail`, nothing recovers the controller s=
hort
of
a reboot =E2=80=94 details already in my original report.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
