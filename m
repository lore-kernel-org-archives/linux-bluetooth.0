Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B201314A6B
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2026 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777675038; cv=none; b=Sj0cxEHIJua2P2f+3bDllYgiTh3+LtEo3MxasBixtVs97rDFuYxJcXnxMGjVaPRy7XiwtCG8tzLeqA9DFw94WPnBW97JdGeUoQq3LV6eIqcWitv4m8xqR/5lYjpd+7u/9mMv7nkGnoFV5y3S8g21SK0oLITEsEV3zTZv0lKXV7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777675038; c=relaxed/simple;
	bh=0TPYHWLgKXDiZGfNntI1eu+VssfCrhcSIw71mw77xfQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gdF4o0iZ70z+rpkWCtbeyoz5R50iLjVn57MBB9O+PANiirrgIf7ljybn/N1VbtZraa5qDfur9+dwzgpkyEYCb0mAIF4TWl2H0E+qHUX+YEfYWN846J72etWlTDDfn+2Ly4z5Pwgu+tiYhgHrnVIhczvpja3+Fw2wmTXxx4Hc6mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJYb6VcU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJYb6VcU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D82FAC2BCB4
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2026 22:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777675037;
	bh=0TPYHWLgKXDiZGfNntI1eu+VssfCrhcSIw71mw77xfQ=;
	h=From:To:Subject:Date:From;
	b=uJYb6VcUCkgDeLPPE0H1jTh8NkqYNV86qMAZcfCWXaV1z69nseZJp5zklmZK2SbRj
	 lfpjzRVbwOW636IB2PsKHAjMfB4iqcJCqfXnRGYKgRn3uRk5xi8Bhc7gad7JU+jYlw
	 3vgHKzYGkd2GsWqZf6hDEHRQwHLKf9Dhkp10Q7rKGXCGcmTIA4R0gzPxgDlSsp4Do9
	 wIhxV6gzVLld2ph/kPznd2wWf1eBR8iDUqJFPme1ODl4cU3pmbJ2r9TiJOs1iUbzXc
	 YcWwN4crdCuZPPS3Eg1mnpmkugZTrrGpj+VWfOet1NKEInJn572NvfpXYiU0HrLsKh
	 NhxXUTj1h1T7A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C2A41C4160E; Fri,  1 May 2026 22:37:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221449] New: Wireless gamepad stopped working through Bluetooth
Date: Fri, 01 May 2026 22:37:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: arvin.ignaci@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221449-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221449

            Bug ID: 221449
           Summary: Wireless gamepad stopped working through Bluetooth
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: arvin.ignaci@gmail.com
        Regression: No

I'm running Fedora Silverblue 44 (Universal Blue image) with kernel version
6.19.14. Some time in the last month or so, a Bluetooth gamepad I had stopp=
ed
working. It started with inputs being mapped incorrectly and certain inputs=
 not
being recognized. Now, I don't get any input at all. The same gamepad used =
to
work just fine over Bluetooth and still works over USB.

The gamepad is a GuliKit KK3 set to the "Android" pairing mode; It shows up=
 as
an "Xbox Wireless Controller" in Linux. My Bluetooth controller appears to =
be
an Intel AX200 modem (according to lsusb). When I connect the gamepad via
Bluetooth and try pressing some buttons or moving the sticks around, the dm=
esg
output is filled with these messages:

> [ 2041.273972] hid_report_raw_event: 14 callbacks suppressed
> [ 2041.273976] microsoft 0005:045E:02FD.000C: Event data for report 1 was=
 too
> short (16 vs 15)
> [ 2041.277912] microsoft 0005:045E:02FD.000C: Event data for report 1 was=
 too
> short (16 vs 15)
> [ 2041.280044] microsoft 0005:045E:02FD.000C: Event data for report 1 was=
 too
> short (16 vs 15)
> [ 2041.288927] microsoft 0005:045E:02FD.000C: Event data for report 1 was=
 too
> short (16 vs 15)
> [ 2041.300915] microsoft 0005:045E:02FD.000C: Event data for report 1 was=
 too
> short (16 vs 15)
> [ 2041.309919] microsoft 0005:045E:02FD.000C: Event data for report 1 was=
 too
> short (16 vs 15)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
