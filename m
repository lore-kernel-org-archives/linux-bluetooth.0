Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792596879;
	b=n2xuvLfsqlUWukp72Cd9u2CWrsjX5J/KX2vFhQ5WiAYrIcuvZp2Aw65B0NnaqLyd362d
	 yFJfq81+6pIqAM5c/TaLVq9ftlb1EjiG5AruyyGM4Z5BdfYAl4/CQMZxNxndFe7GZfCen
	 MXDSvbd9Ugj5uAHX+QP1NtKkcyP0hft8jCZ1dB4q8XiJFloI0RIIkbo0rrQW2VzpnNmJm
	 3sT6pSlTN8h3eCHX2mGS/4B2dUl4D3QyNxmNUPoT+V1jCM4LMcp4OTP8gVP5OkraQ2q90
	 L3FjjzsQifM6lYPVPV8Oztsk9TRosVe1MTX1Yx45EIu4mHJkDNWvoT3SFJONaBZjVOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596879;
	h=Received:Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:Content-Type:Content-Transfer-Encoding:X-Bugzilla-URL:
	 Auto-Submitted:MIME-Version;
	bh=XgjTRb80vhpOqUwQBBhxuFNjzB5nhJLth4WVYFG034Q=;
	b=1wew4Rs9d4DqY+yWB3VLzRhANwGN5wDYxSaKQMKUubXNm0EetSv2wfD62GFrbkV+/FIL
	 dtFC/lVb1V7pc8hOLFJW7AIJN5EsPZnt8JSMQ2e5vzUQzHPiTPtN2Oux/4BjgHeZxYrLS
	 LYOaRkXGhEG2V3HB0X5HccGBX8NrDr8tyaPkGFcOMs17jWEOUKk9D7mH7OzV1/S5FSYDc
	 Ir20AGTq0FNc6LehHkNg+M/BLSvtNVMu9M/JFuPiyZunYcPN0iIan8bFpG2CMhZmn7vx4
	 SEDtVjTtfBrzzXW/UD5+S1OX12LoSUokMfGeO3yQCSxbi1jURXrqicdmo+2Pmk+03/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tbez8Vhy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49089606A320
	for <linux-bluetooth.vger.kernel.org@localhost.mlmmj>; Wed, 21 Oct 2026 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tbez8Vhy
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FB725771
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792596879; cv=none; b=U+hs8Ow2ieImHFT43RuU+M8ybmV4TRMRgPwthWxfRrZXGJ+3sdUGLR0FnbKK2T1wEttgXCMegqXu9adyalMA1XBaNcBLeKkxu6kwJTc0hDGBLz16h6/K3r9XRuHmgCCwJksMGZn2+tTO3FEPIxqhTk287vRBMkKRu7oA8WHNXWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792596879; c=relaxed/simple;
	bh=cPEMrL5p19FCuPSngGxCqCwGlrm87zuRqifiEUnKe3Y=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Blc33yfWyHq5+8yiULt+JBZtXCfsgbIyVOTkyDXAiUyLAQsaiqK1wqdesMGJ9hpT6/QwAJq9pKQuLBxHY6cV2otANm14lA+B23LK/q5jGeCCU0NvsME60Ms2/3eLexqf1otsXxvZAQWagzXa2tjfJvLJo+oCgJOh8rhVhAIaaeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbez8Vhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92F8AC2BCF7
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 15:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792596878;
	bh=cPEMrL5p19FCuPSngGxCqCwGlrm87zuRqifiEUnKe3Y=;
	h=From:To:Subject:Date:From;
	b=tbez8VhyinoJrOqnOAeJgM0zA13LdzN/K2avjW1nfl6ngfgMjPQ2QTcFOozuWnL4I
	 NcX/SwF+RNTJrnE88ffd9GWqt0rpupmXqz74tPVL12ztuIG0RA9mUiSWiDeLLWMEqX
	 jTJL9S40zmM0lFaY6gsAFnxp7e3f5CTdm9Dj18BpQ0pg3IM7DdciQ4nzOjv1E3E8TS
	 1BZCdIvMAUQYvjyIP9pZnFUmsDUbt7J4bbo8cg74a0MFQiywmHMwxlCgod0mmNAtxC
	 oB4l3RapYZIWFWV35/JSBRZ5uz5frPtpTioI49hMFFEjOHaIHdPNqKAuA7OrhCAwW1
	 e2zFVxAHWofTg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6A3F4C4160E; Wed, 21 Oct 2026 15:34:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222177] New: Bluetooth AX201 device does not work on Debian 13
 on Kernel 6.12.114, works on 6.12.113
Date: Wed, 21 Oct 2026 15:34:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kalamlacki@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-222177-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D222177

            Bug ID: 222177
           Summary: Bluetooth AX201 device does not work on Debian 13 on
                    Kernel 6.12.114, works on 6.12.113
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: kalamlacki@gmail.com
        Regression: No

After compiling Kernel 6.12.114 bluetooth device is not working in blueman =
app
on Debian 13, it works correctly on Kernel 6.12.113.

My adapter is:

00:14.3 Network controller: Intel Corporation Wi-Fi 6 AX201 (rev 20)
Bus 001 Device 004: ID 8087:0026 Intel Corp. AX201 Bluetooth

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
