Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ABC78F37
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Mar 2025 06:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741847776; cv=none; b=gCoAq6aKPNwynrfSvYGZl9EMxPtTdy7gF1FyTvY8SUSWzhlVlIgPCraV2RkmauWFs3ZRRGMfQQkecfHITLmBB39yQadpMu5fXkRfiLkc9hG56D5dxPZA8RMpe8E+FKvzaPPSqdDdcWEJ1AWE4edWEM385hDYH3/It8ONp877798=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741847776; c=relaxed/simple;
	bh=CzdX83YDuK0J7XvqkOFbmEcQp4fyHLi4aQlpl68FGY8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hV4rQK1tz0zlNHRF2XFgnRbP8LRACN3J106+PrHEQuPW9GQl4fd7uPBfC9A/N5V7VIzP1TCaZemJdui1Y3Av525LpxDJnXofAhHuWz4SgPOEgpQURW6yxM5Fu1ADVnhzXj+Y8amcYxkOgKewEPRhUdPoMB/EKhiOTr5ZpfLbh8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aql6Q5T7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aql6Q5T7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BE55C4CEDD
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Mar 2025 06:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741847775;
	bh=CzdX83YDuK0J7XvqkOFbmEcQp4fyHLi4aQlpl68FGY8=;
	h=From:To:Subject:Date:From;
	b=aql6Q5T7y4nulkGmOAlcvwLSXpb4PhGAGlJHS7IbeHMBYXtGUtNNw6TFGDSlwmzCw
	 esSeQfttmm3flVbKahXbDWZEB6bSLszTO3tYxO09ud+ei3VXeNMh9O+gaLG9EbsP8v
	 Xs0mVhLAb+vf5HXhULN4tDU+34mJBlbTT7Iwv2k6Y+cfGH/H5Jt+pQxavUCC9Adb+o
	 jOLuVCsEtCk0G8Bk9xEiyVJUTOEMHDVDnKomkdguboPadnBNa8ran4ipP/1nIFL2X1
	 PCXsMtROkI3JLn5n3ibzhmGQxia6T+tnnalSrUYx8nqzRGBM9dPmkvExOtHKkF03PE
	 SVRX+KMNKey1A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4BF65C41613; Thu, 13 Mar 2025 06:36:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219861] New: Bluetooth device in reset loop after suspend
 [regression]
Date: Thu, 13 Mar 2025 06:36:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pierre-bugzilla@ossman.eu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-219861-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219861

            Bug ID: 219861
           Summary: Bluetooth device in reset loop after suspend
                    [regression]
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: pierre-bugzilla@ossman.eu
        Regression: No

Created attachment 307813
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307813&action=3Dedit
kernel log

My bluetooth device has unfortunately stopped working after a suspend/resume
cycle with one of the recent kernel upgrades.

When this happens, I get a constant loop of this, spamming up my logs:

> Mar 09 18:16:44 mjolnir.ossman.eu kernel: Bluetooth: hci0: sending initial
> HCI reset failed (-19)
> Mar 09 18:16:45 mjolnir.ossman.eu kernel: usb 4-3: new full-speed USB dev=
ice
> number 3 using ohci-pci
> Mar 09 18:16:45 mjolnir.ossman.eu kernel: usb 4-3: New USB device found,
> idVendor=3D8087, idProduct=3D07dc,>
> Mar 09 18:16:45 mjolnir.ossman.eu kernel: usb 4-3: New USB device strings:
> Mfr=3D0, Product=3D0, SerialNumb>
> Mar 09 18:16:47 mjolnir.ossman.eu kernel: usb 4-3: USB disconnect, device
> number 3

This is a regression. The issue was first seen with 6.12.11-200.fc41.x86_64.
That same version was used a whole month without issues, though, so I'm uns=
ure
if the kernel itself is the culprit. But I don't know what else to examine.

A complete power cycle is required to return to normal. Power off/power on =
is
insufficient. You have to remove the power cable from the machine.

The device is also on the motherboard, which makes it impossible to just re=
move
and reinsert it.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
