Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F51F26AF6
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jun 2024 07:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718090505; cv=none; b=qSg9jwAXEFRwQpTagc6NF8VArcADCG/kmJlFiXcuT2uMHCISrXHJnOLv9vathExqKLZ+XQs27XntU+Y13avBZb5lQHO2Ox9EchD+gSMTMXd5TlvyF6r4TEjDyK2tS/11552kIiopB/25jx8WY7YdPlrMvdzo00TmXaL4pKIjIgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718090505; c=relaxed/simple;
	bh=aEJZzBct4FOHwiPHkAWWP2KfUWD7P1lNT9UdGojtdAs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s/9aKGg2pSZoRvmNwmSvRqsajKACoOBmQm3v86mV9S+cr/uOlywhf3NEkov1B1ru+HMHZLmnVOD9BXDo9QQZi2/YkQ7lIY2bFSKco3Q4c7cWlXNgvQD9hp3Ev5vT6C6UNX/3qezuPuCN7eF+pvXaCOUJlqUjFKO2tIpIIq1tuo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEaHxYDC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEaHxYDC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EEEBC32789
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jun 2024 07:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718090504;
	bh=aEJZzBct4FOHwiPHkAWWP2KfUWD7P1lNT9UdGojtdAs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VEaHxYDC8lfTqOE6pjAfWwt2VSbsVRg6KKEb9H7XTd2vQlBcsqiQhgdU4Tbl7P6uU
	 ZlvSPokkh9/f9USNK96mCFA5LfL7YnPi75dDZl1zkh2os96zXf6mPCL6UdUhvXV9wP
	 hQ7WWimrOybbmV5Jw8UXl0rhsNkOx9Ykg3BE0lDD1VexlSNX3rK5p+giqwBzjwEkNC
	 /Ai20lr7G5k3fWVABRiGgbY0rEhKMQt+o+pIQNVIO2FdgoJbMmVx1e94iv7/tXXx5y
	 oTNjhLe7bM0lDb5X8SZc9NCUGFZkZLyIIuPqyL84D9qdtyXt6SSslRXsU4nj1ivEkJ
	 VjnNKVJZwl+HQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 865F9C53B50; Tue, 11 Jun 2024 07:21:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218952] bluetooth and wireplumber stop working after some time
 - dmesg report BUG
Date: Tue, 11 Jun 2024 07:21:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-218952-62941-rooZJZSPhR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218952-62941@https.bugzilla.kernel.org/>
References: <bug-218952-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218952

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.1.0-21-amd64 #1  Debian
                   |                            |6.1.90-1

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Is this reproducible in mainline 6.1.92?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
