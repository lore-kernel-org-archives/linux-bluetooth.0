Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5962580EE
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 05:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232780; cv=none; b=pRruCGIjNbLtVWYI0DBFmYpkpvuVsNRGhHM/SZTmrEgshnfWaFuStqIOtpx4vrSlVvVr530KXOGTmf3NzSUj/ZNaV2V+Pir7k2GvWVa7tfI0IFAm4nuPLpwz41+gsi2MJ1BzzWNtG3ICDi0mMMj2jfcccOw/1MLEL+NIi57CtsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232780; c=relaxed/simple;
	bh=7G1c26iZJospP+HVFDEuMbtLXakencHlYtV2tDOvzHc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=paiVsu0ejhNHpeVwFx6irM6U5uDN76QEzPO5b6DCUQB8aLSGGFFK10m4Jvs5MxN/hWq4srsu43ZE3JybaUf10lBvd5eMv0YM1EI5L/20KC9qxy4G4+J6fiU5oACDP9ZntaiaXzHGhJ8EgktC5hILkiBU2yu5e09GcFczTgYOQWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScCciZbx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScCciZbx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68FFEC2BCB4
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 05:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776232780;
	bh=7G1c26iZJospP+HVFDEuMbtLXakencHlYtV2tDOvzHc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ScCciZbxEg9ravgMig3ix10epQ6Ke1PmJ4dXD747qJGIgmb8Wpnp1/JDSbfrdd4Kx
	 PZ+of0LDlMSfB3yayauZCmXpavAX+3OE+CZ/L0h1wudhhrAdSO5xFy7s9uBL4+a59W
	 HPhPKi1lYLNPvUxZeuRhkIEV97oRAMWiwFHzsoiUhnbKB7vJ2skXCvpSFMyypoiSPC
	 2AArdEwa5JOl711PKGN806cKJ+KvTn93NsXBJKl18AexzKTZt8sAQ4VqrVJPesC7r8
	 M0EYLmSTrYSOOhngzuj2nPLa7inNYFx/rhuIcS5WICwBhA/A6ROfroPKGPWKAoxI32
	 p5+Zjn816V9vA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5E9CEC41612; Wed, 15 Apr 2026 05:59:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221346] Bluetooth: btintel_pcie (8086:e476) may hang in
 shutdown path (synchronize_irq) during reboot stress test
Date: Wed, 15 Apr 2026 05:59:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zhangzhigang1996@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-221346-62941-ejgIX4dgfz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221346-62941@https.bugzilla.kernel.org/>
References: <bug-221346-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221346

--- Comment #5 from Zhang Zhigang (zhangzhigang1996@gmail.com) ---
Created attachment 309872
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309872&action=3Dedit
The machine used

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
