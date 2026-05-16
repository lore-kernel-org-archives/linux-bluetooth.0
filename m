Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ABA256C8B
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778917721; cv=none; b=sv7YAav8Xyq4YSUNiRtxTJB8X90Hi3TfkcQ2HlKVETrMKQcjcKndCMaX7AtoSFZYqRdev9m12Ufr3j1dT2TOSUPcYDruYouLWzt5iNrfzycuZI9mhDoAPJwOp3iZ1sW+gWWtOayZk9UN88RYh9jHP/CWqzxNpx5hwP8+ZH3l+RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778917721; c=relaxed/simple;
	bh=nlrdSo6kuSAIMcOGeF9nT+xva9ytXtqNHvDIsKq8dT8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N1sI5c7cfk5ZJXE3f28Kizkbp3WZ1TQwph1qY3ymYyqpLtAaJcAjDHDG3DGc/hleQNH3ocA+F1fdpMJxiaZNWq5WgQWeqyJStGFIylKCaVRI37762+jTpME6QvJvMnRUYJwCL9j6yfzEca0WnNtQEyb2Ugux4jYqepbHP3P6stk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIud6xuV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIud6xuV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79DC4C2BCB8
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 07:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778917721;
	bh=nlrdSo6kuSAIMcOGeF9nT+xva9ytXtqNHvDIsKq8dT8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oIud6xuVir+yXkUs+vxcqiamwpdkQfL10tc5f2mUQ8znMBmeppyywsMoaHx663qGa
	 u9QkS3CliUtM0Kl442iEgETXsh9TXwkyWKCSQ4CNmKZXlRH1PtrTBqs9dLffYnVIa2
	 TPc+ZYfmhzH1rDoOCyITrzrGXRn/sGqyY6mZjZgrBya8LXJrxssAvOvGSXhM2+Llj7
	 bOHjMHVUUKDRhz/oTOVv12PZDOQ+cc76pjKMKX9hLRvGesDUqp0CA9bqa+Pb972ECw
	 WkXbCFSLzw+/3OAW0WOCxUanAC9c0I3vrLtqjShpgi193Zn4jItjPuBexD8zj6rb/D
	 ICcPRIVTHAf0Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 70351C53BBF; Sat, 16 May 2026 07:48:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
 (-22) on MediaTek MT7921 combo adapter
Date: Sat, 16 May 2026 07:48:41 +0000
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
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221521-62941-rvXKqflxu5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221521-62941@https.bugzilla.kernel.org/>
References: <bug-221521-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221521

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |autofire372@gmail.com

--- Comment #8 from Artem S. Tashkinov (aros@gmx.com) ---
*** Bug 221529 has been marked as a duplicate of this bug. ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
