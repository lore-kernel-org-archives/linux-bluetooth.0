Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B6119F12D
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 01:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778894492; cv=none; b=ijk5m8a4nkk0XozdNbquoGQT4NXKzCnMlZsTchIdfXirkH4UY14a6cWBW6gucfolPVbXIstFcl3Uxkhir5gmSyvg9sSxDlJGLUcZ3qj9h+u2ruo2WUXgkZE2OYelhqkUcFrwO7PDi2eJE1i4LwcehNBXXq14SYMr3c+9emcFERs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778894492; c=relaxed/simple;
	bh=K2X2HLN1IQoap23I/0fIMbyh4IgWBnbGWKuIC5GMmis=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NsFIExD43jTpBKHqYNKYYT7Gev00gTxqgUqhZzaYsheg2YHA+Ev0F7QFSlQkaL3WlkS7lrxVzi7mREW+onyfTp09PkU/eHlV3O42J0JUxC+afy9g35AMWyFu5JIEeRGSJtWWwZpX6EOceQyLFTVKq6mvfEk2eH5WuwKkGqcvbvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STSdTQh8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STSdTQh8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A50DC2BCB0
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 01:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778894492;
	bh=K2X2HLN1IQoap23I/0fIMbyh4IgWBnbGWKuIC5GMmis=;
	h=From:To:Subject:Date:From;
	b=STSdTQh8LkQ334uK1Xuntre5VYQDoXejLWcy/jmcBiUZhYyBPf5da/VEAK9VJViLM
	 JQew0n2dvVFFfk6WfMo0ldYakiV4R/Y0WFPfiQm9EDL7QmhxtSkQxGlykgZB5khauM
	 8PbplgsgKVi55ip33TaLyNOxC6fnVXi5D0vkpbIbmTMlYd5pCGdBoZfqBC3f/Y3FCH
	 agsdumF3lQMmzhNvbXNRAMkLcp1GokqG//zpFiM+FdUYnw1dzf+5QzF2dVuykNZHxL
	 ZmS+OqM65oAUnaZAx1F1ZBJ0V49DOiNLj0kkklAsYq8+ytCtz9ZKg3+h4BIOshxeNj
	 s9WoV5HjZr2Hw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3868AC4160E; Sat, 16 May 2026 01:21:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221529] New: mt7922: Kernel 7.0.7 breaks Bluetooth
Date: Sat, 16 May 2026 01:21:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: autofire372@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-221529-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221529

            Bug ID: 221529
           Summary: mt7922: Kernel 7.0.7 breaks Bluetooth
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: autofire372@gmail.com
        Regression: No

Created attachment 310137
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310137&action=3Dedit
Output of "sudo dmesg | grep Bluetooth", piped into a logfile

Starting with kernel 7.0.7, my laptop's Mediatek mt7922 Bluetooth module
(VID:0489, PID:e0f6) has stopped working. The hardware itself is functional=
 if
I boot on an older kernel, and the actual Bluetooth software stack seems fu=
lly
functional, but on 7.0.7 any attempt to connect an already paired device fa=
ils,
with bluetoothctl reporting "No default controller available".

I have attached the output of "sudo dmesg | grep Bluetooth" from a boot on
7.0.7.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
