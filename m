Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E055258CE5
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914552; cv=none; b=gCts+mhXPUZohrxA2OiwXT2GkqxslqXDBpvC1eYHsHHMkcWTK3my0fJUPpkxNziQz/UZ5IdL4wDzjpKZbwRKwVo3dzZD9Q0ZO8E3lD0a4JAORjvtXV4QHdte0z2FBF4Q3dFAzJtqZbchGSWocNitSyN1NT4jPisM1NoikSIp+Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914552; c=relaxed/simple;
	bh=GAxRDW6675Z5pepLW03/TzkKXP/VCgNvHxNAmj1zU5w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fwbidOig2tpDCLa7BPSPG/SpJ+6dZ3huSbi6VQd80jnG1i8K0NhH3mZHBtPw45sCO+Wsd6C++8cuSU7svssI0Wo0Do9mSn+twFunnmLFg5QJCLolvYE9xYKf/rpEQo6Gw+oP1AvG7Ejm2uJAxmdWa1b8buUuvr2pJUdI5wiDVyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiWhD3P0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiWhD3P0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DC97C2BCC7
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 14:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782914552;
	bh=GAxRDW6675Z5pepLW03/TzkKXP/VCgNvHxNAmj1zU5w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oiWhD3P0AZRi5y7DzqOQnmAXBCtRnli2zuLC5egOZ72zcFm1sX3BwxWgDMcoUuve2
	 1lUrIFuvmatN7zUJUOir+cAlhxwg9Y5mMntn32ZJC0RW0+NmtdnWzhITQA7RGCBjaE
	 pr7g18IQkesPiYc1vWNBQmdey+6nOD6b+RULhvlRdA0w1rbeN5upbsPvs7c/p1pdLY
	 FuD/JmXeGDvbWsf+QSgDDVgEtGZ3iaTLVSIrhrFx5kEsN7zAbNv+na8ffaa8+niVoQ
	 wkIDQ8NtkopvYb2hm2f7UW8s1hh6qNmTzXCneIbIh5lITGgEzA6Ek4+4OUW2NcpShf
	 r5kKADKum61uw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5757EC3279F; Wed,  1 Jul 2026 14:02:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220564] hci0: ACL packet for unknown connection handle 3837 and
 sound interruption
Date: Wed, 01 Jul 2026 14:02:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.isobsolete
Message-ID: <bug-220564-62941-kiRKq6k1yh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220564-62941@https.bugzilla.kernel.org/>
References: <bug-220564-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220564

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #310408|0                           |1
        is obsolete|                            |

--- Comment #11 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de=
) ---
Comment on attachment 310408
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310408
Output of `about:support` (Debian=E2=80=99s Firefox 152.0.4) (Copy text to =
clipboard)

Sorry, wrong tab. :(

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
