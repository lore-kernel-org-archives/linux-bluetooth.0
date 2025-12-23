Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D0427472
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766505836; cv=none; b=P56NSToEiEKehheU9NA1A3wIfNNPnDs4PPkoG3SLEkiUSMmFpFrtyJmCTas4fjhqIlFtNu/OdkHzeHv2/mzaw+LlW5LmQGVCyo1pERiZOiOTY9+AIf/3ZCKSwHkwaFVCjZM93pcyU9HN2iR0upXZzHGLSL7Nn4csbuxDgzFzzpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766505836; c=relaxed/simple;
	bh=yiRIDUrl0nLgF8eHd4LV1zC0FGT0pIEvw0lrzETll8Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LBHQjk3L5OCgBg/H58KEykMvQ8GgWvTRhUGCZ+hyen6kHm96D+CfiBgduyV1xqApDoWVhehgXK18aBVUSMbPCGkoJaYeiIwrwz2moWexlJN0Vh39wTxSq9/lcyBwV0ko5hRY4rg7uFCM2D+8cNyXH+2nkar+lZMp+jqu61Ibu2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7xnKdeV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7xnKdeV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD747C116D0
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 16:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766505835;
	bh=yiRIDUrl0nLgF8eHd4LV1zC0FGT0pIEvw0lrzETll8Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=B7xnKdeV3RkoUh3meEFsBll3escpa1kJt2x2UHUew6ILWaZ4whm6NUQ5MMhNsN6mB
	 H9x6HhjMmoD8/0+uEAhQe+9+HPXYDw3wwG1uUUWxFPRYnshzMuVceRqS2WtxnRYLz/
	 emav76P5fa5l4FwmQoxWJyFRCWflVMaDYVAcVHcMbmJjKBkP5ESOQWqz/YHj8SMfEv
	 tGlefZaBZ/0ORTK/tOpM/bvv5FNFzWW5qDcM0dgOkyBz+VndP6qTxltwGn9WatSyMb
	 g6auKV8UWgRombvvDCmVAokPCjbmJyzV3yQbaR1xBTMOBOXew8Q5xy2AfHkg0cA60J
	 O5yzwir2trINQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D2D1FC4160E; Tue, 23 Dec 2025 16:03:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date: Tue, 23 Dec 2025 16:03:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cheako+kernel_org@mikemestnik.net
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216936-62941-CrQ3DX4e0p@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

--- Comment #36 from cheako+kernel_org@mikemestnik.net ---
I'm all for tracking this down...  It didn't sit right with me that I can m=
ake
a call to unplug the bt "dongle", but there isn't an associated call that w=
ould
plug it back it.

That said, I'm not ready to jump right into building the entire kernel.  As
indicated a little nocd cracking was all it took to mostly fix this for me.

I'd love a DKMS module that I could use to call these functions from someth=
ing
like sysfs and I'd jump right into documenting what these all do on my
platform.

Thanks.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
