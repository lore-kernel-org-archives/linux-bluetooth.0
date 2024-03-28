Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0B27D3F5
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711630116; cv=none; b=lCY/utlAp7xKuLENZ5uaawdZnDd8KcYbGZdIkDeV1FL27QGlpC0dXBdZAumOY+SzhZSCjcBxiZBLREHXLKCRyCx/0DhOZVeeUgp6zL2mpILrqedb032BkW/nKZtd9pDtrSVfrNQ+3KtdjMKVMDaakCMU2RXrdnhdnFZVnyUrk1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711630116; c=relaxed/simple;
	bh=A2y+SiAQdgwCa2o2ji5fnmwOB44LYQlPPp75CNERZ34=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c24TnDUf3zVrEC2336ofgH5hP6ozVxLIEVuK7Yrk7taGlSyZxqy+mY5ZCXbYe9GI5vZxCJrHvNoNoR51A5XTiIjwt9eSSHL73cXS/r0jwkkEF70QxhPKFIthH+WBC+0VewOam2AT+pxJV6b/n2953gd8Pekcgj84//0EZZSUhSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjfmU/To; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjfmU/To"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7ED32C43390
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 12:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711630115;
	bh=A2y+SiAQdgwCa2o2ji5fnmwOB44LYQlPPp75CNERZ34=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OjfmU/ToOY5ZzpsU4j9V7VyCMek2VNZfM7ZeLnP+peEho8UOB2WHe3b/J9R1oLZsE
	 5ytt8r4X/bHmqU0w9TrzAOyf2JvNF2bpszXIu5jJoGuoWHyWKCDmmyfYzYpsYBHuP4
	 0QpKa0oJFbCz7RBtADVXZBWW+aoJF3HhepvSiH5Jr8Xc4v8lETrXoyEgcQT1F1n8rE
	 GsxfhwwQvzefAWL1yKgeaNvZhZ1fZPguOQjdqdIFXJ+2yx5hn1eD9rjrlkeIR5vOK5
	 BGRgJVsCHCKfGkHH63OL6Dbded9HzleRmQMgPr+ySgEhfM3nK8epOnLZsdDLJ+NvyP
	 e7U2oRhrktPFw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2A5CBC53BD0; Thu, 28 Mar 2024 12:48:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Thu, 28 Mar 2024 12:48:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: jb.1234abcd@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218651-62941-ijZPTUtYlR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218651-62941@https.bugzilla.kernel.org/>
References: <bug-218651-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218651

--- Comment #6 from jb (jb.1234abcd@gmail.com) ---
Per
https://bbs.archlinux.org/viewtopic.php?id=3D294292

ThinkPad X13 Gen3 with Qualcomm WiFi/Bluetooth is working properly with Lin=
ux
"6.8.2". Therefore this issue is limited to Intel based Bluetooth.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
