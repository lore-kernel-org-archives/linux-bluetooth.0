Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2970A328267
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 07:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778828629; cv=none; b=Db3ggwxo/adJadWQqxlmem4Z6SwwT/j3dq1DcGq82WD1E/E9Rt5p3RjHEDmj0EEjO9TfGl/KzKNq6mvvMj2BL81HkjQYTPToCtOvRGz3wNDPI2RbgvNqHWYH6C6fcb0J9uoFho3qPevNXutSC8lDGFxm1dVsK4+wrLvyznnWYDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778828629; c=relaxed/simple;
	bh=LJHDJIwB2pzsmwnbCpW1V8pH1F62uQTd9kVBgJSkZdI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KlQOI1Taa9T5U7lFJr+eM56JNWRW8qG5IFpSaOv7Wwr6yA/DH7Viy1jFLqaDqr6A5k4RzhH2sbJDhm6FpHZMNtqqsbz8rJEthtapkrMlXzFc3IHaubspoEkErYaDmNZV0DRvJST9TSicDU4QhDzSouiN5IzT0snYID6o7/vmF3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPnUqxVb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPnUqxVb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FD4AC2BCB0
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 07:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778828628;
	bh=LJHDJIwB2pzsmwnbCpW1V8pH1F62uQTd9kVBgJSkZdI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cPnUqxVbaKkdSlEaT1lsQkZWRdyYTNtV1huMKV29FDEj2so+qvpdTALmKIROcnftS
	 ROLkI6i6ML04W36F8Ay6F4YGNDsHhj/aX5F+qSG+vNAO+Lt5CPMO4bqwztzbLlvt/1
	 NemdIQ1oqL6+l2naMrKmS33HnM3Pg3QwR7X2+QDNhVkXNuHr3lx1rUv3O7jAd5nhAy
	 8X6UoH9Jjys0kFH8KefG1ZvZcDikI1zToPlCQjJWF5RxG/aqQ40xglg8vrEmh3HBRM
	 K8bjWljqdAYDdsWSsiCQvOOY+liHX2kZL6M1l4UMKHHpFdcA9PGqukzST+HvRWk7Z5
	 bF4g8T10nJWQA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8CF5EC41612; Fri, 15 May 2026 07:03:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
 (-22) on MediaTek MT7921 combo adapter
Date: Fri, 15 May 2026 07:03:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: txxlc@pm.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: rep_platform
Message-ID: <bug-221521-62941-DkvrXX280L@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221521-62941@https.bugzilla.kernel.org/>
References: <bug-221521-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221521

txxlc@pm.me changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           Hardware|All                         |AMD

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
