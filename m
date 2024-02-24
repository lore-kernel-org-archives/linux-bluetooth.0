Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED2F3C48A
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Feb 2024 11:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708775574; cv=none; b=jUC+RplZSjwoZX6mRrfmdaDUDH8FRECxLQZHcsQiLXVknJrlhpbYqalsqsuZlzFoGmAMI6s5OYVxwSuRnTp9gtu0Zip4Lez1ThJ/Db69MOt1IlzmKS5U1p/y+snOFCqGSQcLlqI2RE5LS7oN69g8RLQbt+9qc38zBCMDb4nW7IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708775574; c=relaxed/simple;
	bh=93twv4Mwb1FU0Na+1+L82o4WBferLOx95v/fKhv5Gl8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hg3p1TeaCSAEVzQ8h6u0eLgUOPfovLgAyRTQqjxckIpwSfhUiS2l45BqQcrHK3spBPFfpOJhunScg1ITiwZ7XixkwI1ikxGPKZIjT5vwERg5XheFPIJj97ITUcz5Rz8p8FX/MuQuRFJPXWBwtTYZOyoFPFAK9QaBQVBMbvXOkI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upflGqSf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upflGqSf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEFA7C433C7
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Feb 2024 11:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708775573;
	bh=93twv4Mwb1FU0Na+1+L82o4WBferLOx95v/fKhv5Gl8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=upflGqSfWtLKrG9UtCLrKaq5t2MYGBkLOQHqpdj/103WUg99ksOiATbEbu90zkeHh
	 B37cVz498zQGOgTN8bcxzgxoFwuiuy2ktj9FH8fgx4MlsH4I2YgblPtl1eE3mXGUYa
	 lF6EPicMV9I5g1bthWSHbDL6uIl1NRNFAfdu1J748PlDWN2YukLu0T29EXJXywIMDy
	 2LxWzzI1cw7Gf/jTFN342K8cRSGg3S9O9Rn3oqVE1q7GJf2IMBAg2kD0p+PPOkUsuL
	 w7ZAaNWh3IY5FwIK48V2cFxP/n2Yl3iRWBQsj+wUKIQ6x6+5BRTnUVJn200lEbmEYu
	 Q2+Rqka3KyyIg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AC1A0C53BC6; Sat, 24 Feb 2024 11:52:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218472] mt7921e bluetooth not working
Date: Sat, 24 Feb 2024 11:52:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jeremy53561@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218472-62941-ESvdQ6xnoa@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218472-62941@https.bugzilla.kernel.org/>
References: <bug-218472-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218472

jeremy (jeremy53561@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jeremy53561@gmail.com

--- Comment #6 from jeremy (jeremy53561@gmail.com) ---
You should post results from terminal for
sudo cat /sys/kernel/debug/usb/devices| awk '/3585/' RS=3D

The bluetooth devs usually want that info.  I am guessing that you will nee=
d a
kernel patch similar to
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/drivers/bluetooth/btusb.c?id=3Df0ad26ee822b197f2421462df9c358a5687=
fddfd
but it would be at about line 610 of btusb.c and be

        { USB_DEVICE(0x13d3, 0x3585), .driver_info =3D BTUSB_MEDIATEK |
                                                     BTUSB_WIDEBAND_SPEECH |
                                                     BTUSB_VALID_LE_STATES =
},

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
