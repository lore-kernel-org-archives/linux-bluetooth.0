Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E633217F5B
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Nov 2024 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006270; cv=none; b=WMf1U1j6nV2p7YnHmB9hLjIugf+0imMWAB9FNb5+vpChcEt1/V7gA06g36Agn/1c4DoqwPi27EKN+wfbgJTn4Btuu6U8J/Rzw4xmc91w/+BVEoRZMUMUSXYpjqCXR6BR8DcxzDxK9mjBYQi8xwnZ8Uf5F/HHXIdiQ38JFVTrWWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006270; c=relaxed/simple;
	bh=ifTAsguUmuXzxLpg7A1G3GCb8bAfNJUj41vnvkfbnTo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gulO40hh+gso0OXWoGsb67ePdWqZ0FnSKAYK5buY+ror9W+XDl5SARTnvodYlBfjLoNEimn0ayU7ywNwGBXcxkS7R8U/SAYo9aQZQRvLL3ZE5N4YBLxfa8tYyJuU8Qi+7Xeiho68oawUIJyonGQ08jYE3sd3UwL2lweYE+PIfcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNM360Yf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNM360Yf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E02CEC4AF0F
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Nov 2024 19:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731006269;
	bh=ifTAsguUmuXzxLpg7A1G3GCb8bAfNJUj41vnvkfbnTo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dNM360Yf6CBm1oD9CSvamoIwxzea984PGQSPQco36fZqMWqNm6Df5qri2GCgrm/Va
	 P2dQ4JMvzrBn21jKKAA8d1S1QPIfBboRGnBBYuEdI23xsxTggFt/GOOqTmS+Ewunfu
	 AO0BCrg/NFHIwCY9UZOfqspYlbbBwrJGjeNrE5+ytwloVpcOjoh/l0L8HyTFTKOfcs
	 cdzcoGY6tSYIa3v8wMq88++mzbVkiPK2MYI8G7yy8DXaDfULEf9snV0QTGEfmnTZBM
	 O1vH3AU8cCOqohew3EsPB3qS256SAWp8k3F/CN9WC60u/BZhUOHkwnViuV3A1cSu5Z
	 hML0+rbiAaGFQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9FCA2C53BC2; Thu,  7 Nov 2024 19:04:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219481] Buffer overflow vulnerability in btusb_write()
Date: Thu, 07 Nov 2024 19:04:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219481-62941-y2QgE3W53K@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219481-62941@https.bugzilla.kernel.org/>
References: <bug-219481-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219481

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
