Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717F41E04B6
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Oct 2024 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729340752; cv=none; b=GUJmJGqEKEEsi5KtPVVaqBUHwcsKKMeIIliYi4xMFE8k5gZGo0szxghYvGsMhAB45B/ECNFhG7fbpe3YH67ahZ33wi/GLasPh2dojTmswfQUBkKWfUOPKDmzk+loDzMY+vLcN7zMSs3+huP+Pu6gziqswAv/8640A8NmYyJWfEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729340752; c=relaxed/simple;
	bh=8sic8YmIuz1j/M0M4X51DisvmDE2k7HlBVJ6oH89XcI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZspCcAgScaiUzT3MCUlaRAbNa5u/FMZ6A5xGlsZEO9rmYlLlMXnJzN668NoB+P3zvbMbeB57r2b2+Wxp/C3TmvIFngXkJXsAJ0tWW7w9m11Gi0NE8DxGcueSaeQpNe/4UfufYx0g+prAosijq3CbrLZuqoPQ7eo/OweiITSYWqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aj8R2Xgw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aj8R2Xgw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09483C4CEC5
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Oct 2024 12:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729340752;
	bh=8sic8YmIuz1j/M0M4X51DisvmDE2k7HlBVJ6oH89XcI=;
	h=From:To:Subject:Date:From;
	b=Aj8R2XgwEezmhY0prkixMGYUJFbG03dwAjYRzCGmNdnSCaNzs8xx2MPK8kTEoEUhj
	 kTNmL2ofH16tkWW7y6ZSZY+7KFTWUCP4SgxgYu3E6XEvpuNuS2OxhLptt3crynxvrj
	 9ltpQy1CxN0rGBLtU1hiS4VNuaw0TRpHLKQUqgJ54u1atHGg6z9uK1XFIQf1aTSff0
	 5I4kmpQyWYNqOlYSCNIslyjc2jQ6xezRORsQdpN9x9+MGLltdiwoatxusis7TE4MKf
	 Z/CshWi1M/duh2jncuAo/KchLIz/nvTFQh9qMkygh34gmFlbdzsvsi0/jP7w6LRI5y
	 9WRWkzMWd7TTw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E49C7C53BBF; Sat, 19 Oct 2024 12:25:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219398] New: 6.11.4 cannot connect DualSense controller via
 bluetooth
Date: Sat, 19 Oct 2024 12:25:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: velemas@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219398-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219398

            Bug ID: 219398
           Summary: 6.11.4 cannot connect DualSense controller via
                    bluetooth
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: velemas@gmail.com
        Regression: No

Since 6.11.4 Sony DualSense controller cannot be connected via bluetooth.
Bisecting leads to this patch
https://lore.kernel.org/all/172797363151.1917736.16977506690005860622.git-p=
atchwork-notify@kernel.org/T/
(Bluetooth: hci_conn: Fix UAF in hci_enhanced_setup_sync).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
