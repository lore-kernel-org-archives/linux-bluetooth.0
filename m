Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DDCFC0A
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824392; cv=none; b=q9kx6DTI8OxjGg69zLpLcEpztTD+L+yxzdDvYCsyOujehEwg2T49fczCabOeqgE39GmLgIHUsPrAw6uzjLWOO+2GdVuBcFll9aJCIE4hCULOQUq/n2rxn14QIST3kChubP0XRnv1a5FNp6mNgzo7BniXRr4kVCaG2on6mnOM2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824392; c=relaxed/simple;
	bh=Uhttl6uK6sVvB6j0fUp9uQPS0x7Y/kMTP7+8fQlzhoc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gWALywEWQSejsSWEqDNwlls+Kklh+DOldZ7X0AoSadWjjUkfYz3/yeN260x2TcIzlG7ZMrDCRPj6rK6QphtSXsGGjoFDUuyJuJ7NECd7BemTNSZjn78U6AEuTISTgHtVhtpb5Y4Ha8nYzNLCeew0d46Y4otJA6ZH47bBM2lNpis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0wxwlFT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0wxwlFT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FCFCC4CEDD
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 13:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742824389;
	bh=Uhttl6uK6sVvB6j0fUp9uQPS0x7Y/kMTP7+8fQlzhoc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=U0wxwlFTJl8Bqy23WpSGpE9qvAC7F4mLGQ8Keu7vKS1GQQ1WVzdzteGZXsTah0s26
	 XOLc1c8dc5XlRBVSxqlzQYVfegDgysx+D2h5whiiGMeww/m1ACgTzxk1vHx6o9Uwmt
	 pAI5Y2iVMl3g8/zEKxCHDqEKPp5MwtPA0k6t42tmBRUkTVot6T1HQxlJDuEweW4sgX
	 gRPo/dURJNk7DKOMB5ITnnCmJGdsnhBXwk5TfCfk5bpVyoWipl5/bECPZUfO43tSC3
	 YHD/5VtMi/ax1XC+NN6IC6XqjqRbb71tGl4wO+Sx14lPQFcEau9UEN9zceF7IyWPNg
	 RIFusd/mkSBxw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6ADD2C53BC5; Mon, 24 Mar 2025 13:53:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219553] Intel Corp. Bluetooth 9460/9560 Jefferson Peak (JfP)
 not able to connnect to Logitech MX Master 3S
Date: Mon, 24 Mar 2025 13:53:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219553-62941-iewVMGKBIV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219553-62941@https.bugzilla.kernel.org/>
References: <bug-219553-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219553

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #3 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
It might be related to https://github.com/bluez/bluez/issues/1138

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
