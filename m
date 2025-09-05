Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9BC3209
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Sep 2025 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757114256; cv=none; b=a9+9QkrctyW2wSZxsHE/I5DBPtoEN/+23r7ssptFVaj5HbJ9/Pn4QnYqCFFle4QPl3DQBb/tFn7Swkf+zIlO99yUzvxktTDS7lvZb7+J8m9Luhh4GPzLSN0BavAeeYKfKoj5rKU4xVw4vXKD6ORsVtX3L8KwCrv8jN+u7shGFA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757114256; c=relaxed/simple;
	bh=n7sJek9O5lto7BJ6wBUHPtjNqfpt1tla3+PP+jtgFWQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JGoeRZDtIgogdDW4hHTSucZWoAH3aWxDMRa8jCT6UQs44iz8dBcCfYEYBpYnO0Iw14uvLNJ2qXXmlaKmTpoiqd73qrvymP4AdgdcmM1IOXyCIh6tFdSEi5xCw17YS6aTXXcWnaV1W11OvThd+xar+SOBJdgmLhxWgH7p0m2bG38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avniDjzr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avniDjzr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33EFBC4CEFB
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Sep 2025 23:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757114256;
	bh=n7sJek9O5lto7BJ6wBUHPtjNqfpt1tla3+PP+jtgFWQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=avniDjzrZrTWNRwbLdBcnUSzUq6t071zfNcefyt4peoMZlx4UFhE+CP3CELc6Z267
	 Be9Q81ClnWBMiXnnaDf+iF4zX4nD5Owq5s/A/6P1iZVm5kGbNN4UU0skIR/kwsF1aw
	 86CBk2SGbXti4xbkjoLV5poFQAjnhSaSFOLyrqt7TgEhMqnWqoHGQEA0YAA4B+tavj
	 +PAgh/INRHbdWhN5a4W79aO/GcHgFViCWcDGiML3kgf4VQvao4Eaz0SYjS7KwyoOLr
	 UboJDt4XbVlwZCMioV/ynsFaID5vaHCNLLEm77YK4ONf6G+HiAxUzwTUwG2UQ1B2xO
	 tcGHtbTg46ziA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 29EC1C41613; Fri,  5 Sep 2025 23:17:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 80791] "Bluetooth: hci0: ACL packet for unknown connection
 handle" must be hidden behind "debug"
Date: Fri, 05 Sep 2025 23:17:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: jcubic@onet.pl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-80791-62941-IK2G0ByQ3Z@https.bugzilla.kernel.org/>
In-Reply-To: <bug-80791-62941@https.bugzilla.kernel.org/>
References: <bug-80791-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D80791

Jakub Jankiewicz (jcubic@onet.pl) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jcubic@onet.pl

--- Comment #11 from Jakub Jankiewicz (jcubic@onet.pl) ---
I have a similar issue. My hardware:

laptop Lenovo Legion Pro 5 16IAX10 Ultra 7 255HX (from 2025)

System Fedora 42 Xfce.

uname -a

Linux jcubic 6.16.4-200.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Aug 28 19:47=
:10
UTC 2025 x86_64 GNU/Linux

My Bluetooth Adapter:

Bus 003 Device 007: ID 0489:e111 Foxconn / Hon Hai Wireless_Device

dmesg output

[   49.567615] Bluetooth: hci0: ACL packet for unknown connection handle 38=
37
[  599.542960] Bluetooth: hci0: ACL packet for unknown connection handle 38=
37
[ 1437.569560] Bluetooth: hci0: ACL packet for unknown connection handle 38=
37
[ 3859.566676] Bluetooth: hci0: ACL packet for unknown connection handle 38=
37
[ 4453.577203] Bluetooth: hci0: ACL packet for unknown connection handle 38=
37
[ 4567.071519] Bluetooth: hci0: ACL packet for unknown connection handle 38=
37
[ 4924.313398] usb 3-10: USB disconnect, device number 5
[ 5240.053501] Bluetooth: hci0: ACL packet for unknown connection handle 38=
37
[ 5628.063962] Bluetooth: hci0: ACL packet for unknown connection handle 38=
37
[ 5949.560492] Bluetooth: hci0: ACL packet for unknown connection handle 38=
37
[ 6101.594003] perf: interrupt took too long (2534 > 2500), lowering
kernel.perf_event_max_sample_rate to 78000
[ 7169.561230] Bluetooth: hci0: ACL packet for unknown connection handle 38=
37
[ 7223.579889] Bluetooth: hci0: ACL packet for unknown connection handle 38=
37
[ 9081.183509] perf: interrupt took too long (3191 > 3167), lowering
kernel.perf_event_max_sample_rate to 62000
[ 9387.061556] Bluetooth: hci0: ACL packet for unknown connection handle 38=
37
[ 9403.597909] i915 0000:00:02.0: [drm] *ERROR* Atomic update failure on pi=
pe A
(start=3D1409651 end=3D1409652) time 125 us, min 1574, max 1600, scanline s=
tart
1572, end 1573
[ 9674.574688] Bluetooth: hci0: ACL packet for unknown connection handle 38=
37
[10152.077253] Bluetooth: hci0: ACL packet for unknown connection handle 38=
37
[11119.576619] Bluetooth: hci0: ACL packet for unknown connection handle 38=
37
[12687.069915] Bluetooth: hci0: ACL packet for unknown connection handle 38=
37
[14921.072319] perf: interrupt took too long (3990 > 3988), lowering
kernel.perf_event_max_sample_rate to 50000
[20399.081113] Bluetooth: hci0: ACL packet for unknown connection handle 38=
37

All Bluetooth entries marked in red

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
