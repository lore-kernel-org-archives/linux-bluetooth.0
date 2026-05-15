Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270F13D171D
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836502; cv=none; b=JY69sloqy3p7GAUAXAokWBLlb+TZgYum1GiKMqobtLX8PdCD26XA37PtJLqVoq1qpZFjxud5lDgBC7emzUwvsHmgplxmcqpEzOTK0o8dtMXAX+Ho49KeUWKd5BI+TeMtgUurbvQMu9B9TwltZbWULR70oRsXy2tD0SH1Zc/gxs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836502; c=relaxed/simple;
	bh=cE7IdnP+vdODshpiOMvDFmbWfOXU4UrtGcIlYXhQkWg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=opvkbiqj8pYwVVJpyWAUYO3qegHkGlbO8e3Hzdjj7pQF5DZLnPn8oG8JU2Pm8FYEFDSH+XT9qBAryufXTk3SNuAFsw7uh+qAB3ngdhQkw2t6JZHyTjw1AE8X0cscgVjxrmvxDs3t9IR6Cfv575f9FKxclK92wMmW0gxKHCy3Y0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrapOHmc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrapOHmc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 961EDC2BCB8
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 09:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778836501;
	bh=cE7IdnP+vdODshpiOMvDFmbWfOXU4UrtGcIlYXhQkWg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OrapOHmcjnLNpwA+HFpSW+XIIDwiuELLABLwQd9IIHlWu0GOd02+vpbpEWmmbWmsW
	 /ymcsKSuW9jB0XWHAKS9LGqIH43C0pD//y0KG1f/g0FPrSOfIPudBZxSSWQdeKFUo8
	 DsqhsqkkBrhq82sEQYUGQHZq4mwWLyYJCTFaEgunkxsS4SOHOQ6IlbDgfASQAcztBM
	 70ikI2M8ndiZQyfPVzAen2Kq9d6IjXjKn4rTSV6VSZj5D8o9Nmv0YT9IOC0yJZtPZ/
	 3aNAVo3nAUNCbprsYqmvBXzm/4AAi5axb9EYmjyIIR+CGl6FCdFpSBRl916laUOFTP
	 yKSAMHx2M8XtA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6FD20C41616; Fri, 15 May 2026 09:15:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
 (-22) on MediaTek MT7921 combo adapter
Date: Fri, 15 May 2026 09:15:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jill+kernel@kokakiwi.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221521-62941-8RYynpQnx1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221521-62941@https.bugzilla.kernel.org/>
References: <bug-221521-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221521

jill+kernel@kokakiwi.net changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jill+kernel@kokakiwi.net

--- Comment #3 from jill+kernel@kokakiwi.net ---
Confirming this regression on MediaTek MT7922 (`0e8d:0717`) on Arch Linux.

Broken: `7.0.7-zen2-1` (linux-zen) and `6.18.30-1-lts` (linux-lts)
Working: `7.0.6-zen1-1` (linux-zen)

Same symptom: `Bluetooth: hci0: Failed to send wmt func ctrl (-22)` immedia=
tely
at boot, Wi-Fi unaffected.

The regression field should be set to "Yes". Based on the 7.0.7 changelog, =
the
likely culprit is commit `634a4408c061` ("Bluetooth: btmtk: validate WMT ev=
ent
SKB length before struct access"), which introduced `skb_pull_data()` length
validation in `btmtk_usb_hci_wmt_sync()`. The MT7922 appears to send a WMT
response that the new validation rejects as too short, causing `-EINVAL` be=
fore
the chip is ever enabled.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
