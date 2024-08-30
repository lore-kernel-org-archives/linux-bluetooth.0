Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8356C1B29CD
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Aug 2024 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029914; cv=none; b=S1v8lSnEKVDSQ0Seiw/GitBfvRrXNBgZT/5QzM+vpO2Oz2XwN02m5a/AD9nO0Zl1z5zt8nH2YkIoRkHkNXrCU1CkRkPCtupbVcvhClKgDezKcn7R41e826oQ1Gle8OW7747ax7UhdHX5Kky+fxMxdsOsqD4w2FLuLy8Zy3dPLbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029914; c=relaxed/simple;
	bh=kgk8V6un68dG5QCHSE9G5f1hvp3rhYGSGe73EUIZKsY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AAoDNo8qrpwlq1HZRVpdGyRA0eso3GZbYDkgl87UuluiV7y1OokXkm6uYLGZHgwOMtGmKAo5C9OKcuDCMW44C0SHRPFlYprfqFHnqQ3gUSrOJcLK5NVuO9oLcIGJh3aHACzIsyo6iM9CKMD4Y6H/ToUfPh4Mc2NvXpjL+aQLVr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxuaR/Qz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxuaR/Qz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 588EBC4CEC8
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Aug 2024 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725029914;
	bh=kgk8V6un68dG5QCHSE9G5f1hvp3rhYGSGe73EUIZKsY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OxuaR/QzMemW1HgsaN8cy/oc4EZX5eowueTvuzY6gN6c8F4OvlyVBHqTCM3f22XaN
	 auykVq0jQdBCB7IUhDLk5mZQRnE28/4xFjJaUDRb5kuSaMSmttzcnQkPoGZo/4ppL+
	 Aght7NgarshQrWj6tufR/9FvvROVRpT9RcwSIsnIBkM3adNHEPLQh0p9pWKyq2pc+O
	 QAc69NwO5/pwlJhld9YzNqt6p4NHaATUr7Nh0PHJ8UiNoYktdZyrjqGukZiehwpM8M
	 x09WfRgO/4onKiNDWZgnIzt75n/pFChy54f2yxHYJ3Cg5mas3reNQ7DLSkERmCrZqg
	 T45xFC08dHnyA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5127CC53BB9; Fri, 30 Aug 2024 14:58:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219211] Bluetooth not working. Bluetooth: hci0: Opcode 0x0c03
 failed: -110
Date: Fri, 30 Aug 2024 14:58:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aprilgrimoire@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219211-62941-hVgfJnMoBt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219211-62941@https.bugzilla.kernel.org/>
References: <bug-219211-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219211

--- Comment #5 from aprilgrimoire@gmail.com ---
Created attachment 306797
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306797&action=3Dedit
dmesg output

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
