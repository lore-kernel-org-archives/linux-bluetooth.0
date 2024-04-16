Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B1E5A10B
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713259474; cv=none; b=mP2Z7ykLBQhCFRguk319ttiGYbR4VGRH+I4dIM+DuIIDKM5NIBvk/e/hw4G9xDeR7IT7uxLVatXQvg+Lwo881ZW7YmQxNrmKZTru6DCI2NaJcikndJVJIHwOcttU3akJ0ELVzHM9929PMpgh6yz3y2avkotTCGgOE+QP+p0BXqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713259474; c=relaxed/simple;
	bh=EAM82pOGpVSQSe325hey0tns9zpGQJpgkVpsXHCZXGI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HSVnugHniTlfuKzlqSv8vdBOHp/a2NjQsaA2yuzt26Q3WNYdvZGJ+3IFJeb8D7eeMn4r522nlgrYEqlawJQYky8VJxsfT8A5hkEjfomVZZziBn4zCVMbdPSQBkhtxu3fC9w/9LycA4VfoD8bmhXE0hS5pDJ3RXTpV0Q+aJ7662g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=im8ro7CG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="im8ro7CG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92B98C113CE
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 09:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713259473;
	bh=EAM82pOGpVSQSe325hey0tns9zpGQJpgkVpsXHCZXGI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=im8ro7CGo4yM1/47PvQgRYN5aJkjqYSFil3Mct8LYCWgsy/SIVOJ4aSafRsytYbKi
	 vYt1sxBDAx9j1P9aEhQbfOYdwuaxd9kszA0pZzHf9z5Xl8xWbEzkjzRueEy4mEkvtt
	 rFBoWnC4zl4UYuGgepgUzEDubHeQ9GsGxq8bqJn9dBvKAKeRb9G7sx0MPC3s53ebZd
	 pmh1rGThvLZCYElGfFpE5JdLay+df6FPgyLV4dEnXYS3KNRelW+IT4Qo4XJDv5NWFQ
	 ubXVCK7e+YxB42ExdDVOmuUvIfoi+8Ggc0QKR5uwIrfHMyhX+aNE0mL0vN11V6XfZR
	 zyojoQiXf2j7Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7CFEFC433DE; Tue, 16 Apr 2024 09:24:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Tue, 16 Apr 2024 09:24:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wt@penguintechs.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-bCDangZrYK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218726-62941@https.bugzilla.kernel.org/>
References: <bug-218726-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218726

--- Comment #18 from Wren Turkal (wt@penguintechs.org) ---
Okay. so I applied your patches you linked above to the tip of the
bluetooth-next repo master branch. That appears to not include all the chan=
ges
from Linus' master branch. When booting into that kernel, bluetooth works w=
hen
I login to GNOME. However, bluetooth disable/enable does not work.

I also have the previous kernel that I built that was essentially 6.9.0-rc4
with the revert of 56d074d26c5828773 (git revert ...). Bluetooth works afte=
r a
cold boot after I login to GNOME. This kernel allows disable/re-enable to w=
ork
multiple times. However, warm boots do not work.

So now I have some questions:
* Are there fixes in Linus' kernel that are not in the bluetooth-next/master
kernel?
* Considering the only functional difference between my revert and your pat=
ch
is the bottom hunk of the second patch you linked
(https://patchwork.kernel.org/project/bluetooth/patch/1713175927-13093-1-gi=
t-send-email-quic_zijuhu@quicinc.com/),
does that the difference between disable/re-enable working have something t=
o do
with the quirk added by that hunk?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
