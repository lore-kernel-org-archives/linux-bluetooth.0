Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB490522F
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Sep 2025 23:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757547081; cv=none; b=R6T5AGcE8LExBZ6E8tPUN4zNPZ0feDNqW1FikF+VKkeklm3+Ctftd6PRAngM9otWIzX33fQzXBZwz258LDeOcMDL8PqFbBpV9EDLSa5Yc5ZudbF8mSK3+y9ZABnod6/GT2fj2iiR+Y+lfkmnRfPU0ZjCrVCZBp/11b7Cg2xpBww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757547081; c=relaxed/simple;
	bh=PzUXpvKcv3H9EzKEVsCL9DgcAfJJHxLMX45ZYLi8UNQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jCLnojZ7yT7+Gf7R5WdD/V93YOyuyE2sZlr6SG4FMDwv/0EPSe6O8KtOTM7jISVB+Lfk0wg5ZM/ZIem3moXTqZ5aRi43ppcAMivfiWbVIPIVxMF5k+sfP2rBFyxOYBj6z6guD9qzd5cNkF5koqjm6OCUIzxtX5/Ynr9zgr7Tw1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=je7QOP/F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="je7QOP/F"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B840C4CEF0
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Sep 2025 23:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757547081;
	bh=PzUXpvKcv3H9EzKEVsCL9DgcAfJJHxLMX45ZYLi8UNQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=je7QOP/F9bomGdle1TapfExlFDLb+DOPl4tD2/U45y7OtW0mqrst034BENufmPMaB
	 q15TO7ra5AI/4K27KQ2VEmoStGIyjFb3HoyhoASOBUI5Ak4qXolBslru2IXD8olGI3
	 IHx7E8xcb8fwO7UWxcZa6DI02BxaB3vhJpFT5th3swSvNSTnMedmCP1kKmVzhzNcUq
	 JjfdmRQ7ry1+TKTQ5Bcb6UHrG5lQb3tfMuHAQDczRPjvTNBUdX4Wpz1pRTtMrG4ccE
	 4hyn9nmcVVdbHWTdp6lvYnLiUvLb4Dqdeig+ufbPoObzN4KxpY3kgI8q6/t958ODT/
	 UYtd01o2O8Rdw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 727ABC3279F; Wed, 10 Sep 2025 23:31:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220564] Wrong indentification of Bluetooth in Lenovo Legion Pro
 5 16IAX10 and 0489:e111 Foxconn / Hon Hai Wireless_Device
Date: Wed, 10 Sep 2025 23:31:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jcubic@onet.pl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-220564-62941-CxXOChwUWH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220564-62941@https.bugzilla.kernel.org/>
References: <bug-220564-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220564

Jakub Jankiewicz (jcubic@onet.pl) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|Wrong indentification of    |Wrong indentification of
                   |Bluetooth in Lenovo Legion  |Bluetooth in Lenovo Legion
                   |Pro 5 and 0489:e111 Foxconn |Pro 5 16IAX10 and 0489:e111
                   |/ Hon Hai Wireless_Device   |Foxconn / Hon Hai
                   |                            |Wireless_Device

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
