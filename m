Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507F1210E9
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Feb 2024 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707042673; cv=none; b=CHlOImSVQA4d8zGRb4IsFa27d0GIsa3vkOB9XKvvQtuIbxZWvBiOSMGQxS1k/wDEY33oKORVr83kMc1s6j9vWcBpPzkMosxyI78XhlzDtHRMvbeRnLRLzjoJ1MXWZDk6YVAL+NiVSs4JmSmQ2U3qk03OHwXnl6mhpz3kp0IvS30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707042673; c=relaxed/simple;
	bh=wz6m7bmiDNjfS06SrozRYguZjjqmMZ65dem52SgJrnw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EEaFwghrqEEPk5pFU4J1bwSheQU8t2Mpx7fq2ru4+y8kYoTlOYd9k0oPKOCVOV0/T7Lt0HRIP1EX4X3IU+kip0twskDajYu/amZpAFQxTFcinjNvnYQLmw8qx/u3uDvuf0vOV8DuqMSBTCyRH145PHsoyzJX7GQYU34ea9uA8i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCnq5/8h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCnq5/8h"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D37B4C433C7
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Feb 2024 10:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707042672;
	bh=wz6m7bmiDNjfS06SrozRYguZjjqmMZ65dem52SgJrnw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GCnq5/8hFEqmr0wI2QPxSWJNVky4KnqqzLiPjSYo4gYPjLMdaPgz6vr74KvzX+XwF
	 VVoI1oXDE6mR0DMRX6WHxOlEXa7gYq2SbmBDMizRUp/cM5H+nTJPDvlQS/LE+uo/Kh
	 ZjOIEyzzTUiYXPd5D/tdZ+8r2XQNo0aJTDXtmmTpiGADDAjxYl31qtBP8JtWNckUTk
	 uVaV6cZguLjDIkZgIkJs47JFVOxg10q/lbwaqFEPacRz1gONu1d0In+ki7rMnrEPM1
	 +p8MXzc1Fzhdeiwi3M8OtTYyyOKmv+81RBMFS9VKq8vbAEguJGfDXre7Ge+xmlJmo0
	 k00qL9F91G2qg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BCDCDC53BC6; Sun,  4 Feb 2024 10:31:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Sun, 04 Feb 2024 10:31:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nickolas@gupton.xyz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218416-62941-NyfRIdmBTn@https.bugzilla.kernel.org/>
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

--- Comment #3 from Nickolas Gupton (nickolas@gupton.xyz) ---
This issue is still present in kernel 6.7.3

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
