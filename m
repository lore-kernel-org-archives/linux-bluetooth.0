Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3A813957E
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 06:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746079616; cv=none; b=VYkV/g0y04FKNHTvZVChCJVQrN0gkeEBHKwMkauKPs2go0zBH8P/RBL1fg8ivNjdn9F54Zq0Mpd4DGatEqRMQQS6MJcASMc+MzYZ9DY24NjHPna1l8FmTauoR9isgqH83JmDQEF9afd60M3PxXYosvIEpFT7Sg6RbRSejDkZ2nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746079616; c=relaxed/simple;
	bh=FOaFNSg4yMUMGlmYXFaRK7sZpepMvl6f5v5E8Eg2xpM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J/xGD1uL/CLv6OUqROlxJJUUgogmvAD29Uc4qQlsmhqF7tMRK5VWxMXVAFRlv8tmlgtYGhcRZglChPDu3OM5h2EDkSoIBjAoKJShc8qlYtAotOS8c36lZf5eScUMn6cZGvf+Tjlb7fiQTGpt+f9+r+aZrhBxlFZQXMrcXtlNq7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ceih17rh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ceih17rh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6885FC4CEF1
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 06:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746079615;
	bh=FOaFNSg4yMUMGlmYXFaRK7sZpepMvl6f5v5E8Eg2xpM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ceih17rhy0eXcuA3ughoNTF7YuaAUHHZ1xxRAfPDLjlNpttvTLLg0oD+RZmy2Kohk
	 cRgsNLcJoSHUQcm/tdyVW3q51gQMCn/GNGlfuRJQubLDJ6RzzHaThUKvDosd1t3se3
	 Jv8/K5KiydbaW4r39mnpbKma9sxkcowVQ/beuBSoSlgZPr5omvSlISjjkI2Tga+BLt
	 PLM5BxvGd9e8YpShcPDJp/RQxtJDzZtGFzsKQhea2hAlBRInVQVVJO6AJFcJ2+so01
	 avg2AgwPQhU2TD/bvesPKE5dbTJD5UXHzsQAwQV0IvnOtDNfjbT2HsGRL4EbbOU06G
	 zqTs67IK0bSPw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 60555C3279F; Thu,  1 May 2025 06:06:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220061] [REGRESSION, BISECTED] Multiple Bluetooth devices
 cannot be paired under Linux 6.14.4
Date: Thu, 01 May 2025 06:06:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220061-62941-MWh18HyK1w@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220061-62941@https.bugzilla.kernel.org/>
References: <bug-220061-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220061

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #7 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Please test Luiz=E2=80=99 fix [1]. (At least I think it is.)

[1]:
https://lore.kernel.org/linux-bluetooth/20250430192448.2386611-1-luiz.dentz=
@gmail.com/T/#t.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
