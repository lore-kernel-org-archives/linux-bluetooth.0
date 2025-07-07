Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A083C2F
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 04:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751863808; cv=none; b=fg5nANRraHD+x4LUQQmvrAB0SInWEl1Oon4JpCScpwJ6te/lzUJxe6elVaBiyS7rMxC6uEd2sCdd6IPr3TOsPQH7vWekliaLHCDplLHcWPvK6BZD+f4Jg8WTTyxGbbLvjlRlnUoMpJOcnIdKhEySe8oV1Gi9OmePyIRen9/wUb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751863808; c=relaxed/simple;
	bh=oYiV1GQ6/s4qFT9qwKH0GGZe6EKHi41ok7X0R41aR3E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sDGsHoa8F2bOjMnKDqrcPiuFLc8z1nsHd08DFUy9vs0xEbOzl/eZWpr1xD14RAC0SUkG0ptT4SVH7gN+SC6jOnsMQgkCh/GbYpS+KUHi5bL2fccaa+zTFR2OAyxaDTsBQxMtmQMWmho6t9XAHt4etG4o0ryCalwqQoRynoCWL38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROFPCqdD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROFPCqdD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2361EC4CEEE
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 04:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751863808;
	bh=oYiV1GQ6/s4qFT9qwKH0GGZe6EKHi41ok7X0R41aR3E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ROFPCqdDNf6m+faJ6LI1ZL2c7P8rTzlKL2KQo21O+Trpf8VGa9hlLKNJhUwoQoUgb
	 tG8vrydTknMrCU+9i5ddYXWXBThAeTQgxkjHaXzk7N4zY7oJgVavVoQPKBupaibchb
	 5JCcDvPHwonI9TqESLxIyg0Neu3NKJBegXnOj8TGpE9kvV8vubcL9JpEXIqvMPZahD
	 Dt5CY9X6NJ/e8ikbATo1oJU9jk4Q++WcaORkvDTVQxt1lzLeZBIoxScLvWOq40IAEw
	 Vj/pyg+lkldhitneOiPGsmjd41hOx+1BjqCXjEZWPQctuXZg5YMlJAQ/PP/CiA0GrP
	 ujjB2GoMT3irA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 179B1C41613; Mon,  7 Jul 2025 04:50:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220306] Updated ibt-18-16-1.sfi is bugged, "Invalid exception
 type 03" kernel spam
Date: Mon, 07 Jul 2025 04:50:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aluvala.sai.teja@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220306-62941-PIgWinZY1I@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220306-62941@https.bugzilla.kernel.org/>
References: <bug-220306-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220306

Sai Teja Aluvala (aluvala.sai.teja@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |aluvala.sai.teja@intel.com

--- Comment #8 from Sai Teja Aluvala (aluvala.sai.teja@intel.com) ---
Reverted firmware is merged in upstream.
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git=
/commit/?id=3Df534fd76aaa8019b4106f7fad363f52ec40adca4

Regards,
Sai Teja.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
