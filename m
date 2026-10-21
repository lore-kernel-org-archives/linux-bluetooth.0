Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792558266;
	b=ZQ+zVlQf9nkmHWZb0SFA5A0Cxn9UklmXMYXojQP+NVL4v2QB5BaihXhw7e9U/cCe0HP8
	 YbI2D4iLrQ1i2D68cPAdeNfPEDAe7G1l4G7GCT7IQRxNm+wRcqrRuxj0D/WYnpgQn29uV
	 NYP5zSWQIGA/sXarcDg573AKwMggG5QJk3+g9BxoyeUHNlt44BqYmUFu7fOSWkkmVxaIk
	 xQ5m4C2EaPl55v117J1slFSmLl5nQ9NwJ9yoSARmFI3KV+b7w1AiivM2O7IWQEd5+GLKM
	 4/dZjNsBKxvI0X5lVJvgfOCPJ4WaT1NvK4m++gYhZe46WrPdyWwb8xADGWI4pi/J9eQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792558266;
	h=Received:Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=JJ1FSimwED83OgpUlTCJYtKR+z4lIh++IO3nflOYYXk=;
	b=DjZfNsqhI8R9Kv1lWz2qbjo4zXGeiL16wlTZHWs901/8avD2z3r0ozHX9rOiMLLdlsf7
	 06X3j9YZlaVUUyPu9NwSsCUCgWKEQaT/R6F84DpyoqUTOaS/UPOMY2aaZZepZCQa9iRiP
	 VT2n0Mhee+rDlL8cBVXiSeb5m3QptUezqWT89+tU8XnDuKBatB0o00zRBzlU/aw2A6cLX
	 M1mSuy+NxNEjC5zjFJOUn7MN7g2ibU206m+0GSGdnbayVpXyZux/B/o6REabze1RkFNtV
	 HtRO2wAUTDNG4Zn4u17ltVg8u/51ndT73DF3Ye8SjIOsk9adRm+/5Bv7w1QTxGUshPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MKWEJGHz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37199606A319
	for <linux-bluetooth.vger.kernel.org@localhost.mlmmj>; Wed, 21 Oct 2026 04:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MKWEJGHz
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B2125771
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 04:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792558266; cv=none; b=cPIhjv4mB+C2PGBxvO75NWcCeSAPn8NK260MuHWzBBI2MBtPt2zWKqZld9zNOEAfdbXyb6JHS1NEX0soUqM2tXy1GFU+f28W7BVLnnsLUikXDlOQ0GNJcqNdVULkT2ZA/NNye0fyXtOfcIziXpcIsZtsshANJaFN5W+Y9znEXTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792558266; c=relaxed/simple;
	bh=jmuSxAQmko1jhgiE7jTK28itcn/LP/njpaeRQVEWveY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DibUM60j1vNXJ8SRsJV+lX4pu2bXb+Bx0YyIHhF6Dl5OKX8frrH8rpb9l59cPdVmWTyeYXPBJRHuDEH8Jb60etLJ5nFqbHuWpNKzIa+tykDmH4+NUOgYmlezqxYYYZUKDLCuOQtCgBOybKTRSJ3SV1nYvruGvLSvudh+kTFX/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKWEJGHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E077CC2BCF7
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 04:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792558265;
	bh=jmuSxAQmko1jhgiE7jTK28itcn/LP/njpaeRQVEWveY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MKWEJGHzfs0hTxlxe9PGF9MPUqERPekVGNSLMoI5FFJKHfvRxHE0YtqNspFWpYn8r
	 iVyT5yBXelhN3BJc0q0GjdpP2+UDFGjLtma9U5ZE3vLXxyT2XrmHw4hIMm0lAe38XO
	 Q227pa7dOgv4e0fc5oRdVfHb+xPO+Fh/Yc+EZpnVTqIkQuzoBcpCc9E1Yqu+1ka4+V
	 XoHK2srtWcwcpGvkn65JNjhKmq+HvxFa5F4a3VM9a9YWTGmLyyT+dJTM9Iv4rWPHx6
	 izl/na2O4xHk1e7MRI+Hm9REuDyUAE6vvJxOHae49KuxqqWKkQRMLBT9DSXnD4mARc
	 iFejk5d+ZEV4w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CD9D4C41616; Wed, 21 Oct 2026 04:51:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222164] MT7902 Bluetooth: firmware coredump after ~10h uptime,
 then &quot;subsys reset fail&quot; and permanent USB disconnect
Date: Wed, 21 Oct 2026 04:51:05 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-222164-62941-CYISdv6PE3@https.bugzilla.kernel.org/>
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

--- Comment #4 from hongweifei@cyue.net ---
Created attachment 311214
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D311214&action=3Dedit
Crash #3 quantitative analysis: 11348 Vendor Diagnostic events in 1.65s, 20=
 min
of silence before coredump, uptime comparison

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
