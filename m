Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA2D816
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Apr 2024 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712386495; cv=none; b=lIMX50Lub4QIAPEmeZ/Q29lshZclp5STvdClhg5GqRpe65yw/A/jWnvpgoj9WHr8Kq+EWtp84gR3zirT0c8AcY3IwKFWvTXYZ/tud0OVYid1T+v/3E0XlxtFS+UKUltujsEFcP/keA/jfcvcDq2wdBI1QPxqJS6Aycsn5bCC9Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712386495; c=relaxed/simple;
	bh=eMaVEwpK+tZ4RooFaOFqEam93VSxyv8xm6fmh7bpb8c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TSGO5rQPRlidmE6EqHPprKSAT3b0OcOD+6BYbHfIUEFtxP3uejvC8ht+uDvGMMtR7GA8jp5wcHQrlcEzP30MiNKpjg0gb1kn/glNSjhfVBzjFfDtf5tFtYf6MIbN6SrzB6nr+JS2MVuow50U8DW9R+8fQr6ZXSg0dXo3Ckbv/EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blkAhRsh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blkAhRsh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 138AEC43601
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Apr 2024 06:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712386495;
	bh=eMaVEwpK+tZ4RooFaOFqEam93VSxyv8xm6fmh7bpb8c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=blkAhRsh7IMUWBLpLITCS0z6aT0gSt0Gc7w7ulH6jTDY9nHgoivJ1ugyFsomaGNZo
	 5COQ87ewGS3p5kMwxyuVeJAmZY/lg1xMFtKWWqnpR0wCM9Pkgv5UZb2ZA6SDTJduRI
	 VD5zfTnVtVtNjjbBnZKvvwFz6B471GMFPs/VKmYngufqLs4WgEbkOgDZfakL4jKi2r
	 uGCxRvh2Gw7uEH6WDopdlgsEmh/JAfAdNKCZzd3v/raBuaGENqTaGAX+j1ys9gBnGm
	 az8W5XehkqoTP+6Gen/7Klv5GmK7nxKvdkuzPlJB3wc9IpyMVbdZ9GtBtd7hPuDdGa
	 58ElthW1PCnpQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0D81EC53BD6; Sat,  6 Apr 2024 06:54:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Sat, 06 Apr 2024 06:54:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: jb.1234abcd@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218651-62941-cUsBSgG526@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218651-62941@https.bugzilla.kernel.org/>
References: <bug-218651-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218651

jb (jb.1234abcd@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #26 from jb (jb.1234abcd@gmail.com) ---
Closed. Fixed in stable 6.8.3.
commit b0a3738c0b3bcb5760ff4db1f22b9b0e1725d1d2

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
