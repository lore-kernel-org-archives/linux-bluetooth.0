Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67E5388891
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121810; cv=none; b=hWx8IH847Qb6GvAOAZL4Rddk9H22o+k7GehGw2ZxPrnNCccWzcIP6SwboogyNpwYhhwrcbzfZnsqj0iokBeJ5HlnOuii+h7dtHQChYwXjKO2BR95p3Rfyu12yDO+s/E5hG4VvaLGrnl7PnIqoPDRVMRp0syU6nVIXS2ML318q8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121810; c=relaxed/simple;
	bh=lT1K8aU4m6O/zNhK2lSUJawKFyVbShl1u0vJUeO4lPs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oxfIGcNkbT79QZvB5meIC3TokbDRGZQRf/bKjGw9l4rbrsopU/OptSibttN1g0suGc3s1z0begHT2Im22ZgcXTrOxenLcj7qAFu6pd287ubrBoHlw6fwFysGBV12GkWjJM8Jijmmo8tncfRatm0rBHm+B8/GOQ931UYx47oZruU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1XOPglL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1XOPglL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49D01C19425
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 20:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781121809;
	bh=lT1K8aU4m6O/zNhK2lSUJawKFyVbShl1u0vJUeO4lPs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=s1XOPglLIsCathV9aOCVjiYBwIFxrYoth37gqIpTQ7fACCHnb7baiVMU2eIKHPZkR
	 UAtV8dNDUiPsQmshNq8x+h2YwXR3xrU3aObzj6X1as1tKr/8Cz1WNZZmYt3zQ4Bqho
	 TnoHBOcr0b/TvJPwWnECNGcdhAX3PTK57ypcmXYvA7a+fGoQHQo27cAatTTatDB46d
	 s+K49Cynv0Ykm4y8ihMeFC7BTLahINMjNnaTmWiqU6HgGMw5ZOydJv0wj6nPuNJJ0x
	 M2I3rj+3I4/92Yd6gRQ/IO9+N4OQ9V/+yQ82G67Ce+Xb9jyYBjvTyo9wgHmxDSmiY2
	 0gqp4n9swcEYg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2EB55C433E1; Wed, 10 Jun 2026 20:03:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221637] Regression for Intel Corporation Device a876 (rev 10)
Date: Wed, 10 Jun 2026 20:03:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: furstenau+kernelbugWGvWw1PW1l@posteo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_regression
Message-ID: <bug-221637-62941-qs6fH7OAlx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221637-62941@https.bugzilla.kernel.org/>
References: <bug-221637-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221637

Bianca F=C3=BCrstenau (furstenau+kernelbugWGvWw1PW1l@posteo.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
