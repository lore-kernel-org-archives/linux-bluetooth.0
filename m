Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304C918D651
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Aug 2024 11:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116975; cv=none; b=VCxmGQ+idMn2/YPsJDzn7bNfqzY+D3xz8oeRdNyeMOTejrDzl7RluWgb80HWxHwsKJ4Z8fQlzhbhBJeK0Qq3yo4DEEzS7hkSiCVNqv1hH5A7ueVSdtXTf/mrQAGz54leaNPoaYQmmJq8VQHVhxsJW1Ecu0skIUub2pY3U98KipY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116975; c=relaxed/simple;
	bh=jcozdenczioISaE6aA+5MTCExjJBJn/ozdvQ3ZDvy0s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OdnrI+hTnPa3Rg9o6ixSmqFCKFx83bZJSb2yenM2LDhMLgvfEIVQjHl7MeZNeZsxbVeXCDWdU49GYVOysRTNyGLCJFzsNRRXJLEcQOdeEpdGdt4qF1OARlZ96ePIPBp5z0wwai+6nQErOFTZENovghJx6UAnJm/DI/6hcg6CFgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/E2QjFC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/E2QjFC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6B51C32782
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Aug 2024 11:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723116974;
	bh=jcozdenczioISaE6aA+5MTCExjJBJn/ozdvQ3ZDvy0s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f/E2QjFCRHLAwSTRe1zgYlqiTKguKYWeZfgrUeGFOIkUifaQZjEQvJYTMaltitznz
	 d8r7Qvh55vBJyyJ+G0yMx8+NizCzFhLx6qGxBW+6yr3pwS9QfWqfD8srPz3mTAfLCO
	 qTFMThQIqgO6BAVepx5ILhYysZHeRXFi7fI/2Y5kAKkzu6DkLO8OWu23dJqurgaQRW
	 as5WwsTlV6a/k6yNghwqiXxdi1qYV/vZS3+iI5p4dJxqo5jVmQ4MSjyg8cHZaz0Dvp
	 JfrBNZVIl/btosuziEhZ9Vi9mGgY+z+3o3nXQFOF7kzscQGPKPpBvomibsSdEhqLhj
	 KGJ2UWft5xlYQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 96F32C53B73; Thu,  8 Aug 2024 11:36:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218952] bluetooth and wireplumber stop working after some time
 - dmesg report BUG
Date: Thu, 08 Aug 2024 11:36:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: nicolas.baranger@3xo.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218952-62941-W5YFCVph7e@https.bugzilla.kernel.org/>
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

--- Comment #3 from Nicolas BARANGER (nicolas.baranger@3xo.fr) ---
Dear maintener

Hope you're doing well...
For the moment, (good news?) I did not succeeded in reproducing the issue on
mainline kernel.=20

I'll keept a particuliar attention on this issue and will update this case =
if
the issue appears again with newer kernel.=20

Also, as I did not succeeded in reproducing the issue on mainline since now=
 ~2
months, I did not get any new logs/status which could help to find the Root
Cause, sorry !

I remain available if you need help to make a deeper investigatation on this
issue.

Kind regards=20
Nicolas Baranger

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
