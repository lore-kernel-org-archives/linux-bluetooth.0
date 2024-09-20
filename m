Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82411F9F8
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Sep 2024 20:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726864894; cv=none; b=SeiEzlKQrPqRIbyXgs61JwmRNwqAaHj2q9BukXKVbtRCTANyEYU7qO7IupZaCx8EPus2WHkmvCWUENol86kkKAWgZOd8oXaU4CgsR7TgiNr1u49rBzUjzO54NCm83nDCPg4AJiNjMxyETvqhg37zFVGAJWM4Ty2JS5qhNks6Tws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726864894; c=relaxed/simple;
	bh=XYgd5bC1LNkmCZM3sxpPUU99/Ts9wf7+YB7OdiDQEas=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gavPuKIyxogAL71lvn/1co5ms6deSOSEV+F60av6Yl12vFtNKIvUNVzRZeTXxUNYlUjzLAIX31W9CDaUXMxwVV+/RJ1rtlTcRWOPwLaYhn1aQ0wNMcuzMjgDs04Wi2qnws4UAjR3xxKYYqkYWF0m9CJbiZhaYGPTTjGa5SebgB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4+3qfNW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4+3qfNW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 063EBC4CECD
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Sep 2024 20:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726864894;
	bh=XYgd5bC1LNkmCZM3sxpPUU99/Ts9wf7+YB7OdiDQEas=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=E4+3qfNWxdJ2xXXBZUAu8DnPcrnTUOKZApzvAV2n0+nsU9FvVBS3V7AxnSiLLU9LW
	 i4Enw6ZKFJUa3iLesavGBLlhXGrklj4KPRU9AwFTs8elnQIIiy16wJ3sBcU0dZn6ZL
	 tFFGRbtRENPY1CYS/p1FX83HCpCZr21XhYaioWGcKiS5nvsV5ZhztfRx0zlN7Q55P9
	 jNwhl+wLUq+YJnWHmy+LL4aDwkzbT+f3OUmhZ3IrVO8LqrgYcR+i/EHjI8HzanB5QV
	 t7Hs0RsdUyZJz1vIJk4w3tBd9tDeRAidKuvktngocxNKEZufn864L+DnzS0iKcbTbz
	 Zv+eLMiNG9MLQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F007FC53BC1; Fri, 20 Sep 2024 20:41:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219294] NULL dereference pointer in Bluetooth at boot
Date: Fri, 20 Sep 2024 20:41:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: casteyde.christian@free.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version cf_regression
Message-ID: <bug-219294-62941-LAW6NqOKn3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219294-62941@https.bugzilla.kernel.org/>
References: <bug-219294-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219294

Christian Casteyde (casteyde.christian@free.fr) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.11
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
