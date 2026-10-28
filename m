Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793189525;
	b=RVw2QxQH1wSZOtXIJjeeoeW/1obIf7ryK+BHIdx2J4FxQSCsjvulqSyeWJWOMq5X6Zaa
	 zlJPQYmRYMWoihiCDn9uQKpzYOHZh0eZksC4JbkQ7yjvpa2cg205a4nE9gjdbdkMWIDrz
	 UqwgabpMdKlZ0MFX0frY/ZJ/jnWk0r5rboTrDzxwXszsFogbdgRmPFZM809HfyXberUnI
	 gb1SYZAEzrYMYLddO4HaRdC4bIx1RmjedSGk80HVsDasycfdhF2WKjkx9Jb3+CeEAJDFr
	 xtiPP4nkaS1TCC3wPJVWHQItc0kmaZ+Uz8Jwb5YluR0gD9YeJFYtxygFS9rLSxBYXYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793189525;
	h=Received:Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=Jn7OD8JNuaHi3Gv+2mblL/UjhhCE8AMUHJyMPpAYvFg=;
	b=vLscsQ2zq8HI0NHTZ6BU69rLQXtuNZ6j3GeJ8J1ARWqIj6B2p6cknwwXgyFv8qsTtv4D
	 Bn/rq2iIsPOG1Nk5Uh/O9TxNwIIgqysl0pIjLp/x5E5evKGVVeuGDryZKbse6gl2Wnl0Y
	 n2RdTGg1WSCS/yM7Yqod7/FSxra3+SB+I6n7b2uED0JKgIYCscrn2DyTF1gVDSYuDj/w4
	 yX5+iBMiJ2L4/o13qgGpgZ8OL4ma1gWFjm5p2UqFavwivCc2e9QYGpruVb79chnEtnCgo
	 vXWCe9n4OOCqyk+Gg3ZmlmqgRcxu3ClnVXLk1qj+H+qbRpuO5ZsQqaBuae0PQcq4P2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b="Hm/kX7R0";
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E59F606A31E
	for <linux-bluetooth.vger.kernel.org@localhost.mlmmj>; Wed, 28 Oct 2026 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Hm/kX7R0
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86596513C0
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1793189525; cv=none; b=Y+JRbgry4PO3iH3jZfmP0dEgNfppsxlpY1H3nANJqkMW+A6ZEPG6YtmYBh3gs7+iSAXRCCD38Myds1XmQFvTcdfM7gZJMU9qyYadxjLW1BU+09u4ZYtO3f32jkDGPqR4DEKs5dBAyjBNQXo5vulZGfNbtr0I8VXFWVjNF/YIouE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1793189525; c=relaxed/simple;
	bh=H3a+/LaEqysK4SGiMnOp+TuUvunECtp9mFQ88KuIQQk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TRjMfrC46HZXeL4s2ctuqkUNJ8Oi86VG5IadvVNOzgCI0VVqILo7pGs7pa5pE8UX6Df39BMdu6Mcrd0ySXaDz6exnoAtujnqskZgHombaygSDmeMVrssMAUHx2675+pe09DnspIxIsgiGxJPcu7LshjfDeTjPG3VMm8ptK71Nm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hm/kX7R0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25EFDC2BCFA
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 12:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1793189524;
	bh=H3a+/LaEqysK4SGiMnOp+TuUvunECtp9mFQ88KuIQQk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Hm/kX7R0xBHnOYw01sw7IplmW8j1TFIeQtfrDqoDohJI4Y+qHvEtyaanlxb2rlCpN
	 dNd7tvyewFMoSfGZaQ6Ic3Jwbk79Tj39pixPxo5CbFtGR9L9auo50zSzN/kZFftN71
	 yPZan1RbISVmQungTflEaEPeKQH82EriMiwTW2ft+CsxCf86pKLhNU3DJ5tOd1yBvB
	 jVyXq5WDfchukb09PDNjJpWSDkr53XfcO0GRNZghx1HshtTeUr1HAeYPmzBt5ctsVn
	 OIZZboW42dRZ5GfKo3pZnuuhcxbfNacc7/w/Sx+f+goXEHnsIve9ngQ35GWo1oQUEg
	 Qgruvys2qAdnw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E8BD0C41613; Wed, 28 Oct 2026 12:12:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222151] MT7925 (0489:e111): BT firmware 20260813113236
 (linux-firmware 50e034a2) breaks HFP calls and fails WMT init; 20260605184935
 works
Date: Wed, 28 Oct 2026 12:12:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: purpleritza@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-222151-62941-U86ivLQYv0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222151-62941@https.bugzilla.kernel.org/>
References: <bug-222151-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D222151

--- Comment #1 from purpleritza@gmail.com ---
Correction after further analysis: most of the call failures in my original
report were NOT caused by the firmware. The repeating failures correlate wi=
th
the wireplumber version, not the BT firmware build.

Per boot, counting "Failure in Bluetooth audio transport" loops (>=3D 4 wit=
hin
3 minutes: HFP/A2DP profile flip-flopping, both bluez nodes going to error):

  Boot start        wireplumber  BT firmware build          Loops
  ----------------  -----------  -------------------------  -----
  2026-09-28 12:40  0.5.15       20260813113236                 0
  2026-10-03 11:07  0.5.18       20260605 + 20260813            3
  2026-10-07 11:36  0.5.18       20260605184935                 1
  2026-10-07 11:59  0.5.15       20260605184935                 0
  2026-10-15 11:00  0.5.15       20260605184935                 0
  2026-10-17 19:53  0.5.15       20260605 + 20260813            0
  2026-10-25 15:49  0.5.18       20260605184935                 5

Every loop happened on wireplumber 0.5.18, with either firmware build; none
on 0.5.15. I will report that part to wireplumber separately.

What remains attributable to firmware 20260813113236:

1. WMT init failure on this machine:

  BT build        Loads  WMT init failures
  20260605184935     71  0
  20260813113236     16  2 (2026-09-27, 2026-10-17)

2. Single mid-call HFP drops with wireplumber 0.5.15:

  BT build        Time on wireplumber 0.5.15  Mid-call HFP drops
  20260605184935  ~16 days                    0
  20260813113236  ~7.5 days                   2 (2026-09-28, 2026-10-19
12:02:56)

   The 2026-10-19 drop is the log in my original report. The only drop seen
   on 20260605184935 was during A2DP playback, not a call. Small sample, so
   weaker evidence than the WMT init failure.

Current setup, no call problems so far: linux-firmware-mediatek 20260810-2
(BT build 20260605184935) + wireplumber 0.5.15, kernel 7.2.11.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
