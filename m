Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7752C15C15F
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746461391; cv=none; b=b94ye8hQGxVol2IeRJXMhgFBW9+yAzh0o/Wx2kzPLC12S3j4iepHWXpYLrTKH1OkLGiLxOPDzo8GdrF/pFUUbJnd5+3HvxgwaZZBt5+EWuv9Dm2YbhcFthW3FiAuWlnFNAsvl9GshUx+NgmpnAFHuYN05oVHeQccCTvJuxGfdek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746461391; c=relaxed/simple;
	bh=3X0bTwxq2ukFjHx6Va1ENgevjJsnragY/+emZr0DFR0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YY1ALDiVUIwXjYneQ2f3+BBrWnLc1u1d+vR44jIRjdY/2gfRqcTGQ6M8tLgKQsCXNg9eh3EQ9vwzM0Fj0crd/hISY1hfjhAuqIFcc5tgkePNmQDmCI5ArxE8SJFoCRtfE0HbddBbNfWU17I75BsXDk0+HdnlZbchKr88AQ2Z/eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6toFpQo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6toFpQo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E64D7C4CEF2
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 16:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746461390;
	bh=3X0bTwxq2ukFjHx6Va1ENgevjJsnragY/+emZr0DFR0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=n6toFpQoR927KHDEuVRkg15AHuhTENLeU8fwHsUTCR7e/31Y1QN7AGkEiakOOgVWj
	 yQUF9s8PN2H4yXn7Ak3vnxxe0bIHrDTXeJYIP5aFzn0RwIv8cgVBuF1tEwVmQNAzYV
	 XNdcufP4fzKeDclWXd4pBV/7cKOaokCBFS2cMyDRpPj3EAkQZXRfo6+oF+U6xBcNL1
	 Uwz0GMaqsO+qaQdfQ7JSOsCXJfLBc85tFHLuX3DWQUiEeOY0hfcaAwSrdluN/cLIIB
	 O7TNYN/QfvJ4u8RxcUR2LLUo1S6fJx+HiBlTJ4kvHbUALlxrZ5RRF4uB0TvH6P7jw+
	 UgiBcwDDcEaeA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DC87FC53BC7; Mon,  5 May 2025 16:09:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220061] [REGRESSION, BISECTED] Multiple Bluetooth devices
 cannot be paired under Linux 6.14.4
Date: Mon, 05 May 2025 16:09:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: andamu@posteo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220061-62941-bL34UVIhVB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220061-62941@https.bugzilla.kernel.org/>
References: <bug-220061-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220061

Andrei Amuraritei (andamu@posteo.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |andamu@posteo.net

--- Comment #15 from Andrei Amuraritei (andamu@posteo.net) ---
Hi,

I also confirm Bluetooth connections to Dualsense and Dualshock controllers
work again after applying the patches from v3.

Tested with two Dualsense controllers and 1 Dualshock controller on the same
Intel AX200 adapter.

The v3 patches did not apply on 6.14.5, I had to manually apply them on bra=
nch
linux-6.14.y.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
