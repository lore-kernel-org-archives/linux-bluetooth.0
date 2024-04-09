Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DD912A160
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 12:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712665105; cv=none; b=NWvPV/ioaRGsjk038moBIE9/A2st6JIkWVoGqtSS9nOH9xtwoMWX5nlfiGIVcfqqvaDK1V2djhuChEF2O56ZIyumjMme/FLV1qGnazDZrWSgR2LfOBHGassQB0gqHeeVOOFQ8XXhKJMIK21UXEZrzo5h7mq9jzI8dEbJg3i0jhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712665105; c=relaxed/simple;
	bh=+TQ+59fwzO3OIG4T3xQcb+9EhkWv3V9Z7cMBnQWhFXU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eRwpbmGJ6h9Bx1oFpR+NqxSraoZ9LYRNb0iotAHvDYopBPn7Q6l/yHY+PhFNnj0V8s353Wk6aZ7CgR8ggnFGqpoxbIMVsxwTSKd8hxBcRMr+KExl49fTvv81tr+UglODLvL7p2ir3T/DaNKpM160czmIXCq/Idq6qs/yEt/s4dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFhk3H7X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFhk3H7X"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 298EBC43390
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 12:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712665105;
	bh=+TQ+59fwzO3OIG4T3xQcb+9EhkWv3V9Z7cMBnQWhFXU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uFhk3H7Xpg9wWCBb5HLanFEf68dpkcFFZHdYLJ0AXX4JsiQrNgVolQgJA0/KPw4Xe
	 2FAzmM/hM795OXc3XD/8smnUbDm1GjMxuTDSW2/+BCSj2GgYUweL3Q87I64wO1WfEY
	 dNSzjNKfh/az63GcK/mtCku8NJ9aFeQamh+u5ixf+J+DUYc6owVoWHHEEmrrMd4mxj
	 7zgc1cwM98Mpa6xJLtQDJbajYovWL9uLPZVesfgp5MjnKqNJGQ877PigM05LpFk7rp
	 opQGwjPdBxlhLMPCaxjYscglpitm8//4c6u1ui1XmaG7yD+X9XCNv8T+LVbHsdTIMv
	 xjxtLZzh02kBA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 132BFC4332E; Tue,  9 Apr 2024 12:18:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Tue, 09 Apr 2024 12:18:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jugoslav.gacas@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218416-62941-Ic0PDFANve@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218416-62941@https.bugzilla.kernel.org/>
References: <bug-218416-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218416

--- Comment #18 from Jugoslav Gacas (jugoslav.gacas@gmail.com) ---
The issue has been fixed for me after upgrading to kernel 6.8.4-arch1-1 on
Arch-linux.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
