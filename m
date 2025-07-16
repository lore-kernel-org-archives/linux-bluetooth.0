Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910BC1DE892
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679669; cv=none; b=eidcxFs9FJmv7MwOwqd1whNU390kDNJaNgAsuQIbGeCif5XHtPxCcEc5sMrKtcU4sQZYTrB2LWTiHglaF/4xCvvw08X3bvMQUMhwkrzNw48hMYftmu2p9wENUflJd+2i+JnK7AbUUYARM4afj7z9GDNHArofoORX+eCrlIcjCoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679669; c=relaxed/simple;
	bh=46h8yJOE9yFsddJ/oSmnm3TWNsBv9mbxFzFrItH/CuQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=epzHXJmvxOTUv7M4ZWbKa4uvX9qDzahm8N4FfGyUGriwCP+yP0FwPq4z6CdxExwghmX5jnh+3GSwa8ybve9F6ODvAqmMhUHEiFz9sPhlIIfUxVf7DFLPeVByWos8/MkFL7pSz7gWYDt4vyqCX662aqOrDTMWCKqn8pttPuoGMQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oROLre3e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oROLre3e"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23BDFC4CEF0
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 15:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752679669;
	bh=46h8yJOE9yFsddJ/oSmnm3TWNsBv9mbxFzFrItH/CuQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oROLre3e55AZMdg0fDwLGB1sbRpPWyzspSVVFTIwSkexutHcnz752k0peaXka7ois
	 tOfvEdxIdppYqdAeRdi8Aq64V4enN8LBNInWl2T2qAbMkPeeqVoYDQEFVQe6lQkAPW
	 0xqq5Zfbaa4qPtZeCJlaeqzdDqtEgULb3u6qElaw7JG4zIxK/7yTWa/5iCtNXQ1qvK
	 bZRaj0Lr6e7f2EejuAEZd6SZJCpCv75nfFBQx5aHhQl4eJp5RPD6lzGel3Ef8gzo4C
	 ALxWMd9lIHJ3Ldcck2t6Vu+izU6p4rqoyNY5nmKPQEhes09g+yptRFhlLe/kBKXU/7
	 0OQxGqa+ik3vA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0E4E9C433E1; Wed, 16 Jul 2025 15:27:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220341] Bluetooth crashes about 30-40 minutes after I connect
 my headphones:  "Bluetooth: hci0: Hardware error 0x0a"
Date: Wed, 16 Jul 2025 15:27:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: martin@hignett.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220341-62941-QR76UyMo4a@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220341-62941@https.bugzilla.kernel.org/>
References: <bug-220341-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220341

--- Comment #8 from Martin Hignett (martin@hignett.net) ---
I've been listening to music on my Bluetooth headset all afternoon and not
experienced any issues so far (~2 hours). I've not had any video calls, so
can't comment on that.=20

I've attached the output of dmesg from today (note: no Bluetooth errors were
experienced today).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
