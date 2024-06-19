Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A756A01E
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 05:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718776057; cv=none; b=lrXwkA+bulvehPTAXnRIV3MIdTytsbd+XusIXKCMAv7qA4CLn+oxnXpuTu3/f3YsvrrSHH7H7dEAVvJFSO5gjPBxtdP5CRsWI1xiAmONusSzu02sPcfa7pWOpe1jrzuePRT1HcLKHWgkQXLb/QemXBNmfZVWciARsFkQ4X7iI78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718776057; c=relaxed/simple;
	bh=i7Ay1U4BGmnhKyjPMOshlpcfC6IbxgEfFWKwtky/HvQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uXbtGjdQY28VYw3+CUFnGfWrCDqxrfuFLke0KD7AsNUxzLMOHSeT6nZhB33EawvTtR7OkFRDV50h6JdrOcbvuOM96vCbLxP8Wxx7FvunZFTx0SXtBWznRhfyKtAY2baxxs5ByfemVSt3v4jYxKpTyyrMN9dlG6BxTEgE93jUw5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpKqYAAb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpKqYAAb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76844C4AF1A
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 05:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718776056;
	bh=i7Ay1U4BGmnhKyjPMOshlpcfC6IbxgEfFWKwtky/HvQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FpKqYAAb2psJI7IimRrvjK2H1MftJPfnDQrGVgsbRzrFVyjwUoq47R/WDTUZcEZq6
	 blXRZkskPB6hByBMY0EnRm8yM+IzuV8JlreP8NUwtL5DpTsxUmug+s/kk/Rj4nLatD
	 Ho3BC8QG/29uPBD7JhJXOWXIC6i6vpTZl3WSlRkQEKCRMAiWgOT1Nttqnlf5NWbEwj
	 lsTGX+NTH0kjbQIFYCPiZCw5e/I0uLDDHca/lVUWYJiE/wFckNhqWmLSTPj2ll81Gy
	 VESiQSc7LFta9bKWNzJV5TLMo8gTRzXGqfRx426OBUpL8cciz+2NqpUheM9d4E3rtD
	 G7XB++aFeDf4w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6C927C433E5; Wed, 19 Jun 2024 05:47:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 121221] Unable to pair / use Genius Navigator 900 Pro mouse
Date: Wed, 19 Jun 2024 05:47:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jiloxe4653@elahan.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-121221-62941-cpcpAtxGxB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-121221-62941@https.bugzilla.kernel.org/>
References: <bug-121221-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D121221

TiaPadavano (jiloxe4653@elahan.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jiloxe4653@elahan.com

--- Comment #7 from TiaPadavano (jiloxe4653@elahan.com) ---
The online course was incredibly informative and well-structured.
https://lafontanacitta.com/blog/culvers-menu-with-prices/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
