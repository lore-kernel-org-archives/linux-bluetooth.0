Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99BE343880
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212389; cv=none; b=kRACs7GuoDf38c7CxMDbWNOTw2BXG0LWBU/VPv63xExJolii/Bgz459vUTQnrSO2KhRlgkL/2jQhXK5Pxd+rxpGFuPncPtzxsgozMkC5+Ml4p9GG6211wnE0iwDUndCKWftx1d98DC9A/7fn6RNK2j1d6WBMvMEKG8Mv30Z41to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212389; c=relaxed/simple;
	bh=0/PRXQoakrcHMCQYbRcKrMP9KTswd9TIhNG4PB86XGA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pIa0V3W4ILa00K/PHW/oVn3HxPgWxh0td0z0Ju1+ul7tAuebbld2TJUsg5fLqKFUDDIQAONzx38v6gZ/y/BApm7Ws8kmv3rQ8xqgrLiWKtoxMnrFHvzbtqJNwlfW84rxt4HiODGas8cX+niLZxj++5jTko19L61HAz5jE6872Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3p5O5VJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3p5O5VJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AEA6C2BCB3
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 17:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779212388;
	bh=0/PRXQoakrcHMCQYbRcKrMP9KTswd9TIhNG4PB86XGA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=G3p5O5VJTioc4eRFpEHilOUaaumIMuWFBicrK7s80vHVCbYDkeWmn65CP/KbViJ/J
	 jdskxHkdSdWt7lpGnqvT9cu4IcN1NOL5CfSDy6jTgdAJf2E7jTM1ik41JAHODjH6jB
	 BTRNrPR0iLSG3nSImykovmbb6BG8NWDh9zxPoul+L7twbJul4kdtf4H+B0OesOE0RG
	 zwh0j389vr/7ww4A91t3cyEVCF20uRu9o56clMPn7/zwDh9uVulCwhOQxCYMM/P91y
	 odjORe9CFUBl38nEULtUWxb3fd3MN45vwV3j1If02c7o5k9En/sHHWsTFS6ga/SLsY
	 flyxJzUBopuqg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 88BB6C433E1; Tue, 19 May 2026 17:39:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221547] MT7902 Bluetooth: Failed to send wmt func ctrl (-22)
 regression in 6.18.31 and 6.12.32
Date: Tue, 19 May 2026 17:39:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: olle@vixit.nu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221547-62941-MUeIDFBD13@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221547-62941@https.bugzilla.kernel.org/>
References: <bug-221547-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221547

--- Comment #2 from ljotom (olle@vixit.nu) ---

Yes, the patch fixes the issue for me as well. Device: Foxconn/Hon Hai
0489:e0f5 (MT7902). Tested on Arch Linux with linux-lts 6.12.32, manually
applied the patch and rebuilt the kernel. Bluetooth works correctly, no "Fa=
iled
to send wmt func ctrl (-22)" in dmesg.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
