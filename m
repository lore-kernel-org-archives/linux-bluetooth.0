Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D7A23A6
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 00:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729125340; cv=none; b=Y4xYmoiixKs7PeKql8l63Dw0z57LDLUQSB2vroKqWRTO45vgZ+4mkv6u9VpMoOxBYzbXbaiw8kRzhLiWvjMFedPNxjCTMOrsxJkKilkjSS6/JryAlZSm8Vh2J9PlvYAw0s2wbLd7JeFifKEEOh60W2EN5Z2lbA/J2P2csJWKYYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729125340; c=relaxed/simple;
	bh=khmA0Do0I0Fuk0yvJPNM4P3UeouVKb97Kghs6i++Qpg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z4+mXLurVaq/kyL6TICQKM3c8dzUZ5GX7XIRC4N4TrYeqK4UKKMAsQKGGB/UuS4BYwtgin90AKw8MOJbrFYPJrz0xW/9s4FNJ+oQPxjPh+ht21cjC2z9pfa/VNXxogpT0G32wOCAapH66N6R+mwgr/ZC/J2hpjKRfzjt/LlqILw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndXP3Upl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndXP3Upl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62A95C4CEC7
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 00:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729125340;
	bh=khmA0Do0I0Fuk0yvJPNM4P3UeouVKb97Kghs6i++Qpg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ndXP3UplPtXOmndyuXDZ6vISp1dVwlXozMWws0pesIVD9J49v+sf7GyEkrVVc/KCj
	 Y/ARkdPvialRDreMyVFZs/K71IhIQtnyab7GFnY/nsCjzLHn9xUcbzPDsEiodJpsQz
	 HW7txgeOx2pGTh+TO8M5Q8TEpaszW4sxPnZvkc3BHLuwWTAkxr6Gq3KKSGaaHm++b8
	 taw4H1w20RKHg9c0J9OaTksjOZO1KyZPllza6Y6NqIW1wYdBYofgw5ZjrhmB08N9mh
	 y40UJL3A3cyV5raYTzu7gFJhDIF7qxYxVNwHXAF+b8Q/sarZr/9GaWSVcA5L1vacS0
	 Eaje7B1YlOyIQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 54C92C53BBF; Thu, 17 Oct 2024 00:35:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219387] Bluetooth: hci0: Reading supported features failed
 (-16)
Date: Thu, 17 Oct 2024 00:35:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alexknoptech@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219387-62941-y57qPnGh7d@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219387-62941@https.bugzilla.kernel.org/>
References: <bug-219387-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219387

--- Comment #4 from alexknoptech@protonmail.com ---
I am not to be able to say whether this is a regression. That is why I just
marked No for regression. I recently acquired this machine and noticed the
error.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
