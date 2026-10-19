Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2E04973AF
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399511; cv=none; b=uZSRXebRqaylkyhlKVqozxTW543PaO9QxxJoTQTe/9pkL3UMfKPDAD5GEFmJvC4a9XAwCdmulE4zm/r52gF52LVCQCbOofViQNVBG08bfbpzM4928jJnZVsIxDO450MO9QsOG3zUudaMFqDDKn8zCBftVemUlQmXwEcbmUnfhoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399511; c=relaxed/simple;
	bh=q+PqqH48M4P+GK/GRd2J2eW3+Vcl4AhH27r7IBO69f4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mIb/UFq/sDEibnCH7xvYvsUanTL2SaUImORQuEaXCbCSrwF7grXmcKyeZXHoBzCDSSZ77Se9V3Df9gJmlT1xyohkM+uZpRjCNUJJ38aQKK+ak2Mm+oMYtSrj0xpgU+pa1E9112f73irjI7YHaiiEYAgRpc0drlwQAdnSUl3cRLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgbVqOZz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgbVqOZz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDB3EC2BCFC
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 08:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792399510;
	bh=q+PqqH48M4P+GK/GRd2J2eW3+Vcl4AhH27r7IBO69f4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mgbVqOZzlpmd4PFNJUCi4trQyPTiyL6ukC+3od+sQUyWVys4T7G6Lb3/caZjIFII0
	 AhYEaJp8A5H+Sk1WW/OjigBBEugVnhyyTZFG+JlnykqeqosBf0NYA9U+gwhF+JBA5K
	 kKn0VDWXDu8vv7c2Pj/LGWUfIR5goBfv7+uCr+8H5nR3K+kulQJkdc+6bjx5Zl5k5F
	 mGGubJa/1IO1czBsqfpVhXk17viLefzL9qn9DQiupWTF7xJTKSdJDOnlfzhr4bvNUl
	 fickYMXRCDhbPCL9BTGiOPGu6mmHLMUbylNJFg+DWD5w9czXqx/M97PtuVBbItddaY
	 9zSARleFmb/Tg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9F7D4C53BC7; Mon, 19 Oct 2026 08:45:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221754] RTL8852BE Bluetooth (0bda:b853) fails to init: Opcode
 0xfcf0 failed: -16, hci0 never registers with mgmt (BD Address
 00:00:00:00:00:00)
Date: Mon, 19 Oct 2026 08:45:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: virtualfoxyloon@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221754-62941-GxHZ9iytS2@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221754-62941@https.bugzilla.kernel.org/>
References: <bug-221754-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221754

--- Comment #12 from FoxyLoon (virtualfoxyloon@gmail.com) ---
Hey Martinho P. (in response to Comment #11)

A few days after posting my previous message, I went through the discussion
history on this page again and noticed a link to a drive that another user =
had
shared for their computer model. I tried it out of curiosity, but I forgot =
to
come back to this discussion and report what happened afterwards.

I decided to give it a try because the GitHub repository containing the fix
stated that, in theory, any drive related to the hardware in question should
work.

After running the script again, it successfully detected the `.dat` file and
installed the firmware. As a result, Bluetooth is now working on my system.

However, it is only partially functional. Bluetooth can now be enabled and
disabled, and I can connect devices, but establishing a stable connection c=
an
sometimes take up to five minutes or more.

For example, when I try to connect my headphones, the following happens:

- I enable Bluetooth.
- I turn on my headphones.
- A connection is established, but no audio comes through the headphones ye=
t...
- A few seconds later, the Bluetooth connection drops, even though Bluetooth
itself is still enabled.
- I try to reconnect the headphones, but the same thing happens again.
- Sometimes in this process, the headphones volume slider appears in the KDE
Plasma volume control, but audio still does not play through them, and if t=
he
Bluetooth disconnects again, the slider ends up disappearing as well.
- After a few seconds, the connection drops again.
- This cycle continues until the headphones finally connect successfully and
start playing audio. Once that happens, the connection remains stable and
everything works as expected until I manually disconnect the headphones or =
shut
down / suspend the computer.

However, if I manually turn off the headphones, the same bug MAY occur the =
next
time I try to turn them on, repeating what I described above.

The behaviour is quite inconsistent. Sometimes the headphones connect
immediately and work without any problems. On other occasions, I have to wa=
it
several minutes for a successful connection because the connection repeated=
ly
drops and reconnects. The number of failed attempts also varies: for exampl=
e,
the connection may drop and reconnect anywhere from 2 to ~10 times before it
finally works.

So, this bug appears to be partially resolved for me with the drive provided
above. Bluetooth is now functional, but establishing a connection can still=
 be
unreliable, and sometimes I have to be patient and try several times before
everything works properly.

I'm not entirely sure what additional information would be useful to help
diagnose this bug, but I've tried to describe the behaviour as accurately as
possible.

Take care!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
