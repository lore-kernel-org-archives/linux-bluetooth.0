Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBC01B808
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Dec 2025 05:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766206847; cv=none; b=Y+46I4liequ1Jr5cqpuQ8mNcSF6apR2r+5h0g6s3Ttm0DRzgjeIOGnuBDTT5K/C8RYQmiCaBa9IuErwh/66u47kgYy6cRCIArDdu0V79ZE+u0YUkb3ktqfIrWGqPJ/6M8FmSsUds1NQNO8YolHpv3nCPuYaDON6itGmDtx5W9Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766206847; c=relaxed/simple;
	bh=KWy8xEzCuf9xc9M6WNwKjZT33XRdssxZi+TnxRm5qJA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vh5CpDy2JXj+2ro8VqUal6YujcxizXhRNuax+ZUg1cAYCjWF1onSwODsiwSiQj0s7Eypd61+6oY8S0CYBGGlpNhfEar8o0+RO8stzi+Jru45EDzoWBuVFUugX7rFDZf8e3W9umLTj4kLBXLpxPNKH8WOnXzp+Mp3XE9pfh1uwDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SX9JeaJp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SX9JeaJp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04BAEC116B1
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Dec 2025 05:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766206847;
	bh=KWy8xEzCuf9xc9M6WNwKjZT33XRdssxZi+TnxRm5qJA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SX9JeaJpgP6Hwz1f7d2oyvwtyGfZ1pBUzND2BcYBhmz+Z3dSPgl+9VVJbXMaBnHs8
	 YKfU9c9o+uSdY4lU7hcGFXFB4kVBX9CeF0e2KmYubagl6tOLWTAk7+6Tb/SOBrI3S9
	 zuRMeVv26rJDgwmQKMiv7T6rhmLDF/5Omgh6YSC5YFGpdRfa9cclNdZCqw2XhXFcJc
	 Wy7Lym7vP+qvlnbG373/1xIwIwFGUlJ0h5jpSE3cNRb2fkXv9T/LdJZzmA04iA2roo
	 +RGcyswZaJU8sJUi2uyr5vGRdEeYGpPwgFO2Zinmm4TUe8xG0sM2VXvce0mj5/SyR3
	 v84KN98U/Sdaw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EC184C433E1; Sat, 20 Dec 2025 05:00:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date: Sat, 20 Dec 2025 05:00:46 +0000
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
Message-ID: <bug-216936-62941-2HSaCFXaiX@https.bugzilla.kernel.org/>
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

--- Comment #29 from cheako+kernel_org@mikemestnik.net ---
I couldn't upload my other trace, was just 58k not 580k.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
