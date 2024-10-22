Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FACE14C5A1
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588913; cv=none; b=GSOduDe4IjG16shIKRTVUzBuJaksmycQdhq/zJY9HCmkv8iypxqO/OeJBpqcuJSk0DFjMdOlQGOQTLdafE1aSDh7SIca1qZvPSvTPOBPTZJ3hf3uBG/VLdcvrq5Z5aJjTXHC0XpRFO5W4XV+MXTN+fNaWCHVKZWDGShU5AjIjqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588913; c=relaxed/simple;
	bh=WlWYonqIbBj6LwOvpZTT2k7e7wJ1xZOT3AQq+9xhOgg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jo89GWBheGfBG6GMukwDpB9EFb7nnEiVjvov1hm/B9ATTc/9FglGdm+SyYgN+bORvongeeEPYAcIa/bEU/v/tY546lP1b+ahkpRfcRPDXCi8mCxHgOnU5RhbYjYwJoubzefRseto66oEOgEVRplA6KoKL4j4zVtmR6e1P0pVJyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pG3FhV0T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pG3FhV0T"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9ABB2C4CEC3
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 09:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588912;
	bh=WlWYonqIbBj6LwOvpZTT2k7e7wJ1xZOT3AQq+9xhOgg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pG3FhV0ThEm/PYYxCLIvCpQEuHTgpuzK+HAmaodtz4ANS4lt1oWrWIEI+9z4bD5zq
	 9cxBw34Hw0cUvczkCIv40X3/4bxU6fH8Xv73+PKalyk2TpkoTWsRuMefrZWQLbEGYk
	 Grx4ZE2FMk+qxzfssi3BwnovZBCPgzzL6u8Lo6nMX/4Wl4vn+GkJi6/8o2zmf3+WGh
	 dS6BkAfTLAtYQ5kjsujFZVeMc8MM1U3D0niCgjNMsvbkmlm19lyid1PoI66VCTNYvS
	 T1OO0L21HwvrD3tS8wbmK3M2KajLENvqg5xzEOPgak7fMTocAYptUGwIHG3SkmDNfN
	 TkvVqa0vfdH1Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 94E20C53BC4; Tue, 22 Oct 2024 09:21:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219405] [regression] mt7922 bluetooth scanning does not work in
 6.11.4
Date: Tue, 22 Oct 2024 09:21:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: eugene.shalygin@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_bisect_commit
Message-ID: <bug-219405-62941-4VOXRGDiJY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219405-62941@https.bugzilla.kernel.org/>
References: <bug-219405-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219405

Eugene Shalygin (eugene.shalygin@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Bisected commit-id|                            |e63125eec47dcc169cf62a2a564
                   |                            |48bec92a0a271

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
