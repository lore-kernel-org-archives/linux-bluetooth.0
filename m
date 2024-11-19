Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6100E14831D
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2024 19:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045427; cv=none; b=LSHjOWCXdfDOgqQXwB4xczF7YQzhwh01uiCcVWmsVF19n5sPIRFTOj34BsUDZz7dL8L0YHGZ/HILYvEBlXTNlNccYOu6W6AyLvUxOCZRYJUNHnPwNsI0YiSX4L4s9ym3vfljVS5CVY6VYux/vUJqbA9/a/RITSqgnptjpJPwhKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045427; c=relaxed/simple;
	bh=jCr3/4QypLKWK7hD5KMwEFUjtx62D+yLSFrUNCPAX+Q=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VlcQPGUifJkB4Dpbqx1+amrSn/a0/gZDnQS5Kvr6Bh8sbzqEdvJ62NmUmnHeZvj9OsBnnr9iaUtPzzZoFsz/8Q5y7h1oZ3Pghw1UVHVqMKLbiRFbTRU70BLes3cKJSufyBcjiS+IVckZfMf5P7dH59d05yGGOOT+YwNR/C2ZmNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0Zsakzn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0Zsakzn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B659EC4CECF
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2024 19:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732045426;
	bh=jCr3/4QypLKWK7hD5KMwEFUjtx62D+yLSFrUNCPAX+Q=;
	h=From:To:Subject:Date:From;
	b=T0ZsakznzZeK18+b4rx0luNZQmF5snmrtWJTak1U6RmjxWJS+20Aj/+x1me/GC9c1
	 33DDT1Xk8s2jdnXpVC2MPMJkJGtuEEUHI9KTUDDZoAEbS4GA4dxmPERYPToZmy5jT4
	 o+nsrANNCLlmmeGOdXNUbfOS603asOLkTw9l9ZkMXz17RHZRHk+oOPW/OhertStMFy
	 wAYMzadQcqzeXSx9FesZ0Ewygsnz69WhRm1ux3m3KvwdQonApHowlJtvVZz+zAX9BM
	 ECadnq+u+jrKZNK19fx4ppmU2+a2RYohFjTuxi8bk5XRpylg1cao++Mq42J4WF6Mj4
	 DgctTEpl6S6mg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A05F8C53BC5; Tue, 19 Nov 2024 19:43:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219514] New: PC does not resume from suspend, bisect points to
 btusb/mediatek
Date: Tue, 19 Nov 2024 19:43:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: h@realh.co.uk
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-219514-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219514

            Bug ID: 219514
           Summary: PC does not resume from suspend, bisect points to
                    btusb/mediatek
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: h@realh.co.uk
        Regression: No

Created attachment 307246
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307246&action=3Dedit
dmesg shortly after booting with the "bad" kernel

In recent kernels my system keeps hanging when trying to resume from suspen=
d.
The fans power up, as do my keyboard LEDs, but the displays stay off and
pressing Caps Lock does not toggle its LED. This means I can't get a log wh=
en
the problem occurs.

My motherboard is an MSI MAG X670E TOMAHAWK WIFI with an onboard Mediatek
wireless device, and I'm using Arch Linux.

lspci: 0f:00.0 Network controller: MEDIATEK Corp. MT7922 802.11ax PCI Expre=
ss
Wireless Network Adapter
lsusb: 0e8d:0616 MediaTek Inc. Wireless_Device

git bisect points to ceac1cb0259de682d78f5c784ef8e0b13022e9d9 as the first =
bad
commit. It's been difficult to pinpoint it, because the bug isn't 100%
consistent, but this commit has exhibited the bug every time I've tried it,=
 and
subsequent revisions nearly always do. I've tested the previous commit,
6dc22ab9f085ae165e4ce89d61fb426f94e8a969, several times, and it's successfu=
lly
resumed every time.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
