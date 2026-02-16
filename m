Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0DC2D0C63
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258252; cv=none; b=doiRW2XQfHIAMuuI0kb8PC75XgyeCA51NTjO3NGDWo8/NKSq/NwwTBMJ0rlHjegqvw+FVz5s8IvZZzIf51e5ZMfo83bTIyKbI4P9qrOQm7ZtvPE9KfWMNFShi7+Wwu6To4g25t5yT9cQM6kXLiYm6E6Y8ILjiaJyUrNBQP0MDCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258252; c=relaxed/simple;
	bh=oryZiLrs/zpvjW9XwRTVUJbJkGNqV25JPGrtL4SbDv0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UBXQcTpl4qWN0AfsupEiCF3AERz9dgHe5/ih5gVhcAHi2AIG3lmvmYLft93lYgHn1BvJ6VP3VebGA7ppOPQPx6wJsGjl2be9OAFNXdWnBc1Y1D5qvf4CPcTYR7+UqEZEiT68PLXu7VuudgVJXlXrRkENI8J03eqepZ/yyFlJ1dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5zCDSTL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5zCDSTL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8800CC19424
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 16:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771258252;
	bh=oryZiLrs/zpvjW9XwRTVUJbJkGNqV25JPGrtL4SbDv0=;
	h=From:To:Subject:Date:From;
	b=T5zCDSTLe3aTsa+RfXE8wS8Mc0jezIC0LsqCM181IXnYjnzX+C/kPh9Yq+sVOK076
	 mTKpVqpgUxAZm8YdGqQ1HWoYjybuGqO1dOGNXwTvbF3GB0XClc2BOH1JUp9IkQKOBD
	 0r00y2jPlr+Dj0h7fTeCTrAzElhZnVNd8JCAFPuwKL5N8P8RTof96+GX2pK4dPY0i8
	 +q6KTYisUoR5zAXPnleCKh8r08YsqswqppH6t69P2/mfiwbb3tcK+k43N2D7vJROLU
	 xBi4NHdZL8zQp9R8StUxrYK8FbsSii8nujsyr5HSxcpJPnuHCAGjhxE5OaHMEjAwfL
	 csXUrBYXeZVXw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7EB12C3279F; Mon, 16 Feb 2026 16:10:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221096] New: [PATCH AVAILABLE]Please add MediaTek MT7927
 (MT6639) Bluetooth support to mainline
Date: Mon, 16 Feb 2026 16:10:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nvaert1986@hotmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-221096-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221096

            Bug ID: 221096
           Summary: [PATCH AVAILABLE]Please add MediaTek MT7927 (MT6639)
                    Bluetooth support to mainline
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: nvaert1986@hotmail.com
        Regression: No

Created attachment 309389
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309389&action=3Dedit
The specified patch

Dear sir/miss,

As of very recent, there's a patch that adds Bluetooth support for the Medi=
aTek
MT7927 (which uses the MT6639) Bluetooth, requiring minimal kernel changes.

Please see:
https://github.com/clemenscodes/linux-mediatek-mt6639-bluetooth-kernel-modu=
le/blob/main/patches/mt6639-bt-6.19.patch.

I've tested it on my machine and several others with several devices and I =
can
confirm this is working with several Bluetooth devices.

Also see: https://github.com/openwrt/mt76/issues/927 for details.

The only obstacle would be the firmware that's not available in linux-firmw=
are,
but can be obtained from official vendors and then extracted using a python
script (see the OpenWRT github for details).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
