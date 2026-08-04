Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962FE41E6C9
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785872146; cv=none; b=ky6bmv3YT/HDnKHx5IB+8sSI4i6gsTIenjcCtmW3GOymYO0ocr7j9RyIKcT0I9Zc9B8ExGUSP39cH+RnWc1TTayGuBd5vWKKuDaMsawQmhBUvsHIP6wbChK2/R+limFBJ6gqwO7Z6YGA/mu9Ne2Az1eNV3LNknVmnZ1ZKySioK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785872146; c=relaxed/simple;
	bh=7CrMiBk1MaQCN0zyGZQVkwbqjo1ohpJjtDLG2Soxr1A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j1VF6jgjG05WvOPAy8/0e0i32kZd0SaI6UgBGq0doy1hUe28j8hbhF3sz0xibLAV7/lbVjv5pU910YOJHdK5GjdlQ9w4JYr4LKfETvOR0yljEF8dhxW5Y5Jmo3whD7VJ7zfTgN70mHIIzZuWv5Hmvnh3b0isEgisLZYIR7b8Ng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhBksEui; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhBksEui"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EBA9C2BCF4
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 19:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785872146;
	bh=7CrMiBk1MaQCN0zyGZQVkwbqjo1ohpJjtDLG2Soxr1A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jhBksEui4GWse4F1eMLLMOHvHDMWsc7a6B/qOU8Qevsl7sap9f0VTRT/q9GcrfaTA
	 GAUEgCCydDnSfwRrn0HVTeDuzO1odQW7EFYtbEXdkgTA6fRyUNzdj8H1fVkrmH/JgK
	 LUaR4utDVLKBVkQBUNj5s4Rh/F78ZnbbUU6+YWBCbYpncxtf26AoT2OsnpuKdAl9Vx
	 Y6lxASCwVmB2fcMlD36h236b8HYbQTjXcZ8+PiM3PV0Uv5aZbgzSwSnHucwzkXu9gd
	 r7waWlVCs0y46I0gmJUYLKpWld3I+XFgm5itcWLe4p8uKfhHBC0+RY0yRivE5SoOyc
	 pSb5e/j+Ylyhg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DE347C3279F; Tue,  4 Aug 2026 19:35:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221754] RTL8852BE Bluetooth (0bda:b853) fails to init: Opcode
 0xfcf0 failed: -16, hci0 never registers with mgmt (BD Address
 00:00:00:00:00:00)
Date: Tue, 04 Aug 2026 19:35:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: dohojda.adam@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221754-62941-TKnymNQmxv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221754-62941@https.bugzilla.kernel.org/>
References: <bug-221754-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221754

--- Comment #7 from Adam (dohojda.adam@gmail.com) ---
(In reply to jeremy from comment #5)
> Might want to try
> https://github.com/mihaits/rtl8852bd-bt-linux/blob/main/README.md

Thank you very much. It resolved my problem.
I had to additionally  enroll DKMS key into firmware's Machine Owner Key as=
 I
use Secure Boot via
```
sudo mokutil --import /var/lib/shim-signed/mok/MOK.der
```

Thanks again to both of you.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
