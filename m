Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350122C11CF
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775812707; cv=none; b=c8JcrXHzmcW3b0ZyA/OJCIF0+VtZ4g11rOJwyK0StGSgO9L/aEfip80bILYxk431SG/FL0KjOWsCVGVO3N3691ETAOUnz+a85ccS5VhjX0xS6MoqbO3snwjz3BW5G6RXIZPkwU0UoAFCb10XE4FMojSHblRNtuGeXvhUXeSeKD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775812707; c=relaxed/simple;
	bh=+mqDv/3CSLRHFdLMTbSQbDK4wOjhLNcp77A64Sq9EHQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SRomfuYKeMbF2vKoby30jlCbqi9o43HmAXPD+racC6oeFCzxpVAqqDNErofJotRyT9zvRMVbhFIUd/MniaWgsgBwdeiLM3zppgqrQXnT/UKG6u1xaeiABT7YLGdvbp4ZZ5+WK4pDrPU5d/z+0YZQ5B75ILB2gzMKK9CvkhIco88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7BcWR/D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7BcWR/D"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D33DBC2BCB0
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 09:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775812706;
	bh=+mqDv/3CSLRHFdLMTbSQbDK4wOjhLNcp77A64Sq9EHQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=t7BcWR/DrZS8yLdC+UhcTThcnE9TMV83gGV4xLMKg+ZZ8HthejIH3rDdrVlYHa9cj
	 Zn1tFps6KrUZ2W1zb7EfklwCpepnXYRBOSojttm8JENQJ2njCCHqhtWiwamgNQE8ne
	 CxOZr2pfe8/0bw9y7Gq3G12ZEZR0sKPPOB9ohuA6T0NbnwHVXvwN063acD64T8P4aO
	 gxbNHkB/e6mxAw4scnRAqYZuYH7fAtjDcJOurs1sUeNrye1KydBUS1ArJStOXDdYjz
	 6RAfJsLIvlOXu387F2kFnqNkgGeGOdS1JfVtbOecrxSjhvYee1cUADSvUbHV9n9asL
	 8y4umK8G99o/w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CE0DCC433E1; Fri, 10 Apr 2026 09:18:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221339] AX200 -19 errors on boot after firmware 20260313-1.1
Date: Fri, 10 Apr 2026 09:18:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221339-62941-oVUqEHghGF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221339-62941@https.bugzilla.kernel.org/>
References: <bug-221339-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221339

--- Comment #3 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
I missed the Bugzilla tag:

> Bisected commit-id:   81608d9216ce1fe954e205aa867655b1a5bce1c5=20

It=E2=80=99s always good to also mention it in the comment.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
