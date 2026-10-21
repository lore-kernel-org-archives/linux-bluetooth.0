Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792597785;
	b=ZS5DgGJk6L56R1gR6GFMJhe82K50ryfIDdtFLvV9QeuVJHZRaVVs7P0DEjeB36TfjumN
	 Xb/z9UPVudaC/fh8jE/0NAczp5knuDar9GhhRcM19dpjAbx7GRxz9vzgsprA3OIPpt1r7
	 OJBbebkSFHG4US2yvuBiLyWNo32FZmSGAbsguO77VMlDSXh+mqtYu8Y72BEsZhFcOvFkT
	 7iV5YZ88PnCRiYcliZkUjUvCym0r5kozViyU9Hh6RRlJu1Kao2Rim14cl5MuDLrrMbi79
	 ilywCByiHHhT4TvHZfi2xSSyzZPa+YStNUmK30qGk5P/dZpoUkGNQWttxIJWLlNSdAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597785;
	h=Received:Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=xfjLnjDpy8Ee7zgmlC4JrWSADaaLcLfedzriSDQRn4U=;
	b=OCS4Mo2Gw2zD7LpAHksKMkIsMA0OrViIIf8DcdVONiUCFneBrDmiy93F3t12PlWWyOcP
	 1RxzaeNeMffs9CtoKnVSSQeMBnt7vjn6a4/9ZqQ2DpTEyQY8vqa1UTNpPlbv6l7CTbJG4
	 G6PBdTCRVSTNzhMA8ltYnvzQCgMEZE144eGFHRH4NWNosv0xpCE0UD9wKuv0UlN69bUbI
	 PyxjnHJhciFjENPJj+EZiiCuLoCIKujBChj7rdj8QVJJCZ+jfkK6pHQB4Uqui3AcVHCY6
	 1JD1EMuI3tsJVULzvqnx6s97joKu+aly5l2wFyIuMsD+luxn5yOCGno4guLTSVlIi1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=G1pju+7R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2DD606A31A
	for <linux-bluetooth.vger.kernel.org@localhost.mlmmj>; Wed, 21 Oct 2026 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=G1pju+7R
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD0C25771
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792597785; cv=none; b=u7bgY7fQH6ZB4b5wDE1ownxzHNLHokJJ6i4L1pzCOtbYBHi50k/yBnmFoKfmzazlHzWP1EXxu3XLXjn7bKCAiTfBQQYGLnGGukX5IIBzMpLjOv4luTem4G40xudO3d8YTXKtdUHdDYYw4fBtxyBE+13ighLOjF6kRoarx3wkNmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792597785; c=relaxed/simple;
	bh=3vDx7qhtoKfxXilcdZMZfBcSxZeT67WxVnafzTLkypM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H9YzsTWP3gFlg25yagYRLPXxAgGNYaCVqlVn8jj9opyfdV6WmtkzBSOvpHwUk94+4VyEibQnp5EY5txnnQHLhJNrzLCaT8WL45MTAXjavCDC09E1ImVqgwIBJ1Qu0kF5E/ZEqNXximNUi8w/6pc4AjyJ+wye3kdtFeDhX0JT37g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1pju+7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C6CEC2BCF7
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 15:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792597785;
	bh=3vDx7qhtoKfxXilcdZMZfBcSxZeT67WxVnafzTLkypM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=G1pju+7RErMZgYrrkgIPSnNICeCVf1WpcVLAhvGS9Lg3TKZJ/JQgiN8d+lJ71vpmG
	 NrLj2SvlOziMnbTaauGsqtzWGGfFhc8YvhNaWqRbxNyUsqs/mSVK7A+mkDLjBGg7O2
	 N6xVlpvL9Y9d9OdZuOdzY2b38/lchGbqIyoV6CdVRGPbmcNV1fgjMI0rsqRHPZghHe
	 KO4ONbF3Nnq7HDQay7IQeljUi0yXSCE1eOFLsWj6e7gU87xmvzmzKKFHfbFD98CR8u
	 HbLCqif/yaWp3OA30suIz+UPqmqfBsM6gTjE3+qTnGjacCRdWpHZgoXdKMXUdDMJUg
	 CqcSfGuSA3h1w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D1D1DC4160E; Wed, 21 Oct 2026 15:49:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222177] Bluetooth AX201 device does not work on Debian 13 on
 Kernel 6.12.114, works on 6.12.113
Date: Wed, 21 Oct 2026 15:49:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kalamlacki@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-222177-62941-ZHIhTAdHPL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222177-62941@https.bugzilla.kernel.org/>
References: <bug-222177-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D222177

Lukasz Kalamlacki (kalamlacki@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.12.114

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
